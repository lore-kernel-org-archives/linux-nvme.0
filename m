Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DA606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hqreXZ2E;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FONW3Zc1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jZxZ3AJ0EZZ7yl/rbh3wt6v4IwuFTYOa4uoE+pDd0y0=; b=hqreXZ2EO7uHSu
	egg6+JwNDmFoqbLjyn0tH0fxFWMt724Hd8V2FC9BbUB06rqEOMGAmiqLm1x7mQLPFEegdKupQUn3w
	+OK4qIIetyWqiXjnIy/xd0zu2Z+ERWho5IKXl5Ls4C4yFcznAUxUBM9ZQElaNOMuwp5ZhiwE50mqT
	xANtsVvFAGD7/wI2W0wfWGkAQjJsKZGLSoJT+JWmWhkLqXh6M9KuRn22j3wyyLr+j7V4WQ7UQfjuJ
	zIQl7WUlwibraGOjjhzgnJar98Jw7jHzaEgNrvFwpHby5nAprrDwqmaM16dKATvS1uDee6YX6iY9o
	v+ur4gW1tREsiNkcd+Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPG2-000000099WD-1Ile;
	Thu, 29 Oct 2026 12:29:26 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFx-000000099Gt-3pQG
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276957; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jZxZ3AJ0EZZ7yl/rbh3wt6v4IwuFTYOa4uoE+pDd0y0=;
	b=FONW3Zc18aBJdvthjnIeaiK08PBfE5sei7cgat7QIlMupi5ykOaHI/RjWpSQEBk9GT+YhACJXdBW/mIyc1DfnaoJFg4L2CU3NknSsK80s6VlDRtEC+8PPe13YF1AsL64ZXZ6/U/fF3CO5AJ8cnGBXlghcr+PexU1/dC979H7nAM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjUB78_1793276956;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjUB78_1793276956 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:16 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 09/12] nvmet: forward the FDP I/O management commands to the backing device
Date: Thu, 29 Oct 2026 20:28:30 +0800
Message-ID: <20261029122833.284572-10-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052922_689541_D9C948FE 
X-CRM114-Status: GOOD (  31.48  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The enable also reads the backing FDP configurations log page, so
that the reclaim unit nominal size and the handle types presented
to hosts are the values of the backing device itself, and the
Commands Supported and Effects advertisement of the new opcodes is
limited to subsystems that actually bridge FDP.

The FDP command handlers run from a workqueue, since lpfc can invoke
the execute callbacks in hardirq context, and the backing geometry is
read from the active FDP configuration selected by FDPCIDX rather
than from the first descriptor of the configurations log.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |  17 +-
 drivers/nvme/target/core.c      |  27 ++-
 drivers/nvme/target/fdp.c       | 370 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  10 +
 4 files changed, 418 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6d0b1df3ae96..523083eb0cee 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -381,7 +381,8 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
-static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
+static void nvmet_get_cmd_effects_nvm(struct nvmet_req *req,
+				      struct nvme_effects_log *log)
 {
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
@@ -394,6 +395,16 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC);
+	/*
+	 * This log page has no namespace context (req->ns is always
+	 * NULL), so the advertisement can only follow the subsystem-wide
+	 * FDP state, just like FDPS and the Features log page.
+	 */
+	if (nvmet_req_subsys(req)->nr_ns_fdp_enabled) {
+		log->iocs[nvme_cmd_io_mgmt_recv] =
+		log->iocs[nvme_cmd_io_mgmt_send] =
+			cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+	}
 }
 
 static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
@@ -420,7 +431,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
 		nvmet_get_cmd_effects_admin(ctrl, log);
-		nvmet_get_cmd_effects_nvm(log);
+		nvmet_get_cmd_effects_nvm(req, log);
 		break;
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -428,7 +439,7 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 			goto free;
 		}
 		nvmet_get_cmd_effects_admin(ctrl, log);
