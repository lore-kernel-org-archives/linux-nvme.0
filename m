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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2400C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D46A20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1Jb8xFI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1Uud/z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D46A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CC88R9+ZSgvxZZ3ddal+NXvVE+xHqhXI1BT57qE1e3E=; b=L1Jb8xFIdyJyHUC5DmpeAh9BXj
	GoKkghdm0U6JDe/QfQLzzR5WP6Edzgu+a3j4zBq37hmlkwqgvDARhbTGpdUKI3I4kesbaFaWHrlhZ
	sMLkjNidc1qt1m14B+10X95TXEafqKiYr2nimnzyGCwRaOrXo2XtaxxzKJP6GsOI70DSM2gUWCF2+
	u56ZSoM4xjX1bcsPPjYC1FSMEBwRnezmTnk4ObfpzMqvMIvdnKZK3jEZA7kOlb2l8z4PxDDRdnxZa
	vbAnwLrxhBLaW4kxd3IRGbyFoYzHnNECSusG4gjid+3m9eGGSXHtWUQcY/pzgZV6spE4HM7QzoLZN
	neA3LDmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPfW-0001QJ-H8; Wed, 05 Feb 2020 18:44:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZS-0003yt-1a
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:59 +0000
Received: by mail-wr1-x442.google.com with SMTP id z3so4036562wru.3
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k+QR7kd3kkCNV5VtsYwIUUkuXQNkiiD1tx4OIawViQw=;
 b=D1Uud/z+LD2gASVG8FMePTI6jb7D6LGWG4hkgIPhBOXvW3f5Eykt8CXSBoyeg+jgLb
 E6Jzd9Ofers0gdPQaL53Z0b6CPXkq0q/aVa+G6CPywgPL0p1M+sDrJ8Zi/acE+ghZS44
 Z/DyBLEJZoYoBu7xAYOsYN/pKCJ1fD24NmLibbutvZAk4KgRefR1ZsmM7zl/7oEpq+Jt
 uq8eqjQ91T98caIGC2SRSi7xwklpFj68yXIEX+i90NtS/zeXluHMSBIfwnUBl8NvLEcg
 GnNgIasXdj8+XbWec8LSFHpVuQo3uF6rYJVxEH74pFOOcVEXP4w5U8VMODEo1O9DUrq4
 /7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k+QR7kd3kkCNV5VtsYwIUUkuXQNkiiD1tx4OIawViQw=;
 b=kSGOxzmsZaZDKH7WO7mR9s1cDZpXuNSpeByiPR0fyee7nX7MrHv5l5Vyedyh14APsm
 Z0W7c3VqFs+Jw4QbXudmYdAh2cPQhgTi1h+TQtr9uPBvEgHOKbmLV+p+yMdBV17qpg+P
 4idWa+4WnHTPKwHvMB2gxgqoJzHSDKtWoLpJb4lImGcZ/6WzmRZVrgSrLZAf3tKnW3jA
 eQpWWoqtz+jUfVpHCtBwTUdt5/wnBLpg0UPtII4PfxfY1Z+IpNxmg43dsL63m4AqUpa2
 JJP2iibSe4XrMxj1IQ31hblFyayREewdBfwgn/hWUmOXFo4RWYaJYzWwVk8yi4Akqbxp
 WVNw==
X-Gm-Message-State: APjAAAW2Zrf8Yix0HHzicyGtTfFpSvjrrkL8gzvmiR8n42YhBsLJrd3q
 ARr0/QLlWYSdus1HbWhFJc0qPHrA
X-Google-Smtp-Source: APXvYqxt42XPEKiGzKnvxxECoTy62nu08hJenQ1THuY8PX456OEZLxlPFJH17pg9g3yR1ncTnREXzQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr31767574wrr.226.1580927920226; 
 Wed, 05 Feb 2020 10:38:40 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:39 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 24/29] lpfc: Refactor Send LS Request support
Date: Wed,  5 Feb 2020 10:37:48 -0800
Message-Id: <20200205183753.25959-25-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103842_211386_5A1DF38E 
X-CRM114-Status: GOOD (  25.39  )
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

Currently, the ability to send an NVME LS request is limited to the nvme
(host) side of the driver.  In preparation of both the nvme and nvmet sides
support Send LS Request, rework the existing send ls_req and ls_req
completion routines such that there is common code that can be used by
both sides.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 289 +++++++++++++++++++++++++-----------------
 drivers/scsi/lpfc/lpfc_nvme.h |  13 ++
 2 files changed, 184 insertions(+), 118 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index daded70ce7b6..e93636986c6f 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -410,43 +410,43 @@ lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
 	return 1;
 }
 
