Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A1606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QSV4ny4t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTqpxhd1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=v9n9te4oMTrX4PwOgKXI7vhBwEAn82JVzuFNLEe/yK8=; b=QSV4ny4th3ICyaBCRI5gGfcFc8
	ogUpBv1UpCYxMOjUlVQl+gc9J8a+QQSV7xVHFNH8aZp/B00dY38R2Gixp70zAqOoXeSzgE+bRV9bb
	l8LnzrVSEJy0phWtFTvuh5K/Z4vZpy3SnZic/l7Q+r5er9VgTH4g9VPRqcLTK5XwmhS0Z54M2rUFj
	YYMqKf8Seiic12VAYAjFgh5aj7Hq1ROhpZfciUd9jG3z7h3m6Ful04m0dRwLopZYDiYszOzb6enHp
	qT3sClhC5JzfwSJPO89M9Eh4jJMZC3UyXajBjLr50PiZfLpanf4Vuoes/bgBrkwK7HK8L/2aMkXQX
	8zcKq4AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4Jo-0000000AbRp-3J4R;
	Thu, 05 Nov 2026 20:44:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4Jn-0000000AbQj-2HyR
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 20:44:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC33E602D4;
	Thu,  5 Nov 2026 20:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153651F0089F;
	Thu,  5 Nov 2026 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793911458;
	bh=v9n9te4oMTrX4PwOgKXI7vhBwEAn82JVzuFNLEe/yK8=;
	h=Date:From:To:Cc:Subject;
	b=BTqpxhd1Vrjo9S9EM1RPWNC8YE56hNbNEwgQkkUZnok36QnzbHtK3tQSixM2dM5pq
	 eJMmDxYwUWGy+FZtxQhd4PHp8CmR0V49LiUQRbZoY44o2rNsLsBz1NvGRnO4uiBOMd
	 TyHgY58/bSBmYIyT0j6AGWMbdaY1cfNc+MG9XBIN5SkW/XG/PrxBWy2MQEIhk6Ue2/
	 YwnPB4L2KNk7RnsqnS8vh+4BpElVB2xbi+8GA8Ae2oSdXckqvmQBa0DIUgziucbOU+
	 3xutlYwXQj5CFZxaLwQ6QY9eJeNUbGUyyHyWZqlyskrMcIiH3ZgeylFaxcfDPfOevZ
	 CVyNojA7iiRtg==
Date: Thu, 5 Nov 2026 13:44:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org, paulmck@kernel.org
Subject: [GIT PULL] nvme fixes for Linux 7.4
Message-ID: <auzqoK4jrx-NSHRv@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This pull includes a patch for the srcu subsystem. The patch adds a new
helper, list_splice_init_srcu(), needed to fix namespace removal racing
with srcu readers. Paul McKenney reviewed and acked this going through
our nvme tree:

  https://lore.kernel.org/linux-nvme/493a0897-c117-4517-a3a4-6d84da9d30ae@paulmck-laptop/

