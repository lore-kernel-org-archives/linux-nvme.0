Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494D2C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mB3slTFc7/RpdI3ntKG5jE11k93RlIl1l9dzcdZkbtA=; b=1H3vnVuZZWjQlOtb3cUCPdpt1E
	YLtNtOFxzUeAngvJ0X1Q9qZ+RiZF35Fo1tJjQ2Q6yeIb5TQNqP9zVfNxb0swd2u1O8q/ELqk5iZhy
	QBT/X3x6M4XsheFhopN+MevCiWo2SETsLjUoJGiZyvI++ro83nnKx1PRyrvTxEQUKczQEExutxdAx
	qE/wEKzykeXZ3AJnVmg3Wwy2FkyslBOXqkHkAHOCoWZXDBKaR56cP2p8UvFWHbVy8Ct3g5WVILxoQ
	UIhsjsV5kQFcHRKjnGESQn+vFI1CN90pdUXMPB3uUQq1n/kUtME/mlfGhzC3RgXyFF4CcqBjHAy5D
	/jJhBnSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXg-0000000A5OP-26E4;
	Tue, 21 Jul 2026 17:46:08 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXb-0000000A5LE-3eyO
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:06 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47f752b3423so2116741f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655960; x=1785260760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mB3slTFc7/RpdI3ntKG5jE11k93RlIl1l9dzcdZkbtA=;
        b=rjzKkvi5hyZBvukoR9A2o402bM1Bb8q4PdgUaVE1Z7JzcmFHpBFBw62MQ1NjJp164P
         NMmuPdxhOJ7s8LYQE+FXjaGOCs1Hw5425bZwZ7tZC4tPcZHSw2zOX+r5bCYLy5cxFZS/
         X+XeRsiHDYdDWWpLmLmguEVCBfAEp7TQdtR3fPZ/6Rs/CwiuNfm/JBSNcZyZtvNX2dP9
         HQLdkotR/tppKOc8MCDzS+0pCKyKuXvfUQKpQRuPRlyrGOqqaFjb3awUlz3j3RRWp3Kv
         7bnWGQzlKUugjBsByoD+fqcKYneVt+21RVVYe4orVaEbIV0eNwN7DIuVGI8RJPvyK+OR
         Erkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655960; x=1785260760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mB3slTFc7/RpdI3ntKG5jE11k93RlIl1l9dzcdZkbtA=;
        b=P7ELndnErP3uCZl61e/z1K81SJNw7vptijxo7+oZe8qlVy7njTHCVLvtZJ1AyX5Eub
         D0Je47RrM4S8R+5DbEZxXhYjVxIPwPYJQXXaytVw8rHCqhqhuOECI9D5l5VOtn8u09uj
         fGrSXWSXhQcsKLC7zoU3dEhhx8rNBqyQfhBLiK4akidiJazte0/yfutuW9BUPUNPuzb8
         ToiRYsPOIrQw79w76urvLWSBy9fksEiNukWP3GdQJZwfOLGgjJOwGqmo/BQ4mM7th1T8
         9Ou4ULAhYB9Sb3dX+5skye5ZXH6Aq0mmsN5mkwLoNLabB3SwcEDAeoj2wKA5BiUNWevD
         L3iA==
X-Forwarded-Encrypted: i=1; AHgh+RpEVjrMlDKXnQusRnfyW7INwON4rdnkoQsNXJkYhHW5FLRlG8P4/wtQzz6OTL9ogvkbpwf2oEibep3G@lists.infradead.org
X-Gm-Message-State: AOJu0YwZPHNQ/RZ7BxwoKFOuOClV7KiWyK8zqalxGK+QqVU6u+N6jVtr
	4tuOo/mocb8iN6NTDWjGw4yjd5X1SJqKPA595NITocXT/LYYf1v7oELZJzAFKVyqhw==
