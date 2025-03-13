Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C18C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9F0EhDA6LFUyZR2ePkT1KWwUoY/lTNuuviPUcttKINU=; b=wU4vPrXVVNGB8wNQae3min6Q3W
	HFcsSYSiVs1cItidVQlHY9+wkI7IlbC1t77XVlLUxS19ZF957yZxl99ddHow9+q+AGIXzoNiWbVZB
	YzNiRO3jzqZRA3kf8M0Bc6JQ+WWy4kU0OzkZGNEWP/Yxll6X6sv6eUESx04FlQJlaPA1jNZAicqDJ
	sVMcC+VJQUJNBmZYhaT8gSBoL++Cj2bFyyELJA/7UNYBRWGxqpVz2SoJw7k/knNxIHuofvng55Vuo
	8HD78xs2f6q5oU2PHl6DNOwOLTLyS99bsqUV4gIU3bDcZTvTtvo7QXZBFEjPoG+8uuFHeVUAOBkto
	OsZ/pCrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tskWe-0000000Bf8P-2CBs;
	Thu, 13 Mar 2025 15:31:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tskWc-0000000Bf7a-1Mfg
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 15:31:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AD45EA46004;
	Thu, 13 Mar 2025 15:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF7C4CEDD;
	Thu, 13 Mar 2025 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879869;
	bh=/pEGqT0igja92HlPr6G5h2V4x+c3UOnzzpvClZv5Yak=;
	h=Date:From:To:Cc:Subject:From;
	b=htPm101svL9xEPfei9WMxagSJEn4dekkqcr5rYjucrEvRlc2klTbdM10cYM72rxLc
	 vpAry3wcTqWJ8/caSCiI4zLgwZVBW3uk18rVyYok7QE4xJ8twLRw2pVzicAe+wXXq0
	 S7UdY9y90T5tLJ/Dw4azJgzZxq9TvzhPJSORcu3gwniOCTTSsBx6+nGaybmR888mqr
	 DdaSSQkhMrwjpbaK+ef9brbQvh3NSekcfzyFcIxtdzTQejAUWWc4CGWK82MktLpM6v
	 RzWwMEeVgjKx0EeiD3k5yIqI4c6s7HO9R2wvqOjU64JkAX2nL2rp7P84SwcR+WvcpC
	 ezL+8mfmsQQIw==
Date: Thu, 13 Mar 2025 09:31:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.14
Message-ID: <Z9L6Ok3AcufNjdjn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_083110_428978_BCCE2C6E 
X-CRM114-Status: UNSURE (   6.05  )
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

The following changes since commit e7112524e5e885181cc5ae4d258f33b9dbe0b907:

  block: Name the RQF flags enum (2025-03-06 17:50:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2025-03-13

for you to fetch changes up to 39393f5c5c795992507aa5005a9d58396a5b07f1:

  nvmet: pci-epf: Do not add an IRQ vector if not needed (2025-03-10 10:12:16 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.14

 - Concurrent pci error and hotplug handling fix (Keith)
 - Endpoint function fixes (Damien)

----------------------------------------------------------------
Damien Le Moal (2):
      nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
      nvmet: pci-epf: Do not add an IRQ vector if not needed

Keith Busch (1):
      nvme-pci: fix stuck reset on concurrent DPC and HP

 drivers/nvme/host/pci.c       | 13 ++++++++++++-
 drivers/nvme/target/pci-epf.c | 28 ++++++++++++++--------------
 2 files changed, 26 insertions(+), 15 deletions(-)

