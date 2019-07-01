From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon,  1 Jul 2019 23:12:33 +0900
Subject: [PATCH v5 3/4] nvme: support DT thermal zone device
In-Reply-To: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1561990354-4084-4-git-send-email-akinobu.mita@gmail.com>

In addition to the standard thermal zone device, this adds support for
registering the DT thermal zone device.

If there is a device tree thermal zone node with the nvme temperature
sensor, the standard thermal zone device is not created.
Because we don't need two thermal zone devices for the same sensor.

Cc: Rob Herring <robh at kernel.org>
Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v5
- split the DT thermal zone support into separate patch
- don't register both standard and DT thermal zone

 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/thermal.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 49dd59ec..d501567 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -159,6 +159,7 @@ struct nvme_fault_inject {
 struct nvme_tz {
 	struct thermal_zone_params params;
 	struct thermal_zone_device *dev;
+	struct thermal_zone_device *of_dev;
 	unsigned int sensor;
 };
 
diff --git a/drivers/nvme/host/thermal.c b/drivers/nvme/host/thermal.c
index c3608f6..431aeb4 100644
--- a/drivers/nvme/host/thermal.c
+++ b/drivers/nvme/host/thermal.c
@@ -150,6 +150,11 @@ static struct thermal_zone_device_ops nvme_tz_ops = {
 	.set_trip_temp = nvme_tz_set_trip_temp,
 };
 
+static struct thermal_zone_of_device_ops nvme_tz_of_ops = {
+	.get_temp = nvme_tz_of_get_temp,
+	.set_trip_temp = nvme_tz_of_set_trip_temp,
+};
+
 static const struct thermal_zone_params nvme_tz_params = {
 	.governor_name = "user_space",
 	.no_hwmon = true,
@@ -164,6 +169,36 @@ static int nvme_thermal_zone_register(struct nvme_ctrl *ctrl,
 	int ret;
 
 	tz->sensor = sensor;
+
+	tzdev = thermal_zone_of_sensor_register(ctrl->dev, sensor, tz,
+						&nvme_tz_of_ops);
+	if (!IS_ERR(tzdev)) {
+		int trip_temp;
+
+		ret = tzdev->ops->get_trip_temp(tzdev, 0, &trip_temp);
+		if (ret) {
+			dev_err(ctrl->device,
+				"Failed to get trip temp: %d\n", ret);
+			return ret;
+		}
+
+		ret = tzdev->ops->set_trip_temp(tzdev, 0, trip_temp);
+		if (ret) {
+			dev_err(ctrl->device,
+				"Failed to set trip temp: %d\n", ret);
+			return ret;
+		}
+
+		tz->of_dev = tzdev;
+
+		return 0;
+	}
+
+	if (PTR_ERR(tzdev) != -ENODEV)
+		dev_warn(ctrl->device,
+			 "Failed to register thermal zone of sensor %d: %ld\n",
+			 sensor, PTR_ERR(tzdev));
+
 	tz->params = nvme_tz_params;
 	snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
 
@@ -286,6 +321,9 @@ void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
 			tz->dev = NULL;
 		}
 
+		thermal_zone_of_sensor_unregister(ctrl->dev, tz->of_dev);
+		tz->of_dev = NULL;
+
 		__clear_bit(i, ctrl->tz_enabled);
 	}
 }
-- 
2.7.4
