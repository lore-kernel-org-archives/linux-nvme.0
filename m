From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 27 May 2019 01:29:02 +0900
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).

This provides these temperatures via thermal zone devices.

Once the controller is identified, the thermal zone devices are created for
all implemented temperature sensors including the composite temperature.

/sys/class/thermal/thermal_zone[0-*]:
    |---type: 'nvme<instance>-temp<sensor>'
    |---temp: Temperature
    |---trip_point_0_temp: Over temperature threshold

The thermal_zone[0-*] contains a 'device' symlink to the corresponding nvme
device.

On the other hand, the following symlinks to the thermal zone devices are
created in the nvme device sysfs directory.

- temp0: Composite temperature
- temp1: Temperature sensor 1
...
- temp8: Temperature sensor 8

Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v3
- Change the type name of thermal zone devices from 'nvme_temp<sensor>' to
  'nvme<instance>_temp<sensor>'
- Pass a NULL to the status argument of nvme_set_feature()
- Change the name of symbolic link from 'nvme_temp<sensor>' to 'temp<sensor>'
- Don't make it fatal error if the device provides a response
- Don't register thermal zone for composite temperature if smart log reports
  zero value
- Move the thermal zones registration and unregistration into the core module.

 drivers/nvme/host/core.c | 288 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   9 ++
 include/linux/nvme.h     |   5 +
 3 files changed, 302 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c950916..4c8271a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2200,6 +2200,289 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	}
 }
 
