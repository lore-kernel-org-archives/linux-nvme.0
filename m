From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 18 Oct 2017 12:38:24 +0000
Subject: [PATCH 1/3] nvme-rdma: Add BLK_MQ_F_NO_SCHED flag to admin tag set
In-Reply-To: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
References: <1508330306-26844-1-git-send-email-israelr@mellanox.com>
Message-ID: <1508330306-26844-2-git-send-email-israelr@mellanox.com>

Since commit b86dd81
"block: get rid of blk-mq default scheduler choice Kconfig entries",
when setting nr_hw_queues to 1 the admin tag set uses mq-deadline scheduler.
This flag is useful for admin queues that aren't used for normal IO.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff..ee61b98f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -699,6 +699,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
+		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
-- 
1.8.3.1
