Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C532C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2lPnJeMt1jv8RApap2bpZNnl5pGv16UZ7yqXpC4biO0=; b=c5i2v2Nap639dL/AyYEnGktecn
	m6ocqyk6pJ1G1lB2kOqJ+za+IZEPqiUe8wIj4iBbqEdE/VTcagKweNtOC3MkD2UvfQoqiLQG9nPGt
	GdBZKiGNvISdneFLGpP2nLVoxlOrVdPf42eSdRxQQ1qMYOhjb/afUjMgf3aiKS4tiGFSFOrI7Ukiv
	Pgo+WQtWSsfa+eBrczTMpjrTDfEes6sn4fOw/uqPRzdCmfgwIiJ21UAmQCL2IaxNtYlqLCxQUm0s7
	2gYqcfx7dQB0MaV2g40ydw2UQSAElBJvmjDgup/cc7OKdSAilFEUPMSgeN2SFxuJDN/fF5cLVVa/A
	o9cCiUmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8x-00000005s66-40cK;
	Fri, 10 May 2024 16:30:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8s-00000005s2m-2nBU
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lPnJeMt1jv8RApap2bpZNnl5pGv16UZ7yqXpC4biO0=;
	b=R/ztE4QH/0Av2fnLNrND/suNWl2yMyDa+pBFygP8R4YFj7qUpm5U/JFNqjW/0ZG1QLw1Qa
	vMzdUzABZAOcrTVqQgtzQHn7peSKKaOoDTaP/zsb5xmzqcB2eLmd1jX/cu3Iw4CfON7w5w
	pkIVuRUhyGmWRw2nH/GtmXx+Nn9DnaQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-vIJIfXaCOmGuudp5tFl3PA-1; Fri,
 10 May 2024 12:30:39 -0400
X-MC-Unique: vIJIfXaCOmGuudp5tFl3PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38FDA29AC03C;
	Fri, 10 May 2024 16:30:39 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16FD3200A380;
	Fri, 10 May 2024 16:30:36 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [donotmerge PATCH 5/5] nvmet: target support for cancel commands
Date: Fri, 10 May 2024 18:30:26 +0200
Message-Id: <20240510163026.786898-6-mlombard@redhat.com>
In-Reply-To: <20240510163026.786898-1-mlombard@redhat.com>
References: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093042_941368_735BBD75 
X-CRM114-Status: GOOD (  27.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is just a target patch that I used to do some basic tests of the host
Cancel patchset.

This is not intended to be merged.

It's loosely based on LIO's iSCSI driver code, it keeps a list of
outstanding commands and scans it when cancel is requested,
it then marks the request as aborted and the nvmet_req_complete
callback sets the NVME_SC_ABORT_REQ code in the status.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/Makefile        |  2 +-
 drivers/nvme/target/admin-cmd.c     | 36 +++++++++++++
 drivers/nvme/target/core.c          | 45 ++++++++++++++++
 drivers/nvme/target/io-cmd-cancel.c | 81 +++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c   | 19 +++++++
 drivers/nvme/target/nvmet.h         | 10 ++++
 6 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/io-cmd-cancel.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index c66820102493..6541808579ae 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o io-cmd-cancel.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f5b7054a4a05..f5640745efe7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,6 +176,7 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
+	log->iocs[nvme_cmd_cancel] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
@@ -736,8 +737,43 @@ static void nvmet_execute_identify(struct nvmet_req *req)
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
 {
+	u16 cid;
+	__le16 sqid;
+	unsigned long flags;
+	struct nvmet_sq *sq;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_req *r, *next;
+
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
+
+	cid  = req->cmd->abort.cid;
+	sqid = le16_to_cpu(req->cmd->abort.sqid);
+	if (sqid > ctrl->subsys->max_qid) {
+		/* Invalid queue id */
+		goto error;
+	}
+
+	sq = ctrl->sqs[sqid];
+	if (!sq)
+		goto error;
+
+	spin_lock_irqsave(&sq->state_lock, flags);
+	list_for_each_entry_safe(r, next, &sq->state_list, state_list) {
+		if (cid != r->cmd->common.command_id)
+			continue;
+
+		if (r == req) {
+			/* Abort command can't abort itself */
+			continue;
+		}
+
+		nvmet_req_abort(r);
+		break;
+	}
+	spin_unlock_irqrestore(&sq->state_lock, flags);
+
+error:
 	nvmet_set_result(req, 1);
 	nvmet_req_complete(req, 0);
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e06013c5dace..7b0d59d1e673 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -772,12 +772,33 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	struct nvmet_sq *sq = req->sq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sq->state_lock, flags);
+
+	if (unlikely(req->aborted))
+		status = NVME_SC_ABORT_REQ;
+	else
+		list_del(&req->state_list);
+
+	spin_unlock_irqrestore(&sq->state_lock, flags);
 
 	__nvmet_req_complete(req, status);
 	percpu_ref_put(&sq->ref);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_complete);
 
+void nvmet_req_abort(struct nvmet_req *req)
+{
+	lockdep_assert_held(&req->sq->state_lock);
+
+	if (req->abort)
+		req->abort(req);
+
+	req->aborted = true;
+	list_del_init(&req->state_list);
+}
+
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 		u16 qid, u16 size)
 {
@@ -818,6 +839,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	percpu_ref_exit(&sq->ref);
 	nvmet_auth_sq_free(sq);
 
+	WARN_ON_ONCE(!list_empty(&sq->state_list));
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
@@ -851,6 +874,8 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 	}
 	init_completion(&sq->free_done);
 	init_completion(&sq->confirm_done);
+	INIT_LIST_HEAD(&sq->state_list);
+	spin_lock_init(&sq->state_lock);
 	nvmet_auth_sq_init(sq);
 
 	return 0;
