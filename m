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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A48C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DBD20848
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pH1N2UvW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrDVC/vp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWQITsMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DBD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8pqNyTzpWRKs0CnYPCwUcSu89HH3lUNnJHVPJ+wXsPc=; b=pH1N2UvW1GlnBiwhWJ7CbjLkip
	xPdD2Rz0vtne/uz6/trXGhLDPwcQc2ACF9c5DgytrUM0bseDXdjlW8rd0Te1lioiaWnRt/ztI1d8e
	36nu5FcJAIASB2WbOhPjpRHijxIui08RE25wYXwsu+nhG8GSOCEJEf8Y9eUNCXroXC/awJbPYbL61
	tKl/yC7CS5Z8R1pMxmfCYsx88daAyW9IBNs5GkOFP+u1LLXGPpMqigDXlFdl8Erb6H2YfDMknNu2D
	Vy5iIo7G2NJjW7pDJCaRJ+OtotbiM/JfmK+BZWIc04/ryfrhyATw516NPM3yFtYANvqcycY/A3hVM
	EvjZrkLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKQb-0005B1-C3; Tue, 31 Mar 2020 17:11:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJKQX-00054g-4Y
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 17:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lRZPiWHa6VvXJ3Mlf57/sZBwnojQKzmZE/doY2MyXsQ=; b=YrDVC/vpy2sM7dLM27HdyhIbu8
 A+LHbVw/UhcuLPL1HReJ2u9AHr7l3rPmx0tprITjnhh8E7mbC8diUhSxc/mucL3ozwWkQaoM60x3i
 iiBX37sTzkDL2fVx8rDuW+XhmOEhSoDwIxI1jTv2ExifJXMwuzdJRMWjXThhrtO28jQA9Tngg8rkN
 JD5rqmqFwp+q2ADU5MkJacwovp/4k+qBXxqcHjkgySAlMwYUwKC/tTBdub/Eju5r6pXHyAU0C3212
 jqgtr1hCdlFTxE4nQCW/ARNMVoXurW8WEfbN807KJ5yLvWpI4tldAJf/+N8W2uetzIhbRnD/s57E1
 Cq3xMZmA==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6U-0007bT-EC
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:10 +0000
Received: by mail-wm1-x341.google.com with SMTP id t128so3332420wma.0
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lRZPiWHa6VvXJ3Mlf57/sZBwnojQKzmZE/doY2MyXsQ=;
 b=jWQITsMzeLV1GN2G+QQsbS/TEPnBXt8AUv5p2U5NCzwDaG6ZNqFUxkJ/+9Xdrlt+ee
 YuYueo+GKokywHTumiz/5P2SdGuRmGpF9DlXcC9GifSSlMs6yImby3EQYid6W8j2uKso
 X4JLVRDgBe3WOWaHGyDxf1hrBHwaVMPyXtbffoWYV8uH8D6bVL96Ussz93d5dqwk/zU1
 CUGnXrJoZqB9fs0mvm4Wejl1qxHij/2pRyihJQ25neZoQCXWRyxmpYrtU7m2VJbU1eGs
 52zCFPcm/gWLGwijy+e9hjZe6Vyh9VnTX1tWqCRwL14A2n4DBgksOaZzsoZbjPSqyJXI
 CFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lRZPiWHa6VvXJ3Mlf57/sZBwnojQKzmZE/doY2MyXsQ=;
 b=CeqrTbh3Ykjvj28rmu3oqhtGXkL3SPI4wUWIc8X9LNbF95NrOJ8SHIXRBn40RLqs4n
 M1ilLEfHyedoaQunk4E3et2bNhw3ESVwlYX/pOmZMUMIB4UkaiN+w+OlYb4lr1SVUu7H
 eaNAN9cx6tEATLrgUVvG4m3U4xgicwsffjZSdst15GjAoIzvRbchxHh+KMlRS+ui3lsc
 zxqNpUb73AV/f0cBqDDQGGjxK6XJjAnGQ2ubkET4SrGTuMMUCAOgJcr6pnBYhtJ4rh7O
 c1FB5knsguVG8eRdGs2lsw/X2K1D5M1S5nN7jFAFjLzEVK09Y7mMQZ0Ka906sgGAZJ78
 CA3A==
