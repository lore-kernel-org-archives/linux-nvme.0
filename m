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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4651C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902B120674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oaCa9Z/B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0kpUEaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M/8M5YXyw/teNWxh8RqIN9vDLhuFTgm88cisu6ZyPe4=; b=oaCa9Z/BiIjGhsl/HZRTs97Ebm
	YP2ZSofIMBeSC+cce8m8mkk1wWCYziaEfdBJjXugeTFC0YcYVv/yo7VJ7UejoXkaw2lzhOPuzfLVm
	mRoDYWnfBNOxD28QUGsFcFTTuoCfY0t48E6AB0v+epeROxDkpYhvaUjccp6GO4d+/Dv0i/eCG/roy
	w31w6oWcV9ah7dCdCpV5VR5NtTdCSfPmmsmbw2hSrJLyiK0ObzgYq1HMtyJJH2o9BkbROwy+tFAVI
	2OeS/GKxvXmliMzZ+mA9mYokqePMTRnZ+Y+MP4TkBFBwmxKscixiQSXm2+OhHsuaESzXJ/pHPIHpt
	RiXMhuEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPgg-0003eE-0k; Wed, 05 Feb 2020 18:46:10 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZZ-00045t-T8
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:39:05 +0000
Received: by mail-wm1-x342.google.com with SMTP id c84so4069147wme.4
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5I1lRCLiMr/UZBhlrTED4GCggRQWFTjJ36djFe3eg94=;
 b=k0kpUEaALzBZC7vu17q5c1ovllcyFdloFHSgh5lie52WnH7TtItIeFCo8P4SbV+5L2
 dqNBsmK58MC5odii/pxC7/SQDPOiVfg2ZlGzJApZGiDHDa1e0Vrm51ba5cclHrqeAr1Z
 ewJowDWriYhDY2ECSDAXJvBsF8xGAD1idZvnprMKMhoSNU3j5oGxft14L9PAQmHTB1t/
 gjkqqKU11jzhyH+y9nbcZmImWf8r0GyVQNO6GaC3I+MCW7CJzaIY3j/cM+wO8AY6fVhI
 4oMgzcJDNsZ1GYyxCHqIeEbrOdIv7zAPbsej/tb9wTutQqzISmW4AWeqNGzzdMbIJsWq
 ospw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5I1lRCLiMr/UZBhlrTED4GCggRQWFTjJ36djFe3eg94=;
 b=eY6O9YE/B4+iFnHEpTYCx2gD11HQSMfLsKNGRt09dCywopZwrwp+jxUnBXs+yguLcJ
 XZUpG6t/kJHc6mRl3bsS6D+MbgnNYW44bXO7LywsSO3qWdhxi/yqTcr72p5zM3Y7g6yf
 Y6tLI1AHG6Opb5RZ1EEOO7HIJcm3o6ECumobR8EnFKYgq9KjOer805duIOAZ9o6C8h0d
 dkw+NACPuLL9fyiGwgZxZQJo/CA7Up4vMmk/+fWODlrI0JjQqVW38A7lUCX0Wm4ESsEw
 +gFkzKwutoMcPFKQZdO47vt2Ba3ZrW2goVHfZPyk2P/HFui7KZ3adFY3ZJ3zMI7gJiqk
 yqBw==
X-Gm-Message-State: APjAAAULaz8eJ9SPOLn4zjhgM0ArJ2SYktmwUCOVkXw5trLOr87uEszU
 bc5JWi9i4fXgCLdo5zeIIc+GF0YV
X-Google-Smtp-Source: APXvYqzCA8rJ/lCpxhznn6yF7oOrs0EZ6mx2m6r6cs5ifF+q0amj2nwVdHF1dz4+0fHMTwib6asiMA==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr6992171wmb.178.1580927928289; 
 Wed, 05 Feb 2020 10:38:48 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:47 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 29/29] lpfc: nvmet: Add Send LS Request and Abort LS Request
 support
