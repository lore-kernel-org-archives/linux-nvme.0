Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0423C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A72421655
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="revGba9x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anrp1tY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A72421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RsY5idhndVFbXpBOj++9CCSrHkISDxmoF5BZSVLmQzY=; b=revGba9xMFWahgnAswYzzcTx3b
	utdRgIkFjY/0MZcVsztFjrXV6injePqh18WtVwS8gonSQikr8dL2PBYcDX29TPQM6JDOQSQI0Vl4u
	WK0qP14OKOmjATEO2fH0sBRHK5wsv/qJbCBe0A1AAKuDMGxjEDWCh/STJbpW0tTNag+2SctJBxfRh
	j9axEz5McHNz7LZ0bUaJ1kFsyVuUeAvUbP7WfHCnbWTWP4Ag3hlpaB64eAUfqbDSkD7xsVqFjyCdQ
	gLnrxPjY1p/Ku16goFN2A9glG/J9M8YK2WeszehGC/oeIpyTaKdJeQ95usfIV26/p7jX2fRoucdQd
	PsBv9KJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDy9f-0000Yl-Oc; Fri, 27 Sep 2019 21:51:59 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDy9Z-0000TJ-O7
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:51:55 +0000
Received: by mail-pf1-x442.google.com with SMTP id y22so2291859pfr.3
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yqr7YGrMYcdc6ajZjiFRzX6+0rEJ6ir0L4HUECGbjyk=;
 b=Anrp1tY2jGrfBYavKJ5SgA80N4S9IsQ8Yq5FdJtKWoBC/OQO+kURV3Egw26hQfblKd
 oOvO4hoQSXTujGfK7A2jgQVj+rdvVQ1AcKJx1uZSc2gDKJiyApo48vZ94K0JUDbnz97Y
 vsRYiTy2Yf8IfNoiBD79R3ln6C/2BnmYQ6dymj2cj5nX9SexanMYD4rElEnfeX0+NJiT
 3QDHVRiRSAx39yZdh2rRHmmPJIodF6ICZbk4LbfIzuFzRIU45I4Ksz+pdkA/9xYxo9Yf
 tN9QpAYDs3JConF4OrtqI+ywmbB1ZHotLtawYs1soNzlPyREylsb9VmhCt+Lg3diRipK
 Tldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yqr7YGrMYcdc6ajZjiFRzX6+0rEJ6ir0L4HUECGbjyk=;
 b=dSz8TvszQfoj0EvVdDDblpB4meweM7V+6vz5myNXwrtMP1YXHVW0xD3uxsVj8WjrhR
 PwtcDdtnQMLDYRL/45bW+1YzfccB9feyBtIMgnx+BnzctJargwgEmt9As1H3CLFM2TYx
 LtBaXhWkJ+CRpHR7jvgoOw4G/YXwKI91kEoCncvZ8y3xd1piyb674siF2aXnaIdCTzk6
 4QxnaSRIOZ2bkOfCnxPDLaiLcCxRp+LfyxVvz5J/1a1vCez4TVoLeVdOIbUhdfuWow2+
 TFOcETD1ZGxAA/53kYIhK2TYB8/oIpGKcYc8XBk89uHeTTHpSTCN+8DJTDhFFsvBidc6
 EiFw==
X-Gm-Message-State: APjAAAW166oug1tHuo9pzh3aAiKxSU54lM6E1JOilZSe+6mkVW+SF6k7
 y/By3dSrpZ8V/7BdJDy/84Mo9xWv
X-Google-Smtp-Source: APXvYqxuzZZo7OWdGsi8bUYnhcGtuBlo8r6s6WrEiJ9iuihW0bXkXsX6PRW2sRw1CJLH55tj2xIxcA==
X-Received: by 2002:aa7:910c:: with SMTP id 12mr6863062pfh.166.1569621112948; 
 Fri, 27 Sep 2019 14:51:52 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g5sm3430507pfh.133.2019.09.27.14.51.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 27 Sep 2019 14:51:52 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme-fc: Sync nvme-fc header to FC-NVME-2
