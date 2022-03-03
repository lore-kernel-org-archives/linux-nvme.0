Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85F2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CHiveUA1ib6yt3yralHpQUfLdOcJ5Wr1IxrQfv+iU7A=; b=glh0k0hN/r4stJ94Z/mnvsSNr+
	YRo5d/mywOq0YtvIV8iJMN0tU4vOIU9XRAgNQTdv1MB+pfnqj9yK2kG9Bp+bLo8fbLBWkLZMLP+TB
	+QS9rrEfwCuRBbn5/t64gFWSfQqQDFr2ojJ+ee8WvfuYZOURmNodDTibs6Wy72I+Th0KmpQLytSbU
	7yN68ZwrwgJ3e5ktVVWfZ2meUqQIfWWB+ZY5zJT8i1jUEky3tzYYBqZZNBu0UIKlRiAgoh+SMlDLR
	iW6mybXgFLCEd0YbOQ2F++GXB86fgzY3gdn85eMmNf64ZQQwEjJLSyG+BHZLil31hnApFmJ70/RIp
	alptNXTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPizU-0066nI-Pl; Thu, 03 Mar 2022 10:47:24 +0000
Received: from [91.93.38.115] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPizQ-0066mF-RY; Thu, 03 Mar 2022 10:47:22 +0000
Date: Thu, 3 Mar 2022 13:47:12 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.18
Message-ID: <YiCcsBPAQwEaDCH2@infradead.org>
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

The following changes since commit df00b1d26c3c3ff9dae4b572a6ad878ab65334e1:

  null_blk: null_alloc_page() cleanup (2022-02-27 14:49:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-03

for you to fetch changes up to 2079f41ec6ffaad9aa51ca550105b2228467aec7:

  nvme: check that EUI/GUID/UUID are globally unique (2022-02-28 13:45:07 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.18

 - add vectored-io support for user-passthrough (Kanchan Joshi)
 - add verbose error logging (Alan Adamson)
 - support buffered I/O on block devices in nvmet (Chaitanya Kulkarni)
 - central discovery controller support (Martin Belanger)
 - fix and extended the globally unique idenfier validation (me)
 - move away from the deprecated IDA APIs (Sagi Grimberg)
 - misc code cleanup (Keith Busch, Max Gurtovoy, Qinghua Jin,
   Chaitanya Kulkarni)

----------------------------------------------------------------
Alan Adamson (1):
      nvme: add verbose error logging

Chaitanya Kulkarni (9):
      nvme-core: remove unnecessary semicolon
      nvme-core: remove unnecessary function parameter
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use consistent zeroout pattern
      nvme-fabrics: remove unnecessary braces for case
      nvmet: use i_size_read() to set size for file-ns
      nvmet: allow bdev in buffered_io mode
      nvme: add a helper to initialize connect_q

Christoph Hellwig (4):
      nvme: cleanup __nvme_check_ids
      nvme: fix the check for duplicate unique identifiers
      nvme: check for duplicate identifiers earlier
      nvme: check that EUI/GUID/UUID are globally unique

Kanchan Joshi (1):
      nvme: add vectored-io support for user-passthrough

Keith Busch (2):
      nvme: explicitly set non-error for directives
      nvme: remove nssa from struct nvme_ctrl

Martin Belanger (2):
      nvme: send uevent on connection up
      nvme: expose cntrltype and dctype through sysfs

Max Gurtovoy (1):
      nvme-rdma: add helpers for mapping/unmapping request

Qinghua Jin (1):
      nvme-fc: fix a typo

Sagi Grimberg (6):
      nvme: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvme-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-rdma: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-tcp: replace ida_simple[get|remove] with the simler ida_[alloc|free]

 drivers/nvme/host/Kconfig         |   8 ++
 drivers/nvme/host/Makefile        |   2 +-
 drivers/nvme/host/constants.c     | 185 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c          | 192 ++++++++++++++++++++++++++++++--------
 drivers/nvme/host/fabrics.c       |   9 +-
 drivers/nvme/host/fc.c            |  22 ++---
 drivers/nvme/host/ioctl.c         |  35 +++++--
 drivers/nvme/host/nvme.h          |  31 +++++-
 drivers/nvme/host/rdma.c          | 117 +++++++++++++----------
 drivers/nvme/host/tcp.c           |   6 +-
 drivers/nvme/target/core.c        |   4 +-
 drivers/nvme/target/fc.c          |  12 +--
 drivers/nvme/target/io-cmd-bdev.c |   8 ++
 drivers/nvme/target/io-cmd-file.c |  17 +---
 drivers/nvme/target/loop.c        |   6 +-
 drivers/nvme/target/nvmet.h       |   2 +-
 drivers/nvme/target/rdma.c        |   6 +-
 drivers/nvme/target/tcp.c         |   6 +-
 include/linux/nvme-fc-driver.h    |   2 +-
 include/linux/nvme.h              |  11 ++-
 include/uapi/linux/nvme_ioctl.h   |   6 +-
 21 files changed, 532 insertions(+), 155 deletions(-)
 create mode 100644 drivers/nvme/host/constants.c

