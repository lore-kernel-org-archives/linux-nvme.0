Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D073C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xj/x/gnIcXgGh5VCLKnABwXJ/ZAV2JlPnRf5SCs8UFA=; b=IsHmPNuOTBoFwwYkItPDGNQtsT
	naR+QPxZWZ33Ib7SszuFLjPDGYBASDAMJmICXl/QnNIn4CVMzOh5C8wwwn0+kctnSNWOm2/xnePNN
	/SYUpmEudL6iqXKcTd7zsTEXvg0drrIpybRISP2bBfa/CgfIZwBkrLTWU4FSATzMW7L4LCqpsMQTQ
	4pcW6kofObDLB2N9PZWYKkcWNKmRV5wnMI7WkWeDhVPLn41UAAyaDDO3HSs9uIB3/len9vonCNKI0
	poshZmMw3BmbjjzlDxM0cNJSXBSu0JTVUKECPkDE/f4ZSDOjPql//z1KLHbNtDzJR5jrEm1VLHKNj
	iTMEIzsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWvBz-00Cvnb-0w; Wed, 23 Mar 2022 07:14:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWvBM-00Cvaw-EW
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 07:13:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 43E54210F8;
 Wed, 23 Mar 2022 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648019602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xj/x/gnIcXgGh5VCLKnABwXJ/ZAV2JlPnRf5SCs8UFA=;
 b=FGeScu+18MxKyFcXx6jlSCTDX+OX5U8LaEhxK+oEHi3SInwoTrZZGaRtCABeydoN5vbVR1
 Qug4VACa9ox7DsakwdzBO4T/Wq2iEYhR4T2gdI/I+pR3PLiJIKEIdBktrLQNndC8lBPkbI
 bKmdBMcaT1kOoTog9SawdAYGsOSR+H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648019602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xj/x/gnIcXgGh5VCLKnABwXJ/ZAV2JlPnRf5SCs8UFA=;
 b=GqZdj7Ou1OPVeE+v6oluarutdmTTC1Vg85Q1UO8hZwRIaD2KYlRqay3bnZwXeK8YoLhY7W
 4SUNuGeRkYtW5+CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0D864A3B88;
 Wed, 23 Mar 2022 07:13:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3FBDE5193881; Wed, 23 Mar 2022 08:13:21 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 04/11] nvme: add definitions for NVMe In-Band authentication
