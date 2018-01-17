From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 15:52:57 +0200
Subject: [PATCH 3/4] iser-target: remove dead code
In-Reply-To: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
Message-ID: <1516197178-26493-4-git-send-email-maxg@mellanox.com>

IB_EVENT_QP_LAST_WQE_REACHED event can arrive only for
QP associated with Shared Receive Queue (SRQ). There is
no SRQ usage in iser target.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 720dfb3..bde22e1 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -81,9 +81,6 @@
 	case IB_EVENT_COMM_EST:
 		rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
 		break;
-	case IB_EVENT_QP_LAST_WQE_REACHED:
-		isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
-		break;
 	default:
 		break;
 	}
-- 
1.8.3.1
