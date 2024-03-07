Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C123C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tD/ssNERxJQI70UUvC4Epr/lipFjoa17IHPR8YSIexw=; b=lIce6ShfsH6YIGuEu7DDdsv/tG
	TsmFE3nKVylvhV93Jl6QwrizToC/T794pxVgCNkQM+jHoZTcpJXM1+7rlOO8MH8HiaAsNWMcDfl3R
	94oEdnfb5pq1cSPB2G/h2DAVbgIHLDC9l00YDFSEANp6OpZPrh84Fng54xsvhfgMkFPEbhtKQLAHt
	Eo+BOppUlDgfD/FvnfJWOAY0TsjqoydMD/TxGNy1RlTJiYjc8+VSu3Ro6l+HOipXPVFdCtYCBiZhT
	L6TQJwHMU93zOvwZy2IO3W0J6IFgheSkBHTthu1eCI4bNs/VI1ScgQxYrxj+ZIUW9dD3tS1YF8yLA
	lWMd8C4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riG1k-00000005Mpv-3OdB;
	Thu, 07 Mar 2024 15:51:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riG1i-00000005MoN-0LSG
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:51:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFEBE616DB;
	Thu,  7 Mar 2024 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCC8C433F1;
	Thu,  7 Mar 2024 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709826680;
	bh=x5xtzGivL2SX5JfwYYUhN1lUC1MtnQR9DDMYpfTp4Qc=;
	h=Date:From:To:Cc:Subject:From;
	b=Hb5T2tuTeVyp3X/yRFwuTfYkkf4lzkhmVQgaR68Kiar5rV1NnsTDyyRIoEnBnl6ET
	 7BlPUlb5vkJMK10rm5X6HdAeQFhnbXnn5h4aCh06uVw7nzSq9YkUCd4PQ0IMXB60Lz
	 nlv1MEwgb/lxPsdTa3elrZyFoTzqekC6PD8qvBABJ/a16X4Iyp7yNdnL++Qf4mUVFx
	 Cto4TLMNAZVA1Cg9EKtQTXM+8qD8wmolxEiGHX0QEA16lYnmzDldJdZXwo8yOTazbu
	 ih0CpAvU7IjdmsMpq9HEc2Fy7io2l7IvVW0S9S3RFw+LbTGSZ/ySSEMP9HBQ5TUmqS
	 /ZcVy/5+Elzww==
Date: Thu, 7 Mar 2024 08:51:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.9
Message-ID: <Zenidge11HKo4JXr@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_075122_236521_09EE0489 
X-CRM114-Status: GOOD (  10.10  )
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

[resending; first one did not CC the list]

This is our first nvme pull request for the upcoming 6.9 merge window.

The following changes since commit 268283244c0f018dec8bf4a9c69ce50684561f46:

  nbd: use the atomic queue limits API in nbd_set_size (2024-03-01 09:08:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.9-2024-03-07

for you to fetch changes up to 7e80eb792bd7377a20f204943ac31c77d859be89:

  nvme: clear caller pointer on identify failure (2024-03-06 06:29:01 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.9

 - RDMA target enhancements (Max)
 - Fabrics fixes (Max, Guixin, Hannes)
 - Atomic queue_limits usage (Christoph)
 - Const use for class_register (Ricardo)
 - Identification error handling fixes (Shin'ichiro, Keith)

----------------------------------------------------------------
Christoph Hellwig (16):
      nvme: set max_hw_sectors unconditionally
      nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard
      nvme: remove nvme_revalidate_zones
      nvme: move max_integrity_segments handling out of nvme_init_integrity
      nvme: cleanup the nvme_init_integrity calling conventions
      nvme: move blk_integrity_unregister into nvme_init_integrity
      nvme: don't use nvme_update_disk_info for the multipath disk
      nvme: move a few things out of nvme_update_disk_info
      nvme: move setting the write cache flags out of nvme_set_queue_limits
      nvme: move common logic into nvme_update_ns_info
      nvme: split out a nvme_identify_ns_nvm helper
      nvme: don't query identify data in configure_metadata
      nvme: cleanup nvme_configure_metadata
      nvme: use the atomic queue limits update API
      nvme-multipath: pass queue_limits to blk_alloc_disk
      nvme-multipath: use atomic queue limits API for stacking limits

Guixin Liu (1):
      nvme-fabrics: check max outstanding commands

Hannes Reinecke (1):
      nvme-fabrics: typo in nvmf_parse_key()

Keith Busch (1):
      nvme: clear caller pointer on identify failure

Max Gurtovoy (8):
      nvme-rdma: move NVME_RDMA_IP_PORT from common file
      nvmet: compare mqes and sqsize only for IO SQ
      nvmet: set maxcmd to be per controller
      nvmet: set ctrl pi_support cap before initializing cap reg
      nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
      nvme-rdma: clamp queue size according to ctrl cap
      nvmet: introduce new max queue size configuration entry
      nvmet-rdma: set max_queue_size for RDMA transport

Ricardo B. Marliere (3):
      nvme: core: constify struct class usage
      nvme: fabrics: make nvmf_class constant
      nvme: fcloop: make fcloop_class constant

Shin'ichiro Kawasaki (1):
      nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()

 drivers/nvme/host/core.c          | 456 ++++++++++++++++++++------------------
 drivers/nvme/host/fabrics.c       |  22 +-
 drivers/nvme/host/multipath.c     |  13 +-
 drivers/nvme/host/nvme.h          |  11 +-
 drivers/nvme/host/rdma.c          |  14 +-
 drivers/nvme/host/sysfs.c         |   7 +-
 drivers/nvme/host/zns.c           |  24 +-
 drivers/nvme/target/admin-cmd.c   |   2 +-
 drivers/nvme/target/configfs.c    |  28 +++
 drivers/nvme/target/core.c        |  18 +-
 drivers/nvme/target/discovery.c   |   2 +-
 drivers/nvme/target/fabrics-cmd.c |   5 +-
 drivers/nvme/target/fcloop.c      |  17 +-
 drivers/nvme/target/nvmet.h       |   6 +-
 drivers/nvme/target/passthru.c    |   2 +-
 drivers/nvme/target/rdma.c        |  10 +
 include/linux/nvme-rdma.h         |   6 +-
 include/linux/nvme.h              |   2 -
 18 files changed, 356 insertions(+), 289 deletions(-)