-static void
-lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
-		       struct lpfc_wcqe_complete *wcqe)
+/**
+ * __lpfc_nvme_ls_req_cmp - Generic completion handler for a NVME
+ *        LS request.
+ * @phba: Pointer to HBA context object
+ * @vport: The local port that issued the LS
+ * @cmdwqe: Pointer to driver command WQE object.
+ * @wcqe: Pointer to driver response CQE object.
+ *
+ * This function is the generic completion handler for NVME LS requests.
+ * The function updates any states and statistics, calls the transport
+ * ls_req done() routine, then tears down the command and buffers used
+ * for the LS request.
+ **/
+void
+__lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba,  struct lpfc_vport *vport,
+			struct lpfc_iocbq *cmdwqe,
+			struct lpfc_wcqe_complete *wcqe)
 {
-	struct lpfc_vport *vport = cmdwqe->vport;
-	struct lpfc_nvme_lport *lport;
-	uint32_t status;
 	struct nvmefc_ls_req *pnvme_lsreq;
 	struct lpfc_dmabuf *buf_ptr;
 	struct lpfc_nodelist *ndlp;
+	uint32_t status;
 
 	pnvme_lsreq = (struct nvmefc_ls_req *)cmdwqe->context2;
+	ndlp = (struct lpfc_nodelist *)cmdwqe->context1;
 	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
 
-	if (vport->localport) {
-		lport = (struct lpfc_nvme_lport *)vport->localport->private;
-		if (lport) {
-			atomic_inc(&lport->fc4NvmeLsCmpls);
-			if (status) {
-				if (bf_get(lpfc_wcqe_c_xb, wcqe))
-					atomic_inc(&lport->cmpl_ls_xb);
-				atomic_inc(&lport->cmpl_ls_err);
-			}
-		}
-	}
-
-	ndlp = (struct lpfc_nodelist *)cmdwqe->context1;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6047 nvme cmpl Enter "
-			 "Data %px DID %x Xri: %x status %x reason x%x "
-			 "cmd:x%px lsreg:x%px bmp:x%px ndlp:x%px\n",
+			 "6047 NVMEx LS REQ %px cmpl DID %x Xri: %x "
+			 "status %x reason x%x cmd:x%px lsreg:x%px bmp:x%px "
+			 "ndlp:x%px\n",
 			 pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
 			 cmdwqe->sli4_xritag, status,
 			 (wcqe->parameter & 0xffff),
 			 cmdwqe, pnvme_lsreq, cmdwqe->context3, ndlp);
 
-	lpfc_nvmeio_data(phba, "NVME LS  CMPL: xri x%x stat x%x parm x%x\n",
+	lpfc_nvmeio_data(phba, "NVMEx LS CMPL: xri x%x stat x%x parm x%x\n",
 			 cmdwqe->sli4_xritag, status, wcqe->parameter);
 
 	if (cmdwqe->context3) {
@@ -459,7 +459,7 @@ lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		pnvme_lsreq->done(pnvme_lsreq, status);
 	else
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-				 "6046 nvme cmpl without done call back? "
+				 "6046 NVMEx cmpl without done call back? "
 				 "Data %px DID %x Xri: %x status %x\n",
 				pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
 				cmdwqe->sli4_xritag, status);
@@ -470,6 +470,31 @@ lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	lpfc_sli_release_iocbq(phba, cmdwqe);
 }
 
+static void
+lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
+		       struct lpfc_wcqe_complete *wcqe)
+{
+	struct lpfc_vport *vport = cmdwqe->vport;
+	struct lpfc_nvme_lport *lport;
+	uint32_t status;
+
+	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
+
+	if (vport->localport) {
+		lport = (struct lpfc_nvme_lport *)vport->localport->private;
+		if (lport) {
+			atomic_inc(&lport->fc4NvmeLsCmpls);
+			if (status) {
+				if (bf_get(lpfc_wcqe_c_xb, wcqe))
+					atomic_inc(&lport->cmpl_ls_xb);
+				atomic_inc(&lport->cmpl_ls_err);
+			}
+		}
+	}
+
+	__lpfc_nvme_ls_req_cmp(phba, vport, cmdwqe, wcqe);
+}
+
 static int
 lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 		  struct lpfc_dmabuf *inp,
