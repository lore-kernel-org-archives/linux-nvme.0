From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:44 -0700
Subject: [PATCH 06/16] nvme-fc: Fix kernel-doc headers
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-7-bvanassche@acm.org>

This patch avoids that the kernel-doc tool complains about several
multiple function headers when building with W=1.

Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/fc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9d201b35397d..d838987fffe1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -317,7 +317,7 @@ nvme_fc_attach_to_unreg_lport(struct nvme_fc_port_info *pinfo,
  * @template:  LLDD entrypoints and operational parameters for the port
  * @dev:       physical hardware device node port corresponds to. Will be
  *             used for DMA mappings
- * @lport_p:   pointer to a local port pointer. Upon success, the routine
+ * @portptr:   pointer to a local port pointer. Upon success, the routine
  *             will allocate a nvme_fc_local_port structure and place its
  *             address in the local port pointer. Upon failure, local port
  *             pointer will be set to 0.
@@ -425,8 +425,7 @@ EXPORT_SYMBOL_GPL(nvme_fc_register_localport);
  * nvme_fc_unregister_localport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
  *                              registered a NVME host FC port.
- * @localport: pointer to the (registered) local port that is to be
- *             deregistered.
+ * @portptr: pointer to the (registered) local port that is to be deregistered.
  *
  * Returns:
  * a completion status. Must be 0 upon success; a negative errno
@@ -632,7 +631,7 @@ __nvme_fc_set_dev_loss_tmo(struct nvme_fc_rport *rport,
  * @localport: pointer to the (registered) local port that the remote
  *             subsystem port is connected to.
  * @pinfo:     pointer to information about the port to be registered
- * @rport_p:   pointer to a remote port pointer. Upon success, the routine
+ * @portptr:   pointer to a remote port pointer. Upon success, the routine
  *             will allocate a nvme_fc_remote_port structure and place its
  *             address in the remote port pointer. Upon failure, remote port
  *             pointer will be set to 0.
@@ -809,8 +808,8 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
  * nvme_fc_unregister_remoteport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
  *                              registered a NVME subsystem FC port.
- * @remoteport: pointer to the (registered) remote port that is to be
- *              deregistered.
+ * @portptr: pointer to the (registered) remote port that is to be
+ *           deregistered.
  *
  * Returns:
  * a completion status. Must be 0 upon success; a negative errno
-- 
2.19.0.605.g01d371f741-goog
