/******************************************************************************
 * GPS HAL shim
 * load older GPS libraries on gingerbread (and above?)
 *
 * Copyright 2010 - Ricardo Cerqueira
******************************************************************************/

#include <hardware/gps.h>

#include <stdlib.h>
#define LOG_TAG "gps-shim"
#include <utils/Log.h>



/** Represents the older GPS interfaces. */

typedef struct {
    int  (*init)( GpsXtraCallbacks* callbacks );
    int  (*inject_xtra_data)( char* data, int length );
} OldGpsXtraInterface;

typedef struct {
    void  (*init)( AGpsCallbacks* callbacks );
    int  (*data_conn_open)( const char* apn );
    int  (*data_conn_closed)();
    int  (*data_conn_failed)();
    int  (*set_server)( AGpsType type, const char* hostname, int port );
} OldAGpsInterface;


typedef struct
{
   void (*init) (GpsNiCallbacks *callbacks);
   void (*respond) (int notif_id, GpsUserResponseType user_response);
} OldGpsNiInterface;

typedef struct {
    uint16_t        flags;
    double          latitude;
    double          longitude;
    double          altitude;
    float           speed;
    float           bearing;
    float           accuracy;
    GpsUtcTime      timestamp;
} OldGpsLocation;

typedef struct {
    GpsStatusValue status;
} OldGpsStatus;

typedef struct {
    int     prn;
    float   snr;
    float   elevation;
    float   azimuth;
} OldGpsSvInfo;

typedef struct {
        int         num_svs;
        OldGpsSvInfo   sv_list[GPS_MAX_SVS];
        uint32_t    ephemeris_mask;
        uint32_t    almanac_mask;
        uint32_t    used_in_fix_mask;
} OldGpsSvStatus;


typedef void (* old_gps_location_callback)(OldGpsLocation* location);
typedef void (* old_gps_status_callback)(OldGpsStatus* status);
typedef void (* old_gps_sv_status_callback)(OldGpsSvStatus* sv_info);

typedef struct {
        old_gps_location_callback location_cb;
        old_gps_status_callback status_cb;
        old_gps_sv_status_callback sv_status_cb;
        gps_nmea_callback nmea_cb;
} OldGpsCallbacks;

GpsCallbacks *originalCallbacks;

typedef struct {
    int   (*init)( OldGpsCallbacks* callbacks );
    int   (*start)( void );
    int   (*stop)( void );
    void  (*cleanup)( void );
    int   (*inject_time)(GpsUtcTime time, int64_t timeReference,
                         int uncertainty);
    int  (*inject_location)(double latitude, double longitude, float accuracy);
    void  (*delete_aiding_data)(GpsAidingData flags);
    int   (*set_position_mode)(GpsPositionMode mode, int fix_frequency);
    const void* (*get_extension)(const char* name);
} OldGpsInterface;


static const OldGpsXtraInterface* oldXTRA = NULL;
static GpsXtraInterface newXTRA;
static const OldAGpsInterface* oldAGPS = NULL;
static AGpsInterface newAGPS;
static const OldGpsNiInterface* oldNI = NULL;
static GpsNiInterface newNI;

static const OldGpsInterface* originalGpsInterface = NULL;
static GpsInterface newGpsInterface;

extern const OldGpsInterface* gps_get_hardware_interface();


static void location_callback_wrapper(OldGpsLocation *location) {
	static GpsLocation newLocation;
	LOGV("I have a location");
    newLocation.size = sizeof(GpsLocation);
    newLocation.flags = location->flags;
    newLocation.latitude = location->latitude;
    newLocation.longitude = location->longitude;
    newLocation.altitude = location->altitude;
    newLocation.speed = location->speed;
    newLocation.bearing = location->bearing;
    newLocation.accuracy = location->accuracy;
    newLocation.timestamp = location->timestamp;
	originalCallbacks->create_thread_cb("gpsshim-location",(void *)originalCallbacks->location_cb,(void *)&newLocation);
}

static GpsStatus newStatus;
static void status_callback_wrapper(OldGpsStatus *status) {
    newStatus.size = sizeof(GpsStatus);
	LOGV("Status value is %u",status->status);
    newStatus.status = status->status;
	originalCallbacks->create_thread_cb("gpsshim-status",(void *)originalCallbacks->status_cb,(void *)&newStatus);
}

