Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F2FC3064D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5AOmhiaI7FZiUToAVL+em9t2qjUjmagJQvAUL0LtGbk=; b=a+HTproLNFe9C+PqDSimg2rkqa
	azUAU8xv1xd9mcrDEl9Ep6gXLfEGDsShhZdq+SHQtd6ZHd4LvLqvJAOKHbaJCtSdRO/OWTJggQ4V4
	In/xtKswoD9UPrgw/qCDgozGqsA5vTymEcHOajB+r6ujAH2gXYCfLRjLcMwEdwitkZ/g7BxxP5gQZ
	h/T4l+ze+mcMa8i7tsr/d1WNLZMaVaPY/x+gIY5fYe3v4wZJpaROAJlhlZ+jpAtCknJ/Q7Rb//riK
	JU1Y7i+hDcm3FywTvWUvMyadKzwuzUKQ0+OwGEJq6wdWzvT2ode4GVkoBJgo11dHfLmr7Y71iXJP3
	btfqQD+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMtTM-0000000BKh4-3iy3;
	Thu, 27 Jun 2024 18:03:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMtTK-0000000BKgc-2akz
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 18:03:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 92E9561F43;
	Thu, 27 Jun 2024 18:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA2C2BBFC;
	Thu, 27 Jun 2024 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719511428;
	bh=pLZm178y4tPZaszRH5mqJDMU84s8xskbJkDdW1zNe/A=;
	h=Date:From:To:Cc:Subject:From;
	b=X4ZLiz6Cup1DaYnjGDJe4lJJ84GOjrPxMRgn/LyoaIWDh4EA7yNubaXZcrkTeJrMQ
	 SHHyVRE3VblxFLZr5/HmPeWeskcuLZahhGZF5q01lYhfWl6Jw5nmoZtzhIrV+nXcwB
	 VURKkB867IiRNRnj4lBK4oYUWscs+ANW2FU4N2jnCdv5gXLD4K9YEzzgZwHs9pyQVo
	 UaD62WLrajNZpkGlHVXRLnVDsw7oVclQR4UnBYfOHPGv3rV+HvsvBolrz0peaZ11Z5
	 gtEJNNYqmQ22XMAvSxXrtLlZ7ND9js/4KI2AJlO2bNyLgKZVErYXVHsNYfNwLTTXCS
	 ExEX+Q9K45RMg==
Date: Thu, 27 Jun 2024 12:03:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.10
Message-ID: <Zn2pgbTvj8TYr_W5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_110350_829030_15018AD3 
X-CRM114-Status: UNSURE (   6.82  )
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

The following changes since commit 5f75e081ab5cbfbe7aca2112a802e69576ee9778:

  loop: Disable fallocate() zero and discard if not supported (2024-06-14 06:21:25 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-27

for you to fetch changes up to 440e2051c577896275c0e0513ec26964e04c7810:

  nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[] (2024-06-26 10:13:04 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.10

 - Fabrics fixes (Hannes)
 - Missing module description (Jeff)
 - Clang warning fix (Nathan)

----------------------------------------------------------------
Boyang Yu (1):
      nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.

Hannes Reinecke (3):
      nvmet: do not return 'reserved' for empty TSAS values
      nvme: fixup comment for nvme RDMA Provider Type
      nvmet: make 'tsas' attribute idempotent for RDMA

Jeff Johnson (1):
      nvme-apple: add missing MODULE_DESCRIPTION()

Nathan Chancellor (1):
      nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[]

 drivers/nvme/host/apple.c      |  1 +
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/configfs.c | 41 +++++++++++++++++++++++++++++++----------
 drivers/nvme/target/fc.c       |  2 +-
 include/linux/nvme.h           |  6 ++++--
 5 files changed, 38 insertions(+), 14 deletions(-)