@@ -904,6 +929,12 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
+	if (req->cmd->common.opcode == nvme_cmd_cancel) {
+		req->execute = nvmet_execute_cancel;
+		if (req->cmd->cancel.nsid == NVME_NSID_ALL)
+			return 0;
+	}
+
 	ret = nvmet_req_find_ns(req);
 	if (unlikely(ret))
 		return ret;
@@ -937,6 +968,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops)
 {
 	u8 flags = req->cmd->common.flags;
+	unsigned long sflags;
 	u16 status;
 
 	req->cq = cq;
@@ -953,6 +985,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->ns = NULL;
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
+	req->aborted = false;
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
@@ -993,6 +1026,12 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (sq->ctrl)
 		sq->ctrl->reset_tbkas = true;
 
+	INIT_LIST_HEAD(&req->state_list);
+
+	spin_lock_irqsave(&sq->state_lock, sflags);
+	list_add_tail(&req->state_list, &sq->state_list);
+	spin_unlock_irqrestore(&sq->state_lock, sflags);
+
 	return true;
 
 fail:
@@ -1003,6 +1042,12 @@ EXPORT_SYMBOL_GPL(nvmet_req_init);
 
 void nvmet_req_uninit(struct nvmet_req *req)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&req->sq->state_lock, flags);
+	list_del(&req->state_list);
+	spin_unlock_irqrestore(&req->sq->state_lock, flags);
+
 	percpu_ref_put(&req->sq->ref);
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
diff --git a/drivers/nvme/target/io-cmd-cancel.c b/drivers/nvme/target/io-cmd-cancel.c
new file mode 100644
index 000000000000..35d0eaa7f707
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-cancel.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe I/O cancel command implementation.
+ * Copyright (c) 2023 Red Hat
+ */
+
+#include "nvmet.h"
+
+void nvmet_execute_cancel(struct nvmet_req *req)
+{
+	u16 cid;
+	__le16 sqid;
+	__le32 nsid;
+	struct nvmet_sq *sq;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_req *r, *next;
+	unsigned long flags;
+	int ret = 0;
+	u16 imm_abrts = 0;
+	u16 def_abrts = 0;
+	bool mult_cmds;
+
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
+
+	cid  = req->cmd->cancel.cid;
+	sqid = le16_to_cpu(req->cmd->cancel.sqid);
+	nsid = le32_to_cpu(req->cmd->cancel.nsid);
+	mult_cmds = req->cmd->cancel.action & NVME_CANCEL_ACTION_MUL_CMD;
+
+	if (sqid > ctrl->subsys->max_qid) {
+		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto error;
+	}
+
+	sq = req->sq;
+
+	if (cid == req->cmd->cancel.command_id && !mult_cmds) {
+		ret = NVME_SC_INVALID_CID | NVME_SC_DNR;
+		goto error;
+	} else if ((cid != 0xFFFF && mult_cmds) || sqid != sq->qid) {
+		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto error;
+	}
+
+	spin_lock_irqsave(&sq->state_lock, flags);
+	list_for_each_entry_safe(r, next, &sq->state_list, state_list) {
+		if (r == req) {
+			/* Cancel command can't abort itself */
+			continue;
+		}
+
+		if (mult_cmds) {
+			if (r->cmd->common.nsid != NVME_NSID_ALL &&
+			    r->cmd->common.nsid != nsid) {
+				continue;
+			}
+
+			nvmet_req_abort(r);
+			def_abrts++;
+		} else {
+			if (cid != r->cmd->common.command_id)
+				continue;
+
+			if (nsid != NVME_NSID_ALL && nsid != r->cmd->common.nsid) {
+				ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+				break;
+			}
+
+			nvmet_req_abort(r);
+			def_abrts++;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&sq->state_lock, flags);
+
+error:
+	nvmet_set_result(req, (def_abrts << 16) | imm_abrts);
+	nvmet_req_complete(req, ret);
+}
+
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..f01033481718 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -330,6 +330,21 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static void nvmet_file_abort_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+
+	nvmet_req_complete(req, NVME_SC_ABORT_REQ);
+}
+
+static void nvmet_file_cancel_work(struct nvmet_req *req)
+{
+	if (cancel_work(&req->f.work)) {
+		INIT_WORK(&req->f.work, nvmet_file_abort_work);
+		queue_work(nvmet_wq, &req->f.work);
+	}
+}
+
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -366,15 +381,19 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_file_execute_rw;
+		req->abort   = nvmet_file_cancel_work;
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_file_execute_flush;
+		req->abort   = nvmet_file_cancel_work;
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_file_execute_dsm;
+		req->abort   = nvmet_file_cancel_work;
 		return 0;
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
+		req->abort   = nvmet_file_cancel_work;
 		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c1306de1f4dd..777c35d4c6f0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -124,6 +124,9 @@ struct nvmet_sq {
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
+
+	spinlock_t		state_lock;
+	struct list_head	state_list;
 };
 
 struct nvmet_ana_group {
@@ -400,12 +403,16 @@ struct nvmet_req {
 	struct nvmet_port	*port;
 
 	void (*execute)(struct nvmet_req *req);
+	void (*abort)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
 
 	struct pci_dev		*p2p_dev;
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+
+	struct list_head	state_list;
+	bool			aborted;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
@@ -468,12 +475,15 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_io_cmd(struct nvmet_req *req);
 
+void nvmet_execute_cancel(struct nvmet_req *req);
+
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
+void nvmet_req_abort(struct nvmet_req *req);
 int nvmet_req_alloc_sgls(struct nvmet_req *req);
 void nvmet_req_free_sgls(struct nvmet_req *req);
 
-- 
2.39.3


