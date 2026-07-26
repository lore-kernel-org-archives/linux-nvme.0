Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF7C531F9
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1Z37TstzxvLPhvEDUnNTL3PywZ4xjkcbPX0WwT+YK50=; b=w4D2nId6MMyHGOP88031JKxtGF
	gA5sliarNR5q3+YDtAPR0D3mHdZmvaYuebE4qvjKqKJjVReo8gJjG09R5pyIwp4YLdIjV7Nzrj1Ma
	yYFbMPpiCfxRtAeBFq5yxYvxhhUCvNSN1AdqmX+iWxwE5BmZkU9HJrzV4EkkzSS7TCbwUpCJSfHav
	mQrs3/4v5vsUsp+Gg4oNIszM92/zfK3tj9VsSHfkYhs18VCB7AVvjInfo5MbKfQHwLEkDSxDHCnV8
	eUB9Xbh6ToNvaGSPIyoQgl35sAy8Pu2VGNj5Dd3MLxn58ix28G9/sU7isi5UlrJ19YHb9EpOo9Lxd
	U3TWcr9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx5z-000000016vW-3F3X;
	Sun, 26 Jul 2026 11:32:39 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx5x-000000016ux-3SaN
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:39 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1648952f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065555; x=1785670355; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Z37TstzxvLPhvEDUnNTL3PywZ4xjkcbPX0WwT+YK50=;
        b=nMqYoGe780QPzqY/EmESrWPYmnlCWWttScUn/WYdd+UcOZNZ4EdVKiK91k12xiASkT
         sJYua9nzzBwP17ID9Ec6YsFRIksuNNF/FDBFO1E8AGbItysK6b9ZQN09GJUY8JRcgJXR
         WkHujFmf9P6/HYmVTHXo5k/Bw/BjtCUAdAGE1B0+GzI6LZNSaP4PEjoHH+Ja3pAuHl74
         DdeXgfDPDOTZrIVdZWV4ECxHbtD+F1wPwligDKxV2kFC8ia158/bwFDG+PHLliJgyRRo
         C8DXpTxjLZs66tt6aRzE2R4Ku1USVwG+vJkD5Woabjwta6hdX/Bspt//Lo9wds6rkqI0
         5lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065555; x=1785670355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z37TstzxvLPhvEDUnNTL3PywZ4xjkcbPX0WwT+YK50=;
        b=V/sQzlmeYzJpP79xgL4vwNsyfIXWVxg/NSsyVrV8wd8m+fQTpSz85+JBGB+gHK0dvC
         ENMQQsfv0XkIy9cGOMTSZrxKsU+888+UWUcs2tX0ci/akDbAjJhW76hBUOvttAvXIEGZ
         EjktpHTUHkIcn07S7VIiLRJ7QpQIoKi/QuauW2uPAwsHZgkDINzmabKImknY7nGOg6RA
         4RDPKbBmsSVs/qhpEfU3lYLedqOnUaeu2sK8zzWeNFq2T21UwteIC1Yd+3jCiJfK0VHh
         bHE44gqByj7xlICDEmJav+2V2iUNuFzEyYuil7zfH/TThP+ArzHXUkWQoI0tQtgTn1eP
         YCWg==
X-Forwarded-Encrypted: i=1; AHgh+RqL1pHduDs7OP4hnQeWMfU9FszAfBpShVKaaG+qjX6nbSISNu8wUvd5oU8v5Wh/vVgyZzGOd7q2XsK4@lists.infradead.org
X-Gm-Message-State: AOJu0YzZiy3dSD+EOk7HCB2t32dEDuQwe325JxIFHpdu2tjp5O0cVqLK
	Ft8SgVeUlMypNqSmkk8biySns3R4yYGfZhDmoHfcfM1BOHYEvrPKn96hSBMm45sfFg==
X-Gm-Gg: AR+sD10gVNHtvkmLrUs9etbisYUDlYvXqjIOFhsdjDiKTvbzYGpU9jxud6J2EFufU6W
	A/KeBuAz0NIGAQ5cSXIB7ZJUUl9hcxJCdcTIMrVfokstABgQ2BqJajFpXLkNFpAvMvM55t1dVRC
	AXbvgSw6pb1emI2eu9pe0Jf36XUIbkFfhz6NVjBcOxQP8pgwNgGYZ7y5sdB5rWNBiBDMteDYS8Q
	vUp2FUhRM6gh9VvBsI2IbKNDf2HDf7kNHtAGW+XYutxGCIwFceMhnGJZ7p/AecvyRXNK2jAPxGV
	Ya4hqDDx5w5zUJL8m1sj4j3hpRCtJQBtdtPgRKZAAqd7SyV1/49cBxhJ5dDAyBdkpqfGZ3AKy6v
	lWCuDrY8iKRqGU3y6UFlKYRbDhgx3U5VMLyO1Af8ko/7aRzOp5wPtlXKe3C7GD/M7ZudzCAoXRO
	cODnD4LHo9yZ0ud9EeKWnZ8EGdWKZRn0vxr4OSqvLamyD9iiX9C9w8MR1c5TaguEykFnaZjnina
	pQJVOfuWf4Plkht1m5cr/G+Y91nET+T/zu4IeklGA==
