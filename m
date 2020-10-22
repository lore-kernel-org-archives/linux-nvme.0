Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E0C388F7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:25:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6DC20848
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hzn114Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6DC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1AbRQNIaUQJ5MvvLtcJpkwlRRo/eqesA08a5qcM+6Bc=; b=Hzn114CkXid2VIKRy7Iggf+j/
	aUTCmHwKms6FzhRdu1uqh4TE8UHzLjEsghSa2QULgstTI8SFaOyqvLIhDLHJxIOIUajjdI1UxOhWD
	eocVl/hLxNq1mpQk4j/XfDKWlwanEZBDQhmnwB3fwQC4/gfml9JBGGKRpBiSiRfNJR6O753GQAOYJ
	1X0TjtLdDzZgtAiMmXveqLYOh3xctX9/7LUGQy61yRX5XoWFoqjWj2iEC5tXYzURemr7H7BVQSqNO
	dndo/INx7QBatkcKcFy4iOeL8X+1rGb+tjWGKFfxMsrHSfb4wrJhWimP33IAeNPmihB9f+RPIoMll
	fGss9xznQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVaaJ-0006Ch-Ui; Thu, 22 Oct 2020 13:24:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVaXn-0004cP-II
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 13:22:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B301567373; Thu, 22 Oct 2020 15:22:06 +0200 (CEST)
Date: Thu, 22 Oct 2020 15:22:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix the Oops in the tracing for flush cmd
Message-ID: <20201022132206.GA8781@lst.de>
References: <20201021232859.4915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201021232859.4915-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_092215_744443_D1F4B350 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think the problem is that the extra namespace lookup doesn't make
sense to start with.  We'll need to reuse req->ns, and for that move
the init tracepoint a bit:

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aafcbc424b7a94..6b610b68c44226 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -907,8 +907,6 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
-	trace_nvmet_req_init(req, req->cmd);
-
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
@@ -937,6 +935,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 
 	if (status)
 		goto fail;
+	
+	trace_nvmet_req_init(req, req->cmd);
 
 	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 0458046d650178..c14e3249a14dc8 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -46,19 +46,12 @@ static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
 	return req->sq->ctrl;
 }
 
-static inline void __assign_disk_name(char *name, struct nvmet_req *req,
-		bool init)
+static inline void __assign_req_name(char *name, struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
-	struct nvmet_ns *ns;
-
-	if ((init && req->sq->qid) || (!init && req->cq->qid)) {
-		ns = nvmet_find_namespace(ctrl, req->cmd->rw.nsid);
-		strncpy(name, ns->device_path, DISK_NAME_LEN);
-		return;
-	}
-
-	memset(name, 0, DISK_NAME_LEN);
+	if (req->ns)
+		strncpy(name, req->ns->device_path, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
 }
 #endif
 
@@ -81,7 +74,7 @@ TRACE_EVENT(nvmet_req_init,
 	TP_fast_assign(
 		__entry->cmd = cmd;
 		__entry->ctrl = nvmet_req_to_ctrl(req);
-		__assign_disk_name(__entry->disk, req, true);
+		__assign_req_name(__entry->disk, req);
 		__entry->qid = req->sq->qid;
 		__entry->cid = cmd->common.command_id;
 		__entry->opcode = cmd->common.opcode;
@@ -121,7 +114,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__entry->cid = req->cqe->command_id;
 		__entry->result = le64_to_cpu(req->cqe->result.u64);
 		__entry->status = le16_to_cpu(req->cqe->status) >> 1;
-		__assign_disk_name(__entry->disk, req, false);
+		__assign_req_name(__entry->disk, req);
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
 		__print_ctrl_name(__entry->ctrl),

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
