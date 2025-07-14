Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E0EC83F28
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNoIC2j+ldMTP5vAkML3EvsHR3OpnZJtnFcj4cbBeCE=; b=vdj7+GbM7AUPUlM3QD/ckDW6od
	A4LdEkeiSl+QSfHSIZJIv/GfNyV7OKDj+x5A7m43JpyQXcY5nIwZuAHs6D51cCKHjEY3kB4PHT3bV
	MYiLZhjXBPkZV6BUNGSSNIEmxBREuW3DlTVvdbpnW2HmeG+sAKDiCS+Lw+J3r4tcuQST5Ls66tVNa
	Gfhyho/JqmyGp0oZCzEEjGNWHSYwk56csJM8VxrK7R4ugf7tnSbn05vjW9OLMKbfIUuBY0c9JFe1/
	6LciTNMzfX4RqXPDm1uvRjMW3kpr3n+HvsXxgY3cqtnQhl0xvIZhnojGOZDlPquxAU/fXuhinNPNe
	pG8eybxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIf-00000001kcu-0YC2;
	Mon, 14 Jul 2025 09:16:41 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXq-3gqB
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAEFBA53CB8;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879C7C4CEF6;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=lwmTomBWKE8Fd16/Zh2Qe9kwiZVyEXAqd8HpaGKIrfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=swVGvptSMFOOMV7ImHmIDyFFsT4ndQ7Wqvjwdef0i6+fc/wA7WIPwrFtdTvrFDRiY
	 eh4IcRJacu1vaEK9WnuFsTiwvuUK56aQoEyfPrM+5/ORkMKK0Uzy/KcihfjMpEA50n
	 AZklIAZEkZlzrTvWq9K332w1Lb0hcS8LLczji0Kiv/Gok3NbMnpgw17XoXR6AyCxgr
	 oAKq3g1wcoQCY6Soz0mr8XSHzzSZOGNaZToorUyB8KoNo0eEaPrRyUQadkJgHaJo/p
	 wJ08I2G1L0humcq1aNs6C/FQSh8hcBDE2LWu/9ApQS+KR8ttMl2lqE1MD1T7ljbeNG
	 JBByCqvQK5O7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E9C83F1A;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:32 +0200
Subject: [PATCH RFC 1/8] nvme: Add CDQ command definitions for contiguous
 PRPs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-1-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=lwmTomBWKE8Fd16/Zh2Qe9kwiZVyEXAqd8HpaGKIrfI=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuk8GfwoY75hez1nZj0kKr5XnWOHgbukI
 9JpgO6uZi0vqokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrpAAoJELqXzVK3
 lkFPbggL/3XB2pAsjL3sKHaEN/oXQH2adusVp/KPNpHVTF6HFzd8CNfdj8yM0/08oL9Zv0CCvx0
 JyeBNW/uugwDdleya/LpBmpLQL5IM5j185NcqpPUHp+TbIPSjKvnk56/O6hn8zccX4MAI5GaoGz
 Xv/XQ67UlpIbz1OJ4kfCypoCfmtCwSMVOOn1+2kQ3HWKUgm32uamuDFonh2H2Jiq4OQUhzYptle
 Sb4psXJpbiOyW/Ubk58PiKB9SqSFIfUh7km3M8S936ElBCFXh8YqvkiT19V533XUTolsEKHifRB
 vLN8bB79Aqd6xywdFp2s2JA7q75tuEcaFGGSmKRTY5ucfEbDl8XzICgaulHcX8lpb4DinIyyi4a
 IxmmJ7tB0c1bEiACjIr+AJRir3tkw8sAEE+QUoahlGSx/6QrRxzp+ImSyhlUDGnv19ksqEDZdmu
 R8BP5p0GcMT42vWg+T7HWD+kwu0pWX7Fg+Qz8KbS9SZWMwi353Wo4ESMoTAOjhCYtE6sf7jiNN7
 K4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_021633_074531_36E5C689 
X-CRM114-Status: GOOD (  12.71  )
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

Add nvme_cdq to the nvme_command union that handles creation and
deletion operations. NVME_FEAT_CDQ is added to the feature flags with a
value of 0x21. nvme_admin_cdq is added to the NVME opcodes with a value
of 0x45. Add support for contiguous PRPs only; the non-contiguous case
described in the NVME spec can be added later.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 include/linux/nvme.h     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b04473c0ab73c61e208bb8fc230c2f9b65c69bc..7be6b42a1adcc3fdb3cec2e2d0e73fcf74244590 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5133,6 +5133,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_rotational_media_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cdq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2479ed10f53e37055973ea3c899060913923fa62..a2012ec00e60c2f0de1b06599ba39481eebe4263 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1240,6 +1240,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cdq			= 0x45,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1309,6 +1310,7 @@ enum {
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
 	NVME_FEAT_SANITIZE	= 0x17,
+	NVME_FEAT_CDQ		= 0x21,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -1514,6 +1516,33 @@ struct nvme_directive_cmd {
 	__u32			rsvd16[3];
 };
 
+struct nvme_cdq {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__u32			rsvd8[2];
+#define NVME_CDQ_SEL_CREATE_CDQ	0x0
+#define NVME_CDQ_SEL_DELETE_CDQ	0x1
+	__u8			sel;
+	__u8			rsvd10;
+	__le16			mos;
+	union {
+		struct {
+#define NVME_CDQ_CFG_PC_CONT	(1 << 0)
+			__le16	cdq_flags;
+			__le16	cqs;
+		} create;
+		struct {
+			__le16	cdqid;
+			__le16	rsvd;
+		} delete;
+	};
+	__le32			cdqsize;
+	__u32			rsvd13[2];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -1923,6 +1952,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_cdq cdq;
 	};
 };
 

-- 
2.47.2



