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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC0C2D0F1
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:07:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE15F20BED
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BGvz8mEe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X13t2hJS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1xtWfkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE15F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hvcgx47l267zOAPdazTthhWenjUW6Tk2PNcEVGaUn34=; b=BGvz8mEen1mxx/bUx/jz0nrFoK
	V6whd8pqPq9uPZ1saBiM4PwU9H8kYCFk4sLzqvlEoqpHH8p0aJjehF70lE9EQK4cNnxoMM4SeU2Cx
	tj/7eEhIedz9Lob4qUG0cCCDhRpqhS8GlaBqloTTQxNq+PJmdCwER+iNAj8zjJMFvP0dIVF1Sqt2N
	xqdeBlwbLi7UW5txELVsAOYDnErJ1ktB6fxZM6XHkE9FJlus0HdmxvOomIxhVOWvRdSjnVG+1fr2a
	djGWxwGSIabOPz+Z9gLIPddX8MKTBf1+NW7t4XMwphjozbz+wJpi9bCicKPbp7eoZ+WoNZdwSnY6W
	qawzs0gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKMJ-0001i0-B9; Tue, 31 Mar 2020 17:07:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJKMH-0001Xq-U2
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 17:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H96/698/4Z+l5bCPIZDMuyuQaHWZ2CIho6yGGcdCuMA=; b=X13t2hJSM3JM16HDm9k4yElbKB
 KLY670aykDAvcPDc7vdsOe8hA2dIKDNJrg57lVaV4cB18KTOteZKU0mfS5966Wvxj5jYqqFTaE4fY
 hRfINGW1X36kNZ4Kk9C+FCSFHrt0YDb+pYgR+XQAUJezoIRu0wSK24Q+BB5Eh3MfrH1yj6S0Xt+/q
 Gkn3O0Q0jOWqRwLlXb8QdzGiaTjAeFEiHZgOyD4ojWnZg3pCfPs+cl4zXTJce++P/MVZKPlUbsIUB
 GJObeTHLnT8npauWwkwbfqWNKs6PkxnSwkhBsP9vRjl6lC0NARQZDR5ku3ftghr+eikVYPEs+RZKP
 2yNfuf3w==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK6S-0008JM-70
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:51:05 +0000
Received: by mail-wm1-x342.google.com with SMTP id i19so3628324wmb.0
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H96/698/4Z+l5bCPIZDMuyuQaHWZ2CIho6yGGcdCuMA=;
 b=X1xtWfkRiZaEnuJonEsfrBxgIbAfb5L1IBnIneJ6vkD4SdFK8uD28O7bgcXfvxHH26
 hipS8/20J4Qp0VjPEOlc08+fM2fiU8gjLyJICQSRXesqwgXagbHZRI+l1PPkXyFdv3s0
 JbK0gq3cH0kKWqESCi7BS5h8u1g2rxEZ8vweDEd7Y8nhHjYVuLfOuL89izt70iYA6Ifi
 uEp+2NFAIajQ3JwvtYzSZkqMeb/aTsgo2wzFe+EW95w35s/NtTvkpp0jkVuytDGp4lHj
 lRyOcmZeQf0r2hAJxYKCJRmj+E9o1XQf5UqVrLIA/+XhDyyO4uoehy+BFgIUCGIlyHKs
 8v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=H96/698/4Z+l5bCPIZDMuyuQaHWZ2CIho6yGGcdCuMA=;
 b=eMhs/H2YlmI/kPoaXCNx7cLvt50FEZI9FTiY6UvLex6hXkLJg51/kshzLkwT1Q4Wky
 iymZ54d9sbcU1WydyY/yVQcsquaUsz5ZYS6wG1APHfLEp1JCECv/z2Q0d/UD4BKdzG/T
 lqNIawK2+S0IU0vDv/9BMco1KtNTtso79jm3/QkRumwS/jgMFRuUmOHZLegAmkxwCRB5
 5i/le372Ld8ihPL78xCJtCBnKmVM9M+z/Q2OhjWkcVNp/OTPUFaFkMYCL86BezjXk4/P
 TFjgNbPV8qvMaZyQ8iofGuc/gke6ziVv+L5qM1AMKJ7AYRc/cMqonMRFIOoi5cpJTEUc
 JtAA==
