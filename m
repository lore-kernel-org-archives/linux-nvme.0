Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4805C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD66A23429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmDDs4r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD66A23429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GPE6OIaznsw4/+UM9brUM/2j4YAEtx+l9SRVoNC0U+Q=; b=mmD
	Ds4r2ODNC10p7pr2Rr0qr+i6y8aTivJdZXp7KlDjqzvxc+plWB+/eB7OiqLzCwSM9ByfMMgFeWRkz
	LeWJUpCie4oX/IXYs4cRnJz6Re6DFS99w1Jmq1DBBHoBRgJJwgVzuJhcZ9BzbjV7arYEEZaFeRjJc
	V8DQVK0iAvI4me03rT+JDg879zuE4M951rv5VBYtN0tiis9IvK510FfSfk/XW5A2GFKWTuhqOX5tB
	Emrf0iXbNquXTIthFt8g6yEOoKKff4prIQGlsmCj52oUHhanjG8Z5DKyXrbsQHPVTWkPaT1bZwVKV
	P5MsyULHMLETo/6EG/39+dWsBgl5heA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3m9H-0004Jk-Cx; Fri, 30 Aug 2019 19:01:27 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3m9F-0004Ja-Tl; Fri, 30 Aug 2019 19:01:25 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme updates for 5.4
Date: Fri, 30 Aug 2019 12:01:24 -0700
Message-Id: <20190830190124.11961-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Jens,

First pull request for 5.4. Note that we do have some more patchsets
in the pipe, but we'll have them settle first in the nvme tree.

Also, note that there will be a merge conflict with 5.3-rc fixes on
the nvme quirk enumeration from the Apple work-around patches from Ben
and the LiteON quirk cb32de1b7e25 ("nvme: Add quirk for LiteON CL1 devices
running FW 22301111"). The fix pretty trivial, as the quirks enums simply
need to increment.

I have the fixed series in a branch:

  git://git.infradead.org/nvme.git nvme-resolve-5.4-conflict

The nvme updates include:
- ana log parse fix from Anton
- nvme quirks support for Apple devices from Ben
- fix missing bio completion tracing for multipath stack devices from Hannes and
  Mikhail
- IP TOS settings for nvme rdma and tcp transports from Israel
- rq_dma_dir cleanups from Israel
- tracing for Get LBA Status command from Minwoo
- Some nvme-tcp cleanups from Minwoo, Potnuri and Myself
- Some consolidation between the fabrics transports for handling the CAP
  register
- reset race with ns scanning fix for fabrics (move fabrics commands to
  a dedicated request queue with a different lifetime from the admin
  request queue).

The following changes since commit 3532e7227243beb0b782266dc05c40b6184ad051:

  blkcg: fix missing free on error path of blk_iocost_init() (2019-08-29 09:59:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4 

for you to fetch changes up to bc31c1eea99de9a8e65b011483716236af52f7ed:

  nvme-rdma: Use rq_dma_dir macro (2019-08-29 12:55:03 -0700)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ana log nsid lookup when nsid is not found

Benjamin Herrenschmidt (4):
      nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
      nvme-pci: Add support for variable IO SQ element size
      nvme-pci: Add support for Apple 2018+ models
      nvme-pci: Support shared tags across queues for Apple 2018 controllers

Hannes Reinecke (1):
      nvme: trace bio completion

Israel Rukshin (8):
      nvme-fabrics: Add type of service (TOS) configuration
      nvme-rdma: Add TOS for rdma transport
      nvme-tcp: Use struct nvme_ctrl directly
      nvme-tcp: Add TOS for tcp transport
      nvmet-tcp: Add TOS for tcp transport
      nvme-pci: Tidy up nvme_unmap_data
      nvme-fc: Use rq_dma_dir macro
      nvme-rdma: Use rq_dma_dir macro

Minwoo Im (5):
      nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp
      nvme: add Get LBA Status command opcode
      nvme: trace: support for Get LBA Status opcode parsed
      nvme: trace: parse Get LBA Status command in detail
      nvmet: trace: parse Get LBA Status command in detail

Potnuri Bharat Teja (1):
      nvme-tcp: Use protocol specific operations while reading socket

Sagi Grimberg (9):
      nvme-tcp: cleanup nvme_tcp_recv_pdu
      nvme: have nvme_init_identify set ctrl->cap
      nvme-pci: set ctrl sqsize to the device q_depth
      nvme: move sqsize setting to the core
      nvme: don't pass cap to nvme_disable_ctrl
      nvme-tcp: support simple polling
      nvmet-tcp: fix possible NULL deref
      nvmet-tcp: fix possible memory leak
      nvme: make fabrics command run on a separate request queue

Tom Wu (1):
      nvmet: fix data units read and written counters in SMART log

 drivers/nvme/host/Kconfig       |   1 +
 drivers/nvme/host/core.c        |  37 +++++------
 drivers/nvme/host/fabrics.c     |  26 ++++++--
 drivers/nvme/host/fabrics.h     |   3 +
 drivers/nvme/host/fc.c          |  34 +++++------
 drivers/nvme/host/multipath.c   |   8 ++-
 drivers/nvme/host/nvme.h        |  36 ++++++++++-
 drivers/nvme/host/pci.c         |  99 +++++++++++++++++++++++-------
 drivers/nvme/host/rdma.c        |  53 ++++++++--------
 drivers/nvme/host/tcp.c         | 132 ++++++++++++++++++++++++++++------------
 drivers/nvme/host/trace.c       |  18 ++++++
 drivers/nvme/target/admin-cmd.c |  14 +++--
 drivers/nvme/target/loop.c      |  28 ++++-----
 drivers/nvme/target/tcp.c       |  24 ++++++--
 drivers/nvme/target/trace.c     |  18 ++++++
 include/linux/nvme.h            |   5 +-
 16 files changed, 379 insertions(+), 157 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
