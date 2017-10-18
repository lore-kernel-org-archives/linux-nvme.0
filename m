From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:40 +0300
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508324864-23087-2-git-send-email-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

Its strange to have some of the cleanup for nvme_init_ctrl in
nvme_free_ctrl. This cause us to have some magic ctrl refcount
handling in controller initialization error paths.

Make the init/uninit symmetric so we can have a sane and
maintainable error sequences.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c95155696741..b8abd016202e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2749,11 +2749,14 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
-	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
-
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
+
+	ida_destroy(&ctrl->ns_ida);
+	put_device(ctrl->device);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
+	nvme_release_instance(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
@@ -2761,10 +2764,6 @@ static void nvme_free_ctrl(struct kref *kref)
 {
 	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
 
-	put_device(ctrl->device);
-	nvme_release_instance(ctrl);
-	ida_destroy(&ctrl->ns_ida);
-
 	ctrl->ops->free_ctrl(ctrl);
 }
 
-- 
2.7.4
