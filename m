Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375ADC282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zDWXHHx+pXISa9q60CxSQFR4cpBhlRoObBjAqHHM1ag=; b=PCHdLy/TM64iBCVH3zFVt2sapP
	VcQY2RuakruwoLjiDINwbthA1IYvuMNcylNjuAfuduP+Cj9VK46xmWkM7ClbhIKBzaT+cKhwaY1i2
	cnngV6wplD1NH5oTdVg5LqRulwFWMfiKoFZeYwP+WFRNWzaiLrntL1sbDGgTAE8DAnvxKhH9EKXut
	PMbKy8UOCJqf6W0OL1F1ZbogOc3qKK6OjB/z4XaPC7x+89Ob/y056QRQsainBOho9sPvSFIZoV9tI
	MAFFRQz69rEas8AbIpPtPpf1gCjGjqggKY8GKuzWI9iSdGdtI68IGBjlA6Mehlwqrs2Eyq0HmuTPd
	5UXz3N7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7FM-000000021jK-31oq;
	Mon, 17 Mar 2025 09:59:00 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7E1-000000021SA-21KE
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 09:57:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BA851A46582;
	Mon, 17 Mar 2025 09:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237F7C4CEEF;
	Mon, 17 Mar 2025 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742205456;
	bh=nsrM1CtY6YU3hzhPdOol0YhIGRO8G1YUmy6/1RsPkKs=;
	h=From:To:Cc:Subject:Date:From;
	b=m5svwRelpXib5GUa36fkTSEoZWBAA/4MF3FQ+jiT6VJVAKmMHVnljlY9Tsd+x41S2
	 zmViLZM69ayi8VnsvbM8Q2LEvIxSGmYoSc4tDJ0GN0lyxyx5uBDKD+xAXJG7iBwlBL
	 pv8fy2I7mw/0LgDOOu4Hut7T6IwVSFoaLht+qx5pCoieGegKPxRMKq4M0a7tnx7HTJ
	 jNMCQUBzs/PUaERwle89iEkIEecN2qz2D2E/T3DE5sU17wsrl4IJUkz91vRkwiF1Hu
	 rfM4QZHhIMFOo3V7J5HbizM2W54X2qkYRXs8Tw/abX2CbM0yzJc2FRCpm8NErKj8oy
	 iewUA5RT9QIaw==
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: pci-epf: Always configure BAR0 as 64-bit
Date: Mon, 17 Mar 2025 10:57:04 +0100
Message-ID: <20250317095703.1661633-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=cassel@kernel.org; h=from:subject; bh=nsrM1CtY6YU3hzhPdOol0YhIGRO8G1YUmy6/1RsPkKs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKvf3xv/WSdyEMJ009R21VLQ37MzC5ebCt1d+2B1Uf/f 5PT2tbD1lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJVD1k+O/5tqQpv/vpr5l5 LRbTuuIa1z24++j/Z479G5v3bHE+aT+d4b+nk48bS75TxKtVi1SXLF9aEHn6d/GJrg0tXZEVm61 bj/IDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_025737_601577_6189F4FC 
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

NVMe PCIe Transport Specification 1.1, section 2.1.10, claims that the
BAR0 type is Implementation Specific.

However, in NVMe 1.1, the type is required to be 64-bit.

Thus, to make our PCI EPF work on as many host systems as possible,
always configure the BAR0 type to be 64-bit.

In the rare case that the underlying PCI EPC does not support configuring
BAR0 as 64-bit, the call to pci_epc_set_bar() will fail, and we will
return a failure back to the user.

This should not be a problem, as most PCI EPCs support configuring a BAR
as 64-bit (and those EPCs with .only_64bit set to true in epc_features
only support configuring the BAR as 64-bit).

Tested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Added Fixes-tag.
-Picked up tags.

 drivers/nvme/target/pci-epf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 0136df45ca275..a24f6549c0d15 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2096,8 +2096,15 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 		return -ENODEV;
 	}
 
-	if (epc_features->bar[BAR_0].only_64bit)
-		epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	/*
+	 * While NVMe PCIe Transport Specification 1.1, section 2.1.10, claims
+	 * that the BAR0 type is Implementation Specific, in NVMe 1.1, the type
+	 * is required to be 64-bit. Thus, for interoperability, always set the
+	 * type to 64-bit. In the rare case that the PCI EPC does not support
+	 * configuring BAR0 as 64-bit, the call to pci_epc_set_bar() will fail,
+	 * and we will return failure back to the user.
+	 */
+	epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 
 	/*
 	 * Calculate the size of the register bar: NVMe registers first with
-- 
2.48.1


