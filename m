Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E3BE7718B
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=foUNybHYbIPDaLUpnJdjrHEk5KyJMzjt00F0suVSko8=; b=la6ph18SkVLT8T8iJl3g2mm3SS
	rht3Xt9eQRum3+jdha1z3GX30MiHt9tC/SdF3lHrtMeUBlGIMNBe/Vz8OND8pdGmtMnePfuKhdeZH
	IcxyEA/9DBab12XyZVp3XBTvti/8AWupfUDFWOC9/1A4RPvZk3hHEe1gL5aVNUuh9Ljm3V4S2Dgps
	Imaygy6FnZyf+r2Jtd+YcEtfJz+bX3gCXedIBiTAvk41DtUgkpECJ5cej09nf3Gv7EqEy5OT3Iiub
	IGLcZJywvHV8bltD+OuMpYoX5wNo31xNXRwBrTKl+Jk48GBskN/ZhXrOp4jbP6adV6P5fyWOLvxQB
	ULC3SK7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMnH-0000000DSe1-1S2k;
	Wed, 25 Dec 2024 08:31:03 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMn8-0000000DSQG-2ic6
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 08:30:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A918BA4031F;
	Wed, 25 Dec 2024 08:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A41C4CEE3;
	Wed, 25 Dec 2024 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115453;
	bh=7O20xJ1bzOCTYiTRyj88KWANfqYBEibS5Le/cdQeDco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIsDIfylPvIAj8Eo2LEsTPZOLdbdvgbGaMctsmmCgq+7HXrtSWlVH5vhwMJsHXiWS
	 e0d73J056n+IQpZ+u9c8lOGdzcPv43CwzTPOMqJWp66yxaORcX7k46t5Hll8Nr2/Tg
	 4rfNaNMV9zSr0nphSyjIqCo28x1yoGQ5abTekCJjigAc7QkkUOHJTBU1MBeAIDd7h8
	 +94vrCWOPeaM01oiql2iXg+ybBXScchjdtB7f2Y7NITBVesD7qXEH+jD3sT+L4Hhg8
	 877hxhCsOjf08r7AF/Q6khlE2kyvJILREmRX6ti5up9ACGzolyuL+g5AnlJE0zfgMG
	 EqWl+0043OQKg==
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
Subject: [PATCH v8 11/18] nvmet: Do not require SGL for PCI target controller commands
Date: Wed, 25 Dec 2024 17:29:48 +0900
Message-ID: <20241225082956.96650-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_003054_920911_CFB69F58 
X-CRM114-Status: GOOD (  16.20  )
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

Support for SGL is optional for the PCI transport. Modify
nvmet_req_init() to not require the NVME_CMD_SGL_METABUF command flag to
be set if the target controller transport type is NVMF_TRTYPE_PCI.
In addition to this, the NVMe base specification v2.1 mandate that all
admin commands use PRP, that is, have CDW0.PSDT cleared to 0. Modify
nvmet_parse_admin_cmd() to check this.

Finally, modify nvmet_check_transfer_len() and
nvmet_check_data_len_lte() to return the appropriate error status
depending on the command using SGL or PRP. Since for fabrics
nvmet_req_init() checks that a command uses SGL, always, this change
affects only PCI target controllers.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      | 27 +++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c91864c185fc..0c5127a1d191 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1478,6 +1478,11 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
+	/* For PCI controllers, admin commands shall not use SGL. */
+	if (nvmet_is_pci_ctrl(req->sq->ctrl) && !req->sq->qid &&
+	    cmd->common.flags & NVME_CMD_SGL_ALL)
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+
 	if (nvmet_is_passthru_req(req))
 		return nvmet_parse_passthru_admin_cmd(req);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a92e3a81b46..43c9888eea90 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1122,12 +1122,15 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	/*
 	 * For fabrics, PSDT field shall describe metadata pointer (MPTR) that
 	 * contains an address of a single contiguous physical buffer that is
-	 * byte aligned.
+	 * byte aligned. For PCI controllers, this is optional so not enforced.
 	 */
 	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
-		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
-		goto fail;
+		if (!req->sq->ctrl || !nvmet_is_pci_ctrl(req->sq->ctrl)) {
+			req->error_loc =
+				offsetof(struct nvme_common_command, flags);
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+			goto fail;
+		}
 	}
 
 	if (unlikely(!req->sq->ctrl))
@@ -1182,8 +1185,14 @@ EXPORT_SYMBOL_GPL(nvmet_req_transfer_len);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
 	if (unlikely(len != req->transfer_len)) {
+		u16 status;
+
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
+		if (req->cmd->common.flags & NVME_CMD_SGL_ALL)
+			status = NVME_SC_SGL_INVALID_DATA;
+		else
+			status = NVME_SC_INVALID_FIELD;
+		nvmet_req_complete(req, status | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -1194,8 +1203,14 @@ EXPORT_SYMBOL_GPL(nvmet_check_transfer_len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
 	if (unlikely(data_len > req->transfer_len)) {
+		u16 status;
+
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
+		if (req->cmd->common.flags & NVME_CMD_SGL_ALL)
+			status = NVME_SC_SGL_INVALID_DATA;
+		else
+			status = NVME_SC_INVALID_FIELD;
+		nvmet_req_complete(req, status | NVME_STATUS_DNR);
 		return false;
 	}
 
-- 
2.47.1


