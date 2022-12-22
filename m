Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331DAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/f2XEf/Fa2fRDROPNECEjqK+VdtLUPh4SVKjpPIIJdU=; b=vycJDpiyj83FVkBtkHjIOOs0t8
	V08pM80taYVFI570QY3Bf5/svka2KkanG3MChyFgOCplUGtvR7HbwCOVOu46YzwuEdcd/nKRKS1Xb
	Bu5cqfnduABwDpUkI8PNb6ro0o8zJX6nfVhJl1D1kJBwAL+Pt3T+Zqmlv0N+5yQgsLhs64iVt6W7c
	HHj8t6fekjjIvOVy1XVTRdGVUBcVx2HlVVAUmvWjO2F+Xd7vtLmJRfND5tYlaC+zQ3epLR8AzEVhA
	io1o2Zt3U9GSKfThux0TkN2Xlqp//ErCHKPmnqpbizq3dgde97xo8mrReJe3lSIKZT+xF/pX1+Ma1
	wNfEx3Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8NoM-00DhDp-9L; Thu, 22 Dec 2022 15:48:46 +0000
Received: from [2001:4bb8:199:7829:d328:c3ff:20ad:37] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8NjZ-00DejP-8D; Thu, 22 Dec 2022 15:43:49 +0000
Date: Thu, 22 Dec 2022 16:43:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y6R7MBrn2xzmwT1J@infradead.org>
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

The following changes since commit 53eab8e76667b124615a943a033cdf97c80c242a:

  block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-22

for you to fetch changes up to 3659fb5ac29a5e6102bebe494ac789fd47fb78f4:

  nvme: fix multipath crash caused by flush request when blktrace is enabled (2022-12-22 09:40:27 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix doorbell buffer value endianness (Klaus Jensen)
 - fix Linux vs NVMe page size mismatch (Keith Busch)
 - fix a potential use memory access beyong the allocation limit
   (Keith Busch)
 - fix a multipath vs blktrace NULL pointer dereference
   (Yanjun Zhang)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: fix mempool alloc size
      nvme-pci: fix page size checks

Klaus Jensen (1):
      nvme-pci: fix doorbell buffer value endianness

Yanjun Zhang (1):
      nvme: fix multipath crash caused by flush request when blktrace is enabled

 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  | 37 +++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

