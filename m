Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAECC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Olw5KXnhihAXNLgi8gB31e2MWGWril1WP4iwNiYTYJs=; b=3SQky/KRsfgtAkOkQbBb+XFak1
	osQ7s0w2u4pxLlnACXdo5EFkP5ynnDKNVIZIkDYwryhzoSe8wPVJyoFP6kKv4CDpV30xRQTNPjgEM
	Q2ay7FAPOarw0jLNT/P2BNuRAFtmYXDxTAvwwA77TAlz90/opJtwO4I1Jb3f1HZxHiu0me5PLFQW0
	NuJVg5UeSSJthqHo7PmY3pVetHOJSJlUQMwYiM+PzgQdu3krPIlxmWbFrHOWHJL1zBOr+irGb9wJu
	XPIM9C9QSt7BFRN2Z32Rt5121rRQcUR40X9xhw+NDrlHXrXrVFz44nYP8YX3LDuKrXdi1C28SfZKO
	Ga9+F/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1TD6-00EkFf-4C; Wed, 15 Jun 2022 13:37:28 +0000
Received: from 213-147-167-122.nat.highway.webapn.at ([213.147.167.122] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1TD3-00EkEX-G6; Wed, 15 Jun 2022 13:37:26 +0000
Date: Wed, 15 Jun 2022 15:37:21 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YqngkWynuVHY+aDS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-15

for you to fetch changes up to 43047e082b90ead395c44b0e8497bc853bd13845:

  nvme-pci: disable write zeros support on UMIC and Samsung SSDs (2022-06-13 19:56:57 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - quirks, quirks, quirks to work around buggy consumer grade devices
   (Keith Bush, Ning Wang, Stefan Reiter, Rasheed Hsueh)
 - better kernel messages for devices that need quirking (Keith Bush)
 - make a kernel message more useful (Thomas Weiﬂschuh)

----------------------------------------------------------------
Keith Busch (5):
      nvme: add bug report info for global duplicate id
      nvme-pci: add trouble shooting steps for timeouts
      nvme-pci: phison e12 has bogus namespace ids
      nvme-pci: smi has bogus namespace ids
      nvme-pci: sk hynix p31 has bogus namespace ids

Ning Wang (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs

Stefan Reiter (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50

Thomas Weiﬂschuh (1):
      nvme: add device name to warning in uuid_show()

rasheed.hsueh (1):
      nvme-pci: disable write zeros support on UMIC and Samsung SSDs

 drivers/nvme/host/core.c |  5 +++--
 drivers/nvme/host/nvme.h | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 3 deletions(-)