X-Gm-Message-State: ANhLgQ1ZLBvHvXiqvNBEWZWHUO6c1VHUyXSr9VdEJMcwq1iCqmDGgf7H
 EMYUvN2bi7r/0/0uznAt/6t5IYeP
X-Google-Smtp-Source: ADFU+vsbQIk3oA+p3FDqpQ0+3eSlVMmMu9kTMq6dby4KGXsaLQqlkgVE1chjnZfGHmyvXHCDSvlgAQ==
X-Received: by 2002:a05:600c:10ce:: with SMTP id
 l14mr4602417wmd.161.1585673462469; 
 Tue, 31 Mar 2020 09:51:02 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:51:01 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 24/26] lpfc: nvme: Add Receive LS Request and Send LS
 Response support to nvme
Date: Tue, 31 Mar 2020 09:50:09 -0700
Message-Id: <20200331165011.15819-25-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
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

Now that common helpers exist, add the ability to receive NVME LS requests
to the driver. New requests will be delivered to the transport by
nvme_fc_rcv_ls_req().

In order to complete the LS, add support for Send LS Response and send
LS response completion handling to the driver.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
  Removed the xmt_ls_xxx and rcv_ls_req_xxx atomic stats that aren't
  meaningful to be tracked.
---
 drivers/scsi/lpfc/lpfc_nvme.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index c6082c65d902..a868743ec3e3 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -400,6 +400,10 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
  * request. Any remaining validation is done and the LS is then forwarded
  * to the nvme-fc transport via nvme_fc_rcv_ls_req().
  *
+ * The calling sequence should be: nvme_fc_rcv_ls_req() -> (processing)
+ * -> lpfc_nvme_xmt_ls_rsp/cmp -> req->done.
+ * __lpfc_nvme_xmt_ls_rsp_cmp should free the allocated axchg.
+ *
  * Returns 0 if LS was handled and delivered to the transport
  * Returns 1 if LS failed to be handled and should be dropped
  */
@@ -407,6 +411,40 @@ int
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
+	if (!rc)
+		return 0;
+#endif
 	return 1;
 }
 
@@ -858,6 +896,37 @@ __lpfc_nvme_ls_abort(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 1;
 }
 
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
+	rc = __lpfc_nvme_xmt_ls_rsp(axchg, ls_rsp, __lpfc_nvme_xmt_ls_rsp_cmp);
+
+	if (rc) {
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
+	return 0;
+}
+
 /**
  * lpfc_nvme_ls_abort - Abort a prior NVME LS request
  * @lpfc_nvme_lport: Transport localport that LS is to be issued from.
@@ -2090,6 +2159,7 @@ static struct nvme_fc_port_template lpfc_nvme_template = {
 	.fcp_io       = lpfc_nvme_fcp_io_submit,
 	.ls_abort     = lpfc_nvme_ls_abort,
 	.fcp_abort    = lpfc_nvme_fcp_abort,
+	.xmt_ls_rsp   = lpfc_nvme_xmt_ls_rsp,
 
 	.max_hw_queues = 1,
 	.max_sgl_segments = LPFC_NVME_DEFAULT_SEGS,
@@ -2285,6 +2355,7 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
 		atomic_set(&lport->cmpl_fcp_err, 0);
 		atomic_set(&lport->cmpl_ls_xb, 0);
 		atomic_set(&lport->cmpl_ls_err, 0);
+
 		atomic_set(&lport->fc4NvmeLsRequests, 0);
 		atomic_set(&lport->fc4NvmeLsCmpls, 0);
 	}
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
