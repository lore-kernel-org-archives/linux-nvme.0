From: james.smart@broadcom.com (James Smart)
Date: Mon, 03 Oct 2016 23:27:03 -0700
Subject: [PATCH 7/7] nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME
Message-ID: <57f34bb7.DaNIUHq69nou/DuF%james.smart@broadcom.com>


Add FC LLDD loopback driver to test FC host and target transport within
nvme-fabrics

To aid in the development and testing of the lower-level api of the FC
transport, this loopback driver has been created to act as if it were a
FC hba driver supporting both the host interfaces as well as the target
interfaces with the nvme FC transport.

The changes made since the prior patch:
- Created defines for template constants per review
- Removal of fabric name for nport qualifier. Not necessary in T11
- Reworked teardown paths with ref counting and proper locking
- Teardown now invokes callbackes on completion of unregister functions
- Added callbacks for unregister complete interfaces
- Split sysfs add of remoteport and targetport for better testing.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/Kconfig  |   13 +
 drivers/nvme/target/Makefile |    2 +
 drivers/nvme/target/fcloop.c | 1131 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1146 insertions(+)
 create mode 100644 drivers/nvme/target/fcloop.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 158efb0..606adf7 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -44,3 +44,16 @@ config NVME_TARGET_FC
 
 	  If unsure, say N.
 
+config NVME_TARGET_FCLOOP
+	tristate "NVMe over Fabrics FC Transport Loopback Test driver"
+	depends on BLK_DEV_NVME
+	select NVME_TARGET
+	select NVME_FABRICS
+	select SG_POOL
+	select NVME_FC
+	select NVME_TARGET_FC
+	help
+	  This enables the NVMe FC loopback test support, which can be useful
+	  to test NVMe-FC transport interfaces.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 80b128b..fecc14f 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -3,9 +3,11 @@ obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
 obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
 obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
+obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o \
 			discovery.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
