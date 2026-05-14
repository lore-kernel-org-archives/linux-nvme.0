Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF36CCD4F39
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rVc7FMULGjZ9JKS3cEb678kBJtx6xaolT3PJ8Qy/1Ww=; b=30w580KH0PoGgKthK3Jl9bX6Ub
	pFfYOiRN49PPz68IhOkLAYOC7S2RZh19CVgyXArPIIpi9qnFWeXDuHZv5nplv4mnQNirOoZ6xu1YP
	kHcKQRoXLYkqcp8Wm56T2dUswG5imgPH0V5dX0S3gMq/gbb7Ji7EAL46eLSHL6937u/qXOYUFvJXU
	5z4zvj9fNNmIABU+KYVC4I3ItAD+pZ7qQR1ToFEqV9sbHIYPC1AuYkzs6AOX1i5LhvHY/vEO1SiUM
	C54tgnVE/L7iapcSkrQqtAayQ+4kwfUX7jd81KJ0eH2Wzd+4zt1ZW/7e0Pu6npHIRStRkBn5bVBaN
	zCE+MXAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNcWS-00000006Vc8-0xFT;
	Thu, 14 May 2026 20:19:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNcWR-00000006Vc1-1YdL
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 20:19:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7DA6B60139;
	Thu, 14 May 2026 20:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028A4C2BCB3;
	Thu, 14 May 2026 20:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778789946;
	bh=0VAMLg+Ndr1s1+0osVISknxO5Vs4t8TXUkPJNBXRX0k=;
	h=Date:From:To:Cc:Subject:From;
	b=AEwawOs7yBA3Kwj5C07iL8r6xw9GgptmPI64wxGXaWDASptJewPiBJzF1Ey7vzqRG
	 rh9REL8q6DQhvyakRKvERpFu2AwIcsFwFUchAZbTymN/thYBhEr6MgpFvTjGdbU/cj
	 2JcjOMF/b01a7cF2TSspUjxHgxEjzuMtk/sLghFfuItUtDf0xPpVs1e+mmqiQnh22h
	 byQpBBe4Jtr3V5TDGhNMJy0z+7IPKSlRAJHVjcW2THHzRURhoEN+0SKdvyJkFCBavT
	 FUUQ3359E26Sy/4g67sau36N/fLVV+aJ8K3Ck//3j5DdTR81Rw1gv3o2L1frQKGWJG
	 QmtGDqkYhHRmg==
Date: Thu, 14 May 2026 14:19:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 7.1
Message-ID: <agYuOOFSTynR-wPG@kbusch-mbp>
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

The following changes since commit 86f33ca9bea30cf011f2b1edad4593faea9c6e98:

  ublk: validate physical_bs_shift, io_min_shift and io_opt_shift (2026-05-06 04:42:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.1-2026-05-14

for you to fetch changes up to a6ab75639e23169a741b0b2e12191fd8acb32c73:

  nvme-apple: Reset q->sq_tail during queue init (2026-05-14 07:40:35 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.1

 - Fix memory leak on a passthrough integrity mapping failure (Keith)
 - Hide secrets behind debug option (Hannes)
 - Fix pci use-after-free for host memory buffer (Chia-Lin Kao)
 - Fix tcp taregt use-after-free for data digest  (Sagi)
 - Revert a mistaken quirk (Alan Cui)
 - Fix uevent and controller state race condition (Maurizio)
 - Fix apple submission queue re-initialization (Nick Chan)

----------------------------------------------------------------
AlanCui4080 (1):
      Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"

Chia-Lin Kao (AceLan) (1):
      nvme-pci: fix use-after-free in nvme_free_host_mem()

Hannes Reinecke (1):
      nvmet-auth: Do not print DH-HMAC-CHAP secrets

Keith Busch (2):
      nvme: make prp passthrough usage less scary
      nvme: fix bio leak on mapping failure

Maurizio Lombardi (1):
      nvme: fix race condition between connected uevent and STARTED_ONCE flag

Nick Chan (1):
      nvme-apple: Reset q->sq_tail during queue init

Sagi Grimberg (1):
      nvmet-tcp: Fix potential UAF when ddgst mismatch

 drivers/nvme/host/apple.c   |  1 +
 drivers/nvme/host/core.c    |  6 +++++-
 drivers/nvme/host/ioctl.c   | 18 ++++--------------
 drivers/nvme/host/pci.c     |  8 ++++----
 drivers/nvme/target/Kconfig |  9 +++++++++
 drivers/nvme/target/auth.c  | 13 ++++++++-----
 drivers/nvme/target/tcp.c   |  4 +++-
 7 files changed, 34 insertions(+), 25 deletions(-)