@@ -571,13 +596,6 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 
 
 	/* Issue GEN REQ WQE for NPORT <did> */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "6050 Issue GEN REQ WQE to NPORT x%x "
-			 "Data: x%x x%x wq:x%px lsreq:x%px bmp:x%px "
-			 "xmit:%d 1st:%d\n",
-			 ndlp->nlp_DID, genwqe->iotag,
-			 vport->port_state,
-			genwqe, pnvme_lsreq, bmp, xmit_len, first_len);
 	genwqe->wqe_cmpl = cmpl;
 	genwqe->iocb_cmpl = NULL;
 	genwqe->drvrTimeout = tmo + LPFC_DRVR_TIMEOUT;
@@ -589,105 +607,108 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 
 	rc = lpfc_sli4_issue_wqe(phba, &phba->sli4_hba.hdwq[0], genwqe);
 	if (rc) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC | LOG_ELS,
 				 "6045 Issue GEN REQ WQE to NPORT x%x "
-				 "Data: x%x x%x\n",
+				 "Data: x%x x%x  rc x%x\n",
 				 ndlp->nlp_DID, genwqe->iotag,
-				 vport->port_state);
+				 vport->port_state, rc);
 		lpfc_sli_release_iocbq(phba, genwqe);
 		return 1;
 	}
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC | LOG_ELS,
+			 "6050 Issue GEN REQ WQE to NPORT x%x "
+			 "Data: oxid: x%x state: x%x wq:x%px lsreq:x%px "
+			 "bmp:x%px xmit:%d 1st:%d\n",
+			 ndlp->nlp_DID, genwqe->sli4_xritag,
+			 vport->port_state,
+			 genwqe, pnvme_lsreq, bmp, xmit_len, first_len);
 	return 0;
 }
 
+
 /**
- * lpfc_nvme_ls_req - Issue an Link Service request
- * @lpfc_pnvme: Pointer to the driver's nvme instance data
- * @lpfc_nvme_lport: Pointer to the driver's local port data
- * @lpfc_nvme_rport: Pointer to the rport getting the @lpfc_nvme_ereq
+ * __lpfc_nvme_ls_req - Generic service routine to issue an NVME LS request
+ * @vport: The local port issuing the LS
+ * @ndlp: The remote port to send the LS to
+ * @pnvme_lsreq: Pointer to LS request structure from the transport
  *
- * Driver registers this routine to handle any link service request
- * from the nvme_fc transport to a remote nvme-aware port.
+ * Routine validates the ndlp, builds buffers and sends a GEN_REQUEST
+ * WQE to perform the LS operation.
  *
  * Return value :
  *   0 - Success
- *   TODO: What are the failure codes.
+ *   non-zero: various error codes, in form of -Exxx
  **/
-static int
-lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
-		 struct nvme_fc_remote_port *pnvme_rport,
-		 struct nvmefc_ls_req *pnvme_lsreq)
+int
+__lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
+		      struct nvmefc_ls_req *pnvme_lsreq,
+		      void (*gen_req_cmp)(struct lpfc_hba *phba,
+				struct lpfc_iocbq *cmdwqe,
+				struct lpfc_wcqe_complete *wcqe))
 {
-	int ret = 0;
-	struct lpfc_nvme_lport *lport;
-	struct lpfc_nvme_rport *rport;
-	struct lpfc_vport *vport;
-	struct lpfc_nodelist *ndlp;
-	struct ulp_bde64 *bpl;
 	struct lpfc_dmabuf *bmp;
+	struct ulp_bde64 *bpl;
+	int ret;
 	uint16_t ntype, nstate;
 
-	/* there are two dma buf in the request, actually there is one and
-	 * the second one is just the start address + cmd size.
-	 * Before calling lpfc_nvme_gen_req these buffers need to be wrapped
-	 * in a lpfc_dmabuf struct. When freeing we just free the wrapper
-	 * because the nvem layer owns the data bufs.
-	 * We do not have to break these packets open, we don't care what is in
-	 * them. And we do not have to look at the resonse data, we only care
-	 * that we got a response. All of the caring is going to happen in the
-	 * nvme-fc layer.
-	 */
-
-	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
-	rport = (struct lpfc_nvme_rport *)pnvme_rport->private;
-	if (unlikely(!lport) || unlikely(!rport))
-		return -EINVAL;
-
-	vport = lport->vport;
-
-	if (vport->load_flag & FC_UNLOADING)
-		return -ENODEV;
-
-	/* Need the ndlp.  It is stored in the driver's rport. */
-	ndlp = rport->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6051 Remoteport x%px, rport has invalid ndlp. "
-				 "Failing LS Req\n", pnvme_rport);
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_NVME_DISC | LOG_NODE | LOG_NVME_IOERR,
+				 "6051 NVMEx LS REQ: Bad NDLP x%px, Failing "
+				 "LS Req\n",
+				 ndlp);
 		return -ENODEV;
 	}
 
