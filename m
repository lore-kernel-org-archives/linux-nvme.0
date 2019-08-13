From: nishkadg.linux@gmail.com (Nishka Dasgupta)
Date: Tue, 13 Aug 2019 14:32:53 +0530
Subject: [PATCH] nvme-tcp: Make nvme_tcp_mq_ops constant
Message-ID: <20190813090253.8813-1-nishkadg.linux@gmail.com>

Static structure nvme_tcp_mq_ops, of type blk_mq_ops, is not used except
to be assigned to field ops of variable set. Variable set itself has
type blk_mq_tag_set, whose field ops is declared as const. Hence
nvme_tcp_mq_ops cannot be modified after being assigned to field ops of
variable set. Therefore declare nvme_tcp_mq_ops const as well.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux at gmail.com>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d35d16..a777cb157d70 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -117,7 +117,7 @@ struct nvme_tcp_ctrl {
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
-static struct blk_mq_ops nvme_tcp_mq_ops;
+static const struct blk_mq_ops nvme_tcp_mq_ops;
 static struct blk_mq_ops nvme_tcp_admin_mq_ops;
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
@@ -2159,7 +2159,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static struct blk_mq_ops nvme_tcp_mq_ops = {
+static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.complete	= nvme_complete_rq,
 	.init_request	= nvme_tcp_init_request,
-- 
2.19.1
