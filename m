Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED1C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D585F20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckEFMKQq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTq51XyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D585F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ybh/yjTfCrTvZbBjKsdGYkqPp+z5KPOHqEfS0OR5SQ0=; b=ckEFMKQqs8YL2N2kr1GIG1SqM+
	GFvx5OL17HbsD3jzUtFxvtfmKZXfPgCtoN6mtoLT3mTmWwbON7N2Tco5SDI1qtqvwY7go0lGhy4Pa
	QuvN0ETxVTo6+0g9F9ys42b3Ej6uFkgpACyxWYFbFEMWu4Gc8oefgnaFvBcqRpudyKPDxTMStJ562
	DeevqbTu+MMkUjwhMYUB0e7q7zR4vrkIUqNs54KM98VjteOqINtd6nxCXk9v/Ma9FAf0QYiVYxIdL
	SSEpWUIXt6RwAibt5kjiJm53ro/BV8QRKoLefP0VFTrV56SY7AJUm0oJfe1fifWAic/ATlT+hU5dJ
	Hv9U5k0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPgP-0003RC-VY; Wed, 05 Feb 2020 18:45:54 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZV-000422-OM
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:39:02 +0000
Received: by mail-wm1-x344.google.com with SMTP id b17so4086471wmb.0
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JPTTnH6RBUnGmPjYqnJz8VPJTuB8Ipa9jPkfmQWtVVs=;
 b=eTq51XyLynZQsj2ezaPEcWju0rvRABdnYtEO1Sy9sGpkNdGQIFplPGdkO2xBIU6y4a
 U1kTHjKwqmVDsu9ALUIjrhDRqIIcdAThXX6u4EqsgbGrx0DErfrHnMeFv4LHwW8eIu1u
 Ly8sGzPR9Y6//2zJ8OPrA8EEmw1gNQ5LYnUqO8xDljlNkt3C2MAQ2CU8P/3vreLISr+z
 DL6KJds1RVI9NObSQ8l3tdQvmiXqox/MZpAf71W98BQBw0Y+YwPbGKAgYBcqYlRREp7u
 BWeMQpsBQg4MiQjXgRhR6RvXREan2uZT9hIXghAFV8+w4rORvx/mxJCYQJpjfJWqwzWi
 EU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JPTTnH6RBUnGmPjYqnJz8VPJTuB8Ipa9jPkfmQWtVVs=;
 b=V7ms9cMTvT6un/bLzAcA8HLJC9zXTRiRW1lNUBr2NLCKGfVjRO6zWrAj2jSiubKpxG
 YunhsAtT/sybZty4KaP1S/NWWhUpwWbvrC29UQKnh2EGm0PbKMzSV7dd5UlrArYrAR6c
 NgyPiiBY6xkGSsY5SvTfIhD3133bxuAHBhKJ1+CoLrqMc8J702aPOWoYqk2RrX0Zo5dG
 3PQ4KsLnKuz0N1cohufz2YzKFFafpK7JXlVFkdsruwbg3QhtDeqOgltAxV2+v5VhsqyV
 X521Aa/ezTU/2DKi6jzomM6UfrFMuqK9+rQlBEUodse9AFiGBJeqwD2DC7Dlsf1jE/sk
 0I3A==
X-Gm-Message-State: APjAAAXXL+Br3PAt+0NlZWOHKUbtDmI+O7vUpz2atGWshattZxvjGMwR
 ajce6GCV1q71MuZqt16UD3Y1Z5Fo
X-Google-Smtp-Source: APXvYqzW592cUGhjmee7Q5VEgLnCXWG8TzWdNdBW0BoaujnvKK2CpM28NrJ1ns0sgsNMcL17V6++NA==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr7086219wma.87.1580927923502; 
 Wed, 05 Feb 2020 10:38:43 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:43 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 26/29] lpfc: Refactor Send LS Response support
