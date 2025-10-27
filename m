Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1FCCCF9EB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fpneGAq5kbcTmWUuwpmd1k/O2ge+XouVkRZKOpHEC4k=; b=gHkiPhASh/R5GpI/QeypL2EM/7
	iMMwlDFFSFW4MHrVx2koYWKhKt97F/g6K7AZ5fHiP+y3szTfdNzDZ4eIvLsdIM4EKgxrTEWurksyL
	1Rp6GrCNhGoG51Q4WlPeQy18VnTqVg8HEbdfU+zjvCxoKrlmOdfP3q2KB+mwzOzXisl84R9Pi8Ot5
	5pL0O7QSJgRWePP1YPVTHP2wRcWX0UL7SnjwLgDYobu7E20R+daK0/ff7Rkf1not9V9VX46yz/jDh
	fMgd5yR284GNQ+wgLkUPa5u4ZUqn76mZ0OTrJJu4ajJhTbnIMZZWH3pTM13aKo6mONG8tdfY9xbml
	+LardKcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHgd-0000000DHGH-0VnY;
	Mon, 27 Oct 2025 07:30:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHgW-0000000DHFJ-2YbZ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 07:30:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EFC17417EB;
	Mon, 27 Oct 2025 07:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122E2C4CEF1;
	Mon, 27 Oct 2025 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761550231;
	bh=hGFCcEJrvi4VyPphwoTdVflmxIwXDwmY/7BclxLP8uo=;
	h=From:To:Cc:Subject:Date:From;
	b=Q21hwoQMPbgf67YRKgEBw+TFGHGnTUtJEhUXfjbUrvnuIWuMDIhigWNzfGYlFLdMw
	 PmIT3evop33JRrfMfOX02EPK7IDgc66Wx/g4KlwFnbRjZKqYa3W9D8IhR2m2koPISv
	 1ZVCSSVz8cIzzA6fm18/wjFFDFmH8K3ReNYhmr0zEYXHfSGg8uiUduB3T3Br6ashsj
	 16Z00IXWDpky/Y86nGhd/79tYYHo97uW42TWDluRcMVLl29kJV9SCyV5tFOW7wpvaA
	 VM5XzmqBo23Db/KJW5omYfwbEPUcqp5wVmVd+sfmnexRZV8I5Ze5CHG4MPh0SBPodM
	 6p1b232sD+tHQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Mon, 27 Oct 2025 09:30:19 +0200
Message-ID: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_003032_669723_7CED808B 
X-CRM114-Status: UNSURE (   9.15  )
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

Changelog:=0D
v3:=0D
 * Encoded p2p map type in IOD flags instead of DMA attributes.=0D
 * Removed REQ_P2PDMA flag from block layer.=0D
 * Simplified map_phys conversion patch.=0D
v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@=
nvidia.com/=0D
 * Added Chirstoph's Reviewed-by tag for first patch.=0D
 * Squashed patches=0D
 * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block la=
yer.=0D
v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvi=
dia.com=0D
 * Reordered patches.=0D
 * Dropped patch which tried to unify unmap flow.=0D
 * Set MMIO flag separately for data and integrity payloads.=0D
v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/=0D
=0D
----------------------------------------------------------------------=0D
=0D
This patch series improves block layer and NVMe driver support for MMIO=0D
memory regions, particularly for peer-to-peer (P2P) DMA transfers that=0D
go through the host bridge.=0D
=0D
The series addresses a critical gap where P2P transfers through the host=0D
bridge (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) were not properly marked as=0D
MMIO memory, leading to potential issues with:=0D
=0D
- Inappropriate CPU cache synchronization operations on MMIO regions=0D
- Incorrect DMA mapping/unmapping that doesn't respect MMIO semantics  =0D
- Missing IOMMU configuration for MMIO memory handling=0D
=0D
This work is extracted from the larger DMA physical API improvement=0D
series [1] and focuses specifically on block layer and NVMe requirements=0D
for MMIO memory support.=0D
=0D
Thanks=0D
=0D
[1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/=0D
=0D
Leon Romanovsky (2):=0D
      nvme-pci: migrate to dma_map_phys instead of map_page=0D
      block-dma: properly take MMIO path=0D
=0D
 block/blk-mq-dma.c            | 19 ++++++----=0D
 drivers/nvme/host/pci.c       | 86 +++++++++++++++++++++++++++++++++++----=
----=0D
 include/linux/bio-integrity.h |  1 -=0D
 include/linux/blk-integrity.h | 14 -------=0D
 include/linux/blk-mq-dma.h    | 28 +++++++-------=0D
 include/linux/blk_types.h     |  2 -=0D
 6 files changed, 95 insertions(+), 55 deletions(-)=0D
---=0D
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787=0D
change-id: 20251016-block-with-mmio-02acf4285427=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

