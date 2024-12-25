Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE9E7718E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 08:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiKSdKslz65+vgsk+RazPiHilcyatjQH8CwHdFLU9+c=; b=vlL/mIDtmfNUnFaXKtdys2GfYv
	HWeVBPt7Av4FX7eJXMjHZGpNv8sJnJ8X1xdimHHl4l3/2meRZCkXFtVDq0/lOIMoRer9K62Mxc33D
	2wYeDVV9r5N4htOfqP7BxjvItoLRBCRYIqGJ621p6c/MKsJXaKeHICjgoLkE+Xosfa+uQECsOpR2W
	DATh98xOO2WyvZnaS6L45k7/4dQ41DydzSEuoaKF+sb99wQS87pcyDGLyupJcfXDWjm408ee7/M4d
	H1/uPeV7RoerrO0DFYVUx9L+5fIpE0lEVB3qNLYkV+Q2LJ+PXWxJNm+nMuFi5jKHjxbG0IkApj+pR
	5sfJtNKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMmv-0000000DSBV-35gn;
	Wed, 25 Dec 2024 08:30:41 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMmr-0000000DS9q-3WNH
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 08:30:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1E6BFA4031F;
	Wed, 25 Dec 2024 08:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1F1C4CED7;
	Wed, 25 Dec 2024 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115436;
	bh=QcsZ2eXp0y8LpgyHEuBlgIhISW+stJlEMf70fl8qcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osq5guKz0wGD8181pheDNKrqaMckYjxoZC0Iv09/bc0cp+1p1QDOfXIUII3LrJXg/
	 +S2LPB324828qRMMOeK26ZAYNgNRP55iYtalIuCQtxLpH3fP9/Lz2wsisSbbIsr4Cd
	 wJXM/wE/0Z4wAwgkiPJgFOyvU8MDDamf+XCjqNx+Tq+m24R2KE6+XArU5MmV4PXRql
	 bWSXJciIkUi5W3qMMBbL7ZwXlmGHqRPXc4io1znIUaMC/QIp9uGEgkV1jlmCfIECJh
	 98vnttNbLUo7GV1vKh0s5+IvZKYke3oa9dJqY8FyGH59UdP4qXKTDsnZqb+zSJo+kN
	 W+FM+xX61nFrw==
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
Subject: [PATCH v8 01/18] nvme: Move opcode string helper functions declarations
Date: Wed, 25 Dec 2024 17:29:38 +0900
Message-ID: <20241225082956.96650-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_003038_007368_E57A7CE4 
X-CRM114-Status: GOOD (  11.71  )
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


