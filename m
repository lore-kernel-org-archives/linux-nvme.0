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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F6C2D0F2
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903FF20BED
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B57z4U5j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b08vBzZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903FF20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3PH0DXlqDx5DJQ9b/PktV8+7z7VCaxWT5yURcl1jkBs=; b=B57z4U5jbWPDl5ssbq3m6MZdx6
	SXYAu9EUcUbJpFFJeVerwIL1FkDVB6tVoQC8hShgPcDi+SoHzC7GbKB2LaiP8BgwRvrImlwWcPSbv
	3bsNDaNQRBuISryKxYwBiCh6Z0PEhw35qLD5i6ORAzF8KQmHxjOG0DLQc5+6KZqpQHxMsUf49oIwj
	OUnukkHR3hGTlbe8KKmXzHpU4bP+vtiO5ZlFQg59YqrHDqGctmTrCbf/dkpMjII3wzaSwxrM/2euC
	qwDUPYOaNiFPSf7ZXEo/xBOVJUj/zJcuIDbC8W4gOKARC79WYxfuBYii6lnX43wYu+OZoUaKl1j0g
	+bXXgpag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKBa-0002HT-QI; Tue, 31 Mar 2020 16:56:22 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6L-0004xI-LP
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id i19so3627888wmb.0
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M0QunpQ8Tiz0s6SoddYjqZcu07zo7szOKHsbnABBLC0=;
 b=b08vBzZMmkOMk1vm3FZFsZXWg6jWP0Qon1KkmNQoYdaFM+5PG2LjiFMVSKZY9Ve1oM
 Wk/B5QEP8mjaml95qI8rJ9xX0JjZtABxiLXOlCIM89Ro7vSP58IFhP70qnd8isAl9+iC
 X4YbF8qZOSwfYc8pqs4y7hTSAE7iULozfySX9RDXLz/6TzaAkOSphnOZZ6Ay3kIpMnPJ
 /4iMaiaiY9TcM+RpLYLVzYrJdwmXV6otSijkHZYZ1opyxMYs7+e0/Jp9OKK+3ABCEXCk
 EenDEp3YNuS0JSFsxG00jSuQeNy0B/26zdZuCnDDV8Je8Rt3fGWMCI/6+80WyTLgZy60
 aCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M0QunpQ8Tiz0s6SoddYjqZcu07zo7szOKHsbnABBLC0=;
 b=Yy4z/WuWkL5SEyRv6oTjAkB5Lmmm6i9kgaXU4ZcK2gTS1yw4UUoidm3MezwMCuzn75
 BiofpbczHUZxh+zPau0NPu2aplAR/8/dbfutwuDFrRpObHbDVjVEDt7dY/aJxVbupO95
 KQzH8GnijJN3QiTUhDDmbbZL3hYMI6gIWHE803u2TwoIiLhFmpb7INOzawjsM6FzZJxG
 gE6pmADFpfyTLN4YaoqJrB0Jnif7DeXYuel3w8NP7QPI1nnVbWQlKeCLZ/mFLHC14/cd
 yYMloFQ0MRMB4dpX5KedWyDHWBt0CGU+lB7X/PtIJlr0mQHvxlPWnEif/yQSbd9Csbv+
 zz8g==
X-Gm-Message-State: ANhLgQ2UyNoestvyuUbEqzDl/Pq75hrdUkf3sOsoJEoz4lJAcXpM0J8a
 qbNvG5cquTO6MiItW9O2I6PufSKR
X-Google-Smtp-Source: ADFU+vvTdNS6/15/4s7g0x52sP1QBgU5cO8paQFjm3eeXPOxi9lpIRZnSpL0MTWdGwOm/IFMFUgUpw==
X-Received: by 2002:a05:600c:da:: with SMTP id
 u26mr4600478wmm.117.1585673455101; 
 Tue, 31 Mar 2020 09:50:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:54 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 20/26] lpfc: Refactor NVME LS receive handling
Date: Tue, 31 Mar 2020 09:50:05 -0700
Message-Id: <20200331165011.15819-21-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095057_818656_13386838 
X-CRM114-Status: GOOD (  23.88  )
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

In preparation for supporting both intiator mode and target mode
receiving NVME LS's, commonize the existing NVME LS request receive
handling found in the base driver and in the nvmet side.

