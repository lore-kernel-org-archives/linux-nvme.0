Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB91BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FwyfvshCqsOyUWe+mRot2kKKs7MrlOQVeRHh4KfZtGk=; b=T5e2FzThOLOnvTK0ZY2p2G8PjS
	y52v2PWHbRNAn8HDZvsck0m4o3U2JsfvF1QOElDsZhW63ws3n676GyY7+tTfmzFBoPS/i/gnrwPYH
	0Uak2xA+aklFQdC+uXYrI/1bEqa5i3/vnrE9q/4O0UH3f4FqGMy4TftX/GrU9u4Jc+FoMp3OGsdqq
	V2P8gzAA3Nwan/9YOJ1AphmptJcCuWeSgrmZbugA7p1hD8wgUj+S1QQWDkH6koCA6qVh6vtkvkZyE
	7bey/ahUMofDWRHsbhe7ms4kSG85CSatwxO0Q/r7mh0TQwEPYjpcJgP14IKjVjWwUCrGLuI6rqVQv
	ET4LA0qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfECe-008aYj-Iz; Fri, 15 Apr 2022 05:09:04 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfE52-008Ve3-8Y; Fri, 15 Apr 2022 05:01:12 +0000
Date: Fri, 15 Apr 2022 07:01:09 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.18
Message-ID: <Ylj8FUYefzczGF92@infradead.org>
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

The following changes since commit 3e3876d322aef82416ecc496a4d4a587e0fdf7a3:

  block: null_blk: end timed out poll request (2022-04-14 10:16:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-04-15

for you to fetch changes up to 66dd346b84d79fde20832ed691a54f4881eac20d:

  nvme-pci: disable namespace identifiers for Qemu controllers (2022-04-15 06:56:17 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.18

 - tone down the error logging added this merge window a bit
   (Chaitanya Kulkarni)
 - quirk devices with non-unique unique identifiers (me)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: don't print verbose errors for internal passthrough requests

Christoph Hellwig (3):
      nvme: add a quirk to disable namespace identifiers
      nvme-pci: disable namespace identifiers for the MAXIO MAP1002/1202
      nvme-pci: disable namespace identifiers for Qemu controllers

 drivers/nvme/host/core.c | 27 ++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  9 ++++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

