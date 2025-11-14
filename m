Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F68CE7A8C
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=08+58ZzebwKsuhQT/cl7upv35I5GGIwTrUgrTtm/hRU=; b=A4Pgsq7Z8sLhBZ4boDQhd2u/Uo
	D4JjSP84qCKtdHlG9+Zk4dYUCfzhVJujOgWaFgIj724RiRs9jFD+IZZQ3gXDr7NUNonhCB72d1W9H
	Cja/JdLRoLqBrXm5Ktu2WCVnPB9ZMSIzEb5OXFF5tx/MxMbqd9dLQaMd3wGFthNLIt9vaxMmESZ9k
	G1Vry8GgjBJGQRVjvm0NakOGC60pqrgz92xblcg8d3W1GcWPJPJ4b/2J0N7nTTZwmyPMvbyoiucPw
	RquDUFfgNqQzxbegrFPXYPEnyPvd72V1XFyD6wNJXuNVan8D5QEDL/cyryPqtoO+tXaUSVOyW5pG/
	fEt52Jyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpmH-0000000BrIH-0xO8;
	Fri, 14 Nov 2025 09:07:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpmD-0000000BrHT-402U
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:07:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E02440478;
	Fri, 14 Nov 2025 09:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D052C16AAE;
	Fri, 14 Nov 2025 09:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111248;
	bh=y03enOMt6iDIjRulioZ2DnXep5g9PTvKHhme/ibbnVU=;
	h=From:To:Cc:Subject:Date:From;
	b=HORw+lPAABndqE3H9HqKikACuPnHahn4JvCgHSvPip9qIYSXXX2UKbJ+bIXyBwcEe
	 6omTzjePtjqw6C1EvhZ3m9moVH0EKgT5cqS8Lvw9/9qa81Yj/MctfTxztxyQBXE2u2
	 SELycBr9KeE9rDdbj3SsDLLcxSO1uBMwKrdtf5LphRkxwtxvQD/xluN8ZTbiwG+aSk
	 88+bG1KJEFOclotffguu5pFMk0lWZnrTkKojUDQvmc7yJq9a6JQ4/wY/wQpY8EGWcF
	 pJrIymXD8FQqIYFGX/sWjm0Zead+NATeZTk0muD7q5i37k4Q2cAggBmt31XtKA0ibR
	 LY5AexD75nZ2A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Fri, 14 Nov 2025 11:07:02 +0200
Message-ID: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_010730_032862_651ADF68 
X-CRM114-Status: GOOD (  10.85  )
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

Changelog:
v5:
 * Rebased on top of 8e1bf774ab18 ("Merge branch 'elevator-switch-6.19' into for-6.19/block")
 * Initialized p2p map to PCI_P2PDMA_MAP_NONE.
v4: https://patch.msgid.link/20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com
 * Changed double "if" to be "else if".
 * Added missed PCI_P2PDMA_MAP_NONE case.
v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
 * Encoded p2p map type in IOD flags instead of DMA attributes.
 * Removed REQ_P2PDMA flag from block layer.
 * Simplified map_phys conversion patch.
v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
 * Added Chirstoph's Reviewed-by tag for first patch.
 * Squashed patches
 * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
 * Reordered patches.
 * Dropped patch which tried to unify unmap flow.
 * Set MMIO flag separately for data and integrity payloads.
v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/

----------------------------------------------------------------------

This patch series improves block layer and NVMe driver support for MMIO
memory regions, particularly for peer-to-peer (P2P) DMA transfers that
go through the host bridge.

The series addresses a critical gap where P2P transfers through the host
bridge (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) were not properly marked as
MMIO memory, leading to potential issues with:

- Inappropriate CPU cache synchronization operations on MMIO regions
- Incorrect DMA mapping/unmapping that doesn't respect MMIO semantics  
- Missing IOMMU configuration for MMIO memory handling

This work is extracted from the larger DMA physical API improvement
series [1] and focuses specifically on block layer and NVMe requirements
for MMIO memory support.

Thanks

[1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/

---
Leon Romanovsky (2):
      nvme-pci: migrate to dma_map_phys instead of map_page
      block-dma: properly take MMIO path

 block/blk-mq-dma.c            | 20 ++++++----
 drivers/nvme/host/pci.c       | 90 +++++++++++++++++++++++++++++++++++--------
 include/linux/bio-integrity.h |  1 -
 include/linux/blk-integrity.h | 14 -------
 include/linux/blk-mq-dma.h    | 28 +++++++-------
 include/linux/blk_types.h     |  2 -
 6 files changed, 100 insertions(+), 55 deletions(-)
---
base-commit: 8e1bf774ab18157cb8041628f2661aa12e425914
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


