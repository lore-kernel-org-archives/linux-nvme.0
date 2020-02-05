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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E0C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E154F20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1o9Un2I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqNbH1Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=c9jF2iYoKsoOFaX7hSIN3MnqmfM9p9qVe0YOHD2NkB4=; b=d1o9Un2I1LTUgi4LxEe4iEGl2X
	lgJHKxzc8gRL91AQKt3G1YrEUL1doCWit5yCKNUadcvdehPBMeeWvhDfMVxAH7Z4C/WuE0UfLB1tg
	g1ITFQI8YMuz4j/xYdFFMPkLKJsN8OREdUfpqpkyU8pBOU3jZFa2znMIVVAdAgM/iTV4nGBAMO6dw
	jdWrA8xKu1LdL3WepTlfFeG3Ax2LQRpX2Yt0LBf7ytyM2H06remze0VYCDFxnqCxGg5p8TlOaM/5k
	4V4ih0HBsldu06wS/MOl5YOvjTr0s8tszUj4Gu+yKTQ6xAczDtBeInwSYrK5HZGqCmj4I0w6+D/bR
	dNu0r7DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPbl-00072w-51; Wed, 05 Feb 2020 18:41:05 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZ5-0003dD-ED
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:22 +0000
Received: by mail-wr1-x441.google.com with SMTP id z7so3977162wrl.13
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WzhkbKQ6GuhbX+Gqyvm7L40PZZYbQJq/F6qRqkbvG3E=;
 b=NqNbH1Wzej+dFsRu9ISqo86LacCOWRZQzCDYQWn71CjhydP4amHMv8K7jJJY3OxhnR
 b4d++PGynTejuqRz2u1YnbzbKLFfhYdNJwRQYdr6/Zd5D+B9Oq3vG66iNKfMPUQ5Y+dE
 6Xv7jiTm/qT+UvMTk7023XS1J6s+Nw4UCl/flPu4vIc73humsq6GY47r4veJXss08GlG
 mYkZdaK8Wcs6RPXeiRCo18zy+/OGYDdyd8zuZMZNxUPv0CqEE11lxP1eXqTuCmK9QaUM
 0BVmjGNzPjLTkayYHnRneFigMgzhg0GKSQZpJSlzIAv1mvF9l714gc2pYIbMEV2HjW7h
 K7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WzhkbKQ6GuhbX+Gqyvm7L40PZZYbQJq/F6qRqkbvG3E=;
 b=lAJtsE1RN48AJ+a0eE4CgxoUdYljmgDrqM/EEMfOEOAZtCnX6ebWPKvw2aLn5wgGHS
 x9e8sXyOHXECusO7sgyrsRT16YY1MCxprKurHUPqsXez4jelEWNr/BK5uPr7MLnx0luy
 4cIYqYHcF4NMYTLPPi4HP6cjiRSgeD9FBgORQfyH/qV1CWHm1KBBur4NXeKFvCxx/Tij
 1To8q7Cs+RiKKbMuA/Ui4EidNXhmNZkuI7DVO977nztsyUSzsA/9fiH1ulQy+xb114kr
 7bnncUrmqwxbGF5/fDNjAtFF+gATsb5mNarAoZ+G3ukDYusZOn/kw1AAYYqLWVPmYoys
 Cx/A==
X-Gm-Message-State: APjAAAWdyJOm0Aq3QCR9DxUcz52vkyVz8bLKPNYI88+jJtrVfukcqFVV
 CsYLxoKaPzBMihTG39nxcr48KbiP
X-Google-Smtp-Source: APXvYqzMEZybLDwhX/7zT0fmL+h5Ancd99+Kbi70okR//fCS0ttbFiwFk5+WOvqOrxbGVo1uLvfj6Q==
X-Received: by 2002:adf:f182:: with SMTP id h2mr29247288wro.364.1580927897532; 
 Wed, 05 Feb 2020 10:38:17 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:17 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 10/29] nvmefc: Use common definitions for LS names, formatting,
 and validation
