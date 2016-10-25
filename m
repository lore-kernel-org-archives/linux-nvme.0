From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:35:02 -0700
Subject: [PATCH v4 7/8] ib_isert: log the connection reject message
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <7baca6d0f38f9556d8b6a14a19b4c2d505503219.1477426743.git.swise@opengridcomputing.com>

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index cae9bbc..5331272 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -795,6 +795,8 @@ isert_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 		 */
 		return 1;
 	case RDMA_CM_EVENT_REJECTED:       /* FALLTHRU */
+		isert_info("Connection rejected: %s\n",
+			   rdma_reject_msg(cma_id, event->status));
 	case RDMA_CM_EVENT_UNREACHABLE:    /* FALLTHRU */
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		ret = isert_connect_error(cma_id);
-- 
2.7.0
