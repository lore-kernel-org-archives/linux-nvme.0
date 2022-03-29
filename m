Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Mar 2022 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ez2NI4Q1HqExaSrgvjuYMBA2xGi6O0vr2aWT3pRhjwY=; b=bkqlkn2HS8ETOgaFGjDIVrOsd7
	dPzmMyPHTowv/Bob9SXNktpe3yVhq8Km1/5CvWRILlPxhT7xtxSBeQHpV2iL+/dOS1IBqAwt3eKGB
	MR9LbtGBWf1IDd9prOZ7BdO4d04St3kpG2214N2h11WofioaKWNZrANkX7PTtLCFuRsGPa87WQVKF
	dJ22sMr3+n+Jk72G5dU9Z2c6yXdLgdAeAdVBqcbQL/82UWto6D35xMT33Z40IaltmfFQo4S4rEuWj
	m8EYdZwt4qArHTgCnJwe37nJJAzZKcrG6bIx1jfvN4Flvp6F1xFzb6Bx58dQGc3aJC8kY6ADyt4Z1
	u69koHEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZ6Ka-00BLAo-6L; Tue, 29 Mar 2022 07:31:56 +0000
Received: from [94.198.141.138] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZ6KX-00BL8y-2w; Tue, 29 Mar 2022 07:31:53 +0000
Date: Tue, 29 Mar 2022 09:31:45 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.18
Message-ID: <YkK14fRnn3GVpGxQ@infradead.org>
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

The following changes since commit b2479de38d8fc7ef13d5c78ff5ded6e5a1a4eac0:

  n64cart: convert bi_disk to bi_bdev->bd_disk fix build (2022-03-21 06:34:45 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-29

for you to fetch changes up to a4a6f3c8f61c3cfbda4998ad94596059ad7e4332:

  nvme-multipath: fix hang when disk goes live over reconnect (2022-03-29 09:29:06 +0200)

----------------------------------------------------------------
 for Linux 5.18

  - fix multipath hang when disk goes live over reconnect (Anton Eidelman)
  - fix RCU hole that allowed for endless looping in multipath round robin
    (Chris Leech)
  - remove redundant assignment after left shift (Colin Ian King)
  - add quirks for Samsung X5 SSDs (Monish Kumar R)
  - fix the read-only state for zoned namespaces with unsupposed features
    (Pankaj Raghav)
  - use a private workqueue instead of the system workqueue in nvmet
    (Sagi Grimberg)
  - allow duplicate NSIDs for private namespaces (Sungup Moon)
  - expose use_threaded_interrupts read-only in sysfs (Xin Hao)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix hang when disk goes live over reconnect

Chris Leech (1):
      nvme: fix RCU hole that allowed for endless looping in multipath round robin

Colin Ian King (1):
      nvmet: remove redundant assignment after left shift

Monish Kumar R (1):
      nvme-pci: add quirks for Samsung X5 SSDs

Pankaj Raghav (1):
      nvme: fix the read-only state for zoned namespaces with unsupposed features

Sagi Grimberg (1):
      nvmet: use a private workqueue instead of the system workqueue

Sungup Moon (1):
      nvme: allow duplicate NSIDs for private namespaces

Xin Hao (1):
      nvme-pci: expose use_threaded_interrupts read-only in sysfs

 drivers/nvme/host/core.c          | 38 ++++++++++++++++++++++++++------------
 drivers/nvme/host/multipath.c     | 32 +++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h          | 23 +++++++++++++++++++++++
 drivers/nvme/host/pci.c           |  7 +++++--
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/configfs.c    |  2 +-
 drivers/nvme/target/core.c        | 26 +++++++++++++++++++-------
 drivers/nvme/target/fc.c          |  8 ++++----
 drivers/nvme/target/fcloop.c      | 16 ++++++++--------
 drivers/nvme/target/io-cmd-file.c |  6 +++---
 drivers/nvme/target/loop.c        |  4 ++--
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        | 12 ++++++------
 drivers/nvme/target/tcp.c         | 10 +++++-----
 include/linux/nvme.h              |  1 +
 16 files changed, 133 insertions(+), 57 deletions(-)