Date: Wed, 23 Mar 2022 08:12:56 +0100
Message-Id: <20220323071303.14671-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220323071303.14671-1-hare@suse.de>
References: <20220323071303.14671-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_001324_784711_2DEAD706 
X-CRM114-Status: GOOD (  15.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add new definitions for NVMe In-band authentication as defined in
the NVMe Base Specification v2.0.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 include/linux/nvme.h | 188 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9dbc3ef4daf7..7ef5a5aa1340 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -19,6 +19,7 @@
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
+#define NVMF_AUTH_HASH_LEN	64
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1286,6 +1287,8 @@ enum nvmf_capsule_command {
 	nvme_fabrics_type_property_set	= 0x00,
 	nvme_fabrics_type_connect	= 0x01,
 	nvme_fabrics_type_property_get	= 0x04,
+	nvme_fabrics_type_auth_send	= 0x05,
+	nvme_fabrics_type_auth_receive	= 0x06,
 };
 
 #define nvme_fabrics_type_name(type)   { type, #type }
@@ -1293,7 +1296,9 @@ enum nvmf_capsule_command {
 	__print_symbolic(type,						\
 		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
 		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
-		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
+		nvme_fabrics_type_name(nvme_fabrics_type_property_get), \
+		nvme_fabrics_type_name(nvme_fabrics_type_auth_send),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_auth_receive))
 
 /*
  * If not fabrics command, fctype will be ignored.
@@ -1423,6 +1428,185 @@ struct nvmf_property_get_command {
 	__u8		resv4[16];
 };
 
+struct nvmf_auth_send_command {
+	__u8		opcode;
+	__u8		resv1;
+	__u16		command_id;
+	__u8		fctype;
+	__u8		resv2[19];
+	union nvme_data_ptr dptr;
+	__u8		resv3;
+	__u8		spsp0;
+	__u8		spsp1;
+	__u8		secp;
+	__le32		tl;
+	__u8		resv4[16];
+};
+
+struct nvmf_auth_receive_command {
+	__u8		opcode;
+	__u8		resv1;
+	__u16		command_id;
+	__u8		fctype;
+	__u8		resv2[19];
+	union nvme_data_ptr dptr;
+	__u8		resv3;
+	__u8		spsp0;
+	__u8		spsp1;
+	__u8		secp;
+	__le32		al;
+	__u8		resv4[16];
+};
+
+/* Value for secp */
+enum {
+	NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER	= 0xe9,
+};
+
+/* Defined value for auth_type */
+enum {
+	NVME_AUTH_COMMON_MESSAGES	= 0x00,
+	NVME_AUTH_DHCHAP_MESSAGES	= 0x01,
+};
+
+/* Defined messages for auth_id */
+enum {
+	NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE	= 0x00,
+	NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE	= 0x01,
+	NVME_AUTH_DHCHAP_MESSAGE_REPLY		= 0x02,
+	NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1	= 0x03,
+	NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2	= 0x04,
+	NVME_AUTH_DHCHAP_MESSAGE_FAILURE2	= 0xf0,
+	NVME_AUTH_DHCHAP_MESSAGE_FAILURE1	= 0xf1,
+};
+
+struct nvmf_auth_dhchap_protocol_descriptor {
+	__u8		authid;
+	__u8		rsvd;
+	__u8		halen;
+	__u8		dhlen;
+	__u8		idlist[60];
+};
+
+enum {
+	NVME_AUTH_DHCHAP_AUTH_ID	= 0x01,
+};
+
+/* Defined hash functions for DH-HMAC-CHAP authentication */
+enum {
+	NVME_AUTH_HASH_SHA256	= 0x01,
+	NVME_AUTH_HASH_SHA384	= 0x02,
+	NVME_AUTH_HASH_SHA512	= 0x03,
+	NVME_AUTH_HASH_INVALID	= 0xff,
+};
+
+/* Defined Diffie-Hellman group identifiers for DH-HMAC-CHAP authentication */
+enum {
+	NVME_AUTH_DHGROUP_NULL		= 0x00,
+	NVME_AUTH_DHGROUP_2048		= 0x01,
+	NVME_AUTH_DHGROUP_3072		= 0x02,
+	NVME_AUTH_DHGROUP_4096		= 0x03,
+	NVME_AUTH_DHGROUP_6144		= 0x04,
+	NVME_AUTH_DHGROUP_8192		= 0x05,
+	NVME_AUTH_DHGROUP_INVALID	= 0xff,
+};
+
+union nvmf_auth_protocol {
+	struct nvmf_auth_dhchap_protocol_descriptor dhchap;
+};
+
+struct nvmf_auth_dhchap_negotiate_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__le16		rsvd;
+	__le16		t_id;
+	__u8		sc_c;
+	__u8		napd;
+	union nvmf_auth_protocol auth_protocol[];
+};
+
+struct nvmf_auth_dhchap_challenge_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__u16		rsvd1;
+	__le16		t_id;
+	__u8		hl;
+	__u8		rsvd2;
+	__u8		hashid;
+	__u8		dhgid;
+	__le16		dhvlen;
+	__le32		seqnum;
+	/* 'hl' bytes of challenge value */
+	__u8		cval[];
+	/* followed by 'dhvlen' bytes of DH value */
+};
+
+struct nvmf_auth_dhchap_reply_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__le16		rsvd1;
+	__le16		t_id;
+	__u8		hl;
+	__u8		rsvd2;
+	__u8		cvalid;
+	__u8		rsvd3;
+	__le16		dhvlen;
+	__le32		seqnum;
+	/* 'hl' bytes of response data */
+	__u8		rval[];
+	/* followed by 'hl' bytes of Challenge value */
+	/* followed by 'dhvlen' bytes of DH value */
+};
+
+enum {
+	NVME_AUTH_DHCHAP_RESPONSE_VALID	= (1 << 0),
+};
+
+struct nvmf_auth_dhchap_success1_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__le16		rsvd1;
+	__le16		t_id;
+	__u8		hl;
+	__u8		rsvd2;
+	__u8		rvalid;
+	__u8		rsvd3[7];
+	/* 'hl' bytes of response value if 'rvalid' is set */
+	__u8		rval[];
+};
+
+struct nvmf_auth_dhchap_success2_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__le16		rsvd1;
+	__le16		t_id;
+	__u8		rsvd2[10];
+};
+
+struct nvmf_auth_dhchap_failure_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__le16		rsvd1;
+	__le16		t_id;
+	__u8		rescode;
+	__u8		rescode_exp;
+};
+
+enum {
+	NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED	= 0x01,
+};
+
+enum {
+	NVME_AUTH_DHCHAP_FAILURE_FAILED			= 0x01,
+	NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE		= 0x02,
+	NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH	= 0x03,
+	NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE		= 0x04,
+	NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE	= 0x05,
+	NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD	= 0x06,
+	NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE	= 0x07,
+};
+
+
 struct nvme_dbbuf {
 	__u8			opcode;
 	__u8			flags;
@@ -1466,6 +1650,8 @@ struct nvme_command {
 		struct nvmf_connect_command connect;
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
+		struct nvmf_auth_send_command auth_send;
+		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 	};
-- 
2.29.2


