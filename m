From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:43 +0300
Subject: [PATCH 4/5] nvme-loop: rework create_ctrl error flow
In-Reply-To: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508324864-23087-5-git-send-email-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

The magic ctrl refcount handling we have due to the asymmetric
behavior in nvme_init/uninit_ctrl is making the controller
creation error sequence a bit awkward and error prone as we
rely on magic refcounting to invoke ->free_ctrl from create_ctrl
error sequence.

Now that we have nvme_init/uninit_ctrl doing the right thing, we
can fix this by making the error sequence sane and simple (just
undo what we did until the error).

Also, allocate ctrl->queues before calling nvme_init_ctrl, just
to separate the driver private resource allocation and the core
resource allocations.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 92628c432926..cea6bab1e70c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -602,26 +602,24 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	INIT_WORK(&ctrl->delete_work, nvme_loop_del_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_loop_reset_ctrl_work);
-
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_put_ctrl;
-
-	ret = -ENOMEM;
-
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
+	ret = -ENOMEM;
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
 			GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+		goto out_free_ctrl;
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
+				0 /* no quirks, we're perfect! */);
 	if (ret)
 		goto out_free_queues;
 
+	ret = nvme_loop_configure_admin_queue(ctrl);
+	if (ret)
+		goto out_uninit_ctrl;
+
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
@@ -656,12 +654,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 out_remove_admin_queue:
 	nvme_loop_destroy_admin_queue(ctrl);
-out_free_queues:
-	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
-out_put_ctrl:
-	nvme_put_ctrl(&ctrl->ctrl);
+out_free_queues:
+	kfree(ctrl->queues);
+out_free_ctrl:
+	kfree(ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-- 
2.7.4
