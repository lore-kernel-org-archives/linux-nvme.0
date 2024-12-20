Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0E1E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c0Y4ULoWkDVMIXjFWZsZqLL2tYBIYgjRCQODy6xQgdI=; b=bwQITAH1m4zuZhA1FC1q/rKxh2
	7w7zi1DL99bauzeo7prnRRX9/GGsIOu039+3cSDR5xQwOwnbTq/HRaYMm8GI+jkhrRepe8ZrJrnb6
	T6n1ioQKykj16Qq8aSjjaUnddVcg4gv/6qmXE8UNF5+KrFQjsi2ktU63pXult3TxJ8vKcUQFY1tZK
	t9xxUrQHm2he8b+GUfj9muVeke0h1Y1Hc1uKplUvAtigpXbMiL94c6gQYS60Qkhv0FFuu5qRwjls2
	Kc0jRcdY+tIjGDdNQlg6vv5nAnCs12ltvgC3xKryKkyhD3YlY8NHNuL0zZb4xL9wzxR60TDzOmynz
	CHzPGY/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5n-00000003pkc-04FR;
	Fri, 20 Dec 2024 03:54:23 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5k-00000003pjn-2qcN
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 03:54:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21D9AA42AB4;
	Fri, 20 Dec 2024 03:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69784C4CED7;
	Fri, 20 Dec 2024 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666859;
	bh=1NuFx3QMcc1tEVOkMLILvj2kCaplIcqdsykNR20gpaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPWfFeAWWJmGrrA2/4BeVv0yw/WBB6SxTew9mT7Teb4sDGyXbu4hW5l8Y8bseuzQT
	 a+v8Vnxpc/4OGBh3yHS4CJrnRZaC7802TZMH3IundHafwlPY4lzqNXr/TF404ni/ep
	 OSuCXWGdp6RAqrGcX9q8ULrKmFqoV3I+1DAy/mDzIatknXvnTRF/DLgcyOuaalPo8R
	 DDr+YnmGIKU5TU+jogy4obximvQW1z2byt7FF8CB6J4d4auQGX2bGu9Fd/wZSXjJGw
	 mP/1Vrv+tLhsLUWN0TdxdU0fYpgLhbyVxtMfYsIaO4MH6xxDFypgpSkQwYkX9qnQVF
	 SYedXUEr1XiTQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 01/18] nvme: Move opcode string helper functions declarations
Date: Fri, 20 Dec 2024 12:54:24 +0900
Message-ID: <20241220035441.600193-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_195420_856621_5A8F60F8 
X-CRM114-Status: GOOD (  11.47  )
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

Move the declaration of all helper functions converting NVMe command
opcodes and status codes into strings from drivers/nvme/host/nvme.h
into include/linux/nvme.h, together with the commands definitions.
This allows NVMe target drivers to call these functions without having
to include a host header file.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/host/nvme.h | 39 ---------------------------------------
 include/linux/nvme.h     | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b3..2c76afd00390 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1182,43 +1182,4 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
-#ifdef CONFIG_NVME_VERBOSE_ERRORS
-const char *nvme_get_error_status_str(u16 status);
-const char *nvme_get_opcode_str(u8 opcode);
-const char *nvme_get_admin_opcode_str(u8 opcode);
-const char *nvme_get_fabrics_opcode_str(u8 opcode);
-#else /* CONFIG_NVME_VERBOSE_ERRORS */
-static inline const char *nvme_get_error_status_str(u16 status)
-{
-	return "I/O Error";
-}
-static inline const char *nvme_get_opcode_str(u8 opcode)
-{
-	return "I/O Cmd";
-}
-static inline const char *nvme_get_admin_opcode_str(u8 opcode)
-{
-	return "Admin Cmd";
-}
-
-static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
-{
-	return "Fabrics Cmd";
-}
-#endif /* CONFIG_NVME_VERBOSE_ERRORS */
-
-static inline const char *nvme_opcode_str(int qid, u8 opcode)
-{
-	return qid ? nvme_get_opcode_str(opcode) :
-		nvme_get_admin_opcode_str(opcode);
-}
-
-static inline const char *nvme_fabrics_opcode_str(
-		int qid, const struct nvme_command *cmd)
-{
-	if (nvme_is_fabrics(cmd))
-		return nvme_get_fabrics_opcode_str(cmd->fabrics.fctype);
-
-	return nvme_opcode_str(qid, cmd->common.opcode);
-}
 #endif /* _NVME_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 13377dde4527..a5a4ee56efcf 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1896,6 +1896,46 @@ static inline bool nvme_is_fabrics(const struct nvme_command *cmd)
 	return cmd->common.opcode == nvme_fabrics_command;
 }
 
+#ifdef CONFIG_NVME_VERBOSE_ERRORS
+const char *nvme_get_error_status_str(u16 status);
+const char *nvme_get_opcode_str(u8 opcode);
+const char *nvme_get_admin_opcode_str(u8 opcode);
+const char *nvme_get_fabrics_opcode_str(u8 opcode);
+#else /* CONFIG_NVME_VERBOSE_ERRORS */
+static inline const char *nvme_get_error_status_str(u16 status)
+{
+	return "I/O Error";
+}
+static inline const char *nvme_get_opcode_str(u8 opcode)
+{
+	return "I/O Cmd";
+}
+static inline const char *nvme_get_admin_opcode_str(u8 opcode)
+{
+	return "Admin Cmd";
+}
+
+static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
+	return "Fabrics Cmd";
+}
+#endif /* CONFIG_NVME_VERBOSE_ERRORS */
+
+static inline const char *nvme_opcode_str(int qid, u8 opcode)
+{
+	return qid ? nvme_get_opcode_str(opcode) :
+		nvme_get_admin_opcode_str(opcode);
+}
+
+static inline const char *nvme_fabrics_opcode_str(
+		int qid, const struct nvme_command *cmd)
+{
+	if (nvme_is_fabrics(cmd))
+		return nvme_get_fabrics_opcode_str(cmd->fabrics.fctype);
+
+	return nvme_opcode_str(qid, cmd->common.opcode);
+}
+
 struct nvme_error_slot {
 	__le64		error_count;
 	__le16		sqid;
-- 
2.47.1


