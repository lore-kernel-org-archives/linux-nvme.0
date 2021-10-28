Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:30:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48FD6108F
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B48FD6108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=00vLC3ywJaxbSWyX1jfgr2zOVXdj2tUeKln34fWMng4=; b=2bLUEghKzEBslr0slk/h3yUBT3
	1iLx/crFylfMRbV0b4cdsPQlKVdxu3WPIxVSu3BSfjfcTLXXMlBnExtt9vexp1f7PwkD6b0Q8vpFR
	f+hLCOoHDXSLhwmLXcIvaIAZAgJ1DD0g0osAoK3fhj0xVsBWtHkR1XUKFOMlBoebI1qhd1cE52bZr
	daJLUybF/3tTXgTckg/UKTfucGCnWubfH1n08YrOR32ZmuR45CdYVGXU01vBSqONVKVP6Aaoot4uD
	6kpWlloTxuTuXCI41oGs/CCTgVJev/B/hiadbgLXxNWulIa4uhkVM3K91W+JBMByPdiZTn7uQKs5a
	La7OKjHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg6QW-008AlA-Nv; Thu, 28 Oct 2021 14:30:44 +0000
Received: from [2001:4bb8:199:7b1d:487c:3190:e387:3394] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg6Nu-0089gT-0r; Thu, 28 Oct 2021 14:28:02 +0000
Date: Thu, 28 Oct 2021 16:27:59 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.16
Message-ID: <YXqzb6dj0DCrIbGY@infradead.org>
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

The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:

  block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28

for you to fetch changes up to d156cfcafbd0eae4224ea007d95ebda467eb0c46:

  nvmet: use flex_array_size and struct_size (2021-10-27 08:06:41 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.16

 - support the current discovery subsystem entry (Hannes Reinecke)
 - use flex_array_size and struct_size (Len Baker)

----------------------------------------------------------------
Hannes Reinecke (3):
      nvme: add new discovery log page entry definitions
      nvmet: switch check for subsystem type
      nvmet: register discovery subsystem as 'current'

Len Baker (1):
      nvmet: use flex_array_size and struct_size

 drivers/nvme/host/multipath.c   |  2 +-
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/discovery.c | 17 +++++++++++------
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            | 19 ++++++++++++++++---
 6 files changed, 31 insertions(+), 12 deletions(-)

