Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4DC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:43:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D882F205F4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0wLIhR2o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TDIfj423";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F0H3FU1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D882F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ssil5SLgS+UKMUni/wbksUUWwOt6RghrtyT/ApkYEwg=; b=0wLIhR2oQcCZPWc7wm/ZLT8Es
	bYe+Ts0m/Jm1G5N/dsQROKpHSV/Ndw+Xw9iLGP3E9YgIZTEr6kw9xa8fFoxLWRj0RuAmkDfVDbZQS
	vYAMaYOep7ZAU8YJRb3Gc4Va10zjwy1fmvTOY4kpxWPLKBfcwtv1XEzTuDtU6cpV+9jiB9g4KTqVu
	fhZf60ZFIvdCNndQJ5vUSC0n3mbPoLt+iy22iTwW5gvwI1F4nunbuFuNgDXAPKmpVR8yA7qXRvlyU
	E3uRWKPaFKXaZFbNDlp6oe2wqWFXg31+CviJlaSFY/AZ43Jo3/LpyXe/3bJNlUEu6F1bj9vBWB9hX
	IlrM+AECw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaWB4-000451-RE; Thu, 05 Nov 2020 03:43:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW9X-0002bw-FR
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dH2OhipTXnISLSQrWnS6NUZpImwI8XiKMvn5Xqc4cOs=; b=TDIfj423rLt2JoKCsGxfBTD1QO
 RFjJ0dCyt77WuQnCbVi1VDFhKwycVHck/gR18qIvR7XmtIVsou3RXOSwMfoCJmp52+/QwKyC6YCqc
 p/3hbMnlm+nAQHuwaiWvLVEliLkMTm5kROXvT8sABbwfdLSQAkmicxN6RHR9IfPXoZBzLmLfnlvnl
 Q3GppAtmJWEw39fxDGtUh8gqHnjsj+Ugm2I6Z883U5H3Fl5oDzbFmSUVUtWeiVZRyZg0L7FMFvIjr
 Kt5MdKEmD/Rc14firHQZJS+zZLUTeeCQemSyB0CbloP5Mm3Gx4OZyCrbhfUbyZfatloni1QhXIvCG
 TZ0Lnsrg==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaPXi-0005cI-Fj
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 20:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604522286; x=1636058286;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IoVRLFeTCZj8nxffiuZSJwKKAoq3rr/vVIxc05yE4IE=;
 b=F0H3FU1dei62QfdrCGF4vHzbFS+hzRraqzoIktIRXgLe/LnXhCPiVwEP
 gmIbownLVnT4TxcbsUTZ6QeAbZ7dME5nWKGzCW1jeT6/IZRJIzGoRZgXb
 SDz21yhC06/udIZyxNXKlPiz17tR17ZzCFOo2zDfV0Rox0ygHubqp03sE
 59ahnwpI2GZ4Mm1TYmIoDRRTzd3cCiFTbsQjwu5gBxdfPzEYS1IjHRBgL
 c2x8W3CHUyVx5M5YJ1rdmP6FBckmF3b8ofDdFAbCuxjm3wMhCOQ1ZrcOP
 NH2neY5ydNhCeqy52+GNQx0CDf629kQY5K9uTGcVT0h4INQWXWfl59c7X g==;
IronPort-SDR: XM4DPuOUo4iuNZF5WkX8X9im2jE4FuIrOH7/LreTUeUEUTt1Wr81QNQ3ZvBjNDfH5IgcSRV3QZ
 7n2KbCx3CE7o0yvPzh7BKZseSRpH15rhefrnd85l+5B/tC7gFTX11XKOvXsPz+0bzAtOMiQ/ej
 NTpMitPQuDrN4bxyTx3Q4MSFU4DSmDeKc9sZ0HFbCBYv04Cqc5SxLjXOrluy2K++1+2Gqk1moy
 yYbmILG1n3o0wF2nIOUkmzO8vrTUlj0KjRTCxZdOLygDHamBBx3QJw/uRbIauXPPt2G2x7y/jv
 ako=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; d="scan'208";a="261812823"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 04:37:46 +0800
