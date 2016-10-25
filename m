From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 11:33:07 -0700
Subject: [PATCH v4 2/8] rdma_cm: add rdma_is_consumer_reject() helper function
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <06687af52fc7154121673bf0b0fa81d8618b43ed.1477426743.git.swise@opengridcomputing.com>

Return true if the peer consumer application rejected the
connection attempt.

Reviewed-by: Sagi Grimberg <sagi at grimbeg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/core/cma.c | 13 +++++++++++++
 include/rdma/rdma_cm.h        |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 427f74e..71d2a06 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -115,6 +115,19 @@ const char *__attribute_const__ rdma_reject_msg(struct rdma_cm_id *id,
 }
 EXPORT_SYMBOL(rdma_reject_msg);
 
+bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason)
+{
+	if (rdma_ib_or_roce(id->device, id->port_num))
+		return reason == IB_CM_REJ_CONSUMER_DEFINED;
+
+	if (rdma_protocol_iwarp(id->device, id->port_num))
+		return reason == -ECONNREFUSED;
+
+	WARN_ON_ONCE(1);
+	return false;
+}
+EXPORT_SYMBOL(rdma_is_consumer_reject);
+
 static void cma_add_one(struct ib_device *device);
 static void cma_remove_one(struct ib_device *device, void *client_data);
 
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index f11a768..62039c2 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -395,5 +395,12 @@ __be64 rdma_get_service_id(struct rdma_cm_id *id, struct sockaddr *addr);
  */
 const char *__attribute_const__ rdma_reject_msg(struct rdma_cm_id *id,
 						int reason);
+/**
+ * rdma_is_consumer_reject - return true if the consumer rejected the connect
+ *                           request.
+ * @id: Communication identifier that received the REJECT event.
+ * @reason: Value returned in the REJECT event status field.
+ */
+bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason);
 
 #endif /* RDMA_CM_H */
-- 
2.7.0
