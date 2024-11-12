Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E303DD32D97
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nooNrk0pdLGb6HpWRiivYxPtImtREYw4ohNgd/wPIVM=; b=aqiz8OAhtC8JQCJXbEWJ6MI0Li
	KXgxu0GOlWDI9xTOPELMdPoyyhxBWu/PaX386d4ca4Ef1svlX8qg6+fl3czVrhYKRr+2h7Dn9Qbbw
	5BG1VMIMwhU69+LdwiUwxK4S683jSWt14+gJzNC6YAdp+yh5l5VSQsjrMzRYvSRxj5USDew0eu4CL
	2k75vArQIGzvC1KmoLHO2TWRj2xRETmmshF0GU3XGUz3w4B0yufXDkS75qhlaCFNG2Imn48GE11OT
	0a79q0p0SRGhZrhFLEwTS1IlEMldGAff0jo6C+o9uK1ZmbhYHG5uEeMLryTOstCQXTUgS5Tf8nIPo
	SDiDk5Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAwvi-00000004mHO-0DMI;
	Tue, 12 Nov 2024 19:52:02 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAwvf-00000004mGr-0D0Y
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 19:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731441112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aRtgj7mr2WNC/5zk/fp43UyVx8wy31cxZ/1Dp4vSKbS1DhkwoLHEhQpGkRa9g48VSlj4tmZXWxb/Bogrsby4m8IpUM2lWnTTbAT5MOqBF92y1fzag/V4crhWU2iWxT2t7BELeSVhr9Ro2TFIlxQaewyytvaQrWe+Bz04SIdm5B8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731441112; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nooNrk0pdLGb6HpWRiivYxPtImtREYw4ohNgd/wPIVM=; 
	b=jqTblEQgIDj7cq0oGMLfJbrAkKU+v1Yq+bP7zoc+liUK04wySJ/GICZoKNHCjESMChYHI40sbgJTA2PcFuH5JYkYOKyPxG/NNO7D0NNwOVODKSiWQEmQBQcIvfOhFefgQp1MuyOdTJi3cbF3nnzZFoTeVyvDDp72cHSOJjWdzDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731441112;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nooNrk0pdLGb6HpWRiivYxPtImtREYw4ohNgd/wPIVM=;
	b=XdDW8jpfXsigiE8D60e0eWVpedR5DrKMIMmaVF4nHSRy+Bdka0zRh4DxG5BZWfDo
	TlBbtn19fSzuXyS4RoVAR24IS9bQ+B0M8B/+6gSfQ+SdewD9ojOw4v+CydAwEz+3Up+
	AiJhFcoiI5ql2JrqSMEguCj043pX1v6z5A/oFPNo=
Received: by mx.zohomail.com with SMTPS id 1731441109569554.7931799757025;
	Tue, 12 Nov 2024 11:51:49 -0800 (PST)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Date: Tue, 12 Nov 2024 19:50:00 +0000
Message-ID: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_115159_169106_4710EEBF 
X-CRM114-Status: GOOD (  17.58  )
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

From: Robert Beckett <bob.beckett@collabora.com>

We initially put in a quick fix of limiting the queue depth to 1
as experimentation showed that it fixed data corruption on 64GB
steamdecks.

After further experimentation, it appears that the corruption
is fixed by aligning the small dma pool segments to 512 bytes.
Testing via desync image verification shows that it now passes
thousands of verification loops, where previously
it never managed above 7.

Currently it is not known why this fixes the corruption.
Perhaps it is doing something nasty like using an mmc page
as a cache for the prp lists (mmc min. page size is 512 bytes)
and not invalidating properly, so that the dma pool change to
treats segment list as a stack ends up giving a previous
segment in the same cached page.

This fixes the previous queue depth limitation as it fixes
the corruption without incurring a 37% tested performance
degredation.

Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..61bba5513de0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,11 @@ enum nvme_quirks {
 	 * MSI (but not MSI-X) interrupts are broken and never fire.
 	 */
 	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
+
+	/*
+	 * Align dma pool segment size to 512 bytes
+	 */
+	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..6fcd3bb413c4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		return -ENOMEM;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
+	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
+				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
@@ -3449,7 +3449,7 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.45.2


