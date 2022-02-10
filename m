Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a3gwvncnlSn4GBCTOYJCrV+pTVRA9a4zE1uhsJkRlGg=; b=437MuvnRZ8E9j8KHa5nJt6shEn
	+u8TxUajzkOm/YHTk+OfvM+vhg102UEeyjRbskuaRWJYQYdP8FHlxU1T8xsSBtf0pZ/s9ulxiFTjB
	uNoirNBo57Vw0oS++bkhqI+6q9ztf0wg6T4wlwK94dNBnJzG9Znqbp9wqQlo7LF0TevbWOJ2VS4Px
	jhgGU44a/fBNjHYDT9EDRVJZ4Uh4y74PntdWo5I2CLN7S6qbR6TV6XE18jC/oTPBvlrjZGt4dDNXa
	gN78AMg8wx4GYtYZEHh14rwd0bQZx+V3rqN2AkQKseiA6n3iBSouFSqtpf7HuEzmKZFaV8KvdUm99
	E3I4cVVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI45l-002u5x-4D; Thu, 10 Feb 2022 07:42:13 +0000
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI45j-002u5H-CB; Thu, 10 Feb 2022 07:42:11 +0000
Date: Thu, 10 Feb 2022 08:42:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YgTB0csAbKyI5WvN@infradead.org>
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

The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:

  block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10

for you to fetch changes up to 63573807b27e0faf8065a28b1bbe1cbfb23c0130:

  nvme-tcp: fix bogus request completion when failing to send AER (2022-02-09 14:50:42 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - nvme-tcp: fix bogus request completion when failing to send AER
   (Sagi Grimberg)
 - add the missing nvme_complete_req tracepoint for batched completion
   (Bean Huo)

----------------------------------------------------------------
Bean Huo (1):
      nvme: add nvme_complete_req tracepoint for batched completion

Sagi Grimberg (1):
      nvme-tcp: fix bogus request completion when failing to send AER

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/tcp.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

