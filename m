From: james.smart@broadcom.com (James Smart)
Date: Thu, 28 Jul 2016 17:00:25 -0700
Subject: [PATCH 1/3] nvme-fabrics: rework nvmf_get_address() for variable
 options
Message-ID: <579a9c99.RE/wCYn5/6zl6dPY%james.smart@broadcom.com>


Revise nvmf_get_address() string to account for not all options being
present.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index dc99676..2867b92 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -109,8 +109,16 @@ static void nvmf_host_put(struct nvmf_host *host)
  */
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 {
-	return snprintf(buf, size, "traddr=%s,trsvcid=%s\n",
-			ctrl->opts->traddr, ctrl->opts->trsvcid);
+	int len = 0;
+
+	if (ctrl->opts->mask & NVMF_OPT_TRADDR)
+		len += snprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
+	if (ctrl->opts->mask & NVMF_OPT_TRSVCID)
+		len += snprintf(buf + len, size - len, "%strsvcid=%s",
+				(len) ? "," : "", ctrl->opts->trsvcid);
+	len += snprintf(buf + len, size - len, "\n");
+
+	return len;
 }
 EXPORT_SYMBOL_GPL(nvmf_get_address);
 
-- 
2.5.0
