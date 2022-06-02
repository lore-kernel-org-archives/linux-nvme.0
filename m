Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AE6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 05:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5TNlqvLrz3phczbzU5AJU0+CyFLEnpzfxRuuPLATMYk=; b=wmRB8aN5zBtudLxff0YRiMrN/l
	RHquEe7bRt5eH5V9dUArJ+n01S/nhxiydMpdouo3hEHbJBkopzRKZPCS3sKvZPd9AulzaaNsNkoFe
	ar6m1/GWVbrBO6+D/opzA6JO2fsjkrHRBJkZoSH4To7tOnTIK6duNHMGAMAmoE3VDjv0c1tN3RhaA
	+ugOBPiOmjDUZE0MuAaoIoc2IIIAned+UjjwWySRADSwN0QmjbZzxRzblmRz+TkNylYZSz+v22/3r
	R8hoVYIPyowM42tB40N4DE32nCCGlgII0GRK+bDWvRt3jpWmMEauuXmrFTsTklktlC+FPA25QgjNQ
	+bw4Kduw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwdNP-001RyS-5Z; Thu, 02 Jun 2022 05:28:07 +0000
Received: from 213-225-2-232.nat.highway.a1.net ([213.225.2.232] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwdNN-001Rxv-Dq; Thu, 02 Jun 2022 05:28:05 +0000
Date: Thu, 2 Jun 2022 07:28:04 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YphKZBtmtKFRNIPL@infradead.org>
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

The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:

  bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02

for you to fetch changes up to cbf84dbf0600b0efe1134cc3f98ae29c523a3a23:

  nvmet: fix typo in comment (2022-05-31 07:41:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - set controller enable bit in a separate write (Niklas Cassel)
 - disable namespace identifiers for the MAXIO MAP1001 (me)
 - fix a comment typo (Julia Lawall)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: disable namespace identifiers for the MAXIO MAP1001

Julia Lawall (1):
      nvmet: fix typo in comment

Niklas Cassel (1):
      nvme: set controller enable bit in a separate write

 drivers/nvme/host/core.c       | 10 +++++++++-
 drivers/nvme/host/pci.c        |  2 ++
 drivers/nvme/target/passthru.c |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

