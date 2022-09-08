Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0054C38145
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zk3pK1fMADHPvgH2vaLLhOL6VnBqBDqbgLBUcfh+dYI=; b=yW+2whFpmI7jHA4xFzAgLoef84
	j9uWN08R1GrVaFwRIAYl+Lxi2H2CwHJVHj/vGtRJggkvJk9g4KSC19O7EbQ3afOfyntXkrzL+HgsL
	wN5WWFPnYrHMVu3aKqZzIIZLtmcdwvrHr+78zu2OoFkLjdZyUTRq3WdKTvAxTZ2PA++6ximVqDpHb
	zavcEcjEO6M343GZm9wGVIIpKUBuTyYreXO6P+k3ev8aK/zVkRhfDJjzNAfOiA1NCnD7vRTQ2LQog
	Su8RuPGYlSQI94Kb+7AUZ4obnJ4Yb4Z34epQGuMdeX9EIwnP33B5j+k8kStiOc8MZE37nXoyxEYp1
	H0QrS0GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWJiK-005Mkn-Ab; Thu, 08 Sep 2022 15:45:12 +0000
Received: from [2001:4bb8:198:38af:d1ad:8412:49b8:c1d3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWJYn-005H08-Co; Thu, 08 Sep 2022 15:35:21 +0000
Date: Thu, 8 Sep 2022 17:35:13 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YxoLsUEjritZcoK9@infradead.org>
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

The following changes since commit 748008e1da926a814cc0a054c81ca614408b1b0c:

  block: don't add partitions if GD_SUPPRESS_PART_SCAN is set (2022-09-03 11:29:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-08

for you to fetch changes up to 371a982cd2b01487295cd87abec82357e268457b:

  nvme: requeue aen after firmware activation (2022-09-07 08:38:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix a use after free in nvmet (Bart Van Assche)
 - fix a use after free when detecting digest errors (Sagi Grimberg)
 - fix regression that causes sporadic TCP requests to time out
   (Sagi Grimberg)
 - fix two off by ones errors in the nvmet ZNS support
   (Dennis Maisenbacher)
 - requeue aen after firmware activation (Keith Busch)

----------------------------------------------------------------
Bart Van Assche (1):
      nvmet: fix a use-after-free

Dennis Maisenbacher (1):
      nvmet: fix mar and mor off-by-one errors

Keith Busch (1):
      nvme: requeue aen after firmware activation

Sagi Grimberg (2):
      nvme-tcp: fix UAF when detecting digest errors
      nvme-tcp: fix regression that causes sporadic requests to time out

 drivers/nvme/host/core.c   | 14 +++++++++++---
 drivers/nvme/host/tcp.c    |  7 ++-----
 drivers/nvme/target/core.c |  6 ++++--
 drivers/nvme/target/zns.c  | 17 +++++++++++++++--
 4 files changed, 32 insertions(+), 12 deletions(-)