static GpsSvStatus newSvStatus;
static void svstatus_callback_wrapper(OldGpsSvStatus *sv_info) {
	int i=0;
	LOGV("I have a svstatus");
    newSvStatus.size = sizeof(GpsSvStatus);
    newSvStatus.num_svs = sv_info->num_svs;
	for (i=0; i<newSvStatus.num_svs; i++) {
		newSvStatus.sv_list[i].size = sizeof(GpsSvInfo);
		newSvStatus.sv_list[i].prn = sv_info->sv_list[i].prn;
		newSvStatus.sv_list[i].snr = sv_info->sv_list[i].snr;
		newSvStatus.sv_list[i].elevation = sv_info->sv_list[i].elevation;
		newSvStatus.sv_list[i].azimuth = sv_info->sv_list[i].azimuth;
	}
    newSvStatus.ephemeris_mask = sv_info->ephemeris_mask;
    newSvStatus.almanac_mask = sv_info->almanac_mask;
    newSvStatus.used_in_fix_mask = sv_info->used_in_fix_mask;
	originalCallbacks->create_thread_cb("gpsshim-svstatus",(void *)originalCallbacks->sv_status_cb,(void *)&newSvStatus);
}

static void nmea_callback_wrapper(GpsUtcTime timestamp, const char* nmea, int length) {
	// Sink it for now. Needs to run in a thread_cb
	// originalCallbacks->nmea_cb(timestamp, nmea, length);
}

static const void* wrapper_get_extension(const char* name)
{
	// Need to overload the inits to make the callbacks run in
	// a thread_cb...
	return NULL;
    if (strcmp(name, GPS_XTRA_INTERFACE) == 0)
    {
		oldXTRA = originalGpsInterface->get_extension(name);
		newXTRA.size = sizeof(GpsXtraInterface);
		newXTRA.init = oldXTRA->init;
		newXTRA.inject_xtra_data = oldXTRA->inject_xtra_data;
        return &newXTRA;
    }
    else if (strcmp(name, AGPS_INTERFACE) == 0)
    {
		oldAGPS = originalGpsInterface->get_extension(name);
		newAGPS.size = sizeof(AGpsInterface);
		newAGPS.init = oldAGPS->init;
		newAGPS.data_conn_open = oldAGPS->data_conn_open;
		newAGPS.data_conn_closed = oldAGPS->data_conn_closed;
		newAGPS.data_conn_failed = oldAGPS->data_conn_failed;
		newAGPS.set_server = oldAGPS->set_server;
        return &newAGPS;
    }
    else if (strcmp(name, GPS_NI_INTERFACE) == 0)
    {
		oldNI = originalGpsInterface->get_extension(name);
		newNI.size = sizeof(GpsNiInterface);
		newNI.init = oldNI->init;
		newNI.respond = oldNI->respond;
        return &newNI;
    }

    return NULL;
}

static OldGpsCallbacks oldCallbacks;
static int  init_wrapper(GpsCallbacks* callbacks) {
	originalCallbacks = callbacks;
	oldCallbacks.location_cb = location_callback_wrapper;
	oldCallbacks.status_cb = status_callback_wrapper;
	oldCallbacks.sv_status_cb = svstatus_callback_wrapper;
	oldCallbacks.nmea_cb = nmea_callback_wrapper;
	originalCallbacks->set_capabilities_cb(0);
	return originalGpsInterface->init(&oldCallbacks);
}

static int set_position_mode_wrapper(GpsPositionMode mode, GpsPositionRecurrence recurrence,  uint32_t min_interval, uint32_t preferred_accuracy, uint32_t preferred_time) {
	return originalGpsInterface->set_position_mode(0, recurrence ? 0 : (min_interval/1000));
}

const GpsInterface* gps__get_gps_interface(struct gps_device_t* dev)
{
	originalGpsInterface = gps_get_hardware_interface();

	newGpsInterface.size = sizeof(GpsInterface);
	newGpsInterface.init = init_wrapper;
	newGpsInterface.start = originalGpsInterface->start;
	newGpsInterface.stop = originalGpsInterface->stop;
	newGpsInterface.cleanup = originalGpsInterface->cleanup;
	newGpsInterface.inject_time = originalGpsInterface->inject_time;
	newGpsInterface.inject_location = originalGpsInterface->inject_location;
	newGpsInterface.delete_aiding_data = originalGpsInterface->delete_aiding_data;
	newGpsInterface.set_position_mode = set_position_mode_wrapper;
	newGpsInterface.get_extension = wrapper_get_extension;


    return &newGpsInterface;
}

static int open_gps(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    struct gps_device_t *dev = malloc(sizeof(struct gps_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->get_gps_interface = gps__get_gps_interface;

    *device = (struct hw_device_t*)dev;
    return 0;
}

static struct hw_module_methods_t gps_module_methods = {
    .open = open_gps
};

const struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = GPS_HARDWARE_MODULE_ID,
    .name = "GPS HAL Wrapper Module",
    .author = "Ricardo Cerqueira",
    .methods = &gps_module_methods,
};
