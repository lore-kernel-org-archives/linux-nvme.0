From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Mar 2017 22:00:52 +0200
Subject: [PATCH] IB/core: Protect against self-requeue of a cq work item
Message-ID: <1489003252-1893-1-git-send-email-sagi@grimberg.me>

We need to make sure that the cq work item does not
run when we are destroying the cq. Unlike flush_work,
cancel_work_sync protects against self-requeue of the
work item (which we can do in ib_cq_poll_work).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/core/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index e95510117a6d..2746d2eb3d52 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -196,7 +196,7 @@ void ib_free_cq(struct ib_cq *cq)
 		irq_poll_disable(&cq->iop);
 		break;
 	case IB_POLL_WORKQUEUE:
-		flush_work(&cq->work);
+		cancel_work_sync(&cq->work);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.7.4
