Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58803C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AaC8Wv8Wgc19tv6DjaGWjM6l0GS6aervzG+1mS2H99k=; b=mWTPqDdAJnhxQZ8UHE18pBuSHi
	78xJR7B9WYjK/t96doqc3LqMTqVpeRt/9z2tdJqkobtutUaimUjYIPZxyLx3pohDa5vjALg9J3sfV
	hbEg3mr35VSTMs+DXbL9kZgZyqSPF7dKCb/aR3QVV6oM2oc54/qe1uSZEQ9UFvejBV8db1CLwlHxt
	6v9TTDuOpm1CC3UQQXt0eo6tFuyU+WfV9p8HTpyVjgjYMeM/X/0ZRgxnXYGf2qkXhq6JJWDMEYpZf
	EXg7dJQ7kM+RZ+gNFp/JlGnY6uDqI1h+D5fuM0Lzs2+JY+L6zl/gFWNpSdtjjH4wCxTKDIGhGT74c
	sPjthERA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrDSb-00HTNE-Ay; Wed, 18 May 2022 06:47:05 +0000
Received: from [2001:4bb8:19a:7bdf:8143:492c:c3b:39b6] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrDSZ-00HTMT-SB; Wed, 18 May 2022 06:47:04 +0000
Date: Wed, 18 May 2022 08:47:02 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.19
Message-ID: <YoSWZoB1/38DdP4S@infradead.org>
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

The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:

  loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-18

for you to fetch changes up to e626f37e657adbab2a7abe51480925891662a5f3:

  nvme: split the enum used for various register constants (2022-05-17 07:33:27 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.19

 - tighten the PCI presence check (Stefan Roese):
 - fix a potential NULL pointer dereference in an error path
   (Kyle Miller Smith)
 - fix interpretation of the DMRSL field (Tom Yan)
 - relax the data transfer alignment (Keith Busch)
 - verbose error logging improvements (Max Gurtovoy, Chaitanya Kulkarni)
 - misc cleanups (Chaitanya Kulkarni, me)

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme: mark internal passthru request RQF_QUIET
      nvme-fabrics: add a request timeout helper

Christoph Hellwig (1):
      nvme: split the enum used for various register constants

Keith Busch (1):
      nvme: set dma alignment to dword

Max Gurtovoy (2):
      nvme: add missing status values to verbose logging
      nvme: remove unneeded include from constants file

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Stefan Roese (1):
      nvme-pci: harden drive presence detect in nvme_dev_disable()

Tom Yan (1):
      nvme: fix interpretation of DMRSL

 drivers/nvme/host/constants.c |  4 +++-
 drivers/nvme/host/core.c      |  9 ++++++---
 drivers/nvme/host/fabrics.h   |  8 ++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  5 ++++-
 drivers/nvme/host/rdma.c      |  5 +----
 drivers/nvme/host/tcp.c       |  5 +----
 include/linux/nvme.h          | 15 +++++++++++++--
 8 files changed, 37 insertions(+), 15 deletions(-)

