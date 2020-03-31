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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5065C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B0420784
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UDAjX+pT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0LZiufy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0420784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=S4SdyDtGyGjsZ+UFgKomnTzzOpiMuBxoOljexcOhHLI=; b=UDAjX+pT0MjPKnVimPvOuq3hJ8
	pSGVMaVFm2xLXTswW+uyF5qXz05Wi/7FzD6g17ar4Bl/IskliPILf6pmQrAHlUkra0lhych4M2QUz
	TsAw3z2CQ/DC+yr346r5AZQM7JHvFHTZqy1gyAoP08krltoSOrFyfI7cZDOCSxyRCI7tYbRN7fAtJ
	pfgoiXeQgzN/jgq5Elty/eI42Kj9s6ZiKRsLSgk+aipw6ihYK/Jl/tfXEHl1DwWBIF0/cTEqDqL5E
	YshRtFRuujj0jCa0tInJHoMWQ+6uPew65AIBqYXtE+YaSzatZH5pVGEKvL8vV9M/1JP4M5UgIzI7I
	hxvO4cwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK7q-0005uY-S0; Tue, 31 Mar 2020 16:52:30 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5w-0004bg-Nt
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id w10so26983740wrm.4
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ocmknJ2bEso2hZDUBFXtwKXzDGu7Kw5Y/vQqgXM2Ae8=;
 b=u0LZiufyJvUa/G5zLDxWfRbbByNzjgXnuAXdHMbJAfDEpEqQwNwqE70aq6kpI+cshM
 KrqFa79HarCMclYCSwog5ovdiqm7gpnxe3d2nM08We07GUN2V90IzKcTTcV/gm6fNxXS
 g2PUqQtJbnOZHPxbsG2qPngiX0GKD5EPWLcUCQixmaXHr6ZZZ/vZTNh+iUlx/924rZEa
 AXSpOUvJ4QpZ2/MbrRMapFFmk+TXiEs3JJLPVOqemUStXaSjEVtRMQM+wBa2ZnltrFwR
 Ab0+jZhEF5iTv4sjjDtFhO5Xkfy8dwFxLOjMVhIB3BDwFwTYSomx4jagUxUhPKmcUwDS
 d4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ocmknJ2bEso2hZDUBFXtwKXzDGu7Kw5Y/vQqgXM2Ae8=;
 b=ZTGY6OXCHNhQmJhaxuTkZ2T8375ExbO/GC9wDJTZe5mFL8Jm6qDTEhDUSTBBR6Llj5
 ZAjajwZXJKW+LKJstnopuKLsUiIklWIZVd5bbTI46ff3cYJxJUnYw0wkjYtB0WN2Qzf9
 QOo7s3GcQFWiIDI6F1JIVTXWDhyzdA+5mIhvyM3TJAJ83ELOkTgCDXH0opbfLnhWZnLI
 h700nhdLdi4opczLoNg2ftq+YLY05w2cO6Te814K3bFk5BoUQ7m1nDgMV8zKDWhWCuMP
 DMhA5Xt22rEjVyRhCbALN8pvEV182UyLXxie7IZ1PKn3nsDSnBR2vJHa7pJZ2UhFLWft
 e/WA==
X-Gm-Message-State: ANhLgQ23Y9DJ6hRoDJkogyqDXne0bw6jn6hXxBvi7OqnUwu90bHooXHP
 xVii6ccl6wFuRpAb0t2mP9ozGf5b
X-Google-Smtp-Source: ADFU+vsMWam7Py2iuB/osxFKdN6fwc7VsPb1F9X4Udm/lAsGlDr6D18ao3QQEBYiFvgAYy+yVpmS1g==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr22277728wrb.188.1585673431049; 
 Tue, 31 Mar 2020 09:50:31 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:30 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 07/26] nvme-fc: Update header and host for common
 definitions for LS handling
Date: Tue, 31 Mar 2020 09:49:52 -0700
Message-Id: <20200331165011.15819-8-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095032_872470_A6007E00 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: James Smart <jsmart2021@gmail.com>
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

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

---
v2:
  Split original patch into two patches: a host-side patch (with header
  update) and a target-side patch.
---
 drivers/nvme/host/fc.c | 25 ++--------------
 drivers/nvme/host/fc.h | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ca9efed2b560..f61a4e733e0d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1420,29 +1420,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
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
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
