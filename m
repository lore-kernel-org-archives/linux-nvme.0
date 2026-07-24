Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1CEC531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Er52nONDC1dbXuvg1JqsIGSHc6WiMdzWPf1DlRzSqE=; b=vkoXb9GI/TwrKz394h862xpBwp
	U1zKFrqoBxp4jv+b544c5oAsU8GhfarhhH+VLbzylOjp+H+3CTN8FZT5bOVdNgSYfQh8Nazl3m6H+
	PFBT4UuenIcq6YaApIb0ewnYlHN4IP3s7bdch+7rx7qr6Y3IDR+fe0UeA/HgbejNED3EbnRjsm+jf
	3rgRI2D02TWVTzqCSm3GgVZ2VoVEYmY9x1idm6ROT4s+c7AIa6kA4ClDmX2T6u7KZAigAzvlZ9GaX
	M83nmMNnsrr5Xkpd+xhTuDXLM8FsJk23IVa8GNgD/d+MRM99sPBb8vwiXixEOBUcZkGDa1gH5iqnc
	eXSYCz4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoX-0000000GFAD-1OHK;
	Fri, 24 Jul 2026 11:11:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF7D-0BdI
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CBC4601E0;
	Fri, 24 Jul 2026 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CEC2C4FF6B;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=ymNcVYBztZcQ5ofo+4XnaaZ/MHgRlLgANYtiOPR0lYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q6IG2NxvmBZnMi221AB3qgpzV4tRh6ec8IR07cFp5rOiesrj6RM+w7yowmDdmSZp2
	 JUxeFvQ8YGpbqmijOrkpCqrjNyGhmN1A/spFuEm60QJcljlMHxDBB0HpKcyI29x/gr
	 /sJqJmrzA2YCfszFtIe80cGgUYDNIrU7dM7G4LpD5nWmYzUK2pftWMjZin03FuDCsS
	 ExwpqMC++BGn1gX07OYop8/i9SH4d4yvFoShe7LvZ/Rvit6WPELkTDvEuoOBDyleXg
	 5FOHSjNsIuAWXya4sEFv6qQms/XaOWF1YhDw7nun66I+MPM1M50fNN6pUD2VOT1twu
	 L6P/3s44/a9CA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8DC53209;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:10:57 +0200
Subject: [PATCH RFC v2 03/14] nvme: Add track send command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-3-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ymNcVYBztZcQ5ofo+4XnaaZ/MHgRlLgANYtiOPR0lYs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFqbSzvQLIQ7SXsSX8M7WzphY1l3jaRBH
 WKkKTMDEu/ScokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0haAAoJELqXzVK3
 lkFPBTkL/1fqXUb73qFKKCECzj/jAZ93Jza+YYmzoEVKXp14byhQqTdjpro5nVBLcTkEOscaua9
 7I8WHTBo8rCQDSD7UdmKH04Ydxm+CsHuF9MRLaPaDvOrYo5FRocW7tAbqaK/fDcpN3nuB0ceIR/
 uavYPeo3VNBPqb0VnHM7jkgsP0r0e2ILS21J2ruWRumNDwFM5CKwdBjzEK+KF5JevOM3twPfioj
 WYY6UUiOrwwOe1OEUmrB4rmIDYw2PtdewGl9bmzy8Kro5ialWBWHy9azy79a1UwT5Fd+AXLMOyU
 TjgRX2u8vuJkwhhBhO9E9h+ZBGTgpnoRO6djoa9UCwBE1a+AsSAMF+8nUDERDIlfZ8RSGWL5Ve/
 W7Qh/ePHJKYzD7jG+ko9VhcBHfvEhxPBls3T232KkOhaLxdzkKfGzGGvlf0wd+GAQgfFeQ2nVXK
 CfH+DrCDBv+YhhPWfGWe4OwXsUGFeg9irZjVhbNZpsJrQN9hOIbJwOStkOFqgl2E6/XndxRCGo4
 8E=
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

The Controller Data Queue is started/stopped using this NVMe command.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/nvme.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1c20ddc06a46066b5ab9acf1dc44b03d941592a9..7cabedce022eda98fff789596682f257203e3b45 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1637,6 +1637,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_track_send		= 0x3d,
 	nvme_admin_lm_send		= 0x41,
 	nvme_admin_lm_recv		= 0x42,
 	nvme_admin_cdq			= 0x45,
@@ -1681,7 +1682,8 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
 		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
 		nvme_admin_opcode_name(nvme_admin_get_lba_status),	\
-		nvme_admin_opcode_name(nvme_admin_cdq))
+		nvme_admin_opcode_name(nvme_admin_cdq),			\
+		nvme_admin_opcode_name(nvme_admin_track_send))
 
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
@@ -1959,6 +1961,28 @@ struct nvme_cdq_command {
 	__u32			rsvd13[3];
 };
 
+// These are the values for select in dword10
+enum nvme_track_send_cmd_mgmt_op {
+	NVME_TRSND_CMD_MGMT_LOG_USR_DATA = 0x0,
+	NVME_TRSND_CMD_MGMT_TRACK_MEM = 0x1
+};
+
+// These are the values for Logging action LACT
+#define NVME_TRSND_CMD_MGMT_LOG_USR_DATA_START	0x1
+#define NVME_TRSND_CMD_MGMT_LOG_USR_DATA_STOP	0x0
+
+struct track_send_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[9];
+	__u8			sel;
+	__u8			rsvd10;
+	__le16			mos;
+	__le32			dw11;
+	__u32			rsvd12[4];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -2378,6 +2402,7 @@ struct nvme_command {
 		struct nvme_lm_command lm;
 		struct nvme_io_mgmt_recv_cmd imr;
 		struct nvme_cdq_command cdq;
+		struct track_send_cmd track_send;
 	};
 };
 

-- 
2.50.1



