From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:35:02 -0700
Subject: [PATCH v4 6/8] rds_rdma: log the connection reject message
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <4d057d8bb97d732d320223d6bf04674b66f5a667.1477426743.git.swise@opengridcomputing.com>

Acked-by: Santosh Shilimkar <santosh.shilimkar at oracle.com>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 net/rds/rdma_transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 345f090..d5f3117 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -100,11 +100,14 @@ int rds_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
 		trans->cm_connect_complete(conn, event);
 		break;
 
+	case RDMA_CM_EVENT_REJECTED:
+		rdsdebug("Connection rejected: %s\n",
+			 rdma_reject_msg(cm_id, event->status));
+		/* FALLTHROUGH */
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-	case RDMA_CM_EVENT_REJECTED:
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		if (conn)
-- 
2.7.0