Date: Wed,  5 Feb 2020 10:37:53 -0800
Message-Id: <20200205183753.25959-30-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103849_995506_9840FE47 
X-CRM114-Status: GOOD (  17.93  )
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

Now that common helpers exist, add the ability to Send an NVME LS Request
and to Abort an outstanding LS Request to the nvmet side of the driver.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.h  |   8 +++
 drivers/scsi/lpfc/lpfc_nvmet.c | 128 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index b3c439a91482..60f9e87b3b1c 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -166,6 +166,14 @@ struct lpfc_nvmet_tgtport {
 	atomic_t defer_ctx;
 	atomic_t defer_fod;
 	atomic_t defer_wqfull;
+
+	/* Stats counters - ls_reqs, ls_aborts, host_invalidate */
+	atomic_t xmt_ls_reqs;
+	atomic_t xmt_ls_cmpls;
+	atomic_t xmt_ls_err;
+	atomic_t cmpl_ls_err;
+	atomic_t cmpl_ls_xb;
+	atomic_t cmpl_ls_reqs;
 };
 
 struct lpfc_nvmet_ctx_info {
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index df0378fd4b59..1182412573c3 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1283,6 +1283,122 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
+/**
+ * lpfc_nvmet_ls_req_cmp - completion handler for a nvme ls request
+ * @phba: Pointer to HBA context object
+ * @cmdwqe: Pointer to driver command WQE object.
+ * @wcqe: Pointer to driver response CQE object.
+ *
+ * This function is the completion handler for NVME LS requests.
+ * The function updates any states and statistics, then calls the
+ * generic completion handler to finish completion of the request.
+ **/
+static void
+lpfc_nvmet_ls_req_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
+		       struct lpfc_wcqe_complete *wcqe)
+{
+	struct lpfc_vport *vport = cmdwqe->vport;
+	uint32_t status;
+	struct lpfc_nvmet_tgtport *tgtp;
+
+	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
+
+	if (!phba->targetport)
+		goto finish;
+
+	tgtp = phba->targetport->private;
+	if (tgtp) {
+		atomic_inc(&tgtp->cmpl_ls_reqs);
+		if (status) {
+			if (bf_get(lpfc_wcqe_c_xb, wcqe))
+				atomic_inc(&tgtp->cmpl_ls_xb);
+			atomic_inc(&tgtp->cmpl_ls_err);
+		}
+	}
+
+finish:
+	__lpfc_nvme_ls_req_cmp(phba, vport, cmdwqe, wcqe);
+}
+
+/**
+ * lpfc_nvmet_ls_req - Issue an Link Service request
+ * @targetport - pointer to target instance registered with nvmet transport.
+ * @hosthandle - hosthandle set by the driver in a prior ls_rqst_rcv.
+ *               Driver sets this value to the ndlp pointer.
+ * @pnvme_lsreq - the transport nvme_ls_req structure for the LS
+ *
+ * Driver registers this routine to handle any link service request
+ * from the nvme_fc transport to a remote nvme-aware port.
+ *
+ * Return value :
+ *   0 - Success
+ *   non-zero: various error codes, in form of -Exxx
+ **/
+static int
+lpfc_nvmet_ls_req(struct nvmet_fc_target_port *targetport,
+		  void *hosthandle,
+		  struct nvmefc_ls_req *pnvme_lsreq)
+{
+	struct lpfc_nvmet_tgtport *lpfc_nvmet = targetport->private;
+	struct lpfc_hba *phba;
+	struct lpfc_nodelist *ndlp;
+	int ret;
+	u32 hstate;
+
+	if (!lpfc_nvmet)
+		return -EINVAL;
+
+	phba = lpfc_nvmet->phba;
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return -EINVAL;
+
+	hstate = atomic_read(&lpfc_nvmet->state);
+	if (hstate == LPFC_NVMET_INV_HOST_ACTIVE)
+		return -EACCES;
+
+	ndlp = (struct lpfc_nodelist *)hosthandle;
+
+	atomic_inc(&lpfc_nvmet->xmt_ls_reqs);
+
+	ret = __lpfc_nvme_ls_req(phba->pport, ndlp, pnvme_lsreq,
+				 lpfc_nvmet_ls_req_cmp);
+	if (ret)
+		atomic_inc(&lpfc_nvmet->xmt_ls_err);
+
+	return ret;
+}
+
+/**
+ * lpfc_nvmet_ls_abort - Abort a prior NVME LS request
+ * @targetport: Transport targetport, that LS was issued from.
+ * @hosthandle - hosthandle set by the driver in a prior ls_rqst_rcv.
+ *               Driver sets this value to the ndlp pointer.
+ * @pnvme_lsreq - the transport nvme_ls_req structure for LS to be aborted
+ *
+ * Driver registers this routine to abort an NVME LS request that is
+ * in progress (from the transports perspective).
+ **/
+static void
+lpfc_nvmet_ls_abort(struct nvmet_fc_target_port *targetport,
+		    void *hosthandle,
+		    struct nvmefc_ls_req *pnvme_lsreq)
+{
+	struct lpfc_nvmet_tgtport *lpfc_nvmet = targetport->private;
+	struct lpfc_hba *phba;
+	struct lpfc_nodelist *ndlp;
+	int ret;
+
+	phba = lpfc_nvmet->phba;
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return;
+
+	ndlp = (struct lpfc_nodelist *)hosthandle;
+
+	ret = __lpfc_nvme_ls_abort(phba->pport, ndlp, pnvme_lsreq);
+	if (!ret)
+		atomic_inc(&lpfc_nvmet->xmt_ls_abort);
+}
+
 static void
 lpfc_nvmet_host_release(void *hosthandle)
 {
@@ -1325,6 +1441,8 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.fcp_req_release = lpfc_nvmet_xmt_fcp_release,
 	.defer_rcv	= lpfc_nvmet_defer_rcv,
 	.discovery_event = lpfc_nvmet_discovery_event,
+	.ls_req         = lpfc_nvmet_ls_req,
+	.ls_abort       = lpfc_nvmet_ls_abort,
 	.host_release   = lpfc_nvmet_host_release,
 
 	.max_hw_queues  = 1,
@@ -1336,6 +1454,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.target_features = 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz = sizeof(struct lpfc_nvmet_tgtport),
+	.lsrqst_priv_sz = 0,
 };
 
 static void
