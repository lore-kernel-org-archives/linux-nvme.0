Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BECAC58E
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G/XFWaBt222BYI26euRpp69b8Zzl6pgRHRnLtWA3Fuk=; b=JKr/yUOthc0SrVfmTEpNeOnqzW
	fBKnvza44CGnm4jv82McK76T4ZPX+rCE84T91XP3NCDIL+PzW3xju34tdkeGM8qDLvahqhbmXVPTn
	eXE9Lqf3qVyhPB6wH8+5G6S0qOc/nX35TQLB5+L3wevlcubz0auiD+AZ0mGTCr36nX5zETxJ0rCjJ
	gcXSRYuF4Ayy6jskvKUdEwtyi09IXw2tEgxEBltBHICmxtBuNTasQjWezFNnYUVt+tULdWIP5aW+Z
	v33DCknE/im46rNgYlbaQJnFQ0IR3I5oAeF9WBIY0eyPWA1omUFaeszaqoYptdU9M5xW/2xt+kxrV
	uFIFHtkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1vD-00000008mkb-07Np;
	Tue, 09 Sep 2025 17:14:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvwQD-00000006h73-2dGG
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 11:22:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 10CE66021E;
	Tue,  9 Sep 2025 11:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED62C4CEF4;
	Tue,  9 Sep 2025 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757416920;
	bh=uLKgh/YTOEG7lRDETZIjV9MdddGsqfjptEVnUVoo7HA=;
	h=From:To:Cc:Subject:Date:From;
	b=T7hUoAlxbo7MUfZQYudnsB+f6wi6/pWj8K9MLJXg4Kb9+F7DnOVtTQg3dOBhqAVVh
	 zzgaMsvWBfxcLkY0/uixL+4jpX1hTR/OeaK4xAkcYSF/a0g2ANVzLEozqTt4Y4yJ0/
	 1Rx5hVIdD40Eaf3uk6CimQ+KQuDRPkRmSi1Xt2u4102VBbxGu9gyjsgAbQSmRRCRg2
	 hQjoKsaLcwmnSEDZlpsHI9VYj6NPueE4ac5jpWPKkEbNiVhxk5WN4UMzGsM7y2e1uI
	 hYwthxe5jHXq9UjvYlrfsg8bCXYtTffM2FH6EChAd0UXM6C2JfyL6TMIWYttOXxjhK
	 uLcnECUE8A2Lw==
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init callback
Date: Tue,  9 Sep 2025 13:21:22 +0200
Message-ID: <20250909112121.682086-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=cassel@kernel.org; h=from:subject; bh=pX/MpTonHapCoD9Ys3C3UTZE9fwAxfHE3GCmLlJrJrU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIO8G5cyxlyMGeK0IJdny9WnuiaL1LzJXUdp+k9G2HPO fVr5y0L6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEykMYGc63ynDnz1/60Ceo VIVn0qsLLQYFFQdUq3zv/t/yS7Haxovhf/ap+2d80kT4Tc5PfpqomtxsynPlkOCjzL3MGaXTZq9 mZQEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

For DMA initialization to work across all EPC drivers, the DMA
initialization has to be done in the .init() callback.

This is because not all EPC drivers will have a refclock (which is often
needed to access registers of a DMA controller embedded in a PCIe
controller) at the time the .bind() callback is called.

However, all EPC drivers are guaranteed to have a refclock by the time
the .init() callback is called.

Thus, move the DMA initialization to the .init() callback.

This change was already done for other EPF drivers in
commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
initialization to EPC init callback").

Cc: stable@vger.kernel.org
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373a..9c5b0f78ce8df 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2325,6 +2325,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 		return ret;
 	}
 
+	nvmet_pci_epf_init_dma(nvme_epf);
+
 	/* Set device ID, class, etc. */
 	epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
 	epf->header->subsys_vendor_id = ctrl->tctrl->subsys->subsys_vendor_id;
@@ -2422,8 +2424,6 @@ static int nvmet_pci_epf_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	nvmet_pci_epf_init_dma(nvme_epf);
-
 	return 0;
 }
 
-- 
2.51.0