Date: Wed,  5 Feb 2020 10:37:34 -0800
Message-Id: <20200205183753.25959-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103819_491463_E680CA4F 
X-CRM114-Status: GOOD (  15.97  )
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

Given that both host and target now generate and receive LS's create
a single table definition for LS names. Each tranport half will have
a local version of the table.

As Create Association LS is issued by both sides, and received by
both sides, create common routines to format the LS and to validate
the LS.

Convert the host side transport to use the new common Create
Association LS formatting routine.

Convert the target side transport to use the new common Create
Association LS validation routine.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c   | 25 ++-------------
 drivers/nvme/host/fc.h   | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fc.c | 28 ++---------------
 3 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1a58e3dc0399..8fed69504c38 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1421,29 +1421,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 	else
 		lsreq->private = NULL;
 
-	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
-	discon_rqst->desc_list_len = cpu_to_be32(
-				sizeof(struct fcnvme_lsdesc_assoc_id) +
-				sizeof(struct fcnvme_lsdesc_disconn_cmd));
-
-	discon_rqst->associd.desc_tag = cpu_to_be32(FCNVME_LSDESC_ASSOC_ID);
-	discon_rqst->associd.desc_len =
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_lsdesc_assoc_id));
-
-	discon_rqst->associd.association_id = cpu_to_be64(ctrl->association_id);
-
-	discon_rqst->discon_cmd.desc_tag = cpu_to_be32(
-						FCNVME_LSDESC_DISCONN_CMD);
-	discon_rqst->discon_cmd.desc_len =
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_lsdesc_disconn_cmd));
-
-	lsreq->rqstaddr = discon_rqst;
-	lsreq->rqstlen = sizeof(*discon_rqst);
-	lsreq->rspaddr = discon_acc;
-	lsreq->rsplen = sizeof(*discon_acc);
-	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
+	nvmefc_fmt_lsreq_discon_assoc(lsreq, discon_rqst, discon_acc,
+				ctrl->association_id);
 
 	ret = nvme_fc_send_ls_req_async(ctrl->rport, lsop,
 				nvme_fc_disconnect_assoc_done);
