From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Fri,  3 Nov 2017 11:02:50 +0100
Subject: [PATCH 3/3] nvme: fix eui_show() print format
In-Reply-To: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1509703370-20379-4-git-send-email-javier@cnexlabs.com>

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae8ab0a1ef0d..f05c81774abf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8phD\n", ns->eui);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
-- 
2.7.4
