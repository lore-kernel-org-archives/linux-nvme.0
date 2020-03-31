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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC7C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF4620848
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mAFnlL9h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRUYJaz0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrHmDNBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF4620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=r4Nc+HVT82WZC8TECh8ySTk8o7btEaIhF01dC8ev7No=; b=mAFnlL9hB3sGwqaeWx9n6u6Gqk
	n0GCgDFbp/WnnM91wt7krfayBRLmY2Z36cu1zb9EYI7qgJA8EeNrJZ45VdTm/WxpD7bZvF9Y9UXrq
	0aTU+Qa44pMO3ASsY7Hgp9D9rh4PtOMMyjyoHOMcGeUKWgCyUaPLBpeifwnBo6vmUAuM7BRNZrtwQ
	Xk4PU33BMI+zJtON/adZODeaN4g1cGSR0HeI9erGaskDZL6BLib1kHtwU45kUP4NSwYytgxAyeiiY
	086lbUIYbypIzz6XjvQL8EqTwcCmROoxcvY/F8Xc79vPhLcEFZCK8cCIt8ykloj7yIY7uHUYVHDOL
	7ampz2QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKQV-00054u-5k; Tue, 31 Mar 2020 17:11:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJKQU-00054g-2Q
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 17:11:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=otie5AmMa8HOmaHWDXSH0oRYVw1oFwFdKfPk5625X7Y=; b=ZRUYJaz0u+5m20u9JuyYwJ73Wr
 wCmlQiORGYIRrlE7EYmGhJmVO7TFmBY4vBJpe/i7jkc2xPrH5itlbpQEHEY+EyXNw3C/Agcu8nnfR
 A3+Aa07LHX8whdZdap6Js3br4OmTlD8xbTToUFVMIpmS+FBxhfj8+YcvTCiUANCbLRVj2tY7XT2a2
 Hqds9Xyaq+LC6sM//57V/Y4zv0k2SmLlNNza07Vp2m/1R4BQU8BAdDYmGEWE3SUe1LewoA2T3eJlG
 Pksghc5YP4snDiHdxPnQDy+Rds9H04voxrqbS1u0ngz3NU/5Go6gqe5iynWCBX6jmzaJElFvIi+aX
 amSc0HxA==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6W-0007bB-6k
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:11 +0000
Received: by mail-wr1-x443.google.com with SMTP id m11so21043626wrx.10
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=otie5AmMa8HOmaHWDXSH0oRYVw1oFwFdKfPk5625X7Y=;
 b=GrHmDNBe/jweN1JoOxz4HQRzIyp70c9Zw+NNLc8xCNW8XwctbRPG/sx3okiHQW6Z8Y
 4GQkLthY+pDBcp55GWuh40IofKeAjT+2+6q9oTw0JNo8BuV3PdFb/axHyt1gb8enCR2G
 2FvnN8ns9MJV4bJj8qDMhpCTpUvRksJpJpHW1zAG4H7jgroHpLYtxZo6H1kRthJRCt7h
 1XysqHur1LCJZQNVtZOXQWhya/JQKZNeEwgoN8JUnVqeQgs8/QmhTfxRHWPioARBjDrW
 EriX2qJht3K0b21bt6dxNGoFWAK/RxbHjcalgY4CukxuWB6AWTfQyB8nPew2kww2Hmma
 itaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=otie5AmMa8HOmaHWDXSH0oRYVw1oFwFdKfPk5625X7Y=;
 b=fP3uvvMRUrKNBnN1T2ACD0rK79q8tekgR5wop4CSx4ok7IKCn4FJlcZzidbsMB1iWc
 4JKUvnHY5i+yUUtaK5ZYqM/OYEWfPed0BPf+5AyMSf4QUDy2DfXXMzBM9gESSNeKF2+7
 b+eorYA5OveMYZ/VX8cILbnuWobTknYLClWsbSmgkmR+0cTbm3tIURCX94pu5sVuD4Sy
 ci89xHVpt5KB7l+S56neQLHYJe/iX8Zkjet0Wz98YGtXUxeVgJZi5mUamzTq2jQDMAnB
 +/khegOjnslGuId0pnrvPzcMbhGHXgEox4u9AzZz58jyOf2tThYfJBm3eHFxG2U1TzI9
 7zPg==
X-Gm-Message-State: ANhLgQ3VIjQRZw8me/S9n3TaHsZrIbhcaYIhCNtbOash1oFwKhvs7qaC
 0k7VCidrm8R1+QJMxeCMNpxxcroD
X-Google-Smtp-Source: ADFU+vuZpZAFMYieuM68u/vPHgAxWEbv/6qnLc2E9cFhzdDFc80qzucU3LA2bPTR/1OUXgsxkjE2Jw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr22733592wrq.172.1585673460801; 
 Tue, 31 Mar 2020 09:51:00 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:51:00 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 23/26] lpfc: Refactor Send LS Response support
Date: Tue, 31 Mar 2020 09:50:08 -0700
Message-Id: <20200331165011.15819-24-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_175108_452360_EAFC7273 
X-CRM114-Status: GOOD (  31.17  )
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

Currently, the ability to send an NVME LS response is limited to the nvmet
(controller/target) side of the driver.  In preparation of both the nvme
and nvmet sides supporting Send LS Response, rework the existing send
ls_rsp and ls_rsp completion routines such that there is common code that
can be used by both sides.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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
@@ -280,6 +280,53 @@ lpfc_nvmet_defer_release(struct lpfc_hba *phba,
 	spin_unlock(&phba->sli4_hba.abts_nvmet_buf_list_lock);
 }
 
+/**
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
 /**
  * lpfc_nvmet_xmt_ls_rsp_cmp - Completion handler for LS Response
  * @phba: Pointer to HBA context object.
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
@@ -821,52 +844,61 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
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
 
-	if (phba->pport->load_flag & FC_UNLOADING)
-		return -ENODEV;
-
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
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
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
