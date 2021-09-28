Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03BCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E2D6113E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2E2D6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=stbVS4CiKNmSRtiHg7YP9CKeVsgPyBsk16DiLcXwVrc=; b=oZo7dX+OQ8VJ3O
	4XoYeydF15FwBd99oeP79/9UC/9U/pOQNpE5hZhgxF9xW9VEBZErXxf+F+b/+k4vOqOVfLK7Sd9EI
	QfC6Gp2fEk4uHHjtCQXtShm2QTtXhGlUzp5vOYUFFUKyzjWkms2Yp1fNeyZYBaIUIGVTxIYT3saJj
	Uq49/qYNZ/wYYhVrjrD8L4bhE63nW8GI4n7ToGfBvjGeH5I9Awn2BTxcBqca1J6CCBvo/IQqckEQt
	IJE9R1gN51lcmbwq1REkdC68547Fu/gfx/49bqycMRL/YS6DR7S/5rjdFxu7pAZeB9Uy5vWJ9EWxt
	VWFaoq+1teL2J9Sg6Gqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV6F3-005kem-1f; Tue, 28 Sep 2021 06:05:25 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV6Dq-005kGb-VD
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 06:04:14 +0000
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out2.suse.de (Postfix) with ESMTP id D034D201C2;
 Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632809047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKRbXWXYTzB1gh4dWUtDVDhJEvaoCmiiHVIb7t9AF/w=;
 b=FbjnPS0IrNoQng9bfu3el9/VJWNeaeLscMq9kRgqz4AS//KBJnJh8t0jPj4c9/o3p0TMfj
 T4hHWyfffVZDAY4d1w+MVPpszClHv/dMWNThbGMmK7NYBlqUDDkCOS3eV8NXm8g6lyFEMN
 dQqEYgARJhsVgAg+BmoPMhaolIkrf7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632809047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKRbXWXYTzB1gh4dWUtDVDhJEvaoCmiiHVIb7t9AF/w=;
 b=v/taKn7IOGsMoTjZTKtnTCNO+EpEyyNEwu+Xt5EmIWU1q1ccl1AW5UpNJyxgq06oeb9exp
 h+BS6X+JRiAtkPCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay1.suse.de (Postfix) with ESMTP id C366925E6D;
 Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 54B18518EE28; Tue, 28 Sep 2021 08:04:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/12] nvme: add definitions for NVMe In-Band authentication
Date: Tue, 28 Sep 2021 08:03:49 +0200
Message-Id: <20210928060356.27338-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928060356.27338-1-hare@suse.de>
References: <20210928060356.27338-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_230411_276740_4BA60938 
X-CRM114-Status: GOOD (  16.17  )
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

Add new definitions for NVMe In-band authentication as defined in
the NVMe Base Specification v2.0.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme.h | 186 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..e2142e3246eb 100644
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
@@ -1393,6 +1398,183 @@ struct nvmf_property_get_command {
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
+	NVME_AUTH_DHCHAP_SHA256	= 0x01,
+	NVME_AUTH_DHCHAP_SHA384	= 0x02,
+	NVME_AUTH_DHCHAP_SHA512	= 0x03,
+};
+
+/* Defined Diffie-Hellman group identifiers for DH-HMAC-CHAP authentication */
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
@@ -1436,6 +1618,8 @@ struct nvme_command {
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
