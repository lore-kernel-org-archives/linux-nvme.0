Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E6DC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488D4206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="afq2DCwL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLfa9HEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488D4206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lv0BkYz3uIYu5oNbvijygDJd7Ke//QJEI6CEOIRQ9Lg=; b=afq2DCwLIW/7ykc9C2U2SW7enV
	qrAAtWisIMerPvcXVXo+YwQ4H8078ApEC09shcdeehO6d2Wa28iV6MEbGDdAuZ/WEAg5BM9R+MnAa
	LvmRngBA012biyc1BmwtUlACvbZjCuMYqJYW8wGTtU3ze4gb3Sb7TYDF6vICGYc3a3rikBd8Ha1gg
	1GCgxIzWO5Gw+QUYKp6rmLLSDrMqRpkeid7jj5CXE966SJC7M1FdiS4iGH/YGx7zFXGzfXZq7X0c2
	ZI+hDfAfHh5pYyMVIx1iqsdF7BHB5Fm0pk8TDsi/fznGoVgmbAwA1eGXyn4zlC1KB/t3r3lWpN61L
	aGmZBvBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKAx-0001ta-Ve; Tue, 31 Mar 2020 16:55:43 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6H-0004tV-F2
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:12 +0000
Received: by mail-wm1-x344.google.com with SMTP id j19so3618239wmi.2
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c6BPr7OBdagMyYWik2LaK1jsSaHSj6G+dg/aUa+QiMo=;
 b=NLfa9HEyrWJPv9jlnzjdLmy1POmF2TMtdNRv1VEnAOm6nMYn/U65trOhDFlzSIup6b
 Lx3okCh50+ubbLamY4ZFGUBE6x8UPzJpSVtpDbeKVWdrU+fgUxo+edwyI+0YBg6tm6kA
 pMSMOK9PoUjJLlyQJum/m9lvNZrMyfB5cqWawViuCUlM+GmSqJQ9TXA55ceDimjZ61eg
 KnSt4BTmyAXwq74iO8YMphOunevogXr4+8jp+9pxvWTX57IJTlkiAjT2/6+DMVe5pF1m
 FxIXaz/EfoCTvUbHyzLZQTSoKpSI62seiLVBgleYJ7rVK0irR2ONhjj2FsmbdFU3Kj+v
 n9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c6BPr7OBdagMyYWik2LaK1jsSaHSj6G+dg/aUa+QiMo=;
 b=LXx+/Kwny5ql8flKJ/BT3WO57jTwEjUavWro/RwQnayR7K1QZNAAl+7fYtH2peqIbw
 KG/4zUNoSRQmeeRwm+wjMjtDFHzXcDmdH7SlSSCgDAJbk8E/jGr21oos28mjZlhT6lkp
 9hwf0Ooc/aqwyPx53bIplXeLnApUAYr04EXmpqSwOAQ8dzheInzz0iTQxu5dpiszXqH8
 HuQkkg7z613F7BYvpkAQEnrtKhNkdDP6ZFkImT++8hRuqNE+cP0pcjg1KbVANtXRCKjM
 q6qputOdfT5uYszB4xHDGUPR/hs/DxtthcjP1ZQuWedzClvCMeioK/aaaFXxpcgkMwMI
 bjPQ==
X-Gm-Message-State: ANhLgQ1U/FO/rQn28cRNdnCWlNkUVOcLKeLLJmlnXwA9Nov0rlomH+B9
 6//7sbWjvLb4LlkVBoN4rpL+anvi
X-Google-Smtp-Source: ADFU+vvd7UuB5q0IKMmiGUVeWdbxSjx2FLy2aJ3u4L9Qctecbnt0n929MkG3qukosYhbJihDQZeWMA==
X-Received: by 2002:a05:600c:552:: with SMTP id
 k18mr4132804wmc.180.1585673451357; 
 Tue, 31 Mar 2020 09:50:51 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:50 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 18/26] lpfc: Refactor nvmet_rcv_ctx to create
 lpfc_async_xchg_ctx
