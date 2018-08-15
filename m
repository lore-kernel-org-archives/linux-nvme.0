From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:50 -0400
Subject: [PATCH V4 5/9] nvmet: add passthru cmd handlers
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-6-chaitanya.kulkarni@wdc.com>

This patch adds passthru command handling capability for the NVMeOF
target and exports passthru APIs which are used to integrate passthru
code with nvmet-core. We add passthru ns member to the target request
to hold the ns reference for respective commands.

The new file pt-cmd.c handles passthru cmd parsing and execution. In the
passthru mode, we create a block layer request from the nvmet request
and map the data on to the block layer request. For handling the side
effects we add two functions similar to the nvme_passthru[start|end]()
functions present in the nvme-core. We explicitly blacklist the commands
at the time of parsing, which allows us to route the fabric commands
through default code path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/Makefile |   2 +-
 drivers/nvme/target/nvmet.h  |   9 +
 drivers/nvme/target/pt-cmd.c | 396 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 406 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/pt-cmd.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 8118c93391c6..280f83a85cd5 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
 obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o pt-cmd.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 72f7380ab590..5975839d2b7c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -27,6 +27,8 @@
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
 
+#include "../host/nvme.h"
+
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 
@@ -213,6 +215,8 @@ struct nvmet_subsys {
 	struct config_group	allowed_hosts_group;
 
 	struct list_head	entry;
+
+	struct nvme_ctrl	*pt_ctrl;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -285,6 +289,9 @@ struct nvmet_req {
 			struct bio_vec          *bvec;
 			struct work_struct      work;
 		} f;
+		struct {
+			struct nvme_ns *pt_ns;
+		} p;
 	};
 	int			sg_cnt;
 	/* data length as parsed from the command: */
