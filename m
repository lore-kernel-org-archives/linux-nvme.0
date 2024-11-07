Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C3FD4337D
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzqIdjsCiS6cIWwwB390ikHO12RkhCwtxFNjtkJpmCM=; b=kRfn54P5wsjXYie+Zupoha18fT
	w+AA7eWoQ8qHmStg/W13eYodx6UTFV9RYFI9bIan7jj/AnntlX1HmoBpZ3BiU6YDBcMIig4pryp9K
	G4/IJm88FWO61P3VDWqosqE2k1V3BajXneteSC8QVlxdQRI09/MAqIY2A85Cv6NEIoMHCFBWeRXfC
	MDeV+Y5aUj+bO0IyQV9azaOT9c+AFxKQamf0Z1e8TSC+QCyA95IPH/pwDTW5f/QqRksLNNvlEtpfc
	yq8fQP+Q1EMC5BQvxArnASxfSrEfPbqYlbkC1OKT3cReptVwQQuY4dnM6cdzu60GaeJbwEw89UmXh
	SZJOYoBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t95q2-00000007jcq-1J9T;
	Thu, 07 Nov 2024 16:58:30 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t95jw-00000007iy9-0pR0
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 16:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1730998325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lWTv7xDJvgDIrcBGGcdLtBEWdYLPBow45KwRuJd+AvFHjtmxE18OK6ZN5w6saJDwxVi9jYKP0tGIOmqbsg5oiACZrAVUGX4txQLK00EDCsuRy0hZnhVWp5fTcGdJpEem0oH4AhKej7JWr1MEoLR625aJ2Ab+alFkvQUWS0bo69w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730998325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qzqIdjsCiS6cIWwwB390ikHO12RkhCwtxFNjtkJpmCM=; 
	b=crN/74d6dPzUvFAtg1XfG8lo9TQAqBZ8CB9/imlYCwcPrsHzPeaUgO2lDNakMaXyH7hBZrMhzf2t0makK3Tr+9RCOAFVQdr76Xc3KGSGrJq5zjstjC7NZT79hBcWbn6lXA8bM5O2FQ85l2GA4dDWIijUxt4MCK5tjIzdCO608Z4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730998325;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qzqIdjsCiS6cIWwwB390ikHO12RkhCwtxFNjtkJpmCM=;
	b=A+TMt1FGEs7F+7X1Jdkt23CldBdl8Y0qlhY4XFKgZO1JTK1Bg6X+fT5cpr2bjwsq
	fLa73UE9pa5Url2h9GoNhfUx4FGvObOUNTfelvYZ3h7424GF25iOMYmLe8ErbFoO28W
	ZMfnI2UKSsIERCIUsI+rXFpXzqayH+da2HemJboI=
Received: by mx.zohomail.com with SMTPS id 1730998323777636.0274986216729;
	Thu, 7 Nov 2024 08:52:03 -0800 (PST)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Date: Thu,  7 Nov 2024 16:50:46 +0000
Message-ID: <20241107165131.3462171-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_085212_306670_72D18125 
X-CRM114-Status: GOOD (  19.96  )
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
is fixed by increasing the small dma pool segment size to
512 bytes. Testing via desync image verification shows that
it now passes thousands of verification loops, where previously
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
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 17 ++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..bbad25d15360 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,11 @@ enum nvme_quirks {
 	 * MSI (but not MSI-X) interrupts are broken and never fire.
 	 */
 	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
+
+	/*
+	 * Min. dma pool segment size 512 bytes
+	 */
+	NVME_QUIRK_SMALL_DMAPOOL_512		= (1 << 22),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..0782c9b1b4e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -141,6 +141,7 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	u32 small_dmapool_seg_size;
 
 	mempool_t *iod_mempool;
 
@@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	}
 
 	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
+	if (nprps <= (dev->small_dmapool_seg_size / 8)) {
 		pool = dev->prp_small_pool;
 		iod->nr_allocations = 0;
 	} else {
@@ -701,7 +702,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
+	if (entries <= (dev->small_dmapool_seg_size / sizeof(struct nvme_sgl_desc))) {
 		pool = dev->prp_small_pool;
 		iod->nr_allocations = 0;
 	} else {
@@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		return -ENOMEM;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
+	dev->prp_small_pool = dma_pool_create("prp list small", dev->dev,
+						dev->small_dmapool_seg_size,
+						dev->small_dmapool_seg_size, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
@@ -3063,6 +3065,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * a single integrity segment for the separate metadata pointer.
 	 */
 	dev->ctrl.max_integrity_segments = 1;
+
+	if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_512)
+		dev->small_dmapool_seg_size = 512;
+	else
+		dev->small_dmapool_seg_size = 256;
 	return dev;
 
 out_put_device:
@@ -3449,7 +3456,7 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
+		.driver_data = NVME_QUIRK_SMALL_DMAPOOL_512 },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.45.2


