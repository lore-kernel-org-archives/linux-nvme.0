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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85ABC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A958620674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gp1qI7E1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5zQ2Knt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A958620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=queXCo9XGRYahKyhvYR2lf9lffz/5dUpC4HfpEg38pU=; b=gp1qI7E16/yq3hSJih9kqhhAhY
	5NboVwlXaEzTQ3jIz+ZyaXQHCSuQiXYlondPwhuUg9OimzGlzGHPApF8Ktj+V+8zHREzj89yuja+U
	rm/6EX7pltropvPz4RnaijgH89bLWypIIhLXtDLadiZzqdyQjjVqmkb2daMl8iTSiArVpqYH4OUeh
	b5oCoGQvPOw9ZoF77S0L5TsH1VhLN7FbcaO8rmoV4ISgTQQVctf6hm8CJZ1vZ4ORokLmBuSoJVGHn
	ghCYxnnMxuDpO8rtDGjoI9shz+bDnbsUbaPERh5mGgFiwAQjfKwquvQMkAbFnSNUfPHGXf8NvCYhh
	739R8k6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPg5-00038R-Pm; Wed, 05 Feb 2020 18:45:33 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZW-00043K-Sw
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:39:01 +0000
Received: by mail-wr1-x442.google.com with SMTP id a6so3975858wrx.12
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9gjKFqJugmk40ANWaMoLhgO8uz4uBIDZNAl7eyDzmdE=;
 b=p5zQ2KntnB1lLglDSxjLswXQEDbPg9haJYHXUGCi5SHl2Lxy0UnqChvHI/H0RMItzy
 EssPu59718s8D3aZlaSIw3SUe+PHFafMATUHoEyLc8Eg220JgkglHOYA9QBicWBVrTpy
 m9yXEJF5lnBZF4d5Qi1/QyFKQJ/9miFrncZr+tfiv4HNLIWbFYRGuX6dZM6QoKB2euVH
 GOB6cFkhg3bLX7CyoTjNJg+0VSWI0SDHhhJtyB5lP1QgsQmH/EYGVgwvUkkpK9mfh/OM
 wBUarWTI5djO17p6NBI7Zc5SVj/8F2nS9RYZvjif27P4TMstIi+dDAbtxLImZqCCNfeM
 jsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9gjKFqJugmk40ANWaMoLhgO8uz4uBIDZNAl7eyDzmdE=;
 b=tL/sT4CZnfNAwcqps4As41NMXfoTnlK2cRsEw3WbTkWK56hrpxgVkFAOud+xjg8Toy
 H5daBsqO1cLAXWLRPhErZV9Yd8WYy93UbY6bHDt33kmFB9F79kmlTRL4qB5ORVYrqd28
 x/8GKfqP/jcoqjLUhhNBaxEzQm4H3VJNHj2pFOU3GvnbLdDl7es1XsJy3hDiZWTPIt9p
 cCA0jfRrspelmw6mLnb+RjLqm6YlTRR4oH6ufdMFU4YIwraJoNMDkFNMrOSlww2OxRE2
 GoO+8UWOCjtbYWroQu9ZV0MYcCHeHvd5uDM/D/Umyp/Eb6xRKDsxgsxZItlpB06RZz0C
 JJlw==
X-Gm-Message-State: APjAAAVvRl4D+7++ID/ObMFUYCPovuxFfVmAKmgCyLqY84UGJyOXmtgC
 ZIPrcaYQEq6d2/8EaHww70l4G4Dr
X-Google-Smtp-Source: APXvYqwcDqtOxNlPxqnBb8lxP/Z4thdmTF86HcIB9WdPWvCNSoqmkaQ1k7Pi//oJs68esXfbrlm0tQ==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr31934121wrm.394.1580927925151; 
 Wed, 05 Feb 2020 10:38:45 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:44 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 27/29] lpfc: nvme: Add Receive LS Request and Send LS Response
 support to nvme
Date: Wed,  5 Feb 2020 10:37:51 -0800
Message-Id: <20200205183753.25959-28-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103847_088283_B214D356 
X-CRM114-Status: GOOD (  18.20  )
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

