Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B69CCF2DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KEBsQE+x7Kof6bmFH3KWUFsM7rW7wd5SWkpAlGeyKLU=; b=qW1siv9V7MrFEPaPgZeRhTresD
	Un5ZIAJP/s6a7czV/x1YDu7c1/gskbEEUNiTiEJEqdeeUm8DLBipL8ad1MTWu8ypop9MywCAULw4O
	LoKs0HvbB1EXv6UtjXMx+D1mufNVWvTIqjoViGHTEetP+T2WQYky5i47vgb4qU/w9jXdUTvFSmTlq
	snrH+yxa1qJaMAsB3EbMTdDYV+/mH/l6ocjwphlQjyIHAaM3lCHZj8gdaS6zrC4K9vgv8y7n7E4nK
	KNNQ23ln14afQTQPHy4Syuko9O0YRUL+CrV5hCaOO4QoUueL+dTNhI1ZyZhDq1bEVqNVuoWHuis1w
	BFOEGoBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB6-00000006XnI-1vQH;
	Mon, 19 Oct 2026 03:36:48 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAz-00000006Xfj-2YdD
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380999; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KEBsQE+x7Kof6bmFH3KWUFsM7rW7wd5SWkpAlGeyKLU=;
	b=esc2UZNN1e6rFMoeLFwVwkjitijnA57zb76RgQMmqGtutO1MjtJ7Ajr74b6mYJkOBM/Ba5S7L84xeqU5rC7QhrZ9O+4No+bUoDmfBU16JR9rnX0RM3L85ImvnmvYYqahcJriKQoNWUEvuVZ+TC7eqB5Vgbi4w9k0joh9V3SgSM8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-ZCOP_1792380996;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-ZCOP_1792380996 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:37 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 08/11] nvmet: forward the FDP I/O management commands to the backing device
Date: Mon, 19 Oct 2026 11:36:21 +0800
Message-ID: <20261019033624.402337-9-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203641_872868_AA30BDAC 
X-CRM114-Status: GOOD (  23.00  )
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

Dispatch the I/O Management Receive and Send commands from the I/O
command parser, with the transfer length derived from NUMD and NPID,
respectively, and report both commands as supported in the Commands
Supported and Effects log page.

Both are forwarded to the backing namespace: the data is staged
through a linear kernel buffer, which is what the backend submission
path takes, so the reclaim unit handle status hosts read reflects
the real reclaim units of the backing device, and a Reclaim Unit
Handle Update is carried out by the controller that owns that state.

When the namespace is enabled, learn the backing FDP geometry that
the forwarding needs: the Endurance Group Identifier the backing FDP
state is addressed by, and the placement identifier list of the
Reclaim Unit Handle Status.  The bridge translates placement
identifiers to write streams by their index, so the enable fails
when the backing placement identifiers are not identity mapped.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |   5 +
 drivers/nvme/target/core.c      |  26 ++++-
 drivers/nvme/target/fdp.c       | 177 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  12 +++
 4 files changed, 217 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 93fb9c3d500a3..34492cf02875a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,6 +394,11 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
+	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
+		log->iocs[nvme_cmd_io_mgmt_recv] =
+		log->iocs[nvme_cmd_io_mgmt_send] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
 }
 
 static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4a6444fdfb2f8..70ae2581812bd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1097,9 +1097,22 @@ static u32 nvmet_io_cmd_transfer_len(struct nvmet_req *req)
 		return nvmet_dsm_len(req);
 	case nvme_cmd_zone_mgmt_recv:
 		return (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+	case nvme_cmd_io_mgmt_recv:
+		if (IS_ENABLED(CONFIG_NVME_TARGET_FDP))
+			return (le32_to_cpu(req->cmd->imr.numd) + 1) << 2;
+		break;
+	case nvme_cmd_io_mgmt_send:
+		if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
+			u32 npid = le16_to_cpu(req->cmd->ims.mos);
+
+			return (npid + 1) * sizeof(__le16);
+		}
+		break;
 	default:
