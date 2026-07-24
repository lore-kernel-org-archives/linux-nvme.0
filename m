Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DFAC531FC
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NX8YLXEIxtujxvwGi6rLz7txy/dv+JRa4mW+Y1YWhTs=; b=m32q32IMHD9M6RXS+jX//yD0zI
	3h9/JhICN8zhuIPydHVqZeWHV+11X0c4toq7LXbLy3UlfuoK8nITjvkpf9bM1v+6NP6Gxb/cqAyAH
	6z3uqpmlKvqvz/ZAzQj4s6R9ulneHkKBJORYeykxfJctrFNYRO5X3zS8A2iH8XDzAw7Oz4fKIPY8d
	kT981L3gjNhORv7WJcLAwx8vTUUBJLkguJB4d0uYmaUMZJUgtODTSBp7Qx4+R907ziwOlXgPdtz6p
	iKhMwgv4zZim01WCt2Hls6sOJYgXCyoZGbbZCw7/kMPjdISCFEZoLzPKIH6XrvUKDxP5/Jv+QmnyY
	cuX6HQlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDol-0000000GFV5-2tR9;
	Fri, 24 Jul 2026 11:11:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoj-0000000GFSX-2Akq
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 00517437A1;
	Fri, 24 Jul 2026 11:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7000AC4FF63;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=AZy2WTqOKzVRegCf28nvQJjMyVdHQz6BP3DV6TkjK9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QkFWKwNFesuxZhZZup0rZ4vakdAAyckDsSP9K7RxHvGwL/rYDcJJTsc+eiZA2UZCB
	 oGz4FC1OfEe607Zn3+Q5BPiCu+gY+wdoqOnhK/xddnbL1wMIeBiaEGDcf2gfLvttvG
	 QAV/mVMZI0zFTKcwCQShbEwF3+zCfSaO71e2V92qF/U1aOFV2Bq8uhZ1AcHArwxWH5
	 HL7IOPmy/N9koctD1v5PYGzi3B5hL83U4o36FigL9XCNY3W3C0OhqSPcBGfUFOELsy
	 p+Pwh2+d1NK3BERhuj3Vz/z3MM/C3G5Ir8v+kSdAfN0aTBt0UMfD78DcAh8RgWSFHS
	 wiS0cqyfE2b6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC3C531C9;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:10:56 +0200
Subject: [PATCH RFC v2 02/14] nvme: Add NVMe Controller Data Queue command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-2-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=AZy2WTqOKzVRegCf28nvQJjMyVdHQz6BP3DV6TkjK9g=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFrWCyLD22UG7qKq/OMjAgVA1sOtD01sl
 bmdPnT8hw5KD4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0haAAoJELqXzVK3
 lkFP4pkL/3PeJxuMTzMA9qAWTcWk0ycTHCE6SA2NFl5AYprn9XXu7TyOMAGzTsk6rEm3KWbj9L5
 i3ert5Jd+DMdp5DQPKZKTblhyUa7QbYh8RM+Qnej04y7+Ysd+QdVNdV+NXNSV7jNIpd+n+m4iMF
 7P62wmJP3qJi7f5+xNG3SS3n+FHiZUXW/jNa8ezZCKd3KW4/OMGxdz1pKlmsLOBoNKbsQU0v2gn
 H0AEDsUrInE1CNGrEp/LOVg3veYyzp/FhMiVdwR8tF5nVMXSFCEH23IKbJ+NJF8Bza7dzVbQRfs
 LWpmfNzsDvPTA0kMWVxVgmB9+iCS18c4hrvdR/2DO060kfLY3pDpCelylPlLUa2/GF+SIZmmirJ
 t2Ol2foyS65NYG/rQ187sm2ZwOBYIiqqkOK024VTgkNmoH2GOHDQqs8MhAZ8OBmn+KAiEo/s5zi
 8kfTniQoGcnBeYZygauOoTGZJXP8+AoMParKfKkyZXVD/33lU2trn17wnT2sDsKebGTS91vyX56
 zw=
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

Add the struct (nvme_cdq_cmd) and define the relative values to support
NVMe Controller Data Queue management.
* struct nvme_cdq_cmd: Is the CDQ mgmt command
* nvme_cdq_cmd_mgmt_op: Specifies create or delete
* NVME_CDQ_CMD_MGMT_CREATE_*: Specifies the create operation.

No functional changes are included as this is a preparation commit.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 include/linux/nvme.h     | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6e7533ccf24bfe3df7188f442986ec18a3200660..d11858300ad43f3e229eab7f2dd77563075b801e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5387,6 +5387,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_lm_send_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_lm_recv_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cdq_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 60fb5b6808615ff7388f30e12ffe6ed5da2ef4f6..1c20ddc06a46066b5ab9acf1dc44b03d941592a9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1639,6 +1639,7 @@ enum nvme_admin_opcode {
 	nvme_admin_nvme_mi_recv		= 0x1e,
 	nvme_admin_lm_send		= 0x41,
 	nvme_admin_lm_recv		= 0x42,
+	nvme_admin_cdq			= 0x45,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1679,7 +1680,8 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
 		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
-		nvme_admin_opcode_name(nvme_admin_get_lba_status))
+		nvme_admin_opcode_name(nvme_admin_get_lba_status),	\
+		nvme_admin_opcode_name(nvme_admin_cdq))
 
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
@@ -1710,6 +1712,7 @@ enum {
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
 	NVME_FEAT_SANITIZE	= 0x17,
+	NVME_FEAT_CDQ		= 0x21,
 	NVME_FEAT_FDP		= 0x1d,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
@@ -1739,6 +1742,10 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+enum {
+	NVME_FEAT_CDQ_ID_MASK = GENMASK(15, 0),
+};
+
 struct nvme_supported_log {
 	__le32	lids[256];
 };
@@ -1917,6 +1924,41 @@ struct nvme_directive_cmd {
 	__u32			rsvd16[3];
 };
 
+//Select values for dword 10
+enum nvme_cdq_cmd_mgmt_op {
+	NVME_CDQ_CMD_MGMT_CREATE = 0x0,
+	NVME_CDQ_CMD_MGMT_DELETE = 0x1
+};
+#define NVME_CDQ_CMD_MGMT_CREATE_MOS_QT_UDMQ	0x0
+#define NVME_CDQ_CMD_MGMT_CREATE_PC_CONT	0x1
+#define NVME_CDQ_CMD_MGMT_CREATE_PC_DISCONT	0x0
+
+union nvme_cdq_cmd_dw11 {
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
+struct nvme_cdq_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__le32			rsvd8[2];
+	__u8			sel;
+	__u8			rsvd10;
+	__le16			mos;
+	union nvme_cdq_cmd_dw11	dw11;
+	__le32			cdqsize;
+	__u32			rsvd13[3];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -2335,6 +2377,7 @@ struct nvme_command {
 		struct nvme_directive_cmd directive;
 		struct nvme_lm_command lm;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cdq_command cdq;
 	};
 };
 

-- 
2.50.1



