Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B0CC25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XLKv/MpUquOnd6VUr05EqDWnET2qZv1DAR/YauThd0g=; b=h/2dIp+Y5SA0YApHmhXMJ7w9CG
	xpJJuReGW3OXMuF6FZ/j0ZRltXMKZQyUVfpyDcS2H0196/HGO4A5cuUpKztvz0jhSRak9FvpGaSsm
	LALlJxitiBQpzDMYmhg4Lra/F+t2cAOKMZtO70k2+cPknBDyVu/0LS61jVQfkIzI0V+QQgZDfzUBg
	N+OBW2oWCmAUo2bbXDnuoIJWUldDSPktop3SbZOVaNJpYSqDPp4w1XZD9+TS6gDCDjfwsvaw11q4t
	iLH/1wVgdv9FaRucc35rs0rLLkWPq0Pvx9Y0tjvjjR8IAZCyE3yPBvd0ZqU8FKV0A+/exjSvC5faB
	NTijEx+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCRVQ-00000005ggw-1eTZ;
	Wed, 29 May 2024 22:10:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCRVL-00000005gdq-242l
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 22:10:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7B6EACE18F6;
	Wed, 29 May 2024 22:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FECC113CC;
	Wed, 29 May 2024 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717020640;
	bh=4hJAGwPQW1qGKKRm3zaKRF/nNwvB57GCZBLRpsQ+IYI=;
	h=Date:From:To:Cc:Subject:From;
	b=FcqueXqYAjwUNNLBexfgVxuT3oyGt8YD8rt4SjvMiTq6EmloN/Kn1sTXY5Kh47hMK
	 pw7bQRSjfxR+asq1x3nhm70TWeRpYTEWXlCMC8SbkhhfiQ5OD5H4JYocdTOjdOg7bN
	 QBLohC0dwGMn5BTVfkemrkQItk8y8ViclJ/7KEkcDZ1CG9010pEt4HppPk+NG/oVC0
	 RCnl2F83rBj8DV4DK7P2EbZDviycCyKe8bWcTngx9KskUEntQ1NcpupTAmBQsP+Ehb
	 +ElVu/QnWC6YHFDWW3oFkhBfYq+M1mZulp0ucKmf1v5pdgXz60OdhgTXwA2a7pI6Pp
	 6WcysbZtAJ0sw==
Date: Wed, 29 May 2024 16:10:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.10
Message-ID: <Zlen3slew1w4dneo@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_151043_780727_3DB955CA 
X-CRM114-Status: UNSURE (   8.45  )
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

The following changes since commit f0eab3e8d1530b87f3523cee060004dd513a6d2b:

  block: t10-pi: add MODULE_DESCRIPTION() (2024-05-20 08:07:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.10-2024-05-29

for you to fetch changes up to c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4:

  nvmet: fix a possible leak when destroy a ctrl during qp establishment (2024-05-28 10:01:52 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.10

 - Removing unused fields (Kanchan)
 - Large folio offsets support (Kundan)
 - Multipath NUMA node initialiazation fix (Nilay)
 - Multipath IO stats accounting fixes (Keith)
 - Circular lockdep fix (Keith)
 - Target race condition fix (Sagi)
 - Target memory leak fix (Sagi)

----------------------------------------------------------------
Kanchan Joshi (1):
      nvme: remove sgs and sws

Keith Busch (3):
      nvme: fix multipath batched completion accounting
      nvme-multipath: fix io accounting on failover
      nvme: use srcu for iterating namespace list

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Sagi Grimberg (2):
      nvmet: fix ns enable/disable possible hang
      nvmet: fix a possible leak when destroy a ctrl during qp establishment

 drivers/nvme/host/core.c       | 116 +++++++++++++++++++++++++----------------
 drivers/nvme/host/ioctl.c      |  15 +++---
 drivers/nvme/host/multipath.c  |  26 +++++----
 drivers/nvme/host/nvme.h       |   7 +--
 drivers/nvme/host/pci.c        |   3 +-
 drivers/nvme/target/configfs.c |   8 +++
 drivers/nvme/target/core.c     |   9 ++++
 7 files changed, 117 insertions(+), 67 deletions(-)


