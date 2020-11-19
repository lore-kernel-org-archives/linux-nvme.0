Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14586C2D0E4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 07:51:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7EC246BB
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 07:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0ZIuFB6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OISqq6V4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7EC246BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=91nTkPUrUA/iYa1xS9023ycEj7+k3v1rbYf4fQLaYY0=; b=u0ZIuFB6QlxL0ZJQ/zo8bbu9GN
	UySxC7bar/SRythDJbplMZHX55htxBVBIakbFwpobtfBrNNDnNburJ4MgYWaro3WGIhHnttHCR7Kb
	hoQXrVClp/6md6NpYqluj0K496OwSAKMoVtOVX32fOORs1x9RoLpMDvLrD1RB4w79zBV8UEGhn1p2
	q+3dfsPnp23lJ6DSAQpJ1T4LGISm+QuyZpzOc7Eg62bhs0xCfOxPI0n3qLG1+bm181fD3xsijVeXR
	7yA4S7bslk7pUKP+Sfa0ALf8pqvC2kl+qmPnqGl97IFOTm0skKbI48kjPXrz8VXIhx+pNQy9pa3GR
	QJpZjNBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfeig-0001mq-21; Thu, 19 Nov 2020 07:51:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfeia-0001mI-LS
 for linux-nvme@merlin.infradead.org; Thu, 19 Nov 2020 07:51:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Pyu9heZIDLVyXwvBLRyPWIbTuCXkV5mAZehTNuiPea0=; b=OISqq6V4TeyD5DG2t3TMdXlEbG
 MusG4yOkvrmrRQZ7vEwkX2W5xC1BkKgKbqnfiwNM5PkLpHNdTporJaGJ5uolfavnOGKYvR0v/qeAm
 k3pV1KAH34Zq+bmPXC4Y+qDf60o7rN3SMphDudYOcZN1ugAaf5ya16tfXvJYQlDqwh/14rPjbe56u
 d7oPNkyrj+Dinl3mj8FbEbu3apaaEz0Bp+YANRHAK22Mo5Oz07NN0q8jp8j2QuxJn9McXHPULmdVO
 uyeSc5QTrtsdFaDZP+HXrIDGFfnYYikRI5yZD7zMPvSs5O/QWBDgO+YvHR0zohVDnc+U2tpMOXGPB
 8YZ5u9Hg==;
Received: from [2001:4bb8:18c:31ba:300a:fbec:1f54:a33a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfeiY-0000y8-U8; Thu, 19 Nov 2020 07:50:59 +0000
Date: Thu, 19 Nov 2020 08:50:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201119075057.GA2465128@infradead.org>
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

The following changes since commit 9f16a66733c90b5f33f624b0b0e36a345b0aaf93:

  block: mark flush request as IDLE when it is really finished (2020-11-13 14:24:16 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-19

for you to fetch changes up to 8168d23fbcee4f9f6c5a1ce8650417f09aef70eb:

  nvme: fix memory leak freeing command effects (2020-11-14 09:57:55 +0100)

----------------------------------------------------------------
nvme fixes for 5.10

 - Doorbell Buffer freeing fix (Minwoo Im)
 - CSE log leak fix (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme: directly cache command effects log
      nvme: fix memory leak freeing command effects

Minwoo Im (1):
      nvme: free sq/cq dbbuf pointers when dbbuf set fails

 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  6 ------
 drivers/nvme/host/pci.c  | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
