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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA2C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:40:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0B220674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ovCdA1I5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8TTUjc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0B220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KzvGViLxmABA7LyVbZCi1fVTL2kDE3iDIwNooWqKUkw=; b=ovCdA1I5PMvw08l7rNUubtd2+m
	zmk7e0V7b04tNr0kC3rMH4AxGObaVGVQJ1jfhupVf3ilLUg5ROfIFqGKlqqoBH0uTgZjRN1zTX9Dg
	1UBJXIfCLc93Xdh+oCEyMX7y0rPisau/aYdikdXcCnZHb9flej4EOxiiBta1tZ0egS21Uiwi8dkmZ
	y4UhZHxLY8XwYqP+sVnmhFNh497X0BryBNPDsrdqDC5p0eR9P6WVzM4q1DWEjNAHAVHoS0ZlZuGdN
	gK7G2kyg9IjAw2o9gZrkS3NiZbSKJ+UEwEX7b0jwyZgsmLkFEwR3gUcxLPEqW8cj5J+yiIaodZ552
	nbpBYVsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPaz-0006Dd-AD; Wed, 05 Feb 2020 18:40:17 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZ0-0003Xt-Ob
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id k11so3999750wrd.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wtHDzciUkhd6HAKXsJdAuiTheobLfkRN7j+mVvBP0xI=;
 b=s8TTUjc2V74DYb8KwYbcns9ZGHPfyIrmrzaJAl3vB62b/Knloi5SDue+yc1jl+cHnz
 dDwHQIG5S919ZbYjWnXh9zKeDzmI0hAXMUa07RQ57jqn+3wmmnZXgB5K0DmASZXiSWTx
 IOyi8olThtb27EnlkmUzAxUYuPyTsxyCk9ua8K9vFUzp3QV9Y3SFUkQZSC0oNiJ2ElUa
 OK3EWlZTEU0SZbl2IpxZmC7gCyPni9vcTlKtR+2f+GpurhFuvyFv7hxCEgytdBgxxcKL
 F9d4Ty/USmW2kkDktX26L/4jX5h18IXoa8MPI8mgo8Mjqf+GpsrNEwkarQ7hWCta3Fbb
 mzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wtHDzciUkhd6HAKXsJdAuiTheobLfkRN7j+mVvBP0xI=;
 b=L3os8bzVHxFN4LLOoaTIDeTRBHYmEE4wtz74gKh3N0BgPCepb3/hxpWuLGFa55Zbb1
 LnXvxpu39b5cy0kHIWHYoPp9+xN/SWRrb0VYBnKapSBMzQgFMfuYL/llOnZ8YN2pXQZ4
 DtqCpo0ShXuxvtDKK0POJa6/THzMWJVWq7myibMQa+xxxgwS8kFI6CRyWHioQGZYzGYU
 HfUcneklrYi3Tu7oW95yWturZzTOWPYu+jv9KtbWp2np2AJ3y2GSpvxWQDjywBNG5Ryj
 0Be5G36eqMqw8tU/+hgslWI1Ox+oMCF/5ixfxmUIwyIcYI76giuu/FLz7RD8l0G0TjWU
 xDug==
X-Gm-Message-State: APjAAAXuMvA79iJ9jxdLnpFIprkCTn5a5IshuULNRkwbV20gu0kPRjbZ
 Ku3ysgk3J1DmxhjZ7LTIETO6zuEM
X-Google-Smtp-Source: APXvYqymJoRl8KxxqKIFGgc+OsinUN9XC+vDQJT4O+EDgbwPsMkIQ0Wm57VcGM1XkdRbdSU0rpIDDw==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr30615402wrp.2.1580927892927; 
 Wed, 05 Feb 2020 10:38:12 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:12 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 07/29] nvme-fc nvmet-fc: refactor for common LS definitions
Date: Wed,  5 Feb 2020 10:37:31 -0800
Message-Id: <20200205183753.25959-8-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103814_846426_3918D770 
X-CRM114-Status: GOOD (  14.72  )
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

Routines in the target will want to be used in the host as well.
Error definitions should now shared as both sides will process
requests and responses to requests.

Moved common declarations to new fc.h header kept in the host
subdirectory.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c   |  36 +------------
 drivers/nvme/host/fc.h   | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fc.c | 115 ++++------------------------------------
 3 files changed, 143 insertions(+), 141 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f8f79cd88769..2e5163600f63 100644
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
@@ -1258,102 +1259,6 @@ EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
 
 static void
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
-static void
 nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
