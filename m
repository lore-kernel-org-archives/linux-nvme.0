Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96381E77170
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOyJeQUmho8Z6RjGitVycosl0u8AW956bpEYkeqy3SI=; b=T5OLoawexSKi7aD9/csCYjgEBu
	u6NCHJxCg55ym1n1NUVabLziFtU9kfl9PTfFMeelNFol3+VrxgoFnHxT44EmjZ7bXKGX7Xb8fclgG
	9X5Xzcx4l2h25TzScttJytD6JOAVKLEejPREiEZWGIEYkj17rfMiynJytJF/+PdXXt0x2yJWU4LMl
	O/C2pNkZ8/VUOmVwUDNYSjett7v70KUF1osxSYLNQ9xiRqEWoj5/UXXjg1amWz176Z3Wo089J1kpH
	+eWHh+q2DJRVb9xHW0Hn0Ale6vIG7/cbA67O2mmdgKMHNey6gytYsw8HUzGChfc5jFMnRHXyMEF/a
	7SA+AWxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJFW8-0000000GvGB-3apN;
	Thu, 05 Dec 2024 17:19:56 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJFNW-0000000Gt7i-30og
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 17:11:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 884F3A437AF;
	Thu,  5 Dec 2024 17:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B4DC4CED1;
	Thu,  5 Dec 2024 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418661;
	bh=dCnKGLIyM/y3megOFkow8uMdj0PLdSHafpH95MbZXGE=;
	h=Date:From:To:Cc:Subject:From;
	b=euOqSueF1LJqR8H9Pi06By564/88iv6gPD1ftNOsBDjkn2INPXzZXOsMIUD4fUhdq
	 wfUOUN9J+BdVLVd41O+m68n9KscmXAkCPKPoL06krS3AJzbpDkmqqQ2P08Z5fnhnH0
	 3X374qj4P32PgQVK7xa8xlgkM1gMqKdIVRJUpHSJEOYdYbJ+JEBylMIjNuf/475bXx
	 6WTvnLp0S/e/S4bZH+lU+q8USdxoRERkcZd+SVBexcuver2V3SGkKbaoPnq1vD4luE
	 aM5zrONeA1D4JLz862K0i4ufqvW0sDTQgwEYU68GVXDoPo6RfXtablWFq/QxAoq/D0
	 bBgEZqFgPlKSA==
Date: Thu, 5 Dec 2024 09:10:57 -0800
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.13
Message-ID: <Z1HeockCWHXRcvGb@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_091102_834912_3AEFD77D 
X-CRM114-Status: UNSURE (   7.62  )
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

The following changes since commit ec9b3ac6e5630e320d926ea13a06d86d2a6bdde1:

  Merge tag 'nvme-6.13-2024-11-21' of git://git.infradead.org/nvme into for-6.13/block (2024-11-21 10:57:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.13-2024-12-05

for you to fetch changes up to b4e12f5728ff963ca5590c48b85a20d076bf517d:

  nvme-tcp: simplify nvme_tcp_teardown_io_queues() (2024-12-04 10:15:46 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.13

 - Target fix using incorrect zero buffer (Nilay)
 - Device specifc deallocate quirk fixes (Christoph, Keith)
 - Fabrics fix for handling max command target bugs (Maurizio)
 - Cocci fix usage for kzalloc (Yu-Chen)
 - DMA size fix for host memory buffer feature (Christoph)
 - Fabrics queue cleanup fixes (Chunguang)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not supported
      nvme-pci: don't use dma_alloc_noncontiguous with 0 merge boundary

Chunguang.xu (4):
      nvme-tcp: fix the memleak while create new ctrl failed
      nvme-rdma: unquiesce admin_q before destroy it
      nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
      nvme-tcp: simplify nvme_tcp_teardown_io_queues()

Keith Busch (1):
      nvme-pci: remove two deallocate zeroes quirks

Maurizio Lombardi (1):
      nvme-fabrics: handle zero MAXCMD without closing the connection

Nilay Shroff (1):
      nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()

Yu-Chun Lin (1):
      nvmet: replace kmalloc + memset with kzalloc for data allocation

 drivers/nvme/host/core.c        |  8 +++++---
 drivers/nvme/host/pci.c         |  7 +++----
 drivers/nvme/host/rdma.c        |  8 +-------
 drivers/nvme/host/tcp.c         | 17 +++++------------
 drivers/nvme/target/admin-cmd.c |  9 +++++++--
 drivers/nvme/target/pr.c        |  3 +--
 6 files changed, 22 insertions(+), 30 deletions(-)

