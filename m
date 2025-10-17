Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD73CCD184
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 05:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DHLt0UU4E3CqVoDTpa1rJewPekEcRy/1gcJGJ5CrewI=; b=SNWx8Eb94a5KA0gBB6kh4hOjFC
	a+VKTHJad73xJ4tRexzSowWSXZZ5WE529m8U9eSRfE+WeeM2m/pwyZObAmjI6gxIo3BzkYQw35/v+
	/ea8pLzOuOjvOmM75PbA6E4uuF+iLHrljWoSiOf/QfzD2Gs5Ud1CLIXEM6W2Y1SU+2//NS0Rb/QM7
	9phxT8gc2kIhQMtZdgiXgZ5fFyEE6UGxM5z9cWRfOm2sxSwO/dceQu56DJ/veNug8/PnKhmdBx/5m
	tXChVm13LtROc2flMMsvm0SW8hB3bqoS/OqC9N1bLBGnvH/43E395dPnSOKri4rpHqX/UViFBYJi0
	z6uIhrbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4Y-00000006csn-36TX;
	Fri, 17 Oct 2025 05:32:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4V-00000006csM-44xf
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 05:32:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2DDAB4A258;
	Fri, 17 Oct 2025 05:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3A1C4CEE7;
	Fri, 17 Oct 2025 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679130;
	bh=OV1AjrdPFJ65x1uyW5xexn0OsRfhPacIT0WgaVlO9TA=;
	h=From:To:Cc:Subject:Date:From;
	b=mXMH7hn7t9bF4evf7iPbPkR1R+H4mM9cDRvMZf4U+xZr/1SJVcwsnB7BrwnnQE9uL
	 7NQdrmdz/25BU73Fgi60Z71xVAkn7XSLtJhbcejTw2CW8PD+B/q8XcBy5IMElSlHN4
	 b+DU4RMiJBBNr1zG41bubClIzVg2njffCx6fxVWLd1UQmHxEub1P1vP1UTYZ3bKbXw
	 bKpoKdjr2Rp+osTr4mG+jfgVTOLEzndfahLFfrPPuBpevAG/7owhp6JitshobCOk5J
	 QA0MvxPkFET5wQBQ/yPHk57iNF7QlwM+FjjLcC0gpBH5NzqUE7WwWbTF64FwxEG76Y
	 F5CTEaAO6Jq3A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] block: Enable proper MMIO memory handling for P2P DMA
Date: Fri, 17 Oct 2025 08:31:57 +0300
Message-ID: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_223212_049128_E2566A5B 
X-CRM114-Status: GOOD (  10.42  )
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
v1:
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
Leon Romanovsky (3):
      blk-mq-dma: migrate to dma_map_phys instead of map_page
      nvme-pci: unmap MMIO pages with appropriate interface
      block-dma: properly take MMIO path

 block/blk-mq-dma.c            | 12 +++++++++---
 drivers/nvme/host/pci.c       | 18 +++++++++++++-----
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  3 ++-
 include/linux/blk-mq-dma.h    | 14 +++++++++++---
 include/linux/blk_types.h     |  2 ++
 6 files changed, 38 insertions(+), 12 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