+nvme-fcloop-y	+= fcloop.o
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
new file mode 100644
index 0000000..3296f2f
--- /dev/null
+++ b/drivers/nvme/target/fcloop.c
@@ -0,0 +1,1131 @@
+/*
+ * Copyright (c) 2016 Avago Technologies.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful.
+ * ALL EXPRESS OR IMPLIED CONDITIONS, REPRESENTATIONS AND WARRANTIES,
+ * INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A
+ * PARTICULAR PURPOSE, OR NON-INFRINGEMENT, ARE DISCLAIMED, EXCEPT TO
+ * THE EXTENT THAT SUCH DISCLAIMERS ARE HELD TO BE LEGALLY INVALID.
+ * See the GNU General Public License for more details, a copy of which
+ * can be found in the file COPYING included with this package
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+#include <linux/parser.h>
+
+#include "../host/nvme.h"
+#include "../target/nvmet.h"
+#include <linux/nvme-fc-driver.h>
+#include <linux/nvme-fc.h>
+
+
+#define is_end_of_list(pos, head, member) ((&pos->member) == (head))
+
+enum {
+	NVMF_OPT_ERR		= 0,
+	NVMF_OPT_WWNN		= 1 << 0,
+	NVMF_OPT_WWPN		= 1 << 1,
+	NVMF_OPT_ROLES		= 1 << 2,
+	NVMF_OPT_FCADDR		= 1 << 3,
+	NVMF_OPT_LPWWNN		= 1 << 4,
+	NVMF_OPT_LPWWPN		= 1 << 5,
+};
+
+struct fcloop_ctrl_options {
+	int			mask;
+	u64			wwnn;
+	u64			wwpn;
+	u32			roles;
+	u32			fcaddr;
+	u64			lpwwnn;
+	u64			lpwwpn;
+};
+
+static const match_table_t opt_tokens = {
+	{ NVMF_OPT_WWNN,	"wwnn=%s"	},
+	{ NVMF_OPT_WWPN,	"wwpn=%s"	},
+	{ NVMF_OPT_ROLES,	"roles=%d"	},
+	{ NVMF_OPT_FCADDR,	"fcaddr=%x"	},
+	{ NVMF_OPT_LPWWNN,	"lpwwnn=%s"	},
+	{ NVMF_OPT_LPWWPN,	"lpwwpn=%s"	},
+	{ NVMF_OPT_ERR,		NULL		}
+};
+
+static int
+fcloop_parse_options(struct fcloop_ctrl_options *opts,
+		const char *buf)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *options, *o, *p;
+	int token, ret = 0;
+	u64 token64;
+
+	options = o = kstrdup(buf, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, opt_tokens, args);
+		opts->mask |= token;
+		switch (token) {
+		case NVMF_OPT_WWNN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->wwnn = token64;
+			break;
+		case NVMF_OPT_WWPN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->wwpn = token64;
+			break;
+		case NVMF_OPT_ROLES:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->roles = token;
+			break;
+		case NVMF_OPT_FCADDR:
+			if (match_hex(args, &token)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->fcaddr = token;
+			break;
+		case NVMF_OPT_LPWWNN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->lpwwnn = token64;
+			break;
+		case NVMF_OPT_LPWWPN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->lpwwpn = token64;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out_free_options;
+		}
+	}
+
+out_free_options:
+	kfree(options);
+	return ret;
+}
+
+
+static int
+fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
+		const char *buf)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *options, *o, *p;
+	int token, ret = 0;
+	u64 token64;
+
+	*nname = -1;
+	*pname = -1;
+
+	options = o = kstrdup(buf, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, opt_tokens, args);
+		switch (token) {
+		case NVMF_OPT_WWNN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			*nname = token64;
+			break;
+		case NVMF_OPT_WWPN:
+			if (match_u64(args, &token64)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			*pname = token64;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out_free_options;
+		}
+	}
+
+out_free_options:
+	kfree(options);
+
+	if (!ret) {
+		if (*nname == -1)
+			return -EINVAL;
+		if (*pname == -1)
+			return -EINVAL;
+	}
+
+	return ret;
+}
+
+
+#define LPORT_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN)
+
+#define RPORT_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN |  \
+			 NVMF_OPT_LPWWNN | NVMF_OPT_LPWWPN)
+
+#define TGTPORT_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN)
+
+#define ALL_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN | NVMF_OPT_ROLES | \
+			 NVMF_OPT_FCADDR | NVMF_OPT_LPWWNN | NVMF_OPT_LPWWPN)
+
+
+static DEFINE_SPINLOCK(fcloop_lock);
+static LIST_HEAD(fcloop_lports);
+static LIST_HEAD(fcloop_nports);
+
+struct fcloop_lport {
+	struct nvme_fc_local_port *localport;
+	struct list_head lport_list;
+	struct completion unreg_done;
+};
+
+struct fcloop_rport {
+	struct nvme_fc_remote_port *remoteport;
+	struct nvmet_fc_target_port *targetport;
+	struct fcloop_nport *nport;
+	struct fcloop_lport *lport;
+};
+
+struct fcloop_tport {
+	struct nvmet_fc_target_port *targetport;
+	struct nvme_fc_remote_port *remoteport;
+	struct fcloop_nport *nport;
+	struct fcloop_lport *lport;
+};
+
+struct fcloop_nport {
+	struct fcloop_rport *rport;
+	struct fcloop_tport *tport;
+	struct fcloop_lport *lport;
+	struct list_head nport_list;
+	struct kref ref;
+	struct completion rport_unreg_done;
+	struct completion tport_unreg_done;
+	u64 node_name;
+	u64 port_name;
+	u32 port_role;
+	u32 port_id;
+};
+
+struct fcloop_lsreq {
+	struct fcloop_tport		*tport;
+	struct nvmefc_ls_req		*lsreq;
+	struct work_struct		work;
+	struct nvmefc_tgt_ls_req	tgt_ls_req;
+	int				status;
+};
+
+struct fcloop_fcpreq {
+	struct fcloop_tport		*tport;
+	struct nvmefc_fcp_req		*fcpreq;
+	u16				status;
+	struct work_struct		work;
+	struct nvmefc_tgt_fcp_req	tgt_fcp_req;
+};
+
+int
+fcloop_create_queue(struct nvme_fc_local_port *localport,
+			unsigned int qidx, u16 qsize,
+			void **handle)
+{
+	*handle = localport;
+	return 0;
+}
+
+void
+fcloop_delete_queue(struct nvme_fc_local_port *localport,
+			unsigned int idx, void *handle)
+{
+}
+
+
+/*
+ * Transmit of LS RSP done (e.g. buffers all set). call back up
+ * initiator "done" flows.
+ */
+void
+fcloop_tgt_lsrqst_done_work(struct work_struct *work)
+{
+	struct fcloop_lsreq *tls_req =
+		container_of(work, struct fcloop_lsreq, work);
+	struct fcloop_tport *tport = tls_req->tport;
+	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+
+	if (tport->remoteport)
+		lsreq->done(lsreq, tls_req->status);
+}
+
+int
+fcloop_ls_req(struct nvme_fc_local_port *localport,
+			struct nvme_fc_remote_port *remoteport,
+			struct nvmefc_ls_req *lsreq)
+{
+	struct fcloop_lsreq *tls_req = lsreq->private;
+	struct fcloop_rport *rport = remoteport->private;
+	int ret = 0;
+
+	tls_req->lsreq = lsreq;
+	INIT_WORK(&tls_req->work, fcloop_tgt_lsrqst_done_work);
+
+	if (!rport->targetport) {
+		tls_req->status = -ECONNREFUSED;
+		schedule_work(&tls_req->work);
+		return ret;
+	}
+
+	tls_req->status = 0;
+	tls_req->tport = rport->targetport->private;
+	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
+				 lsreq->rqstaddr, lsreq->rqstlen);
+
+	return ret;
+}
+
+int
+fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
+			struct nvmefc_tgt_ls_req *tgt_lsreq)
+{
+	struct fcloop_lsreq *tls_req =
+		container_of(tgt_lsreq, struct fcloop_lsreq, tgt_ls_req);
+	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+
+	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
+		((lsreq->rsplen < tgt_lsreq->rsplen) ?
+				lsreq->rsplen : tgt_lsreq->rsplen));
+	(tgt_lsreq->done)(tgt_lsreq);
+
+	schedule_work(&tls_req->work);
+
+	return 0;
+}
+
+/*
+ * FCP IO operation done. call back up initiator "done" flows.
+ */
+void
+fcloop_tgt_fcprqst_done_work(struct work_struct *work)
+{
+	struct fcloop_fcpreq *tfcp_req =
+		container_of(work, struct fcloop_fcpreq, work);
+	struct fcloop_tport *tport = tfcp_req->tport;
+	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+
+	if (tport->remoteport) {
+		fcpreq->status = tfcp_req->status;
+		fcpreq->done(fcpreq);
+	}
+}
+
+
+int
+fcloop_fcp_req(struct nvme_fc_local_port *localport,
+			struct nvme_fc_remote_port *remoteport,
+			void *hw_queue_handle,
+			struct nvmefc_fcp_req *fcpreq)
+{
+	struct fcloop_fcpreq *tfcp_req = fcpreq->private;
+	struct fcloop_rport *rport = remoteport->private;
+	int ret = 0;
+
+	INIT_WORK(&tfcp_req->work, fcloop_tgt_fcprqst_done_work);
+
+	if (!rport->targetport) {
+		tfcp_req->status = NVME_SC_FC_TRANSPORT_ERROR;
+		schedule_work(&tfcp_req->work);
+		return ret;
+	}
+
+	tfcp_req->fcpreq = fcpreq;
+	tfcp_req->tport = rport->targetport->private;
+
+	ret = nvmet_fc_rcv_fcp_req(rport->targetport, &tfcp_req->tgt_fcp_req,
+				 fcpreq->cmdaddr, fcpreq->cmdlen);
+
+	return ret;
+}
+
+void
+fcloop_fcp_copy_data(u8 op, struct scatterlist *data_sg,
+			struct scatterlist *io_sg, u32 offset, u32 length)
+{
+	void *data_p, *io_p;
+	u32 data_len, io_len, tlen;
+
+	io_p = sg_virt(io_sg);
+	io_len = io_sg->length;
+
+	for ( ; offset; ) {
+		tlen = min_t(u32, offset, io_len);
+		offset -= tlen;
+		io_len -= tlen;
+		if (!io_len) {
+			io_sg = sg_next(io_sg);
+			io_p = sg_virt(io_sg);
+			io_len = io_sg->length;
+		} else
+			io_p += tlen;
+	}
+
+	data_p = sg_virt(data_sg);
+	data_len = data_sg->length;
+
+	for ( ; length; ) {
+		tlen = min_t(u32, io_len, data_len);
+		tlen = min_t(u32, tlen, length);
+
+		if (op == NVMET_FCOP_WRITEDATA)
+			memcpy(data_p, io_p, tlen);
+		else
+			memcpy(io_p, data_p, tlen);
+
+		length -= tlen;
+
+		io_len -= tlen;
+		if ((!io_len) && (length)) {
+			io_sg = sg_next(io_sg);
+			io_p = sg_virt(io_sg);
+			io_len = io_sg->length;
+		} else
+			io_p += tlen;
+
+		data_len -= tlen;
+		if ((!data_len) && (length)) {
+			data_sg = sg_next(data_sg);
+			data_p = sg_virt(data_sg);
+			data_len = data_sg->length;
+		} else
+			data_p += tlen;
+	}
+}
+
+int
+fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
+			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
+{
+	struct fcloop_fcpreq *tfcp_req =
+		container_of(tgt_fcpreq, struct fcloop_fcpreq, tgt_fcp_req);
+	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	u32 rsplen = 0, xfrlen = 0;
+	int fcp_err = 0;
+	u8 op = tgt_fcpreq->op;
+
+	switch (op) {
+	case NVMET_FCOP_WRITEDATA:
+		xfrlen = tgt_fcpreq->transfer_length;
+		fcloop_fcp_copy_data(op, tgt_fcpreq->sg, fcpreq->first_sgl,
+					tgt_fcpreq->offset, xfrlen);
+		fcpreq->transferred_length += xfrlen;
+		break;
+
+	case NVMET_FCOP_READDATA:
+	case NVMET_FCOP_READDATA_RSP:
+		xfrlen = tgt_fcpreq->transfer_length;
+		fcloop_fcp_copy_data(op, tgt_fcpreq->sg, fcpreq->first_sgl,
+					tgt_fcpreq->offset, xfrlen);
+		fcpreq->transferred_length += xfrlen;
+		if (op == NVMET_FCOP_READDATA)
+			break;
+
+		/* Fall-Thru to RSP handling */
+
+	case NVMET_FCOP_RSP:
+		rsplen = ((fcpreq->rsplen < tgt_fcpreq->rsplen) ?
+				fcpreq->rsplen : tgt_fcpreq->rsplen);
+		memcpy(fcpreq->rspaddr, tgt_fcpreq->rspaddr, rsplen);
+		if (rsplen < tgt_fcpreq->rsplen)
+			fcp_err = -E2BIG;
+		fcpreq->rcv_rsplen = rsplen;
+		fcpreq->status = 0;
+		tfcp_req->status = 0;
+		break;
+
+	case NVMET_FCOP_ABORT:
+		tfcp_req->status = NVME_SC_FC_TRANSPORT_ABORTED;
+		break;
+
+	default:
+		fcp_err = -EINVAL;
+		break;
+	}
+
+	tgt_fcpreq->transferred_length = xfrlen;
+	tgt_fcpreq->fcp_error = fcp_err;
+	tgt_fcpreq->done(tgt_fcpreq);
+
+	if ((!fcp_err) && (op == NVMET_FCOP_RSP ||
+			op == NVMET_FCOP_READDATA_RSP ||
+			op == NVMET_FCOP_ABORT))
+		schedule_work(&tfcp_req->work);
+
+	return 0;
+}
+
+void
+fcloop_ls_abort(struct nvme_fc_local_port *localport,
+			struct nvme_fc_remote_port *remoteport,
+				struct nvmefc_ls_req *lsreq)
+{
+	/* TODO */
+}
+
+void
+fcloop_fcp_abort(struct nvme_fc_local_port *localport,
+			struct nvme_fc_remote_port *remoteport,
+			void *hw_queue_handle,
+			struct nvmefc_fcp_req *fcpreq)
+{
+	/* TODO */
+}
+
+void
+fcloop_localport_delete(struct nvme_fc_local_port *localport)
+{
+	struct fcloop_lport *lport = localport->private;
+
+	/* release any threads waiting for the unreg to complete */
+	complete(&lport->unreg_done);
+}
+
+void
+fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
+{
+	struct fcloop_rport *rport = remoteport->private;
+
+	/* release any threads waiting for the unreg to complete */
+	complete(&rport->nport->rport_unreg_done);
+}
+
+void
+fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
+{
+	struct fcloop_tport *tport = targetport->private;
+
+	/* release any threads waiting for the unreg to complete */
+	complete(&tport->nport->tport_unreg_done);
+}
+
+#define	FCLOOP_HW_QUEUES		1
+#define	FCLOOP_SGL_SEGS			256
+#define FCLOOP_DMABOUND_4G		0xFFFFFFFF
+
+struct nvme_fc_port_template fctemplate = {
+	.localport_delete	= fcloop_localport_delete,
+	.remoteport_delete	= fcloop_remoteport_delete,
+	.create_queue		= fcloop_create_queue,
+	.delete_queue		= fcloop_delete_queue,
+	.ls_req			= fcloop_ls_req,
+	.fcp_io			= fcloop_fcp_req,
+	.ls_abort		= fcloop_ls_abort,
+	.fcp_abort		= fcloop_fcp_abort,
+	.max_hw_queues		= FCLOOP_HW_QUEUES,
+	.max_sgl_segments	= FCLOOP_SGL_SEGS,
+	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
+	.dma_boundary		= FCLOOP_DMABOUND_4G,
+	/* sizes of additional private data for data structures */
+	.local_priv_sz		= sizeof(struct fcloop_lport),
+	.remote_priv_sz		= sizeof(struct fcloop_rport),
+	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
+	.fcprqst_priv_sz	= sizeof(struct fcloop_fcpreq),
+};
+
+struct nvmet_fc_target_template tgttemplate = {
+	.targetport_delete	= fcloop_targetport_delete,
+	.xmt_ls_rsp		= fcloop_xmt_ls_rsp,
+	.fcp_op			= fcloop_fcp_op,
+	.max_hw_queues		= FCLOOP_HW_QUEUES,
+	.max_sgl_segments	= FCLOOP_SGL_SEGS,
+	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
+	.dma_boundary		= FCLOOP_DMABOUND_4G,
+	/* optional features */
+	.target_features	= NVMET_FCTGTFEAT_READDATA_RSP,
+	/* sizes of additional private data for data structures */
+	.target_priv_sz		= sizeof(struct fcloop_tport),
+};
+
+static ssize_t
+fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nvme_fc_port_info pinfo;
+	struct fcloop_ctrl_options *opts;
+	struct nvme_fc_local_port *localport;
+	struct fcloop_lport *lport;
+	int ret;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	ret = fcloop_parse_options(opts, buf);
+	if (ret)
+		goto out_free_opts;
+
+	/* everything there ? */
+	if ((opts->mask & LPORT_OPTS) != LPORT_OPTS) {
+		ret = -EINVAL;
+		goto out_free_opts;
+	}
+
+	pinfo.node_name = opts->wwnn;
+	pinfo.port_name = opts->wwpn;
+	pinfo.port_role = opts->roles;
+	pinfo.port_id = opts->fcaddr;
+
+	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
+	if (!ret) {
+		unsigned long flags;
+
+		/* success */
+		lport = localport->private;
+		lport->localport = localport;
+		INIT_LIST_HEAD(&lport->lport_list);
+
+		spin_lock_irqsave(&fcloop_lock, flags);
+		list_add_tail(&lport->lport_list, &fcloop_lports);
+		spin_unlock_irqrestore(&fcloop_lock, flags);
+
+		/* mark all of the input buffer consumed */
+		ret = count;
+	}
+
+out_free_opts:
+	kfree(opts);
+	return ret ? ret : count;
+}
+
+
+static int
+__delete_local_port(struct fcloop_lport *lport)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&lport->lport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	init_completion(&lport->unreg_done);
+
+	ret = nvme_fc_unregister_localport(lport->localport);
+
+	wait_for_completion(&lport->unreg_done);
+
+	return ret;
+}
+
+static ssize_t
+fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct fcloop_lport *tlport, *lport = NULL;
+	u64 nodename, portname;
+	unsigned long flags;
+	int ret;
+
+	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+
+	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
+		if ((tlport->localport->node_name == nodename) &&
+		    (tlport->localport->port_name == portname)) {
+			lport = tlport;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	if (!lport)
+		return -ENOENT;
+
+	ret = __delete_local_port(lport);
+
+	return ret ? ret : count;
+}
+
+static void
+fcloop_nport_free(struct kref *ref)
+{
+	struct fcloop_nport *nport =
+		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(nport);
+}
+
+static void
+fcloop_nport_put(
+	struct fcloop_nport *nport)
+{
+	kref_put(&nport->ref, fcloop_nport_free);
+}
+
+static int
+fcloop_nport_get(struct fcloop_nport *nport)
+{
+	return kref_get_unless_zero(&nport->ref);
+}
+
+static struct fcloop_nport *
+fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
+{
+	struct fcloop_nport *newnport, *nport = NULL;
+	struct fcloop_lport *tmplport, *lport = NULL;
+	struct fcloop_ctrl_options *opts;
+	unsigned long flags;
+	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
+	int ret;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return NULL;
+
+	ret = fcloop_parse_options(opts, buf);
+	if (ret)
+		goto out_free_opts;
+
+	/* everything there ? */
+	if ((opts->mask & opts_mask) != opts_mask) {
+		ret = -EINVAL;
+		goto out_free_opts;
+	}
+
+	newnport = kzalloc(sizeof(*nport), GFP_KERNEL);
+	if (!newnport)
+		goto out_free_opts;
+
+	INIT_LIST_HEAD(&newnport->nport_list);
+	newnport->node_name = opts->wwnn;
+	newnport->port_name = opts->wwpn;
+	if (opts->mask & NVMF_OPT_ROLES)
+		newnport->port_role = opts->roles;
+	if (opts->mask & NVMF_OPT_FCADDR)
+		newnport->port_id = opts->fcaddr;
+	kref_init(&newnport->ref);
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+
+	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
+		if ((tmplport->localport->node_name == opts->wwnn) &&
+		    (tmplport->localport->port_name == opts->wwpn))
+			goto out_invalid_opts;
+
+		if ((tmplport->localport->node_name == opts->lpwwnn) &&
+		    (tmplport->localport->port_name == opts->lpwwpn))
+			lport = tmplport;
+	}
+
+	if (remoteport) {
+		if (!lport)
+			goto out_invalid_opts;
+		newnport->lport = lport;
+	}
+
+	list_for_each_entry(nport, &fcloop_nports, nport_list) {
+		if ((nport->node_name == opts->wwnn) &&
+		    (nport->port_name == opts->wwpn)) {
+			if ((remoteport && nport->rport) ||
+			    (!remoteport && nport->tport)) {
+				nport = NULL;
+				goto out_invalid_opts;
+			}
+
+			fcloop_nport_get(nport);
+
+			spin_unlock_irqrestore(&fcloop_lock, flags);
+
+			if (remoteport)
+				nport->lport = lport;
+			if (opts->mask & NVMF_OPT_ROLES)
+				nport->port_role = opts->roles;
+			if (opts->mask & NVMF_OPT_FCADDR)
+				nport->port_id = opts->fcaddr;
+			goto out_free_opts;
+		}
+	}
+
+	list_add_tail(&newnport->nport_list, &fcloop_nports);
+
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(opts);
+	return newnport;
+
+out_invalid_opts:
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+	kfree(newnport);
+out_free_opts:
+	kfree(opts);
+	return nport;
+}
+
+static ssize_t
+fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nvme_fc_remote_port *remoteport;
+	struct fcloop_nport *nport;
+	struct fcloop_rport *rport;
+	struct nvme_fc_port_info pinfo;
+	int ret;
+
+	nport = fcloop_alloc_nport(buf, count, true);
+	if (!nport)
+		return -EIO;
+
+	pinfo.node_name = nport->node_name;
+	pinfo.port_name = nport->port_name;
+	pinfo.port_role = nport->port_role;
+	pinfo.port_id = nport->port_id;
+
+	ret = nvme_fc_register_remoteport(nport->lport->localport,
+						&pinfo, &remoteport);
+	if (ret || !remoteport) {
+		fcloop_nport_put(nport);
+		return ret;
+	}
+
+	/* success */
+	rport = remoteport->private;
+	rport->remoteport = remoteport;
+	rport->targetport = (nport->tport) ?  nport->tport->targetport : NULL;
+	if (nport->tport) {
+		nport->tport->remoteport = remoteport;
+		nport->tport->lport = nport->lport;
+	}
+	rport->nport = nport;
+	rport->lport = nport->lport;
+	nport->rport = rport;
+
+	return ret ? ret : count;
+}
+
+
+static int
+__delete_remote_port(struct fcloop_nport *nport)
+{
+	int pnum, ret;
+
+	if (!nport->rport)
+		return -EALREADY;
+
+	pnum = nport->rport->remoteport->port_num;
+
+	init_completion(&nport->rport_unreg_done);
+
+	ret = nvme_fc_unregister_remoteport(nport->rport->remoteport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->rport_unreg_done);
+
+	if (nport->tport)
+		nport->tport->remoteport = NULL;
+	nport->rport = NULL;
+
+	fcloop_nport_put(nport);
+
+	return ret;
+}
+
+static ssize_t
+fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct fcloop_nport *nport = NULL, *tnport;
+	u64 nodename, portname;
+	unsigned long flags;
+	int ret;
+
+	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+
+	list_for_each_entry(tnport, &fcloop_nports, nport_list) {
+		if ((tnport->node_name == nodename) &&
+		    (tnport->port_name == portname) && tnport->rport) {
+			nport = tnport;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	if (!nport)
+		return -ENOENT;
+
+	ret = __delete_remote_port(nport);
+
+	return ret ? ret : count;
+}
+
+static ssize_t
+fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct nvmet_fc_target_port *targetport;
+	struct fcloop_nport *nport;
+	struct fcloop_tport *tport;
+	struct nvmet_fc_port_info tinfo;
+	int ret;
+
+	nport = fcloop_alloc_nport(buf, count, false);
+	if (!nport)
+		return -EIO;
+
+	tinfo.node_name = nport->node_name;
+	tinfo.port_name = nport->port_name;
+	tinfo.port_id = nport->port_id;
+
+	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate, NULL,
+						&targetport);
+	if (ret) {
+		fcloop_nport_put(nport);
+		return ret;
+	}
+
+	/* success */
+	tport = targetport->private;
+	tport->targetport = targetport;
+	tport->remoteport = (nport->rport) ?  nport->rport->remoteport : NULL;
+	if (nport->rport)
+		nport->rport->targetport = targetport;
+	tport->nport = nport;
+	tport->lport = nport->lport;
+	nport->tport = tport;
+
+	return ret ? ret : count;
+}
+
+
+static int
+__delete_target_port(struct fcloop_nport *nport)
+{
+	int pnum, ret;
+
+	if (!nport->tport)
+		return -EALREADY;
+
+	pnum = nport->tport->targetport->port_num;
+
+	init_completion(&nport->tport_unreg_done);
+
+	ret = nvmet_fc_unregister_targetport(nport->tport->targetport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->tport_unreg_done);
+
+	if (nport->rport)
+		nport->rport->targetport = NULL;
+	nport->tport = NULL;
+
+	fcloop_nport_put(nport);
+
+	return ret;
+}
+
+static ssize_t
+fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct fcloop_nport *nport = NULL, *tnport;
+	u64 nodename, portname;
+	unsigned long flags;
+	int ret;
+
+	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+
+	list_for_each_entry(tnport, &fcloop_nports, nport_list) {
+		if ((tnport->node_name == nodename) &&
+		    (tnport->port_name == portname) && tnport->tport) {
+			nport = tnport;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	if (!nport)
+		return -ENOENT;
+
+	ret = __delete_target_port(nport);
+
+	return ret ? ret : count;
+}
+
+
+static DEVICE_ATTR(add_local_port, S_IWUSR, NULL, fcloop_create_local_port);
+static DEVICE_ATTR(del_local_port, S_IWUSR, NULL, fcloop_delete_local_port);
+static DEVICE_ATTR(add_remote_port, S_IWUSR, NULL, fcloop_create_remote_port);
+static DEVICE_ATTR(del_remote_port, S_IWUSR, NULL, fcloop_delete_remote_port);
+static DEVICE_ATTR(add_target_port, S_IWUSR, NULL, fcloop_create_target_port);
+static DEVICE_ATTR(del_target_port, S_IWUSR, NULL, fcloop_delete_target_port);
+
+
+static struct class *fcloop_class;
+static struct device *fcloop_device;
+
+
+static int __init fcloop_init(void)
+{
+	int ret;
+
+	fcloop_class = class_create(THIS_MODULE, "fcloop");
+	if (IS_ERR(fcloop_class)) {
+		pr_err("couldn't register class fcloop\n");
+		ret = PTR_ERR(fcloop_class);
+		return ret;
+	}
+
+	fcloop_device =
+		device_create(fcloop_class, NULL, MKDEV(0, 0), NULL, "ctl");
+	if (IS_ERR(fcloop_device)) {
+		pr_err("couldn't create ctl device!\n");
+		ret = PTR_ERR(fcloop_device);
+		goto out_destroy_class;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_add_local_port);
+	if (ret) {
+		pr_err("couldn't add device add_local_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_del_local_port);
+	if (ret) {
+		pr_err("couldn't add device del_local_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_add_remote_port);
+	if (ret) {
+		pr_err("couldn't add device add_remote_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_del_remote_port);
+	if (ret) {
+		pr_err("couldn't add device del_remote_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_add_target_port);
+	if (ret) {
+		pr_err("couldn't add device add_remote_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	ret = device_create_file(fcloop_device, &dev_attr_del_target_port);
+	if (ret) {
+		pr_err("couldn't add device del_remote_port attr.\n");
+		goto out_destroy_device;
+	}
+
+	return 0;
+
+out_destroy_device:
+	device_destroy(fcloop_class, MKDEV(0, 0));
+out_destroy_class:
+	class_destroy(fcloop_class);
+	return ret;
+}
+
+static void __exit fcloop_exit(void)
+{
+	struct fcloop_lport *lport;
+	struct fcloop_nport *nport;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+
+	for (;;) {
+		nport = list_first_entry_or_null(&fcloop_nports,
+						typeof(*nport), nport_list);
+		if (!nport)
+			break;
+
+		spin_unlock_irqrestore(&fcloop_lock, flags);
+
+		ret = __delete_target_port(nport);
+		if (ret)
+			pr_warn("%s: Failed deleting target port\n", __func__);
+
+		ret = __delete_remote_port(nport);
+		if (ret)
+			pr_warn("%s: Failed deleting remote port\n", __func__);
+
+		spin_lock_irqsave(&fcloop_lock, flags);
+	}
+
+	for (;;) {
+		lport = list_first_entry_or_null(&fcloop_lports,
+						typeof(*lport), lport_list);
+		if (!lport)
+			break;
+
+		spin_unlock_irqrestore(&fcloop_lock, flags);
+
+		ret = __delete_local_port(lport);
+		if (ret)
+			pr_warn("%s: Failed deleting local port\n", __func__);
+
+		spin_lock_irqsave(&fcloop_lock, flags);
+
+	}
+
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	device_destroy(fcloop_class, MKDEV(0, 0));
+	class_destroy(fcloop_class);
+}
+
+module_init(fcloop_init);
+module_exit(fcloop_exit);
+
+MODULE_LICENSE("GPL v2");
+
+
+
-- 
2.5.0