-	/* The remote node has to be a mapped nvme target or an
-	 * unmapped nvme initiator or it's an error.
-	 */
 	ntype = ndlp->nlp_type;
 	nstate = ndlp->nlp_state;
 	if ((ntype & NLP_NVME_TARGET && nstate != NLP_STE_MAPPED_NODE) ||
 	    (ntype & NLP_NVME_INITIATOR && nstate != NLP_STE_UNMAPPED_NODE)) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6088 DID x%06x not ready for "
-				 "IO. State x%x, Type x%x\n",
-				 pnvme_rport->port_id,
-				 ndlp->nlp_state, ndlp->nlp_type);
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_NVME_DISC | LOG_NODE | LOG_NVME_IOERR,
+				 "6088 NVMEx LS REQ: Fail DID x%06x not "
+				 "ready for IO. Type x%x, State x%x\n",
+				 ndlp->nlp_DID, ntype, nstate);
 		return -ENODEV;
 	}
-	bmp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
+
+	/*
+	 * there are two dma buf in the request, actually there is one and
+	 * the second one is just the start address + cmd size.
+	 * Before calling lpfc_nvme_gen_req these buffers need to be wrapped
+	 * in a lpfc_dmabuf struct. When freeing we just free the wrapper
+	 * because the nvem layer owns the data bufs.
+	 * We do not have to break these packets open, we don't care what is
+	 * in them. And we do not have to look at the resonse data, we only
+	 * care that we got a response. All of the caring is going to happen
+	 * in the nvme-fc layer.
+	 */
+
+	bmp = kmalloc(sizeof(*bmp), GFP_KERNEL);
 	if (!bmp) {
 
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-				 "6044 Could not find node for DID %x\n",
-				 pnvme_rport->port_id);
-		return 2;
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_NVME_DISC | LOG_NVME_IOERR,
+				 "6044 NVMEx LS REQ: Could not alloc LS buf "
+				 "for DID %x\n",
+				 ndlp->nlp_DID);
+		return -ENOMEM;
 	}
-	INIT_LIST_HEAD(&bmp->list);
+
 	bmp->virt = lpfc_mbuf_alloc(vport->phba, MEM_PRI, &(bmp->phys));
 	if (!bmp->virt) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-				 "6042 Could not find node for DID %x\n",
-				 pnvme_rport->port_id);
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_NVME_DISC | LOG_NVME_IOERR,
+				 "6042 NVMEx LS REQ: Could not alloc mbuf "
+				 "for DID %x\n",
+				 ndlp->nlp_DID);
 		kfree(bmp);
-		return 3;
+		return -ENOMEM;
 	}
+
+	INIT_LIST_HEAD(&bmp->list);
+
 	bpl = (struct ulp_bde64 *)bmp->virt;
 	bpl->addrHigh = le32_to_cpu(putPaddrHigh(pnvme_lsreq->rqstdma));
 	bpl->addrLow = le32_to_cpu(putPaddrLow(pnvme_lsreq->rqstdma));
@@ -702,37 +723,69 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 	bpl->tus.f.bdeSize = pnvme_lsreq->rsplen;
 	bpl->tus.w = le32_to_cpu(bpl->tus.w);
 