@@ -327,6 +334,7 @@ struct nvmet_async_event {
 };
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
+u16 nvmet_pt_parse_pt_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
@@ -437,6 +445,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
+bool nvmet_pt_cmd_allow(struct nvmet_req *req);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/pt-cmd.c b/drivers/nvme/target/pt-cmd.c
new file mode 100644
index 000000000000..851e3ee63ac6
--- /dev/null
+++ b/drivers/nvme/target/pt-cmd.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe Over Fabrics Target Passthrough command implementation.
+ * Copyright (c) 2017-2018 Western Digital Corporation or its
+ * affiliates.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/delay.h>
+
+#include "nvmet.h"
+
+#define NVMET_PT_NS_CMD_DELAY	1000
+
+static inline struct nvme_ctrl *nvmet_pt_ctrl(struct nvmet_req *req)
+{
+	return req->sq->ctrl->subsys->pt_ctrl;
+}
+
+static void nvmet_pt_req_complete(struct nvmet_req *req, struct request *rq,
+		u16 status)
+{
+	nvmet_req_complete(req, status);
+	__blk_put_request(rq->q, rq);
+
+	if (req->p.pt_ns) {
+		nvme_put_ns(req->p.pt_ns);
+		req->p.pt_ns = NULL;
+	}
+}
+
+static void nvmet_pt_req_done(struct request *rq,
+		blk_status_t blk_status)
+{
+	struct nvmet_req *req = rq->end_io_data;
+	u16 status = nvme_req(rq)->status;
+
+	nvmet_set_result(req, nvme_req(rq)->result.u32);
+
+	/* prioritize nvme request status over blk_status_t */
+	if (!status && blk_status)
+		status = NVME_SC_INTERNAL;
+
+	nvmet_pt_req_complete(req, rq, status);
+}
+
+static inline u16 nvmet_pt_admin_format_nvm_start(struct nvmet_req *req)
+{
+	int lbaf = le32_to_cpu(req->cmd->format.cdw10) & 0x0000000F;
+	int nsid = le32_to_cpu(req->cmd->format.nsid);
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ns *id;
+
+	id = nvme_identify_ns(nvmet_pt_ctrl(req), nsid);
+	if (!id)
+		return NVME_SC_INTERNAL;
+	/*
+	 * XXX: Please update this code once NVMeOF target starts supoorting
+	 * metadata. We don't support ns lba format with metadata over fabrics
+	 * right now, so report error if format nvm cmd tries to format
+	 * a namespace with the LBA format which has metadata.
+	 */
+	if (id->lbaf[lbaf].ms)
+		status = NVME_SC_INVALID_NS;
+
+	kfree(id);
+	return status;
+}
+
+static inline u16 nvmet_pt_id_ctrl_init_fabircs_fields(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ctrl *id;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+	status = nvmet_copy_from_sgl(req, 0, id, sizeof(struct nvme_id_ctrl));
+	if (status)
+		goto out_free;
+
+	id->cntlid = cpu_to_le16(ctrl->cntlid);
+
+	id->acl = 3;
+	/* XXX: update these values when AER is implemented for the passthru */
+	id->aerl = 0;
+
+	/* emulate kas as most of the PCIe ctrl don't have a support for kas */
+	id->kas = cpu_to_le16(NVMET_KAS);
+
+	/* don't support host memory buffer */
+	id->hmpre = 0;
+	id->hmmin = 0;
+
+	id->sqes = min_t(__u8, ((0x6 << 4) | 0x6), id->sqes);
+	id->cqes = min_t(__u8, ((0x4 << 4) | 0x4), id->cqes);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+
+	/* don't support fuse commands */
+	id->fuses = 0;
+
+	id->sgls = cpu_to_le32(1 << 0); /* we always support SGLs */
+	if (ctrl->ops->has_keyed_sgls)
+		id->sgls |= cpu_to_le32(1 << 2);
+	if (req->port->inline_data_size)
+		id->sgls |= cpu_to_le32(1 << 20);
+
+	/* to allow loop mode don't use passthru ctrl subnqn */
+	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));
+
+	/* use fabric id-ctrl values */
+	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
+				req->port->inline_data_size) / 16);
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
+	id->msdbd = ctrl->ops->msdbd;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(struct nvme_id_ctrl));
+
+out_free:
+	kfree(id);
+out:
+	return status;
+}
+
+static inline u16 nvmet_pt_id_ns_init_fabircs_fields(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ns *id;
+	int i;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, id, sizeof(struct nvme_id_ns));
+	if (status)
+		goto out_free;
+
+	for (i = 0; i < (id->nlbaf + 1); i++)
+		if (id->lbaf[i].ms)
+			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));
+
+	id->flbas = id->flbas & ~(1 << 4);
+	id->mc = 0;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
+out_free:
+	kfree(id);
+out:
+	return status;
+}
+
+static inline u16 nvmet_pt_admin_cmd_identify_end(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->identify.cns) {
+	case NVME_ID_CNS_CTRL:
+		status = nvmet_pt_id_ctrl_init_fabircs_fields(req);
+		break;
+	case NVME_ID_CNS_NS:
+		status = nvmet_pt_id_ns_init_fabircs_fields(req);
+		break;
+	}
+	return status;
+}
+
+static u16 nvmet_pt_admin_passthru_start(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_format_nvm:
+		status = nvmet_pt_admin_format_nvm_start(req);
+		break;
+	}
+	return status;
+}
+
+static u16 nvmet_pt_admin_passthru_end(struct nvmet_req *req)
+{
+	u8 aer_type = NVME_AER_TYPE_NOTICE;
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_identify:
+		status = nvmet_pt_admin_cmd_identify_end(req);
+		break;
+	case nvme_admin_ns_mgmt:
+	case nvme_admin_ns_attach:
+	case nvme_admin_format_nvm:
+		/* allow passthru ctrl to finish the operation */
+		mdelay(NVMET_PT_NS_CMD_DELAY);
+		if (!nvmet_add_async_event(req->sq->ctrl, aer_type, 0, 0))
+			status = NVME_SC_INTERNAL;
+		mdelay(NVMET_PT_NS_CMD_DELAY);
+		break;
+	}
+	return status;
+}
+
+static void nvmet_pt_execute_admin_cmd(struct nvmet_req *req,
+		struct request *rq)
+{
+	u8 opcode = req->cmd->common.opcode;
+	u32 effects;
+	u16 status;
+
+	status = nvmet_pt_admin_passthru_start(req);
+	if (status)
+		goto out;
+
+	effects = nvme_passthru_start(nvmet_pt_ctrl(req), NULL, opcode);
+
+	blk_execute_rq(rq->q, NULL, rq, 0);
+
+	nvme_passthru_end(nvmet_pt_ctrl(req), effects);
+	status = nvmet_pt_admin_passthru_end(req);
+out:
+	if (status == NVME_SC_SUCCESS) {
+		nvmet_set_result(req, nvme_req(rq)->result.u32);
+		status = nvme_req(rq)->status;
+	}
+
+	nvmet_pt_req_complete(req, rq, status);
+}
+
+static struct request *nvmet_pt_blk_make_request(struct nvmet_req *req,
+		struct bio *bio, gfp_t gfp_mask)
+{
+	struct nvme_ctrl *pt_ctrl = nvmet_pt_ctrl(req);
+	struct nvme_command *cmd = req->cmd;
+	struct request_queue *q;
+	struct request *rq;
+
+	if (likely(req->sq->qid != 0))
+		q = req->p.pt_ns->queue;
+	else
+		q = pt_ctrl->admin_q;
+
+	rq = nvme_alloc_request(q, cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	if (IS_ERR(rq))
+		return rq;
+
+	for_each_bio(bio) {
+		int ret = blk_rq_append_bio(rq, &bio);
+
+		if (unlikely(ret)) {
+			blk_put_request(rq);
+			return ERR_PTR(ret);
+		}
+	}
+	/*
+	 * We don't support fuse cmds, also nvme-pci driver used its own
+	 * sgl_threshold parameter to decide whether to use SGLs or PRPs hence
+	 * turn off those bits in the flags.
+	 */
+	req->cmd->common.flags &= ~(NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND |
+			NVME_CMD_SGL_ALL);
+	return rq;
+}
+
+static void nvmet_pt_execute_pt(struct nvmet_req *req)
+{
+	struct bio *first_bio = NULL;
+	int sg_cnt = req->sg_cnt;
+	struct bio *prev = NULL;
+	struct bio *bio = NULL;
+	struct scatterlist *sg;
+	int op = REQ_OP_READ;
+	struct request *rq;
+	int op_flags = 0;
+	int i;
+
+	if (nvme_is_write(req->cmd)) {
+		op = REQ_OP_WRITE;
+		op_flags = REQ_SYNC | REQ_IDLE;
+	}
+
+	if (req->sg_cnt) {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+		first_bio = bio;
+		bio->bi_end_io = bio_put;
+
+		for_each_sg(req->sg, sg, req->sg_cnt, i) {
+			if (bio_add_page(bio, sg_page(sg), sg->length,
+						sg->offset) != sg->length) {
+				prev = bio;
+				bio_set_op_attrs(bio, op, op_flags);
+				bio = bio_alloc(GFP_KERNEL,
+						min(sg_cnt, BIO_MAX_PAGES));
+				bio_chain(bio, prev);
+			}
+			sg_cnt--;
+		}
+	}
+
+	rq = nvmet_pt_blk_make_request(req, first_bio, GFP_KERNEL);
+	if (IS_ERR(rq))
+		goto fail_free_bio;
+
+	rq->end_io_data = req;
+	if (likely(req->sq->qid != 0))
+		blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvmet_pt_req_done);
+	else
+		nvmet_pt_execute_admin_cmd(req, rq);
+	return;
+
+fail_free_bio:
+	while (first_bio) {
+		bio = first_bio;
+		first_bio = first_bio->bi_next;
+		bio_endio(bio);
+	}
+}
+
+static inline bool nvmet_pt_admin_cmd_supported(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+	unsigned int fid;
+	bool ret = true;
+
+	switch (cmd->common.opcode) {
+	/* black listed commands */
+	case nvme_admin_create_sq:
+	case nvme_admin_create_cq:
+	case nvme_admin_delete_sq:
+	case nvme_admin_delete_cq:
+	case nvme_admin_async_event:	/* not implemented */
+	case nvme_admin_activate_fw:
+	case nvme_admin_download_fw:
+	case nvme_admin_directive_send:
+	case nvme_admin_directive_recv:
+	case nvme_admin_dbbuf:
+	case nvme_admin_security_send:
+	case nvme_admin_security_recv:
+	case nvme_fabrics_command:
+		/* fall thru */
+	/*
+	 * Most PCIe ctrls don't support keep alive cmd, we route
+	 * keep alive to the non-passthru mode. In future please change
+	 * this code when PCIe ctrls with keep alive support available.
+	 */
+	case nvme_admin_keep_alive:
+		ret = false;
+		break;
+	case nvme_admin_set_features:
+		fid = le32_to_cpu(req->cmd->features.fid);
+		switch (fid) {
+		case NVME_FEAT_NUM_QUEUES:	/* disabled */
+		case NVME_FEAT_ASYNC_EVENT:	/* not implemented */
+		case NVME_FEAT_KATO:		/* route through target code */
+			ret = false;
+			break;
+		}
+		break;
+	}
+	return ret;
+}
+
+bool nvmet_pt_cmd_allow(struct nvmet_req *req)
+{
+	if (likely(req->sq->ctrl) && !nvmet_pt_ctrl(req))
+		return false;
+
+	if (unlikely(req->sq->qid == 0))
+		return nvmet_pt_admin_cmd_supported(req);
+
+	return true;
+}
+
+u16 nvmet_pt_parse_pt_cmd(struct nvmet_req *req)
+{
+	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+
+	if (unlikely(nvmet_check_ctrl_status(req, req->cmd)))
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+
+	if (unlikely(req->sq->qid == 0))
+		goto out;
+
+	req->p.pt_ns = nvme_find_get_ns(nvmet_pt_ctrl(req), nsid);
+	if (unlikely(!req->p.pt_ns)) {
+		pr_err("failed to get passthru ns nsid:%u\n", nsid);
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
+out:
+	req->execute = nvmet_pt_execute_pt;
+	return NVME_SC_SUCCESS;
+}
-- 
2.14.1
