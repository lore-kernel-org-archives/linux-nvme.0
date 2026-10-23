Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D2606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d29fm2bl;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ao+iZ5uS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kz+HO152bXh6IpXSH6ojHXcgbmzoYOidbG+ikRMQHGs=; b=d29fm2blgLFxFA
	1pMv63Zp9UHcdjLbhw7v2W08EXKn39tIMYGNkiQqPTNt488ISW13w+5GYiqyJRfw50pR95/dv8DHg
	wnFEln65oiD6IDmeVlymc8ZdxeugDI5fW44gnBogDQcCFKHAB3RAB93EYS4VcnCY+Rl5yAuJAe449
	WD7IChr8ZG/Ob5u2IgM6BjKx+XyMolEtyLT8ZpEVAQFszj1Z5LnTGrcSRksaq2naQfDbSCfk3kbgv
	mv8Iw8hvX4w0RvbDTNPh9iW7RKHsnI0V7SvbP6QxxfybTZukYhz/rutzRQTXzF77m1ntzviWnpyvC
	0BCRK0lwphzxDw02VCbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFB-0000000Fqtm-3Id1;
	Fri, 23 Oct 2026 08:03:17 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF4-0000000FqlI-0XGV
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kz+HO152bXh6IpXSH6ojHXcgbmzoYOidbG+ikRMQHGs=;
	b=Ao+iZ5uSjvbQgwxujUH7M1bsW4V1QNsAfe7kJLBa+qsQCsjVv5a+dsAXNCCJMN5cIBcHUGQV0i0tzjJ2YRHo6QjLCaKb1Cldw2XLWVeto4GLrf44TfQp0GECfKu5BdV68NFarTySj0byUZvXIpsS+JfqZYi9GHJ7LIMPU16l7Qc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLXpdI_1792742587;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLXpdI_1792742587 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:07 +0800
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
Date: Fri, 23 Oct 2026 16:02:48 +0800
Message-ID: <20261023080251.2606443-9-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010311_719992_3959137B 
X-CRM114-Status: GOOD (  24.88  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dispatch the I/O Management Receive and Send commands from the I/O
command parser, after the persistent reservation checks so that the
commands go through the same access path as the other I/O commands,
with the transfer length derived from NUMD and NPID, respectively,
and report both commands as supported in the Commands Supported and
Effects log page.  The transfer length encoded in the command is
verified against the length the host actually supplied, so that the
forwarded command cannot carry a length that disagrees with the data
buffer.

Both are forwarded to the backing namespace: the data is staged
through a linear kernel buffer, which is what the backend submission
path takes, so the reclaim unit handle status hosts read reflects
the real reclaim units of the backing device, and a Reclaim Unit
Handle Update is carried out by the controller that owns that state.
The host data pointer is not carried over to the backing command.

When the namespace is enabled, learn the backing FDP geometry that
the forwarding needs: the Endurance Group Identifier the backing FDP
state is addressed by, and the placement identifier list of the
Reclaim Unit Handle Status.  The bridge translates placement
identifiers to write streams by their index, so the enable fails
when the backing placement identifiers are not identity mapped.
The backing command failures are reported as errno; the NVMe status
of the backing controller is logged but not propagated, as the
enable path may only fail with a negative error.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |   5 +
 drivers/nvme/target/core.c      |  26 ++++-
 drivers/nvme/target/fdp.c       | 193 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  12 ++
 4 files changed, 233 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8062f7e59f561..72606c0eeefd9 100644
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
index 14f55631cf502..cdf5a4c183edd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1110,9 +1110,22 @@ static u32 nvmet_io_cmd_transfer_len(struct nvmet_req *req)
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
@@ -1154,6 +1167,17 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
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
index 5008294984885..807f54c73c4e1 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -34,10 +34,13 @@ bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
 	return ret;
 }
 
+static int nvmet_fdp_init_backend(struct nvmet_ns *ns);
+
 int nvmet_fdp_init_ns(struct nvmet_ns *ns)
 {
 	struct block_device *bdev = ns->bdev;
 	struct nvme_ns *backend_ns;
+	int ret;
 
 	if (!bdev) {
 		pr_err("the ns:%u has no block device for FDP\n", ns->nsid);
@@ -78,8 +81,13 @@ int nvmet_fdp_init_ns(struct nvmet_ns *ns)
 	backend_ns = bdev->bd_disk->private_data;
 	ns->fdp.backend_q = backend_ns->queue;
 	ns->fdp.backend_ctrl = backend_ns->ctrl;
+	ns->fdp.backend_nsid = backend_ns->head->ns_id;
 
-	return 0;
+	ret = nvmet_fdp_init_backend(ns);
+	if (ret)
+		nvmet_fdp_exit_ns(ns);
+
+	return ret;
 }
 
 void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
@@ -88,7 +96,6 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
 	ns->fdp.backend_ctrl = NULL;
 }
 
-
 /*
  * Each namespace is its own endurance group, so the Endurance Group
  * Identifier in Command Dword 11, and in the Log Specific Identifier
@@ -166,3 +173,185 @@ u16 nvmet_get_feat_fdp(struct nvmet_req *req)
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
+	c.common.dptr = (union nvme_data_ptr){};
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
+	if (!nvmet_check_transfer_len(req,
+			(le32_to_cpu(req->cmd->imr.numd) + 1) << 2))
+		return;
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
+	if (!nvmet_check_transfer_len(req,
+			(le16_to_cpu(req->cmd->ims.mos) + 1) * sizeof(__le16)))
+		return;
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
+		ret = ret < 0 ? ret : -EIO;
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
+		ret = ret < 0 ? ret : -EIO;
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
index 94cea9dcf0f74..c86fb2c19c152 100644
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
@@ -1003,6 +1005,8 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
 bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys);
 u16 nvmet_set_feat_fdp(struct nvmet_req *req);
 u16 nvmet_get_feat_fdp(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1027,6 +1031,14 @@ static inline u16 nvmet_get_feat_fdp(struct nvmet_req *req)
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


