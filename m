Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3525C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NJllDt/tGBBHR8YkJulvsU7yOqGtD9huZUiRyzH8+0k=; b=lXb8rkIAC5ep6J/eJ1eRq1GwWA
	ijKQatn4AN3l4UoOKntgtV7EGcwemQywlXaP2JHW1LWegO/1PxqDzJQFJAtI2qrT63ZOurONUVez/
	c7ZHiL3Wd82imDdtwRdRZJOUFpNHZal6Vxt3PSzdR5DxWuTUwFoR/MX6aBmMCBpjzafTx+mGLhrHK
	K/xPjyFwbX/nImGIqgrP552qmD/CfJfbfHso9T83k/tGSJ2232iw5VPd7sfZeRt0YE77VmQji4n4i
	jJQofVzL9LgHMIqUBSVCs9HV5O8IKnPxxEkmHKwzqewOPwYVtELbZjkkPcuAqsFR/uElfKVIg/Md/
	MUi4xOOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi0tN-005Efg-32;
	Thu, 30 Mar 2023 22:37:13 +0000
Received: from [182.171.77.115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pi0tK-005EfC-35;
	Thu, 30 Mar 2023 22:37:11 +0000
Date: Fri, 31 Mar 2023 07:37:06 +0900
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZCYPEl0cfKtOlkU8@infradead.org>
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

The following changes since commit bb430b69422640891b0b8db762885730579a4145:

  loop: LOOP_CONFIGURE: send uevents for partitions (2023-03-27 13:27:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-31

for you to fetch changes up to 88eaba80328b31ef81813a1207b4056efd7006a6:

  nvme-tcp: fix a possible UAF when failing to allocate an io queue (2023-03-30 11:24:33 +0900)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - mark Lexar NM760 as IGNORE_DEV_SUBNQN (Juraj Pecigos)
 - fix a possible UAF when failing to allocate an TCP io queue
   (Sagi Grimberg)

----------------------------------------------------------------
Juraj Pecigos (1):
      nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN

Sagi Grimberg (1):
      nvme-tcp: fix a possible UAF when failing to allocate an io queue

 drivers/nvme/host/pci.c |  3 ++-
 drivers/nvme/host/tcp.c | 46 ++++++++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

