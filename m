From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:17:06 +0100
Subject: [PATCH 07/19] lightnvm: complete 2.0 values in sysfs
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519651038-16845-8-git-send-email-javier@cnexlabs.com>

Add missing geometry values to sysfs. Namely, maxoc and maxocpu.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a8f35e8b7953..4ea553c91756 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1066,6 +1066,10 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_min);
 	} else if (strcmp(attr->name, "ws_opt") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_opt);
+	} else if (strcmp(attr->name, "maxoc") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxoc);
+	} else if (strcmp(attr->name, "maxocpu") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxocpu);
 	} else if (strcmp(attr->name, "mw_cunits") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mw_cunits);
 	} else if (strcmp(attr->name, "write_typ") == 0) {
@@ -1163,6 +1167,8 @@ static NVM_DEV_ATTR_20_RO(chunks);
 static NVM_DEV_ATTR_20_RO(clba);
 static NVM_DEV_ATTR_20_RO(ws_min);
 static NVM_DEV_ATTR_20_RO(ws_opt);
+static NVM_DEV_ATTR_20_RO(maxoc);
+static NVM_DEV_ATTR_20_RO(maxocpu);
 static NVM_DEV_ATTR_20_RO(mw_cunits);
 static NVM_DEV_ATTR_20_RO(write_typ);
 static NVM_DEV_ATTR_20_RO(write_max);
@@ -1179,6 +1185,8 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_clba.attr,
 	&dev_attr_ws_min.attr,
 	&dev_attr_ws_opt.attr,
+	&dev_attr_maxoc.attr,
+	&dev_attr_maxocpu.attr,
 	&dev_attr_mw_cunits.attr,
 
 	&dev_attr_read_typ.attr,
-- 
2.7.4
