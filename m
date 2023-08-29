Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46AAC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NG1Qwe/WQzn5azjwmrwbfCg0wFPF7HJfxfYNGD1R4lU=; b=Kt2sbghvCgrcr3xW4FXbThsQvD
	Ss3sygcv3fv3Pf5o7U3lWyAlOaE74oJHLAfvyKJV7tC86Useui98+8FX+vYr2Y+r+o1g4ylXt0+Z+
	mqk21wMGueQsQTY08kG7ifRRuPt6HE7/JtPMvl/90pAvsN+Sfloh2YaGppBkoR9dxElvbNwEiFIrF
	BxYEK6sIxD2gBNpBbmRQhIOB05CmhpFrAk7ZOgLNZ4PVbGBxyndd50VmPS9IGzRglZH/HUWPnlJEN
	T8MxnZhLrW71jcUx4Soop/gJijmCpy/jKwe4gp0HcSHmi3yc+xM5jbfrQ00ow/Wnlq8xUBxtjt1AF
	2y3RViGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunF-00B68f-1A;
	Tue, 29 Aug 2023 09:13:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaun8-00B65p-2F
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 09:13:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B273121865;
	Tue, 29 Aug 2023 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693300418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NG1Qwe/WQzn5azjwmrwbfCg0wFPF7HJfxfYNGD1R4lU=;
	b=C1n8p0O15bSrHcTHtAA8ZZk0+fz+QOSAdWYxSuzrh8NIP2darW85anPSxaRzYpacGMUE/P
	822CXr5PZ1kDfbrU1Ok/tMFc/Ybs7JD8YH/VxzBgRK/1pI533Jgt+iN6YwXpM68Zk4Q/cR
	02g3b394hZC78jQ/srcKAlV3bTWQabs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693300418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NG1Qwe/WQzn5azjwmrwbfCg0wFPF7HJfxfYNGD1R4lU=;
	b=oiGZnWY4IpTAhpK4Mm7to+YCbWtJFgxB/AC8JG+HM1yFE1En13jRpTI/rbuUkCADLBdJTN
	S0ucFGfSxeNmdTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A19A813301;
	Tue, 29 Aug 2023 09:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2yVbJ8K27WSwUwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Date: Tue, 29 Aug 2023 11:13:46 +0200
Message-ID: <20230829091350.16156-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091350.16156-1-dwagner@suse.de>
References: <20230829091350.16156-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_021342_903809_6C27B814 
X-CRM114-Status: GOOD (  12.99  )
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

The first command issued from the host to the target is the fabrics
connect command. At this point, neither the target queue nor the
controller have been allocated. But we already try to trace this command
in nvmet_req_init.

Reported by KASAN.

Signed-off-by: Daniel Wagner <dwagner@suse.de>

---
 drivers/nvme/target/trace.c |  6 +++---
 drivers/nvme/target/trace.h | 24 +++++++++++++-----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 6109b3806b12..6997bd7e45cf 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -32,18 +32,20 @@ const char *nvmet_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
 	 nvmet_trace_parse_nvm_cmd(p, opcode, cdw10) :			\
 	 nvmet_trace_parse_admin_cmd(p, opcode, cdw10)))
 
-const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl);
-#define __print_ctrl_name(ctrl)				\
-	nvmet_trace_ctrl_name(p, ctrl)
+const char *nvmet_trace_ctrl_id(struct trace_seq *p, u16 ctrl_id);
+#define __print_ctrl_id(ctrl_id)			\
+	nvmet_trace_ctrl_id(p, ctrl_id)
 
 const char *nvmet_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
 	nvmet_trace_disk_name(p, name)
 
 #ifndef TRACE_HEADER_MULTI_READ
-static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
 {
-	return req->sq->ctrl;
+	if (!req->sq || !req->sq->ctrl)
+		return 0;
+	return req->sq->ctrl->cntlid;
 }
 
 static inline void __assign_req_name(char *name, struct nvmet_req *req)
@@ -63,7 +65,7 @@ TRACE_EVENT(nvmet_req_init,
 	TP_ARGS(req, cmd),
 	TP_STRUCT__entry(
 		__field(struct nvme_command *, cmd)
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(u16, cid)
@@ -76,7 +78,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_fast_assign(
 		__entry->cmd = cmd;
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__assign_req_name(__entry->disk, req);
 		__entry->qid = req->sq->qid;
 		__entry->cid = cmd->common.command_id;
@@ -90,7 +92,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
 		  "meta=%#llx, cmd=(%s, %s)",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->nsid,
 		__entry->flags, __entry->metadata,
@@ -104,7 +106,7 @@ TRACE_EVENT(nvmet_req_complete,
 	TP_PROTO(struct nvmet_req *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(int, cid)
@@ -112,7 +114,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__field(u16, status)
 	),
 	TP_fast_assign(
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__entry->qid = req->cq->qid;
 		__entry->cid = req->cqe->command_id;
 		__entry->result = le64_to_cpu(req->cqe->result.u64);
@@ -120,7 +122,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__assign_req_name(__entry->disk, req);
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->result, __entry->status)
 
-- 
2.41.0


