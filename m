From: jsmart2021@gmail.com (James Smart)
Date: Thu, 11 Jan 2018 15:21:38 -0800
Subject: [PATCH] nvme_fc: correct hang in nvme_ns_remove()
Message-ID: <20180111232138.10669-1-jsmart2021@gmail.com>

When connectivity is lost to a device, the association is terminated
and the blk-mq queues are quiesced/stopped. When connectivity is
re-established, they are resumed.

If connectivity is lost for a sufficient amount of time that the
controller is then deleted, the delete path starts tearing down queues,
and eventually calling nvme_ns_remove(). It appears that pending
commands may cause blk_cleanup_queue() to never complete and the
teardown stalls.

Correct by starting the ns queues after transitioning to a DELETING
state, allowing pending commands to be flushed with io failures. Thus
the delete path is clear when reached.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fe98e994498c..99bf51c7e513 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2938,6 +2938,9 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+
+	/* resume the io queues so that things will fast fail */
+	nvme_start_queues(nctrl);
 }
 
 static void
-- 
2.13.1