The following changes since commit c8c53d669d4e45b3a804013251a34387d7e11bfb:

  blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key() (2026-10-29 11:10:05 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.4-2026-11-05

for you to fetch changes up to f33c8bc785401669b29229bcf3d0086ba9f5b87c:

  nvmet: cache passthru reference in __nvmet_req_complete() (2026-11-05 08:53:01 -0800)

----------------------------------------------------------------
nvme fixes for Linux 7.4

 - Fix a passthru reference leak that hangs disabling a target passthru
   controller (7.4-rc1 regression)
 - Fix namespace removal race with SRCU readers of the namespace list
 - Fix use-after-free in nvme-tcp controller teardown after a failed
   connect
 - Fix NULL dereference in nvme-rdma when a reconnect adds queues
 - nvmet-rdma device removal and disconnect fixes
 - nvmet-tcp TLS record type handling and bounded connection accept work
 - Don't leak stale memory in the nvmet ANA log page
 - Harden nvmet against invalid input: keep-alive timeout overflow,
   incomplete DHCHAP messages, configfs address bounds, arbitration
   burst mask, and locking for traffic based keep alive updates
 - Keep the old nvmet auth keys if setting new ones fails
 - Delete nvme-loop controller on failed reset
 - Fix extra cdev reference put and unregister on a zero pr_register key
 - Fix a TLS key reference leak in the nvme keyring
 - Quirks for ADATA XPG GAMMIX S70 BLADE and KIOXIA XG10d
 - Speed up nvmet namespace disable
 - Misc cleanups

----------------------------------------------------------------
Chris Mason (4):
      nvmet-rdma: disconnect only established queues
      nvmet-rdma: take a device off the list last
      nvmet-rdma: queue the release work under the mutex
      nvmet-rdma: disconnect a queue on device removal

Christian Aurich Zanettini Martins (2):
      nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
      nvme-rdma: fix NULL queue->ctrl dereference on reconnect

Christophe JAILLET (1):
      nvmet: pci-epf: Constify struct pci_epf_ops

Daejun Park (1):
      nvme: unregister when pr_register() is given a zero new key

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Guixin Liu (1):
      nvmet-rdma: remove dead allocated field in nvmet_rdma_rsp

Hugo Deco (1):
      nvme-pci: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE

James Fantin-Hardesty (1):
      nvmet: fix arbitration burst field mask

Jarkko Sakkinen (1):
      nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()

Josef Bacik (4):
      nvme-loop: delete the controller if a reset fails
      nvmet-tcp: ask for the TLS record type on every receive
      nvmet-auth: keep the old keys if the new ones fail
      nvmet-tcp: limit the connections accepted per work run

Jérémy Jean (1):
      nvmet-auth: reject incomplete DHCHAP messages

Nilay Shroff (1):
      nvmet: cache passthru reference in __nvmet_req_complete()

Qiliang Yuan (3):
      nvmet: drop the extra RCU grace period in nvmet_ns_disable()
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

Sasha Levin (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d

Shao Mingyin (3):
      nvmet: take subsys->lock when forcing reconnects for tbkas
      nvmet: bound the traddr and trsvcid configfs writes
      nvmet: drop the redundant auth check in nvmet_parse_io_cmd()

Sreeraj S Kurup (1):
      nvmet: use appropriate types for authentication payload lengths

Yingjie Wang (1):
      nvmet: reject keep-alive timeouts that would overflow

Yuqiang Sun (1):
      nvme: Do not drop the cdev reference twice when cdev_device_add() fails

 drivers/nvme/common/keyring.c          |  1 +
 drivers/nvme/host/core.c               | 23 +++++++++---
 drivers/nvme/host/multipath.c          |  2 -
 drivers/nvme/host/nvme.h               |  8 ++++
 drivers/nvme/host/pci.c                |  4 ++
 drivers/nvme/host/pr.c                 |  8 +++-
 drivers/nvme/host/rdma.c               |  7 ++--
 drivers/nvme/host/tcp.c                | 10 ++---
 drivers/nvme/target/admin-cmd.c        | 20 ++++++++--
 drivers/nvme/target/auth.c             | 69 ++++++++++++++--------------------
 drivers/nvme/target/configfs.c         |  6 ++-
 drivers/nvme/target/core.c             | 27 ++++++++-----
 drivers/nvme/target/fabrics-cmd-auth.c | 10 ++---
 drivers/nvme/target/loop.c             |  5 ++-
 drivers/nvme/target/nvmet.h            | 32 ++++++++++++----
 drivers/nvme/target/pci-epf.c          |  2 +-
 drivers/nvme/target/rdma.c             | 56 ++++++++++++++++-----------
 drivers/nvme/target/tcp.c              | 13 ++++++-
 include/linux/srcu.h                   | 36 ++++++++++++++++++
 19 files changed, 228 insertions(+), 111 deletions(-)


