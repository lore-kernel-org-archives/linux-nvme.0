Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D95C05027
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sxJBaTN19A70jHkuOMUFcmvbgXlT2VUpb4rKJphDDN8=; b=mIXXXst7Fs0t52LIKH0yI76nxK
	KPBFHT4Z4eaZcEL6Pcfq2pCqmKL1cSn4Rw+fDlKdIKr5EVAsGN8wUnxpdOyqJcRf8qnaZ89wUQe1Z
	GWKnq3Ns+hxTxRHeEqYnkcZnFf3/Np3c2sYTa5pDGsbV+B/Rkb3QAG36pSyKrOFKfb8dDPB3JbY4P
	aGsgcje1dyoJAWaqiAr4Rv2ZDCEvm1GMOYtieeaCD/PNKnprCKyPdPU7YLcJK+T9ZKoflfvIPWk8Y
	2IAjScHCl3NYKghM1spgWJpwLWLXeWUEYN3Nv3TTAu8GsmzzvPpKCJteSpA7z+5TIYlEw/an0KVCc
	P46Yds6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL6CT-00C3zd-Ir; Thu, 26 Jan 2023 17:38:13 +0000
Received: from 213-225-9-99.nat.highway.a1.net ([213.225.9.99] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL6CQ-00C3zC-L7; Thu, 26 Jan 2023 17:38:11 +0000
Date: Thu, 26 Jan 2023 18:38:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y9K6fTTrhXSWkVeZ@infradead.org>
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

The following changes since commit 955bc12299b17aa60325e1748336e1fd1e664ed0:

  Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-26

for you to fetch changes up to 85eee6341abb81ac6a35062ffd5c3029eb53be6b:

  nvme: fix passthrough csi check (2023-01-25 07:09:38 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - flush initial scan_work for async probe (Keith Busch)
 - fix passthrough csi check (Keith Busch)
 - fix nvme-fc initialization order (Ross Lagerwall)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: flush initial scan_work for async probe
      nvme: fix passthrough csi check

Ross Lagerwall (1):
      nvme-fc: fix initialization order

 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/fc.c   | 18 ++++++++----------
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 10 insertions(+), 11 deletions(-)

