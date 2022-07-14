Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E7BC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PXZSyT7Qc60lozx/M4d1lcHQ0kN6+4N3VjfFxuRG5U4=; b=ycKXrt0D6LUNN8zRvcExS4lUOc
	v8Xi0Y5O5IlGR+EXEMEZj4pw5l7RUTFeu2Y6+nd1Yc/bjnG4735stFX28XdaNfDMo1HPYN0NkPWsL
	kggcM8r8cz3Fg/qW9TR2+abZvt9Ui1uUfJVaj+GBucIizFoZR9U0myaQJP7qubNxNHSFxR85Hz/lk
	+ZjAsenDMiR0T5k/UVHIJEokprFLNsICXarli9M+qM/JdA2+v5Xm65MY7W1NJhqreV4IG6qTsfbBE
	OhKD4w1X4hQ6ZkilgXp+eljFhNJrrXc4iV809fwGTWSgOBQ8s/nvol6RTB0pLlPe7wvq2RBge8t2Y
	zQTyNWZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzuu-00FEbM-Di; Thu, 14 Jul 2022 14:34:12 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzus-00FEZD-Fy; Thu, 14 Jul 2022 14:34:10 +0000
Date: Thu, 14 Jul 2022 16:34:07 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.20
Message-ID: <YtApX8HC+BcN3NvL@infradead.org>
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

The following changes since commit 3b56590b1715b998cb5c73a5bd2e9d340ccb42dc:

  rnbd-clt: make rnbd_clt_change_capacity return void (2022-07-06 07:38:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-14

for you to fetch changes up to 7b20ea4f3911c86bee698f1b23ba7f59ec890ceb:

  nvme-multipath: refactor nvme_mpath_add_disk (2022-07-12 17:37:31 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.20

 - add support for In-Band authentication (Hannes Reinecke)
 - handle the persistent internal error AER (Michael Kelley)
 - use in-capsule data for TCP I/O queue connect (Caleb Sander)
 - remove timeout for getting RDMA-CM established event (Israel Rukshin)
 - misc cleanups (Joel Granados, Sagi Grimberg, Chaitanya Kulkarni,
   Guixin Liu, Xiang wangx)

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: use in-capsule data for I/O connect

Chaitanya Kulkarni (2):
      nvme: remove unused timeout parameter
      nvme: fix qid param blk_mq_alloc_request_hctx

Guixin Liu (2):
      nvme-pci: use nvme core helper to cancel requests in tagset
      nvme-apple: use nvme core helper to cancel requests in tagset

Hannes Reinecke (11):
      crypto: add crypto_has_shash()
      crypto: add crypto_has_kpp()
      lib/base64: RFC4648-compliant base64 encoding
      nvme: add definitions for NVMe In-Band authentication
      nvme-fabrics: decode 'authentication required' connect error
      nvme: implement In-Band authentication
      nvme-auth: Diffie-Hellman key exchange support
      nvmet: parse fabrics commands on io queues
      nvmet: implement basic In-Band Authentication
      nvmet-auth: Diffie-Hellman key exchange support
      nvmet-auth: expire authentication sessions

Israel Rukshin (1):
      nvme-rdma: remove timeout for getting RDMA-CM established event

Joel Granados (1):
      nvme-multipath: refactor nvme_mpath_add_disk

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Sagi Grimberg (1):
      nvme-loop: use nvme core helpers to cancel all requests in a tagset

Xiang wangx (1):
      nvme: remove a double word in a comment

 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/nvme/Kconfig                   |    1 +
 drivers/nvme/Makefile                  |    1 +
 drivers/nvme/common/Kconfig            |    4 +
 drivers/nvme/common/Makefile           |    7 +
 drivers/nvme/common/auth.c             |  482 +++++++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/apple.c              |    7 +-
 drivers/nvme/host/auth.c               | 1017 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c               |  190 +++++-
 drivers/nvme/host/fabrics.c            |   94 ++-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/multipath.c          |    6 +-
 drivers/nvme/host/nvme.h               |   39 +-
 drivers/nvme/host/pci.c                |    6 +-
 drivers/nvme/host/rdma.c               |   14 +-
 drivers/nvme/host/tcp.c                |   13 +-
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   15 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  525 +++++++++++++++++
 drivers/nvme/target/configfs.c         |  138 ++++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  545 +++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/loop.c             |    8 +-
 drivers/nvme/target/nvmet.h            |   75 ++-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme-auth.h              |   41 ++
 include/linux/nvme.h                   |  213 ++++++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 ++++
 37 files changed, 3640 insertions(+), 68 deletions(-)
 create mode 100644 drivers/nvme/common/Kconfig
 create mode 100644 drivers/nvme/common/Makefile
 create mode 100644 drivers/nvme/common/auth.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 include/linux/nvme-auth.h
 create mode 100644 lib/base64.c

