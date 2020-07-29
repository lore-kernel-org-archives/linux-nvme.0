Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C55C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:11:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A342075D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qw6kSjws";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hYCxpd8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A342075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p2qfOqUj2YIkQt9h0ipG38jEYi8PUMg7fZGg69RH5EU=; b=qw6kSjwsH5IusavomBOSqhpC21
	mTTN3t+gf5CmEwFMUqmIstNabWzBUUAKheSJ/AkNFIENCUYvdWYhR75pgS7Jo6xwiT6xiRVh0UmpR
	rWMiwrtlWAw2z9GPnmtm+W+0gC98GyQ5uJ7meKYGaqih0q+kmHqYsMSYk0sGi9x45/oqD0cIcDT0t
	NxezuXzkxQOMDT1CFALRddtfKZAsLJPCtus/MeV4KnvZajdgDGcD/YZdy4Uq+bSg2+hqY+WsNV7yK
	WX4bysSNdzJHycvMfmxY1GXdBlCQ0BdVTzoEszZ0+mh+K/HPD7c+DuIf1xJsylx+tiayJgaPuAdCL
	kzqmg+2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0pc1-0006XM-HB; Wed, 29 Jul 2020 17:11:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pbz-0006X4-Ma
 for linux-nvme@merlin.infradead.org; Wed, 29 Jul 2020 17:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=8x5+1sBZGgSeebNtxQXIZMi3XZqMO+qzdh4d6SFy7M0=; b=hYCxpd8zyFd4EIxRH5jxTf68BV
 db2mQgyUb6JAqdSj9U+spVmbx0W7og8+UdfNyVZjXp9DXGtzsSHk/W9scRYB+t9txLKBT+T6rtL0x
 W/YjljnE8EV/+57lRBiHjxxfmICcGyVNpSbCY6omHtCJt/qVCYO8dTVFE2OPzjhXcDJHGgZh1l0PO
 m1yXEU58xB7i5lWE6w6FeJExBEDKhCEpdaFkGtTIeDuSw4CMIDYv9L3AtaZ3ioQK9cuJCiAc5efar
 aqsp+qzCKCTvXxxsyyVgfRhxnQNqmDCRtL5yzQfN2nzZytKkHGrKCEUcGueZl9bO5UToppt4XN+Xv
 Y8g1wEBg==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pbx-0002cs-NE; Wed, 29 Jul 2020 17:11:26 +0000
Date: Wed, 29 Jul 2020 19:11:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme updates for 5.9
Message-ID: <20200729171125.GA21194@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


The following changes since commit c5be1f2c5bab1538aa29cd42e226d6b80391e3ff:

  bcache: use disk_{start,end}_io_acct() to count I/O for bcache device (2020-07-28 09:14:52 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.9

for you to fetch changes up to b6cec06d19d90db5dbcc50034fb33983f6259b8b:

  nvme-loop: remove extra variable in create ctrl (2020-07-29 07:46:28 +0200)

----------------------------------------------------------------
Baolin Wang (1):
      nvme: remove redundant validation in nvme_start_ctrl()

Chaitanya Kulkarni (6):
      nvme-core: replace ctrl page size with a macro
      nvme-pci: use max of PRP or SGL for iod size
      nvmet: use xarray for ctrl ns storing
      nvmet: introduce the passthru Kconfig option
      nvme-loop: set ctrl state connecting after init
      nvme-loop: remove extra variable in create ctrl

Dan Carpenter (1):
      nvme: remove an unnecessary condition

David E. Box (1):
      nvme-pci: add support for ACPI StorageD3Enable property

Hannes Reinecke (1):
      nvme-multipath: do not fall back to __nvme_find_path() for non-optimized paths

James Smart (3):
      nvme-fc: set max_segments to lldd max value
      nvmet-fc: check successful reference in nvmet_fc_find_target_assoc
      nvmet-fc: remove redundant del_work_active flag

Logan Gunthorpe (8):
      nvme: clear any SGL flags in passthru commands
      nvme: create helper function to obtain command effects
      nvme: introduce nvme_execute_passthru_rq to call nvme_passthru_[start|end]()
      nvme: introduce nvme_ctrl_get_by_path()
      nvme: export nvme_find_get_ns() and nvme_put_ns()
      nvmet: add passthru code to process commands
      nvmet: Add passthru enable/disable helpers
      nvmet: introduce the passthru configfs interface

Martin Wilck (1):
      nvme-multipath: fix logic for non-optimized paths

Randy Dunlap (1):
      nvme-fc: drop a duplicated word in a comment

Sagi Grimberg (5):
      nvme: document nvme controller states
      nvme: fix deadlock in disconnect during scan_work and/or ana_work
      nvme-hwmon: log the controller device name
      nvme-tcp: fix controller reset hang during traffic
      nvme-rdma: fix controller reset hang during traffic

Yamin Friedman (2):
      nvme-rdma: use new shared CQ mechanism
      nvmet-rdma: use new shared CQ mechanism

 drivers/acpi/property.c         |   3 +
 drivers/nvme/host/core.c        | 294 +++++++++++++---------
 drivers/nvme/host/fabrics.c     |   2 +-
 drivers/nvme/host/fabrics.h     |   3 +-
 drivers/nvme/host/fc.c          |   6 +-
 drivers/nvme/host/hwmon.c       |   3 +-
 drivers/nvme/host/multipath.c   |  35 ++-
 drivers/nvme/host/nvme.h        |  36 ++-
 drivers/nvme/host/pci.c         | 133 +++++++---
 drivers/nvme/host/rdma.c        |  99 +++++---
 drivers/nvme/host/tcp.c         |  27 +-
 drivers/nvme/target/Kconfig     |  12 +
 drivers/nvme/target/Makefile    |   1 +
 drivers/nvme/target/admin-cmd.c |  24 +-
 drivers/nvme/target/configfs.c  | 103 ++++++++
 drivers/nvme/target/core.c      |  77 +++---
 drivers/nvme/target/fc.c        |  30 +--
 drivers/nvme/target/loop.c      |  13 +-
 drivers/nvme/target/nvmet.h     |  55 +++-
 drivers/nvme/target/passthru.c  | 544 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/rdma.c      |  14 +-
 include/linux/nvme-fc-driver.h  |   2 +-
 include/linux/nvme.h            |   4 +
 23 files changed, 1209 insertions(+), 311 deletions(-)
 create mode 100644 drivers/nvme/target/passthru.c

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
