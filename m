Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242FEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A72823B40
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A72823B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wzp2WubyWZPldru7tR/o93Q8IX6233PNhn5zi3TNmLo=; b=OzklxFk8JfIV3emj9+NmYKbJM8
	UNQDGTuWoG/ru5nGhaWig7sdrv77KdzTOHtrolbkGq2wb/nsKW3iBKz5VEUdU1N9xlg/iWIs/FFks
	56qJCik1EvlCzEJTAg8VpGJAuvYB5zcKBQ1C8X8D/Y2nB/qnJWSVw0EKMGSZ6BrBFZN1lR2MVByW0
	O9xf3am3RGlEJfBWnFKM3oXrHD4pvjZCP0apY30nfIwfaaxiJAQr481+RwchRPq1I+srVps1l1T59
	wOWIz8cUEyTnFT8ye8AYMcvuumSWucU0zHGDdWybClKHm3pDJAdLKWOjq1+VbjCPlQVjIviBXrNfq
	+QG4FapQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l08Jw-0002bC-Rt; Thu, 14 Jan 2021 19:30:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l08Jv-0002aU-AG
 for linux-nvme@merlin.infradead.org; Thu, 14 Jan 2021 19:30:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iMbL6fqf8zt3Caal0LFmwWvyAtg2qmkvjNKB8hnyUHg=; b=DC7GehA3Lx6enHNSQ6zd66cNmx
 hR+OG6MHYRLYpzQUjMfJ0p5q5BBaTT8nfjaqX80ibAfuR6XnT8KfK/gFxRb0uGd8XBtIUa/w5k45b
 Rt4lop9F/AedObd/7Noip+q7TmTeyFBrtpp0fbcvx828uedz3ZYF1A8RJge7tBK6/sTpS/cEYRNQA
 DIJJV5IhXbmowTWSl2+qLomA9SWGWR7P0c+n1IuhMiJN0jqZfodTOBfJ8hLKaDY6Lg32F5uCdnRjx
 K4WxragZQHWJXjCGaH8e+YFOKz0WdGYShqBt6ZoHSgP//pFpqCiPQd5txRtPqxGNs5HTcF1QsMVme
 wBpeX3uA==;
Received: from [2001:4bb8:188:1954:a479:70de:a137:a166] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l08JZ-007yd6-Kq; Thu, 14 Jan 2021 19:30:02 +0000
Date: Thu, 14 Jan 2021 20:29:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <YACbrIes4r8Qa1mA@infradead.org>
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

The following changes since commit 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:

  bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-14

for you to fetch changes up to 5ab25a32cd90ce561ac28b9302766e565d61304c:

  nvme: don't intialize hwmon for discovery controllers (2021-01-14 20:27:35 +0100)

----------------------------------------------------------------
nvme fixes for 5.11:

 - don't initialize hwmon for discover controllers (Sagi Grimberg)
 - fix iov_iter handling in nvme-tcp (Sagi Grimberg)
 - fix a preempt warning in nvme-tcp (Sagi Grimberg)
 - fix a possible NULL pointer dereference in nvme (Israel Rukshin)

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet-rdma: Fix NULL deref when setting pi_enable and traddr INADDR_ANY

Sagi Grimberg (3):
      nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT
      nvme-tcp: fix possible data corruption with bio merges
      nvme: don't intialize hwmon for discovery controllers

 drivers/nvme/host/core.c   | 11 ++++++++---
 drivers/nvme/host/tcp.c    |  4 ++--
 drivers/nvme/target/rdma.c | 16 ++++++++--------
 3 files changed, 18 insertions(+), 13 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
