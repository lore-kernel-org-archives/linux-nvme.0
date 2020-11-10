Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9811CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21C4206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dg5fQACp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kw36mVMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21C4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B/vAsVEV1rbgodKXiA/6Htz7vOTBxHMfBtveXLhgLt4=; b=Dg5fQACpsV9kFPuPCSZ4TFE65
	hykVhoC2LSxGNVSgBCJUFKtqZqLMIYO6zymkgp9kd6UtD2+ikudMd/hibbpp2KHzEfKudZcskGV8p
	GXr4ccusr7gmX9GCc2UKXGtIvJtK9fyD1EoxzHb6+AGZ5/dtptInXTMW1+pYXRXvGrjZALCEmSIRR
	gETC5vypp/6uIc44xarpFzJWXa+ojHsk4nwTPkclcZ8c4GAdK1OJHC8qc6np1iEmb3BfUzy2NtI/R
	GfmIoPtz+mSaf1GjJUsnsrKDSf3N7YccpfbWyD03L64zQCV+4JhrLtkAc5tnZzhP+GEVzc4ojDCbX
	55VkYK4PA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJKf-00066B-CZ; Tue, 10 Nov 2020 02:24:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKZ-000632-ML
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975063; x=1636511063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=htBo/T+51yFNf/aP20lfx/LKM07TCey+64vVFBRYtC8=;
 b=kw36mVMFc81e4kSJd+jZcdnJPTh0jPty0ONXmTHjuheqKE40kaKrLZgq
 DBvxoWxo3KqnDKnoWwCz56ufoK12hJy9QuC+U8ysO8eHL2t84vbvZDMko
 CRva9AQURzTa0j5kN3KlnDbPy94SH5oJPNrIV1kH0Ot0U3wyhyFXgf0sH
 tTn/uqAUJslj2S9cnPrzaVVGlSTyi/bG/OBjinbxvvLo5sc2ZkzaQJCVD
 Cr+B+gStBBZ8UPKrCWB/DLxSveFIPH1FqTn/FZnRa+zd6swAtNIA+beYX
 lfos8TS9y6HLIqhOLAXGItqwP0xf5116kIe8R4ZE+iVDUqvukKbk3dwbO A==;
IronPort-SDR: T5v3+G8HiUtD+pd6wLnnQ8ZiR2pF6UVCfZcsAwTabZaMbhVDb6KS0+ROZv1Br63DhhQt+c0aHl
 yIpcLtjwtl4bEUZsUiG/DqkIPm+EZvC2pTZztlv+LnRqG/C19pfAjRJh+EJmzZTkviH0TMWvqe
 /NuTT+0ajiRgrgkisZJenvpcuxJv1swVslhcTAZr69Lj1cNcZlfydgU8C3AXo8bJ8ssCr2Yu5l
 hvgVqq3Ky8woIUNlgIsF0O7+MdSIfV32k7anIwM25jA13fTLmQ3uCuNQaPRQLhB9I8dUXen27K
 hTw=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="262243707"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:22 +0800
IronPort-SDR: jxqJatddITo1GQORGamp+nkMrSxoXeF6q643BwlRWk8JOErx0iaF8gn7piVtQt0z80xnKk547C
 Qz4c8kmrBP3nTFF7wp6/r5ITaBVqOCblGwH5znrfxAo9ZXU/dUKum+MVjhHepwCVbJUyf5qXf+
 13dgu3bH7xCUyRiu6xRbKCgyda4wDuQ/2LoC4+NxeUcDnTlHwzluuIKpNyeJI957/faipITeUh
 nSkz/QFFm4WxJ0Cpq2q+TnJcBmC35OJ7bCkWFCJjrlc2FvRJfof297LwF0rYEvCfGeU7r6oO6r
 KzyTh8UAcp7eEJmE1lLRVJe5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:10:23 -0800
IronPort-SDR: Sea2stDnWVAs+NRyLpMU5L3sNHddbbkuizv7ct1Um9A3BVH4y+GtdxDK2eddQmkCZwvh8qYDR7
 3fmS+MV0oOCvyUte7yupPIxUorIib9h95snnuAgS9HpIg9eGup2NOTR7lg/5sGddHlQkh9MiPG
 4QygbVHDF+37WgUfLRNzwPlbu3WU1BGGXAzI3zR4Wcy2QGh3ZGsAIdicjUS6B4/GcTWRhpJfyJ
 2I5lP4/o7m5SKQQPx5cbyZT95RA0eeZ8F26F/89SBZb+dxX8zL+Azmnv3SPag3FbbHPCUNqbop
 dxI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:21 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 2/6] nvme-core: split nvme_alloc_request()