+#ifdef CONFIG_THERMAL
+
+static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, int *temp)
+{
+	struct nvme_smart_log *log;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=
+		     ARRAY_SIZE(ctrl->tzdev));
+
+	if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
+		return -EINVAL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return -ENOMEM;
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			   log, sizeof(*log), 0);
+	if (ret) {
+		ret = ret > 0 ? -EINVAL : ret;
+		goto free_log;
+	}
+
+	if (sensor)
+		*temp = le16_to_cpu(log->temp_sensor[sensor - 1]);
+	else
+		*temp = get_unaligned_le16(log->temperature);
+
+free_log:
+	kfree(log);
+
+	return ret;
+}
+
+static unsigned int nvme_tz_type_to_sensor(const char *type)
+{
+	int instance;
+	unsigned int sensor;
+
+	if (sscanf(type, "nvme%d_temp%u", &instance, &sensor) != 2)
+		return UINT_MAX;
+
+	return sensor;
+}
+
+#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
+#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
+
+static int nvme_tz_get_temp(struct thermal_zone_device *tzdev, int *temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+	int ret;
+
+	ret = nvme_get_temp(ctrl, sensor, temp);
+	if (!ret)
+		*temp = KELVIN_TO_MILLICELSIUS(*temp);
+
+	return ret;
+}
+
+static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,
+				 int trip, enum thermal_trip_type *type)
+{
+	*type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
+
+static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl,
+				     unsigned int sensor, int *temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int status;
+	int ret;
+
+	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
+		return -EINVAL;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+	if (!ret)
+		*temp = status & NVME_TEMP_THRESH_MASK;
+
+	return ret > 0 ? -EINVAL : ret;
+}
+
+static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
+				     unsigned int sensor, int temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int ret;
+
+	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
+		return -EINVAL;
+
+	if (temp > NVME_TEMP_THRESH_MASK)
+		return -EINVAL;
+
+	threshold |= temp & NVME_TEMP_THRESH_MASK;
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				NULL);
+
+	return ret > 0 ? -EINVAL : ret;
+}
+
+static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
+				 int trip, int *temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+	int ret;
+
+	ret = nvme_get_over_temp_thresh(ctrl, sensor, temp);
+	if (!ret)
+		*temp = KELVIN_TO_MILLICELSIUS(*temp);
+
+	return ret;
+}
+
+static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,
+				 int trip, int temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+
+	temp = MILLICELSIUS_TO_KELVIN(temp);
+
+	return nvme_set_over_temp_thresh(ctrl, sensor, temp);
+}
+
+static struct thermal_zone_device_ops nvme_tz_ops = {
+	.get_temp = nvme_tz_get_temp,
+	.get_trip_type = nvme_tz_get_trip_type,
+	.get_trip_temp = nvme_tz_get_trip_temp,
+	.set_trip_temp = nvme_tz_set_trip_temp,
+};
+
+static struct thermal_zone_params nvme_tz_params = {
+	.governor_name = "user_space",
+	.no_hwmon = true,
+};
+
+static struct thermal_zone_device *
+nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
+{
+	struct thermal_zone_device *tzdev;
+	char name[THERMAL_NAME_LENGTH];
+	int ret;
+
+	snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
+
+	tzdev = thermal_zone_device_register(name, 1, 1, ctrl, &nvme_tz_ops,
+					     &nvme_tz_params, 0, 0);
+	if (IS_ERR(tzdev)) {
+		dev_err(ctrl->device,
+			"Failed to register thermal zone device: %ld\n",
+			PTR_ERR(tzdev));
+		return tzdev;
+	}
+
+	snprintf(name, sizeof(name), "temp%d", sensor);
+	ret = sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->device.kobj,
+				name);
+	if (ret)
+		goto device_unregister;
+
+	ret = sysfs_create_link(&tzdev->device.kobj,
+				&ctrl->ctrl_device.kobj, "device");
+	if (ret)
+		goto remove_link;
+
+	return tzdev;
+
+remove_link:
+	sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
+device_unregister:
+	thermal_zone_device_unregister(tzdev);
+
+	return ERR_PTR(ret);
+}
+
+/**
+ * nvme_thermal_zones_register() - register nvme thermal zone devices
+ * @ctrl: controller instance
+ *
+ * This function creates up to nine thermal zone devices for all implemented
+ * temperature sensors including the composite temperature.
+ * Each thermal zone device provides a single trip point temperature that is
+ * associated with an over temperature threshold.
+ */
+static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
+{
+	struct nvme_smart_log *log;
+	int ret;
+	int i;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return 0; /* non-fatal error */
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			   log, sizeof(*log), 0);
+	if (ret) {
+		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
+		/* If the device provided a response, then it's non-fatal */
+		if (ret > 0)
+			ret = 0;
+		goto free_log;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
+		struct thermal_zone_device *tzdev;
+		int temp;
+
+		if (i)
+			temp = le16_to_cpu(log->temp_sensor[i - 1]);
+		else
+			temp = get_unaligned_le16(log->temperature);
+
+		/*
+		 * All implemented temperature sensors report a non-zero value
+		 * in temperature sensor fields in the smart log page.
+		 */
+		if (!temp)
+			continue;
+		if (ctrl->tzdev[i])
+			continue;
+
+		tzdev = nvme_thermal_zone_register(ctrl, i);
+		if (!IS_ERR(tzdev))
+			ctrl->tzdev[i] = tzdev;
+	}
+
+free_log:
+	kfree(log);
+
+	return ret;
+}
+
+/**
+ * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
+ * @ctrl: controller instance
+ *
+ * This function removes the registered thermal zone devices and symlinks.
+ */
+static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
+		struct thermal_zone_device *tzdev = ctrl->tzdev[i];
+		char name[20];
+
+		if (!tzdev)
+			continue;
+
+		sysfs_remove_link(&tzdev->device.kobj, "device");
+
+		snprintf(name, sizeof(name), "temp%d", i);
+		sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
+
+		thermal_zone_device_unregister(tzdev);
+
+		ctrl->tzdev[i] = NULL;
+	}
+}
+
+#else
+
+static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
+{
+	return 0;
+}
+
+static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
+{
+}
+
+#endif /* CONFIG_THERMAL */
+
 struct nvme_core_quirk_entry {
 	/*
 	 * NVMe model and firmware strings are padded with spaces.  For
@@ -2754,6 +3037,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	ret = nvme_thermal_zones_register(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ctrl->identified = true;
 
 	return 0;
@@ -3756,6 +4043,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
+	nvme_thermal_zones_unregister(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 802aa19..53f0b24 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -15,6 +15,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/thermal.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -248,6 +249,14 @@ struct nvme_ctrl {
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
+
+#ifdef CONFIG_THERMAL
+	/*
+	 * tzdev[0]: composite temperature
+	 * tzdev[1-8]: temperature sensor 1 through 8
+	 */
+	struct thermal_zone_device *tzdev[9];
+#endif
 };
 
 enum nvme_iopolicy {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 658ac75..54f0a13 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -780,6 +780,11 @@ struct nvme_write_zeroes_cmd {
 
 /* Features */
 
+enum {
+	NVME_TEMP_THRESH_MASK		= 0xffff,
+	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
+};
+
 struct nvme_feat_auto_pst {
 	__le64 entries[32];
 };
-- 
2.7.4
