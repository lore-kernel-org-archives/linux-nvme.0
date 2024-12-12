Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50739E77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c0Y4ULoWkDVMIXjFWZsZqLL2tYBIYgjRCQODy6xQgdI=; b=TI12+sAlJRutj8hBW2Anxmw+EG
	gsBLecHnPAUSjlhB7ZGpjyOSNa/L+hSGA0gyKz30oXgY5YR94IGE11T6u8oRyLeHDld0XL6AK6/P4
	feM9aqAmhGn8w8Zm/CAUJfIcpda1sbz0/aj7Y7DPLar/8kC1LQ8+slZTW+m+IM76e6bqUH11I3JFg
	ZlOubHqUCbZ8aRQ9IKmg5Ll8zB0bLWjoGiC0Ogi6OmS/REm6YtLcP7iWzNvbSQFgkCKlg5tzMHlR4
	J4HkR2J42kLsv8Jsx0WJ1ZPDJGqZcrf2b2y7ra3HQ3xZ0SxDMGknc/53Ai+zfNsWA5t2Wj0OH6efj
	63fR3iGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhUN-00000000DMD-1iD6;
	Thu, 12 Dec 2024 11:36:15 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhTK-00000000CpU-24ug
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:35:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7653BA42774;
	Thu, 12 Dec 2024 11:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D92C4CEDD;
	Thu, 12 Dec 2024 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003309;
	bh=1NuFx3QMcc1tEVOkMLILvj2kCaplIcqdsykNR20gpaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COdsd6ul+OC7jL5rq13zpY1Z68/Y6HBTo+WRN1wJlFftPyDIlHqV+KjZnEV9iUMup
	 2EMjGAKzG0ioeLZvC1NYZ5vCi2zIj0yx/cwb7WcaPqsqHzvCtWemrohkbOkmVbk1+O
	 W/fpWm5WepewFjd/L202xgRmI5CmuL0hbDFLrUaHr2l5Q1iuyEzZ4sdJm7Y9RIceG7
	 ZGu4oeRNey9zJeK3HYc2227+Rm4AMXmsc8mRt74QRvNBm8xhQ5GE+Yd0GONoICJmsO
	 5z8WvwpE/Uboj20j92Ck4L0+UPc3dOlEdzBdOcUFpqVYQlU8jeg1qSdO5kkBi3UiAe
	 hC+TNOZGLotPQ==
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
Subject: [PATCH v4 01/18] nvme: Move opcode string helper functions declarations
Date: Thu, 12 Dec 2024 20:34:23 +0900
Message-ID: <20241212113440.352958-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_033510_660522_CAB4ACAB 
X-CRM114-Status: GOOD (  11.46  )
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


