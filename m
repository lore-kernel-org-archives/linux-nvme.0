From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 25 Jul 2017 21:28:26 +0800
Subject: [PATCH] nvme: wwid_show: show uuid first if existed
Message-ID: <1500989306-18460-1-git-send-email-guanjunxiong@huawei.com>

The NGUID/EUI64 is not universal unique because a controller may reuse a non-zero NGUID
or EUI64 value for a new namespace after the original namespace using the value has been
deleted. Therefore, UUID of a namescpace prevails over NGUID/EUI64 for showing wwid.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d70df1d..e609913 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1995,6 +1995,9 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
 
+	if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
+		return sprintf(buf, "uuid.%16phN\n", ns->uuid);
+
 	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 		return sprintf(buf, "eui.%16phN\n", ns->nguid);
 
-- 
2.6.4.windows.1
