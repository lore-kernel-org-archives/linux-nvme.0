Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A3FC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xhTmDKWbL2Q+ADomHwmZKFLODShjxozhC5a0dwbcc4k=; b=YORljWQQLd7tyrGBHWNQTClT53
	AgENJIpvLvetLIXpwCoArkus4+aIz0DLHlBY6jJPGbk7YLNv4Rset1b2qkm3gYq/H1LKQ/mzDB7hV
	7GfM474e1zUKhEILXAfBVmICErkSrdgX1tj0P8mW8hbAu07d7mH36i6wisv3tnT1uPXCOWQaiBFRO
	+K4K7JDd4VcZdHt+Uvwqlk3EPTu0lqa6lNgPCSxTolR7CMUBYjTa9JcMbE2UB9YmoJXTQnoM4i/GA
	VnUYQVOKQB8AWI27VU65LR6ikK2M49hSIwZstt9ydWwJ+f0w9N81Qzuv7eZgAn+frJIHXwI36gLEF
	ToW1NVpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNbQh-00GKAz-3n; Thu, 02 Feb 2023 15:23:15 +0000
Received: from [2001:4bb8:19a:272a:3196:5eba:213b:e6aa] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNbQe-00GK9B-QC; Thu, 02 Feb 2023 15:23:13 +0000
Date: Thu, 2 Feb 2023 16:23:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y9vVXvMeTgA4bC2R@infradead.org>
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

The following changes since commit 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0:

  block: Fix the blk_mq_destroy_queue() documentation (2023-01-31 11:46:15 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-02

for you to fetch changes up to bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd:

  nvme-auth: use workqueue dedicated to authentication (2023-02-01 16:11:20 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix a missing queue put in nvmet_fc_ls_create_association (Amit Engel)
 - clear queue pointers on tag_set initialization failure
   (Maurizio Lombardi)
 - use workqueue dedicated to authentication (Shin'ichiro Kawasaki)

----------------------------------------------------------------
Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Maurizio Lombardi (2):
      nvme: clear the request_queue pointers on failure in nvme_alloc_admin_tag_set
      nvme: clear the request_queue pointers on failure in nvme_alloc_io_tag_set

Shin'ichiro Kawasaki (1):
      nvme-auth: use workqueue dedicated to authentication

 drivers/nvme/host/auth.c | 14 ++++++++++++--
 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/target/fc.c |  4 +++-
 3 files changed, 19 insertions(+), 4 deletions(-)

