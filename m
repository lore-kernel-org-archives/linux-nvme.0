From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:33:58 -0700
Subject: [PATCH v4 3/8] rdma_cm: add rdma_consumer_reject_data helper function
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <82250f533f3a712189cf38352ae4d04a08bb637f.1477426743.git.swise@opengridcomputing.com>

rdma_consumer_reject_data() will return the private data pointer
and length if any is available.

Reviewed-by: Sagi Grimberg <sagi at grimbeg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/core/cma.c | 16 ++++++++++++++++
 include/rdma/rdma_cm.h        | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 71d2a06..8399149 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -128,6 +128,22 @@ bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason)
 }
 EXPORT_SYMBOL(rdma_is_consumer_reject);
 
+const void *rdma_consumer_reject_data(struct rdma_cm_id *id,
+				      struct rdma_cm_event *ev, u8 *data_len)
+{
+	const void *p;
+
+	if (rdma_is_consumer_reject(id, ev->status)) {
+		*data_len = ev->param.conn.private_data_len;
+		p = ev->param.conn.private_data;
+	} else {
+		*data_len = 0;
+		p = NULL;
+	}
+	return p;
+}
+EXPORT_SYMBOL(rdma_consumer_reject_data);
+
 static void cma_add_one(struct ib_device *device);
 static void cma_remove_one(struct ib_device *device, void *client_data);
 
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 62039c2..d3968b5 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -403,4 +403,14 @@ const char *__attribute_const__ rdma_reject_msg(struct rdma_cm_id *id,
  */
 bool rdma_is_consumer_reject(struct rdma_cm_id *id, int reason);
 
+/**
+ * rdma_consumer_reject_data - return the consumer reject private data and
+ *			       length, if any.
+ * @id: Communication identifier that received the REJECT event.
+ * @ev: RDMA CM reject event.
+ * @data_len: Pointer to the resulting length of the consumer data.
+ */
+const void *rdma_consumer_reject_data(struct rdma_cm_id *id,
+				      struct rdma_cm_event *ev, u8 *data_len);
+
 #endif /* RDMA_CM_H */
-- 
2.7.0
