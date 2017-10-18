From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:41 +0300
Subject: [PATCH 2/5] nvme-rdma: rework create_ctrl error flow
In-Reply-To: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508324864-23087-3-git-send-email-sagi@grimberg.me>

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
 drivers/nvme/host/rdma.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 605586b88186..866abee2374d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1875,11 +1875,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_free_ctrl;
-
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
@@ -1894,11 +1889,16 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+		goto out_free_ctrl;
+
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
+				0 /* no quirks, we're perfect! */);
+	if (ret)
+		goto out_free_queues;
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
-		goto out_kfree_queues;
+		goto out_uninit_ctrl;
 
 	/* sanity check icdoff */
 	if (ctrl->ctrl.icdoff) {
@@ -1954,16 +1954,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 out_remove_admin_queue:
 	nvme_rdma_destroy_admin_queue(ctrl, true);
-out_kfree_queues:
-	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
-	if (ret > 0)
-		ret = -EIO;
-	return ERR_PTR(ret);
+out_free_queues:
+	kfree(ctrl->queues);
 out_free_ctrl:
 	kfree(ctrl);
+	if (ret > 0)
+		ret = -EIO;
 	return ERR_PTR(ret);
 }
 
-- 
2.7.4
