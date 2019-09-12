Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B9C4CEC6
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 16:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DEE20830
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sOdykTMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DEE20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KgHGqCk+EmciBXnhphG2FD4iF7Ue0+/ihjqXIISx+po=; b=sOd
	ykTMGNnHTajYo/d90fo/hBReo2CA7frcccyDi6diBxzCf+zFV+3Z8C4w3UvH4Cgq6YNS9WTqVYqF0
	VNIB3cgftX3OKAShFPDEzKFXNtaaCNq+9zN70aPbEpCMN9J+AH+IjJIt2Q7aynDfZ1ncmMHDpfn3S
	3IJHtaIl+G0+sCvBy24rxyxnbxBXL1ENaRQkH62xXdke16e6vYTA5IAP5hq6FCMtTzgrJVst+lAmS
	qJQQsimLOelP5lPZnKX16S5FhspkoUiglWjwEPT5WjNLr5y/6osgVqx2bfvrTQkzxXB9RCTnptUKt
	/z2m2HofgpdYqgHg1Yt3EAK7VS4WwUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8SAN-0006Gi-8T; Thu, 12 Sep 2019 16:41:55 +0000
Received: from [2601:647:4800:973f:c36:579b:9814:69b7]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8SAK-0006GY-LM; Thu, 12 Sep 2019 16:41:52 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] second round of nvme updates for 5.4
Date: Thu, 12 Sep 2019 09:41:51 -0700
Message-Id: <20190912164151.7788-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Jens,

This is the second batch of nvme updates for 5.4.

Highlights includes:
- controller reset and namespace scan races fixes
- nvme discovery log change uevent support
- naming improvements from Keith
- multiple discovery controllers reject fix from James
- some regular cleanups from various people

The following changes since commit 0a67b5a926e63ff5492c3c675eab5900580d056d:

  block: fix race between switching elevator and removing queues (2019-09-12 07:13:22 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4 

for you to fetch changes up to 5f8badbcbeac298a77ee634a10a375f3e66923f9:

  nvmet: fix a wrong error status returned in error log page (2019-09-12 08:50:46 -0700)

----------------------------------------------------------------
Amit (1):
      nvmet: fix a wrong error status returned in error log page

Colin Ian King (1):
      nvme: tcp: remove redundant assignment to variable ret

Edmund Nadolski (1):
      nvme: include admin_q sync with nvme_sync_queues

Israel Rukshin (1):
      nvme: Remove redundant assignment of cq vector

James Smart (2):
      nvme-fc: Fail transport errors with NVME_SC_HOST_PATH
      nvme: Treat discovery subsystems as unique subsystems

Keith Busch (1):
      nvme: Assign subsys instance from first ctrl

Markus Elfring (1):
      nvmet: Use PTR_ERR_OR_ZERO() in nvmet_init_discovery()

Sagi Grimberg (10):
      nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
      nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
      nvme: pass status to nvme_error_status
      nvme: make nvme_identify_ns propagate errors back
      nvme: make nvme_report_ns_ids propagate error back
      nvme: fix ns removal hang when failing to revalidate due to a transient error
      nvme-fabrics: allow discovery subsystems accept a kato
      nvme: enable aen regardless of the presence of I/O queues
      nvme: add uevent variables for controller devices
      nvme: send discovery log page change events to userspace

 drivers/nvme/host/core.c        | 158 +++++++++++++++++++++++++++++-----------
 drivers/nvme/host/fabrics.c     |  12 +--
 drivers/nvme/host/fc.c          |  37 ++++++++--
 drivers/nvme/host/pci.c         |   1 -
 drivers/nvme/host/tcp.c         |   4 +-
 drivers/nvme/target/admin-cmd.c |   8 +-
 drivers/nvme/target/discovery.c |   4 +-
 7 files changed, 153 insertions(+), 71 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
