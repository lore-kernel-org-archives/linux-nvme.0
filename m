From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 18 Oct 2017 12:38:26 +0000
Subject: [PATCH 3/3] nvme-loop: Add BLK_MQ_F_NO_SCHED flag to admin tag set
In-Reply-To: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
Message-ID: <1508330306-26844-4-git-send-email-israelr@mellanox.com>

This flag is useful for admin queues that aren't used for normal IO.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 92628c4..c56354e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -365,6 +365,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ctrl->queues[0].ctrl = ctrl;
 	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
-- 
1.8.3.1
