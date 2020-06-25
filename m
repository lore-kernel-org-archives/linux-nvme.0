Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB5C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:04:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5043A2078D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AxhHtiuk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmrGiSe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5043A2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ghUSwR9GeUQGzPPddRevCVUyKzknAf86jXYNIpG6UdM=; b=AxhHtiukeyMPSNNu3XYuTFJs+G
	LcFrFJ7piO1r73g1dNVYyIu8jUrDwPq55qs6XNZe3h2P1TSyQNG15zzdL6s6CNlkXyPjjFFAtOJ94
	U/5nlvsxtAlPmC9h8z7s4Q2W/XbXILtl0cDjjM9wmAX+vyKEVm8aeGpF0E01L5RoqYdZ2quifpE7D
	VUwDNBnNeJ0JMk39z3Mm7LDFpbq+U2tuxkEgUjOL9IIFI9mxpcpji6502g6sw5KtqfcJ9pE+CslMC
	f2Frnp6A/jeiuEwWFWlgCFux3dCErxkOxAE4V6ES+alrtgnPzTDgYEcXO4PHUlAB9Jpuz1oeSLTqA
	I3/i3Fiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jon5R-0003I7-FO; Fri, 26 Jun 2020 12:04:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolR4-0006f7-3f
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Ovbcs12mvJLszoemDpWBQMsw9noi17CuGO1me0ZW8EI=; b=GmrGiSe0Cn0dLfIls2yj5qr3YB
 yfIGj/KxWmRTkfLnu+S9mrQgFWaPZqQU8QRtbclgttgsiL0FZLEyFt0Qd3WWzPZ7SmoBvAlVcGlzZ
 LhNf7BzzANmBWrL9YA1OyfjrfwPI21knLIIm3/t0PVuvcSCN3JuwsF1LI02apQhopqc9ghmgGtu62
 WAtWf33wK74U3hXclFTgr/dNeYeORLGDumstRPcIsMSkQPcTy9emrmkA+Osn5OwCyRXwB1WkD0Emj
 2QBWYg5WkRTHkAYG7Rh4I8dQ7HT+YnJYVvY0jT9znKfYFH8vnDjMn5Cs7zgmGgXaKJVs9Vk4LwueR
 4s5ozfjA==;
Received: from [2001:4bb8:184:76e3:ac72:d772:f6e1:212] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joV83-0000DB-4N; Thu, 25 Jun 2020 16:53:35 +0000
Date: Thu, 25 Jun 2020 18:53:33 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200625165333.GA1982738@infradead.org>
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

The following changes since commit 0b8eb629a700c0ef15a437758db8255f8444e76c:

  block: release bip in a right way in error path (2020-06-24 08:49:07 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to c31244669f57963b6ce133a5555b118fc50aec95:

  nvme-multipath: fix bogus request queue reference put (2020-06-24 18:41:20 +0200)

----------------------------------------------------------------
Anton Eidelman (2):
      nvme-multipath: fix deadlock between ana_work and scan_work
      nvme-multipath: fix deadlock due to head->lock

Max Gurtovoy (6):
      nvme: set initial value for controller's numa node
      nvme-pci: override the value of the controller's numa node
      nvme-pci: initialize tagset numa value to the value of the ctrl
      nvme-tcp: initialize tagset numa value to the value of the ctrl
      nvme-loop: initialize tagset numa value to the value of the ctrl
      nvme-rdma: assign completion vector correctly

Sagi Grimberg (3):
      nvme: fix possible deadlock when I/O is blocked
      nvme: don't protect ns mutation with ns->head->lock
      nvme-multipath: fix bogus request queue reference put

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 46 +++++++++++++++++++++++++++----------------
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  4 ++--
 drivers/nvme/target/loop.c    |  4 ++--
 7 files changed, 41 insertions(+), 25 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
