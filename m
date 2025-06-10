Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A22C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 05:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HVgBpv5sL2SuwQmKlYHcmWpggTZtVThIILcHaEoCTcM=; b=SqE4a0B1cXPA7c5gK111QJovf2
	/8z/qssxB1XIe4whqwLLjbN2DEqKL1zPwmDn0fphXP5CwbQD9snJUCpbC+JU/A6KF0z9j+BnEfG8L
	CdQsYai2rRqtz6yraDHMTht2HHUy9BjMYE2kljvW+BTgpVA8epe4Akt40X5HMAItCLxwXg460uFhq
	mjxBvEe7F+s6AWoc8jwdh12eEy9CE87uckpBtcIAJgVOyxee2sHdpQmerCxKejDO8EBmH2Aq9BjJw
	Eh/fA1r5X9bmwgx2Jl/xNHLveny7us9O/olBx6OjSBKDd6ZS36dDwcELqrKUYyl57JC0qkPglQFve
	Eht7dR/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrDC-00000005o3f-2dHi;
	Tue, 10 Jun 2025 05:07:50 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrDA-00000005nzz-2314;
	Tue, 10 Jun 2025 05:07:49 +0000
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
	linux-nvme@lists.infradead.org
Subject: [PATCH 9/9] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
Date: Tue, 10 Jun 2025 07:06:47 +0200
Message-ID: <20250610050713.2046316-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
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

The current use of an always_inline helper is a bit convoluted.
Instead use macros that represent the arithmerics used for building
up the PRP chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 735f448d8db2..0f07599e0980 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -57,6 +57,21 @@
 #define NVME_MAX_META_SEGS \
 	((NVME_SMALL_POOL_SIZE / sizeof(struct nvme_sgl_desc)) - 1)
 
+/*
+ * The last entry is used to link to the next descriptor.
+ */
+#define PRPS_PER_PAGE \
+	(((NVME_CTRL_PAGE_SIZE / sizeof(__le64))) - 1)
+
+/*
+ * I/O could be non-aligned both at the beginning and end.
+ */
+#define MAX_PRP_RANGE \
+	(NVME_MAX_BYTES + 2 * (NVME_CTRL_PAGE_SIZE - 1))
+
+static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
+	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -405,18 +420,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 	return true;
 }
 
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the lifetime of
- * the I/O.
- */
-static __always_inline int nvme_pci_npages_prp(void)
-{
-	unsigned max_bytes = NVME_MAX_BYTES + NVME_CTRL_PAGE_SIZE;
-	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
-	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
-}
-
 static struct nvme_descriptor_pools *
 nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
 {
@@ -3934,7 +3937,6 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
 
 	return pci_register_driver(&nvme_driver);
 }
-- 
2.47.2


