Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B62C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5116134F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5116134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vg27UAU9QyTbsLbGnhuu5L1qYSDPUZAvYbCJGcfMdcQ=; b=Ib+QCZ8paE3aPo
	P/hrybL7YydDE6jlwCtl1tioONYuugKGdepottYdBRhfqwXdzxGYywiXcTYVSQkmKqh6k99DTVJTB
	gi7DNivsn89DOgfDiOpNkkSMCKsytOWgvNqs+//z8Gzik0NFjP68FoJWvRTnIJWW+AKsxWeoMjps/
	iiJyFooHSgJP7frGWh16YZPFE7F7CMa9dprxzQNRewQGE3xYzsNE4KCEyuDL5VDhnc9LKuCidnY4x
	Q9vbMm0lLFS3vLAiw8BwtE3Rw48IuLrwrVYNuGX77vfpGIiKJUOG5l/9Jt+TmW/wAeoz5gHaD0uM3
	1C8Hu67L4Q6d1DQ8o5nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqa5p-0085KL-BC; Tue, 08 Jun 2021 11:40:25 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqZuJ-00826h-4B
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 11:28:36 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 38DF43C15B;
 Tue,  8 Jun 2021 04:28:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 38DF43C15B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1623151710;
 bh=OSYVwtPqAU+uuaWNkLfPV6bFE5dYJkzPbB2/elnXCLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wX0vbdyUxIXQkatqMYRxjDdrauOTy0Ok9dXhm/EmxT6niLkRRmSc2OUi2bvpbsBI6
 MkTM9VASEbkfHyGUR9HgPE9x6OCP7W5BlrSi0RrfECGEtqN+BmL4VIcvvqPyofc3Ii
 FudGpk4mnb60ghQjk7nJTspw/+m6xDUhjp5Ux4AM=
From: Muneendra Kumar <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v11 10/13] lpfc: vmid: Appends the vmid in the wqe before
 sending
Date: Tue,  8 Jun 2021 10:05:53 +0530
Message-Id: <20210608043556.274139-11-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210608043556.274139-1-muneendra.kumar@broadcom.com>
References: <20210608043556.274139-1-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_042831_267283_A0039BE5 
X-CRM114-Status: GOOD (  12.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the vmid in wqe before sending out the request.
The type of vmid depends on the configured type and is checked before
being appended.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v11:
No change

v10:
Removed redudant code

v9:
No change

v8:
Modified the log messages

v7:
No change

v6:
No change

v5:
Modified the comments

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_sli.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c7d0acd6c8ef..6555308cea7a 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9766,6 +9766,8 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
+				*pcmd == ELS_CMD_QFPA ||
+				*pcmd == ELS_CMD_UVEM ||
 				*pcmd == ELS_CMD_PLOGI)) {
 				bf_set(els_req64_sp, &wqe->els_req, 1);
 				bf_set(els_req64_sid, &wqe->els_req,
@@ -10328,6 +10330,18 @@ __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
 		bf_set(wqe_wqes, &wqe->generic.wqe_com, 0);
 	}
 
+	/* add the VMID tags as per switch response */
+	if (unlikely(piocb->iocb_flag & LPFC_IO_VMID)) {
+		if (phba->pport->vmid_priority_tagging) {
+			bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
+					(piocb->vmid_tag.cs_ctl_vmid));
+		} else {
+			bf_set(wqe_appid, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_wqes, &wqe->fcp_iwrite.wqe_com, 1);
+			wqe->words[31] = piocb->vmid_tag.app_id;
+		}
+	}
 	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
 	return rc;
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
