From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 00:25:33 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <20170713222533.30794-1-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
Message-ID: <20170713222533.30794-4-mwilck@suse.com>

If the serial number is a series of hex digits (as usual for the
Linux target), there's no need to encode it in hex once more.
This will improve the readability of NVME wwids for users.

Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index deced6b91442d..c80e90603c9c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -27,6 +27,7 @@
 #include <linux/nvme_ioctl.h>
 #include <linux/t10-pi.h>
 #include <linux/pm_qos.h>
+#include <linux/ctype.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -1987,6 +1988,14 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static bool _is_hex_string(const char *buf, int len)
+{
+	const char *p;
+
+	for (p = buf; p < buf + len && isxdigit(*p); p++);
+	return p == buf + len;
+}
+
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -1994,6 +2003,7 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
+	char *p;
 
 	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 		return sprintf(buf, "eui.%16phN\n", ns->nguid);
@@ -2008,8 +2018,18 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	       ctrl->model[model_len - 1] == '\0')
 		model_len--;
 
-	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
-		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
+	p = buf + sprintf(buf, "nvme.%04x-", ctrl->vid);
+
+	if (_is_hex_string(ctrl->serial, serial_len)) {
+		memcpy(p, ctrl->serial, serial_len);
+		p += serial_len;
+		*p++ = '-';
+	} else
+		p += sprintf(p, "%*phN-", serial_len, ctrl->serial);
+
+	p += sprintf(p, "%*phN-%08x\n", model_len, ctrl->model, ns->ns_id);
+
+	return p - buf;
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
-- 
2.13.2
