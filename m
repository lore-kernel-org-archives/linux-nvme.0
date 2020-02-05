Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18CC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D5B20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZfLpDEU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7/nfKp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D5B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4ZopmgORVgJioPlWzmlSkUR88w4jYYH5O/ntEero0fY=; b=VZfLpDEUlzI7yU8/BG2dXpbli4
	+VsxZeWxdwhLC16bXs/Q5ErMRSmpVU5ayYhNjl8/kzLrgZmTcj70o0hkwLfNWic5GUNK3f0iPiUtJ
	IzVtLQWmOPbTo9nTxtN8N+RFR2QyJCnCa4Gei/iSvo7kCOV6tCXIDalENWTrQwswx/UXVe+uEoHJf
	62cqhK1qzOU4G+mFR+g9p16hfnw2ELeKMKFarasosWbAgpjmmfolQNAyr5YMiGDXn0EnoUbTqqdcW
	4TAvugwcrU9oE/xF3tC24ECdnCDTitPnva+yMTS+wkGYjPdKlMh83XxCMoBpnM6Zvx5KREbik6nkU
	y9ueu5XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPeq-0000v4-92; Wed, 05 Feb 2020 18:44:16 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZO-0003w3-Ly
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:55 +0000
Received: by mail-wm1-x343.google.com with SMTP id a5so3603015wmb.0
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I5GZCvu2vv0JE5i3Hy5PA4al/X0iCq/H9VDN8ZkAZJM=;
 b=c7/nfKp7WDLCub+A70rOfWHubN5vt1CD7zq0ZtatzMrA4OXdIX6vZkegnB2EFJDvqr
 RkvmI749GyjUq9dhovWzk7fg/npbO2Kyh7/WPsEfeu+c5EDCTnR239OVXgwGB7TXo9F/
 cUFusD8DOtcnHAThQngO5PRM1aEcMQjuKW+QQiKJwVB/Qgp0Gx8rsVpeBaTPKCEVMQsn
 NP2QR8N/yITTHSeffajEWrDzNvHzspCbiV+/AXi6bbLvQQLcn1X9kkgcYZ3Ukx7RduzS
 Q5wLr+e6jdJ+vyEAY5gDMF07fn0w4vQIJDLtpz4x2Et5jlTZIqqe3pvHlBPYDbI5t3Pb
 gxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I5GZCvu2vv0JE5i3Hy5PA4al/X0iCq/H9VDN8ZkAZJM=;
 b=MKdmF6sgSL1T7+8ynlfrJiC6CBHjIkO6RyYnmzjCoM/bhKSX+9uhoxUXzScTZtoL4A
 ThhhEslJ9vUmExf9CvaAegFk9ByTlD+olc5lYs9naezUMtQNQv7JTxC+Lkf6MxtkgzeH
 mlWHRWkcxvKmtxW0quT1J/0Vmlx601XEXvAEP/OoHFdCJpiMLiZ8ZbTLyA67LuFrMM37
 t+nRYqfh/mqAHvblrkUPaPG2+orzvR9whKFXQmhRplvij/IMnD8m7aKx8DANI55+1ncG
 d2cfxWZwKYcOsFKFnlszqzGzKqwbEKxqZU6pgalYX6EcGQ3pmPqrfBLaRUvEk8bNORiS
 0l5Q==
X-Gm-Message-State: APjAAAXyG8Pr3kacQ67+hJke9I9xZvPB4efzx0mIeiasUNbw79TTRokF
 sZiqanuPd6aqATos64oIMYvm2HTJ
X-Google-Smtp-Source: APXvYqxqql+g+cDnTMc5EVqRQmuLOpqw216QlMuZnXD3gyGI7W/gA30AyK+YZQav6tokGFXWM/kPZQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr6907141wmj.96.1580927916793; 
 Wed, 05 Feb 2020 10:38:36 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:36 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 22/29] lpfc: Commonize lpfc_async_xchg_ctx state and flag
 definitions
Date: Wed,  5 Feb 2020 10:37:46 -0800
Message-Id: <20200205183753.25959-23-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103839_083715_E5AC3DEE 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: James Smart <jsmart2021@gmail.com>, Paul Ely <paul.ely@broadcom.com>,
 martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The last step of commonization is to remove the 'T' suffix from
