Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04173EF8FF1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Uptzev6Oyq7V6+a7KdJDANZV4IR46G0oqMpnq/iU92w=; b=xyvET157Zc+rlGANoOuGacwt2I
	/nDP5a/9ZYaEeFOoatZZDZBx+kzJ+yEShbi7+TOkPqhKVyOaeEAtQMWoVlxL6/XBwTFDDgb5fU/yT
	X7e/TXUi8ZwFGZ9Kk+j3p1JBFnsMY4gvlckMoFQpeSTBihicaEG0GnKJbEXsTkn0IJ+mdDKpF4peK
	JmBAh0KUvNtDFcNmB3wRFjEdMSoZa3YKaKBqLbD2yL58gozwXZHaiUmJ5qIjmk6fEWYu9CyelTMAE
	fyVZ2mBSzt7XPfzcpwP0cpqaWRLq86VX6e0/XSYjHagACX+CuBJqD/fcFTZovenXj7hTaSdP6+mQY
	G0E8W5lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxns2-0000000HWMX-030I;
	Wed, 04 Mar 2026 15:10:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxns0-0000000HWME-2bIx
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 15:10:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0325460097;
	Wed,  4 Mar 2026 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA9C4CEF7;
	Wed,  4 Mar 2026 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772637039;
	bh=kQga9AFfRJCEFI1DVmS2RHPHUvqyGgqNw3Dj4fTum2w=;
	h=Date:From:To:Cc:Subject:From;
	b=eA4k4U4R8TJZJbr7KUGJ0DFsqLY7Zxh9w9Q39RatoMgcGkc7UDCk2IlKlVbSHSZxM
	 VVuZciNuKw1l94SY5FgcbaBcEbBj1sdvshxAGJylWfC7DBr9H/EJtARY1ATgVFj099
	 MzGKnX0qgVGZqM51KYysFJkFhv7hWDdvXGfDezEqB2LZqC88bvclqh35n0Z23QtEzC
	 k9xMm7x0GKddLQYqbfd5I9svFiqS+BnVhmDLVLheg4AykTMxo3e9c3Uyvo3gk3OK3e
	 r7qpvpqn/mujy6pcgPuxHrV9pim/Rdpv3cIUGUOpp596RYthgjHi1u7uNhZFD9Ypfq
	 Szd08475aZ+qA==
Date: Wed, 4 Mar 2026 08:10:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 7.0
Message-ID: <aahLbUJOav9p1mfx@kbusch-mbp>
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

The following changes since commit 91e1c1bcf0f2376f40ac859cf17d0a64a605e662:

  block, nvme: remove unused dma_iova_state function parameter (2026-01-13 07:23:39 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.0-2026-03-04

for you to fetch changes up to c3320153769f05fd7fe9d840cb555dd3080ae424:

  nvme: fix memory allocation in nvme_pr_read_keys() (2026-03-04 06:53:41 -0800)

----------------------------------------------------------------
nvme fixes for Linux 7.0

 - Improve quirk visibility and configurability (Maurizio)
 - Fix runtime user modification to queue setup (Keith)
 - Fix multipath leak on try_module_get failure (Keith)
 - Ignore ambiguous spec definitions for better atomics support (John)
 - Fix admin queue leak on controller reset (Ming)
 - Fix large allocation in persistent reservation read keys (Sungwoo Kim)
 - Fix fcloop callback handling (Justin)
 - Securely free DHCHAP secrets (Daniel)
 - Various cleanups and typo fixes (John, Wilfred)

----------------------------------------------------------------
Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

John Garry (3):
      nvme: stop using AWUPF
      nvme: stop setting namespace gendisk device driver data
      nvme: correct comment about nvme_ns_remove()

Justin Tee (1):
      nvmet-fcloop: Check remoteport port_state before calling done callback

Keith Busch (4):
      nvme-pci: ensure we're polling a polled queue
      nvme-pci: cap queue creation to used queues
      nvme-pci: do not try to add queue maps at runtime
      nvme-multipath: fix leak on try_module_get failure

Maurizio Lombardi (3):
      nvme: expose active quirks in sysfs
      nvme: add support for dynamic quirk configuration via module parameter
      nvme: fix memory leak in quirks_param_set()

Ming Lei (1):
      nvme: fix admin queue leak on controller reset

Sungwoo Kim (1):
      nvme: fix memory allocation in nvme_pr_read_keys()

Wilfred Mallawa (1):
      nvme/host: fixup some typos

 Documentation/admin-guide/kernel-parameters.txt |  13 ++
 drivers/nvme/host/core.c                        |  28 ++--
 drivers/nvme/host/fabrics.c                     |   4 +-
 drivers/nvme/host/multipath.c                   |  14 +-
 drivers/nvme/host/nvme.h                        |  57 +++++++-
 drivers/nvme/host/pci.c                         | 186 +++++++++++++++++++++++-
 drivers/nvme/host/pr.c                          |   4 +-
 drivers/nvme/host/sysfs.c                       |  23 +++
 drivers/nvme/host/tcp.c                         |   5 +-
 drivers/nvme/target/fcloop.c                    |  15 +-
 10 files changed, 312 insertions(+), 37 deletions(-)

