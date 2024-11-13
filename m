Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0631ED637A0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PHmfeFjf4CgzhNYtK9nMSoRxt4WL7DzO+q5x9i03VFU=; b=F1+T85s6s6+ZNVNBsLPiGJQG5q
	aEX6eUlywqVrGJakVNutm6a/QhrsNM7qdbx8WTiTp8FWFzahxtbBF2wulxSZaeARlLwZEraeIvfWK
	+zUg0XOw2gQ5/7QBCXC8PnA6RSS3or2Iw3siCbiTjP6VBk5fJLNTV9DCR2baV+vB5rBXtjKPXzTym
	PAy1n02S9BlYeS11Fs+4urc1MCGtIt9cGLYUkbQsaiTswOTV05HgDJ2uIMJYSCPzcNBxE3o178Wc6
	4kWd+SA/6mFEB97W+TVDR+I7/RYwf+OB1V/+jeKThGf1vRlOLpxdVpGk7fPTtlglqMg4sUig+X3On
	GKwC3xIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGvn-00000007XQm-2Q9T;
	Wed, 13 Nov 2024 17:13:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGvj-00000007XPV-38h8
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 17:13:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E2505A40EB0;
	Wed, 13 Nov 2024 17:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5554BC4CECD;
	Wed, 13 Nov 2024 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518002;
	bh=UybnvkJtpE1g5EZX+DEulSc51ZGkQFg4mfOhtjR5UhE=;
	h=Date:From:To:Cc:Subject:From;
	b=LsqRck92AOHUbtsYjO2uDCeDclkEiAYhz6W8aZJ38mvLLgaa+WwIL9CFnzcVvjmlS
	 8cTiC6Bj8DJb+SReDAw8gTW4BPKxde5nfZLneB4sZWmwiNKNqOplCMvOrIPbEsfkOd
	 0AAOFkyR0urVUKBi8fg+ywEos1U8rUv4HaSyJ3bTNFvYczXejfbCMxzHhOGzduqzpz
	 GZ+ksQJqoX23UvWZAzu9yFQWLAzBnQAt3F7+rcBqrFF3l6eHGBs+xJtGZBNoMx1oSM
	 ajQ9LXHSNOR3nZkK530UM0hUeuSAmqPNlWCOyinflO7OeHOAD+4qagoXF3MR5Cy0/H
	 G+kz0t3u3gkvA==
Date: Wed, 13 Nov 2024 10:13:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: [GIT PULL] nvme updates for Linux 6.13
Message-ID: <ZzTeMJ60L4mViFPq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_091323_954081_DEFF75D2 
X-CRM114-Status: UNSURE (   9.00  )
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

There is an imminent merge conflict with the srcu list fixes (applied to
upstream 6.12) with the queue freeze lockdep work in block's for-6.13.
It's a pretty straight forward resolution, but I can send the merge if
desired.

The following changes since commit fdad1a20cd57bff65539d971c0ec74faf2b5b2fc:

  Merge branch 'for-6.13/block-atomic' into for-6.13/block (2024-10-22 08:21:51 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.13-2024-11-13

for you to fetch changes up to 50bee3857d081ab1b83f93c64cb5c10a4babe2d9:

  nvmet: add tracing of reservation commands (2024-11-13 08:51:24 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.13

 - Use uring_cmd helper (Pavel)
 - Host Memory Buffer allocation enhancements (Christoph)
 - Target persistent reservation support (Guixin)
 - Persistent reservation tracing (Guixen)
 - NVMe 2.1 specification support (Keith)
 - Rotational Meta Support (Matias, Wang, Keith)
 - Volatile cache detection enhancment (Guixen)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: remove repeated wq flags

Christoph Hellwig (2):
      nvme-pci: fix freeing of the HMB descriptor table
      nvme-pci: use dma_alloc_noncontigous if possible

Guixin Liu (7):
      nvmet: make nvmet_wq visible in sysfs
      nvme: add reservation command's defines
      nvmet: support reservation feature
      nvme: check ns's volatile write cache not present
      nvmet: report ns's vwc not present
      nvme: parse reservation commands's action and rtype to string
      nvmet: add tracing of reservation commands

Keith Busch (9):
      nvmet: implement id ns for nvm command set
      nvmet: implement active command set ns list
      nvmet: implement supported log pages
      nvmet: implement supported features log
      nvmet: implement crto property
      nvmet: declare 2.1 version compliance
      nvmet: implement endurance groups
      nvmet: implement rotational media information log
      nvmet: support for csi identify ns

Matias Bjørling (1):
      nvme: use command set independent id ns if available

Pavel Begunkov (1):
      nvme: use helpers to access io_uring cmd space

Wang Yugui (1):
      nvme: add rotational support

 drivers/nvme/host/core.c          |   29 +++++---
 drivers/nvme/host/ioctl.c         |    4 +-
 drivers/nvme/host/nvme.h          |    1 +
 drivers/nvme/host/pci.c           |   74 +++++++++++++++++----
 drivers/nvme/host/trace.c         |   58 ++++++++++++++--
 drivers/nvme/target/Makefile      |    2 +-
 drivers/nvme/target/admin-cmd.c   |  288 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/configfs.c    |   27 ++++++++
 drivers/nvme/target/core.c        |   64 ++++++++++++++++--
 drivers/nvme/target/fabrics-cmd.c |    7 +-
 drivers/nvme/target/nvmet.h       |   67 ++++++++++++++++++-
 drivers/nvme/target/pr.c          | 1156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.c       |  108 ++++++++++++++++++++++++++++++
 include/linux/nvme.h              |  135 +++++++++++++++++++++++++++++++++++++-
 14 files changed, 1968 insertions(+), 52 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