Date: Wed,  5 Feb 2020 10:37:50 -0800
Message-Id: <20200205183753.25959-27-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103846_090322_8A946014 
X-CRM114-Status: GOOD (  25.09  )
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

Currently, the ability to send an NVME LS response is limited to the nvmet
(controller/target) side of the driver.  In preparation of both the nvme
and nvmet sides supporting Send LS Response, rework the existing send
ls_rsp and ls_rsp completion routines such that there is common code that
can be used by both sides.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.h  |   7 ++
 drivers/scsi/lpfc/lpfc_nvmet.c | 255 ++++++++++++++++++++++++++++-------------
 2 files changed, 184 insertions(+), 78 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 3ebcf885cac5..2ce29dfeedda 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -245,3 +245,10 @@ int __lpfc_nvme_ls_abort(struct lpfc_vport *vport,
 int lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 			struct lpfc_async_xchg_ctx *ctxp, uint32_t sid,
 			uint16_t xri);
+int __lpfc_nvme_xmt_ls_rsp(struct lpfc_async_xchg_ctx *axchg,
+			struct nvmefc_ls_rsp *ls_rsp,
+			void (*xmt_ls_rsp_cmp)(struct lpfc_hba *phba,
+				struct lpfc_iocbq *cmdwqe,
+				struct lpfc_wcqe_complete *wcqe));
+void __lpfc_nvme_xmt_ls_rsp_cmp(struct lpfc_hba *phba,
+		struct lpfc_iocbq *cmdwqe, struct lpfc_wcqe_complete *wcqe);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index e6895c719683..edec7c3ffab1 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -281,6 +281,53 @@ lpfc_nvmet_defer_release(struct lpfc_hba *phba,
 }
 
 /**
+ * __lpfc_nvme_xmt_ls_rsp_cmp - Generic completion handler for the
+ *         transmission of an NVME LS response.
+ * @phba: Pointer to HBA context object.
+ * @cmdwqe: Pointer to driver command WQE object.
+ * @wcqe: Pointer to driver response CQE object.
+ *
+ * The function is called from SLI ring event handler with no
+ * lock held. The function frees memory resources used for the command
+ * used to send the NVME LS RSP.
+ **/
+void
+__lpfc_nvme_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
+			   struct lpfc_wcqe_complete *wcqe)
+{
+	struct lpfc_async_xchg_ctx *axchg = cmdwqe->context2;
+	struct nvmefc_ls_rsp *ls_rsp = &axchg->ls_rsp;
+	uint32_t status, result;
+
+	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
+	result = wcqe->parameter;
+
+	if (axchg->state != LPFC_NVME_STE_LS_RSP || axchg->entry_cnt != 2) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+				"6410 NVMEx LS cmpl state mismatch IO x%x: "
+				"%d %d\n",
+				axchg->oxid, axchg->state, axchg->entry_cnt);
+	}
+
+	lpfc_nvmeio_data(phba, "NVMEx LS  CMPL: xri x%x stat x%x result x%x\n",
+			 axchg->oxid, status, result);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
+			"6038 NVMEx LS rsp cmpl: %d %d oxid x%x\n",
+			status, result, axchg->oxid);
+
+	lpfc_nlp_put(cmdwqe->context1);
+	cmdwqe->context2 = NULL;
+	cmdwqe->context3 = NULL;
+	lpfc_sli_release_iocbq(phba, cmdwqe);
+	ls_rsp->done(ls_rsp);
+	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
+			"6200 NVMEx LS rsp cmpl done status %d oxid x%x\n",
+			status, axchg->oxid);
+	kfree(axchg);
+}
+
+/**
  * lpfc_nvmet_xmt_ls_rsp_cmp - Completion handler for LS Response
  * @phba: Pointer to HBA context object.
  * @cmdwqe: Pointer to driver command WQE object.
@@ -288,33 +335,23 @@ lpfc_nvmet_defer_release(struct lpfc_hba *phba,
  *
  * The function is called from SLI ring event handler with no
  * lock held. This function is the completion handler for NVME LS commands
- * The function frees memory resources used for the NVME commands.
+ * The function updates any states and statistics, then calls the
+ * generic completion handler to free resources.
  **/
 static void
 lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			  struct lpfc_wcqe_complete *wcqe)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvmefc_ls_rsp *rsp;
