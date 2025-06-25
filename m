Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463FDC7EE3A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucJIOXhLgw3NtO4XghnLlnCxyVfpahrCQS4I2zAFJuk=; b=HrPhgUgJ4tGiRa2bISujIHsEH3
	j7GtHhy36JK6ylUNMopm1MNsUwLe65xnwvLgrkbNcyDcdjMz09BODQPfnkl9HSxFw2fEr+QIrgwwt
	l8XYjHbsjMwzyRJg5OpgOOO8stRb5nhslGnIgbskuV6OzlkHjuaxdSOeenuxVONm2kLcqUCy/meKh
	euxB/FvGVkSbuOtIqmZi85/PTnE3psgo4+Qao8WBNvHgrTEFEtmL3g9KO0Ve5+JDw32Meaj6Wh7RJ
	thRLnB6tqe+LFF+sF+vV9vvVOmHfEBhmr4iIy6mxM4LVYDk43ReCSOv9I4RWU78TPSKnT++2XBNra
	aGFh9cFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT0b-00000009Hmj-3AS4;
	Wed, 25 Jun 2025 16:30:01 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPw-00000008V1T-0pGF;
	Wed, 25 Jun 2025 11:35:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Date: Wed, 25 Jun 2025 13:35:04 +0200
Message-ID: <20250625113531.522027-8-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
MIME-Version: 1.0
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

Having a define in kiB units is a bit weird.  Also update the
comment now that there is not scatterlist limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e8688840818a..14d4630fd370 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -38,10 +38,9 @@
 #define NVME_SMALL_POOL_SIZE	256
 
 /*
- * These can be higher, but we need to ensure that any command doesn't
- * require an sg allocation that needs more than a page of data.
+ * Arbitrary upper bound.
  */
-#define NVME_MAX_KB_SZ	8192
+#define NVME_MAX_BYTES		SZ_8M
 #define NVME_MAX_NR_DESCRIPTORS	5
 
 /*
@@ -413,7 +412,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  */
 static __always_inline int nvme_pci_npages_prp(void)
 {
-	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
+	unsigned max_bytes = NVME_MAX_BYTES + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
@@ -3367,7 +3366,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * over a single page.
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
+			NVME_MAX_BYTES >> SECTOR_SHIFT,
+			dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
-- 
2.47.2