Using the original lpfc_nvmet_unsol_ls_event() and
lpfc_nvme_unsol_ls_buffer() routines as a templates, commonize the
reception of an NVME LS request. The common routine will validate the LS
request, that it was received from a logged-in node, and allocate a
lpfc_async_xchg_ctx that is used to manage the LS request. The role of
the port is then inspected to determine which handler is to receive the
LS - nvme or nvmet. As such, the nvmet handler is tied back in. A handler
is created in nvme and is stubbed out.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/lpfc/lpfc_crtn.h  |   6 +-
 drivers/scsi/lpfc/lpfc_nvme.c  |  19 +++++
 drivers/scsi/lpfc/lpfc_nvme.h  |   5 ++
 drivers/scsi/lpfc/lpfc_nvmet.c | 163 ++++++++++-------------------------------
 drivers/scsi/lpfc/lpfc_sli.c   | 121 +++++++++++++++++++++++++++++-
 5 files changed, 184 insertions(+), 130 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index dc76729f8864..51b0f01c6206 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -564,8 +564,10 @@ void lpfc_nvme_update_localport(struct lpfc_vport *vport);
 int lpfc_nvmet_create_targetport(struct lpfc_hba *phba);
 int lpfc_nvmet_update_targetport(struct lpfc_hba *phba);
 void lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba);
-void lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba,
-			struct lpfc_sli_ring *pring, struct lpfc_iocbq *piocb);
+int lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg);
+int lpfc_nvmet_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg);
 void lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba, uint32_t idx,
 				struct rqb_dmabuf *nvmebuf, uint64_t isr_ts,
 				uint8_t cqflag);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 21f2282b26ba..daded70ce7b6 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -391,6 +391,25 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	return;
 }
 
+/**
+ * lpfc_nvme_handle_lsreq - Process an unsolicited NVME LS request
+ * @phba: pointer to lpfc hba data structure.
+ * @axchg: pointer to exchange context for the NVME LS request
+ *
+ * This routine is used for processing an asychronously received NVME LS
+ * request. Any remaining validation is done and the LS is then forwarded
+ * to the nvme-fc transport via nvme_fc_rcv_ls_req().
+ *
+ * Returns 0 if LS was handled and delivered to the transport
+ * Returns 1 if LS failed to be handled and should be dropped
+ */
+int
+lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg)
+{
+	return 1;
+}
+
 static void
 lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		       struct lpfc_wcqe_complete *wcqe)
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index c5706c950625..7525b12b06c8 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -189,6 +189,7 @@ struct lpfc_async_xchg_ctx {
 	} hdlrctx;
 	struct list_head list;
 	struct lpfc_hba *phba;
+	struct lpfc_nodelist *ndlp;
 	struct nvmefc_ls_req *ls_req;
 	struct nvmefc_ls_rsp ls_rsp;
 	struct lpfc_iocbq *wqeq;
@@ -203,6 +204,7 @@ struct lpfc_async_xchg_ctx {
 	uint16_t idx;
 	uint16_t state;
 	uint16_t flag;
+	void *payload;
 	struct rqb_dmabuf *rqb_buffer;
 	struct lpfc_nvmet_ctxbuf *ctxbuf;
 	struct lpfc_sli4_hdw_queue *hdwq;
@@ -225,3 +227,6 @@ struct lpfc_async_xchg_ctx {
 /* routines found in lpfc_nvme.c */
 
 /* routines found in lpfc_nvmet.c */
+int lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *ctxp, uint32_t sid,
+			uint16_t xri);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 28db056cf5af..e6895c719683 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -63,9 +63,6 @@ static int lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *,
 static int lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *,
 					    struct lpfc_async_xchg_ctx *,
 					    uint32_t, uint16_t);
-static int lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *,
-					   struct lpfc_async_xchg_ctx *,
-					   uint32_t, uint16_t);
 static void lpfc_nvmet_wqfull_flush(struct lpfc_hba *, struct lpfc_queue *,
 				    struct lpfc_async_xchg_ctx *);
 static void lpfc_nvmet_fcp_rqst_defer_work(struct work_struct *);
@@ -867,7 +864,7 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 				ctxp->oxid);
 		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 		atomic_inc(&nvmep->xmt_ls_abort);
-		lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp,
+		lpfc_nvme_unsol_ls_issue_abort(phba, ctxp,
 						ctxp->sid, ctxp->oxid);
 		return -ENOMEM;
 	}
@@ -910,7 +907,7 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 
 	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 	atomic_inc(&nvmep->xmt_ls_abort);
