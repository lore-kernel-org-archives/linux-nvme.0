Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78858C021B2
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 00:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WJ0MaikbZtOnnh9jqUYxg2wsBzbxNQ6H8bt7sFClI48=; b=tZu2Kjb7J8hF3MiP8J8wsWeAE5
	yGNT/dH1FEc438R+DgvPLZJfRBXhi4fV1KGt6tm4Le5Ti31Utg2ZHNS+I1i0cLcZeqxjClQfhPuDh
	62UZ5E1gBHhgbo8U6BawLbW+SXVf2cnE6oC7L6ylSem+r2dKL31vdcpeO5sjYv/r7yNFAW/qmKEEU
	V4zjV4nSGTumtbRpyCgQVbrMHglHgahBUX3LqDZMIxlMkmZsGCjZ7G7RAhtchmn2oBV/hiDGHmFE1
	5LTHs5p4OlROfaQS+wjqm6qa0vHJ4cmVoIsim/067nbdjr3JQEt72hK7gp+Y8UlCI4RJeVC7S4Urm
	2UspCpDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGZl-00000003RnI-3Muy;
	Fri, 21 Feb 2025 00:07:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGZk-00000003Rn4-0PL4
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 00:07:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A84226123F;
	Fri, 21 Feb 2025 00:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B9FC4CED1;
	Fri, 21 Feb 2025 00:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740096446;
	bh=i8vccezxcDOb2X0bCpDjFoA8D+F7pnRUQhko6LWPLf0=;
	h=Date:From:To:Cc:Subject:From;
	b=QukVgkqtrO4kJM36c3NNxYtryVr7Vsi59Bt1Nmb95afcDkUU2XKUIaVfLJLRZVfwm
	 Z5lskRQhPhEI7jxZI0rBP501zahxLChMheFIN0kDX80gyQQ/nIwNfvvNwXLik/U55v
	 RaI/C1lXVzK/kuHTZos20dpDNd3Y0hBv7qzBnjB+JAmHC5FVPDP5qZ/AKD3xxuRcdJ
	 zBWNYKTAVBobVkGP8J2e8BUrGXaTW5sKVN2PLgbe90SliDs91I2BTFdMyRalbCSJhe
	 Xy5raFP0bxpOQmdmtvmIDEBcwn6OP5l8oMR1i+OOSE5bMRbl2I7g4ckX1mFDJDfTUI
	 ukp0oK6tsn6Mw==
Date: Thu, 20 Feb 2025 17:07:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.14
Message-ID: <Z7fDvDmMihwtyUDV@kbusch-mbp>
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

The following changes since commit dd8b0582e25e36bba483c60338741c0ba5bc426c:

  block: fix NULL pointer dereferenced within __blk_rq_map_sg (2025-02-17 09:04:07 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2025-02-20

for you to fetch changes up to d2fe192348f93fe3a0cb1e33e4aba58e646397f4:

  nvme: only allow entering LIVE from CONNECTING state (2025-02-20 09:14:25 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.14

 - FC controller state check fixes (Daniel)
 - PCI Endpoint fixes (Damien)
 - TCP connection failure fix (Caleb)
 - TCP handling C2HTermReq PDU (Maurizio)
 - RDMA queue state check (Ruozhu)
 - Apple controller fixes (Hector)
 - Target crash on disbaled namespace (Hannes)

----------------------------------------------------------------
Caleb Sander Mateos (2):
      nvme-tcp: fix connect failure on receiving partial ICResp PDU
      nvme/ioctl: add missing space in err message

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Damien Le Moal (6):
      nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
      nvmet: pci-epf: Do not uselessly write the CSTS register
      nvmet: pci-epf: Avoid RCU stalls under heavy workload
      nvme: tcp: Fix compilation warning with W=1
      nvme: Cleanup the definition of the controller config register fields
      nvmet: Use enum definitions instead of hardcoded values

Daniel Wagner (2):
      nvme-fc: rely on state transitions to handle connectivity loss
      nvme: only allow entering LIVE from CONNECTING state

Hannes Reinecke (1):
      nvmet: Fix crash when a namespace is disabled

Hector Martin (2):
      apple-nvme: Release power domains when probe fails
      apple-nvme: Support coprocessors left idle

Maurizio Lombardi (1):
      nvme-tcp: add basic support for the C2HTermReq PDU

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

 drivers/nvme/host/apple.c     | 55 ++++++++++++++++++++++++-----------
 drivers/nvme/host/core.c      |  2 --
 drivers/nvme/host/fc.c        | 67 ++++---------------------------------------
 drivers/nvme/host/ioctl.c     |  3 +-
 drivers/nvme/host/pci.c       |  2 ++
 drivers/nvme/host/tcp.c       | 50 ++++++++++++++++++++++++++++++--
 drivers/nvme/target/core.c    | 40 ++++++++++++--------------
 drivers/nvme/target/nvmet.h   | 14 ++++-----
 drivers/nvme/target/pci-epf.c | 39 ++++++++++++++++++-------
 drivers/nvme/target/rdma.c    | 33 ++++++++++++++-------
 include/linux/nvme-tcp.h      |  2 ++
 include/linux/nvme.h          | 40 +++++++++++++++++++++-----
 12 files changed, 208 insertions(+), 139 deletions(-)