Date: Tue, 31 Mar 2020 09:50:03 -0700
Message-Id: <20200331165011.15819-19-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095053_688662_88E29A79 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: James Smart <jsmart2021@gmail.com>, Paul Ely <paul.ely@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To support FC-NVME-2 support (actually FC-NVME (rev 1) with Ammendment 1),
both the nvme (host) and nvmet (controller/target) sides will need to be
able to receive LS requests.  Currently, this support is in the nvmet side
only. To prepare for both sides supporting LS receive, rename
lpfc_nvmet_rcv_ctx to lpfc_async_xchg_ctx and commonize the definition.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/lpfc/lpfc.h         |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h    |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c |   2 +-
 drivers/scsi/lpfc/lpfc_init.c    |   2 +-
 drivers/scsi/lpfc/lpfc_nvme.h    |   7 +--
 drivers/scsi/lpfc/lpfc_nvmet.c   | 109 ++++++++++++++++++++-------------------
 drivers/scsi/lpfc/lpfc_sli.c     |   2 +-
 7 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 04d73e2be373..8b0d8f390034 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -143,7 +143,7 @@ struct lpfc_dmabuf {
 
 struct lpfc_nvmet_ctxbuf {
 	struct list_head list;
-	struct lpfc_nvmet_rcv_ctx *context;
+	struct lpfc_async_xchg_ctx *context;
 	struct lpfc_iocbq *iocbq;
 	struct lpfc_sglq *sglq;
 	struct work_struct defer_work;
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 25d3dd39bc05..dc76729f8864 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -24,7 +24,6 @@ typedef int (*node_filter)(struct lpfc_nodelist *, void *);
 
 struct fc_rport;
 struct fc_frame_header;
-struct lpfc_nvmet_rcv_ctx;
 void lpfc_down_link(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_sli_read_link_ste(struct lpfc_hba *);
 void lpfc_dump_mem(struct lpfc_hba *, LPFC_MBOXQ_t *, uint16_t, uint16_t);
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 02420588ddd1..9e87b8ccc8e6 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -1032,7 +1032,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
 {
 	struct lpfc_hba   *phba = vport->phba;
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
+	struct lpfc_async_xchg_ctx *ctxp, *next_ctxp;
 	struct nvme_fc_local_port *localport;
 	struct lpfc_fc4_ctrl_stat *cstat;
 	struct lpfc_nvme_lport *lport;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 994af5547ab3..14964e8300d4 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1038,7 +1038,7 @@ static int
 lpfc_hba_down_post_s4(struct lpfc_hba *phba)
 {
 	struct lpfc_io_buf *psb, *psb_next;
-	struct lpfc_nvmet_rcv_ctx *ctxp, *ctxp_next;
+	struct lpfc_async_xchg_ctx *ctxp, *ctxp_next;
 	struct lpfc_sli4_hdw_queue *qp;
 	LIST_HEAD(aborts);
 	LIST_HEAD(nvme_aborts);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 4c1e7e68d4b6..25eebc362121 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -163,13 +163,14 @@ struct lpfc_nvmet_ctx_info {
 #define lpfc_get_ctx_list(phba, cpu, mrq)  \
 	(phba->sli4_hba.nvmet_ctx_info + ((cpu * phba->cfg_nvmet_mrq) + mrq))
 
-struct lpfc_nvmet_rcv_ctx {
+struct lpfc_async_xchg_ctx {
 	union {
-		struct nvmefc_ls_rsp ls_rsp;
 		struct nvmefc_tgt_fcp_req fcp_req;
-	} ctx;
+	} hdlrctx;
 	struct list_head list;
 	struct lpfc_hba *phba;
+	struct nvmefc_ls_req *ls_req;
+	struct nvmefc_ls_rsp ls_rsp;
 	struct lpfc_iocbq *wqeq;
 	struct lpfc_iocbq *abort_wqeq;
 	spinlock_t ctxlock; /* protect flag access */
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 8d991466970f..ded7f973cad4 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -52,22 +52,22 @@
 #include "lpfc_debugfs.h"
 
 static struct lpfc_iocbq *lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *,
-						 struct lpfc_nvmet_rcv_ctx *,
+						 struct lpfc_async_xchg_ctx *,
 						 dma_addr_t rspbuf,
 						 uint16_t rspsize);
 static struct lpfc_iocbq *lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *,
-						  struct lpfc_nvmet_rcv_ctx *);
+						  struct lpfc_async_xchg_ctx *);
 static int lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *,
-					  struct lpfc_nvmet_rcv_ctx *,
+					  struct lpfc_async_xchg_ctx *,
 					  uint32_t, uint16_t);
 static int lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *,
-					    struct lpfc_nvmet_rcv_ctx *,
+					    struct lpfc_async_xchg_ctx *,
 					    uint32_t, uint16_t);
 static int lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *,
-					   struct lpfc_nvmet_rcv_ctx *,
+					   struct lpfc_async_xchg_ctx *,
 					   uint32_t, uint16_t);
 static void lpfc_nvmet_wqfull_flush(struct lpfc_hba *, struct lpfc_queue *,
-				    struct lpfc_nvmet_rcv_ctx *);
+				    struct lpfc_async_xchg_ctx *);
 static void lpfc_nvmet_fcp_rqst_defer_work(struct work_struct *);
 
 static void lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf);
