From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 24 Oct 2016 12:07:16 -0700
Subject: [PATCH v3 6/6] rds_rdma: log the connection reject message
In-Reply-To: <cover.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
Message-ID: <21c48d771ab8a9d37ec19ea5f7a48ed5b84c8984.1477336045.git.swise@opengridcomputing.com>

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 net/rds/rdma_transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 345f090..6bd2814 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -100,11 +100,14 @@ int rds_rdma_cm_event_handler(struct rdma_cm_id *cm_id,
 		trans->cm_connect_complete(conn, event);
 		break;
 
+	case RDMA_CM_EVENT_REJECTED:
+		rdsdebug("Connection rejected: %s\n",
+			 rdma_reject_msg(cm_id, event->status));
+		/*FALLTHROUGH*/
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
