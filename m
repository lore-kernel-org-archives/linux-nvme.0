Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B933CF8864
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+f9FQguHJUI2AphnEoMl7474dcaUPTLq4BZi/mkexkI=; b=ZZOCgJEUNagAqmGtGYYPFxSdCL
	FwHbWz4cNYpwRxfgrXelPcQD56w73h+Uz/NsEktu9EPKBzCeTp/uXKl2PwbpjnBfVF+pHS20olOYp
	SnzNisGgc1zSM4FOdJBh64ZxFmkmRCBU7VAgDHrsHN8vVMIFz0zmm6lR/7ciXQGMYmHW3P1+Dciub
	JqeWQSKX5NielM2ej0StY3IGU760X7FBm+rs95hT2bQFbmrA4TOMVbcs7ylM+hpTORY4VN4ybuzHo
	52RadHX3EMyiP+dZ3yfM2+6sJ1CJb/ycte+5kZpjSqYc2dRwe+7XsKAlkKaGnRglJF53vy+9Kg1Pl
	fksdtfFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6hW-00000006vEL-20Qn;
	Thu, 20 Nov 2025 15:36:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6hT-00000006vE0-4BLQ
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 15:36:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E10AC442D0;
	Thu, 20 Nov 2025 15:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94881C4CEF1;
	Thu, 20 Nov 2025 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652958;
	bh=rbt+P10kmhRA5E+oMQadyGf5yJbFVpLaKzj7jqC3avU=;
	h=Date:From:To:Cc:Subject:From;
	b=RAqtmT0Ns+IxDQZT6qLrydqh/AF7zcEIeC1i650RbOSy5xn25eTG+7sX7854rZdTl
	 zeRV1r1T0ikf4/Lj18UV4OAAustP5YNLZK5PQt3BeTVNkBcWc0k7GIkd0Ei/03HtWF
	 WaIt1R955cVlvZwgFPR+LsNzhpWyKzu33QgWoqyxg9vgavMyooNuCfMcHUwHFM5zB3
	 Rv57ZTZBtTddmfypgPothPD+Ros3WjtYYMFu0N01vBSU4g0PQGMvNsGlKDMA+auuhE
	 nvhKUetP+olG5XTbIrBPYBdEx5KfzyWFPabHUAkFoxax8t1rYDDBJrOS5QH6Vv6PSX
	 li3d8tULOwfvQ==
Date: Thu, 20 Nov 2025 08:35:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.18
Message-ID: <aR81XMUX0mILxPpz@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_073600_078576_558AF3AB 
X-CRM114-Status: UNSURE (   7.15  )
X-CRM114-Notice: Please train this message.
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

The following changes since commit 0194b65ab571430130a11f8500894bb88f7af2c0:

  nvme-pci: use blk_map_iter for p2p metadata (2025-10-22 19:46:25 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.18-2025-11-20

for you to fetch changes up to 0a2c5495b6d1ecb0fa18ef6631450f391a888256:

  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl() (2025-11-17 09:00:42 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.18

 - Admin queue use-after-free fix (Keith)
 - Target authentication fix (Alistar)
 - Multipath lockdep fix (Shin'ichiro)
 - FC transport teardown fixes (Ewan)

----------------------------------------------------------------
Alistair Francis (1):
      nvmet-auth: update sc_c in target host hash calculation

Ewan D. Milne (2):
      nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Keith Busch (1):
      nvme: fix admin request_queue lifetime

Shin'ichiro Kawasaki (1):
      nvme-multipath: fix lockdep WARN due to partition scan work

 drivers/nvme/host/core.c               |  3 ++-
 drivers/nvme/host/fc.c                 | 15 ++++++++-------
 drivers/nvme/host/multipath.c          |  2 +-
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/fabrics-cmd-auth.c |  1 +
 drivers/nvme/target/nvmet.h            |  1 +
 6 files changed, 15 insertions(+), 11 deletions(-)

