From: jsmart2021@gmail.com (James Smart)
Date: Wed, 20 Sep 2017 11:07:26 -0700
Subject: [PATCH] nvmet_fc: sync header templates with comments
Message-ID: <20170920180726.31764-1-jsmart2021@gmail.com>

Comments were incorrect:
- defer_rcv was in host port template. moved to target port template
- Added Mandatory statements for target port template items

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme-fc-driver.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 9c5cb4480806..a726f96010d5 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -346,11 +346,6 @@ struct nvme_fc_remote_port {
  *       indicating an FC transport Aborted status.
  *       Entrypoint is Mandatory.
  *
- * @defer_rcv:  Called by the transport to signal the LLLD that it has
- *       begun processing of a previously received NVME CMD IU. The LLDD
- *       is now free to re-use the rcv buffer associated with the
- *       nvmefc_tgt_fcp_req.
- *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -806,11 +801,19 @@ struct nvmet_fc_target_port {
  *       outstanding operation (if there was one) to complete, then will
  *       call the fcp_req_release() callback to return the command's
  *       exchange context back to the LLDD.
+ *       Entrypoint is Mandatory.
  *
  * @fcp_req_release:  Called by the transport to return a nvmefc_tgt_fcp_req
  *       to the LLDD after all operations on the fcp operation are complete.
  *       This may be due to the command completing or upon completion of
  *       abort cleanup.
+ *       Entrypoint is Mandatory.
+ *
+ * @defer_rcv:  Called by the transport to signal the LLLD that it has
+ *       begun processing of a previously received NVME CMD IU. The LLDD
+ *       is now free to re-use the rcv buffer associated with the
+ *       nvmefc_tgt_fcp_req.
+ *       Entrypoint is Optional.
  *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
-- 
2.13.1
