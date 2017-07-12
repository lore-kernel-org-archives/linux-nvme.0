From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 12 Jul 2017 15:38:56 +0200
Subject: [PATCH] nvme: also provide a UUID in the WWID sysfs attribute
Message-ID: <20170712133856.17211-1-jthumshirn@suse.de>

The WWID sysfs attribute can provide multiple means of a World Wide ID
for a NVMe device. It can either be a NGUID, a EUI-64 or a concatenation
of VID, Serial Number, Model and the Namespace ID in this order of
preference.

If the target also sends us a UUID use the UUID for identification and
give it the highest priority.

This eases generation of /dev/disk/by-* symlinks.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d70df1d0072d..c100e7db9b54 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1995,6 +1995,9 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
 
+	if (!uuid_is_null(&ns->uuid))
+		return sprintf(buf, "uuid.%pU\n", &ns->uuid);
+
 	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 		return sprintf(buf, "eui.%16phN\n", ns->nguid);
 
-- 
2.12.3