@@ -216,10 +216,10 @@ lpfc_nvmet_cmd_template(void)
 }
 
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
-static struct lpfc_nvmet_rcv_ctx *
+static struct lpfc_async_xchg_ctx *
 lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	unsigned long iflag;
 	bool found = false;
 
@@ -238,10 +238,10 @@ lpfc_nvmet_get_ctx_for_xri(struct lpfc_hba *phba, u16 xri)
 	return NULL;
 }
 
-static struct lpfc_nvmet_rcv_ctx *
+static struct lpfc_async_xchg_ctx *
 lpfc_nvmet_get_ctx_for_oxid(struct lpfc_hba *phba, u16 oxid, u32 sid)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	unsigned long iflag;
 	bool found = false;
 
@@ -262,7 +262,8 @@ lpfc_nvmet_get_ctx_for_oxid(struct lpfc_hba *phba, u16 oxid, u32 sid)
 #endif
 
 static void
-lpfc_nvmet_defer_release(struct lpfc_hba *phba, struct lpfc_nvmet_rcv_ctx *ctxp)
+lpfc_nvmet_defer_release(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *ctxp)
 {
 	lockdep_assert_held(&ctxp->ctxlock);
 
@@ -298,7 +299,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 {
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct nvmefc_ls_rsp *rsp;
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	uint32_t status, result;
 
 	status = bf_get(lpfc_wcqe_c_status, wcqe);
@@ -330,7 +331,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	}
 
 out:
-	rsp = &ctxp->ctx.ls_rsp;
+	rsp = &ctxp->ls_rsp;
 
 	lpfc_nvmeio_data(phba, "NVMET LS  CMPL: xri x%x stat x%x result x%x\n",
 			 ctxp->oxid, status, result);
@@ -364,7 +365,7 @@ void
 lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 {
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
-	struct lpfc_nvmet_rcv_ctx *ctxp = ctx_buf->context;
+	struct lpfc_async_xchg_ctx *ctxp = ctx_buf->context;
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct fc_frame_header *fc_hdr;
 	struct rqb_dmabuf *nvmebuf;
@@ -416,7 +417,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 		size = nvmebuf->bytes_recv;
 		sid = sli4_sid_from_fc_hdr(fc_hdr);
 
-		ctxp = (struct lpfc_nvmet_rcv_ctx *)ctx_buf->context;
+		ctxp = (struct lpfc_async_xchg_ctx *)ctx_buf->context;
 		ctxp->wqeq = NULL;
 		ctxp->offset = 0;
 		ctxp->phba = phba;
@@ -490,7 +491,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 static void
 lpfc_nvmet_ktime(struct lpfc_hba *phba,
-		 struct lpfc_nvmet_rcv_ctx *ctxp)
+		 struct lpfc_async_xchg_ctx *ctxp)
 {
 	uint64_t seg1, seg2, seg3, seg4, seg5;
 	uint64_t seg6, seg7, seg8, seg9, seg10;
@@ -699,7 +700,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 {
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct nvmefc_tgt_fcp_req *rsp;
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	uint32_t status, result, op, start_clean, logerr;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint32_t id;
@@ -708,7 +709,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	ctxp = cmdwqe->context2;
 	ctxp->flag &= ~LPFC_NVMET_IO_INP;
 
-	rsp = &ctxp->ctx.fcp_req;
+	rsp = &ctxp->hdlrctx.fcp_req;
 	op = rsp->op;
 
 	status = bf_get(lpfc_wcqe_c_status, wcqe);
@@ -827,8 +828,8 @@ static int
 lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 		      struct nvmefc_ls_rsp *rsp)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_rsp);
+	struct lpfc_async_xchg_ctx *ctxp =
+		container_of(rsp, struct lpfc_async_xchg_ctx, ls_rsp);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct hbq_dmabuf *nvmebuf =
 		(struct hbq_dmabuf *)ctxp->rqb_buffer;
@@ -918,8 +919,8 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		      struct nvmefc_tgt_fcp_req *rsp)
 {
 	struct lpfc_nvmet_tgtport *lpfc_nvmep = tgtport->private;
-	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
+	struct lpfc_async_xchg_ctx *ctxp =
+		container_of(rsp, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct lpfc_queue *wq;
 	struct lpfc_iocbq *nvmewqeq;
@@ -1052,8 +1053,8 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			 struct nvmefc_tgt_fcp_req *req)
 {
 	struct lpfc_nvmet_tgtport *lpfc_nvmep = tgtport->private;
-	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(req, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
+	struct lpfc_async_xchg_ctx *ctxp =
+		container_of(req, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct lpfc_queue *wq;
 	unsigned long flags;
@@ -1114,8 +1115,8 @@ lpfc_nvmet_xmt_fcp_release(struct nvmet_fc_target_port *tgtport,
 			   struct nvmefc_tgt_fcp_req *rsp)
 {
 	struct lpfc_nvmet_tgtport *lpfc_nvmep = tgtport->private;
-	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
+	struct lpfc_async_xchg_ctx *ctxp =
+		container_of(rsp, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long flags;
 	bool aborting = false;
@@ -1157,8 +1158,8 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 		     struct nvmefc_tgt_fcp_req *rsp)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
+	struct lpfc_async_xchg_ctx *ctxp =
+		container_of(rsp, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
 	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long iflag;
@@ -1564,7 +1565,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	uint16_t xri = bf_get(lpfc_wcqe_xa_xri, axri);
 	uint16_t rxid = bf_get(lpfc_wcqe_xa_remote_xid, axri);
-	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
+	struct lpfc_async_xchg_ctx *ctxp, *next_ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct nvmefc_tgt_fcp_req *req = NULL;
 	struct lpfc_nodelist *ndlp;
@@ -1650,7 +1651,7 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 				 "NVMET ABTS RCV: xri x%x CPU %02x rjt %d\n",
 				 xri, raw_smp_processor_id(), 0);
 
-		req = &ctxp->ctx.fcp_req;
+		req = &ctxp->hdlrctx.fcp_req;
 		if (req)
 			nvmet_fc_rcv_fcp_abort(phba->targetport, req);
 	}
@@ -1663,7 +1664,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 {
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_nvmet_rcv_ctx *ctxp, *next_ctxp;
+	struct lpfc_async_xchg_ctx *ctxp, *next_ctxp;
 	struct nvmefc_tgt_fcp_req *rsp;
 	uint32_t sid;
 	uint16_t oxid, xri;
@@ -1696,7 +1697,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
 				"6319 NVMET Rcv ABTS:acc xri x%x\n", xri);
 
-		rsp = &ctxp->ctx.fcp_req;
+		rsp = &ctxp->hdlrctx.fcp_req;
 		nvmet_fc_rcv_fcp_abort(phba->targetport, rsp);
 
 		/* Respond with BA_ACC accordingly */
@@ -1770,7 +1771,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 		if (ctxp->flag & LPFC_NVMET_TNOTIFY) {
 			/* Notify the transport */
 			nvmet_fc_rcv_fcp_abort(phba->targetport,
-					       &ctxp->ctx.fcp_req);
+					       &ctxp->hdlrctx.fcp_req);
 		} else {
 			cancel_work_sync(&ctxp->ctxbuf->defer_work);
 			spin_lock_irqsave(&ctxp->ctxlock, iflag);
@@ -1798,7 +1799,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 
 static void
 lpfc_nvmet_wqfull_flush(struct lpfc_hba *phba, struct lpfc_queue *wq,
-			struct lpfc_nvmet_rcv_ctx *ctxp)
+			struct lpfc_async_xchg_ctx *ctxp)
 {
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *nvmewqeq;
@@ -1849,7 +1850,7 @@ lpfc_nvmet_wqfull_process(struct lpfc_hba *phba,
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *nvmewqeq;
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	unsigned long iflags;
 	int rc;
 
@@ -1863,7 +1864,7 @@ lpfc_nvmet_wqfull_process(struct lpfc_hba *phba,
 		list_remove_head(&wq->wqfull_list, nvmewqeq, struct lpfc_iocbq,
 				 list);
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
-		ctxp = (struct lpfc_nvmet_rcv_ctx *)nvmewqeq->context2;
+		ctxp = (struct lpfc_async_xchg_ctx *)nvmewqeq->context2;
 		rc = lpfc_sli4_issue_wqe(phba, ctxp->hdwq, nvmewqeq);
 		spin_lock_irqsave(&pring->ring_lock, iflags);
 		if (rc == -EBUSY) {
@@ -1875,7 +1876,7 @@ lpfc_nvmet_wqfull_process(struct lpfc_hba *phba,
 		if (rc == WQE_SUCCESS) {
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 			if (ctxp->ts_cmd_nvme) {
-				if (ctxp->ctx.fcp_req.op == NVMET_FCOP_RSP)
+				if (ctxp->hdlrctx.fcp_req.op == NVMET_FCOP_RSP)
 					ctxp->ts_status_wqput = ktime_get_ns();
 				else
 					ctxp->ts_data_wqput = ktime_get_ns();
@@ -1941,7 +1942,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct fc_frame_header *fc_hdr;
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	uint32_t *payload;
 	uint32_t size, oxid, sid, rc;
 
@@ -1964,7 +1965,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	size = bf_get(lpfc_rcqe_length,  &nvmebuf->cq_event.cqe.rcqe_cmpl);
 	sid = sli4_sid_from_fc_hdr(fc_hdr);
 
-	ctxp = kzalloc(sizeof(struct lpfc_nvmet_rcv_ctx), GFP_ATOMIC);
+	ctxp = kzalloc(sizeof(struct lpfc_async_xchg_ctx), GFP_ATOMIC);
 	if (ctxp == NULL) {
 		atomic_inc(&tgtp->rcv_ls_req_drop);
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
@@ -1995,7 +1996,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
 	 */
 	atomic_inc(&tgtp->rcv_ls_req_in);
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ctx.ls_rsp,
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ls_rsp,
 				 payload, size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
@@ -2029,7 +2030,7 @@ static void
 lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 {
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
-	struct lpfc_nvmet_rcv_ctx *ctxp = ctx_buf->context;
+	struct lpfc_async_xchg_ctx *ctxp = ctx_buf->context;
 	struct lpfc_hba *phba = ctxp->phba;
 	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
 	struct lpfc_nvmet_tgtport *tgtp;
@@ -2073,7 +2074,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 	 * A buffer has already been reposted for this IO, so just free
 	 * the nvmebuf.
 	 */
-	rc = nvmet_fc_rcv_fcp_req(phba->targetport, &ctxp->ctx.fcp_req,
+	rc = nvmet_fc_rcv_fcp_req(phba->targetport, &ctxp->hdlrctx.fcp_req,
 				  payload, ctxp->size);
 	/* Process FCP command */
 	if (rc == 0) {
@@ -2220,7 +2221,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 			    uint64_t isr_timestamp,
 			    uint8_t cqflag)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct fc_frame_header *fc_hdr;
 	struct lpfc_nvmet_ctxbuf *ctx_buf;
@@ -2304,7 +2305,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 
 	sid = sli4_sid_from_fc_hdr(fc_hdr);
 
-	ctxp = (struct lpfc_nvmet_rcv_ctx *)ctx_buf->context;
+	ctxp = (struct lpfc_async_xchg_ctx *)ctx_buf->context;
 	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
 	list_add_tail(&ctxp->list, &phba->sli4_hba.t_active_ctx_list);
 	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
@@ -2460,7 +2461,7 @@ lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba,
  **/
 static struct lpfc_iocbq *
 lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
-		       struct lpfc_nvmet_rcv_ctx *ctxp,
+		       struct lpfc_async_xchg_ctx *ctxp,
 		       dma_addr_t rspbuf, uint16_t rspsize)
 {
 	struct lpfc_nodelist *ndlp;
@@ -2582,9 +2583,9 @@ lpfc_nvmet_prep_ls_wqe(struct lpfc_hba *phba,
 
 static struct lpfc_iocbq *
 lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
-			struct lpfc_nvmet_rcv_ctx *ctxp)
+			struct lpfc_async_xchg_ctx *ctxp)
 {
-	struct nvmefc_tgt_fcp_req *rsp = &ctxp->ctx.fcp_req;
+	struct nvmefc_tgt_fcp_req *rsp = &ctxp->hdlrctx.fcp_req;
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct sli4_sge *sgl;
 	struct lpfc_nodelist *ndlp;
@@ -2928,7 +2929,7 @@ static void
 lpfc_nvmet_sol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			     struct lpfc_wcqe_complete *wcqe)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
 	uint32_t result;
 	unsigned long flags;
@@ -2997,7 +2998,7 @@ static void
 lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			       struct lpfc_wcqe_complete *wcqe)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
 	unsigned long flags;
 	uint32_t result;
@@ -3078,7 +3079,7 @@ static void
 lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			    struct lpfc_wcqe_complete *wcqe)
 {
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	struct lpfc_nvmet_tgtport *tgtp;
 	uint32_t result;
 
@@ -3119,7 +3120,7 @@ lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 static int
 lpfc_nvmet_unsol_issue_abort(struct lpfc_hba *phba,
-			     struct lpfc_nvmet_rcv_ctx *ctxp,
+			     struct lpfc_async_xchg_ctx *ctxp,
 			     uint32_t sid, uint16_t xri)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
@@ -3214,7 +3215,7 @@ lpfc_nvmet_unsol_issue_abort(struct lpfc_hba *phba,
 
 static int
 lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
-			       struct lpfc_nvmet_rcv_ctx *ctxp,
+			       struct lpfc_async_xchg_ctx *ctxp,
 			       uint32_t sid, uint16_t xri)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
@@ -3340,7 +3341,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 
 static int
 lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
-				 struct lpfc_nvmet_rcv_ctx *ctxp,
+				 struct lpfc_async_xchg_ctx *ctxp,
 				 uint32_t sid, uint16_t xri)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
@@ -3405,7 +3406,7 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 
 static int
 lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *phba,
-				struct lpfc_nvmet_rcv_ctx *ctxp,
+				struct lpfc_async_xchg_ctx *ctxp,
 				uint32_t sid, uint16_t xri)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index b232be81bbd2..730a8ea4ad94 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -19913,7 +19913,7 @@ lpfc_sli4_issue_wqe(struct lpfc_hba *phba, struct lpfc_sli4_hdw_queue *qp,
 		    struct lpfc_iocbq *pwqe)
 {
 	union lpfc_wqe128 *wqe = &pwqe->wqe;
-	struct lpfc_nvmet_rcv_ctx *ctxp;
+	struct lpfc_async_xchg_ctx *ctxp;
 	struct lpfc_queue *wq;
 	struct lpfc_sglq *sglq;
 	struct lpfc_sli_ring *pring;
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
