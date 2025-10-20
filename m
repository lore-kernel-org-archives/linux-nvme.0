Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC61DCCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WIJ9/ZuOeP//JKKAcvUsNlSp1zGrfDBBMrKLnJhIkCY=; b=mD1GBN+Foh2AT6XyQs4DwJH7IL
	quAvHOG63GX5IktapM1o3ClnXc4EKQ3TbR+a8hpRSgnuVYewiXR7DVmWXkmAlyentURs0fzb1ZQLK
	U7umoF/pG7y+CO6/KJ7mwGEVok6ufUlMWZ37IWEsuJ6R6JW6AZhLDR18DL7xdzttdH3cAbfrc5s/+
	HorUYE5Ah1XQVXMpIhXicQD3VSZqUdNDIn4ViCPvvu8FHCSuB6tiNqd7pixP4XJmmq0S9wEVs2mg3
	/QODNhka82YBtEzcp7RQAtiro33HYKGIeXQEQrYNX0U+6u2lJBAYztLdk1NnIXcTGq1xzuALRFaOV
	B9PO7hoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFa-0000000EOoU-1xC6;
	Mon, 20 Oct 2025 17:00:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFZ-0000000EOnw-3Lsn
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 Oct 2025 17:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WIJ9/ZuOeP//JKKAcvUsNlSp1zGrfDBBMrKLnJhIkCY=; b=T/lZRFyE7/89rBCA2Il6qiU6L2
	Kf5fP++DgbpAT8rcLOs9nFQ8v0jWfhUSXKB+h4pIH0/Tl1l4lyC7JDgj9ldozuqtj4hIgs0n2IA8k
	hAr7sW1F359LFgmcYsbZumT08rHieYAiHobGgJ0sELtA4qKsod3g9uLjm82UWliZcY/gfKy/DN+BZ
	VpBrLgq1/9RRhjDiREd2c9Q2/Zx+61yck1v2HNYo3np8a6LXiM2mj/7pJRN8JX6aV2izdb1qAkS4Y
	UUY+jkQeFyyuNZgI6ptOnX787zI3h/cHesPFWBruU1xSKrxsP9mmxttwuu75Qf5IHwslRedQlGAwC
	o4EKCQ/Q==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAsNp-000000001MT-3X03
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 16:05:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3A85436E5;
	Mon, 20 Oct 2025 17:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0393BC4CEF9;
	Mon, 20 Oct 2025 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979628;
	bh=aDeOnEEz1nETobkR0liGykS0l8wmYPsfShAs2ltzD7w=;
	h=From:To:Cc:Subject:Date:From;
	b=naKhHO642wpE6pJC8jUqPZgMFbjxkebP1+tixYGLmX5nENZioJ/daM/nUGEc7DskT
	 eQjfLka959SMZlj/bj2szpSo9I2JUoNKEOaEOylFI8c/AIYjF9se1BKzjx7tJmds3v
	 ZGAKSrifgiAX2Zeb97ZcBfnPOhj0cBhis9PUgyvmusF8HkxmzuCtqaXeA9lHfRTF2O
	 Qgh1tbyDSsX0DGggMWV5E5YI/UY+ZxffSoZNmiUZ1xTEvOFBFHEZzLNoo2vBdVMFjY
	 qM1WvYJWDE6innT8ar4vyx5cFqPQ79Oz7EON2h4oT6Abf88RhXVUcwqktWKcFjhy0m
	 t8wzAXfYQNadw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Mon, 20 Oct 2025 20:00:19 +0300
Message-ID: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_170518_203778_893B8BF5 
X-CRM114-Status: GOOD (  10.41  )
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
v2:
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

 block/blk-mq-dma.c            |  8 ++++---
 drivers/nvme/host/pci.c       | 50 +++++++++++++++++++++++++++++++------------
 include/linux/blk-integrity.h |  7 +++---
 include/linux/blk-mq-dma.h    | 12 +++++++----
 4 files changed, 53 insertions(+), 24 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


