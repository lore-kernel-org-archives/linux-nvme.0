Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26876C3DA41
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OzrP2AYpfSpUwdK/IMMWKZDlJdT394tnAgCiwWFS8UE=; b=1uWvB547wVcf4fbjSeE/Isg+di
	FIYas4OA3OFpsBK1+livO560LeHGctlFey1WDsKh4/Qp5b4DWWcyyveZbs6/XIQhv9OUFKUSyEP9f
	hpmrxax870hK35GFGF+CMVWTaye67j4jDb/vMGorjEAPok423Lbdq8qdbNiGikUyHh5KKQqoLtPIA
	K2u6q2YT+SyYVQuskt5OGtQ5iF7Ep2WduFjkkzOIUZpScqLcDpbR7WgJ+l6jARYplHIL9/HyIItQZ
	Ns4OqpJxDDxWP/BZFEFhMl1M5Uoh7Fr8z3SjlxrGJ9v4W3GwMBFLw/NoWOP2F+RnOVJOEBpEv6Dl1
	WVn7z/dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQv2Z-00000004yXI-1c9p;
	Mon, 08 Jul 2024 20:32:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQv2X-00000004yW1-0Zro
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 20:32:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4718ACE0B7A;
	Mon,  8 Jul 2024 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341C5C3277B;
	Mon,  8 Jul 2024 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470766;
	bh=/10tOHUkdJ+Vkrf+JzT6fB3SfHCSlx7/jIUiXxydxYo=;
	h=Date:From:To:Cc:Subject:From;
	b=YryMuOo6Xq5pdyIZVUWUXo+AuSOLi8EtBdnaGG7w38CVEv3piKN9hOqppljuncxL1
	 dxL/gCN6LMN9zqzedJqyn0jWsYS1gKmukJeb4J7Qlf+j1L72b2Q+IbdXDTU3xLgajD
	 W64VmCdDUQ6MaUsST86Ke981n50t9bmS8mAs0gO2972PihoU0OlWtat/Zd3lmAAtG+
	 cSWFECuuzrlFG8Sd6gXh5WS2wkj5LmwoaM178bZXqY0Sd0QlAlPsH65DUsIHSDVI7w
	 JmvCqlMKJ0IT5N5QZ7joKmZ2xt0Lc9wprQwfdOf3Lk1c2lolWp62Q3Fh5QL0RlPVi6
	 Yazu86GTqGTFA==
Date: Mon, 8 Jul 2024 14:32:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 6.11
Message-ID: <ZoxM6r4B2bxhi_i1@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_133249_551064_F07948E3 
X-CRM114-Status: GOOD (  12.21  )
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

The following changes since commit 44348870de4b8f292f97b84583a298d66fbaf738:

  block: fix the blk_queue_nonrot polarity (2024-06-24 13:06:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.11-2024-07-08

for you to fetch changes up to 89f58f96d1e2357601c092d85b40a2109cf25ef3:

  nvmet-auth: fix nvmet_auth hash error handling (2024-07-08 10:28:16 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.11

 - Device initialization memory leak fixes (Keith)
 - More constants defined (Weiwen)
 - Target debugfs support (Hannes)
 - PCIe subsystem reset enhancements (Keith)
 - Queue-depth multipath policy (Redhat and PureStorage)
 - Implement get_unique_id (Christoph)
 - Authentication error fixes (Gaosheng)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: implement ->get_unique_id

Gaosheng Cui (1):
      nvmet-auth: fix nvmet_auth hash error handling

Hannes Reinecke (7):
      nvmet: add debugfs support
      nvmet: add 'host_traddr' callback for debugfs
      nvmet-tcp: implement host_traddr()
      nvmet-rdma: implement host_traddr()
      nvmet-fc: implement host_traddr()
      nvme-fcloop: implement 'host_traddr'
      lpfc_nvmet: implement 'host_traddr'

John Meneghini (1):
      nvme-multipath: prepare for "queue-depth" iopolicy

Keith Busch (6):
      nvme: apple: fix device reference counting
      nvme: tcp: split controller bringup handling
      nvme: rdma: split controller bringup handling
      nvme: fc: split controller bringup handling
      nvme: split device add from initialization
      nvme-pci: do not directly handle subsys reset fallout

Thomas Song (1):
      nvme-multipath: implement "queue-depth" iopolicy

Weiwen Hu (4):
      nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
      nvme: fix status magic numbers
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*
      mailmap: add entry for Weiwen Hu

 .mailmap                               |   1 +
 drivers/nvme/host/apple.c              |  32 +++++-
 drivers/nvme/host/constants.c          |   2 +-
 drivers/nvme/host/core.c               | 127 ++++++++++++++-------
 drivers/nvme/host/fabrics.c            |  25 +++-
 drivers/nvme/host/fabrics.h            |   1 +
 drivers/nvme/host/fault_inject.c       |   2 +-
 drivers/nvme/host/fc.c                 |  55 +++++----
 drivers/nvme/host/multipath.c          | 121 ++++++++++++++++++--
 drivers/nvme/host/nvme.h               |  28 ++---
 drivers/nvme/host/pci.c                |  41 +++++++
 drivers/nvme/host/pr.c                 |  10 +-
 drivers/nvme/host/rdma.c               |  34 ++++--
 drivers/nvme/host/tcp.c                |  31 ++++-
 drivers/nvme/target/Kconfig            |   9 ++
 drivers/nvme/target/Makefile           |   1 +
 drivers/nvme/target/admin-cmd.c        |  24 ++--
 drivers/nvme/target/auth.c             |  14 ++-
 drivers/nvme/target/core.c             |  76 +++++++++----
 drivers/nvme/target/debugfs.c          | 202 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h          |  42 +++++++
 drivers/nvme/target/discovery.c        |  14 +--
 drivers/nvme/target/fabrics-cmd-auth.c |  16 +--
 drivers/nvme/target/fabrics-cmd.c      |  36 +++---
 drivers/nvme/target/fc.c               |  33 ++++++
 drivers/nvme/target/fcloop.c           |  11 ++
 drivers/nvme/target/io-cmd-bdev.c      |  12 +-
 drivers/nvme/target/loop.c             |   5 +
 drivers/nvme/target/nvmet.h            |  12 +-
 drivers/nvme/target/passthru.c         |  10 +-
 drivers/nvme/target/rdma.c             |  22 +++-
 drivers/nvme/target/tcp.c              |  18 ++-
 drivers/nvme/target/zns.c              |  30 ++---
 drivers/scsi/lpfc/lpfc_nvmet.c         |  11 ++
 include/linux/nvme-fc-driver.h         |   4 +
 include/linux/nvme.h                   |  19 +++-
 36 files changed, 902 insertions(+), 229 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h


