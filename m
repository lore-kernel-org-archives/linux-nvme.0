Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414EECFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 04:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWXAmHvXn4vCpATTyiYW6ts8HAnNGwtjMWKq5UIzamQ=; b=f9wcw6xVQbmoZB3Dz/AsdeQ2p6
	DPZWr2JkdjURGvT9UQmsyj9b7QXLF4VlXBW1HS75HTualPkejyykX+3AcF8QJPcbYNDOPLBHEHoaN
	gPDikMymFdgrynGUfcmUUjZkhISmIq/9QcHLJPLY7DVRrpadQsrjhcniiKXLYfOoVafS1/cOg0TwM
	0f06N7czE6d6+jrrjePkXAPLK9GWEZypc+3rLo6QTbBPvOMuUzbx1udRr1AMBq+o5KoZmOvqoIQcM
	c8X84HA2w8Z3WLl8Xi2O4HU0PFFM4tUDPaydjfPuUbKwkyeaF0paKy5of+s6HASIDC4F3hY84wXAc
	b4l8kVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbI-00000001FmB-0iLH;
	Mon, 07 Oct 2024 04:44:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbC-00000001Fjd-22oa
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 04:43:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A0C3C5C5B8F;
	Mon,  7 Oct 2024 04:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A49BC4CECF;
	Mon,  7 Oct 2024 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276237;
	bh=ksVCnorPjWn7+AyFB7R0NeXDZPsR2eZvsmvQ/R3OnJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI3mIYwaOgSApf8p5+di9x584jUdgCpNG/mpOyYjW5/o379m7Kt4/yxGUG4pTXyLv
	 X34LeUK67xZFsdFgtTiXS8XagLNUba5vRr3Q5sN8a513B8YyzXLxYepuS55uHWhgf7
	 Ascrknql9LYK2ew1Im+gatjFsp3zBCnbSGmvkhqrmAuIsOybuU8O+FuEJpfBkDGpzz
	 Gq1xd+qCyQLoznx1YTqeGmrBaOTLqDZ0UEg1JABH8LJtViL7xZKmC/JGB0At4IuWrq
	 sjyi26kl99KZtPLVFzJW/03yRLNvRs+vPXvMBFBH7EOZq2zmMCF0qq77L4Nj+eOHPl
	 aNwlcROvIC9vQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 2/5] nvmef: export nvmef_create_ctrl()
Date: Mon,  7 Oct 2024 13:43:48 +0900
Message-ID: <20241007044351.157912-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007044351.157912-1-dlemoal@kernel.org>
References: <20241007044351.157912-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_214358_596505_89EB65E6 
X-CRM114-Status: GOOD (  12.64  )
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

Export nvmef_create_ctrl() to allow drivers to directly call this
function instead of forcing the creation of a fabrics host controller
with a write to /dev/nvmef. The export is restricted to the NVME_FABRICS
namespace.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/fabrics.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 432efcbf9e2f..e3c990d50704 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1276,8 +1276,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
 				 NVMF_OPT_DHCHAP_CTRL_SECRET)
 
-static struct nvme_ctrl *
-nvmf_create_ctrl(struct device *dev, const char *buf)
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf)
 {
 	struct nvmf_ctrl_options *opts;
 	struct nvmf_transport_ops *ops;
@@ -1346,6 +1345,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	nvmf_free_options(opts);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(nvmf_create_ctrl, NVME_FABRICS);
 
 static const struct class nvmf_class = {
 	.name = "nvme-fabrics",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 21d75dc4a3a0..2dd3aeb8c53a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -214,6 +214,7 @@ static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
 
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf);
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.46.2


