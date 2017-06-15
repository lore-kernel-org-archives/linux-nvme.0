From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:35:02 +0200
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170615163502.10548-1-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
Message-ID: <20170615163502.10548-7-hch@lst.de>

Verify that our IDs match for shared namespaces in a subystem, and link
them up in a headless queue so that we can find siblings easily.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 57e48d893173..a67a850ef7db 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2249,6 +2249,89 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	return ret;
 }
 
+static int nvme_ns_link_siblings(struct nvme_ns *ns, struct nvme_id_ns *id,
+		struct nvme_ns *cur)
+{
+	bool is_shared = id->nmic & (1 << 0);
+	bool have_id = false;
+
+	if (!uuid_is_null(&ns->uuid)) {
+		have_id = true;
+		if (!uuid_equal(&ns->uuid, &cur->uuid))
+			return 0;
+	}
+	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+		have_id = true;
+		if (memcmp(&ns->nguid, &cur->nguid, sizeof(ns->nguid)))
+			return 0;
+	}
+	if (memchr_inv(ns->eui, 0, sizeof(ns->eui))) {
+		have_id = true;
+		if (memcmp(&ns->eui, &cur->eui, sizeof(ns->eui)))
+			return 0;
+	}
+
+	/*
+	 * XXX: unique namespace ids are only required when namespace
+	 * management is enabled.  But between that and the uniqueue ids not
+	 * being mandatory we are between a rock and a hard place.
+	 */
+	if (!have_id && is_shared) {
+		dev_err(ns->ctrl->device,
+			"shared namespace %u without unique ID.\n",
+			ns->ns_id);
+		return -EINVAL;
+	}
+
+	if (have_id && !is_shared) {
+		dev_err(ns->ctrl->device,
+			"private namespace %u with duplicate ID.\n",
+			ns->ns_id);
+		return -EINVAL;
+	}
+
+	/*
+	 * XXX: this is currently only guaranteed when namespace management
+	 * is supported.  Decide if we should make it conditional or simply
+	 * not support multipathing on odd devices.
+	 */
+	if (is_shared && ns->ns_id != cur->ns_id) {
+		dev_err(ns->ctrl->device,
+			"non-matching nsids (%u vs %u) for shared namespaces\n",
+			ns->ns_id, cur->ns_id);
+	}
+
+	list_add(&ns->siblings, &cur->siblings);
+	return 0;
+}
+
+static int nvme_ns_find_siblings(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	struct nvme_subsystem *subsys = ns->ctrl->subsys;
+	struct nvme_ctrl *ctrl;
+	struct nvme_ns *cur;
+	int err;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl == ns->ctrl)
+			continue;
+
+		mutex_lock(&ctrl->namespaces_mutex);
+		list_for_each_entry(cur, &ctrl->namespaces, list) {
+			err = nvme_ns_link_siblings(ns, id, cur);
+			if (err)
+				break;
+		}
+		mutex_unlock(&ctrl->namespaces_mutex);
+
+		if (err)
+			break;
+	}
+	mutex_unlock(&subsys->lock);
+	return err;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -2271,6 +2354,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
+	INIT_LIST_HEAD(&ns->siblings);
 
 	kref_init(&ns->kref);
 	ns->ns_id = nsid;
@@ -2284,6 +2368,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_ns(ns, &id))
 		goto out_free_queue;
 
+	if (nvme_ns_find_siblings(ns, id))
+		goto out_free_id;
+
 	if (nvme_nvm_ns_supported(ns, id) &&
 				nvme_nvm_register(ns, disk_name, node)) {
 		dev_warn(ctrl->device, "%s: LightNVM init failure\n", __func__);
@@ -2348,6 +2435,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
+	list_del_init(&ns->siblings);
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
 
 	nvme_put_ns(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2a006a00c3fc..777a85cc2a0d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -196,6 +196,7 @@ struct nvme_ns {
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
+	struct list_head siblings;
 	struct nvm_dev *ndev;
 	struct kref kref;
 	int instance;
-- 
2.11.0