-		return 0;
+		break;
 	}
+
+	return 0;
 }
 
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
@@ -1141,6 +1154,17 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 			return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_io_mgmt_recv:
+			req->execute = nvmet_execute_io_mgmt_recv;
+			return 0;
+		case nvme_cmd_io_mgmt_send:
+			req->execute = nvmet_execute_io_mgmt_send;
+			return 0;
+		}
+	}
+
 	switch (req->ns->csi) {
 	case NVME_CSI_NVM:
 		if (req->ns->file)
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
index 0327970a9cb9d..6458efadbcb8e 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -34,6 +34,8 @@ bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
 	return ret;
 }
 
+static int nvmet_fdp_init_backend(struct nvmet_ns *ns);
+
 int nvmet_fdp_init_ns(struct nvmet_ns *ns)
 {
 	struct block_device *bdev = ns->bdev;
@@ -78,8 +80,9 @@ int nvmet_fdp_init_ns(struct nvmet_ns *ns)
 	backend_ns = bdev->bd_disk->private_data;
 	ns->fdp.backend_q = backend_ns->queue;
 	ns->fdp.backend_ctrl = backend_ns->ctrl;
+	ns->fdp.backend_nsid = backend_ns->head->ns_id;
 
-	return 0;
+	return nvmet_fdp_init_backend(ns);
 }
 
 void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
@@ -88,7 +91,6 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
 	ns->fdp.backend_ctrl = NULL;
 }
 
