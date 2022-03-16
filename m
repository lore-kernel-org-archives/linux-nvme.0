Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4CEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AsIUq7+RSnqQQnR7oUJiLxsWazVuQ1qtZlXnVGn+QTU=; b=bj1rnseQU1y5wA8NhdeqLw9SZ7
	g12K4WJC6/ar3jnbwOPvS9yxe66PE180WOU2jb2PeCAmhvluLVhNEi5lGU4QjuxAqf9nKY42s8+ok
	13NmhK2XOM4gBpn5coWKR6t8ylh+7VC5p2+ACCeV1Du9ZCEkX+7cUZFHM9JLlPjbw/fz+IafV2Iz4
	SLjYxw8HI6LnqOq1R88fFWTDTU84w8A5Sei0UOtvxi/RxgUJsQzIWPEiGyyxWsnX6xujdEJtwyLpw
	w7a2PZgHAAoi/SN86hPbl7k7obNNNEb2458DDqtpmoEUXz9hXPIzFXOUHypP4kQXNTwYIuMDoRf+5
	InnOTIGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUQAr-00CLjt-QB; Wed, 16 Mar 2022 09:42:33 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUQAp-00CLip-7J; Wed, 16 Mar 2022 09:42:31 +0000
Date: Wed, 16 Mar 2022 10:42:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 5.17
Message-ID: <YjGxBNRRK/VLVYsF@infradead.org>
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

The following changes since commit c2700d2886a87f83f31e0a301de1d2350b52c79b:

  nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-03-16

for you to fetch changes up to 0c48645a7f3988a624767d025fa3275ae24b6ca1:

  nvmet: revert "nvmet: make discovery NQN configurable" (2022-03-15 10:39:26 +0100)

----------------------------------------------------------------
nvme fix for Linux 5.17

 - last minute revert of a nvmet feature added in Linux 5.16
   (Hannes Reinecke)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet: revert "nvmet: make discovery NQN configurable"

 drivers/nvme/target/configfs.c | 39 ---------------------------------------
 drivers/nvme/target/core.c     |  3 +--
 2 files changed, 1 insertion(+), 41 deletions(-)

