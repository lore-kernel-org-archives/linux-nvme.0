Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB81C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:37:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD22222C3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QJhknqk3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUWDcepv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD22222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S7fUKN3Xt70Z96782uTS2cGOC3NqBlZcMxytyq0TDrg=; b=QJhknqk3CVhyLnWFNr4c7c5L6
	Ns8Ye/olnF2xui3Do90ZF1JxG7Zc6x4ts+tVXegTSP8c3Yf07hU+VUBa9rXpe7q6Y97dT0O87Zp9m
	56eMjNkonEwNXoGGZ7be8NQijek1mcQO7/VcoaFsDVCTpQrcj0G1gfGP7p0tXFT0lQUo5OmCN3wOm
	klsEftQf6PEKTjlXHTwMw+BJptr6h2s6a089EW4/Up4ZOBJ3DsBx25YJ7vR0feVOausaQt5g6RC9o
	CaV1rMy9Jipqbxt8sfbTD7dGUjwVjCzLMyWMW8+P6hOeHk31pdZanKXLR+TXOAEqiTAxByxgloBhZ
	pUqRZqSOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWHd-0001pi-3O; Mon, 19 Oct 2020 14:37:09 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWHY-0001nc-Kl
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:37:07 +0000
Received: by mail-pf1-x444.google.com with SMTP id e7so46932pfn.12
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z/5lGblnspg2oBd2pugDI4UQNSuWO3yUl64UAvRjtws=;
 b=WUWDcepvUurEpLxlTlIjPj2UOqNAId7qTXeMPNjLiSvSGc074OscnOpVagRjLDCDyV
 iOhIdZ/41qx5qVywyYsHUFQ3wowjVkKp7eGB8u2JuBDtZvSvwMrdjRTAjwFJSA9jvlGt
 K6A8rqGWkf1vhVEEmcLOwEXUb3SuYigmiQTsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z/5lGblnspg2oBd2pugDI4UQNSuWO3yUl64UAvRjtws=;
 b=Q/Cz4do1g/PhSPJ6jeQh1BKZYlZgULQZ2NO0hkSuMBnvYYmg2I+xSm84uh/TgBv3yu
 5EKaB7ySKQ7ZUinEULHBLvnSJ26vA6HGWRln2TR57D99v4Vq3lgr6Jdbi6BfUziDZ5Gd
 vrwCEL1GC7kZEyRvN6MW/jN0nV6E8RzzPyTf7EsNDatwhb18YTKGKVxhYEm35yIwA2Is
 T3av4ql9N2uaNNs0IN88Wn369rOO4bsOMgXSpwZq87hJ+CNRvrYqFNijP9DoRMAr5TLC
 2EEviGBULs2/+Z31mSW1NvoWhLtexQ7MzyMAkoYGuSDRr9ZpzXbCw99YmJrZAfDXkTlD
 AFRw==
X-Gm-Message-State: AOAM530TtJP++PHQQs0vlZhwCW6gdIql5i2cMZhXRpO6knComPvHiJa7
 YuNhMC0kvJjEhG2haF89JGjKQg7mjfKd0yN/
X-Google-Smtp-Source: ABdhPJyiojPgDPnCl+suNWYafBMayFW3kP1b9eRupWXx7pss5TxhGOYeCnYFF1zPGICBe4yVk1wFVA==
X-Received: by 2002:a63:3d88:: with SMTP id k130mr6617pga.30.1603118222416;
 Mon, 19 Oct 2020 07:37:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id kb15sm53377pjb.17.2020.10.19.07.36.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 07:37:01 -0700 (PDT)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [RFC v2 06/18] lpfc: vmid: Supplementary data structures for vmid
Date: Mon, 19 Oct 2020 13:13:01 +0530
Message-Id: <1603093393-12875-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_103704_746673_85F81053 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277611280774178488=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============8277611280774178488==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003479a405b2070c7e"

