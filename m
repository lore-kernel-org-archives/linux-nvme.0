Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC4C7EE32
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LcZ98PyYXyygH9Qq0vaX6U6tOe0SgfK12YNTq+HbDHc=; b=OaucKTXqssamgq9zTspq3sJ+Wz
	OynK98WJbDNHEuPcvOQH7j6w3l0cXV+El9z3uqT6gaJZq/WiFeAzT2TTW7opORpz+Bwhiiodwr3hE
	MEkDrpCTSYuhtIoNMK4g5gqV9mJbSLeIZ0ECiX7roh09JFR+4pwZsYQxvYz/ybkBp8xIBi6kdNmCT
	BkgJVnotRfUTLcyJ3etUrHakkL4f16mYP0Cj1V7WjOwiFBTgA9ExqtEKk/p5a15aj/2EyMAtUfIwI
	3eBxQQ1akr61fofwbNUC11yJQMX8F3vberF0fN8Q/iXn57Em+hDuiLGQjraYwVC1+0dLsVVMNjPhC
	uAz4z/sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUlHW-0000000BUHH-06T4;
	Thu, 26 Jun 2025 12:00:42 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUkS5-0000000BMEH-2A7N;
	Thu, 26 Jun 2025 11:07:34 +0000
Date: Thu, 26 Jun 2025 13:07:28 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aF0p8PlTkmFvfDeW@infradead.org>
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

The following changes since commit dd2c18548964ae7ad48d208a765d909cd35448a1:

  nvme: reset delayed remove_work after reconnect (2025-06-26 13:04:35 +0200)

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

 drivers/nvme/host/core.c | 83 ++++++++++++++++++++++--------------------------
 drivers/nvme/host/nvme.h |  3 +-
 2 files changed, 39 insertions(+), 47 deletions(-)

