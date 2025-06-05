Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1DFC5B543
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jun 2025 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YYjeuCcthxQp2Rj4IBlNgZmfsGf7h2Z1vLxzsw/HV+g=; b=LbW7LSbU/QRmfYh5Ggu9y298+7
	W3TRRYGvCZ3bmeOF5GorkZRR36hnc4o7wQ1sKl5/j4pY2vpqmektbwZKj0zLtdEkrx+TLPkJtKTGJ
	zVTIliEJ20gSwrr+U05DqwZ95YBIXhq4TOGMIA2ZOVaHKNRUp9g+6xe4aJc9aeCI42oRQO6oKMEsr
	3ZaZp+1yBi9+jI/Hd/mvyC0psrAx81CFlZsrKQxcILIjsl5J8MphvRL3FWMaWZitXB9WqbUScGaEo
	ruTM3KQzEJr6sg7qWacIE87y0iK6UXN+qGyw7GzzrDYyV9kq7ZEHd8u0bW8Ss6WNMdxn9OUPZL/UU
	WGdGMPdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6zJ-0000000FAXg-3jGs;
	Thu, 05 Jun 2025 09:34:17 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6zD-0000000FAWy-0DwF;
	Thu, 05 Jun 2025 09:34:11 +0000
Date: Thu, 5 Jun 2025 11:34:07 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aEFkj8jfrDVGuG4_@infradead.org>
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

The following changes since commit a2f4c1ae163b815dc81e3cab97c3149fdc6639e3:

  selftests: ublk: kublk: improve behavior on init failure (2025-06-03 20:19:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-05

for you to fetch changes up to 44e479d7202070c3bc7f084a4951ee8689769f71:

  nvme: spelling fixes (2025-06-04 10:23:28 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.16

 - TCP error handling fix (Shin'ichiro Kawasaki)
 - TCP I/O stall handling fixes (Hannes Reinecke)
 - fix command limits status code (Keith Busch)
 - support vectored buffers also for passthrough (Pavel Begunkov)
 - spelling fixes (Yi Zhang)

----------------------------------------------------------------
Hannes Reinecke (2):
      nvme-tcp: sanitize request list handling
      nvme-tcp: fix I/O stalls on congested sockets

Keith Busch (1):
      nvme: fix command limits status code

Pavel Begunkov (2):
      nvme: fix implicit bool to flags conversion
      nvme: enable vectored registered bufs for passthrough cmds

Shin'ichiro Kawasaki (1):
      nvme-tcp: remove tag set when second admin queue config fails

Yi Zhang (1):
      nvme: spelling fixes

 drivers/nvme/common/auth.c        |  6 +++---
 drivers/nvme/host/Kconfig         |  2 +-
 drivers/nvme/host/constants.c     |  2 +-
 drivers/nvme/host/core.c          |  3 +--
 drivers/nvme/host/fabrics.c       |  2 +-
 drivers/nvme/host/fabrics.h       |  6 +++---
 drivers/nvme/host/fc.c            |  4 ++--
 drivers/nvme/host/ioctl.c         | 18 ++++++++++--------
 drivers/nvme/host/multipath.c     |  2 +-
 drivers/nvme/host/nvme.h          |  2 +-
 drivers/nvme/host/pci.c           |  4 ++--
 drivers/nvme/host/pr.c            |  2 --
 drivers/nvme/host/rdma.c          |  4 ++--
 drivers/nvme/host/tcp.c           | 24 +++++++++++++++++++++---
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 11 ++---------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/io-cmd-bdev.c | 11 ++---------
 drivers/nvme/target/passthru.c    |  2 +-
 include/linux/nvme.h              |  2 +-
 20 files changed, 57 insertions(+), 54 deletions(-)

