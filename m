Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84FCD1356C
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qCSfEUxX1kivYoEN/pG87zG2xU+fc4uyPhwvg4kTeno=; b=d12/wTyyz27qb8DsUmvJ4RgOYZ
	t+/Hk3/GwIfvY1I7UKjKt2sId03eN7ffCobE2xf3taYfi+W6vd/NfIpJn8ODBbbtkGITxAH42nHgy
	iQHlkxtaAkZSy6u7QzeftQzhM61QEgjn1znJ0vGjwAjUKm21lByhy1H5kpfTVQnItWeOlEq6mUeUi
	BweW0cQE+2KCZHeBMdOekzdb9uynsJYxEqxRPh8nzCOJuQ3c5zDXtS28t5nULnElAmRE5tIGL36s+
	Bo8ntObkDJGqDwRf232+lvWJvy61/5D8+2voyI8R9rtIaV0EGi7ZM2nZzhrP3CvUCf+jg7L/bgfuc
	CzFuGDVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t55Dh-00000008TUF-0HAy;
	Sun, 27 Oct 2024 15:30:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54Ae-00000008L1g-1oTS
	for linux-nvme@bombadil.infradead.org;
	Sun, 27 Oct 2024 14:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qCSfEUxX1kivYoEN/pG87zG2xU+fc4uyPhwvg4kTeno=; b=kCytRYJvRj4+CjmCp7odEk4mLb
	6nbdgTRTnxexR1g+M4utJA4CsgvK1JBkyxnlFoZbosnQCJTMFKQksv1KqUP+zwiGDB8bYQRfVeFME
	QNxC1riJq5TRKbtzP+WnB20SdTXBg2sUKBoM75wlP/z6/bC7Taw4c3Z2pOXT0Lz8XLX/tedQKOlEe
	/uEv64Kk3dbSZL11oSv1LsAWLUAAq5VhnEUQF1r5E36Sb23dSLgqeq5rd+2lHyGD7DHUJ2M6iDaWk
	4sdRFj0S3KDvoQNT+/LxYuh2sKZsudZVkuiuk/v8TaXelLhW12DA3vekN36caYlcnwLVuMuCBJy/2
	SDYkJ+7w==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54AV-00000009QVN-0670
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 14:23:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A2CC5C5416;
	Sun, 27 Oct 2024 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319FEC4CEC3;
	Sun, 27 Oct 2024 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038977;
	bh=BINE0bzsOqI+RjXMn339mOpninDICNxaXannsg5oEKA=;
	h=From:To:Cc:Subject:Date:From;
	b=pd0BzzZLKEzBqB8FWM9UZHam4tYNjsnnks0WcWuSmuuGlWxovKjdQAiI80MVb2wGZ
	 MTG3Xte9Jh0NPOVe8g5i1zq0pO5fVaNHNx2Y5e677UAgwYHjtDxNvA9Zat2wJBBXiz
	 R9aUDLrTH2666bqNkqWn8CjaFttj2+pvGYC79+kM2RvXqapBiYUhaEBxX04LxMqBA5
	 nEFd2n+xRDKhnirU2/wPoC5KGRP0XTSFPNger8/n0w6gzVIWEHU+Kx5hRf7z0+eAnI
	 hxdNIMaJRWkRkHkRXtlZgB+O6cM86XADyzKCTloRhKNu3+iYzVgS1Hqy8Wx0zQnauc
	 6bI4K5B/nVNRA==
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/7] Block and NMMe PCI use of new DMA mapping API
Date: Sun, 27 Oct 2024 16:21:53 +0200
Message-ID: <cover.1730037261.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_142304_530553_A3B34263 
X-CRM114-Status: GOOD (  11.43  )
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

This is complimentary patchset to the series which adds new DMA mapping API [1].

In this series, Christoph converts existing nvme-pci driver to use new API, which
is wrapped by relevant blk-mq helpers, so future blk drivers can reuse them in
block layer specific structures.

This is posted as RFC as it is under heavy testing now, and presented
here to get feedback from the community and show another advanced use
case of the new API.

Thanks

[1] https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org

Christoph Hellwig (7):
  block: share more code for bio addition helpers
  block: don't merge different kinds of P2P transfers in a single bio
  blk-mq: add a dma mapping iterator
  blk-mq: add scatterlist-less DMA mapping helpers
  nvme-pci: remove struct nvme_descriptor
  nvme-pci: use a better encoding for small prp pool allocations
  nvme-pci: convert to blk_rq_dma_map

 block/bio.c                | 148 ++++++------
 block/blk-map.c            |  32 ++-
 block/blk-merge.c          | 313 +++++++++++++++++-------
 drivers/nvme/host/pci.c    | 470 +++++++++++++++++++------------------
 include/linux/blk-mq-dma.h |  64 +++++
 include/linux/blk_types.h  |   2 +
 6 files changed, 636 insertions(+), 393 deletions(-)
 create mode 100644 include/linux/blk-mq-dma.h

-- 
2.46.2


