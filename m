From: tal.shorer@gmail.com (Tal Shorer)
Date: Tue,  7 Aug 2018 23:42:39 +0300
Subject: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
Message-ID: <20180807204239.24907-1-tal.shorer@gmail.com>

When the user supplics ctrl_loss_tmo < 0, we warn them that this will
cause the fabrics layer to attempt reconnection forever.
However, in reality the fabrics layer never attempts to reconnect
because the condition to test whether we should reconnect is backwards
in this case.

Signed-off-by: Tal Shorer <tal.shorer at gmail.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f7efe5a58cc7..206d63cb1afc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->opts->max_reconnects != -1 &&
+	if (ctrl->opts->max_reconnects == -1 ||
 	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
 
-- 
2.14.1
