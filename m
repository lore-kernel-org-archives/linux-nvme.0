Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A74C531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=; b=FqZJA8mpWp9ZOiQZlFeCWM0BDd
	9U6ulSMZRcwXaw7eDVt7O3Vl6pIA1CJnHQ3wRlNHrD2vlRsBTx5QUggj6bMhZyyxITAg/2SNP7QdI
	dopxKk+gbXVxK/8ufuIXxHKa3Hjg6W45fl7lBQ80Xc29pxVsPrBFNifKtPBYThAh0IqmETQZXeyl3
	qmUVn0kkILY0dsUDzjjybTus5ElWRql7x270lzqM95CdGDQ6VBsGpoWCBAeQGDxOTjIahLoldUEpP
	SAgJQEtalMyp44Cpvm7QVp3CI4Uwfq1DnZw5Q58x2a0tEUchgYwMITj0ZmunwBl1WNXxQpcUuGX8U
	RjBcVk/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fu-0000000F3Ws-2IO3;
	Thu, 23 Jul 2026 20:42:58 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fr-0000000F3Vs-1pQG
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:42:56 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so947932f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839373; x=1785444173; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=HKY8P9ZT4m0JsLPmmFE8HqWZPUBv7Cr+Iiy1JotsnKN9ZlqWFF4m2V97TXlCQrXd5F
         vq+yIqf+HpOthVjcuSx3m4egp73uuzwCGnvuUgZyOVf9iU7M1vVYWmYMXilYOjD14FzU
         Xsb1KctpOVrYOSwJdbPNaCmPch47jxuH6kKZvCprI5swFSNPVJds2cPNGBrvwk8L/iBA
         /WiQztxL+gPwB6mFpzvX+IkdYmauZPncjOl23xAzvKW+8xTW5JFwK4nWfgQiyfq92RcW
         URqOqFRdJ+YxTm76/fX7xE6vcHc8GAGx9fgN8GCoYMStFP0DTmHUogEq56tA7K8V9MOb
         JJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839373; x=1785444173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=AlUgejEn7JgTT+7KIZz47yJmEM3ebyQzwyGD8IsYx0C7BWCCNF4vnePIM4hxkE33kg
         cRX1AczLi5b40L5hhm118ngx9M1U7BtZxgD6uRceLCsCH3EAvO7Wd/4Z+5QgZHz8VyQ1
         oEafwXKSGYSckJlOKfjBjCuitBqqknZoW/CDeXQzFyW9YdjO1NGlGCNyyy201PqcY7og
         U0n8m0UgDvkL4O63h4Mc8DnUEJJgFtNYdpz5XytDmz9HgODR5ayQzg9I7oBzECESmbH4
         6o1J7DVxyy1JMPfX+W50qvFfzjCUwef/NZf8s9LSspZAHMvBJ95LKwJBd4+68uKiVQ/B
         wPCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNdvrtrMdtInKbvNSU/aak97RO8zmffUkp+84nm2WXBY/qCy+hTNJ2gkYbPbp0hx+8bbhvfYO1n+4f@lists.infradead.org
X-Gm-Message-State: AOJu0YxXACVgIqJQDv03nT6T6lNMbWWEWcs/ouchBN+Ysi40kfo8/zIw
	B6X9mtsrlu9C3DqAZyJe63FAF57XbgdVlH/vsmVvBFSwS3klrUqp21dq85bTy1mAfw==
X-Gm-Gg: AR+sD12jRVY/d6LlYn55Cb/py9ju2o9P1Jj1PLf+77fJnVYBR1cxnEzhrNAgMDDVoEx
	sBs3UqhUsp2hpaWPS8fRZ593ktBsvwYU5GtIxUSqt36MYEWRWFmg75AFZN5GQ2MLJybt+eIRO+L
	ju+SAmkf/hiPzq+OWtufjSHxPD/OihWp8Yeqk5/sQR425jRZmECbDmg8MZTa401WH6DO9PqIkRC
	QQkXli7AXnSp9K5Tag+XoqTJN5lBGtWUSaffpAfEt7vj75U/b/d8MlNyWDKbh/XIh2LgDtLxIIY
	DpDJUtLXAJZbJZL+yNTwbZFqx1oq2mnva04frWf8L8GU9AV/XvGDHxNP+M5I0U4aAyA1E3dehyc
	fgyeHvgUOtuaEwEUKmzutL7rLMUaSC4bIyfs+fe3taALGLVPBs1JL9y/kxOqdWwtB0q5HPnLrtm
	tEJuu+JyQEip/kT2bMMXPYBWk4U+9q8G+JrGUZQtbnQBos5HqEKp8PZIxj2uXihxdqcW/yLL8da
	L5RCl17x4FM9UTSg7HVbbhBy7qxifj15sayWqcS9Q==
X-Received: by 2002:a05:6000:46d4:b0:47f:93b9:b76c with SMTP id ffacd0b85a97d-47f93b9b770mr1881409f8f.56.1784839373145;
        Thu, 23 Jul 2026 13:42:53 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:52 -0700 (PDT)
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
	linux-pci@vger.kernel.org
Subject: [PATCH v5 00/10] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Thu, 23 Jul 2026 22:41:56 +0200
Message-ID: <20260723204206.76930-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134255_512646_EB02086B 
X-CRM114-Status: GOOD (  14.28  )
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
wrote the core patches; v5 is built on them.  Patches 1 and 5 are
his and keep his authorship.

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

Routing: patch 1 block, 2-8 md, 9-10 nvme; 7, 8 and 10 use the new
status.  Patch 1 alone stops the divergence and the dm-multipath
requeue loop; the nvme-rdma loop also needs 9-10; everything else
refines the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
stable) and 5 (refactor).

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

Changes in v5:
 - patches 7, 8: From: is now Mykola (Logan's request)
   Logan keeps Signed-off-by on both, Co-developed-by on 8
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
 - read path: bi_status is evaluated before bio_put()

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]
Link: https://lore.kernel.org/linux-raid/20260721174502.111503-1-mykola@meshstor.io/ [v3]
Link: https://lore.kernel.org/linux-raid/20260722185841.449934-1-mykola@meshstor.io/ [v4]
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (2):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper

Mykola Marzhan (8):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  nvme-rdma: use ib_dma_map_sgtable_attrs()
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 +++++++--
 drivers/md/md.h           | 15 +++++++++++++
 drivers/md/raid1-10.c     | 16 +++++++++++++
 drivers/md/raid1.c        | 47 +++++++++++++++++++++++----------------
 drivers/md/raid10.c       | 27 +++++++++++-----------
 drivers/nvme/host/rdma.c  | 38 ++++++++++++++++++-------------
 include/linux/blk_types.h | 10 +++++++++
 9 files changed, 118 insertions(+), 51 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0


