Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE171ECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ROsJgpE9rEMRCM5qmh8UCJsLoFKZuXuJf1k45OIp/M=; b=NO676tiMSSVke/fWqEPlvGAiln
	l+CWJMkZbcUSmpcOeqeMoTs8uEurXhj8MbDDXp20k4RluPWn/xC/xIHQC3INGT0yUyF7D4IkvmVpU
	zgEdU/Wfpe+JvgIiMisZbkJ6hQmStdt7xRK+t/YIeqlxD1/A0ZwN40eDAVSCFlOKp9i25sFtKreCc
	/oUOvf4HMWhDJYUm0QQeTJ4jJbwRz/NHy2s/GnIjipVNOx9qBuov8u0tiumkFw3mAHISvR3hnj3RN
	Y4mS4+y2fJ49teiC6uFrVpvMvmnnHCpu9ZlUq2bjjeseB7fk858pd41LyAM0PHbvzpLM8QnlF0GlB
	xQKuv+VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3EZ-00Dg5R-IM; Thu, 27 Oct 2022 13:47:47 +0000
Received: from [88.128.92.137] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3E4-00DfsB-Rd; Thu, 27 Oct 2022 13:47:17 +0000
Date: Thu, 27 Oct 2022 15:47:03 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y1qL1zsNFc6w2WTd@infradead.org>
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

The following changes since commit 02341a08c9dec5a88527981b0bdf0fb6f7499cbf:

  block: fix memory leak for elevator on add_disk failure (2022-10-22 15:14:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-27

for you to fetch changes up to fe8714b04fb137aa62e9a69424c48b5301b721b9:

  nvme-multipath: set queue dma alignment to 3 (2022-10-25 08:07:53 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - make the multipath dma alignment to match the non-multipath one
   (Keith Busch)
 - fix a bogus use of sg_init_marker() (Nam Cao)
 - fix circulr locking in nvme-tcp (Sagi Grimberg)

----------------------------------------------------------------
Keith Busch (1):
      nvme-multipath: set queue dma alignment to 3

Nam Cao (1):
      nvme-tcp: replace sg_init_marker() with sg_init_table()

Sagi Grimberg (1):
      nvme-tcp: fix possible circular locking when deleting a controller under memory pressure

 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/tcp.c       | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

