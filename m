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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1AEC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316A206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K57vUK1l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF64ijb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=annxO4TU1p8njxwfFKVUXY4BMzV6VMiBrbLK4WvW3ko=; b=K57vUK1lFTluHo8xHfe7uA2hJ1
	1aA93dQCGCFGnSiDFvj+9tlM6nVTWoV2Pcetj7t10fGiSGrJAchXplhTWpD8ocBezF+FA/ZGOQVXp
	TQqQDlZZYBSPt91l4/rfXBMO/TJxMFhHndRShMwlrJAgxJNNLWdLiLO3sxzl+WTZMIgn0vdgYkQl+
	joofRjIdJy7l5f2s9vsXkBA81OlJaC/GEiHbStus1MLaRkLjGk1XNnlCJ0rv1txG0C96hNA/mNJ70
	YFZSW1bNucWJMwCpu4759t/Xl5VjOluk7A2SA6VS9DlEeo/15SZXNbHdx7EkyG2TnvBDgQ9ZXzD1O
	Mwf7iqNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKC8-0002cj-FQ; Tue, 31 Mar 2020 16:56:56 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6W-00055p-AD
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:23 +0000
Received: by mail-wr1-f66.google.com with SMTP id w10so26986390wrm.4
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XCGcZM/M2thD27Xh1v9hUQMqyZZ8d62PesVFPWLsceE=;
 b=PF64ijb7dqq8vvccJpwtpbdDC1to3awva1qpKJJGJgGOypRSlpXbcDIeb20Pfr0UZP
 42ITZaVCpDPrnSTQLSWzr2T/U51yDsEYt68nDwtlagxwJ4RjPwhQjklZjapu6BU0kexR
 v8G24sYOgFeTcIlO6waeiq0KWXYg252MWWQ5WdAlOxJ7aA3+QMY/ZHxKj3XoOUdjZWvb
 wmEgJz6c4mv1u0SWWBfSnAnmKPZPWe3Ik0g7CXSDXBGwJE7g9Xln6P9cd4ZU/xnd86wj
 D2Ys9UlkEb9QfllEJVjLay7AqQ58PqyzT3GCS+eMEjsRdcLIsnyWcDXqHTwsevC59Oyo
 s7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XCGcZM/M2thD27Xh1v9hUQMqyZZ8d62PesVFPWLsceE=;
 b=nQPb2MF1iXLqCIzCCAio6u6XObgTaldW5tprX5wDz3O4rqyvoEM3SXVw2QnPXGRcHH
 LLYbiOaEbgD+l3zf5clSvWZtXh4Hvk2R/Yrnllfelerqh6nn98zVLc57vIC6U6U5Yk/b
 G18DSBsilC/JiMlCzIy5Ti4MTVN60M4Gz/bsMP4mLD2XKScqVv4BVgBvUdL6K4T1MTPV
 9UWLuahvlkgdyqPtx4uF7p/OYAV3yedi4216Ss4V7q9eUSSUI6BFxq1HMwsRw/SlE32w
 kcmvA76BbRFAg4A8KqoSBlvxoioX+KC0hago0r3hnX/yO1HBiiWTcdp17aOEAInNfPmB
 PB9g==
X-Gm-Message-State: ANhLgQ3UxB0nxbHjlvB3TXP0mWr4caB8/cYgzJk35yO+botwKpKiiIcA
 hEWnFbNgro2gRfQl1PtLnva/FjVK
X-Google-Smtp-Source: ADFU+vtd1zFbnF0Mvp9vHqOIKgjJVHCBIaWLaceyUy3NuzoabVUfhA80V1C0a0P0G1DpDs5fs8vFWQ==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr22684969wru.390.1585673465963; 
 Tue, 31 Mar 2020 09:51:05 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.51.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:51:05 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 26/26] lpfc: nvmet: Add Send LS Request and Abort LS
 Request support
Date: Tue, 31 Mar 2020 09:50:11 -0700
Message-Id: <20200331165011.15819-27-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095108_875175_6030DC03 
X-CRM114-Status: GOOD (  15.10  )
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

Now that common helpers exist, add the ability to Send an NVME LS Request
and to Abort an outstanding LS Request to the nvmet side of the driver.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
  Removed the xmt_ls_xxx and cmpl_ls_xxx atomic stats that aren't
  meaningful to be tracked.
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index df0378fd4b59..0d137ce7aa0b 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1283,6 +1283,98 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
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
+	__lpfc_nvme_ls_req_cmp(phba, cmdwqe->vport, cmdwqe, wcqe);
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
+	ret = __lpfc_nvme_ls_req(phba->pport, ndlp, pnvme_lsreq,
+				 lpfc_nvmet_ls_req_cmp);
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
@@ -1325,6 +1417,8 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.fcp_req_release = lpfc_nvmet_xmt_fcp_release,
 	.defer_rcv	= lpfc_nvmet_defer_rcv,
 	.discovery_event = lpfc_nvmet_discovery_event,
+	.ls_req         = lpfc_nvmet_ls_req,
+	.ls_abort       = lpfc_nvmet_ls_abort,
 	.host_release   = lpfc_nvmet_host_release,
 
 	.max_hw_queues  = 1,
@@ -1336,6 +1430,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.target_features = 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz = sizeof(struct lpfc_nvmet_tgtport),
+	.lsrqst_priv_sz = 0,
 };
 
 static void
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