-		nvmet_get_cmd_effects_nvm(log);
+		nvmet_get_cmd_effects_nvm(req, log);
 		nvmet_get_cmd_effects_zns(log);
 		break;
 	default:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14e2a908857c..2bae9ee86611 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1114,9 +1114,22 @@ static u32 nvmet_io_cmd_transfer_len(struct nvmet_req *req)
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
@@ -1158,6 +1171,17 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 			return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP)) {
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_io_mgmt_recv:
+			req->execute = nvmet_execute_io_mgmt_recv;
+			goto check_pr;
+		case nvme_cmd_io_mgmt_send:
+			req->execute = nvmet_execute_io_mgmt_send;
+			goto check_pr;
+		}
+	}
+
 	switch (req->ns->csi) {
 	case NVME_CSI_NVM:
 		if (req->ns->file)
@@ -1177,6 +1201,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (ret)
 		return ret;
 
+check_pr:
 	if (req->ns->pr.enable) {
 		ret = nvmet_pr_check_cmd_access(req);
 		if (ret)
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
index ae23a6078745..f615b2bdc3d6 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
 #include <linux/nvme.h>
+#include <linux/sizes.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -16,10 +17,20 @@
 #define NVME_FDP_CDW12_FDPE			(1U << 0)
 #define NVME_FDP_CDW12_FDPCIDX_MASK		(0xffU << 8)
 
+/*
+ * Commands and log pages are staged through a kernel buffer, so bound
+ * the host requested transfer size.  The defined responses are small:
+ * even a RUH Status with 255 handles is only about 8 KiB.
+ */
+#define NVMET_FDP_MAX_TRANSFER_SIZE		SZ_1M
+
+static int nvmet_fdp_init_backend(struct nvmet_ns *ns);
+
 int nvmet_fdp_init_ns(struct nvmet_ns *ns)
 {
 	struct block_device *bdev = ns->bdev;
 	struct nvme_ns *backend_ns;
+	int ret;
 
 	if (!bdev) {
 		pr_err("the ns:%u has no block device for FDP\n", ns->nsid);
@@ -60,8 +71,13 @@ int nvmet_fdp_init_ns(struct nvmet_ns *ns)
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
@@ -70,7 +86,6 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
 	ns->fdp.backend_ctrl = NULL;
 }
 
-
 /*
  * Each namespace is its own endurance group, so the Endurance Group
  * Identifier in Command Dword 11, and in the Log Specific Identifier
@@ -176,3 +191,354 @@ u16 nvmet_get_feat_fdp(struct nvmet_req *req)
 	percpu_ref_put(&ns->ref);
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
+struct nvmet_fdp_work {
+	struct work_struct work;
+	struct nvmet_req *req;
+	void (*execute)(struct nvmet_req *req);
+};
+
+static void nvmet_fdp_work_fn(struct work_struct *work)
+{
+	struct nvmet_fdp_work *w = container_of(work, struct nvmet_fdp_work,
+						work);
+
+	w->execute(w->req);
+	kfree(w);
+}
+
+/*
+ * lpfc can invoke the execute callbacks in hardirq context, and the FDP
+ * handlers allocate memory and wait for backing commands to complete.
+ * Defer them to a workqueue, which also keeps the other transports
+ * unchanged in behavior.
+ */
+static void nvmet_fdp_defer(struct nvmet_req *req,
+			    void (*execute)(struct nvmet_req *req))
+{
+	struct nvmet_fdp_work *w;
+
+	w = kmalloc_obj(*w, GFP_ATOMIC);
+	if (!w) {
+		nvmet_req_complete(req, NVME_SC_INTERNAL);
+		return;
+	}
+	INIT_WORK(&w->work, nvmet_fdp_work_fn);
+	w->req = req;
+	w->execute = execute;
+	queue_work(nvmet_wq, &w->work);
+}
+
+static void nvmet_fdp_io_mgmt_recv_work(struct nvmet_req *req)
+{
+	size_t len = ((u64)le32_to_cpu(req->cmd->imr.numd) + 1) << 2;
+	u16 status;
+
+	status = nvmet_fdp_io_mgmt_check(req);
+	if (status)
+		goto out;
+
+	/* NUMD is 32 bit, do not let the length arithmetic wrap */
+	if (len > NVMET_FDP_MAX_TRANSFER_SIZE) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	if (!nvmet_check_transfer_len(req, len))
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
+void nvmet_execute_io_mgmt_recv(struct nvmet_req *req)
+{
+	nvmet_fdp_defer(req, nvmet_fdp_io_mgmt_recv_work);
+}
+
+static void nvmet_fdp_io_mgmt_send_work(struct nvmet_req *req)
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
+void nvmet_execute_io_mgmt_send(struct nvmet_req *req)
+{
+	nvmet_fdp_defer(req, nvmet_fdp_io_mgmt_send_work);
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
+static int nvmet_fdp_backend_configs(struct nvmet_ns *ns,
+				     struct nvme_fdp_config_log *log,
+				     size_t len)
+{
+	u32 numd = nvme_bytes_to_numd(len);
+	struct nvme_command c = {};
+
+	c.get_log_page.opcode = nvme_admin_get_log_page;
+	c.get_log_page.nsid = cpu_to_le32(0);
+	c.get_log_page.lid = NVME_LOG_FDP_CONFIGS;
+	c.get_log_page.lsi = cpu_to_le16(ns->fdp.backend_endgid);
+	c.get_log_page.numdl = cpu_to_le16(numd);
+	c.get_log_page.numdu = cpu_to_le16(numd >> 16);
+
+	return nvme_submit_sync_cmd(ns->fdp.backend_ctrl->admin_q, &c, log,
+				    len);
+}
+
+static int nvmet_fdp_backend_get_feat(struct nvmet_ns *ns,
+				      struct nvme_fdp_config *fdp)
+{
+	return nvme_get_features(ns->fdp.backend_ctrl, NVME_FEAT_FDP,
+				 ns->fdp.backend_endgid, NULL, 0, fdp);
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
+	struct nvme_fdp_config_desc *desc;
+	struct nvme_fdp_config_log *log;
+	struct nvme_fdp_ruh_status *st;
+	struct nvme_fdp_config fdp;
+	struct nvme_id_ns *id;
+	size_t dsze, total;
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
+	if (le16_to_cpu(st->nruhsd) != ns->fdp.nruh) {
+		pr_err("the ns:%u backing handle count mismatch\n", ns->nsid);
+		ret = -EINVAL;
+		goto free_st;
+	}
+
+	for (i = 0; i < ns->fdp.nruh; i++) {
+		if (le16_to_cpu(st->ruhsd[i].pid) != i) {
+			pr_err("the ns:%u backing pids are not identity mapped\n",
+			       ns->nsid);
+			ret = -EINVAL;
+			goto free_st;
+		}
+	}
+
+	/*
+	 * Take the configuration the host is presented with from the
+	 * backing device itself: the nominal reclaim unit size is 64 bit
+	 * there, and the handle types must not be invented.  The active
+	 * configuration is selected by FDPCIDX, not by descriptor order.
+	 */
+	ret = nvmet_fdp_backend_get_feat(ns, &fdp);
+	if (ret) {
+		pr_err("the ns:%u backing get FDP feature failed: %d\n",
+		       ns->nsid, ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto free_st;
+	}
+	if (!(fdp.flags & FDPCFG_FDPE)) {
+		pr_err("the ns:%u backing FDP is not enabled\n", ns->nsid);
+		ret = -EINVAL;
+		goto free_st;
+	}
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		ret = -ENOMEM;
+		goto free_st;
+	}
+	ret = nvmet_fdp_backend_configs(ns, log, sizeof(*log));
+	if (ret) {
+		pr_err("the ns:%u backing FDP configurations failed: %d\n",
+		       ns->nsid, ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto free_log;
+	}
+
+	total = le32_to_cpu(log->sze);
+	kfree(log);
+	if (total < sizeof(*log) + sizeof(*desc) ||
+	    total > NVMET_FDP_MAX_TRANSFER_SIZE) {
+		ret = -EINVAL;
+		goto free_st;
+	}
+	log = kzalloc(total, GFP_KERNEL);
+	if (!log) {
+		ret = -ENOMEM;
+		goto free_st;
+	}
+	ret = nvmet_fdp_backend_configs(ns, log, total);
+	if (ret) {
+		pr_err("the ns:%u backing FDP configurations failed: %d\n",
+		       ns->nsid, ret);
+		ret = ret < 0 ? ret : -EIO;
+		goto free_log;
+	}
+
+	desc = (void *)(log + 1);
+	for (i = 0; i < fdp.fdpcidx; i++) {
+		if ((void *)desc + sizeof(*desc) > (void *)log + total) {
+			ret = -EINVAL;
+			goto free_log;
+		}
+		if ((void *)desc + le16_to_cpu(desc->dsze) >
+		    (void *)log + total) {
+			ret = -EINVAL;
+			goto free_log;
+		}
+		desc = (void *)desc + le16_to_cpu(desc->dsze);
+	}
+
+	if ((void *)desc + sizeof(*desc) > (void *)log + total) {
+		ret = -EINVAL;
+		goto free_log;
+	}
+
+	dsze = ALIGN(struct_size(desc, ruhs, ns->fdp.nruh), 8);
+	if ((void *)desc + dsze > (void *)log + total) {
+		ret = -EINVAL;
+		goto free_log;
+	}
+	if (le16_to_cpu(desc->dsze) < dsze ||
+	    le16_to_cpu(desc->nruh) != ns->fdp.nruh) {
+		pr_err("the ns:%u backing FDP configuration is inconsistent\n",
+		       ns->nsid);
+		ret = -EINVAL;
+		goto free_log;
+	}
+
+	ns->fdp.runs = le64_to_cpu(desc->runs);
+	for (i = 0; i < ns->fdp.nruh; i++)
+		ns->fdp.ruht[i] = desc->ruhs[i].ruht;
+
+free_log:
+	kfree(log);
+free_st:
+	kfree(st);
+free_id:
+	kfree(id);
+	return ret;
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5620492dd431..0a20c22b0b23 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1006,6 +1006,8 @@ int nvmet_fdp_init_ns(struct nvmet_ns *ns);
 void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
 u16 nvmet_set_feat_fdp(struct nvmet_req *req);
 u16 nvmet_get_feat_fdp(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
+void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1026,6 +1028,14 @@ static inline u16 nvmet_get_feat_fdp(struct nvmet_req *req)
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


