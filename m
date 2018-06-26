From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 26 Jun 2018 18:17:17 -0400
Subject: [PATCH V4 2/2] nvmet: add support for flush all
In-Reply-To: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
References: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180626221717.19992-3-chaitanya.kulkarni@wdc.com>

This patch implements the flush command behavior described in
"NVMe 1.3a  TP 4035" for NSID value of FFFFFFFFh. Now flush command
applies to all the namespaces attached to the controller processing the
Flush command when the value 0xFFFFFFFF is set in the NSID field.

For block device and file-backed ns we execute flush in the separate
worker thread context (nvmet_bdev_flush_work() and
nvmet_file_flush_work() respectively).

We also add a new struct nvmet_subsys member to keep the track of number
of currently active namespaces "active_ns". We update this "active_ns"
member in nvmet_ns_enable()/nvmet_ns_disable().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 89 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 17 +++++-
 drivers/nvme/target/io-cmd-file.c |  9 +++-
 drivers/nvme/target/nvmet.h       | 10 ++++
 5 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e2c6f8b39388..2ad52e5cdaed 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -256,7 +256,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
 	/* XXX: don't report vwc if the underlying device is write through */
-	id->vwc = NVME_CTRL_VWC_PRESENT;
+	id->vwc = NVME_CTRL_VWC_PRESENT | 1 << 2 | 1 << 1;
 
 	/*
 	 * We can't support atomic writes bigger than a LBA without support
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 322f7cfc37a4..4fe474c632f2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -370,6 +370,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
 
+	subsys->active_ns++;
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	ret = 0;
@@ -411,6 +412,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	mutex_lock(&subsys->lock);
 	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
+	subsys->active_ns--;
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
@@ -543,6 +545,85 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
+static void nvmet_flush_all_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_req *r, *req_arr;
+	u16 status = NVME_SC_SUCCESS;
+	struct nvmet_ns *ns;
+	unsigned int max_ns;
+	int cnt = 0, i;
+
+	req->ns = NULL;
+
+	/* only process namespaces present prior to flush command */
+	mutex_lock(&subsys->lock);
+	max_ns = subsys->active_ns;
+	mutex_unlock(&subsys->lock);
+
+	req_arr = kmalloc_array(max_ns, sizeof(*req_arr), GFP_KERNEL);
+	if (!req_arr) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	for (i = 0; i < max_ns; i++) {
+		r = &req_arr[i];
+
+		r->rsp = kmalloc(sizeof(*r->rsp), GFP_KERNEL);
+		if (!r->rsp) {
+			status = NVME_SC_INTERNAL;
+			goto free_rsps;
+		}
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &subsys->namespaces, dev_link) {
+		if (cnt > max_ns)
+			break;
+
+		r = &req_arr[cnt];
+		r->ns = ns;
+		r->cmd = req->cmd;
+		r->rsp->status = cpu_to_le16(0);
+
+		if (ns->file)
+			INIT_WORK(&r->work, nvmet_file_flush_work);
+		else
+			INIT_WORK(&r->work, nvmet_bdev_flush_work);
+
+		percpu_ref_get(&r->ns->ref);
+		schedule_work(&r->work);
+		cnt++;
+	}
+	rcu_read_unlock();
+
+	while (--cnt >= 0) {
+		r = &req_arr[cnt];
+
+		flush_work(&r->work);
+		percpu_ref_put(&r->ns->ref);
+		if (r->rsp->status) {
+			pr_err("flush all failed nsid: %u\n", r->ns->nsid);
+			status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		}
+	}
+
+free_rsps:
+	while (--i)
+		kfree(req_arr[i].rsp);
+	kfree(req_arr);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_flush_all(struct nvmet_req *req)
+{
+	INIT_WORK(&req->work, nvmet_flush_all_work);
+	schedule_work(&req->work);
+}
+
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -552,6 +633,12 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
+	if (unlikely(nvmet_cmd_flush_all(req))) {
+		req->execute = nvmet_execute_flush_all;
+		req->data_len = 0;
+		return NVME_SC_SUCCESS;
+	}
+
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
@@ -1077,6 +1164,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	subsys->active_ns = 0;
+
 	return subsys;
 }
 
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e0b0f7df70c2..a08275c70f73 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,10 +46,16 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 
 static void nvmet_bio_done(struct bio *bio)
 {
+	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
 	struct nvmet_req *req = bio->bi_private;
 
-	nvmet_req_complete(req,
-		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	if (unlikely(nvmet_cmd_flush_all(req))) {
+		if (req->b.inline_bio.bi_status)
+			req->rsp->status = cpu_to_le16(status);
+		return;
+	}
+
+	nvmet_req_complete(req, bio->bi_status ? status : 0);
 
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
@@ -124,6 +130,13 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
+void nvmet_bdev_flush_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
+
+	nvmet_bdev_execute_flush(req);
+}
+
 static u16 nvmet_bdev_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 4e6e6c255a58..d1c79a3c4f9b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -218,14 +218,19 @@ static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
 	queue_work(req->ns->file_wq, &req->work);
 }
 
-static void nvmet_file_flush_work(struct work_struct *w)
+void nvmet_file_flush_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
+	u16 status;
 	int ret;
 
 	ret = vfs_fsync(req->ns->file, 1);
+	status = ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : NVME_SC_SUCCESS;
 
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	if (nvmet_cmd_flush_all(req))
+		req->rsp->status = cpu_to_le16(status);
+	else
+		nvmet_req_complete(req, status);
 }
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b1cd8eb6717f..48928b1acded 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -169,6 +169,7 @@ struct nvmet_subsys {
 
 	struct list_head	namespaces;
 	unsigned int		max_nsid;
+	unsigned int		active_ns;
 
 	struct list_head	ctrls;
 
@@ -380,9 +381,18 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
 
+void nvmet_bdev_flush_work(struct work_struct *w);
+void nvmet_file_flush_work(struct work_struct *w);
+
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
 			req->ns->blksize_shift;
 }
+
+static inline int nvmet_cmd_flush_all(struct nvmet_req *req)
+{
+	return (req->cmd->common.opcode == nvme_cmd_flush) &&
+		(le32_to_cpu(req->cmd->rw.nsid) == 0xFFFFFFFF);
+}
 #endif /* _NVMET_H */
-- 
2.17.0
