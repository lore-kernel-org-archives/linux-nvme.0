From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 12:34:07 -0800
Subject: [PATCH] nvme: fix kernel paging oops
Message-ID: <20181213203407.2374-1-sagi@grimberg.me>

free the controller discard_page correctly.

Fixes: cb5b7262b011 ("nvme: provide fallback for discard alloc failure")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4d8ee7186268..136512e8ba58 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3596,7 +3596,7 @@ static void nvme_free_ctrl(struct device *dev)
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
-	kfree(ctrl->discard_page);
+	__free_page(ctrl->discard_page);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
-- 
2.17.1
