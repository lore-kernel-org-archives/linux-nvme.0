From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed,  8 Nov 2017 10:59:04 +0100
Subject: [PATCH v2] nvme: fix eui_show() print format
In-Reply-To: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>
References: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1510135144-1557-2-git-send-email-javier@cnexlabs.com>

From: Javier Gonz?lez <jg@lightnvm.io>

Fix print formatting, but keep the original output to prevent user
breakage as suggested by Joe Perches.

Change since v1:
  - Maintain the original output format printing spaces instead of dashes

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3bc9fb39a6c..6c9d313c6f90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2109,7 +2109,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8ph\n", ns->eui);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
-- 
2.7.4
