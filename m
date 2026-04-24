Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21541FE51FE
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wsspUeFa6jTWibB8Hu8vBBNRCyHfiUPfN5u5PlMW2/w=; b=2sFsttDmdXpW8zLSnxmsjORlih
	zuDe0Z70KLVA+7tCIEXufn6quID8Zed9tF8MFT35rHTCA97f2vhLv4U9xWU0Sj4PH4KP9YfEp39N5
	AlJZlhwCLmx88vYVTsYBJz4RChFwnASrfFKW76WO27zz+odth1GYpIlFBVkS6qb6g+eb4iVf50GaK
	ZrI/pFB8DOVu408AcbQDpx+RSOsakmN8s2SJ7VDk2Z9/ymXAmTeC+I9nOOEtK7Rs2K9F7SS1GWP37
	W4H7jFLJW/kbuaIQo3rwo4Dt/4SC/+bJjccnkeAq1TYKlEjMvDNOUPzR7coN2sLv5dApw91++ie/q
	YZBu+ZzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGErY-0000000D8L5-1prm;
	Fri, 24 Apr 2026 11:38:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGErW-0000000D8Js-3Scl
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 11:38:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E548860121;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BA09C2BCB2;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030701;
	bh=4zNJ6loTKjIjSN+QrYsZm8Egd19LSNJXk9dOsf5rVFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nDvxV33uYGQJvOQ+OxQ5BbDazm9UjOaZDRD9SRHX1b2lYBsTf7Gw6+s+lgIshZ4zN
	 u4pm4WSwCboI5xY0VfhMgrRW8e//3TIKlz5fE4bf+WKwLu5HB6ca81ULY+oujcgwQ9
	 39B9boXKXPd1q+X6prDOUxNpU8b4Q5aUfbt1Iq/3ZEu0D2R+H2fLOm+Iv4c2wJNKr8
	 SCmX1Ut177jcEELV0gvlYPvMqBEYkqoiwWyelccRvqc0qb0cpIxkvm0rXOCfyZe42Q
	 6oLmUP/FMCzY1e9jZNPj4OW5mzHtXpW5RVaZ673atld9qYe7QgTGZimAjaD7aXDRRd
	 qqGt4stISGdfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6FFE520D;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Apr 2026 13:37:51 +0200
Subject: [PATCH RFC 1/5] nvme: Add CDQ data structures to nvme spec header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-jag-cdq-lkml-v1-1-d773343a717c@kernel.org>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
In-Reply-To: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=4zNJ6loTKjIjSN+QrYsZm8Egd19LSNJXk9dOsf5rVFw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGnrVikChr+aVWumC6i1NEray6knJqmhtIjdn
 LZrhvR9iDi6OokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJp61YpAAoJELqXzVK3
 lkFPahEMAI7SmMJOy/dGbCgVfw2dl7JsnbTmjBUqVQqrzJkOoQu/dAxejUEo74twokZ5lSPXoCF
 IIF5UMKZjuSix+ItI2vxQYh2A5vO20066IUAHCvgRzEBuWFAsc5Bzy7P3FRw0e/BBQPI3LKvHft
 bBwBS2TZ6dPyMvEAvhDJX2Xe3a5R0TXcavVbWqBiLWaVhnkDmgC+lIlU18yO5KcsaHnaJji5azX
 kzXJL74j8ULmv9NmIhnDmsAZbKjwH8ci7S2DbWTWNU2fYwJAtWcZtjS+FZwNUSykPzxDfAxwyGK
 S/oIgrC2OgGk2bE1B611lMHkIAXuvAaG6OwC4Sc3qa3LhKvP/E8BFqdv3d2uLgBWuyhOggu1Z0p
 odADU07+heji/vQq7R/944g+bbs32CpSTpQSGE++yG72I2HuLwXB9IEzCjpk4TZaB66o4GGuP/P
 apBIn2FJF3QJ4J3+TQ1JyGcu2uBIFHfkeEKZt1lEp12QKSJnEmKEIjjEG6+YuXai5G/Bw9tetg5
 t0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Add Controller Data Queue (CDQ) related data structures and definitions
to include/linux/nvme.h. These are just the data structures. No
functional implementation yet.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/nvme.h | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e722c3400ac00f76841e1af0281f38f..4a42f1614de962b9d448193193f68fe1968dfb6f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1314,6 +1314,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cdq			= 0x45,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1352,7 +1353,8 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
 		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
-		nvme_admin_opcode_name(nvme_admin_get_lba_status))
+		nvme_admin_opcode_name(nvme_admin_get_lba_status),	\
+		nvme_admin_opcode_name(nvme_admin_cdq))
 
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
@@ -1412,6 +1414,10 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+enum {
+	NVME_FEAT_CDQ_ID_MASK = GENMASK(15, 0),
+};
+
 struct nvme_supported_log {
 	__le32	lids[256];
 };
@@ -1590,6 +1596,42 @@ struct nvme_directive_cmd {
 	__u32			rsvd16[3];
 };
 
+enum {
+	NVME_CDQ_SEL_CREATE_CDQ = 0x0,
+	NVME_CDQ_SEL_DELETE_CDQ = 0x1
+};
+
+enum {
+	NVME_CDQ_CFG_PC_DISCONT = 0x0,
+	NVME_CDQ_CFG_PC_CONT = 0x1
+};
+
+union nvme_cdq_dw11 {
+	struct {
+		__le16	flags;
+		__le16	cqs;
+	};
+	struct {
+		__le16	cdqid;
+		__le16	rsvd;
+	};
+};
+
+struct nvme_cdq {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__le32			rsvd8[2];
+	__u8			sel;
+	__u8			rsvd10;
+	__le16			mos;
+	union nvme_cdq_dw11	dw11;
+	__le32			cdqsize;
+	__u32			rsvd13[3];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -2000,6 +2042,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cdq cdq;
 	};
 };
 

-- 
2.50.1