Date: Fri, 27 Sep 2019 14:51:34 -0700
Message-Id: <20190927215136.3096-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190927215136.3096-1-jsmart2021@gmail.com>
References: <20190927215136.3096-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_145153_790622_F505CA61 
X-CRM114-Status: GOOD (  16.31  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sync the header to FC-NVME-2 r1.06 (T11-2019-00210-v001).

Includes some minor mods where pre-release field names changed
by the time the spec was released.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 include/linux/nvme-fc.h | 182 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 137 insertions(+), 45 deletions(-)

diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
index 067c9fea64fe..e8c30b39bb27 100644
--- a/include/linux/nvme-fc.h
+++ b/include/linux/nvme-fc.h
@@ -4,33 +4,60 @@
  */
 
 /*
- * This file contains definitions relative to FC-NVME r1.14 (16-020vB).
- * The fcnvme_lsdesc_cr_assoc_cmd struct reflects expected r1.16 content.
+ * This file contains definitions relative to FC-NVME-2 r1.06
+ * (T11-2019-00210-v001).
  */
 
 #ifndef _NVME_FC_H
 #define _NVME_FC_H 1
 
+#include <uapi/scsi/fc/fc_fs.h>
 
-#define NVME_CMD_SCSI_ID		0xFD
+#define NVME_CMD_FORMAT_ID		0xFD
 #define NVME_CMD_FC_ID			FC_TYPE_NVME
 
 /* FC-NVME Cmd IU Flags */
-#define FCNVME_CMD_FLAGS_DIRMASK	0x03
-#define FCNVME_CMD_FLAGS_WRITE		0x01
-#define FCNVME_CMD_FLAGS_READ		0x02
+enum {
+	FCNVME_CMD_FLAGS_DIRMASK	= 0x03,
+	FCNVME_CMD_FLAGS_WRITE		= (1 << 0),
+	FCNVME_CMD_FLAGS_READ		= (1 << 1),
+
+	FCNVME_CMD_FLAGS_PICWP		= (1 << 2),
+};
+
+enum {
+	FCNVME_CMD_CAT_MASK		= 0x0F,
+	FCNVME_CMD_CAT_ADMINQ		= 0x01,
+	FCNVME_CMD_CAT_CSSMASK		= 0x07,
+	FCNVME_CMD_CAT_CSSFLAG		= 0x08,
+};
+
+static inline __u8 fccmnd_set_cat_admin(__u8 rsv_cat)
+{
+	return (rsv_cat & ~FCNVME_CMD_CAT_MASK) | FCNVME_CMD_CAT_ADMINQ;
+}
+
+static inline __u8 fccmnd_set_cat_css(__u8 rsv_cat, __u8 css)
+{
+	return (rsv_cat & ~FCNVME_CMD_CAT_MASK) | FCNVME_CMD_CAT_CSSFLAG |
+		(css & FCNVME_CMD_CAT_CSSMASK);
+}
 
 struct nvme_fc_cmd_iu {
-	__u8			scsi_id;
+	__u8			format_id;
 	__u8			fc_id;
 	__be16			iu_len;
-	__u8			rsvd4[3];
+	__u8			rsvd4[2];
+	__u8			rsv_cat;
 	__u8			flags;
 	__be64			connection_id;
 	__be32			csn;
 	__be32			data_len;
 	struct nvme_command	sqe;
-	__be32			rsvd88[2];
+	__u8			dps;
+	__u8			lbads;
+	__be16			ms;
+	__be32			rsvd92;
 };
 
 #define NVME_FC_SIZEOF_ZEROS_RSP	12
@@ -38,11 +65,12 @@ struct nvme_fc_cmd_iu {
 enum {
 	FCNVME_SC_SUCCESS		= 0,
 	FCNVME_SC_INVALID_FIELD		= 1,
-	FCNVME_SC_INVALID_CONNID	= 2,
+	/* reserved			  2 */
+	FCNVME_SC_ILL_CONN_PARAMS	= 3,
 };
 
 struct nvme_fc_ersp_iu {
-	__u8			status_code;
+	__u8			ersp_result;
 	__u8			rsvd1;
 	__be16			iu_len;
 	__be32			rsn;
@@ -53,14 +81,44 @@ struct nvme_fc_ersp_iu {
 };
 
 
-/* FC-NVME Link Services */
+#define FCNVME_NVME_SR_OPCODE	0x01
+
+struct nvme_fc_nvme_sr_iu {
+	__u8			fc_id;
+	__u8			opcode;
+	__u8			rsvd2;
+	__u8			retry_rctl;
+	__be32			rsvd4;
+};
+
+
+enum {
+	FCNVME_SRSTAT_ACC		= 0x0,
+	FCNVME_SRSTAT_INV_FCID		= 0x1,
+	/* reserved			  0x2 */
+	FCNVME_SRSTAT_LOGICAL_ERR	= 0x3,
+	FCNVME_SRSTAT_INV_QUALIF	= 0x4,
+	FCNVME_SRSTAT_UNABL2PERFORM	= 0x9,
+};
+
+struct nvme_fc_nvme_sr_rsp_iu {
+	__u8			fc_id;
+	__u8			opcode;
+	__u8			rsvd2;
+	__u8			status;
+	__be32			rsvd4;
+};
+
+
+/* FC-NVME Link Services - LS cmd values (w0 bits 31:24) */
 enum {
 	FCNVME_LS_RSVD			= 0,
 	FCNVME_LS_RJT			= 1,
 	FCNVME_LS_ACC			= 2,
-	FCNVME_LS_CREATE_ASSOCIATION	= 3,
-	FCNVME_LS_CREATE_CONNECTION	= 4,
-	FCNVME_LS_DISCONNECT		= 5,
+	FCNVME_LS_CREATE_ASSOCIATION	= 3,	/* Create Association */
+	FCNVME_LS_CREATE_CONNECTION	= 4,	/* Create I/O Connection */
+	FCNVME_LS_DISCONNECT_ASSOC	= 5,	/* Disconnect Association */
+	FCNVME_LS_DISCONNECT_CONN	= 6,	/* Disconnect Connection */
 };
 
 /* FC-NVME Link Service Descriptors */
@@ -117,14 +175,17 @@ enum fcnvme_ls_rjt_reason {
 	FCNVME_RJT_RC_UNSUP		= 0x0b,
 	/* command not supported */
 
-	FCNVME_RJT_RC_INPROG		= 0x0e,
-	/* command already in progress */
-
 	FCNVME_RJT_RC_INV_ASSOC		= 0x40,
-	/* Invalid Association ID*/
+	/* Invalid Association ID */
 
 	FCNVME_RJT_RC_INV_CONN		= 0x41,
-	/* Invalid Connection ID*/
+	/* Invalid Connection ID */
+
+	FCNVME_RJT_RC_INV_PARAM		= 0x42,
+	/* Invalid Parameters */
+
+	FCNVME_RJT_RC_INSUF_RES		= 0x43,
+	/* Insufficient Resources */
 
 	FCNVME_RJT_RC_VENDOR		= 0xff,
 	/* vendor specific error */
@@ -138,14 +199,32 @@ enum fcnvme_ls_rjt_explan {
 	FCNVME_RJT_EXP_OXID_RXID	= 0x17,
 	/* invalid OX_ID-RX_ID combination */
 
-	FCNVME_RJT_EXP_INSUF_RES	= 0x29,
-	/* insufficient resources */
-
 	FCNVME_RJT_EXP_UNAB_DATA	= 0x2a,
 	/* unable to supply requested data */
 
 	FCNVME_RJT_EXP_INV_LEN		= 0x2d,
 	/* Invalid payload length */
+
+	FCNVME_RJT_EXP_INV_ERSP_RAT	= 0x40,
+	/* Invalid NVMe_ERSP Ratio */
+
+	FCNVME_RJT_EXP_INV_CTLR_ID	= 0x41,
+	/* Invalid Controller ID */
+
+	FCNVME_RJT_EXP_INV_QUEUE_ID	= 0x42,
+	/* Invalid Queue ID */
+
+	FCNVME_RJT_EXP_INV_SQSIZE	= 0x43,
+	/* Invalid Submission Queue Size */
+
+	FCNVME_RJT_EXP_INV_HOSTID	= 0x44,
+	/* Invalid HOST ID */
+
+	FCNVME_RJT_EXP_INV_HOSTNQN	= 0x45,
+	/* Invalid HOSTNQN */
+
+	FCNVME_RJT_EXP_INV_SUBNQN	= 0x46,
+	/* Invalid SUBNQN */
 };
 
 /* FCNVME_LSDESC_RJT */
@@ -209,21 +288,11 @@ struct fcnvme_lsdesc_cr_conn_cmd {
 	__be32  rsvd52;
 };
 
-/* Disconnect Scope Values */
-enum {
-	FCNVME_DISCONN_ASSOCIATION	= 0,
-	FCNVME_DISCONN_CONNECTION	= 1,
-};
-
 /* FCNVME_LSDESC_DISCONN_CMD */
 struct fcnvme_lsdesc_disconn_cmd {
 	__be32	desc_tag;		/* FCNVME_LSDESC_xxx */
 	__be32	desc_len;
-	u8	rsvd8[3];
-	/* note: scope is really a 1 bit field */
-	u8	scope;			/* FCNVME_DISCONN_xxx */
-	__be32	rsvd12;
-	__be64	id;
+	__be32	rsvd8[4];
 };
 
 /* FCNVME_LSDESC_CONN_ID */
@@ -242,9 +311,14 @@ struct fcnvme_lsdesc_assoc_id {
 
 /* r_ctl values */
 enum {
-	FCNVME_RS_RCTL_DATA		= 1,
-	FCNVME_RS_RCTL_XFER_RDY		= 5,
-	FCNVME_RS_RCTL_RSP		= 8,
+	FCNVME_RS_RCTL_CMND		= 0x6,
+	FCNVME_RS_RCTL_DATA		= 0x1,
+	FCNVME_RS_RCTL_CONF		= 0x3,
+	FCNVME_RS_RCTL_SR		= 0x9,
+	FCNVME_RS_RCTL_XFER_RDY		= 0x5,
+	FCNVME_RS_RCTL_RSP		= 0x7,
+	FCNVME_RS_RCTL_ERSP		= 0x8,
+	FCNVME_RS_RCTL_SR_RSP		= 0xA,
 };
 
 
@@ -264,7 +338,10 @@ struct fcnvme_ls_acc_hdr {
 	struct fcnvme_ls_rqst_w0		w0;
 	__be32					desc_list_len;
 	struct fcnvme_lsdesc_rqst		rqst;
-	/* Followed by cmd-specific ACC descriptors, see next definitions */
+	/*
+	 * Followed by cmd-specific ACCEPT descriptors, see xxx_acc
+	 * definitions below
+	 */
 };
 
 /* FCNVME_LS_CREATE_ASSOCIATION */
@@ -302,25 +379,39 @@ struct fcnvme_ls_cr_conn_acc {
 	struct fcnvme_lsdesc_conn_id		connectid;
 };
 
-/* FCNVME_LS_DISCONNECT */
-struct fcnvme_ls_disconnect_rqst {
+/* FCNVME_LS_DISCONNECT_ASSOC */
+struct fcnvme_ls_disconnect_assoc_rqst {
 	struct fcnvme_ls_rqst_w0		w0;
 	__be32					desc_list_len;
 	struct fcnvme_lsdesc_assoc_id		associd;
 	struct fcnvme_lsdesc_disconn_cmd	discon_cmd;
 };
 
-struct fcnvme_ls_disconnect_acc {
+struct fcnvme_ls_disconnect_assoc_acc {
+	struct fcnvme_ls_acc_hdr		hdr;
+};
+
+
+/* FCNVME_LS_DISCONNECT_CONN */
+struct fcnvme_ls_disconnect_conn_rqst {
+	struct fcnvme_ls_rqst_w0		w0;
+	__be32					desc_list_len;
+	struct fcnvme_lsdesc_assoc_id		associd;
+	struct fcnvme_lsdesc_disconn_cmd	connectid;
+};
+
+struct fcnvme_ls_disconnect_conn_acc {
 	struct fcnvme_ls_acc_hdr		hdr;
 };
 
 
 /*
- * Yet to be defined in FC-NVME:
+ * Default R_A_TOV is pulled in from fc_fs.h but needs conversion
+ * from ms to seconds for our use.
  */
-#define NVME_FC_CONNECT_TIMEOUT_SEC	2		/* 2 seconds */
-#define NVME_FC_LS_TIMEOUT_SEC		2		/* 2 seconds */
-#define NVME_FC_TGTOP_TIMEOUT_SEC	2		/* 2 seconds */
+#define FC_TWO_TIMES_R_A_TOV		(2 * (FC_DEF_R_A_TOV / 1000))
+#define NVME_FC_LS_TIMEOUT_SEC		FC_TWO_TIMES_R_A_TOV
+#define NVME_FC_TGTOP_TIMEOUT_SEC	FC_TWO_TIMES_R_A_TOV
 
 /*
  * TRADDR string must be of form "nn-<16hexdigits>:pn-<16hexdigits>"
@@ -328,6 +419,7 @@ struct fcnvme_ls_disconnect_acc {
  * infront of the <16hexdigits>.  Without is considered the "min" string
  * and with is considered the "max" string. The hexdigits may be upper
  * or lower case.
+ * Note: FC-NVME-2 standard requires a "0x" prefix.
  */
 #define NVME_FC_TRADDR_NNLEN		3	/* "?n-" */
 #define NVME_FC_TRADDR_OXNNLEN		5	/* "?n-0x" */
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
