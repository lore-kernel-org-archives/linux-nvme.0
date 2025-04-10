Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFC9C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P3cul0HMSLwsREqYKeSJyVYe4xfBvK7Oexli1yLCdSA=; b=sadT3RebvHYB2OyWUMecYOaDNE
	i7Le2SG0+IeWExUJCZAsxUb6mV479ynw2fJYgy674kIpqgGKEvorhvz+t2Vuxe5eZF+/WqOONCUE0
	Ti7ANCNtGU4C18nmXxIbSLClCfh4ejfgoi3KLFb/9VgwwcYZobwnOrN92C9zY2ifV2x+U3MaWD9G8
	AWdOs3CHjzH+i+QX8p48Cr1RXoQhXdMBlKewelxz8l+HsEoW1i3U7oTZIPlQ9sUR0bqRzy/QC9qDE
	+fwE9bh8tuEKg7fMTqNJxWENqvmsK33xOnXCOGnACzfoOUez/rTx4WHOJGJXW7iv56q/9e/3eWj54
	xZ+MyAdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2vED-0000000BHxm-1QiM;
	Thu, 10 Apr 2025 16:58:13 +0000
Received: from 2a02-8389-2341-5b80-393b-6fa1-7c8e-6b3b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:393b:6fa1:7c8e:6b3b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2tPJ-0000000AwRx-26Yv;
	Thu, 10 Apr 2025 15:01:33 +0000
Date: Thu, 10 Apr 2025 17:01:30 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.15
Message-ID: <Z_fdSjFqscMuzxYq@infradead.org>
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

The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:

  selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10

for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:

  nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.15

 - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
 - fix missed namespace/ANA scans (Hannes Reinecke)
 - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
 - fix a NULL instead of false review in multipath (Uday Shankar)

----------------------------------------------------------------
Daniel Wagner (8):
      nvmet-fcloop: swap list_add_tail arguments
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Hannes Reinecke (2):
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes

Kuniyuki Iwashima (1):
      nvme-tcp: fix use-after-free of netns by kernel TCP socket.

Uday Shankar (1):
      nvme: multipath: fix return value of nvme_available_path

 drivers/nvme/host/core.c      |  9 ++++++
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/tcp.c       |  2 ++
 drivers/nvme/target/fc.c      | 60 ++++++++++++-----------------------
 drivers/nvme/target/fcloop.c  | 74 +++++++++++++++++++++++--------------------
 5 files changed, 72 insertions(+), 75 deletions(-)

