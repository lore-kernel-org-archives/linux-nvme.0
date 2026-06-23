Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F80CDB479
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OGasAkvsJ6n/6vhmY9NpjI3c/+Xz6byzRC1gDy76+aU=; b=aLN4c+PgQUqoqwHaNc1txRo7D5
	mPItUSPCVVT78tJ2cjxBP41NlS4DKSJIoe+4Q1sWMMTSJSDXvOlKSQJ0MttwyytcgfEBpmj8LWIDs
	UMkHxCmny39TEjC1tpQbMJHmqKuk7bn2Hleyqzo9OB3wkKewcCxlgeLXW6zaamTENjdPoKD6OpIjI
	nDsvFlwCPjuJCQ0AcNO3v/F6Ta9nOwdlKNKsfT+unv6bGbIpWx+Av9t5RL/XYDeB1qjZBfGYMRMEP
	C6IE7EOor0wwIMZDtrZsVBYxD8JYdd/ZMfWj0TH442oTfeMEVkASv0RfSdbdT0XzjS2tYD4JSwGuQ
	/9HmNy9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2Pa-00000006TmT-2aWJ;
	Tue, 23 Jun 2026 14:47:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2PZ-00000006TmJ-00xA
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 14:47:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 62BBC405FC;
	Tue, 23 Jun 2026 14:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD221F00A3A;
	Tue, 23 Jun 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782226056;
	bh=OGasAkvsJ6n/6vhmY9NpjI3c/+Xz6byzRC1gDy76+aU=;
	h=Date:From:To:Cc:Subject;
	b=hwrSJVDEabrLh7S0kSNx9t4RZbojRot4hMLtCnXXCIxKk9uheVIPe0fDISH3EpkMN
	 9YD577LC3YkvpUcWmhlsb2JMTr8nQmO40tmmSN309PgmH4YvDRZqH6NIWDJbgYfnyb
	 cWxIH/C4rqFbjU4YhYFsSnBFrqIe2H8iA1Tiu8SbWxhsvj+gdkadcgKLaJaXYNjLOc
	 dLpPljlDocyorc7k7BgGW34OurYLO/hN7/NSgIVZjEPx4l+uW3xM/9RCWi+wwm8l5A
	 O185kzUtSFFVl/0Ibq55GI7S5tIEh5JYNUNS0gAEsLPT8rf1/NNF+OsSyKOEpSqv7B
	 zRQdmXxGsd4Cg==
Date: Tue, 23 Jun 2026 08:47:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 7.2
Message-ID: <ajqchuQAz534Erac@kbusch-mbp>
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

The following changes since commit 7ed4aab1381f3439f45032eb860f89d9da5e45c2:

  block: optimize I/O merge hot path with unlikely() hints (2026-06-08 07:46:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.2-2026-06-23

for you to fetch changes up to 7d953c75f0a3f905aadf3675c9394a5b9d9897bf:

  nvmet-tcp: handle TCP_CLOSING state in nvmet_tcp_state_change (2026-06-10 08:14:19 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.2

 - Apple A11 quirk for sharing tags across admin and IO queues (Nick)
 - Target fix for short AUTH_RECEIVE buffers (Michael)
 - Target fix for SQ refcount leak (Wentao)
 - Target RDMA handling inline data with nonzero offset (Bryam)
 - Target TCP fix handling the TCP_CLOSING state (Maurizio)
 - FC abort fixes in early initialization (Mohamed)
 - Controller device teardown fixes (Maurizio, John)
 - Allocate the target ana_state with the port (Rosen)
 - Quieten sparse and sysfs symbol warnings (John)

----------------------------------------------------------------
Bryam Vargas (1):
      nvmet-rdma: handle inline data with a nonzero offset

John Garry (3):
      nvme: quieten sparse warning in valid LBA size check
      nvme: make some sysfs diagnostic structures static
      nvme: make nvme_add_ns{_head}_cdev return void

Maurizio Lombardi (2):
      nvme: fix crash and memory leak during invalid cdev teardown
      nvmet-tcp: handle TCP_CLOSING state in nvmet_tcp_state_change

Michael Bommarito (1):
      nvmet-auth: reject short AUTH_RECEIVE buffers

Mohamed Khalfella (1):
      nvme-fc: Do not cancel requests in io target before it is initialized

Nick Chan (1):
      nvme-apple: Prevent shared tags across queues on Apple A11

Rosen Penev (1):
      nvme: target: allocate ana_state with port

Wentao Liang (1):
      nvmet: fix refcount leak in nvmet_sq_create()

 drivers/nvme/host/apple.c              | 12 +++------
 drivers/nvme/host/core.c               | 45 ++++++++++++++++++++++------------
 drivers/nvme/host/fc.c                 |  7 +++++-
 drivers/nvme/host/multipath.c          | 24 ++++++++++--------
 drivers/nvme/host/nvme.h               |  5 +++-
 drivers/nvme/host/sysfs.c              |  6 ++---
 drivers/nvme/target/configfs.c         |  9 +------
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 26 +++++++++++++++++++-
 drivers/nvme/target/nvmet.h            |  2 +-
 drivers/nvme/target/rdma.c             | 18 ++++++++------
 drivers/nvme/target/tcp.c              |  1 +
 12 files changed, 100 insertions(+), 57 deletions(-)


