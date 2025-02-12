Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341EFC021A6
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zpnS5LdUZemikz3jDhlU3VLItf8J0nEAlg+TMLI01V8=; b=CI7UV1cbRk19iX3vtpG40mePX7
	qRUWCtHCoqyu6eM9gbWMZlP8r+EIouKkzENWVVD4Ah+BUk+JAw8e/v5CGIfK1qSg5Kf3xKxRFoqzZ
	QwIbd+zFwHGmyzaXiSPYwzotLu5z+d7iGIR8npV3r+Ywpw5EAN4bskgIWZmQlZ3v1uqLwPR2yC+Im
	D8bRKlS1nQMxcSMmDVFy72J3HGcbiIp60XkdXaWEAPpUp2AvNokgUKxjDLrTm3jz1IjZLdppQ+Iw7
	KaZcdd1gHvwJQUE4QvwvkIxpA7Gv2gGrsfARZQJ3Z3m3ViM7EzDs6fLd5r1rbQuZeIH/X75c+EN+2
	eQ1scJ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGKI-00000008H5i-1UsA;
	Wed, 12 Feb 2025 17:15:06 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGB7-00000008DPy-3uyq
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 17:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1739379935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hTuz8gGCmAz6/NBm7x2386wVyrsN941gsocYRg+g3+UXSUKRFTlU7284FPZkcYKxLK4pWRo3DqMRqevPRv1rXhICt+FsAZeZ6a7ySdt1Bm+pVT6qBjUNBqjelUbrN5p7ymdZfpTjvVLWazQ991PYC+Q6yoImo4+SR3LrQF/9k08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379935; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zpnS5LdUZemikz3jDhlU3VLItf8J0nEAlg+TMLI01V8=; 
	b=jiiALIKpOceXbs44izIR1/J28Rhiu+Cx/2ZZM0dVt6QGBCjx1JyJvt7AAeTSI9N1cOUhlPkIzpPH2Du7brk+hZhlghWoKP730j0UjGGwSNkaohd2TeYUYbo1/NmE2dtUCkijWKLZjvVVGPds37PLSCXLUCORycH/e5j1ZO12jdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379935;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zpnS5LdUZemikz3jDhlU3VLItf8J0nEAlg+TMLI01V8=;
	b=oWrklSyMJV7/9lYP4MoNQlK8kEEvvLyhL/rppCWn/mwCB3z46Qx6ddcYuR+NPhDm
	Z9vecKExVTh+9t4M8kuc8Q8eFuSwuHINgzoO+HOqYKzQuJGjFfPC4C+Lhyni3tssAU/
	WDuWfuOhmKkqZcbj6V8/cRy9/ftPPVyW/qGaePs60Xe+fu/VtlYJ3A2bJKpy4CfTgmC
	jznRkRkx2aeH9XmrK7vUfdx50F1YYzOlcu0b+KR1DO3E7drpqt24V4krH3KjBDZAhou
	z4+fr0Xhve+pysuvLG7/+Rjd2Fr+nniwHC7SJSIXBAq/wntlrgSjUR858dceKeGUTyT
	lDmNDDLbDA==
Received: by mx.zohomail.com with SMTPS id 1739379932694459.250015065458;
	Wed, 12 Feb 2025 09:05:32 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI P2P DMA
Date: Thu, 13 Feb 2025 01:04:44 +0800
Message-ID: <20250212170444.16138-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
References: <20250212170444.16138-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_090538_037138_E741174F 
X-CRM114-Status: GOOD (  15.94  )
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

The PCI P2PDMA code will register the CMB block to the memory
hot-plugging subsystem, which have an alignment requirement. Memory
blocks that do not satisfy this alignment requirement (usually 2MB) will
lead to a WARNING from memory hotplugging.

Verify the CMB block's address and size against the alignment and only
try to send CMB blocks compatible with it to prevent this warning.

Tested on Intel DC D4502 SSD, which has a 512K CMB block that is too
small for memory hotplugging (thus PCI P2PDMA).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 659ba85795a91..1a27688417b3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1982,6 +1982,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Controllers may support a CMB size larger than their BAR,
+	 * for example, due to being behind a bridge. Reduce the CMB to
+	 * the reported size of the BAR
+	 */
+	if (size > bar_size - offset)
+		size = bar_size - offset;
+
+	if (!IS_ALIGNED(size, memremap_compat_align()) ||
+	    !IS_ALIGNED(pci_resource_start(pdev, bar),
+			memremap_compat_align()))
+		return;
+
 	/*
 	 * Tell the controller about the host side address mapping the CMB,
 	 * and enable CMB decoding for the NVMe 1.4+ scheme:
@@ -1992,14 +2005,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
-- 
2.48.1