-	struct lpfc_async_xchg_ctx *ctxp;
 	uint32_t status, result;
 
-	status = bf_get(lpfc_wcqe_c_status, wcqe);
-	result = wcqe->parameter;
-	ctxp = cmdwqe->context2;
-
-	if (ctxp->state != LPFC_NVME_STE_LS_RSP || ctxp->entry_cnt != 2) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6410 NVMET LS cmpl state mismatch IO x%x: "
-				"%d %d\n",
-				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
-	}
-
 	if (!phba->targetport)
-		goto out;
+		goto finish;
 
-	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
+	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
+	result = wcqe->parameter;
 
+	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
 	if (tgtp) {
 		if (status) {
 			atomic_inc(&tgtp->xmt_ls_rsp_error);
@@ -327,22 +364,8 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		}
 	}
 
-out:
-	rsp = &ctxp->ls_rsp;
-
-	lpfc_nvmeio_data(phba, "NVMET LS  CMPL: xri x%x stat x%x result x%x\n",
-			 ctxp->oxid, status, result);
-
-	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
-			"6038 NVMET LS rsp cmpl: %d %d oxid x%x\n",
-			status, result, ctxp->oxid);
-
-	lpfc_nlp_put(cmdwqe->context1);
-	cmdwqe->context2 = NULL;
-	cmdwqe->context3 = NULL;
-	lpfc_sli_release_iocbq(phba, cmdwqe);
-	rsp->done(rsp);
-	kfree(ctxp);
+finish:
+	__lpfc_nvme_xmt_ls_rsp_cmp(phba, cmdwqe, wcqe);
 }
 
 /**
@@ -821,17 +844,32 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 #endif
 }
 
-static int
-lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
-		      struct nvmefc_ls_rsp *rsp)
+/**
+ * __lpfc_nvme_xmt_ls_rsp - Generic service routine to issue transmit
+ *         an NVME LS rsp for a prior NVME LS request that was received.
+ * @axchg: pointer to exchange context for the NVME LS request the response
+ *         is for.
+ * @ls_rsp: pointer to the transport LS RSP that is to be sent
+ * @xmt_ls_rsp_cmp: completion routine to call upon RSP transmit done
+ *
+ * This routine is used to format and send a WQE to transmit a NVME LS
+ * Response.  The response is for a prior NVME LS request that was
+ * received and posted to the transport.
+ *
+ * Returns:
+ *  0 : if response successfully transmit
+ *  non-zero : if response failed to transmit, of the form -Exxx.
+ **/
+int
+__lpfc_nvme_xmt_ls_rsp(struct lpfc_async_xchg_ctx *axchg,
+			struct nvmefc_ls_rsp *ls_rsp,
+			void (*xmt_ls_rsp_cmp)(struct lpfc_hba *phba,
+				struct lpfc_iocbq *cmdwqe,
+				struct lpfc_wcqe_complete *wcqe))
 {
-	struct lpfc_async_xchg_ctx *ctxp =
-		container_of(rsp, struct lpfc_async_xchg_ctx, ls_rsp);
-	struct lpfc_hba *phba = ctxp->phba;
-	struct hbq_dmabuf *nvmebuf =
-		(struct hbq_dmabuf *)ctxp->rqb_buffer;
+	struct lpfc_hba *phba = axchg->phba;
+	struct hbq_dmabuf *nvmebuf = (struct hbq_dmabuf *)axchg->rqb_buffer;
 	struct lpfc_iocbq *nvmewqeq;
-	struct lpfc_nvmet_tgtport *nvmep = tgtport->private;
 	struct lpfc_dmabuf dmabuf;
 	struct ulp_bde64 bpl;
 	int rc;
@@ -839,34 +877,28 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
-	if (phba->pport->load_flag & FC_UNLOADING)
-		return -ENODEV;
-
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
-			"6023 NVMET LS rsp oxid x%x\n", ctxp->oxid);
+			"6023 NVMEx LS rsp oxid x%x\n", axchg->oxid);
 
