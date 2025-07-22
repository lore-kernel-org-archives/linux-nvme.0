Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A6EC83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L8O+JavWYdIu/uRuDiGUA+k1UuTdTqMRcqDi9Y6C2Kc=; b=0SYtaECSRJdY3uVDy77GHm5qZy
	V/eN8lFhpWwqZuBQ4lBUT1g/5x4nMrbGcbOyuZ/CtQJpY24Y9r310okVhPxTPGX97WJ2AjmyKVvvo
	oMjO5hKyV0lrQ08fWWdV6UQ1LUAV5k5T4rum6oHcuB0WKrYE4rgqAp3awjHHPUaEYXpH+AUCT+TWQ
	AML2XfMNtqYro0wYQFpC02cJ+K1/Lc8kAbfo+YWyowVWnOxz0nr/8uAHNlYDFsi07TLnTmTf8hVM5
	kCgtxKSzD6bnqlUtDcUbew18Fk6wSyrsR7MSDEMoB0b7kLH+OTe/tY9+o7w6OuD8Ndw8zx2PUpco7
	Rw/bAnHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue67a-00000001OLK-05pw;
	Tue, 22 Jul 2025 06:05:02 +0000
Received: from [81.144.254.34] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue67X-00000001OKp-1szm;
	Tue, 22 Jul 2025 06:04:59 +0000
Date: Tue, 22 Jul 2025 07:04:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.17
Message-ID: <aH8qCeSvpt3eH5g_@infradead.org>
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

The following changes since commit ab17ead0e0ee8650cd1cf4e481b1ed0ee9731956:

  block: fix blk_zone_append_update_request_bio() kernel-doc (2025-07-16 10:02:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-22

for you to fetch changes up to 5b2c214a95942f7997d1916a4c44017becbc3cac:

  nvme-pci: try function level reset on init failure (2025-07-17 17:46:33 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.17

 - try PCIe function level reset on init failure (Keith Busch)
 - log TLS handshake failures at error level (Maurizio Lombardi)
 - pci-epf: do not complete commands twice if nvmet_req_init() fails
   (Rick Wertenbroek)
 - misc cleanups (Alok Tiwari)

----------------------------------------------------------------
Alok Tiwari (5):
      nvme: fix multiple spelling and grammar issues in host drivers
      nvme: fix incorrect variable in io cqes error message
      nvmet: remove redundant assignment of error code in nvmet_ns_enable()
      nvme: fix typo in status code constant for self-test in progress
      docs: nvme: fix grammar in nvme-pci-endpoint-target.rst

Keith Busch (1):
      nvme-pci: try function level reset on init failure

Maurizio Lombardi (1):
      nvme-tcp: log TLS handshake failures at error level

Rick Wertenbroek (1):
      nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails

 Documentation/nvme/nvme-pci-endpoint-target.rst | 22 ++++++++++-----------
 drivers/nvme/host/apple.c                       |  4 ++--
 drivers/nvme/host/constants.c                   |  4 ++--
 drivers/nvme/host/core.c                        |  2 +-
 drivers/nvme/host/fc.c                          | 10 +++++-----
 drivers/nvme/host/nvme.h                        |  2 +-
 drivers/nvme/host/pci.c                         | 26 ++++++++++++++++++++++---
 drivers/nvme/host/rdma.c                        |  2 +-
 drivers/nvme/host/tcp.c                         | 11 ++++++++---
 drivers/nvme/target/core.c                      |  2 --
 drivers/nvme/target/passthru.c                  |  4 ++--
 drivers/nvme/target/pci-epf.c                   | 25 ++++++++++++++++--------
 drivers/nvme/target/zns.c                       |  2 +-
 include/linux/nvme.h                            |  2 +-
 14 files changed, 75 insertions(+), 43 deletions(-)