X-Received: by 2002:a05:6000:490b:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-47f9fc9c6c8mr6246245f8f.9.1785065554907;
        Sun, 26 Jul 2026 04:32:34 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:34 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 00/12] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Sun, 26 Jul 2026 13:32:17 +0200
Message-ID: <20260726113229.2154269-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043237_930949_E3C119F1 
X-CRM114-Status: GOOD (  16.25  )
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

md treats an unsupported P2PDMA transfer to a member as success, and
nvme-rdma retries one forever.  Whether peer memory can be DMA-mapped
depends on the PCIe topology between the two devices, and since v6.17
the failure completes as BLK_STS_INVAL: retryable for multipath and
deliberately ignored by md for member failures, so mirrors silently
diverge.

v1-v3 restored BLK_STS_TARGET for these failures and tagged P2PDMA
bios in md.  Logan Gunthorpe proposed a dedicated BLK_STS_P2PDMA
instead, so no consumer needs to know whether an I/O was P2P, and
wrote the core patches; v4 onward is built on them.  Patches 1 and 5
are his and keep his authorship.

  1  block: add BLK_STS_P2PDMA (stable, v6.17)
  2  md: ensure REQ_NOMERGE is set on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: factor out raid1_write_error() helper
  6  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  7  md/raid1,raid10: skip futile retries on P2PDMA mapping
     failures
  8  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  9  nvme-rdma: use ib_dma_map_sgtable_attrs() (stable, v7.1;
     dependency of patch 10)
 10  nvme-rdma: return BLK_STS_P2PDMA (stable, v7.1; needs patches
     1 and 9)
 11  nvme-rdma: ratelimit the map-failure error message (cleanup)
 12  nvme-rdma: factor out the scatterlist DMA mapping helper
     (cleanup)

Routing: patch 1 block, 2-8 md, 9-12 nvme; 7, 8 and 10 use the new
status.  Patch 1 alone stops the divergence and the dm-multipath
requeue loop; the nvme-rdma loop also needs 9-10; everything else
refines the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
stable) and 5 (refactor).  11 and 12 are cleanup only and can be
deferred if you would rather not carry them at -rc.

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

Changes in v6:
 - patches 7, 9, 10: picked up Logan's Reviewed-by; on 7 it replaces
   his now-stale Signed-off-by, as he asked
 - patch 10: the map-failure ratelimit conversion moves out to its
   own patch 11 (Logan); the stable note now names both prerequisites
 - new patch 12: the data and the metadata mapping share a helper
   (Logan's suggestion on patch 9).  Kept out of 9 so the
   stable-tagged fix stays minimal

Changes in v5:
 - patch 7: From: is now Mykola, at Logan's request; patch 8 follows
   for consistency.  Logan keeps Signed-off-by on both,
   Co-developed-by on 8
 - patch 8: raid10 declares bio up front and bi_status sits in a
   blk_status_t local in both files.
 - old patch 9 split: 9 is the mechanical sgtable conversion,
   10 the -EREMOTEIO -> BLK_STS_P2PDMA translation; both stable
   since 10 needs 9

Changes in v4:
 - new BLK_STS_P2PDMA (Logan) replaces restoring BLK_STS_TARGET; the
   R1BIO_P2PDMA/R10BIO_P2PDMA state bits are gone and the md changes
   shrink to completion-time status tests
 - blk_dma_map_iter_start() gets the explicit
   PCI_P2PDMA_MAP_NOT_SUPPORTED case (Logan's patch; v3 kept
   default: only)
 - write completions record the whole failed range as bad blocks
   instead of narrow_write_error()'s per-block retries; v3's coarse
   retry is gone -- the new status is deterministic, nothing to
   re-attempt

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]
Link: https://lore.kernel.org/linux-raid/20260721174502.111503-1-mykola@meshstor.io/ [v3]
Link: https://lore.kernel.org/linux-raid/20260722185841.449934-1-mykola@meshstor.io/ [v4]
Link: https://lore.kernel.org/linux-raid/20260723204206.76930-1-mykola@meshstor.io/ [v5]
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (2):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper

Mykola Marzhan (10):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  nvme-rdma: use ib_dma_map_sgtable_attrs()
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
  nvme-rdma: ratelimit the map-failure error message
  nvme-rdma: factor out the scatterlist DMA mapping helper

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 ++++++--
 drivers/md/md.h           | 15 +++++++++++
 drivers/md/raid1-10.c     | 16 ++++++++++++
 drivers/md/raid1.c        | 47 ++++++++++++++++++++--------------
 drivers/md/raid10.c       | 27 ++++++++++----------
 drivers/nvme/host/rdma.c  | 54 +++++++++++++++++++++++++++------------
 include/linux/blk_types.h | 10 ++++++++
 9 files changed, 134 insertions(+), 51 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0


