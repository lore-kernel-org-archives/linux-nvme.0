Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB5C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57262206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9sMeKEH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7AvFrRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57262206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KBLpcYPPjG7FiPkCVv48oE10vWRL9rfDjjz1QSYRbvc=; b=X9sMeKEHt9lAmThSnZ4QFJsojP
	kWw6Wax7PdcxWLqy5213przB5zLXE+IStDVBqXI8byvJY/RQfeGKumKZGnue3tUEN9PzzLFQavzin
	zabXJ97syk4bo01Od6Kse2BGjlMvNSw2x+73S5wFlg35hV8N/SfqxLq2F02xknLGNfpTEUgVJNMIF
	iZedBQanrMGwOYvl+onEsc68GqwXaTf8yyPKJhZguvycIgGBTL/+58mQlFgBLt0DKIh7fR2VWmXH4
	64U0J0Zp+iO93yMo9OOAtzTcUTX8aAk6dFyB4UsF/4hqoevIgK6UzsCKpRPkfQCBjznLFwob9lMbI
	q8Wa3CgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK6J-0004vI-6v; Tue, 31 Mar 2020 16:50:55 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5q-0004MB-9p
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:29 +0000
Received: by mail-wr1-x443.google.com with SMTP id h9so26880178wrc.8
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q6D60z+lzacMiwcC1pQ6aO/ePG1pPJv2xFc8HJCP8+k=;
 b=Y7AvFrRPyNPlflFraWmHpR0myGT/YGnr5Bhkm7RnYjmRYQRHmV/V9p/+yMTQxtAEZ7
 DNQWJcvTfPo8og4Oda2ChWOlVX8Ruwbox8oFFuARffhuE3CoPUnEukkxD9xNTYjX812r
 QY66TY6ex60Ak58L6mNujxqmtAJnw/JxjnReZVOOYWP/RSf1DpbEY2ssKKrZPBB8cFnO
 uzDWtTGeXfXbN7wQCD/iLVtu/ZABvjbTHv1j4P0SaE4PTp+bfrLTAuGoS+dUUeXmyqcS
 GOMJfHT8aCLHg9zJIz6PTm4FuOUYE2dc2jBFqlT18AOC5RjbCceEcbkO1Tx72PhQgFv4
 tTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q6D60z+lzacMiwcC1pQ6aO/ePG1pPJv2xFc8HJCP8+k=;
 b=cfJ3KjmW234QFHLRIZAxsq3SxV3iRPG+Ma3bYTV/w2ras+G2G8F2a1VsoGQD5CRubs
 N6HaH0I3Dcbj5Ted6R3OjO0GKPgf21dvVmhZSXTX7aYeZyckEZHJFbuhlrSxjc8OUBYg
 gA1v99Kzi3D6zomWvqUuGqtANyrXmNaH67NCPVZS1iebi+b59PdyFKFAXru3xWhRi+Du
 B7ZHJGDUhVUlKGodsGOLU/bcReSjBr43bwxvAHVLNzXVB0b87QC9u6KmuLE5s52YxcEs
 nOWDxaNudr1RkcLjPYGBigVLyHGhAHuwfb7xyBuY2U6iQQChqMpKfxesXtuzB8NguwMb
 YICg==
X-Gm-Message-State: ANhLgQ0YTcu8Zp16fatK0HDhkMbKHll5/wOL5HETW4sXDRUU0M+rSHx6
 E4J8cm/XNtNUNcfP9rCwmk33cI5/
X-Google-Smtp-Source: ADFU+vuQUl7izwpBDe92p+NmDae4W5v3ugpUPToEgLEHRjEvGuBmoTRyQ7T8ETafaFVIavfXNdYICw==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr22374424wrn.326.1585673424637; 
 Tue, 31 Mar 2020 09:50:24 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:23 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 03/26] nvme-fc nvmet-fc: refactor for common LS definitions
Date: Tue, 31 Mar 2020 09:49:48 -0700
Message-Id: <20200331165011.15819-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095026_429467_F9B5BA13 
X-CRM114-Status: GOOD (  15.03  )
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

Routines in the target will want to be used in the host as well.
Error definitions should now shared as both sides will process
requests and responses to requests.

Moved common declarations to new fc.h header kept in the host
subdirectory.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/fc.c   |  36 +------------
 drivers/nvme/host/fc.h   | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fc.c | 115 ++++------------------------------------
 3 files changed, 143 insertions(+), 141 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d6e8edddbbf0..bfbd1c2c1638 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -14,6 +14,7 @@
 #include "fabrics.h"
 #include <linux/nvme-fc-driver.h>
 #include <linux/nvme-fc.h>
