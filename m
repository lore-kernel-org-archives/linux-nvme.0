Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC82D1BDD2
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h0eoiPyjYmms/nSnM0uICi6sesvIHnyzdsB4tYl03+I=; b=sPn80EHCIVu9kJYBd/B+1uVCgr
	0dngHmMoPpVREYRfO4DJbCKRSLHlXOeAVJl0wAbWyJklxRWJe99T+uhbzbSMWxh/hTB5oSz70pQUY
	0/hObRYyWOgYzDs7nA/TrHJ+X0VQqx9JJLZ34OXdTi99/pp2T3tr+1NpUrSg1+f2+YVTVfYmtm88q
	Odk6O6ZR6sIfhggGNafpDa5/qJLgGQwnRJx/esjaHUJfinJB1R8f+r48dUl59Kt+leQh6EiL0vv0x
	9Z9CE5z5C2COAd420os2lCt2++7cPdF0ucVx8LXHqM+ZD+NYf7yPuUT6qJP4P+uCmMqCl4E/LCshW
	z9GUv7fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQsQ2-00000006yp9-42xz;
	Wed, 03 Dec 2025 19:21:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQsQ1-00000006you-2Ofi
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 19:21:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 93E8060125;
	Wed,  3 Dec 2025 19:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1580C4CEF5;
	Wed,  3 Dec 2025 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764789700;
	bh=DdHMVOQZYHeAuOyLO8nrKj7WRtHZkCZzjO/Dkc7cjUA=;
	h=Date:From:To:Cc:Subject:From;
	b=CMDPdlqyRjrHc/eJHHv2QpYqXMUpO7ZbuAb3mKNMqfL0kwy/W160aMX3NcHVRUw+E
	 PKhR+QzP/9HZLzTIvhOvRgISZJvxEZHXNAms4rz0kL0UM5CoE2pJF7JVpY9+O4wtNR
	 6NTOF7uwuQnXraTd3bnIA0oPu09VHPU42a2M1l0X5jqW6SEtgDFhrdm8O7AuJGxMgV
	 Vrzf/XhwtZoxGtXliEYwvWBqz4+4EpADqsHMPJtg5Xv9WdXyt5dnASh65EAhCcluG8
	 fATJtUr5dnKaTczw5EN23TlvnrwHzrrLkkqrFSHdW3uTz0v7XBt4EykMS+TVKVwm5A
	 uQVhEfKmvpXXg==
Date: Wed, 3 Dec 2025 12:21:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.19
Message-ID: <aTCNwTd9E186RsXE@kbusch-mbp>
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

This is a bit later than usual as we dropped part of the original set to
provide additional time to resolve some late comments.

The following changes since commit d211a2803551c8ffdf0b97d129388f7d9cc129b5:

  block/rnbd: correct all kernel-doc complaints (2025-12-01 07:19:50 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2025-12-03

for you to fetch changes up to fd87c8a7982fdb555133a6d225b636984d12c7db:

  nvme-fabrics: add ENOKEY to no retry criteria for authentication failures (2025-12-01 13:45:58 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.19

 - Subsystem usage cleanups (Max)
 - Endpoint device fixes (Shin'ichiro)
 - Debug statements (Gerd)
 - FC fabrics cleanups and fixes (Daniel)
 - Consistent alloc API usages (Israel)
 - Code comment updates (Chu)
 - Authentication retry fix (Justin)

----------------------------------------------------------------
Chu Guangqing (1):
      nvme: fix typo error in nvme target

Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

Gerd Bayer (2):
      nvme-pci: print error message on failure in nvme_probe
      nvme-pci: add debug message on fail to read CSTS

Israel Rukshin (3):
      nvmet-rdma: use kvcalloc for commands and responses arrays
      nvmet-tcp: use kvcalloc for commands array
      nvme-auth: use kvfree() for memory allocated with kvcalloc()

Justin Tee (1):
      nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

Max Gurtovoy (2):
      nvmet: add sanity checks when freeing subsystem
      nvmet: remove redundant subsysnqn field from ctrl

Shin'ichiro Kawasaki (2):
      nvmet: pci-epf: move DMA initialization to EPC init callback
      nvmet: pci-epf: fix DMA channel debug print

 drivers/nvme/host/auth.c        |  2 +-
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/fc.c          |  8 ++++++--
 drivers/nvme/host/pci.c         |  2 ++
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/auth.c      | 18 ++++++++++--------
 drivers/nvme/target/core.c      |  5 +++--
 drivers/nvme/target/fc.c        | 48 +++++++++++++++++++++---------------------------
 drivers/nvme/target/fcloop.c    |  9 ++++++---
 drivers/nvme/target/nvmet.h     |  1 -
 drivers/nvme/target/passthru.c  |  2 +-
 drivers/nvme/target/pci-epf.c   | 14 ++++++++------
 drivers/nvme/target/rdma.c      | 12 ++++++------
 drivers/nvme/target/tcp.c       |  6 +++---
 14 files changed, 69 insertions(+), 62 deletions(-)

