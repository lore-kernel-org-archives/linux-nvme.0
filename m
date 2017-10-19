From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 18:10:53 +0300
Subject: [PATCH v2 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
Message-ID: <1508425853-31998-1-git-send-email-sagi@grimberg.me>

We should make sure to escelate allocation failures to
prevent a use-after-free in nvmf_create_ctrl.

Fixes: b28a308ee777 ("nvme-rdma: move tagset allocation to
a dedicated routine")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Chnages from v1:
- fixed changelog

 drivers/nvme/host/rdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a5577e06a620..1f01744d859f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -766,8 +766,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	if (new) {
 		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-		if (IS_ERR(ctrl->ctrl.admin_tagset))
+		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
+			error = PTR_ERR(ctrl->ctrl.admin_tagset);
 			goto out_free_queue;
+		}
 
 		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
@@ -846,8 +848,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (new) {
 		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
-		if (IS_ERR(ctrl->ctrl.tagset))
+		if (IS_ERR(ctrl->ctrl.tagset)) {
+			ret = PTR_ERR(ctrl->ctrl.tagset);
 			goto out_free_io_queues;
+		}
 
 		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
 		if (IS_ERR(ctrl->ctrl.connect_q)) {
-- 
2.7.4
