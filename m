Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E75FC7EE30
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hl2AecGxpLcBXJzUH+GHlQKWZ1rBYMu0o0Q5xXYl65o=; b=ckf6WatKx7Sq9B7q5cegNnQJKf
	Kz+bTqBxAhG6BLg5tm4GeLa24w3U5iZkqyQhRug8Ot5itZqpVAAhPeCLyS9GC7s8IvorQ7eiBQ+iO
	bZIUEzWO8v8IEKbEvvb3O7FBgYCglCv8/E8EJTCCr/xKRzITkKORV77c7XFoW3PW1LMXfAtDw4ZXX
	yc3FZUyqExVrSo3VBVkzcj+qROzLFXSkdNzW7wKUd4avGx6x23EL+8ypu2Z/ZTdtSPBQ6YEXaRCzp
	pg7TJ3dtqoKlCAYYnTyS2BxOVdTNTMvNPHAPfKnB1af3eIG5/ict45FPUI/AmwD+X3nWjAI7GrUL1
	0K2NcvAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmSC-0000000BdaN-2O38;
	Thu, 26 Jun 2025 13:15:48 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmS9-0000000BdZH-49wO;
	Thu, 26 Jun 2025 13:15:46 +0000
Date: Thu, 26 Jun 2025 15:15:43 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL, resend] nvme updates for Linux 6.16
Message-ID: <aF1H_345SuVYxoCW@infradead.org>
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

[note that the commit dates are very recent.  That is because somehow the
tree the ran through the build bot had me as the author for the commit
from Keith, so I did a metadata only rebase just now to fix that]

The following changes since commit 4c8a951787ffc4b61a547db9866196104971b5fd:

  ublk: setup ublk_io correctly in case of ublk_get_data() failure (2025-06-24 20:45:31 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-26

for you to fetch changes up to f46d273449ba65afd53f3dd8fe0182c9df877e08:

  nvme: fix atomic write size validation (2025-06-26 13:04:37 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.16

 - reset delayed remove_work after reconnect (Keith Busch)
 - fix atomic write size validation (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation

Keith Busch (1):
      nvme: reset delayed remove_work after reconnect

 drivers/nvme/host/core.c      | 87 +++++++++++++++++++++----------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  3 +-
 3 files changed, 44 insertions(+), 48 deletions(-)

