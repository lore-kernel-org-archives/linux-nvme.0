Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9D9C6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XTBXPgJaAS/Rk+rOJ2daFp/gw2en9Iwyy0SadIzG7Oo=; b=x3/X7CNikEQz2FfHCXz5QFraTY
	zNt8denuY0uhwiwLTsPXd1IhFe9dbLWI5zbEEjl6HC2inc+/vV/c1/7asD547Sfok/zCfKPT+CnyD
	iFNMjFXOq8792d4sq3I26VLpI1+C2q+aQJPl4P/yb0h58wrvlNg1Pwgv0Cv2VvhnIwToAEObT3ifN
	5gft8ZGScHnQgTXj51/9exEcFarjiU2kI+19UAM6rhQWgLJoC1bgmhxC54WwsGBxL8HYrcJJhCjlV
	ETTagQLNW2GoQhgoMjCjZHYBTw+09HBJEKOyhoJRfZFN2R/vVgHSZ0RmzCOWsVV2R6U5GW5qHj+2H
	MTWf31iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pciVb-00FZV7-1Z;
	Thu, 16 Mar 2023 07:58:47 +0000
Received: from 213-225-12-242.nat.highway.a1.net ([213.225.12.242] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pciVZ-00FZUS-1r;
	Thu, 16 Mar 2023 07:58:45 +0000
Date: Thu, 16 Mar 2023 08:58:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZBLMMaLFyRsgOvGp@infradead.org>
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

The following changes since commit b6402014cab0481bdfd1ffff3e1dad714e8e1205:

  block: null_blk: cleanup null_queue_rq() (2023-03-15 06:50:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-16

for you to fetch changes up to 6173a77b7e9d3e202bdb9897b23f2a8afe7bf286:

  nvmet: avoid potential UAF in nvmet_req_complete() (2023-03-15 14:58:53 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - avoid potential UAF in nvmet_req_complete (Damien Le Moal)
 - more quirks (Elmer Miroslav Mosher Golovin, Philipp Geulen)
 - fix a memory leak in the nvme-pci probe teardown path (Irvin Cote)
 - repair the MAINTAINERS entry (Lukas Bulwahn)
 - fix handling single range discard request (Ming Lei)
 - show more opcode names in trace events (Minwoo Im)
 - fix nvme-tcp timeout reporting (Sagi Grimberg)

----------------------------------------------------------------
Damien Le Moal (1):
      nvmet: avoid potential UAF in nvmet_req_complete()

Elmer Miroslav Mosher Golovin (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000

Irvin Cote (1):
      nvme-pci: fixing memory leak in probe teardown path

Lukas Bulwahn (1):
      MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS

Ming Lei (1):
      nvme: fix handling single range discard request

Minwoo Im (1):
      nvme-trace: show more opcode names

Philipp Geulen (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620

Sagi Grimberg (2):
      nvme-tcp: fix opcode reporting in the timeout handler
      nvme-tcp: add nvme-tcp pdu size build protection

 MAINTAINERS                |  8 ++++----
 drivers/nvme/host/core.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/pci.c    |  5 +++++
 drivers/nvme/host/tcp.c    | 33 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c |  4 +++-
 include/linux/nvme.h       |  5 +++++
 6 files changed, 63 insertions(+), 20 deletions(-)