-	if ((ctxp->state != LPFC_NVME_STE_LS_RCV) ||
-	    (ctxp->entry_cnt != 1)) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6412 NVMET LS rsp state mismatch "
+	if (axchg->state != LPFC_NVME_STE_LS_RCV || axchg->entry_cnt != 1) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+				"6412 NVMEx LS rsp state mismatch "
 				"oxid x%x: %d %d\n",
-				ctxp->oxid, ctxp->state, ctxp->entry_cnt);
+				axchg->oxid, axchg->state, axchg->entry_cnt);
+		return -EALREADY;
 	}
-	ctxp->state = LPFC_NVME_STE_LS_RSP;
-	ctxp->entry_cnt++;
+	axchg->state = LPFC_NVME_STE_LS_RSP;
+	axchg->entry_cnt++;
 
-	nvmewqeq = lpfc_nvmet_prep_ls_wqe(phba, ctxp, rsp->rspdma,
-				      rsp->rsplen);
+	nvmewqeq = lpfc_nvmet_prep_ls_wqe(phba, axchg, ls_rsp->rspdma,
+					 ls_rsp->rsplen);
 	if (nvmewqeq == NULL) {
-		atomic_inc(&nvmep->xmt_ls_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6150 LS Drop IO x%x: Prep\n",
-				ctxp->oxid);
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		atomic_inc(&nvmep->xmt_ls_abort);
-		lpfc_nvme_unsol_ls_issue_abort(phba, ctxp,
-						ctxp->sid, ctxp->oxid);
-		return -ENOMEM;
+		lpfc_printf_log(phba, KERN_ERR,
+				LOG_NVME_DISC | LOG_NVME_IOERR | LOG_NVME_ABTS,
+				"6150 NVMEx LS Drop Rsp x%x: Prep\n",
+				axchg->oxid);
+		rc = -ENOMEM;
+		goto out_free_buf;
 	}
 
 	/* Save numBdes for bpl2sgl */
@@ -876,39 +908,106 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 	dmabuf.virt = &bpl;
 	bpl.addrLow = nvmewqeq->wqe.xmit_sequence.bde.addrLow;
 	bpl.addrHigh = nvmewqeq->wqe.xmit_sequence.bde.addrHigh;
-	bpl.tus.f.bdeSize = rsp->rsplen;
+	bpl.tus.f.bdeSize = ls_rsp->rsplen;
 	bpl.tus.f.bdeFlags = 0;
 	bpl.tus.w = le32_to_cpu(bpl.tus.w);
+	/*
+	 * Note: although we're using stack space for the dmabuf, the
+	 * call to lpfc_sli4_issue_wqe is synchronous, so it will not
+	 * be referenced after it returns back to this routine.
+	 */
 
-	nvmewqeq->wqe_cmpl = lpfc_nvmet_xmt_ls_rsp_cmp;
+	nvmewqeq->wqe_cmpl = xmt_ls_rsp_cmp;
 	nvmewqeq->iocb_cmpl = NULL;
-	nvmewqeq->context2 = ctxp;
+	nvmewqeq->context2 = axchg;
 