Date: Mon,  9 Nov 2020 18:24:01 -0800
Message-Id: <20201110022405.6707-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212423_931374_2B710FD2 
X-CRM114-Status: GOOD (  19.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now nvme_alloc_request() allocates a request from block layer
based on the value of the qid. When qid set to NVME_QID_ANY it used
blk_mq_alloc_request() else blk_mq_alloc_request_hctx().

The function nvme_alloc_request() is called from different context, The
only place where it uses non NVME_QID_ANY value is for fabrics connect
commands :-

nvme_submit_sync_cmd()		NVME_QID_ANY
nvme_features()			NVME_QID_ANY
nvme_sec_submit()		NVME_QID_ANY
nvmf_reg_read32()		NVME_QID_ANY
nvmf_reg_read64()		NVME_QID_ANY
nvmf_reg_write32()		NVME_QID_ANY
nvmf_connect_admin_queue()	NVME_QID_ANY
nvme_submit_user_cmd()		NVME_QID_ANY
	nvme_alloc_request()
nvme_keep_alive()		NVME_QID_ANY
	nvme_alloc_request()
nvme_timeout()			NVME_QID_ANY
	nvme_alloc_request()
nvme_delete_queue()		NVME_QID_ANY
	nvme_alloc_request()
nvmet_passthru_execute_cmd()	NVME_QID_ANY
	nvme_alloc_request()
nvmf_connect_io_queue() 	QID
	__nvme_submit_sync_cmd()
		nvme_alloc_request()

With passthru nvme_alloc_request() now falls into the I/O fast path such
that blk_mq_alloc_request_hctx() is never gets called and that adds
additional branch check in fast path.

Split the nvme_alloc_request() into nvme_alloc_request() and
nvme_alloc_request_qid().

Replace each call of the nvme_alloc_request() with NVME_QID_ANY param
with a call to newly added nvme_alloc_request() without NVME_QID_ANY.

Replace a call to nvme_alloc_request() with QID param with a call to
newly added nvme_alloc_request() and nvme_alloc_request_qid()
based on the qid value set in the __nvme_submit_sync_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c       | 56 +++++++++++++++++++++-------------
 drivers/nvme/host/lightnvm.c   |  5 ++-
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/pci.c        |  4 +--
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 315ea958d1b7..99aa0863502f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -526,12 +526,7 @@ static inline void nvme_init_req_from_cmd(struct request *req,
 	nvme_req(req)->cmd = cmd;
 }
 
-static inline unsigned int nvme_req_op(struct nvme_command *cmd)
-{
-	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
-}
-
-static inline void nvme_init_req_default_timeout(struct request *req)
+static inline void nvme_init_req_timeout(struct request *req)
 {
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
@@ -539,28 +534,42 @@ static inline void nvme_init_req_default_timeout(struct request *req)
 		req->timeout = NVME_ADMIN_TIMEOUT;
 }
 
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+		struct nvme_command *cmd, blk_mq_req_flags_t flags)
 {
-	unsigned op = nvme_req_op(cmd);
 	struct request *req;
 
-	if (qid == NVME_QID_ANY) {
-		req = blk_mq_alloc_request(q, op, flags);
-	} else {
-		req = blk_mq_alloc_request_hctx(q, op, flags,
-				qid ? qid - 1 : 0);
+	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	if (!IS_ERR(req)) {
+		nvme_init_req_timeout(req);
+		nvme_init_req_from_cmd(req, cmd);
 	}
-	if (IS_ERR(req))
-		return req;
-
-	nvme_init_req_timeout(req);
-	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
+struct request *nvme_alloc_request_qid(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+{
+	struct request *req;
+
+	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+			qid ? qid - 1 : 0);
+	if (!IS_ERR(req)) {
+		nvme_init_req_timeout(req);
+		nvme_init_req_from_cmd(req, cmd);
+	}
+
+	return req;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_request_qid);
+
 static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 {
 	struct nvme_command c;
@@ -917,7 +926,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	if (qid == NVME_QID_ANY)
+		req = nvme_alloc_request(q, cmd, flags);
+	else
+		req = nvme_alloc_request_qid(q, cmd, flags, qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1088,7 +1100,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1163,8 +1175,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 88a7c8eac455..470cef3abec3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -767,8 +767,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 53783358d62b..d2ccd3473b20 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -610,6 +610,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+struct request *nvme_alloc_request_qid(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6123040ff872..5e6365dd0c8e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1304,7 +1304,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+			BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2218,7 +2218,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a062398305a7..be8ae59dcb71 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -248,7 +248,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, req->cmd, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
