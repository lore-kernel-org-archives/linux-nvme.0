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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152FDC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01E520674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Du+eEkp0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bohthWNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01E520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UkPKt9/tD7tYKYuUzj1TG1I8W3CD+KgIP+dCtII+1Z8=; b=Du+eEkp0b0K12qGU0VKegECY2+
	2LNYes+nNkVb2CgoDumBEngNLj9+y/GRwnvdLN9pXUTMD/pjciSYiWjH0zZtLx3QmTre/xeOLsp+R
	9wvRKkPRzxrBp+dm5cH+uWT8KKQqcW/33MnVtfAvlw0DaXoSmVrFeketuYcErBrA2vYap/xdbc4VR
	KJxu5DoEYCGcx57G+wDJRcgt4odTC0to9FYWKqxN5/lePnZWpGdxjM75pe0Pc23UmUV5jXv5C1W6d
	aNIPxYw+lMnl5hNVyJ7zSYfbjYfdkM/wXavzpnjPBVeX5HbOl2LyFT8FVk2ccJyY8X8Uj5lLV8s5V
	yU8D1bWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPfr-00023q-PT; Wed, 05 Feb 2020 18:45:19 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZT-00040Y-OT
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:58 +0000
Received: by mail-wr1-x442.google.com with SMTP id w12so4040261wrt.2
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AOKo+O70WtZUYyZ/+GuYUgii57XauSdRw2rfhf+9DD4=;
 b=bohthWNu+/JdVMzF1N5ydLlgFsrV4FUPMy8ClYHY9t9WanFahNTg5dYNOGU0Nmd8GH
 N4SP4hH7zPYqF4SEWpLJBOQCd8zEqiIpT1yiW+VVZIbn169esTYtCycAp2gxQCS5b89+
 IA/FrZyVgvwKKBj0mMWimCWoUsZu5h9NRwMfyfGBfOR+vVWsqRO9KbF/umH+JTDPfQ84
 IAhTvIhttQAaVvHRUOnptCjrG2vHQpoQ5fLUAB4O8+7z7w/9y2gubEB0dUfi3/SvvZ0A
 TD94K6D9f95MuNS5xPvt/kuO3fnCRmo0J8tP+xUsUzTYW7Ic7tyRNvueGWWFAbt1jU/a
 VnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AOKo+O70WtZUYyZ/+GuYUgii57XauSdRw2rfhf+9DD4=;
 b=C6ZXirI0XZ0DndaQibG+r0y6HfWV6XMU/5bQv1PKyQiOd7Ouli6hZjvryzbQdQ1dUY
 ruX2Ro+PXTvVMDTK52dO9jHb/FVEaVgquOxyuG2FIaeX2hwnp7brWE4O9cQw9yoS2S5j
 ccS6Ko5r2Jw4SBjBLLeQ+BUryqdR29Rdmv2mCBStGwijEdN2G/a42iJ2GU8c3uQ54Z9B
 8ydZDrvRY0GyFy8veuwTh/ZDARbVWBSa8sLBEIZlt/b1vTV7GyNSnnsu2zwSi5f+iVsa
 R1ppbg2jm7gazXQnMpZYeanXYBDjg8CKPSQq/uRc1mfPBY9Nar9TUN4EQtxUYQ1oksBX
 yWRg==
X-Gm-Message-State: APjAAAXe946b8VbQF5Sy3Np6TK4692N6U3q3dbq6EtqzkkEV/l4y3eIc
 tFx6W0WZ36LX6bhqBF2hL1OVPek6
X-Google-Smtp-Source: APXvYqyj6mL+B9me8rdzm0g8X0lccsIgW3il2nbezq1OBsu4OUKfxm5I3FxULYzmPhcb52I17c53Tw==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr31425915wru.170.1580927921858; 
 Wed, 05 Feb 2020 10:38:41 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:41 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 25/29] lpfc: Refactor Send LS Abort support
Date: Wed,  5 Feb 2020 10:37:49 -0800
Message-Id: <20200205183753.25959-26-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103843_958339_D637EEDA 
X-CRM114-Status: GOOD (  22.56  )
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

Send LS Abort support is needed when Send LS Request is supported.

Currently, the ability to abort an NVME LS request is limited to the nvme
(host) side of the driver.  In preparation of both the nvme and nvmet sides
supporting Send LS Abort, rework the existing ls_req abort routines such
that there is common code that can be used by both sides.

While refactoring it was seen the logic in the abort routine was incorrect.
It attempted to abort all NVME LS's on the indicated port. As such, the
routine was reworked to abort only the NVME LS request that was specified.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 125 +++++++++++++++++++++++++-----------------
 drivers/scsi/lpfc/lpfc_nvme.h |   2 +
 2 files changed, 77 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index e93636986c6f..c6082c65d902 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -790,83 +790,108 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 }
 
 /**
- * lpfc_nvme_ls_abort - Issue an Link Service request
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
+ * __lpfc_nvme_ls_abort - Generic service routine to abort a prior
+ *         NVME LS request
+ * @vport: The local port that issued the LS
+ * @ndlp: The remote port the LS was sent to
+ * @pnvme_lsreq: Pointer to LS request structure from the transport
  *
- * Driver registers this routine to handle any link service request
- * from the nvme_fc transport to a remote nvme-aware port.
+ * The driver validates the ndlp, looks for the LS, and aborts the
+ * LS if found.
  *
- * Return value :
- *   0 - Success
- *   TODO: What are the failure codes.
+ * Returns:
+ * 0 : if LS found and aborted
+ * non-zero: various error conditions in form -Exxx
  **/
