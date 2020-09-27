Return-Path: <SRS0=Tdqk=DE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06565C4346E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 07:23:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99A5239E5
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 07:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E0Wv0P3q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdUcf1qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99A5239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SOF/9yuuL1qt6VK5FKqwZa6cy4icWoTAgphKjmMcby8=; b=E0Wv0P3qho23LXy6/clqsmzqS7
	Tw3OebsLTC8Kn/v6EMiVhoee5y3HSoIIU34rL3TGhzJz5FPlII9EhAPPLLQjKkUeDSVXtI1JkH73S
	O5zn7GSCnKNKSB6ZnKGAbJy9TAdzIMCxJo5t1CjQyBsEDqUVmmL9DQ89eXpiOyMr9DPE4ec5IUpTK
	qlOrG8qP+RfGhzcI/fo42aEzHxpPX/YQQXC6j8zIvFwORVt/w2eMO44qg0WdnAG+Hxir7HCyDJLZF
	zM3am4nf7KKn9nA4psTijzRCW3lmhTB2otyfV0amhxHfv4hEohOxCarQgW3U4iUumMqeFrYQAmndi
	8YLGkmlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMR2D-0002qM-QK; Sun, 27 Sep 2020 07:23:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMR2C-0002qD-2H
 for linux-nvme@merlin.infradead.org; Sun, 27 Sep 2020 07:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=36mN1mB4d5Gu6vgKrDnTuZBkOpRA6jqzrm+jMSZth4g=; b=gdUcf1qkpEy4ENvvyVdXFYH37s
 xTbtfR5rKSLM21D/vOHoiHpvEvs/5Hjsg2D68xTh1kYdmYpcbOwLAQDZdGpXykPUhUN2ff8pSJ/fu
 0ywGQY9LtXqapc/y69PG4jCm0sgrmCL8mNUL7gp3HQ4fFYEULnPnZ8MumI9GRhKZZh8+CYYBzv1wf
 9TIUVOOMGG9S3ethnB3sVuF4nTej3ufxlrILv08zpAl4MQVIxVeE0yHFhtCwiA0C8Zh3We8rZY9Kg
 aNAgocfOi4xQ7G2Jha7gOdkQ1U4XqxCgu8Pj6MKm4UisG3AhqSR40W+7QsPNheea8nUKVZsg+tmZw
 g2sasiJA==;
Received: from [46.189.67.162] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMR28-0001Es-4R; Sun, 27 Sep 2020 07:23:46 +0000
Date: Sun, 27 Sep 2020 09:23:43 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme updates for 5.10
Message-ID: <20200927072343.GA381603@infradead.org>
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

The following changes since commit 163090c14a42778c3ccfbdaf39133129bea68632:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-09-25 07:48:20 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-09-27

for you to fetch changes up to 21cc2f3f799fa228f812f7ab971fa8d43c893392:

  nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue (2020-09-27 09:14:19 +0200)

----------------------------------------------------------------
nvme updates for 5.10

 - fix keep alive timer modification (Amit Engel)
 - order the PCI ID list more sensibly (Andy Shevchenko)
 - cleanup the open by controller helper (Chaitanya Kulkarni)
 - use an xarray for th CSE log lookup (Chaitanya Kulkarni)
 - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
 - fix nvme_ns_report_zones (me)
 - add a sanity check to nvmet-fc (James Smart)
 - fix interrupt allocation when too many polled queues are specified
   (Jeffle Xu)
 - small nvmet-tcp optimization (Mark Wunderlich)

----------------------------------------------------------------
Amit Engel (1):
      nvmet: handle keep-alive timer when kato is modified by a set features cmd

Andy Shevchenko (1):
      nvme-pci: Move enumeration by class to be last in the table

Chaitanya Kulkarni (3):
      nvme: lift the file open code from nvme_ctrl_get_by_path
      nvme: use an xarray to lookup the Commands Supported and Effects log
      nvmet: add passthru ZNS support

Christoph Hellwig (1):
      nvme: fix error handling in nvme_ns_report_zones

James Smart (1):
      nvmet-fc: fix missing check for no hostport struct

Jeffle Xu (1):
      nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue

Mark Wunderlich (1):
      nvmet-tcp: have queue io_work context run on sock incoming cpu

 drivers/nvme/host/core.c        | 56 +++++++----------------------------------
 drivers/nvme/host/nvme.h        |  4 +--
 drivers/nvme/host/pci.c         | 35 +++++++++++++-------------
 drivers/nvme/host/zns.c         | 41 ++++++++++++------------------
 drivers/nvme/target/admin-cmd.c |  2 ++
 drivers/nvme/target/core.c      |  4 +--
 drivers/nvme/target/fc.c        |  2 +-
 drivers/nvme/target/nvmet.h     |  2 ++
 drivers/nvme/target/passthru.c  | 43 +++++++++++++++++++++++--------
 drivers/nvme/target/tcp.c       | 21 ++++++++--------
 10 files changed, 93 insertions(+), 117 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
