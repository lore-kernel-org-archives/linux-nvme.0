Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EC1C4828F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JFS9QMylMH9dWZDvodE1imbjdv/dLV/BVmXE9j32i8E=; b=137+xdnZve3La0Kw6NI8z5u0hi
	ni9kQGDn7wfMHDRBsVxChPAx8gjkXWE57l5B/MZtAaWTVpp7EiOE3OIIKqYrEYBb8LNt3vnhSAbJJ
	8aqhjjuNr/sisXuV9k3+vnIBUASixkiGRYFr1qNebeO83jZrPTOr4lUsFNqCYRpvATXEH06bVQJvn
	kT3FndrN3CVQyi1yqjt2P8C/hqoipRmD0XJjqTCDI8XGNhOJD0BEcLUW9pkFCALuZumsi61Xvjop8
	e50DjcBKGXDyRqLIYfhy61OP44TkaZStD6qhC5/f7NLnVFrSKqYlrL1x0UpCYsO29wplJs20+o2P6
	8B4WoiAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVZXh-00000008YB4-41R3;
	Thu, 01 Feb 2024 16:03:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVZXe-00000008YA0-2ddc
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 16:03:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F2FBE61F9C;
	Thu,  1 Feb 2024 16:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D8BC433F1;
	Thu,  1 Feb 2024 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803433;
	bh=GtkzzBZgnKM4YAc8rU8PRSxQDPDwwj2sUtJsUjUQVbY=;
	h=Date:From:To:Cc:Subject:From;
	b=APRY9+lZ7pVao44GHP123DSB+INmxZYPGTK0yIGPELH3w+OwMgXh0Njs9h+IPVdxz
	 0g/EhpLmxvcVhPP/ezARUo19eh7/CxVg7GRKxqJUFQjYXf8YuSR9vKVWKEU4Lqw0UA
	 FLp7kSTEIPxszg49QKfKTQfcJr25Gdhgtm0LKIggJ6OkbWbrjmWSznHFuhVta1eWlP
	 eH8ZGSYrIijykRU92XLxIm5Xs1t4ruXL9e3TIQqb3dShBENzIQuW9U/NHK4pqqwSu9
	 lcxOyqGHtEOwvIdZHiR24qWORMGscBech6Yq4Kecd9OCgBqdWVYXZo7HAGo85un47V
	 inVlU3w9QGZqA==
Date: Thu, 1 Feb 2024 09:03:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.8
Message-ID: <ZbvA5mjkhOpso5Nj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_080354_781686_89F3558B 
X-CRM114-Status: GOOD (  10.67  )
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

The following changes since commit 13f3956eb5681a4045a8dfdef48df5dc4d9f58a6:

  block: Fix WARNING in _copy_from_iter (2024-01-23 08:56:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.8-2024-02-01

for you to fetch changes up to 9f079dda14339ee87d864306a9dc8c6b4e4da40b:

  nvme: allow passthru cmd error logging (2024-02-01 07:44:53 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.8

 - Remove duplicated enums (Guixen)
 - Use appropriate controller state accessors (Keith)
 - Retryable authentication (Hannes)
 - Add missing module descriptions (Chaitanya)
 - Fibre-channel fixes for blktests (Daniel)
 - Various type correctness updates (Caleb)
 - Improve fabrics connection debugging prints (Nitin)
 - Passthrough command verbose error logging (Adam)

----------------------------------------------------------------
Alan Adamson (1):
      nvme: allow passthru cmd error logging

Caleb Sander (5):
      nvme: return string as char *, not unsigned char *
      nvme: remove redundant status mask
      nvme: take const cmd pointer in read-only helpers
      nvme: split out fabrics version of nvme_opcode_str()
      nvme-fc: log human-readable opcode on timeout

Chaitanya Kulkarni (3):
      nvme: add module description to stop warnings
      nvmet: add module description to stop warnings
      nvme-common: add module description

Daniel Wagner (12):
      nvme-fc: do not wait in vain when unloading module
      nvmet-fcloop: swap the list_add_tail arguments
      nvmet-fc: release reference on target port
      nvmet-fc: defer cleanup using RCU properly
      nvmet-fc: free queue and assoc directly
      nvmet-fc: hold reference on hostport match
      nvmet-fc: remove null hostport pointer check
      nvmet-fc: do not tack refs on tgtports from assoc
      nvmet-fc: abort command when there is no binding
      nvmet-fc: avoid deadlock on delete association path
      nvmet-fc: take ref count on tgtport before delete assoc
      nvmet-fc: use RCU list iterator for assoc_list

Guixin Liu (2):
      nvmet: unify aer type enum
      nvmet-tcp: fix nvme tcp ida memory leak

Hannes Reinecke (3):
      nvme-auth: open-code single-use macros
      nvme: change __nvme_submit_sync_cmd() calling conventions
      nvme: enable retries for authentication commands

Israel Rukshin (1):
      nvme-rdma: Fix transfer length when write_generate/read_verify are 0

Keith Busch (1):
      nvme: use ctrl state accessor

Nitin U. Yewale (3):
      nvme-tcp: show hostnqn when connecting to tcp target
      nvme-rdma: show hostnqn when connecting to rdma target
      nvme-fc: show hostnqn when connecting to fc target

 drivers/nvme/common/auth.c      |   1 +
 drivers/nvme/common/keyring.c   |   1 +
 drivers/nvme/host/apple.c       |  13 +--
 drivers/nvme/host/auth.c        |  19 ++--
 drivers/nvme/host/constants.c   |  10 +--
 drivers/nvme/host/core.c        |  85 ++++++++++++++----
 drivers/nvme/host/fabrics.c     |  19 ++--
 drivers/nvme/host/fabrics.h     |   8 +-
 drivers/nvme/host/fc.c          |  60 +++----------
 drivers/nvme/host/multipath.c   |  15 ++--
 drivers/nvme/host/nvme.h        |  62 ++++++++++----
 drivers/nvme/host/pci.c         |   3 +-
 drivers/nvme/host/rdma.c        |  23 +++--
 drivers/nvme/host/sysfs.c       |  64 +++++++++++++-
 drivers/nvme/host/tcp.c         |  11 +--
 drivers/nvme/target/core.c      |   5 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/fc.c        | 186 ++++++++++++++++++++++------------------
 drivers/nvme/target/fcloop.c    |   7 +-
 drivers/nvme/target/loop.c      |   9 +-
 drivers/nvme/target/rdma.c      |   1 +
 drivers/nvme/target/tcp.c       |   2 +
 include/linux/nvme.h            |  10 +--
 23 files changed, 380 insertions(+), 236 deletions(-)


