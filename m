From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 10 Aug 2016 21:07:18 -0700
Subject: [PATCH RFC 4/4] nvme-loop: set sqsize to 0-based value, per spec
In-Reply-To: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470888438-823-5-git-send-email-james_p_freyensee@linux.intel.com>

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 94e7829..21ce0e8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -622,7 +622,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = -ENOMEM;
 
-	ctrl->ctrl.sqsize = opts->queue_size;
+	ctrl->ctrl.sqsize = opts->queue_size-1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
-- 
2.7.4
