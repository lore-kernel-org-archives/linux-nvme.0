Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C93C433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BBB206A5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VSgDoKjM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzuZWERv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BBB206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C8vgs4hM4U7oa2mgBI1iiiMq2MgawlYS7hBmnZW/CUA=; b=VSgDoKjMZtNJxZZfdhixNx2Uvp
	IzvhkmPYWEqANCLRNDTNSSJotJQiBXJxqYFi8mecL2FzBQM95EbOZl9KHaP3L4W+oqUTVV6pm5DYX
	vyrzS9+9Dv+pFeDp8NQPFaLxIPemg0q0PrkEI/6ggbbdICkw3nGNd65n7jgs3dIRWpk+oLY4BUwl9
	KAPq8ZFyRpPkDDHWjzneOgIbQW70ZT0ZylUwWHZlcZ0f7grXli35pxYrIj9nWop+bOm8o/hL8UESA
	8L39iXeuHeQiou84cfs1YQuz4QDxIiMaZJLVt9NZlOvryMguRuvVqUthgHI3+I1VoV5DhBLhIdK6g
	E7ScnWUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jttQH-000346-PW; Fri, 10 Jul 2020 13:50:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jttQG-00033U-5p
 for linux-nvme@merlin.infradead.org; Fri, 10 Jul 2020 13:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=eQuysGzWXzyhpllcK8Em7fWTw+q4T9JNCBzSXh1+kRA=; b=GzuZWERvgHlCK/e77+poaR/Ev1
 0XynIgp1x0UBdDYDofj6qK+5B301wGzDK/040nTDXDVjfGKmfBfHJ8hTJ7Y2YeLmZY8ggpRJCcCOy
 N/uqfgqJH6A036iFJuSedY2KHQFl6f0UIEn86IhA8QkuZQhzeErFmCWcDbax64O4+yF15IpSnnVq6
 OfU83sqh9jCS28kzGA0jMftZtYvHJ0LcEvh3drh35keY1O2eC0S+I8AboXkRHZm79HBYR+pP+hCJk
 lSwJL7ZIvFQ9ahBrjpsdL1SPZ4BvEKGxw/zMv19NIFViG9RI2/V3b70FqiwIlPpevJCOee1FK6pLj
 8AvWQiVw==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jttQD-0004Nz-Ei; Fri, 10 Jul 2020 13:50:38 +0000
Date: Fri, 10 Jul 2020 15:48:26 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Subject: [GIT PULL] first round of nvme updates for 5.9
Message-ID: <20200710134826.GA537445@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

below is the current large chunk we have in the nvme tree for 5.9:

 - ZNS support (Aravind, Keith, Matias, Niklas)
 - misc cleanups and optimizations
   (Baolin, Chaitanya, David, Dongli, Max, Sagi)

The following changes since commit 482c6b614a4750f71ed9c928bb5b2007a05dd694:

  Merge tag 'v5.8-rc4' into for-5.9/drivers (2020-07-08 08:02:13 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.9

for you to fetch changes up to 3913f4f3a65ca9ed6ba7e4678fff10a6e7b42dbd:

  nvme: remove ns->disk checks (2020-07-08 19:15:20 +0200)

----------------------------------------------------------------
Aravind Ramesh (1):
      null_blk: introduce zone capacity for zoned device

Baolin Wang (6):
      nvme: use USEC_PER_SEC instead of magic numbers
      nvme-pci: remove redundant segment validation
      nvme-pci: fix some comments issues
      nvme-pci: add a blank line after declarations
      nvme-pci: use the consistent return type of nvme_pci_iod_alloc_size()
      nvme-pci: use standard block status symbolic names

Chaitanya Kulkarni (5):
      nvme-core: use u16 type for directives
      nvme-core: use u16 type for ctrl->sqsize
      nvme-pci: use unsigned for io queue depth
      nvme-pci: code cleanup for nvme_alloc_host_mem()
      nvmet: use unsigned type for u64

Christoph Hellwig (1):
      nvme: remove ns->disk checks

David Fugate (1):
      nvme: document quirked Intel models

Dongli Zhang (3):
      nvme-pci: remove the empty line at the beginning of nvme_should_reset=
()
      nvmet-loop: remove unused 'target_ctrl' in nvme_loop_ctrl
      nvme-fcloop: verify wwnn and wwpn format

Keith Busch (2):
      nvme: support for multiple Command Sets Supported and Effects log pag=
es
      nvme: support for zoned namespaces

Matias Bj=F8rling (1):
      block: add capacity field to zone descriptors

Max Gurtovoy (2):
      nvmet-tcp: remove has_keyed_sgls initialization
      nvmet: introduce flags member in nvmet_fabrics_ops

Niklas Cassel (1):
      nvme: implement multiple I/O Command Set support

Sagi Grimberg (5):
      nvme-tcp: have queue prod/cons send list become a llist
      nvme-tcp: leverage request plugging
      nvme-tcp: optimize network stack with setting msg flags according to =
batch size
      nvmet-tcp: simplify nvmet_process_resp_list
      nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs

 block/Kconfig                   |   5 +-
 block/blk-zoned.c               |   1 +
 drivers/block/null_blk.h        |   1 +
 drivers/block/null_blk_main.c   |  10 +-
 drivers/block/null_blk_zoned.c  |  16 ++-
 drivers/nvme/host/Makefile      |   1 +
 drivers/nvme/host/core.c        | 301 +++++++++++++++++++++++++++++++++---=
----
 drivers/nvme/host/hwmon.c       |   2 +-
 drivers/nvme/host/lightnvm.c    |   4 +-
 drivers/nvme/host/multipath.c   |   2 +-
 drivers/nvme/host/nvme.h        |  50 ++++++-
 drivers/nvme/host/pci.c         |  59 ++++----
 drivers/nvme/host/tcp.c         |  73 +++++++---
 drivers/nvme/host/zns.c         | 254 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/admin-cmd.c |   2 +-
 drivers/nvme/target/configfs.c  |  16 +--
 drivers/nvme/target/core.c      |   2 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/fcloop.c    |  29 +++-
 drivers/nvme/target/loop.c      |   1 -
 drivers/nvme/target/nvmet.h     |   5 +-
 drivers/nvme/target/rdma.c      |   3 +-
 drivers/nvme/target/tcp.c       |  13 +-
 drivers/scsi/sd_zbc.c           |   1 +
 include/linux/nvme.h            | 134 +++++++++++++++++-
 include/uapi/linux/blkzoned.h   |  15 +-
 26 files changed, 862 insertions(+), 140 deletions(-)
 create mode 100644 drivers/nvme/host/zns.c

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