-	lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp, ctxp->sid, ctxp->oxid);
+	lpfc_nvme_unsol_ls_issue_abort(phba, ctxp, ctxp->sid, ctxp->oxid);
 	return -ENXIO;
 }
 
@@ -1923,107 +1920,49 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_nvmet_unsol_ls_buffer - Process an unsolicited event data buffer
+ * lpfc_nvmet_handle_lsreq - Process an NVME LS request
  * @phba: pointer to lpfc hba data structure.
- * @pring: pointer to a SLI ring.
- * @nvmebuf: pointer to lpfc nvme command HBQ data structure.
+ * @axchg: pointer to exchange context for the NVME LS request
  *
- * This routine is used for processing the WQE associated with a unsolicited
- * event. It first determines whether there is an existing ndlp that matches
- * the DID from the unsolicited WQE. If not, it will create a new one with
- * the DID from the unsolicited WQE. The ELS command from the unsolicited
- * WQE is then used to invoke the proper routine and to set up proper state
- * of the discovery state machine.
- **/
-static void
-lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
-			   struct hbq_dmabuf *nvmebuf)
+ * This routine is used for processing an asychronously received NVME LS
+ * request. Any remaining validation is done and the LS is then forwarded
+ * to the nvmet-fc transport via nvmet_fc_rcv_ls_req().
+ *
+ * The calling sequence should be: nvmet_fc_rcv_ls_req() -> (processing)
+ * -> lpfc_nvmet_xmt_ls_rsp/cmp -> req->done.
+ * lpfc_nvme_xmt_ls_rsp_cmp should free the allocated axchg.
+ *
+ * Returns 0 if LS was handled and delivered to the transport
+ * Returns 1 if LS failed to be handled and should be dropped
+ */
+int
+lpfc_nvmet_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg)
 {
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
-	struct lpfc_nvmet_tgtport *tgtp;
-	struct fc_frame_header *fc_hdr;
-	struct lpfc_async_xchg_ctx *ctxp;
-	uint32_t *payload;
-	uint32_t size, oxid, sid, rc;
-
-
-	if (!nvmebuf || !phba->targetport) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6154 LS Drop IO\n");
-		oxid = 0;
-		size = 0;
-		sid = 0;
-		ctxp = NULL;
-		goto dropit;
-	}
-
-	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
-	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
-
-	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
-	payload = (uint32_t *)(nvmebuf->dbuf.virt);
-	size = bf_get(lpfc_rcqe_length,  &nvmebuf->cq_event.cqe.rcqe_cmpl);
-	sid = sli4_sid_from_fc_hdr(fc_hdr);
-
-	ctxp = kzalloc(sizeof(struct lpfc_async_xchg_ctx), GFP_ATOMIC);
-	if (ctxp == NULL) {
-		atomic_inc(&tgtp->rcv_ls_req_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6155 LS Drop IO x%x: Alloc\n",
-				oxid);
-dropit:
-		lpfc_nvmeio_data(phba, "NVMET LS  DROP: "
-				 "xri x%x sz %d from %06x\n",
-				 oxid, size, sid);
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		return;
-	}
-	ctxp->phba = phba;
-	ctxp->size = size;
-	ctxp->oxid = oxid;
-	ctxp->sid = sid;
-	ctxp->wqeq = NULL;
-	ctxp->state = LPFC_NVME_STE_LS_RCV;
-	ctxp->entry_cnt = 1;
-	ctxp->rqb_buffer = (void *)nvmebuf;
-	ctxp->hdwq = &phba->sli4_hba.hdwq[0];
+	struct lpfc_nvmet_tgtport *tgtp = phba->targetport->private;
+	uint32_t *payload = axchg->payload;
+	int rc;
 
-	lpfc_nvmeio_data(phba, "NVMET LS   RCV: xri x%x sz %d from %06x\n",
-			 oxid, size, sid);
-	/*
-	 * The calling sequence should be:
-	 * nvmet_fc_rcv_ls_req -> lpfc_nvmet_xmt_ls_rsp/cmp ->_req->done
-	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
-	 */
 	atomic_inc(&tgtp->rcv_ls_req_in);
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ls_rsp,
-				 payload, size);
+
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &axchg->ls_rsp,
+				 axchg->payload, axchg->size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
 			"6037 NVMET Unsol rcv: sz %d rc %d: %08x %08x %08x "
