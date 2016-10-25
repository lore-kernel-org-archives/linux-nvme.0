From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:35:02 -0700
Subject: [PATCH v4 5/8] ib_iser: log the connection reject message
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <95c18a20404b92ed799a5774ffaa949df4a909ce.1477426743.git.swise@opengridcomputing.com>

Acked-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 1b49453..6eeffb2 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -906,11 +906,14 @@ static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *eve
 	case RDMA_CM_EVENT_ESTABLISHED:
 		iser_connected_handler(cma_id, event->param.conn.private_data);
 		break;
+	case RDMA_CM_EVENT_REJECTED:
+		iser_info("Connection rejected: %s\n",
+			 rdma_reject_msg(cma_id, event->status));
+		/* FALLTHROUGH */
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-	case RDMA_CM_EVENT_REJECTED:
 		iser_connect_error(cma_id);
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
-- 
2.7.0