diff --git a/drivers/nvme/host/fc.h b/drivers/nvme/host/fc.h
index 08fa88381d45..05ce566f2caf 100644
--- a/drivers/nvme/host/fc.h
+++ b/drivers/nvme/host/fc.h
@@ -17,6 +17,7 @@
  */
 
 union nvmefc_ls_requests {
+	struct fcnvme_ls_rqst_w0		w0;
 	struct fcnvme_ls_cr_assoc_rqst		rq_cr_assoc;
 	struct fcnvme_ls_cr_conn_rqst		rq_cr_conn;
 	struct fcnvme_ls_disconnect_assoc_rqst	rq_dis_assoc;
@@ -145,4 +146,82 @@ static char *validation_errors[] = {
 	"Bad Disconnect ACC Length",
 };
 
+#define NVME_FC_LAST_LS_CMD_VALUE	FCNVME_LS_DISCONNECT_CONN
+
+static char *nvmefc_ls_names[] = {
+	"Reserved (0)",
+	"RJT (1)",
+	"ACC (2)",
+	"Create Association",
+	"Create Connection",
+	"Disconnect Association",
+	"Disconnect Connection",
+};
+
+static inline void
+nvmefc_fmt_lsreq_discon_assoc(struct nvmefc_ls_req *lsreq,
+	struct fcnvme_ls_disconnect_assoc_rqst *discon_rqst,
+	struct fcnvme_ls_disconnect_assoc_acc *discon_acc,
+	u64 association_id)
+{
+	lsreq->rqstaddr = discon_rqst;
+	lsreq->rqstlen = sizeof(*discon_rqst);
+	lsreq->rspaddr = discon_acc;
+	lsreq->rsplen = sizeof(*discon_acc);
+	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
+
+	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
+	discon_rqst->desc_list_len = cpu_to_be32(
+				sizeof(struct fcnvme_lsdesc_assoc_id) +
+				sizeof(struct fcnvme_lsdesc_disconn_cmd));
+
+	discon_rqst->associd.desc_tag = cpu_to_be32(FCNVME_LSDESC_ASSOC_ID);
+	discon_rqst->associd.desc_len =
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_lsdesc_assoc_id));
+
+	discon_rqst->associd.association_id = cpu_to_be64(association_id);
+
+	discon_rqst->discon_cmd.desc_tag = cpu_to_be32(
+						FCNVME_LSDESC_DISCONN_CMD);
+	discon_rqst->discon_cmd.desc_len =
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_lsdesc_disconn_cmd));
+}
+
+static inline int
+nvmefc_vldt_lsreq_discon_assoc(u32 rqstlen,
+	struct fcnvme_ls_disconnect_assoc_rqst *rqst)
+{
+	int ret = 0;
+
+	if (rqstlen < sizeof(struct fcnvme_ls_disconnect_assoc_rqst))
+		ret = VERR_DISCONN_LEN;
+	else if (rqst->desc_list_len !=
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_ls_disconnect_assoc_rqst)))
+		ret = VERR_DISCONN_RQST_LEN;
+	else if (rqst->associd.desc_tag != cpu_to_be32(FCNVME_LSDESC_ASSOC_ID))
+		ret = VERR_ASSOC_ID;
+	else if (rqst->associd.desc_len !=
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_lsdesc_assoc_id)))
+		ret = VERR_ASSOC_ID_LEN;
+	else if (rqst->discon_cmd.desc_tag !=
+			cpu_to_be32(FCNVME_LSDESC_DISCONN_CMD))
+		ret = VERR_DISCONN_CMD;
+	else if (rqst->discon_cmd.desc_len !=
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_lsdesc_disconn_cmd)))
+		ret = VERR_DISCONN_CMD_LEN;
+	/*
+	 * As the standard changed on the LS, check if old format and scope
+	 * something other than Association (e.g. 0).
+	 */
+	else if (rqst->discon_cmd.rsvd8[0])
+		ret = VERR_DISCONN_SCOPE;
+
+	return ret;
+}
+
 #endif /* _NVME_FC_TRANSPORT_H */
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 66a60a218994..5739df7edc59 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1442,32 +1442,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	memset(acc, 0, sizeof(*acc));
 
-	if (iod->rqstdatalen < sizeof(struct fcnvme_ls_disconnect_assoc_rqst))
-		ret = VERR_DISCONN_LEN;
-	else if (rqst->desc_list_len !=
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_ls_disconnect_assoc_rqst)))
-		ret = VERR_DISCONN_RQST_LEN;
-	else if (rqst->associd.desc_tag != cpu_to_be32(FCNVME_LSDESC_ASSOC_ID))
-		ret = VERR_ASSOC_ID;
-	else if (rqst->associd.desc_len !=
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_lsdesc_assoc_id)))
-		ret = VERR_ASSOC_ID_LEN;
-	else if (rqst->discon_cmd.desc_tag !=
-			cpu_to_be32(FCNVME_LSDESC_DISCONN_CMD))
-		ret = VERR_DISCONN_CMD;
-	else if (rqst->discon_cmd.desc_len !=
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_lsdesc_disconn_cmd)))
-		ret = VERR_DISCONN_CMD_LEN;
-	/*
-	 * As the standard changed on the LS, check if old format and scope
-	 * something other than Association (e.g. 0).
-	 */
-	else if (rqst->discon_cmd.rsvd8[0])
-		ret = VERR_DISCONN_SCOPE;
-	else {
+	ret = nvmefc_vldt_lsreq_discon_assoc(iod->rqstdatalen, rqst);
+	if (!ret) {
 		/* match an active association */
 		assoc = nvmet_fc_find_target_assoc(tgtport,
 				be64_to_cpu(rqst->associd.association_id));
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