X-Gm-Message-State: ANhLgQ2xG6NGh4yNi7Q0KTHCHVmM28ht3EujX7+cao60TXth+8hisgKb
 3NhvOtMFwwXniji856/3bkpAvaR+
X-Google-Smtp-Source: ADFU+vtZKDsK5iTP/uqVBD8KJ2K0hioC0yt0M8BaWoob1EhS6jlM77IH82Ody7GZpYZiODMYxb7nCA==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr4415498wmj.149.1585673464130; 
 Tue, 31 Mar 2020 09:51:04 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.51.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:51:03 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 25/26] lpfc: nvmet: Add support for NVME LS request
 hosthandle
Date: Tue, 31 Mar 2020 09:50:10 -0700
Message-Id: <20200331165011.15819-26-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_175106_679271_6A851985 
X-CRM114-Status: GOOD (  29.11  )
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

As the nvmet layer does not have the concept of a remoteport object, which
can be used to identify the entity on the other end of the fabric that is
to receive an LS, the hosthandle was introduced.  The driver passes the
hosthandle, a value representative of the remote port, with a ls request
receive. The LS request will create the association.  The transport will
remember the hosthandle for the association, and if there is a need to
initiate a LS request to the remote port for the association, the
hosthandle will be used. When the driver loses connectivity with the
remote port, it needs to notify the transport that the hosthandle is no
longer valid, allowing the transport to terminate associations related to
the hosthandle.

This patch adds support to the driver for the hosthandle. The driver will
use the ndlp pointer of the remote port for the hosthandle in calls to
nvmet_fc_rcv_ls_req().  The discovery engine is updated to invalidate the
hosthandle whenever connectivity with the remote port is lost.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/lpfc/lpfc_crtn.h      |  2 ++
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  6 +++++
 drivers/scsi/lpfc/lpfc_nportdisc.c | 11 ++++++++
 drivers/scsi/lpfc/lpfc_nvme.h      |  3 +++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 53 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 51b0f01c6206..6bccad7106ee 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -572,6 +572,8 @@ void lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba, uint32_t idx,
 				struct rqb_dmabuf *nvmebuf, uint64_t isr_ts,
 				uint8_t cqflag);
 void lpfc_nvme_mod_param_dep(struct lpfc_hba *phba);
+void lpfc_nvmet_invalidate_host(struct lpfc_hba *phba,
+			struct lpfc_nodelist *ndlp);
 void lpfc_nvme_abort_fcreq_cmpl(struct lpfc_hba *phba,
 				struct lpfc_iocbq *cmdiocb,
 				struct lpfc_wcqe_complete *abts_cmpl);
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 000a26d46f54..b2278df447d3 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -823,6 +823,12 @@ lpfc_cleanup_rpis(struct lpfc_vport *vport, int remove)
 		if ((phba->sli_rev < LPFC_SLI_REV4) &&
 		    (!remove && ndlp->nlp_type & NLP_FABRIC))
 			continue;
+
+		/* Notify transport of connectivity loss to trigger cleanup. */
+		if (phba->nvmet_support &&
+		    ndlp->nlp_state == NLP_STE_UNMAPPED_NODE)
+			lpfc_nvmet_invalidate_host(phba, ndlp);
+
 		lpfc_disc_state_machine(vport, ndlp, NULL,
 					remove
 					? NLP_EVT_DEVICE_RM
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 81f4ba1c24b4..d8501bd959e7 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -489,6 +489,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 					 (unsigned long long)
 					 wwn_to_u64(sp->portName.u.wwn));
 
+		/* Notify transport of connectivity loss to trigger cleanup. */
+		if (phba->nvmet_support &&
+		    ndlp->nlp_state == NLP_STE_UNMAPPED_NODE)
+			lpfc_nvmet_invalidate_host(phba, ndlp);
+
 		ndlp->nlp_prev_state = ndlp->nlp_state;
 		/* rport needs to be unregistered first */
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
@@ -839,6 +844,12 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
 	else
 		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