state and flag field definitions.  This is minor, but removes the
mental association that it solely applies to nvmet use.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c  |   2 +-
 drivers/scsi/lpfc/lpfc_nvme.h  |  37 +++++-----
 drivers/scsi/lpfc/lpfc_nvmet.c | 158 ++++++++++++++++++++---------------------
 3 files changed, 100 insertions(+), 97 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7bcd743dba4d..923605382df2 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1105,7 +1105,7 @@ lpfc_hba_down_post_s4(struct lpfc_hba *phba)
 				 &nvmet_aborts);
 		spin_unlock_irq(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		list_for_each_entry_safe(ctxp, ctxp_next, &nvmet_aborts, list) {
-			ctxp->flag &= ~(LPFC_NVMET_XBUSY | LPFC_NVMET_ABORT_OP);
+			ctxp->flag &= ~(LPFC_NVME_XBUSY | LPFC_NVME_ABORT_OP);
 			lpfc_nvmet_ctxbuf_post(phba, ctxp->ctxbuf);
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 25eebc362121..c5706c950625 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -163,6 +163,26 @@ struct lpfc_nvmet_ctx_info {
 #define lpfc_get_ctx_list(phba, cpu, mrq)  \
 	(phba->sli4_hba.nvmet_ctx_info + ((cpu * phba->cfg_nvmet_mrq) + mrq))
 
+/* Values for state field of struct lpfc_async_xchg_ctx */
+#define LPFC_NVME_STE_LS_RCV		1
+#define LPFC_NVME_STE_LS_ABORT		2
+#define LPFC_NVME_STE_LS_RSP		3
+#define LPFC_NVME_STE_RCV		4
+#define LPFC_NVME_STE_DATA		5
+#define LPFC_NVME_STE_ABORT		6
+#define LPFC_NVME_STE_DONE		7
+#define LPFC_NVME_STE_FREE		0xff
+
+/* Values for flag field of struct lpfc_async_xchg_ctx */
+#define LPFC_NVME_IO_INP		0x1  /* IO is in progress on exchange */
+#define LPFC_NVME_ABORT_OP		0x2  /* Abort WQE issued on exchange */
+#define LPFC_NVME_XBUSY			0x4  /* XB bit set on IO cmpl */
+#define LPFC_NVME_CTX_RLS		0x8  /* ctx free requested */
+#define LPFC_NVME_ABTS_RCV		0x10  /* ABTS received on exchange */
+#define LPFC_NVME_CTX_REUSE_WQ		0x20  /* ctx reused via WQ */
+#define LPFC_NVME_DEFER_WQFULL		0x40  /* Waiting on a free WQE */
+#define LPFC_NVME_TNOTIFY		0x80  /* notify transport of abts */
+
 struct lpfc_async_xchg_ctx {
 	union {
 		struct nvmefc_tgt_fcp_req fcp_req;
@@ -182,24 +202,7 @@ struct lpfc_async_xchg_ctx {
 	uint16_t cpu;
 	uint16_t idx;
 	uint16_t state;
-	/* States */
-#define LPFC_NVMET_STE_LS_RCV		1
-#define LPFC_NVMET_STE_LS_ABORT		2
-#define LPFC_NVMET_STE_LS_RSP		3
-#define LPFC_NVMET_STE_RCV		4
-#define LPFC_NVMET_STE_DATA		5
-#define LPFC_NVMET_STE_ABORT		6
-#define LPFC_NVMET_STE_DONE		7
-#define LPFC_NVMET_STE_FREE		0xff
 	uint16_t flag;
-#define LPFC_NVMET_IO_INP		0x1  /* IO is in progress on exchange */
-#define LPFC_NVMET_ABORT_OP		0x2  /* Abort WQE issued on exchange */
-#define LPFC_NVMET_XBUSY		0x4  /* XB bit set on IO cmpl */
-#define LPFC_NVMET_CTX_RLS		0x8  /* ctx free requested */
-#define LPFC_NVMET_ABTS_RCV		0x10  /* ABTS received on exchange */
-#define LPFC_NVMET_CTX_REUSE_WQ		0x20  /* ctx reused via WQ */
-#define LPFC_NVMET_DEFER_WQFULL		0x40  /* Waiting on a free WQE */
-#define LPFC_NVMET_TNOTIFY		0x80  /* notify transport of abts */
 	struct rqb_dmabuf *rqb_buffer;
 	struct lpfc_nvmet_ctxbuf *ctxbuf;
 	struct lpfc_sli4_hdw_queue *hdwq;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index ded7f973cad4..28db056cf5af 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -271,10 +271,10 @@ lpfc_nvmet_defer_release(struct lpfc_hba *phba,
 			"6313 NVMET Defer ctx release oxid x%x flg x%x\n",
 			ctxp->oxid, ctxp->flag);
 
-	if (ctxp->flag & LPFC_NVMET_CTX_RLS)
+	if (ctxp->flag & LPFC_NVME_CTX_RLS)
 		return;
 
-	ctxp->flag |= LPFC_NVMET_CTX_RLS;
+	ctxp->flag |= LPFC_NVME_CTX_RLS;
 	spin_lock(&phba->sli4_hba.t_active_list_lock);
 	list_del(&ctxp->list);
 	spin_unlock(&phba->sli4_hba.t_active_list_lock);
@@ -306,7 +306,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	result = wcqe->parameter;
 	ctxp = cmdwqe->context2;
 
-	if (ctxp->state != LPFC_NVMET_STE_LS_RSP || ctxp->entry_cnt != 2) {
+	if (ctxp->state != LPFC_NVME_STE_LS_RSP || ctxp->entry_cnt != 2) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6410 NVMET LS cmpl state mismatch IO x%x: "
 				"%d %d\n",
@@ -374,7 +374,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 	int cpu;
 	unsigned long iflag;
 
-	if (ctxp->state == LPFC_NVMET_STE_FREE) {
+	if (ctxp->state == LPFC_NVME_STE_FREE) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6411 NVMET free, already free IO x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
@@ -386,8 +386,8 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 		/* check if freed in another path whilst acquiring lock */
 		if (nvmebuf) {
 			ctxp->rqb_buffer = NULL;
-			if (ctxp->flag & LPFC_NVMET_CTX_REUSE_WQ) {
-				ctxp->flag &= ~LPFC_NVMET_CTX_REUSE_WQ;
+			if (ctxp->flag & LPFC_NVME_CTX_REUSE_WQ) {
+				ctxp->flag &= ~LPFC_NVME_CTX_REUSE_WQ;
 				spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 				nvmebuf->hrq->rqbp->rqb_free_buffer(phba,
 								    nvmebuf);
@@ -400,7 +400,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 			spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 		}
 	}
-	ctxp->state = LPFC_NVMET_STE_FREE;
+	ctxp->state = LPFC_NVME_STE_FREE;
 
 	spin_lock_irqsave(&phba->sli4_hba.nvmet_io_wait_lock, iflag);
 	if (phba->sli4_hba.nvmet_io_wait_cnt) {
@@ -424,7 +424,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 		ctxp->size = size;
 		ctxp->oxid = oxid;
 		ctxp->sid = sid;
-		ctxp->state = LPFC_NVMET_STE_RCV;
+		ctxp->state = LPFC_NVME_STE_RCV;
 		ctxp->entry_cnt = 1;
 		ctxp->flag = 0;
 		ctxp->ctxbuf = ctx_buf;
@@ -449,7 +449,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *phba, struct lpfc_nvmet_ctxbuf *ctx_buf)
 
 		/* Indicate that a replacement buffer has been posted */
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
-		ctxp->flag |= LPFC_NVMET_CTX_REUSE_WQ;
+		ctxp->flag |= LPFC_NVME_CTX_REUSE_WQ;
 		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 		if (!queue_work(phba->wq, &ctx_buf->defer_work)) {
@@ -707,7 +707,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 #endif
 
 	ctxp = cmdwqe->context2;
-	ctxp->flag &= ~LPFC_NVMET_IO_INP;
+	ctxp->flag &= ~LPFC_NVME_IO_INP;
 
 	rsp = &ctxp->hdlrctx.fcp_req;
 	op = rsp->op;
@@ -736,13 +736,13 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 		/* pick up SLI4 exhange busy condition */
 		if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
-			ctxp->flag |= LPFC_NVMET_XBUSY;
+			ctxp->flag |= LPFC_NVME_XBUSY;
 			logerr |= LOG_NVME_ABTS;
 			if (tgtp)
 				atomic_inc(&tgtp->xmt_fcp_rsp_xb_set);
 
 		} else {
-			ctxp->flag &= ~LPFC_NVMET_XBUSY;
+			ctxp->flag &= ~LPFC_NVME_XBUSY;
 		}
 
 		lpfc_printf_log(phba, KERN_INFO, logerr,
@@ -764,7 +764,7 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	if ((op == NVMET_FCOP_READDATA_RSP) ||
 	    (op == NVMET_FCOP_RSP)) {
 		/* Sanity check */
-		ctxp->state = LPFC_NVMET_STE_DONE;
+		ctxp->state = LPFC_NVME_STE_DONE;
 		ctxp->entry_cnt++;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
@@ -848,14 +848,14 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
 			"6023 NVMET LS rsp oxid x%x\n", ctxp->oxid);
 
-	if ((ctxp->state != LPFC_NVMET_STE_LS_RCV) ||
+	if ((ctxp->state != LPFC_NVME_STE_LS_RCV) ||
 	    (ctxp->entry_cnt != 1)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6412 NVMET LS rsp state mismatch "
 				"oxid x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
 	}
-	ctxp->state = LPFC_NVMET_STE_LS_RSP;
+	ctxp->state = LPFC_NVME_STE_LS_RSP;
 	ctxp->entry_cnt++;
 
 	nvmewqeq = lpfc_nvmet_prep_ls_wqe(phba, ctxp, rsp->rspdma,
@@ -965,8 +965,8 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 #endif
 
 	/* Sanity check */
-	if ((ctxp->flag & LPFC_NVMET_ABTS_RCV) ||
-	    (ctxp->state == LPFC_NVMET_STE_ABORT)) {
+	if ((ctxp->flag & LPFC_NVME_ABTS_RCV) ||
+	    (ctxp->state == LPFC_NVME_STE_ABORT)) {
 		atomic_inc(&lpfc_nvmep->xmt_fcp_drop);
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6102 IO oxid x%x aborted\n",
@@ -994,7 +994,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET FCP CMND: xri x%x op x%x len x%x\n",
 			 ctxp->oxid, rsp->op, rsp->rsplen);
 
-	ctxp->flag |= LPFC_NVMET_IO_INP;
+	ctxp->flag |= LPFC_NVME_IO_INP;
 	rc = lpfc_sli4_issue_wqe(phba, ctxp->hdwq, nvmewqeq);
 	if (rc == WQE_SUCCESS) {
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
@@ -1013,7 +1013,7 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgtport,
 		 * WQ was full, so queue nvmewqeq to be sent after
 		 * WQE release CQE
 		 */
-		ctxp->flag |= LPFC_NVMET_DEFER_WQFULL;
+		ctxp->flag |= LPFC_NVME_DEFER_WQFULL;
 		wq = ctxp->hdwq->io_wq;
 		pring = wq->pring;
 		spin_lock_irqsave(&pring->ring_lock, iflags);
@@ -1082,13 +1082,13 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	/* Since iaab/iaar are NOT set, we need to check
 	 * if the firmware is in process of aborting IO
 	 */
-	if (ctxp->flag & (LPFC_NVMET_XBUSY | LPFC_NVMET_ABORT_OP)) {
+	if (ctxp->flag & (LPFC_NVME_XBUSY | LPFC_NVME_ABORT_OP)) {
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return;
 	}
-	ctxp->flag |= LPFC_NVMET_ABORT_OP;
+	ctxp->flag |= LPFC_NVME_ABORT_OP;
 
-	if (ctxp->flag & LPFC_NVMET_DEFER_WQFULL) {
+	if (ctxp->flag & LPFC_NVME_DEFER_WQFULL) {
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		lpfc_nvmet_unsol_fcp_issue_abort(phba, ctxp, ctxp->sid,
 						 ctxp->oxid);
@@ -1098,11 +1098,11 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	}
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 
-	/* An state of LPFC_NVMET_STE_RCV means we have just received
+	/* A state of LPFC_NVME_STE_RCV means we have just received
 	 * the NVME command and have not started processing it.
 	 * (by issuing any IO WQEs on this exchange yet)
 	 */
-	if (ctxp->state == LPFC_NVMET_STE_RCV)
+	if (ctxp->state == LPFC_NVME_STE_RCV)
 		lpfc_nvmet_unsol_fcp_issue_abort(phba, ctxp, ctxp->sid,
 						 ctxp->oxid);
 	else
@@ -1122,19 +1122,19 @@ lpfc_nvmet_xmt_fcp_release(struct nvmet_fc_target_port *tgtport,
 	bool aborting = false;
 
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
-	if (ctxp->flag & LPFC_NVMET_XBUSY)
+	if (ctxp->flag & LPFC_NVME_XBUSY)
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
 				"6027 NVMET release with XBUSY flag x%x"
 				" oxid x%x\n",
 				ctxp->flag, ctxp->oxid);
-	else if (ctxp->state != LPFC_NVMET_STE_DONE &&
-		 ctxp->state != LPFC_NVMET_STE_ABORT)
+	else if (ctxp->state != LPFC_NVME_STE_DONE &&
+		 ctxp->state != LPFC_NVME_STE_ABORT)
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6413 NVMET release bad state %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
 
-	if ((ctxp->flag & LPFC_NVMET_ABORT_OP) ||
-	    (ctxp->flag & LPFC_NVMET_XBUSY)) {
+	if ((ctxp->flag & LPFC_NVME_ABORT_OP) ||
+	    (ctxp->flag & LPFC_NVME_XBUSY)) {
 		aborting = true;
 		/* let the abort path do the real release */
 		lpfc_nvmet_defer_release(phba, ctxp);
@@ -1145,7 +1145,7 @@ lpfc_nvmet_xmt_fcp_release(struct nvmet_fc_target_port *tgtport,
 			 ctxp->state, aborting);
 
 	atomic_inc(&lpfc_nvmep->xmt_fcp_release);
-	ctxp->flag &= ~LPFC_NVMET_TNOTIFY;
+	ctxp->flag &= ~LPFC_NVME_TNOTIFY;
 
 	if (aborting)
 		return;
@@ -1365,7 +1365,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 			return -ENOMEM;
 		}
 		ctx_buf->context->ctxbuf = ctx_buf;
-		ctx_buf->context->state = LPFC_NVMET_STE_FREE;
+		ctx_buf->context->state = LPFC_NVME_STE_FREE;
 
 		ctx_buf->iocbq = lpfc_sli_get_iocbq(phba);
 		if (!ctx_buf->iocbq) {
@@ -1596,12 +1596,12 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 		/* Check if we already received a free context call
 		 * and we have completed processing an abort situation.
 		 */
-		if (ctxp->flag & LPFC_NVMET_CTX_RLS &&
-		    !(ctxp->flag & LPFC_NVMET_ABORT_OP)) {
+		if (ctxp->flag & LPFC_NVME_CTX_RLS &&
+		    !(ctxp->flag & LPFC_NVME_ABORT_OP)) {
 			list_del_init(&ctxp->list);
 			released = true;
 		}
-		ctxp->flag &= ~LPFC_NVMET_XBUSY;
+		ctxp->flag &= ~LPFC_NVME_XBUSY;
 		spin_unlock(&ctxp->ctxlock);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 
@@ -1643,8 +1643,8 @@ lpfc_sli4_nvmet_xri_aborted(struct lpfc_hba *phba,
 				rxid);
 
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
-		ctxp->flag |= LPFC_NVMET_ABTS_RCV;
-		ctxp->state = LPFC_NVMET_STE_ABORT;
+		ctxp->flag |= LPFC_NVME_ABTS_RCV;
+		ctxp->state = LPFC_NVME_STE_ABORT;
 		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 		lpfc_nvmeio_data(phba,
@@ -1687,7 +1687,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 		spin_unlock_irqrestore(&phba->hbalock, iflag);
 
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
-		ctxp->flag |= LPFC_NVMET_ABTS_RCV;
+		ctxp->flag |= LPFC_NVME_ABTS_RCV;
 		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 		lpfc_nvmeio_data(phba,
@@ -1756,7 +1756,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 		xri = ctxp->ctxbuf->sglq->sli4_xritag;
 
 		spin_lock_irqsave(&ctxp->ctxlock, iflag);
-		ctxp->flag |= (LPFC_NVMET_ABTS_RCV | LPFC_NVMET_ABORT_OP);
+		ctxp->flag |= (LPFC_NVME_ABTS_RCV | LPFC_NVME_ABORT_OP);
 		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 		lpfc_nvmeio_data(phba,
@@ -1768,7 +1768,7 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
 				"flag x%x state x%x\n",
 				ctxp->oxid, xri, ctxp->flag, ctxp->state);
 
-		if (ctxp->flag & LPFC_NVMET_TNOTIFY) {
+		if (ctxp->flag & LPFC_NVME_TNOTIFY) {
 			/* Notify the transport */
 			nvmet_fc_rcv_fcp_abort(phba->targetport,
 					       &ctxp->hdlrctx.fcp_req);
@@ -1983,7 +1983,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	ctxp->oxid = oxid;
 	ctxp->sid = sid;
 	ctxp->wqeq = NULL;
-	ctxp->state = LPFC_NVMET_STE_LS_RCV;
+	ctxp->state = LPFC_NVME_STE_LS_RCV;
 	ctxp->entry_cnt = 1;
 	ctxp->rqb_buffer = (void *)nvmebuf;
 	ctxp->hdwq = &phba->sli4_hba.hdwq[0];
@@ -2051,7 +2051,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 		return;
 	}
 
-	if (ctxp->flag & LPFC_NVMET_ABTS_RCV) {
+	if (ctxp->flag & LPFC_NVME_ABTS_RCV) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6324 IO oxid x%x aborted\n",
 				ctxp->oxid);
@@ -2060,7 +2060,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 
 	payload = (uint32_t *)(nvmebuf->dbuf.virt);
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
-	ctxp->flag |= LPFC_NVMET_TNOTIFY;
+	ctxp->flag |= LPFC_NVME_TNOTIFY;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (ctxp->ts_isr_cmd)
 		ctxp->ts_cmd_nvme = ktime_get_ns();
@@ -2080,7 +2080,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 	if (rc == 0) {
 		atomic_inc(&tgtp->rcv_fcp_cmd_out);
 		spin_lock_irqsave(&ctxp->ctxlock, iflags);
-		if ((ctxp->flag & LPFC_NVMET_CTX_REUSE_WQ) ||
+		if ((ctxp->flag & LPFC_NVME_CTX_REUSE_WQ) ||
 		    (nvmebuf != ctxp->rqb_buffer)) {
 			spin_unlock_irqrestore(&ctxp->ctxlock, iflags);
 			return;
@@ -2099,7 +2099,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 		atomic_inc(&tgtp->rcv_fcp_cmd_out);
 		atomic_inc(&tgtp->defer_fod);
 		spin_lock_irqsave(&ctxp->ctxlock, iflags);
-		if (ctxp->flag & LPFC_NVMET_CTX_REUSE_WQ) {
+		if (ctxp->flag & LPFC_NVME_CTX_REUSE_WQ) {
 			spin_unlock_irqrestore(&ctxp->ctxlock, iflags);
 			return;
 		}
@@ -2114,7 +2114,7 @@ lpfc_nvmet_process_rcv_fcp_req(struct lpfc_nvmet_ctxbuf *ctx_buf)
 			phba->sli4_hba.nvmet_mrq_data[qno], 1, qno);
 		return;
 	}
-	ctxp->flag &= ~LPFC_NVMET_TNOTIFY;
+	ctxp->flag &= ~LPFC_NVME_TNOTIFY;
 	atomic_inc(&tgtp->rcv_fcp_cmd_drop);
 	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 			"2582 FCP Drop IO x%x: err x%x: x%x x%x x%x\n",
@@ -2309,7 +2309,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	spin_lock_irqsave(&phba->sli4_hba.t_active_list_lock, iflag);
 	list_add_tail(&ctxp->list, &phba->sli4_hba.t_active_ctx_list);
 	spin_unlock_irqrestore(&phba->sli4_hba.t_active_list_lock, iflag);
-	if (ctxp->state != LPFC_NVMET_STE_FREE) {
+	if (ctxp->state != LPFC_NVME_STE_FREE) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6414 NVMET Context corrupt %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
@@ -2321,7 +2321,7 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	ctxp->oxid = oxid;
 	ctxp->sid = sid;
 	ctxp->idx = idx;
-	ctxp->state = LPFC_NVMET_STE_RCV;
+	ctxp->state = LPFC_NVME_STE_RCV;
 	ctxp->entry_cnt = 1;
 	ctxp->flag = 0;
 	ctxp->ctxbuf = ctx_buf;
@@ -2645,9 +2645,9 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 	}
 
 	/* Sanity check */
-	if (((ctxp->state == LPFC_NVMET_STE_RCV) &&
+	if (((ctxp->state == LPFC_NVME_STE_RCV) &&
 	    (ctxp->entry_cnt == 1)) ||
-	    (ctxp->state == LPFC_NVMET_STE_DATA)) {
+	    (ctxp->state == LPFC_NVME_STE_DATA)) {
 		wqe = &nvmewqe->wqe;
 	} else {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
@@ -2910,7 +2910,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 		sgl++;
 		ctxp->offset += cnt;
 	}
-	ctxp->state = LPFC_NVMET_STE_DATA;
+	ctxp->state = LPFC_NVME_STE_DATA;
 	ctxp->entry_cnt++;
 	return nvmewqe;
 }
@@ -2939,23 +2939,23 @@ lpfc_nvmet_sol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	result = wcqe->parameter;
 
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
-	if (ctxp->flag & LPFC_NVMET_ABORT_OP)
+	if (ctxp->flag & LPFC_NVME_ABORT_OP)
 		atomic_inc(&tgtp->xmt_fcp_abort_cmpl);
 
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
-	ctxp->state = LPFC_NVMET_STE_DONE;
+	ctxp->state = LPFC_NVME_STE_DONE;
 
 	/* Check if we already received a free context call
 	 * and we have completed processing an abort situation.
 	 */
-	if ((ctxp->flag & LPFC_NVMET_CTX_RLS) &&
-	    !(ctxp->flag & LPFC_NVMET_XBUSY)) {
+	if ((ctxp->flag & LPFC_NVME_CTX_RLS) &&
+	    !(ctxp->flag & LPFC_NVME_XBUSY)) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
-	ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+	ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 	atomic_inc(&tgtp->xmt_abort_rsp);
 
@@ -2979,7 +2979,7 @@ lpfc_nvmet_sol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	lpfc_sli_release_iocbq(phba, cmdwqe);
 
 	/* Since iaab/iaar are NOT set, there is no work left.
-	 * For LPFC_NVMET_XBUSY, lpfc_sli4_nvmet_xri_aborted
+	 * For LPFC_NVME_XBUSY, lpfc_sli4_nvmet_xri_aborted
 	 * should have been called already.
 	 */
 }
@@ -3018,11 +3018,11 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
-	if (ctxp->flag & LPFC_NVMET_ABORT_OP)
+	if (ctxp->flag & LPFC_NVME_ABORT_OP)
 		atomic_inc(&tgtp->xmt_fcp_abort_cmpl);
 
 	/* Sanity check */
-	if (ctxp->state != LPFC_NVMET_STE_ABORT) {
+	if (ctxp->state != LPFC_NVME_STE_ABORT) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
 				"6112 ABTS Wrong state:%d oxid x%x\n",
 				ctxp->state, ctxp->oxid);
@@ -3031,15 +3031,15 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	/* Check if we already received a free context call
 	 * and we have completed processing an abort situation.
 	 */
-	ctxp->state = LPFC_NVMET_STE_DONE;
-	if ((ctxp->flag & LPFC_NVMET_CTX_RLS) &&
-	    !(ctxp->flag & LPFC_NVMET_XBUSY)) {
+	ctxp->state = LPFC_NVME_STE_DONE;
+	if ((ctxp->flag & LPFC_NVME_CTX_RLS) &&
+	    !(ctxp->flag & LPFC_NVME_XBUSY)) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
-	ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+	ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 	atomic_inc(&tgtp->xmt_abort_rsp);
 
@@ -3060,7 +3060,7 @@ lpfc_nvmet_unsol_fcp_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		lpfc_nvmet_ctxbuf_post(phba, ctxp->ctxbuf);
 
 	/* Since iaab/iaar are NOT set, there is no work left.
-	 * For LPFC_NVMET_XBUSY, lpfc_sli4_nvmet_xri_aborted
+	 * For LPFC_NVME_XBUSY, lpfc_sli4_nvmet_xri_aborted
 	 * should have been called already.
 	 */
 }
@@ -3105,7 +3105,7 @@ lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		return;
 	}
 
-	if (ctxp->state != LPFC_NVMET_STE_LS_ABORT) {
+	if (ctxp->state != LPFC_NVME_STE_LS_ABORT) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6416 NVMET LS abort cmpl state mismatch: "
 				"oxid x%x: %d %d\n",
@@ -3242,7 +3242,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 
 		/* No failure to an ABTS request. */
 		spin_lock_irqsave(&ctxp->ctxlock, flags);
-		ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+		ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return 0;
 	}
@@ -3256,13 +3256,13 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 				"6161 ABORT failed: No wqeqs: "
 				"xri: x%x\n", ctxp->oxid);
 		/* No failure to an ABTS request. */
-		ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+		ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return 0;
 	}
 	abts_wqeq = ctxp->abort_wqeq;
-	ctxp->state = LPFC_NVMET_STE_ABORT;
-	opt = (ctxp->flag & LPFC_NVMET_ABTS_RCV) ? INHIBIT_ABORT : 0;
+	ctxp->state = LPFC_NVME_STE_ABORT;
+	opt = (ctxp->flag & LPFC_NVME_ABTS_RCV) ? INHIBIT_ABORT : 0;
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 
 	/* Announce entry to new IO submit field. */
@@ -3285,7 +3285,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 				phba->hba_flag, ctxp->oxid);
 		lpfc_sli_release_iocbq(phba, abts_wqeq);
 		spin_lock_irqsave(&ctxp->ctxlock, flags);
-		ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+		ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return 0;
 	}
@@ -3300,7 +3300,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 				ctxp->oxid);
 		lpfc_sli_release_iocbq(phba, abts_wqeq);
 		spin_lock_irqsave(&ctxp->ctxlock, flags);
-		ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+		ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 		spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 		return 0;
 	}
@@ -3329,7 +3329,7 @@ lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *phba,
 
 	atomic_inc(&tgtp->xmt_abort_rsp_error);
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
-	ctxp->flag &= ~LPFC_NVMET_ABORT_OP;
+	ctxp->flag &= ~LPFC_NVME_ABORT_OP;
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 	lpfc_sli_release_iocbq(phba, abts_wqeq);
 	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
@@ -3356,14 +3356,14 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 		ctxp->wqeq->hba_wqidx = 0;
 	}
 
-	if (ctxp->state == LPFC_NVMET_STE_FREE) {
+	if (ctxp->state == LPFC_NVME_STE_FREE) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6417 NVMET ABORT ctx freed %d %d oxid x%x\n",
 				ctxp->state, ctxp->entry_cnt, ctxp->oxid);
 		rc = WQE_BUSY;
 		goto aerr;
 	}
-	ctxp->state = LPFC_NVMET_STE_ABORT;
+	ctxp->state = LPFC_NVME_STE_ABORT;
 	ctxp->entry_cnt++;
 	rc = lpfc_nvmet_unsol_issue_abort(phba, ctxp, sid, xri);
 	if (rc == 0)
@@ -3385,13 +3385,13 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 
 aerr:
 	spin_lock_irqsave(&ctxp->ctxlock, flags);
-	if (ctxp->flag & LPFC_NVMET_CTX_RLS) {
+	if (ctxp->flag & LPFC_NVME_CTX_RLS) {
 		spin_lock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		list_del_init(&ctxp->list);
 		spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 		released = true;
 	}
-	ctxp->flag &= ~(LPFC_NVMET_ABORT_OP | LPFC_NVMET_CTX_RLS);
+	ctxp->flag &= ~(LPFC_NVME_ABORT_OP | LPFC_NVME_CTX_RLS);
 	spin_unlock_irqrestore(&ctxp->ctxlock, flags);
 
 	atomic_inc(&tgtp->xmt_abort_rsp_error);
@@ -3414,16 +3414,16 @@ lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *phba,
 	unsigned long flags;
 	int rc;
 
-	if ((ctxp->state == LPFC_NVMET_STE_LS_RCV && ctxp->entry_cnt == 1) ||
-	    (ctxp->state == LPFC_NVMET_STE_LS_RSP && ctxp->entry_cnt == 2)) {
-		ctxp->state = LPFC_NVMET_STE_LS_ABORT;
+	if ((ctxp->state == LPFC_NVME_STE_LS_RCV && ctxp->entry_cnt == 1) ||
+	    (ctxp->state == LPFC_NVME_STE_LS_RSP && ctxp->entry_cnt == 2)) {
+		ctxp->state = LPFC_NVME_STE_LS_ABORT;
 		ctxp->entry_cnt++;
 	} else {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6418 NVMET LS abort state mismatch "
 				"IO x%x: %d %d\n",
 				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
-		ctxp->state = LPFC_NVMET_STE_LS_ABORT;
+		ctxp->state = LPFC_NVME_STE_LS_ABORT;
 	}
 
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
