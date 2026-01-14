Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC63D3900B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XW7UqmUZxFPBKI46+Zsu7NGH20OFP/Buomj87csc2m4=; b=uIL/85YzoO1raxZ//Evwa8YINv
	wqYIhr4MD/f6tdn8guJTqtO5lDhFHysdvvBgAk+qGgwhlw/JeYLJtkGeRu6aTHYl/KNNNj2LPbfkr
	ocssz4HaB/yo25f42jWndVXcSfvwI+LayMskwV1917oKrXQrymRm2+8wukId9HWWRkhgcEJLoqyeo
	2RABujbCeWgCG9ajddjdMvq3vy+gHt57SuP+/dUw1IIyV2bhnwk1Gl8gBJfBNlf6ZMFe0h14iMnt5
	y366VMfNxaRpbzBBVkRLT+h4evNtItWgpHUjNETikUktybfpBqDhD5eHHtB3/POt0sy1C7qpov1m1
	3yN5Jnsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg5lf-0000000ALpX-2Y4U;
	Wed, 14 Jan 2026 18:38:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg5lf-0000000ALpD-08h7
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 18:38:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 17BC66000A;
	Wed, 14 Jan 2026 18:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8969AC4CEF7;
	Wed, 14 Jan 2026 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768415933;
	bh=x7DbmQJQV7QHt+t2udRvHDk681dZQUYX/n92c2XtDxI=;
	h=Date:From:To:Cc:Subject:From;
	b=ttXrT5Ex7QuBQ/8y9k7pghMUriZwp2xrculrfP6ZeLxZ4w5PowgpVTAX3S1hWtk2t
	 nyYR26UfxR1zsEanoCKc6XWVK33uRBx6r0xFvYB8x+YSo8YINCBHRLUG4f+E/zXqeM
	 GIZg1QvmaE2gWdsEgX/7PqWJ5KsWbxfKicfUZHN1dwfYOglWYZHd94CUj0XYK5vmgE
	 9CJ2fEljVz54lOYblbHWrYSzij+iE6FVJCtApVnypjz+YlhsBVWRRqEocM0OHXEn5l
	 zBOAhItyIECl0DpsCu3wDEacZhq6DZHlWhOredTuJ+UHboU+Ra9RRbTp063z3iRLrN
	 RVe4HvqLGQuZw==
Date: Wed, 14 Jan 2026 11:38:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.19
Message-ID: <aWfiu2Twr5_lT9zq@kbusch-mbp>
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

The following changes since commit 9869d3a6fed381f3b98404e26e1afc75d680cbf9:

  block: fix race between wbt_enable_default and IO submission (2025-12-12 12:51:11 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-14

for you to fetch changes up to 0edb475ac0a7d153318a24d4dca175a270a5cc4f:

  nvme: fix PCIe subsystem reset controller state transition (2026-01-14 07:21:31 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.19

 - Device quirk to disable faulty temperature (Ilikara)
 - TCP target null pointer fix from bad host protocol usage (Shivam)
 - Add compatible apple controller (Janne)
 - FC tagset leak fix (Chaitanya)
 - TCP socket deadlock fix (Hannes)
 - Target name buffer overrun fix (Shin'ichiro)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-fc: release admin tagset if init fails

Hannes Reinecke (1):
      nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

Janne Grunau (1):
      nvme-apple: add "apple,t8103-nvme-ans2" as compatible

Nilay Shroff (1):
      nvme: fix PCIe subsystem reset controller state transition

Shin'ichiro Kawasaki (1):
      nvmet: do not copy beyond sybsysnqn string length

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

 drivers/nvme/host/apple.c      |  1 +
 drivers/nvme/host/fc.c         |  2 ++
 drivers/nvme/host/pci.c        |  7 ++++++-
 drivers/nvme/target/passthru.c |  2 +-
 drivers/nvme/target/tcp.c      | 21 ++++++++++++++++-----
 5 files changed, 26 insertions(+), 7 deletions(-)