-			"%08x %08x %08x\n", size, rc,
+			"%08x %08x %08x\n", axchg->size, rc,
 			*payload, *(payload+1), *(payload+2),
 			*(payload+3), *(payload+4), *(payload+5));
 
-	if (rc == 0) {
+	if (!rc) {
 		atomic_inc(&tgtp->rcv_ls_req_out);
-		return;
+		return 0;
 	}
 
-	lpfc_nvmeio_data(phba, "NVMET LS  DROP: xri x%x sz %d from %06x\n",
-			 oxid, size, sid);
-
 	atomic_inc(&tgtp->rcv_ls_req_drop);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-			"6156 LS Drop IO x%x: nvmet_fc_rcv_ls_req %d\n",
-			ctxp->oxid, rc);
-
-	/* We assume a rcv'ed cmd ALWAYs fits into 1 buffer */
-	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-
-	atomic_inc(&tgtp->xmt_ls_abort);
-	lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp, sid, oxid);
 #endif
+	return 1;
 }
 
 static void
@@ -2367,40 +2306,6 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 	}
 }
 
-/**
- * lpfc_nvmet_unsol_ls_event - Process an unsolicited event from an nvme nport
- * @phba: pointer to lpfc hba data structure.
- * @pring: pointer to a SLI ring.
- * @nvmebuf: pointer to received nvme data structure.
- *
- * This routine is used to process an unsolicited event received from a SLI
- * (Service Level Interface) ring. The actual processing of the data buffer
- * associated with the unsolicited event is done by invoking the routine
- * lpfc_nvmet_unsol_ls_buffer() after properly set up the buffer from the
- * SLI RQ on which the unsolicited event was received.
- **/
-void
-lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
-			  struct lpfc_iocbq *piocb)
-{
-	struct lpfc_dmabuf *d_buf;
-	struct hbq_dmabuf *nvmebuf;
-
-	d_buf = piocb->context2;
-	nvmebuf = container_of(d_buf, struct hbq_dmabuf, dbuf);
-
-	if (!nvmebuf) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"3015 LS Drop IO\n");
-		return;
-	}
-	if (phba->nvmet_support == 0) {
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		return;
-	}
-	lpfc_nvmet_unsol_ls_buffer(phba, pring, nvmebuf);
-}
-
 /**
  * lpfc_nvmet_unsol_fcp_event - Process an unsolicited event from an nvme nport
  * @phba: pointer to lpfc hba data structure.
@@ -3404,8 +3309,16 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 	return 1;
 }
 
-static int
-lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *phba,
+/**
+ * lpfc_nvme_unsol_ls_issue_abort - issue ABTS on an exchange received
+ *        via async frame receive where the frame is not handled.
+ * @phba: pointer to adapter structure
+ * @ctxp: pointer to the asynchronously received received sequence
+ * @sid: address of the remote port to send the ABTS to
+ * @xri: oxid value to for the ABTS (other side's exchange id).
+ **/
+int
+lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 				struct lpfc_async_xchg_ctx *ctxp,
 				uint32_t sid, uint16_t xri)
 {
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 730a8ea4ad94..96fc6aefa4b3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2799,6 +2799,121 @@ lpfc_sli_get_buff(struct lpfc_hba *phba,
 	return &hbq_entry->dbuf;
 }
 
+/**
+ * lpfc_nvme_unsol_ls_handler - Process an unsolicited event data buffer
+ *                              containing a NVME LS request.
+ * @phba: pointer to lpfc hba data structure.
+ * @piocb: pointer to the iocbq struct representing the sequence starting
+ *        frame.
+ *
+ * This routine initially validates the NVME LS, validates there is a login
+ * with the port that sent the LS, and then calls the appropriate nvme host
+ * or target LS request handler.
+ **/
+static void
+lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
+{
+	struct lpfc_nodelist *ndlp;
+	struct lpfc_dmabuf *d_buf;
+	struct hbq_dmabuf *nvmebuf;
+	struct fc_frame_header *fc_hdr;
+	struct lpfc_async_xchg_ctx *axchg = NULL;
+	char *failwhy = NULL;
+	uint32_t oxid, sid, did, fctl, size;
+	int ret;
+
+	d_buf = piocb->context2;
+
+	nvmebuf = container_of(d_buf, struct hbq_dmabuf, dbuf);
+	fc_hdr = nvmebuf->hbuf.virt;
+	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
+	sid = sli4_sid_from_fc_hdr(fc_hdr);
+	did = sli4_did_from_fc_hdr(fc_hdr);
+	fctl = (fc_hdr->fh_f_ctl[0] << 16 |
+		fc_hdr->fh_f_ctl[1] << 8 |
+		fc_hdr->fh_f_ctl[2]);
+	size = bf_get(lpfc_rcqe_length, &nvmebuf->cq_event.cqe.rcqe_cmpl);
+
+	lpfc_nvmeio_data(phba, "NVME LS    RCV: xri x%x sz %d from %06x\n",
+			 oxid, size, sid);
+
+	if (phba->pport->load_flag & FC_UNLOADING) {
+		failwhy = "Driver Unloading";
+	} else if (!(phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)) {
+		failwhy = "NVME FC4 Disabled";
+	} else if (!phba->nvmet_support && !phba->pport->localport) {
+		failwhy = "No Localport";
+	} else if (phba->nvmet_support && !phba->targetport) {
+		failwhy = "No Targetport";
+	} else if (unlikely(fc_hdr->fh_r_ctl != FC_RCTL_ELS4_REQ)) {
+		failwhy = "Bad NVME LS R_CTL";
+	} else if (unlikely((fctl & 0x00FF0000) !=
+			(FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT))) {
+		failwhy = "Bad NVME LS F_CTL";
+	} else {
+		axchg = kzalloc(sizeof(*axchg), GFP_ATOMIC);
+		if (!axchg)
+			failwhy = "No CTX memory";
+	}
+
+	if (unlikely(failwhy)) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+				"6154 Drop NVME LS: SID %06X OXID x%X: %s\n",
+				sid, oxid, failwhy);
+		goto out_fail;
+	}
+
+	/* validate the source of the LS is logged in */
+	ndlp = lpfc_findnode_did(phba->pport, sid);
+	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp) ||
+	    ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
+	     (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+				"6216 NVME Unsol rcv: No ndlp: "
+				"NPort_ID x%x oxid x%x\n",
+				sid, oxid);
+		goto out_fail;
+	}
+
+	axchg->phba = phba;
+	axchg->ndlp = ndlp;
+	axchg->size = size;
+	axchg->oxid = oxid;
+	axchg->sid = sid;
+	axchg->wqeq = NULL;
+	axchg->state = LPFC_NVME_STE_LS_RCV;
+	axchg->entry_cnt = 1;
+	axchg->rqb_buffer = (void *)nvmebuf;
+	axchg->hdwq = &phba->sli4_hba.hdwq[0];
+	axchg->payload = nvmebuf->dbuf.virt;
+	INIT_LIST_HEAD(&axchg->list);
+
+	if (phba->nvmet_support)
+		ret = lpfc_nvmet_handle_lsreq(phba, axchg);
+	else
+		ret = lpfc_nvme_handle_lsreq(phba, axchg);
+
+	/* if zero, LS was successfully handled. If non-zero, LS not handled */
+	if (!ret)
+		return;
+
+	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+			"6155 Drop NVME LS from DID %06X: SID %06X OXID x%X "
+			"NVMe%s handler failed %d\n",
+			did, sid, oxid,
+			(phba->nvmet_support) ? "T" : "I", ret);
+
+out_fail:
+	kfree(axchg);
+
+	/* recycle receive buffer */
+	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
+
+	/* If start of new exchange, abort it */
+	if (fctl & FC_FC_FIRST_SEQ && !(fctl & FC_FC_EX_CTX))
+		lpfc_nvme_unsol_ls_issue_abort(phba, axchg, sid, oxid);
+}
+
 /**
  * lpfc_complete_unsol_iocb - Complete an unsolicited sequence
  * @phba: Pointer to HBA context object.
@@ -2820,7 +2935,7 @@ lpfc_complete_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	switch (fch_type) {
 	case FC_TYPE_NVME:
-		lpfc_nvmet_unsol_ls_event(phba, pring, saveq);
+		lpfc_nvme_unsol_ls_handler(phba, saveq);
 		return 1;
 	default:
 		break;
@@ -14005,8 +14120,8 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 
 		/* Just some basic sanity checks on FCP Command frame */
 		fctl = (fc_hdr->fh_f_ctl[0] << 16 |
-		fc_hdr->fh_f_ctl[1] << 8 |
-		fc_hdr->fh_f_ctl[2]);
+			fc_hdr->fh_f_ctl[1] << 8 |
+			fc_hdr->fh_f_ctl[2]);
 		if (((fctl &
 		    (FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT)) !=
 		    (FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT)) ||
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
