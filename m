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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C6CC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF4E20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hDbm/oSw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmV8Vn55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF4E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/eZDOa98CA+f164QWu9ZBf9WZ2G2nozVB5VJd+P0L+E=; b=hDbm/oSwdngGC7svnboB8Kz1B9
	b5d9YiwvdboxaHjh3Rnk5HtOZcPVPfK+ZwdjfycSj03ISTBnZLPMWPWhfdK6L5lT1ss4JjMPOFOIY
	jCdZRROIVqRcu3SmGkYH9+5TQNgDDdbjSayFL2FxYo2Ft4fb0WkdHY/1C544BtqAovQ15OgLga+pg
	UNYsdEFPcmTCYqinDMGwOTEzZeBtixZ6O4cn2xGLK15QNdpFrs5RZtCmJqueBy6nF7kzMt+v8tCsE
	fmXkCShNQuJCEVPB1aLZKwW7tbI/ZLVvgNWFUvqtIPnILqaSFDInDCCsgZ/IO32F+4Lc8ROmt8gXg
	GKQV2UhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPgs-0003oP-LG; Wed, 05 Feb 2020 18:46:22 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZY-00044i-Hm
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:39:05 +0000
Received: by mail-wr1-x442.google.com with SMTP id w12so4040532wrt.2
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/3Uip2WX8dUhLb6spglSuU9RfnCOYQwfKZLWVI/EM5s=;
 b=LmV8Vn553+1Lhkj0PXm4wKR0BEOr67bFYLcLIuKU60W40mycHtGM1JGgLUugo7ujCY
 NIdRHTXBpMakPvRpYoHjf+9EDLhbYyeYmYefldnp1gHA+vlua07MdWBcW9HkG4RZdZ+/
 dKRw8anb3xJI+7TG2Ssandp+ggBezpGjYNi4zLQOtgbeyv1fBZAhyi4agaHrHClOMCcN
 M5Wm6u5CRGkrqE2jyLnh0/OUuAWTz7f+NOctQIBmvqeW/QLe17kURT5V7GMUzAh5WZXK
 dWVKbbXduFWoPSGalTblSMbuSLrCBks1wfb1tC7N8tV0KXd/fViBgc9GrlQP3zEqvcAe
 kfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/3Uip2WX8dUhLb6spglSuU9RfnCOYQwfKZLWVI/EM5s=;
 b=Py/Ou1XbmHNdKvEXEwEAdEPX8Xjm4pffKRQ+9R5aDJ2R6IxP4/ThfGokj+rD17Rc0D
 68w/iVlVUi5aK7uzj8LJ0PsNIUwK9snkzmwMlL/TDk7d45cvuMXWbwM60MM7qi6WukAT
 G5eojMAvxl7udpcVZLW8boWqmBQPEEDIJ05VN/OzTjZ3PCKrORSMjjOZFRJDxHf7VA9W
 XQ7gLhsAfq8too3wmEYAta+qObv8cuSvt2Pc9aISyPvj/VOd5UNackNvfuok11tqhsJJ
 YGPkkk6MsC30QB3cByfEOjOgBu2okslYAjFj7zMiEWkP8bB9SzQ7dMoWRScVatIYUSBv
 EaSA==
X-Gm-Message-State: APjAAAWVNkXE+MCZ6G2IY+L0+T6cETlcd1Qdwp2HJCuW4C85oIjKaGgo
 AHElAkG4E1rcANT4U/5i9lUxwHKH
X-Google-Smtp-Source: APXvYqzAzsCDTAXCWlz4RfbFQKL/WMLAUI0X0Li/HtdPFFCK19cdpd1uQhsxDpv7ZnenVvZ+jT50JA==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr30082577wro.421.1580927926679; 
 Wed, 05 Feb 2020 10:38:46 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:46 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 28/29] lpfc: nvmet: Add support for NVME LS request hosthandle
Date: Wed,  5 Feb 2020 10:37:52 -0800
Message-Id: <20200205183753.25959-29-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103848_907910_A277AD0A 
X-CRM114-Status: GOOD (  22.43  )
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
---
 drivers/scsi/lpfc/lpfc_crtn.h      |  2 ++
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  6 +++++
 drivers/scsi/lpfc/lpfc_nportdisc.c | 11 ++++++++
 drivers/scsi/lpfc/lpfc_nvme.h      |  3 +++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 53 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 928e40fcf544..9ff292540072 100644
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
index 05d51945defd..6943943340d3 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -822,6 +822,12 @@ lpfc_cleanup_rpis(struct lpfc_vport *vport, int remove)
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
index 1324e34f2a46..400201c2e2f6 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -434,6 +434,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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
@@ -749,6 +754,12 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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
index e4e696f12433..b3c439a91482 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -108,9 +108,12 @@ struct lpfc_nvme_fcpreq_priv {
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
@@ -1284,6 +1284,24 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 }
 
 static void
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
+static void
 lpfc_nvmet_discovery_event(struct nvmet_fc_target_port *tgtport)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