--0000000000003479a405b2070c7e

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds additional data structures for supporting the two
versions of vmid implementation. First type uses app header while the
other types uses priority tagging mechanism. These data structures
are used mostly for ELS and CT commands for the two vmid implementation.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_disc.h |   1 +
 drivers/scsi/lpfc/lpfc_hw.h   | 124 ++++++++++++++++++++++++++++++++--
 drivers/scsi/lpfc/lpfc_sli.h  |   8 +++
 3 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index 482e4a888dae..c38313ee17dd 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -113,6 +113,7 @@ struct lpfc_nodelist {
 	uint8_t         nlp_fcp_info;	        /* class info, bits 0-3 */
 #define NLP_FCP_2_DEVICE   0x10			/* FCP-2 device */
 	u8		nlp_nvme_info;	        /* NVME NSLER Support */
+	u8		vmid_support;		/* destination VMID support */
 #define NLP_NVME_NSLER     0x1			/* NVME NSLER device */
 
 	uint16_t        nlp_usg_map;	/* ndlp management usage bitmap */
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index c20034b3101c..c6b252fbea40 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -275,6 +275,7 @@ struct lpfc_sli_ct_request {
 #define  SLI_CT_ACCESS_DENIED             0x10
 #define  SLI_CT_INVALID_PORT_ID           0x11
 #define  SLI_CT_DATABASE_EMPTY            0x12
+#define  SLI_CT_APP_ID_NOT_AVAILABLE      0x40
 
 /*
  * Name Server Command Codes
@@ -400,16 +401,16 @@ struct csp {
 	uint16_t altBbCredit:1;	/* FC Word 1, bit 27 */
 	uint16_t edtovResolution:1;	/* FC Word 1, bit 26 */
 	uint16_t multicast:1;	/* FC Word 1, bit 25 */
-	uint16_t broadcast:1;	/* FC Word 1, bit 24 */
+	u16 app_hdr_support:1;	/* FC Word 1, bit 24 */
 
-	uint16_t huntgroup:1;	/* FC Word 1, bit 23 */
+	uint16_t priority_tagging:1;	/* FC Word 1, bit 23 */
 	uint16_t simplex:1;	/* FC Word 1, bit 22 */
 	uint16_t word1Reserved1:3;	/* FC Word 1, bit 21:19 */
 	uint16_t dhd:1;		/* FC Word 1, bit 18 */
 	uint16_t contIncSeqCnt:1;	/* FC Word 1, bit 17 */
 	uint16_t payloadlength:1;	/* FC Word 1, bit 16 */
 #else	/*  __LITTLE_ENDIAN_BITFIELD */
-	uint16_t broadcast:1;	/* FC Word 1, bit 24 */
+	u16 app_hdr_support:1;	/* FC Word 1, bit 24 */
 	uint16_t multicast:1;	/* FC Word 1, bit 25 */
 	uint16_t edtovResolution:1;	/* FC Word 1, bit 26 */
 	uint16_t altBbCredit:1;	/* FC Word 1, bit 27 */
@@ -423,7 +424,7 @@ struct csp {
 	uint16_t dhd:1;		/* FC Word 1, bit 18 */
 	uint16_t word1Reserved1:3;	/* FC Word 1, bit 21:19 */
 	uint16_t simplex:1;	/* FC Word 1, bit 22 */
-	uint16_t huntgroup:1;	/* FC Word 1, bit 23 */
+	uint16_t priority_tagging:1;	/* FC Word 1, bit 23 */
 #endif
 
 	uint8_t bbRcvSizeMsb;	/* Upper nibble is reserved */
@@ -607,6 +608,8 @@ struct fc_vft_header {
 #define ELS_CMD_LIRR      0x7A000000
 #define ELS_CMD_LCB	  0x81000000
 #define ELS_CMD_FPIN	  0x16000000
+#define ELS_CMD_QFPA      0xB0000000
+#define ELS_CMD_UVEM      0xB1000000
 #else	/*  __LITTLE_ENDIAN_BITFIELD */
 #define ELS_CMD_MASK      0xffff
 #define ELS_RSP_MASK      0xff
@@ -649,6 +652,8 @@ struct fc_vft_header {
 #define ELS_CMD_LIRR      0x7A
 #define ELS_CMD_LCB	  0x81
 #define ELS_CMD_FPIN	  ELS_FPIN
+#define ELS_CMD_QFPA      0xB0
+#define ELS_CMD_UVEM      0xB1
 #endif
 
 /*
@@ -1317,6 +1322,117 @@ struct fc_rdp_res_frame {
 };
 
 
+/* UVEM */
+
+#define LPFC_UVEM_SIZE 60
+#define LPFC_UVEM_VEM_ID_DESC_SIZE 16
+#define LPFC_UVEM_VE_MAP_DESC_SIZE 20
+
+#define VEM_ID_DESC_TAG  0x0001000A
+struct lpfc_vem_id_desc {
+	u32 tag;
+	u32 length;
+	u8 vem_id[16];
+};
+
+#define LPFC_QFPA_SIZE	4
+
+#define INSTANTIATED_VE_DESC_TAG  0x0001000B
+struct instantiated_ve_desc {
+	u32 tag;
+	u32 length;
+	u8 global_vem_id[16];
+	u32 word6;
+#define lpfc_instantiated_local_id_SHIFT   0
+#define lpfc_instantiated_local_id_MASK    0x000000ff
+#define lpfc_instantiated_local_id_WORD    word6
+#define lpfc_instantiated_nport_id_SHIFT   8
+#define lpfc_instantiated_nport_id_MASK    0x00ffffff
+#define lpfc_instantiated_nport_id_WORD    word6
+};
+
+#define DEINSTANTIATED_VE_DESC_TAG  0x0001000C
+struct deinstantiated_ve_desc {
+	u32 tag;
+	u32 length;
+	u8 global_vem_id[16];
+	u32 word6;
+#define lpfc_deinstantiated_nport_id_SHIFT   0
+#define lpfc_deinstantiated_nport_id_MASK    0x000000ff
+#define lpfc_deinstantiated_nport_id_WORD    word6
+#define lpfc_deinstantiated_local_id_SHIFT   24
+#define lpfc_deinstantiated_local_id_MASK    0x00ffffff
+#define lpfc_deinstantiated_local_id_WORD    word6
+};
+
+/* Query Fabric Priority Allocation Response */
+#define LPFC_PRIORITY_RANGE_DESC_SIZE 12
+
+struct priority_range_desc {
+	u32 tag;
+	u32 length;
+	u8 lo_range;
+	u8 hi_range;
+	u8 qos_priority;
+	u8 local_ve_id;
+};
+
+struct fc_qfpa_res {
+	u32 reply_sequence;	/* LS_ACC or LS_RJT */
+	u32 length;	/* FC Word 1    */
+	struct priority_range_desc desc[1];
+};
+
+/* Application Server command code */
+/* VMID               */
+
+#define SLI_CT_APP_SEV_Subtypes     0x20	/* Application Server subtype */
+
+#define SLI_CTAS_GAPPIA_ENT    0x0100	/* Get Application Identifier */
+#define SLI_CTAS_GALLAPPIA     0x0101	/* Get All Application Identifier */
+#define SLI_CTAS_GALLAPPIA_ID  0x0102	/* Get All Application Identifier */
+					/* for Nport */
+#define SLI_CTAS_GAPPIA_IDAPP  0x0103	/* Get Application Identifier */
+					/* for Nport */
+#define SLI_CTAS_RAPP_IDENT    0x0200	/* Register Application Identifier */
+#define SLI_CTAS_DAPP_IDENT    0x0300	/* Deregister Application */
+					/* Identifier */
+#define SLI_CTAS_DALLAPP_ID    0x0301	/* Deregister All Application */
+					/* Identifier */
+
+struct entity_id_object {
+	u8 entity_id_len;
+	u8 entity_id[255];	/* VM UUID */
+};
+
+struct app_id_object {
+	u32 port_id;
+	u32 app_id;
+	struct entity_id_object obj;
+};
+
+struct lpfc_vmid_rapp_ident_list {
+	u32 no_of_objects;
+	struct entity_id_object obj[1];
+};
+
+struct lpfc_vmid_dapp_ident_list {
+	u32 no_of_objects;
+	struct entity_id_object obj[1];
+};
+
+#define GALLAPPIA_ID_LAST  0x80
+struct lpfc_vmid_gallapp_ident_list {
+	u8 control;
+	u8 reserved[3];
+	struct app_id_object app_id;
+};
+
+#define RAPP_IDENT_OFFSET  (offsetof(struct lpfc_sli_ct_request, un) + 4)
+#define DAPP_IDENT_OFFSET  (offsetof(struct lpfc_sli_ct_request, un) + 4)
+#define GALLAPPIA_ID_SIZE  (offsetof(struct lpfc_sli_ct_request, un) + 4)
+#define DALLAPP_ID_SIZE    (offsetof(struct lpfc_sli_ct_request, un) + 4)
+
 /******** FDMI ********/
 
 /* lpfc_sli_ct_request defines the CT_IU preamble for FDMI commands */
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 93d976ea8c5d..6dd45885df4f 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -35,6 +35,12 @@ typedef enum _lpfc_ctx_cmd {
 	LPFC_CTX_HOST
 } lpfc_ctx_cmd;
 
+union lpfc_vmid_iocb_tag {
+	u32 app_id;
+	u8 cs_ctl_vmid;
+	struct lpfc_vmid_context *vmid_context;	/* UVEM context information */
+};
+
 struct lpfc_cq_event {
 	struct list_head list;
 	uint16_t hdwq;
@@ -100,6 +106,7 @@ struct lpfc_iocbq {
 #define LPFC_IO_NVME	        0x200000 /* NVME FCP command */
 #define LPFC_IO_NVME_LS		0x400000 /* NVME LS command */
 #define LPFC_IO_NVMET		0x800000 /* NVMET command */
+#define LPFC_IO_VMID            0x1000000 /* VMID tagged IO */
 
 	uint32_t drvrTimeout;	/* driver timeout in seconds */
 	struct lpfc_vport *vport;/* virtual port pointer */
@@ -114,6 +121,7 @@ struct lpfc_iocbq {
 		struct lpfc_node_rrq *rrq;
 	} context_un;
 
+	union lpfc_vmid_iocb_tag vmid_tag;
 	void (*fabric_iocb_cmpl)(struct lpfc_hba *, struct lpfc_iocbq *,
 			   struct lpfc_iocbq *);
 	void (*wait_iocb_cmpl)(struct lpfc_hba *, struct lpfc_iocbq *,
-- 
2.26.2


--0000000000003479a405b2070c7e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCAfJjWoaK8umj/+h/35EIozqNtOqkPEjfGaAHp+SBjVFzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEwMTkxNDM3MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJgT76oSazl1mBqtD
FIQk91WGH9Xf6ADRWvE5qVdVCxobdc2tKmrgFVlnSyy7AF2Xx+cZDxHtPjTGYUYi26Jxrbx6PwRs
ZKkP6EETSNOZlIfqzjYvqjWhBJE5WVNWf2gs87yhuDJeXv68CHIU6PjqnnCwVEGBnlCCLZojprlU
grpEI8Xnd+v8YmFDyRZIcddT68t6IwWpooRX84S01Y5sPLhvjbiM5wDMxK0nHHZftkB6Taq9kOWd
ErH4v43s8J3fHUqZ2dKdKkhW2ZMxIbLRXbm4zU+2qA9BbvQL9x78g3iEedIoBb1yfJUNIcxicwVx
f8oz8wzUbRl7bSM36jQNxA==
--0000000000003479a405b2070c7e--


--===============8277611280774178488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8277611280774178488==--

