From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:05 +0300
Subject: [PATCH 01/11] nvme-loop: get rid of unused controller lock
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-2-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 304f1c87c160..84ae300d6498 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -45,7 +45,6 @@ struct nvme_loop_iod {
 };
 
 struct nvme_loop_ctrl {
-	spinlock_t		lock;
 	struct nvme_loop_queue	*queues;
 	u32			queue_count;
 
@@ -635,8 +634,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_put_ctrl;
 
-	spin_lock_init(&ctrl->lock);
-
 	ret = -ENOMEM;
 
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.7.4
