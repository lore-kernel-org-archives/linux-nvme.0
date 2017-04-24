From: emilne@redhat.com (Ewan D. Milne)
Date: Mon, 24 Apr 2017 13:24:16 -0400
Subject: [PATCH 1/1] nvme-fc: avoid memory corruption caused by calling
 nvmf_free_options() twice
In-Reply-To: <1493054656-18296-1-git-send-email-emilne@redhat.com>
References: <1493054656-18296-1-git-send-email-emilne@redhat.com>
Message-ID: <1493054656-18296-2-git-send-email-emilne@redhat.com>

From: "Ewan D. Milne" <emilne@redhat.com>

Do not call nvmf_free_options() from the nvme_fc_ctlr destructor if
nvme_fc_create_ctrl() returns an error, because nvmf_create_ctrl()
frees the options when an error is returned.

Signed-off-by: Ewan D. Milne <emilne at redhat.com>
---
 drivers/nvme/host/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 890e096..9da98ec 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1716,7 +1716,8 @@ enum {
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	nvmf_free_options(ctrl->ctrl.opts);
+	if (ctrl->ctrl.opts)
+		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
 
@@ -2821,6 +2822,7 @@ enum blk_eh_timer_return
 
 	ret = nvme_fc_create_association(ctrl);
 	if (ret) {
+		ctrl->ctrl.opts = NULL;
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
 		nvme_put_ctrl(&ctrl->ctrl);
-- 
1.8.3.1
