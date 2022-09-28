Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCE6C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TEDFlJHmL9a2KPSXfgFDpNA0Vbh3Sy+MeZrvqFrMEJQ=; b=xW3bl2fMEl7glg4dGjnCtrdqa4
	DQKeixi7gLbvmKN4ccIATzl/22PfOfzqUD5IKD6Jxs5AILx4FKrtp1PnC16EEC7TbGcwtJMykNKUB
	rXOrjyE4s1H4VdjIfRDeZ9P7LeELvyCIluFUO0vbhW6X9opm3GRXJAVKwKchF8bTB5/mP71ffYjRf
	QPe7cqCIJBF7r2B5qpz4EfZ1SZ+Gwy/zKSCntzaI6P5FzmguaIfRMPEXz0s99GmCCExiBcKdKFw1c
	cWGRFm9FfPTk5eDfVLRLxxK0fjfpbgXcTejPczNYpXbfGkdIlST0ii6qfH/Wq+5uwEVB4CmWAt9SC
	vyVkeU1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaZR-00HH9h-CG; Wed, 28 Sep 2022 17:10:05 +0000
Received: from [2001:4bb8:180:b903:da25:1781:34d5:855b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaZP-00HH8p-9t; Wed, 28 Sep 2022 17:10:03 +0000
Date: Wed, 28 Sep 2022 19:10:00 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [GIT PULL] second round of nvme updates for Linux 6.1
Message-ID: <YzR/6HNJeGTDkxSQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 99e603874366be1115b40ecbc0e25847186d84ea:

  blk-cgroup: pass a gendisk to the blkg allocation helpers (2022-09-26 19:17:28 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-28

for you to fetch changes up to 84fe64f898913ef69f70a8d91aea613b5722b63b:

  nvmet: don't look at the request_queue in nvmet_bdev_set_limits (2022-09-27 18:51:50 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.1

 - handle effects after freeing the request (Keith Busch)
 - copy firmware_rev on each init (Keith Busch)
 - restrict management ioctls to admin (Keith Busch)
 - ensure subsystem reset is single threaded (Keith Busch)
 - report the actual number of tagset maps in nvme-pci (Keith Busch)
 - small fabrics authentication fixups (Christoph Hellwig)
 - add common code for tagset allocation and freeing (Christoph Hellwig)
 - stop using the request_queue in nvmet (Christoph Hellwig)
 - set min_align_mask before calculating max_hw_sectors
   (Rishabh Bhatnagar)
 - send a rediscover uevent when a persistent discovery controller
   reconnects (Sagi Grimberg)
 - misc nvmet-tcp fixes (Varun Prakash, zhenwei pi)

----------------------------------------------------------------
Christoph Hellwig (19):
      nvmet-auth: don't try to cancel a non-initialized work_struct
      nvme: improve the NVME_CONNECT_AUTHREQ* definitions
      nvmet: add helpers to set the result field for connect commands
      nvme-auth: add a MAINTAINERS entry
      nvme: add common helpers to allocate and free tagsets
      nvme-tcp: remove the unused queue_size member in nvme_tcp_queue
      nvme-tcp: store the generic nvme_ctrl in set->driver_data
      nvme-tcp: use the tagset alloc/free helpers
      nvme-rdma: store the generic nvme_ctrl in set->driver_data
      nvme-rdma: use the tagset alloc/free helpers
      nvme-fc: keep ctrl->sqsize in sync with opts->queue_size
      nvme-fc: store the generic nvme_ctrl in set->driver_data
      nvme-fc: use the tagset alloc/free helpers
      nvme-loop: initialize sqsize later
      nvme-loop: store the generic nvme_ctrl in set->driver_data
      nvme-loop: use the tagset alloc/free helpers
      nvme: remove nvme_ctrl_init_connect_q
      nvmet: don't look at the request_queue in nvmet_bdev_zone_mgmt_emulate_all
      nvmet: don't look at the request_queue in nvmet_bdev_set_limits

Keith Busch (5):
      nvme: handle effects after freeing the request
      nvme: copy firmware_rev on each init
      nvme: restrict management ioctls to admin
      nvme: ensure subsystem reset is single threaded
      nvme-pci: report the actual number of tagset maps

Rishabh Bhatnagar (1):
      nvme-pci: set min_align_mask before calculating max_hw_sectors

Sagi Grimberg (2):
      nvme: enumerate controller flags
      nvme: send a rediscover uevent when a persistent discovery controller reconnects

Varun Prakash (2):
      nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE state
      nvmet-tcp: add bounds check on Transfer Tag

zhenwei pi (2):
      nvmet-tcp: fix NULL pointer dereference during release
      nvmet-tcp: remove nvmet_tcp_finish_cmd

 MAINTAINERS                            |   9 +++
 drivers/nvme/host/core.c               | 132 +++++++++++++++++++++++++++---
 drivers/nvme/host/fc.c                 | 121 +++++++---------------------
 drivers/nvme/host/ioctl.c              |  15 +++-
 drivers/nvme/host/nvme.h               |  44 ++++++----
 drivers/nvme/host/pci.c                |   9 ++-
 drivers/nvme/host/rdma.c               | 141 +++++++++------------------------
 drivers/nvme/host/tcp.c                | 118 ++++++---------------------
 drivers/nvme/target/core.c             |   1 +
 drivers/nvme/target/fabrics-cmd-auth.c |  13 +--
 drivers/nvme/target/fabrics-cmd.c      |  18 ++---
 drivers/nvme/target/io-cmd-bdev.c      |  11 ++-
 drivers/nvme/target/loop.c             |  91 ++++++---------------
 drivers/nvme/target/nvmet.h            |   7 +-
 drivers/nvme/target/passthru.c         |   7 +-
 drivers/nvme/target/tcp.c              |  47 ++++++++---
 drivers/nvme/target/zns.c              |   3 +-
 include/linux/nvme.h                   |   4 +-
 18 files changed, 356 insertions(+), 435 deletions(-)

