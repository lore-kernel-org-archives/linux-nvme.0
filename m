Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C041D6A221
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mepHExHBfO2e5z8V9jTUYN/yE3wKG2c1mSZYQk13dJs=; b=NGI4cDT6H7A4wmQtlUOlFaqvzy
	zEfVCpqrQrIuKUIaAnnfCTL7kP/10OWSrSKuK6Ei6SA7+L3J6rL5JPm4vNFTPQ2/+tZGyWpKKixP1
	6THLR86yTmd7Mikg6X+dXtJ+wzFucilc27RxGFsKLIwgY42kz0wLu7g4Zef+m5cjyeKAS1jUqFPvL
	j0DAI/CHa9ETWRI14b0tXJGpoHPZ7ral18SqVq/7oAZRYsrhtCEUTdwoTobislrc5tKbA/pBhXSST
	MG+odJtO7t4Cs8xJ+3mEgP7wN8w0ch/Vhc5vG6j44ttxRjUGJ7LoZMfsUsbijX6tO504LbUR+UL0T
	szhizXCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeRd-00000000Sso-23Bg;
	Thu, 14 Nov 2024 18:19:53 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeRb-00000000Ss1-2Tuy
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:19:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CE040A419ED;
	Thu, 14 Nov 2024 18:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE0EC4CECD;
	Thu, 14 Nov 2024 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731608390;
	bh=lZcxno+fqkcb8WxWiFxsn18dDyw8QfzFvKltLD7NF6U=;
	h=Date:From:To:Cc:Subject:From;
	b=rmIvqIBgttZsplwdg5W0IYVy2xgVbBbOpSs32M4wPikmJt2KS8c8178y03XNVVmnz
	 bwoCmW0HvBJjIMyoS+lRkmK4BG2zSG5D2hhKFwUYUr5rltYRC2PBjMECS66MAMZJLj
	 DMjcXo/JE6UT8EDuyfpZMTb+OpysZE8dLwrZh0jWL2gMce00VzP/6fqAH/LYaJX8NB
	 p/1RY0wCRX5ZNAjlXdYAptwZBcdqtu1cCbmdJY00Wuk7/jC4YEMIah/o69rjGUbdnT
	 iE4sbQypBsTrZy4oaSJfP/NBfkEWR16KlhyFc7CzX8HjCXdA6SYTLNvLqlX4DvNP4i
	 wvlkdz/DUg8iA==
Date: Thu, 14 Nov 2024 11:19:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.12
Message-ID: <ZzY_Q785-p12Bl14@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_101951_689378_BE12B433 
X-CRM114-Status: UNSURE (   6.84  )
X-CRM114-Notice: Please train this message.
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

Same fix as the last week's nvme fix, but for nvme-multipath. It should
have been included with our previous pull-request, but I did see the
message in my queue until too late.

The following changes since commit 52ff8e91f916fa05dd47b5c30afa3286c30db444:

  Merge tag 'nvme-6.12-2024-11-07' of git://git.infradead.org/nvme into block-6.12 (2024-11-07 13:57:12 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-11-14

for you to fetch changes up to f0f5b364d903a35c02432b0f55d3a0114ba35845:

  nvme/multipath: Fix RCU list traversal to use SRCU primitive (2024-11-07 13:40:59 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.12

 - Use correct list traversal for srcu lists (Breno)

----------------------------------------------------------------
Breno Leitao (1):
      nvme/multipath: Fix RCU list traversal to use SRCU primitive

 drivers/nvme/host/multipath.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

