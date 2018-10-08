From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:47 -0700
Subject: [PATCH 09/16] nvmet-fc: Fix kernel-doc headers
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-10-bvanassche@acm.org>

This patch avoids that the kernel-doc tool complains about two function
headers when building with W=1.

Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ef286b72d958..409081a03b24 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1245,8 +1245,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
  * nvme_fc_unregister_targetport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
  *                              registered a local NVME subsystem FC port.
- * @tgtport: pointer to the (registered) target port that is to be
- *           deregistered.
+ * @target_port: pointer to the (registered) target port that is to be
+ *               deregistered.
  *
  * Returns:
  * a completion status. Must be 0 upon success; a negative errno
@@ -1749,7 +1749,7 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * If this routine returns error, the LLDD should abort the exchange.
  *
- * @tgtport:    pointer to the (registered) target port the LS was
+ * @target_port: pointer to the (registered) target port the LS was
  *              received on.
  * @lsreq:      pointer to a lsreq request structure to be used to reference
  *              the exchange corresponding to the LS.
-- 
2.19.0.605.g01d371f741-goog