Now that common helpers exist, add the ability to receive NVME LS requests
to the driver. New requests will be delivered to the transport by
nvme_fc_rcv_ls_req().

In order to complete the LS, add support for Send LS Response and send
LS response completion handling to the driver.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 130 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_nvme.h |   9 +++
 2 files changed, 139 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index c6082c65d902..9f5e8964f83c 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -400,6 +400,10 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
  * request. Any remaining validation is done and the LS is then forwarded
  * to the nvme-fc transport via nvme_fc_rcv_ls_req().
  *
+ * The calling sequence should be: nvme_fc_rcv_ls_req() -> (processing)
+ * -> lpfc_nvme_xmt_ls_rsp/cmp -> req->done.
+ * lpfc_nvme_xmt_ls_rsp_cmp should free the allocated axchg.
+ *
  * Returns 0 if LS was handled and delivered to the transport
  * Returns 1 if LS failed to be handled and should be dropped
  */
@@ -407,6 +411,46 @@ int
 lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
 			struct lpfc_async_xchg_ctx *axchg)
 {
+#if (IS_ENABLED(CONFIG_NVME_FC))
+	struct lpfc_vport *vport;
+	struct lpfc_nvme_rport *lpfc_rport;
+	struct nvme_fc_remote_port *remoteport;
+	struct lpfc_nvme_lport *lport;
+	uint32_t *payload = axchg->payload;
+	int rc;
+
+	vport = axchg->ndlp->vport;
+	lpfc_rport = axchg->ndlp->nrport;
+	if (!lpfc_rport)
+		return -EINVAL;
+
+	remoteport = lpfc_rport->remoteport;
+	if (!vport->localport)
+		return -EINVAL;
+
+	lport = vport->localport->private;
+	if (!lport)
+		return -EINVAL;
+
+	atomic_inc(&lport->rcv_ls_req_in);
+
+	rc = nvme_fc_rcv_ls_req(remoteport, &axchg->ls_rsp, axchg->payload,
+				axchg->size);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
+			"6205 NVME Unsol rcv: sz %d rc %d: %08x %08x %08x "
+			"%08x %08x %08x\n",
+			axchg->size, rc,
+			*payload, *(payload+1), *(payload+2),
+			*(payload+3), *(payload+4), *(payload+5));
+
+	if (!rc) {
+		atomic_inc(&lport->rcv_ls_req_out);
+		return 0;
+	}
+
+	atomic_inc(&lport->rcv_ls_req_drop);
+#endif
 	return 1;
 }
 
