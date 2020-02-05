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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B1C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E8A20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c+qM06y6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEhXkeTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E8A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MVWkjsC0LJTBOgc5HEfhqNOg6i1MT3lkavatrpfe9M8=; b=c+qM06y6XsQTkD6ewn3hVanq2T
	ELrC61NlJumKd81M59GwB9udOkP/Sa7N8pQMlTdHLmolBWng3W1pu4VGsx+Ss9QHDK8N161VfI+MM
	KYfzODQ/xvzwQ9uMNek1Lomx73itDzn8b3boEmLebzamPOi6eNWosJ6dFORs3OKpqjbPa1OmWqNin
	dzyrv1tK49fQ78etkp/ec52+taOHhYMZKZHZkWO4Grq/xvLyNjwPJza8W2obshxRpAOc7U9LOYAvh
	fJTmkI1W76N2wXldCQ9lmgdSXhGFaLnIUTphbkViRuZZQq/Z+fKJrByR70HBCVkLel8I6FnTqZwaQ
	Ht3g5GKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPa4-0004Q1-FK; Wed, 05 Feb 2020 18:39:20 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPYx-0003Tz-HN
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:13 +0000
Received: by mail-wm1-x344.google.com with SMTP id t14so4055982wmi.5
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=odwVNo4lR2SJH4+IJkdVLyOCJXySl3BbtojbPv9OltI=;
 b=pEhXkeTJK+DhPGQAO7rR8czV1Hq0NJHJmFT3PWJXOYeMG5qntjsB2Xpz78s9gQUe5d
 LfFCJysMQf1bh2bowD/YfV7Tqoi7nEyH/MhFtbvrVrWJqCfM56BcJEzBzRho83Q3KJtY
 2g6W4tjZIxPNuP+kn4U9CQKJN3s+h3T2Twa/9V/y5FmBNyHYt9OWPWFnuAdbgUaLRmjZ
 qmd5ogOaekja/81NLxje5520JAMDI5dpuHbPfymEUTBK53k4K9MbmBozYJmTT8wB/ehW
 1KwuNEUOvGBYi+LwNpdCPAhb/IdcW6kSUre+TAn3nFCso70HtcibDJhYyardH2GUDHQN
 JhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=odwVNo4lR2SJH4+IJkdVLyOCJXySl3BbtojbPv9OltI=;
 b=k5qh+jnQ+qngCqufAQMNMI3UW2mBbx3t0klUCvC1Hu614HMzkSP3N+PIv8fAuFgxOJ
 UW1ZgItltprUWGW4rlQBIl1c6VLNqIfAbaiPU78wWeezKKtEiwMzAVhsPgB45R6vfoPM
 qqHWl86uX6LrfmxK3SbPe06TGJubrVyARlzxdTHQ15bL8itCIvVntdpYrwoqt39KVcki
 Oq6HTU9Tl3m0b72bqcrdV3nS1Yzk7YKjwGbw7arV7nevrUOngmKnSJzANlVJeOM1ebJA
 tdyZNT4beGTljhOT3CEM4nuqk4bAwfSv0syP6NpwJLhJ3Iax0xDZQQmsA7WRRryQYXKb
 4s4w==
X-Gm-Message-State: APjAAAW5JLBGb+tgc9WA9FELfY8FJbmBFuR/7bdLgKn8B6dwm4Dll9Jn
 uTXpBTCjfIu3loV2S1FiDgzVS+o2
X-Google-Smtp-Source: APXvYqxR0mSJBxCQ0D3o6dW9jmbt96qZH78GWsfRgpt/nOQBs9vNdER7k6pe6V0/erSIHibJ27kGtg==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr7040783wml.116.1580927890025; 
 Wed, 05 Feb 2020 10:38:10 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:09 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 05/29] lpfc: adapt code to changed names in api header
Date: Wed,  5 Feb 2020 10:37:29 -0800
Message-Id: <20200205183753.25959-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103811_619598_9EBA6E2A 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

deal with following naming changes in the header:
  nvmefc_tgt_ls_req -> nvmefc_ls_rsp
  nvmefc_tgt_ls_req.nvmet_fc_private -> nvmefc_ls_rsp.nvme_fc_private

Change calling sequence to nvmet_fc_rcv_ls_req() for hosthandle.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 10 +++++-----
 drivers/scsi/lpfc/lpfc_nvmet.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 9dc9afe1c255..47b983eddbb2 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -302,7 +302,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			  struct lpfc_wcqe_complete *wcqe)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvmefc_tgt_ls_req *rsp;
+	struct nvmefc_ls_rsp *rsp;
 	struct lpfc_nvmet_rcv_ctx *ctxp;
 	uint32_t status, result;
 
@@ -335,7 +335,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	}
 
 out:
-	rsp = &ctxp->ctx.ls_req;
+	rsp = &ctxp->ctx.ls_rsp;
 
 	lpfc_nvmeio_data(phba, "NVMET LS  CMPL: xri x%x stat x%x result x%x\n",
 			 ctxp->oxid, status, result);
@@ -830,10 +830,10 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 static int
 lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
-		      struct nvmefc_tgt_ls_req *rsp)
+		      struct nvmefc_ls_rsp *rsp)
 {
 	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_req);
+		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_rsp);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct hbq_dmabuf *nvmebuf =
 		(struct hbq_dmabuf *)ctxp->rqb_buffer;
@@ -2000,7 +2000,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
 	 */
 	atomic_inc(&tgtp->rcv_ls_req_in);
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, &ctxp->ctx.ls_req,
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ctx.ls_rsp,
 				 payload, size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index b80b1639b9a7..f0196f3ef90d 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -105,7 +105,7 @@ struct lpfc_nvmet_ctx_info {
 
 struct lpfc_nvmet_rcv_ctx {
 	union {
-		struct nvmefc_tgt_ls_req ls_req;
+		struct nvmefc_ls_rsp ls_rsp;
 		struct nvmefc_tgt_fcp_req fcp_req;
 	} ctx;
 	struct list_head list;
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