+#include "fc.h"
 #include <scsi/scsi_transport_fc.h>
 
 /* *************************** Data Structures/Defines ****************** */
@@ -1141,41 +1142,6 @@ nvme_fc_send_ls_req_async(struct nvme_fc_rport *rport,
 	return __nvme_fc_send_ls_req(rport, lsop, done);
 }
 
-/* Validation Error indexes into the string table below */
-enum {
-	VERR_NO_ERROR		= 0,
-	VERR_LSACC		= 1,
-	VERR_LSDESC_RQST	= 2,
-	VERR_LSDESC_RQST_LEN	= 3,
-	VERR_ASSOC_ID		= 4,
-	VERR_ASSOC_ID_LEN	= 5,
-	VERR_CONN_ID		= 6,
-	VERR_CONN_ID_LEN	= 7,
-	VERR_CR_ASSOC		= 8,
-	VERR_CR_ASSOC_ACC_LEN	= 9,
-	VERR_CR_CONN		= 10,
-	VERR_CR_CONN_ACC_LEN	= 11,
-	VERR_DISCONN		= 12,
-	VERR_DISCONN_ACC_LEN	= 13,
-};
-
-static char *validation_errors[] = {
-	"OK",
-	"Not LS_ACC",
-	"Not LSDESC_RQST",
-	"Bad LSDESC_RQST Length",
-	"Not Association ID",
-	"Bad Association ID Length",
-	"Not Connection ID",
-	"Bad Connection ID Length",
-	"Not CR_ASSOC Rqst",
-	"Bad CR_ASSOC ACC Length",
-	"Not CR_CONN Rqst",
-	"Bad CR_CONN ACC Length",
-	"Not Disconnect Rqst",
-	"Bad Disconnect ACC Length",
-};
-
 static int
 nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	struct nvme_fc_queue *queue, u16 qsize, u16 ersp_ratio)
