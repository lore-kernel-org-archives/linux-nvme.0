Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A064C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:06:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4066F613EB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4066F613EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zFcyl9r68jh3SdPfO4Y5Is7XxwEzAvjFv0xWy5DvImA=; b=T/wqOraNTv7H35
	+78QoNjI18y04O25YQX4aNZSo3ZJonqKhunVnAFF0U+dXZc1sUKmyAWtCjvy41ATR8AJnJ23mfus7
	rGhr29PmPhxvwZAxFBvAOq6KVwY1JzANosUbi/IUkvBNdVqDXwYuAuEaStn9ovkCjClqZvwlVvIKI
	rRZTB3b6GOBkO9cbJ+EE9sxLSB6agJyXIGICrXYNsrPzX1l0JEyqxO1AcmfL3TdkD1tEAnaWELNdz
	Fm86QiOw/dGemWnFjpG9eGS35kpcEQD66K8+biHfH+c26c3HZdJpm90XVV8tXa4Ai2/E5O6Yz0FFq
	pqA5oU77CX+MkFdHg4rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4LfC-004EKU-De; Fri, 16 Jul 2021 11:05:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4Le9-004E5U-Hm
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 11:04:49 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 56E89205D4;
 Fri, 16 Jul 2021 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626433482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqxozhLBJMzXENHdmmUKHtrkpmCxpVvzwbM5zntJ/Lc=;
 b=spMiS2wyo87Zo14k3/peX8YCk9WXrVrNDJUZOYXzvN0iK1YWbRWPnV3BUFu5U3OGvgvvX8
 2Pke3kq0jB5kKqlwYaLFVLWuHCxfxQuWO5xZqojeCZodo7xQhaaGdIvd/rpDhIjQCLJtyd
 TrCdS083vsrCYioEwfpajcDTRo2guuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626433482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqxozhLBJMzXENHdmmUKHtrkpmCxpVvzwbM5zntJ/Lc=;
 b=CxS11aGMGQYginryk5N7w73sNCalJ8jS9PbZ79UnfzWCEkAGobOb2AAGYol08orzSKJ7yB
 3qgOCrV9w2AevXCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 47557A3BB9;
 Fri, 16 Jul 2021 11:04:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8B050517160E; Fri, 16 Jul 2021 13:04:41 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/11] nvme: add definitions for NVMe In-Band authentication
Date: Fri, 16 Jul 2021 13:04:22 +0200
Message-Id: <20210716110428.9727-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210716110428.9727-1-hare@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_040445_971688_AD68736E 
X-CRM114-Status: GOOD (  13.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/nvme.h | 185 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..7b94abacfd08 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -19,6 +19,7 @@
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
+#define NVMF_AUTH_HASH_LEN	64
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1263,6 +1264,8 @@ enum nvmf_capsule_command {
 	nvme_fabrics_type_property_set	= 0x00,
 	nvme_fabrics_type_connect	= 0x01,
 	nvme_fabrics_type_property_get	= 0x04,
+	nvme_fabrics_type_auth_send	= 0x05,
+	nvme_fabrics_type_auth_receive	= 0x06,
 };
 
 #define nvme_fabrics_type_name(type)   { type, #type }
@@ -1270,7 +1273,9 @@ enum nvmf_capsule_command {
 	__print_symbolic(type,						\
 		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
 		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
-		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
+		nvme_fabrics_type_name(nvme_fabrics_type_property_get), \
+		nvme_fabrics_type_name(nvme_fabrics_type_auth_send),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_auth_receive))
 
 /*
  * If not fabrics command, fctype will be ignored.
@@ -1393,6 +1398,182 @@ struct nvmf_property_get_command {
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
+	__u8		resv4[12];
+
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
+	__u8		resv4[12];
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
+enum {
+	NVME_AUTH_DHCHAP_HASH_SHA256	= 0x01,
+	NVME_AUTH_DHCHAP_HASH_SHA384	= 0x02,
+	NVME_AUTH_DHCHAP_HASH_SHA512	= 0x03,
+};
+
+enum {
+	NVME_AUTH_DHCHAP_DHGROUP_NULL	= 0x00,
+	NVME_AUTH_DHCHAP_DHGROUP_2048	= 0x01,
+	NVME_AUTH_DHCHAP_DHGROUP_3072	= 0x02,
+	NVME_AUTH_DHCHAP_DHGROUP_4096	= 0x03,
+	NVME_AUTH_DHCHAP_DHGROUP_6144	= 0x04,
+	NVME_AUTH_DHCHAP_DHGROUP_8192	= 0x05,
+};
+
+union nvmf_auth_protocol {
+	struct nvmf_auth_dhchap_protocol_descriptor dhchap;
+};
+
+struct nvmf_auth_dhchap_negotiate_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__u8		rsvd[2];
+	__le16		t_id;
+	__u8		sc_c;
+	__u8		napd;
+	union nvmf_auth_protocol auth_protocol[];
+};
+
+struct nvmf_auth_dhchap_challenge_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__u8		rsvd1[2];
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
+	__u8		rsvd1[2];
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
+	__u8		rsvd1[2];
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
+	__u8		rsvd1[2];
+	__le16		t_id;
+	__u8		rsvd2[10];
+};
+
+struct nvmf_auth_dhchap_failure_data {
+	__u8		auth_type;
+	__u8		auth_id;
+	__u8		rsvd1[2];
+	__le16		t_id;
+	__u8		reason_code;
+	__u8		reason_code_explanation;
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
+	NVME_AUTH_DHCHAP_FAILURE_INVALID_PAYLOAD	= 0x06,
+	NVME_AUTH_DHCHAP_FAILURE_INVALID_MESSAGE	= 0x07,
+};
+
+
 struct nvme_dbbuf {
 	__u8			opcode;
 	__u8			flags;
@@ -1436,6 +1617,8 @@ struct nvme_command {
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
