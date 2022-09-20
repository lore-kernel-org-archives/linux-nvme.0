Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC19C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=esF+HXZdlARYQPg7/MAFN+XNPN0Myox5IB5R3zI3vSY=; b=SbD3wXViXXo6C/zYQIr7JCtKcs
	e1gAl7v6FXM/Tw2ht4kbDQO25wOzmAhKSPz/26sPAcqxz720Zu5nDcqcnpO2xtsZ4lfI0XGqOp6wh
	nYsctRhuVD70iMCFrFi6Z9ADcxRHT9V7NVw99SPAf3fa7HR1Huz/I2TA6NVw0JBlaeK1tqH1hXzOF
	NP6tjav9uTDas1nLxMp3O1fzmpVpB0QfwjeYnYR9JsxrkUaTJ4VEVmsWlyhlLucDl00a4qwtxda2w
	stw8DCalTL4rSRbbLH6tDx1MiKZdBXx5AHrwVTbg9ltHaxux1Sf2SP11b2eJqFJpTLngPmROEzQfS
	VoVj8R/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYEm-001adU-Kf; Tue, 20 Sep 2022 08:04:12 +0000
Received: from [2001:4bb8:189:f4ee:2681:1838:8166:a6f8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYEh-001aRl-6R; Tue, 20 Sep 2022 08:04:07 +0000
Date: Tue, 20 Sep 2022 10:04:05 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 6.1
Message-ID: <Yylz9ST3BJeXmQCU@infradead.org>
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

Hi Jens,

here is currently queue up nvme patches for 6.1, which are not a lot.
There are a few more patches under discussion that will follow later.

The following changes since commit 91418cc4fd8f8e2e21b409eb8983d074359c8be6:

  block/drbd: remove unused w_start_resync declaration (2022-09-12 01:47:57 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-20

for you to fetch changes up to 02c57a82c0081141abc19150beab48ef47f97f18:

  nvme-tcp: print actual source IP address through sysfs "address" attr (2022-09-19 17:55:28 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.1

 - handle number of queue changes in the TCP and RDMA drivers
   (Daniel Wagner)
 - allow changing the number of queues in nvmet (Daniel Wagner)
 - also consider host_iface when checking ip options (Daniel Wagner)
 - don't map pages which can't come from HIGHMEM (Fabio M. De Francesco)
 - avoid unnecessary flush bios in nvmet (Guixin Liu)
 - shrink and better pack the nvme_iod structure (Keith Busch)
 - add comment for unaligned "fake" nqn (Linjun Bao)
 - print actual source IP address through sysfs "address" attr
   (Martin Belanger)
 - various cleanups (Jackie Liu, Wolfram Sang, Genjian Zhang)

----------------------------------------------------------------
Daniel Wagner (4):
      nvmet: expose max queues to configfs
      nvme-tcp: handle number of queue changes
      nvme-rdma: handle number of queue changes
      nvme: consider also host_iface when checking ip options

Fabio M. De Francesco (1):
      nvmet-tcp: don't map pages which can't come from HIGHMEM

Genjian Zhang (1):
      nvmet-auth: remove redundant parameters req

Guixin Liu (1):
      nvmet: avoid unnecessary flush bio

Jackie Liu (2):
      nvme-auth: remove the redundant req->cqe->result.u16 assignment operation
      nvmet-auth: clean up with done_kfree

Keith Busch (4):
      nvme-pci: remove nvme_queue from nvme_iod
      nvme-pci: iod's 'aborted' is a bool
      nvme-pci: iod npages fits in s8
      nvme-pci: move iod dma_len fill gaps

Linjun Bao (1):
      nvme: add comment for unaligned "fake" nqn

Martin Belanger (1):
      nvme-tcp: print actual source IP address through sysfs "address" attr

Wolfram Sang (1):
      nvme: move from strlcpy with unused retval to strscpy

 drivers/nvme/host/core.c               |  8 +++--
 drivers/nvme/host/fabrics.c            | 25 +++++++++----
 drivers/nvme/host/pci.c                | 65 +++++++++++++++++-----------------
 drivers/nvme/host/rdma.c               | 26 +++++++++++---
 drivers/nvme/host/tcp.c                | 47 ++++++++++++++++++++----
 drivers/nvme/target/admin-cmd.c        |  2 +-
 drivers/nvme/target/configfs.c         | 29 +++++++++++++++
 drivers/nvme/target/discovery.c        |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 10 +++---
 drivers/nvme/target/fabrics-cmd.c      |  1 -
 drivers/nvme/target/io-cmd-bdev.c      |  8 +++++
 drivers/nvme/target/tcp.c              | 44 +++++++----------------
 12 files changed, 176 insertions(+), 91 deletions(-)