diff --git a/drivers/nvme/host/fc.h b/drivers/nvme/host/fc.h
new file mode 100644
index 000000000000..d2861cdd58ee
--- /dev/null
+++ b/drivers/nvme/host/fc.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016, Avago Technologies
+ */
+
+#ifndef _NVME_FC_TRANSPORT_H
+#define _NVME_FC_TRANSPORT_H 1
+
+
+/*
+ * Common definitions between the nvme_fc (host) transport and
+ * nvmet_fc (target) transport implementation.
+ */
+
+/*
+ * ******************  FC-NVME LS HANDLING ******************
+ */
+
+static inline void
+nvme_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
+{
+	struct fcnvme_ls_acc_hdr *acc = buf;
+
+	acc->w0.ls_cmd = ls_cmd;
+	acc->desc_list_len = desc_len;
+	acc->rqst.desc_tag = cpu_to_be32(FCNVME_LSDESC_RQST);
+	acc->rqst.desc_len =
+			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst));
+	acc->rqst.w0.ls_cmd = rqst_ls_cmd;
+}
+
+static inline int
+nvme_fc_format_rjt(void *buf, u16 buflen, u8 ls_cmd,
+			u8 reason, u8 explanation, u8 vendor)
+{
+	struct fcnvme_ls_rjt *rjt = buf;
+
+	nvme_fc_format_rsp_hdr(buf, FCNVME_LSDESC_RQST,
+			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_rjt)),
+			ls_cmd);
+	rjt->rjt.desc_tag = cpu_to_be32(FCNVME_LSDESC_RJT);
+	rjt->rjt.desc_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rjt));
+	rjt->rjt.reason_code = reason;
+	rjt->rjt.reason_explanation = explanation;
+	rjt->rjt.vendor = vendor;
+
+	return sizeof(struct fcnvme_ls_rjt);
+}
+
+/* Validation Error indexes into the string table below */
+enum {
+	VERR_NO_ERROR		= 0,
+	VERR_CR_ASSOC_LEN	= 1,
+	VERR_CR_ASSOC_RQST_LEN	= 2,
+	VERR_CR_ASSOC_CMD	= 3,
+	VERR_CR_ASSOC_CMD_LEN	= 4,
+	VERR_ERSP_RATIO		= 5,
+	VERR_ASSOC_ALLOC_FAIL	= 6,
+	VERR_QUEUE_ALLOC_FAIL	= 7,
+	VERR_CR_CONN_LEN	= 8,
+	VERR_CR_CONN_RQST_LEN	= 9,
+	VERR_ASSOC_ID		= 10,
+	VERR_ASSOC_ID_LEN	= 11,
+	VERR_NO_ASSOC		= 12,
+	VERR_CONN_ID		= 13,
+	VERR_CONN_ID_LEN	= 14,
+	VERR_INVAL_CONN		= 15,
+	VERR_CR_CONN_CMD	= 16,
+	VERR_CR_CONN_CMD_LEN	= 17,
+	VERR_DISCONN_LEN	= 18,
+	VERR_DISCONN_RQST_LEN	= 19,
+	VERR_DISCONN_CMD	= 20,
+	VERR_DISCONN_CMD_LEN	= 21,
+	VERR_DISCONN_SCOPE	= 22,
+	VERR_RS_LEN		= 23,
+	VERR_RS_RQST_LEN	= 24,
+	VERR_RS_CMD		= 25,
+	VERR_RS_CMD_LEN		= 26,
+	VERR_RS_RCTL		= 27,
+	VERR_RS_RO		= 28,
+	VERR_LSACC		= 29,
+	VERR_LSDESC_RQST	= 30,
+	VERR_LSDESC_RQST_LEN	= 31,
+	VERR_CR_ASSOC		= 32,
+	VERR_CR_ASSOC_ACC_LEN	= 33,
+	VERR_CR_CONN		= 34,
+	VERR_CR_CONN_ACC_LEN	= 35,
+	VERR_DISCONN		= 36,
+	VERR_DISCONN_ACC_LEN	= 37,
+};
+
+static char *validation_errors[] = {
+	"OK",
+	"Bad CR_ASSOC Length",
+	"Bad CR_ASSOC Rqst Length",
+	"Not CR_ASSOC Cmd",
+	"Bad CR_ASSOC Cmd Length",
+	"Bad Ersp Ratio",
+	"Association Allocation Failed",
+	"Queue Allocation Failed",
+	"Bad CR_CONN Length",
+	"Bad CR_CONN Rqst Length",
+	"Not Association ID",
+	"Bad Association ID Length",
+	"No Association",
+	"Not Connection ID",
+	"Bad Connection ID Length",
+	"Invalid Connection ID",
+	"Not CR_CONN Cmd",
+	"Bad CR_CONN Cmd Length",
+	"Bad DISCONN Length",
+	"Bad DISCONN Rqst Length",
+	"Not DISCONN Cmd",
+	"Bad DISCONN Cmd Length",
+	"Bad Disconnect Scope",
+	"Bad RS Length",
+	"Bad RS Rqst Length",
+	"Not RS Cmd",
+	"Bad RS Cmd Length",
+	"Bad RS R_CTL",
+	"Bad RS Relative Offset",
+	"Not LS_ACC",
+	"Not LSDESC_RQST",
+	"Bad LSDESC_RQST Length",
+	"Not CR_ASSOC Rqst",
+	"Bad CR_ASSOC ACC Length",
+	"Not CR_CONN Rqst",
+	"Bad CR_CONN ACC Length",
+	"Not Disconnect Rqst",
+	"Bad Disconnect ACC Length",
+};
+
+#endif /* _NVME_FC_TRANSPORT_H */
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index aac7869a70bb..1f3118a3b0a3 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -14,6 +14,7 @@
 #include "nvmet.h"
 #include <linux/nvme-fc-driver.h>
 #include <linux/nvme-fc.h>
+#include "../host/fc.h"
 
 
 /* *************************** Data Structures/Defines ****************** */