-	lpfc_nvmeio_data(phba, "NVMET LS  RESP: xri x%x wqidx x%x len x%x\n",
-			 ctxp->oxid, nvmewqeq->hba_wqidx, rsp->rsplen);
+	lpfc_nvmeio_data(phba, "NVMEx LS RSP: xri x%x wqidx x%x len x%x\n",
+			 axchg->oxid, nvmewqeq->hba_wqidx, ls_rsp->rsplen);
+
+	rc = lpfc_sli4_issue_wqe(phba, axchg->hdwq, nvmewqeq);
+
+	/* clear to be sure there's no reference */
+	nvmewqeq->context3 = NULL;
 
-	rc = lpfc_sli4_issue_wqe(phba, ctxp->hdwq, nvmewqeq);
 	if (rc == WQE_SUCCESS) {
 		/*
 		 * Okay to repost buffer here, but wait till cmpl
 		 * before freeing ctxp and iocbq.
 		 */
 		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		atomic_inc(&nvmep->xmt_ls_rsp);
 		return 0;
 	}
-	/* Give back resources */
-	atomic_inc(&nvmep->xmt_ls_drop);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-			"6151 LS Drop IO x%x: Issue %d\n",
-			ctxp->oxid, rc);
+
+	lpfc_printf_log(phba, KERN_ERR,
+			LOG_NVME_DISC | LOG_NVME_IOERR | LOG_NVME_ABTS,
+			"6151 NVMEx LS RSP x%x: failed to transmit %d\n",
+			axchg->oxid, rc);
+
+	rc = -ENXIO;
 
 	lpfc_nlp_put(nvmewqeq->context1);
 
+out_free_buf:
+	/* Give back resources */
 	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-	atomic_inc(&nvmep->xmt_ls_abort);
-	lpfc_nvme_unsol_ls_issue_abort(phba, ctxp, ctxp->sid, ctxp->oxid);
-	return -ENXIO;
+
+	/*
+	 * As transport doesn't track completions of responses, if the rsp
+	 * fails to send, the transport will effectively ignore the rsp
+	 * and consider the LS done. However, the driver has an active
+	 * exchange open for the LS - so be sure to abort the exchange
+	 * if the response isn't sent.
+	 */
+	lpfc_nvme_unsol_ls_issue_abort(phba, axchg, axchg->sid, axchg->oxid);
+	return rc;
+}
+
+/**
+ * lpfc_nvmet_xmt_ls_rsp - Transmit NVME LS response
+ * @tgtport: pointer to target port that NVME LS is to be transmit from.
+ * @ls_rsp: pointer to the transport LS RSP that is to be sent
+ *
+ * Driver registers this routine to transmit responses for received NVME
+ * LS requests.
+ *
+ * This routine is used to format and send a WQE to transmit a NVME LS
+ * Response. The ls_rsp is used to reverse-map the LS to the original
+ * NVME LS request sequence, which provides addressing information for
+ * the remote port the LS to be sent to, as well as the exchange id
+ * that is the LS is bound to.
+ *
+ * Returns:
+ *  0 : if response successfully transmit
+ *  non-zero : if response failed to transmit, of the form -Exxx.
+ **/
+static int
+lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
+		      struct nvmefc_ls_rsp *ls_rsp)
+{
+	struct lpfc_async_xchg_ctx *axchg =
+		container_of(ls_rsp, struct lpfc_async_xchg_ctx, ls_rsp);
+	struct lpfc_nvmet_tgtport *nvmep = tgtport->private;
+	int rc;
+
+	if (axchg->phba->pport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
+	rc = __lpfc_nvme_xmt_ls_rsp(axchg, ls_rsp, lpfc_nvmet_xmt_ls_rsp_cmp);
+
+	if (rc) {
+		atomic_inc(&nvmep->xmt_ls_drop);
+		/*
+		 * unless the failure is due to having already sent
+		 * the response, an abort will be generated for the
+		 * exchange if the rsp can't be sent.
+		 */
+		if (rc != -EALREADY)
+			atomic_inc(&nvmep->xmt_ls_abort);
+		return rc;
+	}
+
+	atomic_inc(&nvmep->xmt_ls_rsp);
+	return 0;
 }
 
 static int
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
