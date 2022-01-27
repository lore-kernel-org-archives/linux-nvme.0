Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE89C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p2vjoJd92tcYa7NYh6W4PPS0sqzlcejZJmZ8SEX5nyM=; b=dbJXqX47nXdV/xJjKikldiwx8c
	M5CJROMAvBFsDtD/x7yGEudyVyixIWnwYUgBO18WnNcu7npiI5fE40XJTGfcbtduV59RNn97yis+U
	f84ByLkPX0dMisP5A0K7ja1hSOq3bTXXXz4wwr0obRgfzNPgR9CjT3CfYfepSJyFq+HkNwhvGKFa7
	UHs47UDG5wqaGbM0N4Smw7h9NJtjlEWgfF2cIVScmfir+aDI7nAzuXR9xMLogg99uDV5mA2+DHN3H
	oy9RfyCYFeL/YkWFXGTNYdAYo6f9/o5n1SDB+SzcaAVnmM38D/4v0yB2SXaCvelUsvENGtU9A1sVU
	k503+cMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCz42-00EcjW-JQ; Thu, 27 Jan 2022 07:19:26 +0000
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCz40-00EcjC-LF; Thu, 27 Jan 2022 07:19:25 +0000
Date: Thu, 27 Jan 2022 08:19:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YfJHeoRZIPt2t3aP@infradead.org>
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

The following changes since commit 83114df32ae779df57e0af99a8ba6c3968b2ba3d:

  block: fix memory leak in disk_register_independent_access_ranges (2022-01-23 09:13:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-01-27

for you to fetch changes up to a5f3851b7f7951e8d4ba0a9ba3b5308a5f250a2d:

  nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show (2022-01-27 08:17:17 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs (Wu Zheng)
 - remove the unneeded ret variable in nvmf_dev_show (Changcheng Deng)

----------------------------------------------------------------
Changcheng Deng (1):
      nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show

Wu Zheng (1):
      nvme-pci: add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs

 drivers/nvme/host/fabrics.c | 3 +--
 drivers/nvme/host/pci.c     | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