@@ -1638,6 +1757,9 @@ lpfc_nvmet_create_targetport(struct lpfc_hba *phba)
 		atomic_set(&tgtp->xmt_fcp_xri_abort_cqe, 0);
 		atomic_set(&tgtp->xmt_fcp_abort, 0);
 		atomic_set(&tgtp->xmt_fcp_abort_cmpl, 0);
+		atomic_set(&tgtp->xmt_ls_reqs, 0);
+		atomic_set(&tgtp->xmt_ls_cmpls, 0);
+		atomic_set(&tgtp->xmt_ls_err, 0);
 		atomic_set(&tgtp->xmt_abort_unsol, 0);
 		atomic_set(&tgtp->xmt_abort_sol, 0);
 		atomic_set(&tgtp->xmt_abort_rsp, 0);
@@ -1645,6 +1767,12 @@ lpfc_nvmet_create_targetport(struct lpfc_hba *phba)
 		atomic_set(&tgtp->defer_ctx, 0);
 		atomic_set(&tgtp->defer_fod, 0);
 		atomic_set(&tgtp->defer_wqfull, 0);
+		atomic_set(&tgtp->xmt_ls_reqs, 0);
+		atomic_set(&tgtp->xmt_ls_cmpls, 0);
+		atomic_set(&tgtp->xmt_ls_err, 0);
+		atomic_set(&tgtp->cmpl_ls_err, 0);
+		atomic_set(&tgtp->cmpl_ls_xb, 0);
+		atomic_set(&tgtp->cmpl_ls_reqs, 0);
 	}
 	return error;
 }
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