-	/* Expand print to include key fields. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6149 Issue LS Req to DID 0x%06x lport x%px, "
-			 "rport x%px lsreq x%px rqstlen:%d rsplen:%d "
-			 "%pad %pad\n",
-			 ndlp->nlp_DID, pnvme_lport, pnvme_rport,
-			 pnvme_lsreq, pnvme_lsreq->rqstlen,
-			 pnvme_lsreq->rsplen, &pnvme_lsreq->rqstdma,
-			 &pnvme_lsreq->rspdma);
-
-	atomic_inc(&lport->fc4NvmeLsRequests);
+			"6149 NVMEx LS REQ: Issue to DID 0x%06x lsreq x%px, "
+			"rqstlen:%d rsplen:%d %pad %pad\n",
+			ndlp->nlp_DID, pnvme_lsreq, pnvme_lsreq->rqstlen,
+			pnvme_lsreq->rsplen, &pnvme_lsreq->rqstdma,
+			&pnvme_lsreq->rspdma);
 
-	/* Hardcode the wait to 30 seconds.  Connections are failing otherwise.
-	 * This code allows it all to work.
-	 */
 	ret = lpfc_nvme_gen_req(vport, bmp, pnvme_lsreq->rqstaddr,
-				pnvme_lsreq, lpfc_nvme_cmpl_gen_req,
-				ndlp, 2, 30, 0);
+				pnvme_lsreq, gen_req_cmp, ndlp, 2,
+				LPFC_NVME_LS_TIMEOUT, 0);
 	if (ret != WQE_SUCCESS) {
-		atomic_inc(&lport->xmt_ls_err);
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-				 "6052 EXIT. issue ls wqe failed lport x%px, "
-				 "rport x%px lsreq x%px Status %x DID %x\n",
-				 pnvme_lport, pnvme_rport, pnvme_lsreq,
-				 ret, ndlp->nlp_DID);
+		lpfc_printf_vlog(vport, KERN_ERR,
+				 LOG_NVME_DISC | LOG_NVME_IOERR,
+				 "6052 NVMEx REQ: EXIT. issue ls wqe failed "
+				 "lsreq x%px Status %x DID %x\n",
+				 pnvme_lsreq, ret, ndlp->nlp_DID);
 		lpfc_mbuf_free(vport->phba, bmp->virt, bmp->phys);
 		kfree(bmp);
-		return ret;
+		return -EIO;
 	}
 
-	/* Stub in routine and return 0 for now. */
+	return 0;
+}
+
+/**
+ * lpfc_nvme_ls_req - Issue an NVME Link Service request
+ * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
+ * @lpfc_nvme_rport: Transport remoteport that LS is to be sent to.
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
+lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
+		 struct nvme_fc_remote_port *pnvme_rport,
+		 struct nvmefc_ls_req *pnvme_lsreq)
+{
+	struct lpfc_nvme_lport *lport;
+	struct lpfc_nvme_rport *rport;
+	struct lpfc_vport *vport;
+	int ret;
+
+	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	rport = (struct lpfc_nvme_rport *)pnvme_rport->private;
+	if (unlikely(!lport) || unlikely(!rport))
+		return -EINVAL;
+
+	vport = lport->vport;
+	if (vport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
+	atomic_inc(&lport->fc4NvmeLsRequests);
+
+	ret = __lpfc_nvme_ls_req(vport, rport->ndlp, pnvme_lsreq,
+				 lpfc_nvme_ls_req_cmp);
+	if (ret)
+		atomic_inc(&lport->xmt_ls_err);
+
 	return ret;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 7525b12b06c8..65df27bbb7bb 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -80,6 +80,12 @@ struct lpfc_nvme_fcpreq_priv {
 	struct lpfc_io_buf *nvme_buf;
 };
 
+/*
+ * set NVME LS request timeouts to 30s. It is larger than the 2*R_A_TOV
+ * set by the spec, which appears to have issues with some devices.
+ */
+#define LPFC_NVME_LS_TIMEOUT		30
+
 
 #define LPFC_NVMET_DEFAULT_SEGS		(64 + 1)	/* 256K IOs */
 #define LPFC_NVMET_RQE_MIN_POST		128
@@ -225,6 +231,13 @@ struct lpfc_async_xchg_ctx {
 
 
 /* routines found in lpfc_nvme.c */
+int __lpfc_nvme_ls_req(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
+		struct nvmefc_ls_req *pnvme_lsreq,
+		void (*gen_req_cmp)(struct lpfc_hba *phba,
+				struct lpfc_iocbq *cmdwqe,
+				struct lpfc_wcqe_complete *wcqe));
+void __lpfc_nvme_ls_req_cmp(struct lpfc_hba *phba,  struct lpfc_vport *vport,
+		struct lpfc_iocbq *cmdwqe, struct lpfc_wcqe_complete *wcqe);
 
 /* routines found in lpfc_nvmet.c */
 int lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
