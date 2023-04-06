Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E90C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XiCu8MZTq6itawMnWEnNpiWUQ6jMWRUJO21SnKerX2Q=; b=hOsVkhYNsgoHC5MekB/BszQy4Q
	ChNc69z3RiFgksy2fXnSWnxd87Rfp2nX7+DGXU+UKqVNofxVAfwFgf3dhGLVU8NkHcrmDRG9XzEpg
	DZkw/6XzYV9kcEg9JacEVoJd8OM2Bkne8uOeEj4FzE+VznrVzaqXZH9cO7X5zWRaPVEgP80VIptU2
	cTWLq3l9hi/k2Yi5xTDdn0Mntkj676P+H4Q8Av9axa+9p3FHFKGn0rAKzQP3MVOPsO0pqJ4A9BOIh
	sXaR5Kq5xbdTf/xzTIiymjtcMU41lCw/pO18lU5qEAo8R2+pOOLDdCXca6oHwQy9ZjDUDEF+Ovn6c
	QOBtXYPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkQ6Q-007TW9-2Z;
	Thu, 06 Apr 2023 13:56:38 +0000
Received: from [2001:4bb8:191:a744:e487:acf4:4793:eb02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pkQ6P-007TUy-04;
	Thu, 06 Apr 2023 13:56:37 +0000
Date: Thu, 6 Apr 2023 15:56:33 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <ZC7PkTumUFAzsKNJ@infradead.org>
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

The following changes since commit 38a8c4d1d45006841f0643f4cb29b5e50758837c:

  blk-mq: directly poll requests (2023-04-04 16:11:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-04-06

for you to fetch changes up to d3205ab75e99a47539ec91ef85ba488f4ddfeaa9:

  nvme: fix discard support without oncs (2023-04-05 17:13:17 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - fix discard support without oncs (Keith Busch)

----------------------------------------------------------------
Keith Busch (1):
      nvme: fix discard support without oncs

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

