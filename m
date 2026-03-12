Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A788106ACEE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 21:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZClCHBC05BqXSaQ3LASqMV5tIgvLm8FHgIIokwXuiqk=; b=SaQLcAaTPTvh9dZCkuUrN7lzlk
	3XoYxFJs67PaGrQamnRiELKA1qmWsHKh832nCjeoIvoz0Kl2n174IsQe2KCKElmBVpJ3vALogubYk
	St4mXXDLRtHuKy+EVCNM9WUmXc8tDSJaGVy28BrjEOp9fgSTaFj21RtQirIAP6jsJGAzyuL/WAuUr
	kf8/9EW1XoxoV8aRiVzra9SGmyJQ1MBjP1ik1nuIDKl/6kEz9dRvoVrW8W0cjLJIb6ONpz3gqovhS
	fnH045tzVfb8MReCc1A/r/wFA2tEA3MMCXYmyeqKyVhjD6fEUCrN3GVOQoekNSoDyPANgk74e5STN
	a9MAMaZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nG0-0000000FPKQ-40Ai;
	Thu, 12 Mar 2026 21:07:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0nFy-0000000FPJh-1JJE
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 21:07:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A9F140648;
	Thu, 12 Mar 2026 21:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB7CC4CEF7;
	Thu, 12 Mar 2026 21:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773349665;
	bh=u/Au7uiM51ozl9Rp6NcGNS/bHpcU88eTh8OlBeKJm3o=;
	h=Date:From:To:Cc:Subject:From;
	b=dR8UPjcoCZkohlx9YE4kxOGX9DDzx+43L9pHjlxrQrVzY2JiNnetRP6+XpUBgZgVq
	 /eSXz13ZeNlasDk3R/ORMNda83DKp2d0E/nVdwbMm+LsZyM0dH3A/4OJFvisWcL+KP
	 zmwPOC1kfj7nhqWW+OTFkuntq2N4L8v1B+IVCi34LpfwRmRId984Z3AGjyS4JorLgw
	 Ybw2LNPrP/nyzvMd/2c/pNBVhcayraQn6UEuq7vUr1SiaNmKObeYF5GIpwvRI6s+KB
	 RlVIFdzD5CznHlSa/X7SvSh9Q38tu7TldnLeNeRj5JWyPADlD2xoqKshDzxgrmnP6m
	 Am7OvYopt8ZNQ==
Date: Thu, 12 Mar 2026 15:07:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 7.0
Message-ID: <abMrH7YqnCQsGt-Z@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_140746_373210_01946EFC 
X-CRM114-Status: UNSURE (   7.89  )
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

The following changes since commit 155a3bedccaf57c69aa0b590ba3fb579debf3a4d:

  ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons (2026-03-09 07:37:36 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.0-2026-03-12

for you to fetch changes up to fa655a9ca73f7df32b8ca4d14ce11742f9578288:

  nvme: Annotate struct nvme_dhchap_key with __counted_by (2026-03-10 08:20:29 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.0

 - Fix nvme-pci IRQ race and slab-out-of-bounds access (Sungwoo Kim)
 - Fix recursive workqueue locking for target async events (Chaitanya)
 - Various cleanups (Maurizio Lombardi, Thorsten Blum)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: move async event work off nvmet-wq

Maurizio Lombardi (1):
      nvme-core: do not pass empty queue_limits to blk_mq_alloc_queue()

Sungwoo Kim (2):
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set
      nvme-pci: Fix race bug in nvme_poll_irqdisable()

Thorsten Blum (1):
      nvme: Annotate struct nvme_dhchap_key with __counted_by

 drivers/nvme/host/core.c        |  3 +--
 drivers/nvme/host/pci.c         |  8 +++++---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 14 ++++++++++++--
 drivers/nvme/target/nvmet.h     |  1 +
 drivers/nvme/target/rdma.c      |  1 +
 include/linux/nvme-auth.h       |  2 +-
 7 files changed, 22 insertions(+), 9 deletions(-)