-
 /*
  * Each namespace is its own endurance group, so the Endurance Group
  * Identifier in Command Dword 11, and in the Log Specific Identifier
@@ -160,3 +162,174 @@ u16 nvmet_get_feat_fdp(struct nvmet_req *req)
 	return 0;
 }
 
+
+static u16 nvmet_fdp_io_mgmt_check(struct nvmet_req *req)
+{
+	if (!nvmet_fdp_enabled(req->ns))
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+
+	return 0;
+}
+
+/*
+ * The backend submission path takes a linear kernel buffer, so the
+ * request data is staged through one.
+ */
+static u16 nvmet_fdp_io_mgmt_forward(struct nvmet_req *req, bool recv)
+{
+	struct nvme_command c = {};
+	u16 status = 0;
+	void *buf;
+	int ret;
+
+	buf = kzalloc(req->transfer_len, GFP_KERNEL);
+	if (!buf)
+		return NVME_SC_INTERNAL;
+
+	if (!recv) {
+		status = nvmet_copy_from_sgl(req, 0, buf, req->transfer_len);
+		if (status)
+			goto free;
+	}
+
+	c.common = req->cmd->common;
+	c.common.nsid = cpu_to_le32(req->ns->fdp.backend_nsid);
+	ret = nvme_submit_sync_cmd(req->ns->fdp.backend_q, &c, buf,
+				   req->transfer_len);
+	if (ret) {
+		status = ret > 0 ? ret : NVME_SC_INTERNAL;
+		goto free;
+	}
+
+	if (recv)
+		status = nvmet_copy_to_sgl(req, 0, buf, req->transfer_len);
+free:
+	kfree(buf);
+	return status;
+}
+
+void nvmet_execute_io_mgmt_recv(struct nvmet_req *req)
+{
+	u16 status;
+
+	status = nvmet_fdp_io_mgmt_check(req);
+	if (status)
+		goto out;
+
+	if (req->cmd->imr.mo != NVME_IO_MGMT_RECV_MO_RUHS) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	status = nvmet_fdp_io_mgmt_forward(req, true);
+out:
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
+{
+	u16 status;
+
+	status = nvmet_fdp_io_mgmt_check(req);
+	if (status)
+		goto out;
+
+	if (req->cmd->ims.mo != NVME_IO_MGMT_SEND_MO_RUH_UPDATE) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	status = nvmet_fdp_io_mgmt_forward(req, false);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static int nvmet_fdp_backend_identify(struct nvmet_ns *ns,
+		struct nvme_id_ns *id)
+{
+	struct nvme_command c = {};
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(ns->fdp.backend_nsid);
+	c.identify.cns = NVME_ID_CNS_NS;
+
+	return nvme_submit_sync_cmd(ns->fdp.backend_ctrl->admin_q, &c, id,
+				    sizeof(*id));
+}
+
+static int nvmet_fdp_backend_ruhs(struct nvmet_ns *ns,
+				  struct nvme_fdp_ruh_status *st)
+{
+	size_t len = struct_size(st, ruhsd, ns->fdp.nruh);
+	struct nvme_command c = {};
+
+	c.imr.opcode = nvme_cmd_io_mgmt_recv;
+	c.imr.nsid = cpu_to_le32(ns->fdp.backend_nsid);
+	c.imr.mo = NVME_IO_MGMT_RECV_MO_RUHS;
+	c.imr.numd = cpu_to_le32(nvme_bytes_to_numd(len));
+
+	return nvme_submit_sync_cmd(ns->fdp.backend_q, &c, st, len);
+}
+
+/*
+ * Learn the FDP geometry of the backing NVMe namespace: the
+ * Endurance Group Identifier its FDP state is addressed by, and the
+ * placement identifier list of the Reclaim Unit Handle Status.  The
+ * placement translation relies on the identity mapping, so the
+ * enable fails when the backing geometry deviates from it.
+ */
+static int nvmet_fdp_init_backend(struct nvmet_ns *ns)
+{
+	struct nvme_fdp_ruh_status *st;
+	struct nvme_id_ns *id;
+	int ret, i;
+
+	id = kzalloc_obj(*id, GFP_KERNEL);
+	if (!id)
+		return -ENOMEM;
+
+	ret = nvmet_fdp_backend_identify(ns, id);
+	if (ret) {
+		pr_err("the ns:%u backing identify failed: %d\n",
+		       ns->nsid, ret);
+		goto free_id;
+	}
+
+	ns->fdp.backend_endgid = le16_to_cpu(id->endgid);
+
+	st = kzalloc(struct_size(st, ruhsd, ns->fdp.nruh), GFP_KERNEL);
+	if (!st) {
+		ret = -ENOMEM;
+		goto free_id;
+	}
+
+	ret = nvmet_fdp_backend_ruhs(ns, st);
+	if (ret) {
+		pr_err("the ns:%u backing reclaim unit handle status failed: %d\n",
+		       ns->nsid, ret);
+		goto free_st;
+	}
+
+	if (le16_to_cpu(st->nruhsd) < ns->fdp.nruh) {
+		pr_err("the ns:%u backing reports fewer handles than write streams\n",
+		       ns->nsid);
+		ret = -EINVAL;
+		goto free_st;
+	}
+
+	for (i = 0; i < ns->fdp.nruh; i++) {
+		if (le16_to_cpu(st->ruhsd[i].pid) != i) {
+			pr_err("the ns:%u backing placement identifiers are not identity mapped\n",
+			       ns->nsid);
+			ret = -EINVAL;
+			goto free_st;
+		}
+	}
+
+free_st:
+	kfree(st);
+free_id:
+	kfree(id);
+	return ret;
+}
+
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e95bafe1fb019..037c3862062ab 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -103,6 +103,8 @@ struct nvmet_fdp {
 	u64			runs;
 	struct request_queue	*backend_q;
 	struct nvme_ctrl	*backend_ctrl;
+	u32			backend_nsid;
+	u16			backend_endgid;
 };
 
 struct nvmet_ns {
@@ -999,6 +1001,8 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
 bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys);
 u16 nvmet_set_feat_fdp(struct nvmet_req *req);
 u16 nvmet_get_feat_fdp(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1023,6 +1027,14 @@ static inline u16 nvmet_get_feat_fdp(struct nvmet_req *req)
 {
 	return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 }
+static inline void nvmet_execute_io_mgmt_recv(struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
+static inline void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
+{
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
+}
 #endif
 
 /*
-- 
2.43.7