IronPort-SDR: iaRN8QKc8EO/HlVjKtvAs5HN4noW++gETyVqbVZENPDTa6tVDFNZREtG42CqmqjhH6Eea7OE/k
 nngQ9k9SkU9gNzOZKwpNgbRd1f2MaGFuWSXfF2/ZIr/NoHOUwBZ9QNGutTsnhDKTaTslHvoiNc
 nReWm4CM0qmsDOrsZ4/XdQ1DaLD/Rc2MIaL5sk8K5cGKd6tVubgOlKFccdrTZ+eceTKDFetrV6
 XFuayTogv2SFeAdxEIU4GHTppzCBYBwhkOOUoUI0vuCzE/FBqWXHlEwV+6AmvOpYWMAb0jVgxm
 Kf3zEMHZOycBoCCPx4TqLJD9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 12:22:43 -0800
IronPort-SDR: eYnPzG07zjDomk6agTZSoOZLRV2KBqNXnC8I4aQEPK98pSjGY/DgZfywXUE121J4Ymi8E7Dove
 zkFOLN1/o6VrRGZNA+jnr4FLvLckD8N3RVZzVtp4li2mIn2SWkmNM0HPYnSrQE+/x3aCy7Iltv
 mU/2MtlMmXqqCLGsHqTD9EfGnyWz5gacVOikBWEENJ04W00HU7+y8+Wp+AriTSQpOs9ifVDOJJ
 oCjb29ZeL2OsesVBwPNRhzD7Yw8SKeWyW8QALOO9PnDEE5LnXFSTxnImrF6EceIWIVa5DmhfxN
 yiU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 12:37:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 1/5] nvme: centralize setting req timeout
Date: Wed,  4 Nov 2020 12:37:32 -0800
Message-Id: <20201104203736.62745-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_203807_025936_0311AFAC 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_alloc_request() is called from different context
(I/O and Admin queue) where callers do not consider the I/O timeout
when called from I/O queue context.

Introduce nvme_req_set_default_timeout() function which sets the
default I/O and Admin timeout value based on whether the queuedata
is set or not. Call this function from the nvme_alloc_request() when
the newly added timeout parameter is not set from the callers of
nvme_alloc_request().

Update the respective callers of the nvme_alloc_request() which are
setting the req->timeout value after allocating the request such that
now we pass that value as a last parameter of the nvme_alloc_request().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 28 +++++++++++++++++++---------
 drivers/nvme/host/lightnvm.c   |  9 ++++-----
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/host/pci.c        |  7 +++----
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..045ac445aee7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,8 +518,17 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
+static inline void nvme_req_set_default_timeout(struct request *req)
+{
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = ADMIN_TIMEOUT;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
+		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid,
+		unsigned int timeout)
 {
 	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
@@ -533,6 +542,11 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
+	if (timeout)
+		req->timeout = timeout;
+	else
+		nvme_req_set_default_timeout(req);
+
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
@@ -897,12 +911,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	req = nvme_alloc_request(q, cmd, flags, qid, timeout);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
 		if (ret)
@@ -1067,11 +1079,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY, timeout);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
@@ -1141,12 +1152,11 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+			BLK_MQ_REQ_RESERVED, NVME_QID_ANY, ctrl->kato * HZ);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
-	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
 
 	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_keep_alive_end_io);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..eabcbdd3a556 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -653,7 +653,8 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY,
+			0);
 	if (IS_ERR(rq))
 		return rq;
 
@@ -767,15 +768,13 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int ret = 0;
 
-	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
-			NVME_QID_ANY);
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0, NVME_QID_ANY,
+			timeout);
 	if (IS_ERR(rq)) {
 		ret = -ENOMEM;
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
 		if (!ppa_list) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bc330bf0d3bd..f2b1a18d8bd7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -610,7 +610,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
+		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid,
+		unsigned int timeout);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..923ca1d47031 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1304,13 +1304,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY, ADMIN_TIMEOUT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
@@ -2219,11 +2218,11 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY,
+				 ADMIN_TIMEOUT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8ee94f056898..2905c039b479 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -244,7 +244,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		q = ns->queue;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY);
+	rq = nvme_alloc_request(q, req->cmd, 0, NVME_QID_ANY, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
