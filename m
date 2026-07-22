Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B11C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Roft6Ikjq+qhKFFk0rGulNK01SEMvk3YKlHglgEZK0o=; b=4dxtdO4tgUkqYD+PfvLaDQHFTE
	ZtraofSZRQvRJfU0fxmxkKx3NFM7o46v2cCZIXo64NB0MYD/0r5K4tf77hcvItj9uQdHMKoXDA1Gy
	6tNocbGIDZGtLisvotXI4b17R+Il6nv2MDClukfatMMfnhgTHf9yduecScWaS2W8BkzzP3jPKtL9y
	wRZM+q0RvaTjhsHpNnEZDjpIZ/HvESFHAtE0Povj8k6dXmOKeAQHZhG+uGH/2q5FeZfXggwwy27m0
	Sg9skLq83wGzkLk3FkymGzUP9u5/wVChkSU1x0sZBNZ6IXjXwIWtBRrFdbe2Q5ba9ySKg/8gyXCX3
	2Fpp+elA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9n-0000000Caeh-29zN;
	Wed, 22 Jul 2026 18:59:03 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9k-0000000CadW-1tNJ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:01 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so99351195e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746738; x=1785351538; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Roft6Ikjq+qhKFFk0rGulNK01SEMvk3YKlHglgEZK0o=;
        b=Nb40xrrS8CUPeN1fy2ev+tsdCy2SrQYssbW6iA8659akEiQWcTr+02rJh3kUe0+QXJ
         Yytu176OuUTxdNIfhuiIoVNpX2bGP7NR3aOJEoamzMi+nvuunwNtO11va8OTjcxCs3d7
         HLtCa47umLts9noCrs/NjPn8weyOn+soiclCQTPaBB50/OsqHNeBLtqY6vE6+0l+UC+H
         1DETSXMPhB7/lTPqgXZJrUcCa0Ia1BJTAxDB0LRj7qhjDwk6BtO5Gr3ESWgjKG0fnq4p
         3n2DV2G+RMMYh+WS1a9aftc15xsBbYFPQxOGxgAuggFrxMVWqPv93f5v7K+QC6LDsfu1
         b6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746738; x=1785351538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Roft6Ikjq+qhKFFk0rGulNK01SEMvk3YKlHglgEZK0o=;
        b=m5S0MxNfPy7IT0al8fMDqacIG7jwjNM4lbiOSwlZ57xeCBTdpCJHGscGAML4aQphR4
         MKDcaqzA6+5DaeVI2BekmXM59zG6NjsUMU3v8P4gexd5UEOGqbWFy5s/1yFOxe2ZguUa
         BEwOD4E1kwCizYae6aYQvXMCPEpBB0iuS8nMaY/kBxom88UpTAKMJ/DHyN7GHS1EIv2n
         inb7ThsHTFKlPLnPmxFJskSA8uGfz9SIQE6kVKDa/ZsstlBtry1ynHIOrJtKNg0wSkir
         x5DDiy3sK1vFHnbAqX9eNmhI3CLQVLtyE+J81aiKSGSA8QPtAM4G5ft33QC96nSCPA9K
         yEsg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1g3sXCy44QmbOjOsrzXOyeedU1K9x91aK0tHcajwrI7HaDKBw0PbjQNfCkwWYHmMtRaPw0O8xaWB4@lists.infradead.org
X-Gm-Message-State: AOJu0YyIjegnSgisSNQoGpf95rFoqnD9ql8CduTiTiYh06EgS1i9RVPt
	ttNdxd9Ckyi4+Hw/9UiPZcaXYwKjuVM0vFN8DNRdgbKMvQ3x/SZGglMpf4640qGOOw==
X-Gm-Gg: AR+sD10910omVr/WeGL3G0u2JCyJiB0H6YQU3pT/e7Ax57BkOImVLyPcmm9lDVoEB5A
	PSmlUuiax1TS0e4R9GaCh91mKvAQr+B6ErQSKDu2y8IVNh+big/z2AQCIBTojrfrglk10fOSJ34
	0b98TTma2aOfCau2y7pWXlCkfa3MXsnasko+S9OkrKLoVWoOapScPo5dZjiR3cWWT7GIvTVzwLE
	1ELborV96qYVlkrzIUtuaavSoIqVlGNlVZSYblaGEvJy5YzfwaCUZM8yL9l7J+mrk7M+MJG3wpQ
	aeTVK9AtWApMBotbaDrFzYRUbFP+rzdpBuI0iQQxgjxrkw0h7HY5wTxkGi5BpBVTii8wrm+mphB
	Dw/PNkz/cLBlVKm/35p2stt8oHdegJQ1ocSvNUDUq5wQWF0cDkWNbHEC4gX+bzfrPhd6UH92r5F
	uWfeFtfPMAN9dhuvDUUvfU91l/XEV+iC6Wds4LyrhZwSbLtC0=
X-Received: by 2002:a05:600c:1c16:b0:495:5022:71b9 with SMTP id 5b1f17b1804b1-495502272f2mr281514875e9.33.1784746738206;
        Wed, 22 Jul 2026 11:58:58 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:58:57 -0700 (PDT)
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
Subject: [PATCH v4 0/9] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Wed, 22 Jul 2026 20:58:32 +0200
Message-ID: <20260722185841.449934-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115900_525719_A9DAF87D 
X-CRM114-Status: GOOD (  13.50  )
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
wrote the core patches; v4 is built on them.  Patches 1, 5, 7 and 8
are his and keep his authorship (7 and 8 with completion-handler
additions).

  1  block: add BLK_STS_P2PDMA (stable, v6.17)
  2  md: keep REQ_NOMERGE on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: factor out raid1_write_error() helper
  6  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  7  md/raid1,raid10: skip futile retries on P2PDMA mapping
     failures
  8  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  9  nvme-rdma: return BLK_STS_P2PDMA (stable, v7.1; needs patch 1)

Routing: patch 1 block, 2-8 md, 9 nvme; 7-9 use the status patch 1
adds.  Patch 1 alone already fixes the divergence (md stops ignoring
the failure) and the multipath retry storm; the later patches only
refine the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a) and carry no stable tags.

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

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
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (4):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA

Mykola Marzhan (5):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 ++++++--
 drivers/md/md.h           | 15 ++++++++++++
 drivers/md/raid1-10.c     | 16 +++++++++++++
 drivers/md/raid1.c        | 48 +++++++++++++++++++++++----------------
 drivers/md/raid10.c       | 26 ++++++++++++---------
 drivers/nvme/host/rdma.c  | 38 ++++++++++++++++++-------------
 include/linux/blk_types.h | 10 ++++++++
 9 files changed, 120 insertions(+), 49 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0