-static void
-lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
-		   struct nvme_fc_remote_port *pnvme_rport,
-		   struct nvmefc_ls_req *pnvme_lsreq)
+int
+__lpfc_nvme_ls_abort(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
+			struct nvmefc_ls_req *pnvme_lsreq)
 {
-	struct lpfc_nvme_lport *lport;
-	struct lpfc_vport *vport;
-	struct lpfc_hba *phba;
-	struct lpfc_nodelist *ndlp;
-	LIST_HEAD(abort_list);
+	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_sli_ring *pring;
 	struct lpfc_iocbq *wqe, *next_wqe;
+	bool foundit = false;
 
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
-	if (unlikely(!lport))
-		return;
-	vport = lport->vport;
-	phba = vport->phba;
-
-	if (vport->load_flag & FC_UNLOADING)
-		return;
-
-	ndlp = lpfc_findnode_did(vport, pnvme_rport->port_id);
 	if (!ndlp) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
-				 "6049 Could not find node for DID %x\n",
-				 pnvme_rport->port_id);
-		return;
+		lpfc_printf_log(phba, KERN_ERR,
+				LOG_NVME_DISC | LOG_NODE |
+					LOG_NVME_IOERR | LOG_NVME_ABTS,
+				"6049 NVMEx LS REQ Abort: Bad NDLP x%px DID "
+				"x%06x, Failing LS Req\n",
+				ndlp, ndlp ? ndlp->nlp_DID : 0);
+		return -EINVAL;
 	}
 
-	/* Expand print to include key fields. */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
-			 "6040 ENTER.  lport x%px, rport x%px lsreq x%px rqstlen:%d "
-			 "rsplen:%d %pad %pad\n",
-			 pnvme_lport, pnvme_rport,
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC | LOG_NVME_ABTS,
+			 "6040 NVMEx LS REQ Abort: Issue LS_ABORT for lsreq "
+			 "x%p rqstlen:%d rsplen:%d %pad %pad\n",
 			 pnvme_lsreq, pnvme_lsreq->rqstlen,
 			 pnvme_lsreq->rsplen, &pnvme_lsreq->rqstdma,
 			 &pnvme_lsreq->rspdma);
 
 	/*
-	 * Lock the ELS ring txcmplq and build a local list of all ELS IOs
-	 * that need an ABTS.  The IOs need to stay on the txcmplq so that
-	 * the abort operation completes them successfully.
+	 * Lock the ELS ring txcmplq and look for the wqe that matches
+	 * this ELS. If found, issue an abort on the wqe.
 	 */
 	pring = phba->sli4_hba.nvmels_wq->pring;
 	spin_lock_irq(&phba->hbalock);
 	spin_lock(&pring->ring_lock);
 	list_for_each_entry_safe(wqe, next_wqe, &pring->txcmplq, list) {
-		/* Add to abort_list on on NDLP match. */
-		if (lpfc_check_sli_ndlp(phba, pring, wqe, ndlp)) {
+		if (wqe->context2 == pnvme_lsreq) {
 			wqe->iocb_flag |= LPFC_DRIVER_ABORTED;
-			list_add_tail(&wqe->dlist, &abort_list);
+			foundit = true;
+			break;
 		}
 	}
 	spin_unlock(&pring->ring_lock);
+
+	if (foundit)
+		lpfc_sli_issue_abort_iotag(phba, pring, wqe);
 	spin_unlock_irq(&phba->hbalock);
 
-	/* Abort the targeted IOs and remove them from the abort list. */
-	list_for_each_entry_safe(wqe, next_wqe, &abort_list, dlist) {
+	if (foundit)
+		return 0;
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC | LOG_NVME_ABTS,
+			 "6213 NVMEx LS REQ Abort: Unable to locate req x%p\n",
+			 pnvme_lsreq);
+	return 1;
+}
+
+/**
+ * lpfc_nvme_ls_abort - Abort a prior NVME LS request
+ * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
+ * @lpfc_nvme_rport: Transport remoteport that LS is to be sent to.
+ * @pnvme_lsreq - the transport nvme_ls_req structure for the LS
+ *
+ * Driver registers this routine to abort a NVME LS request that is
+ * in progress (from the transports perspective).
+ **/
+static void
+lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
+		   struct nvme_fc_remote_port *pnvme_rport,
+		   struct nvmefc_ls_req *pnvme_lsreq)
+{
+	struct lpfc_nvme_lport *lport;
+	struct lpfc_vport *vport;
+	struct lpfc_hba *phba;
+	struct lpfc_nodelist *ndlp;
+	int ret;
+
+	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	if (unlikely(!lport))
+		return;
+	vport = lport->vport;
+	phba = vport->phba;
+
+	if (vport->load_flag & FC_UNLOADING)
+		return;
+
+	ndlp = lpfc_findnode_did(vport, pnvme_rport->port_id);
+
+	ret = __lpfc_nvme_ls_abort(vport, ndlp, pnvme_lsreq);
+	if (!ret)
 		atomic_inc(&lport->xmt_ls_abort);
-		spin_lock_irq(&phba->hbalock);
-		list_del_init(&wqe->dlist);
-		lpfc_sli_issue_abort_iotag(phba, pring, wqe);
-		spin_unlock_irq(&phba->hbalock);
-	}
 }
 
 /* Fix up the existing sgls for NVME IO. */
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 65df27bbb7bb..3ebcf885cac5 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -238,6 +238,8 @@ int __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				struct lpfc_wcqe_complete *wcqe));
 void __lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba,  struct lpfc_vport *vport,
 		struct lpfc_iocbq *cmdwqe, struct lpfc_wcqe_complete *wcqe);
+int __lpfc_nvme_ls_abort(struct lpfc_vport *vport,
+		struct lpfc_nodelist *ndlp, struct nvmefc_ls_req *pnvme_lsreq);
 
 /* routines found in lpfc_nvmet.c */
 int lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