+
+	/* Notify transport of connectivity loss to trigger cleanup. */
+	if (phba->nvmet_support &&
+	    ndlp->nlp_state == NLP_STE_UNMAPPED_NODE)
+		lpfc_nvmet_invalidate_host(phba, ndlp);
+
 	if (ndlp->nlp_DID == Fabric_DID) {
 		if (vport->port_state <= LPFC_FDISC)
 			goto out;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 2ce29dfeedda..4dab4d9705a6 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -99,9 +99,12 @@ struct lpfc_nvme_fcpreq_priv {
 #define LPFC_NVMET_WAIT_TMO		(5 * MSEC_PER_SEC)
 
 /* Used for NVME Target */
+#define LPFC_NVMET_INV_HOST_ACTIVE      1
+
 struct lpfc_nvmet_tgtport {
 	struct lpfc_hba *phba;
 	struct completion *tport_unreg_cmp;
+	atomic_t state;		/* tracks nvmet hosthandle invalidation */
 
 	/* Stats counters - lpfc_nvmet_unsol_ls_buffer */
 	atomic_t rcv_ls_req_in;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index edec7c3ffab1..df0378fd4b59 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1283,6 +1283,24 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
+static void
+lpfc_nvmet_host_release(void *hosthandle)
+{
+	struct lpfc_nodelist *ndlp = hosthandle;
+	struct lpfc_hba *phba = NULL;
+	struct lpfc_nvmet_tgtport *tgtp;
+
+	phba = ndlp->phba;
+	if (!phba->targetport || !phba->targetport->private)
+		return;
+
+	lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
+			"6202 NVMET XPT releasing hosthandle x%px\n",
+			hosthandle);
+	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
+	atomic_set(&tgtp->state, 0);
+}
+
 static void
 lpfc_nvmet_discovery_event(struct nvmet_fc_target_port *tgtport)
 {
@@ -1307,6 +1325,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.fcp_req_release = lpfc_nvmet_xmt_fcp_release,
 	.defer_rcv	= lpfc_nvmet_defer_rcv,
 	.discovery_event = lpfc_nvmet_discovery_event,
+	.host_release   = lpfc_nvmet_host_release,
 
 	.max_hw_queues  = 1,
 	.max_sgl_segments = LPFC_NVMET_DEFAULT_SEGS,
@@ -2045,7 +2064,12 @@ lpfc_nvmet_handle_lsreq(struct lpfc_hba *phba,
 
 	atomic_inc(&tgtp->rcv_ls_req_in);
 
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &axchg->ls_rsp,
+	/*
+	 * Driver passes the ndlp as the hosthandle argument allowing
+	 * the transport to generate LS requests for any associateions
+	 * that are created.
+	 */
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, axchg->ndlp, &axchg->ls_rsp,
 				 axchg->payload, axchg->size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
@@ -3478,3 +3502,30 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 			"6056 Failed to Issue ABTS. Status x%x\n", rc);
 	return 0;
 }
+
+/**
+ * lpfc_nvmet_invalidate_host
+ *
+ * @phba - pointer to the driver instance bound to an adapter port.
+ * @ndlp - pointer to an lpfc_nodelist type
+ *
+ * This routine upcalls the nvmet transport to invalidate an NVME
+ * host to which this target instance had active connections.
+ */
+void
+lpfc_nvmet_invalidate_host(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
+{
+	struct lpfc_nvmet_tgtport *tgtp;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_NVME_ABTS,
+			"6203 Invalidating hosthandle x%px\n",
+			ndlp);
+
+	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
+	atomic_set(&tgtp->state, LPFC_NVMET_INV_HOST_ACTIVE);
+
+#if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
+	/* Need to get the nvmet_fc_target_port pointer here.*/
+	nvmet_fc_invalidate_host(phba->targetport, ndlp);
+#endif
+}
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
