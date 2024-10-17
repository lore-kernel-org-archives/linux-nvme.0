Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DC6D3C526
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/2qMORloTUaqYTP7c72PPYF0Oq5y5G3xD1W0V2ashGs=; b=rQtOreO+xLGf1aEz9OfcGipYsb
	i/7PAZ5sy8v0BT1JLrwz7B8YU67av/vSW0tmA4Yiw4d2PTvtbnd4w2HthGzhOAsuoMzL4Iyu6SDIc
	0PFpPM2i4qJtpZAyA+tYwh5xJBP31ujcy9jK2QZKCF58RWht3pt7IBt6gDE169pNIqmNQqAVn7zZ2
	zrcKzGfUPvQZmyG7QC8Ds7hJNzdwqbD5JvdxTz85yIQJ/F9+3WKT8DLY6NzMAtSiSan5EAGhJXggM
	FM2+Qfl0f4TK8js5q5fpSBenK6KmmBrtmM3zMf1qmzpwo8dyWDBlt5e/43joakVjJa05gg3ELdVlu
	Jeer1qgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1VYp-0000000FvIR-12RR;
	Thu, 17 Oct 2024 18:49:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1VXl-0000000Fv4B-3eyc
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 18:48:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2480FA443CF;
	Thu, 17 Oct 2024 18:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826BAC4CECD;
	Thu, 17 Oct 2024 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190896;
	bh=GMFKJuafiTqgN/rXiGzKMHGc7HzglDHAyYOP9hydiec=;
	h=Date:From:To:Cc:Subject:From;
	b=RbKI+HRMxRqJVb+Bvokbih8RxM/MXV0+3MJxWYMLckJXkv63entnivpW7gGdTIy8p
	 Q/eyt5fXUEgkcwjQYqKIGycx4Z93D05Pk3dWiaQibRyRszTC41g5lsk/MZ+w4At9wi
	 H8FVTK4fEgvv5N5uUPvGS0TWUDnt46tqmQeWDpYPbOTdh8b+f0sca6vDn3d1ik4NXv
	 YNk1XhDmuKCqZgpaLp0XoBc1ndap/SfOKFaOf93nByIBJoIuYdmIzh7ieuQk2QvCf0
	 +E7XbHHzdxfwWEpkAUhyZgeSr13LNnlNiUi6hlpyl6aSAnl0VxBvFHgTiYSvgG+sGF
	 VKcKRAO45wktg==
Date: Thu, 17 Oct 2024 12:48:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.12
Message-ID: <ZxFb7BMydvpLbDuh@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_114817_993097_BB355ACC 
X-CRM114-Status: UNSURE (   6.44  )
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

The following changes since commit 8be007c8e0911d0450b402ca8cbb1a8cbd00e8f2:

  block: fix blk_rq_map_integrity_sg kernel-doc (2024-09-27 04:19:53 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-10-18

for you to fetch changes up to 599d9f3a10eec69ef28a90161763e4bd7c9c02bf:

  nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function (2024-10-17 11:07:37 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.12

 - Fix target passthrough identifier (Nilay)
 - Fix tcp locking (Hannes)
 - Replace list with sbitmap for tracking RDMA rsp tags (Guixen)
 - Remove unnecessary fallthrough statements (Tokunori)
 - Remove ready-without-media support (Greg)
 - Fix multipath partition scan deadlock (Keith)
 - Fix concurrent PCI reset and remove queue mapping (Maurizio)
 - Fabrics shutdown fixes (Nilay)

----------------------------------------------------------------
Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Guixin Liu (1):
      nvmet-rdma: use sbitmap to replace rsp free list

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Keith Busch (1):
      nvme-multipath: defer partition scanning

Maurizio Lombardi (1):
      nvme-pci: fix race condition between reset and nvme_dev_disable()

Nilay Shroff (4):
      nvmet-passthru: clear EUID/NGUID/UUID while using loop target
      nvme-loop: flush off pending I/O while shutting down loop controller
      nvme: make keep-alive synchronous operation
      nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function

Tokunori Ikegami (1):
      nvme: delete unnecessary fallthru comment

 drivers/nvme/host/core.c       | 41 +++++++++++++++++------------------------
 drivers/nvme/host/multipath.c  | 40 +++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        | 19 ++++++++++++++++---
 drivers/nvme/host/tcp.c        |  7 ++++---
 drivers/nvme/target/loop.c     | 13 +++++++++++++
 drivers/nvme/target/passthru.c |  6 ++----
 drivers/nvme/target/rdma.c     | 56 +++++++++++++++++++++++++++-----------------------------
 8 files changed, 113 insertions(+), 70 deletions(-)