X-Gm-Gg: AR+sD13b8ZW9Ab8PpJ2sMy1qGFaaBXCrF/NhCWDGrVwy1vIEZF6HJJKmPhzzqcisA7w
	tXZDZ9ChVcxaecy5kmmQt3A8SqV97R+0xml1idM48hZkZKvniJKlk8dOJU0K6ZeEjawtckW80Y/
	VG24fLx85i+z4tmqoVlzpTU8PhcFsd4PjS8Sur3AnA+Q5zSdHOAL7Z5tEAoAiSigMk7/CQ9V36g
	LxTFJV3BHp7C44q1zt5nN44ZiVZ+wFY6pRsmX8kDTJsNYtJkgGKpOsGqIzbrNLETch0dJDMtPAd
	XKC5Xl8+yTMeiPKe07kbeZUhtzpkWYucvgaTzD6CFLhI1qG7FkscCUkOqfUr8O2Kx0mKsNTlknI
	ceeg6hcaCskr/0QN4NIr2nxbzTH6NYntu0y0rjt944uzNjh5mSdjFrJHchu2sSezm93Z/y2aMW/
	ie/wm96aEyL6rVvOrRF2cQUETkdFnzGubzOLrhwz7FXAq7JmI=
X-Received: by 2002:a5d:5d82:0:b0:472:aaba:faed with SMTP id ffacd0b85a97d-47f6232c345mr23371068f8f.31.1784655959771;
        Tue, 21 Jul 2026 10:45:59 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:45:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/8] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Tue, 21 Jul 2026 19:44:54 +0200
Message-ID: <20260721174502.111503-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104603_936070_C40FA296 
X-CRM114-Status: GOOD (  12.55  )
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
nvme-rdma retries one forever.  Restore BLK_STS_TARGET for these
failures (lost in the blk_rq_dma_map conversion, v6.17) and fix what
md and nvme-rdma do around it.

Whether peer memory can be DMA-mapped depends on the PCIe topology
between the two devices: the same buffer may map fine for one
array member or nvme path and fail for another.  Since v6.17 that
failure completes as BLK_STS_INVAL.

md deliberately ignores INVAL member failures (commit
f7b24c7b41f2) and accepts P2PDMA bios since v7.2-rc1.  So a peer
write to an unreachable member simply counts as written: mirrors
silently diverge, and with no member reachable the write still
reports success.  nvme-rdma never even sees the errno --
ib_dma_map_sg() returns 0 -- and reports a path error, which
default multipath requeues forever.

  1  blk-mq-dma: restore BLK_STS_TARGET (block; stable, v6.17)
  2  md: keep REQ_NOMERGE on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  6  md/raid1: skip futile retries on P2PDMA mapping failures
  7  md/raid10: same
  8  nvme-rdma: preserve the DMA errno, return BLK_STS_TARGET
     (stable, v7.1)

Routing: patch 1 block, 2-7 md, 8 nvme; independently applicable
(patch 8 takes the errno from dma_map_sgtable() in rdma.c, not
from patch 1).

The patches were developed with AI assistance (see the Assisted-by
trailers); all code was human-reviewed and tested (result tables in
the v2 cover, linked below).

Against v7.2-rc2; merges clean onto current master.

Changes in v3:
 - split the raid1,raid10 mapping-failure patch per personality and
   folded its completion-path checks into one branch (Logan)
 - much shorter commit messages, comments and cover (Christoph,
   Keith, Leon); repro description added (Christoph)
 - picked up Logan's Reviewed-by on 1, 2, 4 and 5; since his review
   only a code comment in 1 and 2 was shortened (no code change)

Changes in v2: new serialization fix (patch 3), submission-time
state bit, metadata scatterlist, WantReplacement dropped for
mapping failures -- details in the v2 cover.

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]

Mykola Marzhan (8):
  blk-mq-dma: restore BLK_STS_TARGET for unsupported P2P transfers
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1: skip futile retries on P2PDMA mapping failures
  md/raid10: skip futile retries on P2PDMA mapping failures
  nvme-rdma: return BLK_STS_TARGET for unsupported P2P transfers

 block/blk-mq-dma.c       |  6 +++-
 drivers/md/md.c          | 10 ++++--
 drivers/md/md.h          | 15 +++++++++
 drivers/md/raid1.c       | 73 ++++++++++++++++++++++++++++++----------
 drivers/md/raid1.h       |  2 ++
 drivers/md/raid10.c      | 66 +++++++++++++++++++++++++++---------
 drivers/md/raid10.h      |  2 ++
 drivers/nvme/host/rdma.c | 38 ++++++++++++---------
 8 files changed, 160 insertions(+), 52 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.52.0


