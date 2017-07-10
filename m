From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 10:17:31 +0300
Subject: [PATCH v7 for-4.13 4/7] RDMA/core: expose affinity mappings per
 completion vector
In-Reply-To: <1499671054-23899-1-git-send-email-sagi@grimberg.me>
References: <1499671054-23899-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499671054-23899-5-git-send-email-sagi@grimberg.me>

This will allow ULPs to intelligently locate threads based
on completion vector cpu affinity mappings. In case the
driver does not expose a get_vector_affinity callout, return
NULL so the caller can maintain a fallback logic.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: H?kon Bugge <haakon.bugge at oracle.com>
Acked-by: Doug Ledford <dledford at redhat.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 include/rdma/ib_verbs.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9d4d2a74c95e..8d5621cada90 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2248,6 +2248,8 @@ struct ib_device {
 	 */
 	int (*get_port_immutable)(struct ib_device *, u8, struct ib_port_immutable *);
 	void (*get_dev_fw_str)(struct ib_device *, char *str, size_t str_len);
+	const struct cpumask *(*get_vector_affinity)(struct ib_device *ibdev,
+						     int comp_vector);
 };
 
 struct ib_client {
@@ -3612,7 +3614,6 @@ static inline void rdma_ah_set_interface_id(struct rdma_ah_attr *attr,
 
 	grh->dgid.global.interface_id = if_id;
 }
-
 static inline void rdma_ah_set_grh(struct rdma_ah_attr *attr,
 				   union ib_gid *dgid, u32 flow_label,
 				   u8 sgid_index, u8 hop_limit,
@@ -3642,4 +3643,26 @@ static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
 	else
 		return RDMA_AH_ATTR_TYPE_IB;
 }
+
+/**
+ * ib_get_vector_affinity - Get the affinity mappings of a given completion
+ *   vector
+ * @device:         the rdma device
+ * @comp_vector:    index of completion vector
+ *
+ * Returns NULL on failure, otherwise a corresponding cpu map of the
+ * completion vector (returns all-cpus map if the device driver doesn't
+ * implement get_vector_affinity).
+ */
+static inline const struct cpumask *
+ib_get_vector_affinity(struct ib_device *device, int comp_vector)
+{
+	if (comp_vector < 0 || comp_vector >= device->num_comp_vectors ||
+	    !device->get_vector_affinity)
+		return NULL;
+
+	return device->get_vector_affinity(device, comp_vector);
+
+}
+
 #endif /* IB_VERBS_H */
-- 
2.7.4
