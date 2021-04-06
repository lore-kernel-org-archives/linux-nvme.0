Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD2C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:09:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49041613A9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49041613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XcjKUj0gYhlEuTZPwl3fMJ7zz24JoRT5+xoMhMJSQao=; b=XSCdW6LrwW4FnYdffD0b9GqPOU
	h2WSKFQBGVY956w4lBA2WI9U5Oo1yXwQuuuly0irs3XlLHIsiwwFdZ+s3pzbyx1JigL9v2FYriUp8
	to8sPyEO8x4fP9cfSo7P/evEuH4cCRgWWGzDISKOV6eIVn/twTIl42BJkU4MJgs6XlKhN5HOtNpTD
	fAfcTdbHxSdhrih/9G6u46B89zE00irAzWlkq5pcJIzgD0T+rntEhQV2e1lBsyg6WLfK479kvAcTE
	l3kma4XLJwrY+OSuZqgqkhDtWvKBc2ACxUhwZLvfR3l82AcPPEx3/FV8l1RH50pCzPO1QSA2kYOZx
	BeWeExLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU1Nm-004BQU-Er; Wed, 07 Apr 2021 06:09:42 +0000
Received: from saphodev.broadcom.com ([192.19.232.172]
 helo=relay.smtp-ext.broadcom.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1Ly-004BAm-SH
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 06:08:00 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id A98AF24323;
 Tue,  6 Apr 2021 22:59:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A98AF24323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1617775163;
 bh=2YgMQ5KOWA01f4QClAwpTk6e0Fkj9IafQ49xlySuTDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WVn02tlfCDqpLvAWDsMgT/CzomWDS7TRq+SUFeT3XTQO3hASVThQK+eGhzi+m/Dbs
 rwUpX5cbLIqXYzt5c2DJbeKpPU3fk2VryknXAtAO/fv+NvVl9szg7hwBcjSbtR64cz
 S2Je9LzYw1b+aH6tq580pbNjOQfynXs1Wgbb1Lu8=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v9 10/13] lpfc: vmid: Appends the vmid in the wqe before
 sending
Date: Wed,  7 Apr 2021 04:36:34 +0530
Message-Id: <1617750397-26466-11-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_070752_888922_08F30E5D 
X-CRM114-Status: GOOD (  13.65  )
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
MIME-Version: 1.0
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
 drivers/scsi/lpfc/lpfc_sli.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3f212555f3ac..22296ed691f6 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9764,6 +9764,8 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
+				*pcmd == ELS_CMD_QFPA ||
+				*pcmd == ELS_CMD_UVEM ||
 				*pcmd == ELS_CMD_PLOGI)) {
 				bf_set(els_req64_sp, &wqe->els_req, 1);
 				bf_set(els_req64_sid, &wqe->els_req,
@@ -9895,6 +9897,24 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per switch response */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_iwrite.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_iwrite.wqe_com,
+				       1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_FCP_IREAD64_CR:
 		/* word3 iocb=iotag wqe=payload_offset_len */
@@ -9959,6 +9979,23 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per switch response */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_iread.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_iread.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_iread.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_iread.wqe_com, 1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_FCP_ICMND64_CR:
 		/* word3 iocb=iotag wqe=payload_offset_len */
@@ -10016,6 +10053,23 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per switch response */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_icmd.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_icmd.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_icmd.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_icmd.wqe_com, 1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_GEN_REQUEST64_CR:
 		/* For this command calculate the xmit length of the
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