@@ -1257,102 +1258,6 @@ EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 /* *********************** FC-NVME LS Handling **************************** */
 
 
-static void
-nvmet_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
-{
-	struct fcnvme_ls_acc_hdr *acc = buf;
-
-	acc->w0.ls_cmd = ls_cmd;
-	acc->desc_list_len = desc_len;
-	acc->rqst.desc_tag = cpu_to_be32(FCNVME_LSDESC_RQST);
-	acc->rqst.desc_len =
-			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst));
-	acc->rqst.w0.ls_cmd = rqst_ls_cmd;
-}
-
-static int
-nvmet_fc_format_rjt(void *buf, u16 buflen, u8 ls_cmd,
-			u8 reason, u8 explanation, u8 vendor)
-{
-	struct fcnvme_ls_rjt *rjt = buf;
-
-	nvmet_fc_format_rsp_hdr(buf, FCNVME_LSDESC_RQST,
-			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_rjt)),
-			ls_cmd);
-	rjt->rjt.desc_tag = cpu_to_be32(FCNVME_LSDESC_RJT);
-	rjt->rjt.desc_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rjt));
-	rjt->rjt.reason_code = reason;
-	rjt->rjt.reason_explanation = explanation;
-	rjt->rjt.vendor = vendor;
-
-	return sizeof(struct fcnvme_ls_rjt);
-}
-
-/* Validation Error indexes into the string table below */
-enum {
-	VERR_NO_ERROR		= 0,
-	VERR_CR_ASSOC_LEN	= 1,
-	VERR_CR_ASSOC_RQST_LEN	= 2,
-	VERR_CR_ASSOC_CMD	= 3,
-	VERR_CR_ASSOC_CMD_LEN	= 4,
-	VERR_ERSP_RATIO		= 5,
-	VERR_ASSOC_ALLOC_FAIL	= 6,
-	VERR_QUEUE_ALLOC_FAIL	= 7,
-	VERR_CR_CONN_LEN	= 8,
-	VERR_CR_CONN_RQST_LEN	= 9,
-	VERR_ASSOC_ID		= 10,
-	VERR_ASSOC_ID_LEN	= 11,
-	VERR_NO_ASSOC		= 12,
-	VERR_CONN_ID		= 13,
-	VERR_CONN_ID_LEN	= 14,
-	VERR_NO_CONN		= 15,
-	VERR_CR_CONN_CMD	= 16,
-	VERR_CR_CONN_CMD_LEN	= 17,
-	VERR_DISCONN_LEN	= 18,
-	VERR_DISCONN_RQST_LEN	= 19,
-	VERR_DISCONN_CMD	= 20,
-	VERR_DISCONN_CMD_LEN	= 21,
-	VERR_DISCONN_SCOPE	= 22,
-	VERR_RS_LEN		= 23,
-	VERR_RS_RQST_LEN	= 24,
-	VERR_RS_CMD		= 25,
-	VERR_RS_CMD_LEN		= 26,
-	VERR_RS_RCTL		= 27,
-	VERR_RS_RO		= 28,
-};
-
-static char *validation_errors[] = {
-	"OK",
-	"Bad CR_ASSOC Length",
-	"Bad CR_ASSOC Rqst Length",
-	"Not CR_ASSOC Cmd",
-	"Bad CR_ASSOC Cmd Length",
-	"Bad Ersp Ratio",
-	"Association Allocation Failed",
-	"Queue Allocation Failed",
-	"Bad CR_CONN Length",
-	"Bad CR_CONN Rqst Length",
-	"Not Association ID",
-	"Bad Association ID Length",
-	"No Association",
-	"Not Connection ID",
-	"Bad Connection ID Length",
-	"No Connection",
-	"Not CR_CONN Cmd",
-	"Bad CR_CONN Cmd Length",
-	"Bad DISCONN Length",
-	"Bad DISCONN Rqst Length",
-	"Not DISCONN Cmd",
-	"Bad DISCONN Cmd Length",
-	"Bad Disconnect Scope",
-	"Bad RS Length",
-	"Bad RS Rqst Length",
-	"Not RS Cmd",
-	"Bad RS Cmd Length",
-	"Bad RS R_CTL",
-	"Bad RS Relative Offset",
-};
-
 static void
 nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
@@ -1407,7 +1312,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Association LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
@@ -1422,7 +1327,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 
 	iod->lsrsp->rsplen = sizeof(*acc);
 
-	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
+	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
 				sizeof(struct fcnvme_ls_cr_assoc_acc)),
 			FCNVME_LS_CREATE_ASSOCIATION);
@@ -1498,7 +1403,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Connection LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
@@ -1515,7 +1420,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 
 	iod->lsrsp->rsplen = sizeof(*acc);
 
-	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
+	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)),
 			FCNVME_LS_CREATE_CONNECTION);
 	acc->connectid.desc_tag = cpu_to_be32(FCNVME_LSDESC_CONN_ID);
@@ -1578,13 +1483,11 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Disconnect LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
-					(ret == VERR_NO_CONN) ?
-						FCNVME_RJT_RC_INV_CONN :
-						FCNVME_RJT_RC_LOGIC,
+					FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
 		return;
 	}
@@ -1593,7 +1496,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	iod->lsrsp->rsplen = sizeof(*acc);
 
-	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
+	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
 				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
 			FCNVME_LS_DISCONNECT_ASSOC);
@@ -1676,7 +1579,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_ls_disconnect(tgtport, iod);
 		break;
 	default:
-		iod->lsrsp->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
+		iod->lsrsp->rsplen = nvme_fc_format_rjt(iod->rspbuf,
 				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
 				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