@@ -859,6 +903,81 @@ __lpfc_nvme_ls_abort(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 }
 
 /**
+ * lpfc_nvme_xmt_ls_rsp_cmp - Completion handler for LS Response
+ * @phba: Pointer to HBA context object.
+ * @cmdwqe: Pointer to driver command WQE object.
+ * @wcqe: Pointer to driver response CQE object.
+ *
+ * The function is called from SLI ring event handler with no
+ * lock held. This function is the completion handler for NVME LS commands
+ * The function updates any states and statistics, then calls the
+ * generic completion handler to free resources.
+ **/
+static void
+lpfc_nvme_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
+			  struct lpfc_wcqe_complete *wcqe)
+{
+	struct lpfc_vport *vport = cmdwqe->vport;
+	struct lpfc_nvme_lport *lport;
+	uint32_t status, result;
+
+	status = bf_get(lpfc_wcqe_c_status, wcqe) & LPFC_IOCB_STATUS_MASK;
+	result = wcqe->parameter;
+
+	if (!vport->localport)
+		goto finish;
+
+	lport = (struct lpfc_nvme_lport *)vport->localport->private;
+	if (lport) {
+		if (status) {
+			atomic_inc(&lport->xmt_ls_rsp_error);
+			if (result == IOERR_ABORT_REQUESTED)
+				atomic_inc(&lport->xmt_ls_rsp_aborted);
+			if (bf_get(lpfc_wcqe_c_xb, wcqe))
+				atomic_inc(&lport->xmt_ls_rsp_xb_set);
+		} else {
+			atomic_inc(&lport->xmt_ls_rsp_cmpl);
+		}
+	}
+
+finish:
+	__lpfc_nvme_xmt_ls_rsp_cmp(phba, cmdwqe, wcqe);
+}
+
+static int
+lpfc_nvme_xmt_ls_rsp(struct nvme_fc_local_port *localport,
+		     struct nvme_fc_remote_port *remoteport,
+		     struct nvmefc_ls_rsp *ls_rsp)
+{
+	struct lpfc_async_xchg_ctx *axchg =
+		container_of(ls_rsp, struct lpfc_async_xchg_ctx, ls_rsp);
+	struct lpfc_nvme_lport *lport;
+	int rc;
+
+	if (axchg->phba->pport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
+	lport = (struct lpfc_nvme_lport *)localport->private;
+
+	rc = __lpfc_nvme_xmt_ls_rsp(axchg, ls_rsp, lpfc_nvme_xmt_ls_rsp_cmp);
+
+	if (rc) {
+		atomic_inc(&lport->xmt_ls_drop);
+		/*
+		 * unless the failure is due to having already sent
+		 * the response, an abort will be generated for the
+		 * exchange if the rsp can't be sent.
+		 */
+		if (rc != -EALREADY)
+			atomic_inc(&lport->xmt_ls_abort);
+		return rc;
+	}
+
+	atomic_inc(&lport->xmt_ls_rsp);
+	return 0;
+}
+
+/**
  * lpfc_nvme_ls_abort - Abort a prior NVME LS request
  * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
  * @lpfc_nvme_rport: Transport remoteport that LS is to be sent to.
@@ -2090,6 +2209,7 @@ static struct nvme_fc_port_template lpfc_nvme_template = {
 	.fcp_io       = lpfc_nvme_fcp_io_submit,
 	.ls_abort     = lpfc_nvme_ls_abort,
 	.fcp_abort    = lpfc_nvme_fcp_abort,
+	.xmt_ls_rsp   = lpfc_nvme_xmt_ls_rsp,
 
 	.max_hw_queues = 1,
 	.max_sgl_segments = LPFC_NVME_DEFAULT_SEGS,
@@ -2285,6 +2405,16 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
 		atomic_set(&lport->cmpl_fcp_err, 0);
 		atomic_set(&lport->cmpl_ls_xb, 0);
 		atomic_set(&lport->cmpl_ls_err, 0);
+		atomic_set(&lport->xmt_ls_rsp, 0);
+		atomic_set(&lport->xmt_ls_drop, 0);
+		atomic_set(&lport->xmt_ls_rsp_cmpl, 0);
+		atomic_set(&lport->xmt_ls_rsp_error, 0);
+		atomic_set(&lport->xmt_ls_rsp_aborted, 0);
+		atomic_set(&lport->xmt_ls_rsp_xb_set, 0);
+		atomic_set(&lport->rcv_ls_req_in, 0);
+		atomic_set(&lport->rcv_ls_req_out, 0);
+		atomic_set(&lport->rcv_ls_req_drop, 0);
+
 		atomic_set(&lport->fc4NvmeLsRequests, 0);
 		atomic_set(&lport->fc4NvmeLsCmpls, 0);
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index 2ce29dfeedda..e4e696f12433 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -67,6 +67,15 @@ struct lpfc_nvme_lport {
 	atomic_t cmpl_fcp_err;
 	atomic_t cmpl_ls_xb;
 	atomic_t cmpl_ls_err;
+	atomic_t xmt_ls_rsp;
+	atomic_t xmt_ls_drop;
+	atomic_t xmt_ls_rsp_cmpl;
+	atomic_t xmt_ls_rsp_error;
+	atomic_t xmt_ls_rsp_aborted;
+	atomic_t xmt_ls_rsp_xb_set;
+	atomic_t rcv_ls_req_in;
+	atomic_t rcv_ls_req_out;
+	atomic_t rcv_ls_req_drop;
 };
 
 struct lpfc_nvme_rport {
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
