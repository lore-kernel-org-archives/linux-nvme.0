Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2417C3ABA9
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f/rYEcwn8rWojhSbupuGw1x9rDfspVAzKTDyTUlJoUM=; b=DGDHC2ZtGPfTkdM75HdbjLP2+Z
	FYyS3/fumb3WR4e2z5SrMbray54UVC6cWmNG4Rkf2Zi++UZ+tH/E9eHcFiS/sngx/BTK3Golnm4n5
	lpHTCTwOSRcAA3RgUKC49FubW5pWsFok1jIioU7ehONwURoPfgluHuEIgLehDbMvzS3NebENm3OdB
	Q3NUyEhRfWDO6Br+yNL4Wf2omiLtVDVGFdFbc/DKN7qL8LlO2l97J0gJ/mQPr1mbCMoCEv1LsZPQR
	dA5tfNArzFoq551wwTDnjyPUGM/Gompwbx3rSXrC9qRa2225GVZyVx26GiK37nwrQ5LrlQeGR3x9g
	CxACCozg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAU88-0000000Fqga-1Z58;
	Thu, 01 May 2025 13:39:12 +0000
Received: from [104.254.106.146] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAU2U-0000000FpkN-40tc;
	Thu, 01 May 2025 13:33:23 +0000
Date: Thu, 1 May 2025 08:33:21 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aBN4IW2wlSfRIfjU@infradead.org>
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

The following changes since commit a584b2630b0d31f8a20e4ccb4de370b160177b8a:

  ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req (2025-04-29 06:01:36 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-01

for you to fetch changes up to 8edb86b2ed1d63cc400aecae8eb8c8114837171a:

  nvmet-auth: always free derived key data (2025-04-30 08:09:09 -0500)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix queue unquiesce check on PCI slot_reset (Keith Busch)
 - fix premature queue removal and I/O failover in nvme-tcp
   (Michael Liang)
 - don't restore null sk_state_change (Alistair Francis)
 - select CONFIG_TLS where needed (Alistair Francis)
 - always free derived key data (Hannes Reinecke)
 - more quirks (Wentao Guan)

----------------------------------------------------------------
Alistair Francis (3):
      nvme-tcp: select CONFIG_TLS from CONFIG_NVME_TCP_TLS
      nvmet-tcp: select CONFIG_TLS from CONFIG_NVME_TARGET_TCP_TLS
      nvmet-tcp: don't restore null sk_state_change

Hannes Reinecke (1):
      nvmet-auth: always free derived key data

Keith Busch (1):
      nvme-pci: fix queue unquiesce check on slot_reset

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Wentao Guan (2):
      nvme-pci: add quirks for device 126f:1001
      nvme-pci: add quirks for WDC Blue SN550 15b7:5009

 drivers/nvme/host/Kconfig   |  1 +
 drivers/nvme/host/pci.c     |  8 +++++++-
 drivers/nvme/host/tcp.c     | 31 +++++++++++++++++++++++++++++--
 drivers/nvme/target/Kconfig |  1 +
 drivers/nvme/target/auth.c  |  3 +--
 drivers/nvme/target/tcp.c   |  3 +++
 6 files changed, 42 insertions(+), 5 deletions(-)

