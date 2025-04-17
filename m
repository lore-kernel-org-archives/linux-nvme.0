Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27832C369C7
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c9kni1jFYiyoXztyV0kzepCImzHwZJUkBjwKuQf090w=; b=Bh2J/WkDzHFSKjIbji1TLqGihU
	g1d/mVnDJhXiwUmZQ7BQYZCG2mZmEcrHsml0jbm+1m5NLvkSm21EFXQrXYHz+DN4D1nIzimy4uMv4
	PB3e8IlL+vI99UoZcL6YbO12PCo8Jd2S0bAfKEV57WPW2lZ6oZFJGklkEFY5C0pswIrhjF8uQLGBs
	Xk6i3G08f3k32V5DHpM0AIqnpjBVpy8pXGReGNquvtUEKklxQkjmf8m82/zzMN0m5IlR8xo80dlWk
	/rbIBlWPKYmxnP/u7ARXRDYlZHwxwnNt195AD/DL/JiaOwYOxQZ74qDioaT2Vc5ztAEeT7N1aWBLx
	jdTikBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5J8g-0000000By6p-1FHW;
	Thu, 17 Apr 2025 06:54:22 +0000
Received: from 089144221046.atnat0030.highway.webapn.at ([89.144.221.46] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5J1e-0000000Bwpo-0SlH;
	Thu, 17 Apr 2025 06:47:06 +0000
Date: Thu, 17 Apr 2025 08:47:02 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aACj5pg7dLAsfZ1u@infradead.org>
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

The following changes since commit 0b7a4817756c7906d0a8112c953ce88d7cd8d4c6:

  ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y (2025-04-15 18:59:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-17

for you to fetch changes up to ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7:

  nvmet: pci-epf: cleanup link state management (2025-04-16 07:37:37 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix scan failure for non-ANA multipath controllers (Hannes Reinecke)
 - fix multipath sysfs links creation for some cases (Hannes Reinecke)
 - PCIe endpoint fixes (Damien Le Moal)
 - use NULL instead of 0 in the auth code (Damien Le Moal)

----------------------------------------------------------------
Damien Le Moal (4):
      nvmet: auth: use NULL to clear a pointer in nvmet_auth_sq_free()
      nvmet: pci-epf: always fully initialize completion entries
      nvmet: pci-epf: clear CC and CSTS when disabling the controller
      nvmet: pci-epf: cleanup link state management

Hannes Reinecke (2):
      nvme: fixup scan failure for non-ANA multipath controllers
      nvme-multipath: sysfs links may not be created for devices

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 14 +++----
 drivers/nvme/target/auth.c    |  2 +-
 drivers/nvme/target/pci-epf.c | 88 ++++++++++++++++++++++++++++---------------
 4 files changed, 67 insertions(+), 39 deletions(-)

