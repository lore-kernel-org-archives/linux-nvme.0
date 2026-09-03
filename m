Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE6DC624D7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=geaXj1No+1QnHDQx1YM9u9i2kHWjwITnyxDj6HMkO68=; b=osnNnW0tDu5Ioy/Kl5PGZ1a1xz
	xVVFyj2UfMNIKscI+WXtla8bq0uNqh38Nr6DXllTPbOsDmWe2GaPkyX/CwNSTrtcwc794ljvMSoZ1
	m/J+gqtQFYbaWyfay+OA44wgXGZmK9TLG9Vo64ac8ZVTxXliN/jdo3vIrxf8R46Hn38Xvcfjx5BOR
	LyNaE6Zwr0sQbeWen4jc6Nx8eeKGvuaByjZuG2xmj3g5BNLg+GwIBwCwbbPzEBdRuQ/seeYtVOfcf
	eUKH2btVhcSsoI99jS3WlkZ4tESXDF1n4EI4/U9KerJDU3DoZtnvItDHyOSFtrcicnwSO5BEnIJ1R
	Ic1u9MIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Edu-00000000bjR-28lY;
	Thu, 03 Sep 2026 21:06:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Eds-00000000bjL-3xZP
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 21:06:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72F9E405FC;
	Thu,  3 Sep 2026 21:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3006A1F000E9;
	Thu,  3 Sep 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469600;
	bh=geaXj1No+1QnHDQx1YM9u9i2kHWjwITnyxDj6HMkO68=;
	h=Date:From:To:Cc:Subject;
	b=TkjPDevFyYbQf7NcwX4CEeFV0yyo3+LeQANafFpOLsY+ZWN+8kz683+xpfwd2P4y7
	 iyHDkWwKL0/6d7kuHiemVQ2uzGcdXRtSqYoneyVQojK5QJrh44XsO+rug7ESDwZQHK
	 qkLbVJOaQ8pfZLEnVzIu6R36jON4Uej2M4CFFEXW5DdFo9YTL/Z7VWBxx2OmyNlO9Y
	 ipCFN6oPn2GFX4GINMhdSKXjp9XzT90UtFbxs78/21bkWmgk2V+KYX9JP2TM8UWKta
	 iIEvxJ4UW2qKVs/FKqi/vwItHtTnujnu9jmHdF6rsMtuoa9rtdAfmU7lG7lpoUgS1l
	 nlcinAVRvGOJA==
Date: Thu, 3 Sep 2026 15:06:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 7.3
Message-ID: <apnhXnr8bFqNl-o6@kbusch-mbp>
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

The following changes since commit 326d49039c10b65522ac7277b19b9b5c42ed1aeb:

  nbd: add pre_defined_connections module parameter for pre-created devices (2026-08-15 20:01:20 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.3-2026-09-03

for you to fetch changes up to f46566780a5f7e00a9026868e45421de61afcf22:

  nvme-tcp.h: drop kernel-doc comments, fix a few descriptions (2026-09-02 15:45:10 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.3

 - Harden the tcp host and target against malformed PDUs: reject C2HData
   for a non-read command, bound an over-long PDU before copying it, and
   reject unsolicited H2CData (Yehyeong, Shivam)
 - Fix circular locking on TLS queues (Xixin)
 - Fix a soft lockup when scanning sparse namespace ID space (Mohamed)
 - Fix racy access to the FDP placement id array (Kanchan)
 - RDMA host and target fixes for a double cleanup on the queue_rq
   error path and a queue leak when the connect backlog is exceeded
   (Xixin)
 - Authentication fixes: drain the target's expiry work before the SQ
   is freed, and release the DH-CHAP secret when parsing fails (Kazuki,
   Xu Rao)
 - Fix nvme-fc options double free when nvme_add_ctrl() fails (Niklas)
 - Add missing SRCU grace period to nvme_alloc_ns() error path (Tristan)
 - Skip zoned limits update when the zone info query failed (Chao)
 - Reject enabling a target namespace with no device path (Seokgyu)
 - Add opcode filtering for fault injection (Mohamed)
 - Drop the kernel-doc comments from nvme-tcp.h (Randy)

----------------------------------------------------------------
Chao Shi (1):
      nvme: skip the zoned limits update if the zone info query failed

Kanchan Joshi (2):
      nvme: set ns->head in nvme_alloc_ns_head
      nvme: fix racy access to FDP placement id array

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Keith Busch (1):
      MAINTAINERS: update nvme entry

Mohamed Khalfella (4):
      nvme: add opcode filtering for fault injection
      nvme: remove stale namespaces by NSID range during scan
      nvme: print namespace IDs as unsigned 32bit value
      nvmet: print namespace IDs as unsigned 32bit value

Niklas Cassel (1):
      nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails

Randy Dunlap (1):
      nvme-tcp.h: drop kernel-doc comments, fix a few descriptions

Seokgyu Choi (1):
      nvmet: reject namespace enable without device path

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Tristan Madani (1):
      nvme: add missing SRCU grace period in error path

Xixin Liu (3):
      nvme-rdma: fix -EIO cleanup order in queue_rq
      nvmet-rdma: fix queue leak when connect backlog is exceeded
      nvme-tcp: defer TLS inline send to io_work

Xu Rao (1):
      nvme-fabrics: fix DHCHAP secret leak on parse failure

Yehyeong Lee (2):
      nvme-tcp: check the data direction of a C2HData PDU
      nvme-tcp: return -EPROTO for a C2HData on a write

 .../fault-injection/nvme-fault-injection.rst       | 65 ++++++++++++++
 MAINTAINERS                                        |  2 +-
 drivers/nvme/host/core.c                           | 99 +++++++++++++---------
 drivers/nvme/host/fabrics.c                        |  2 +
 drivers/nvme/host/fault_inject.c                   | 14 ++-
 drivers/nvme/host/fc.c                             | 26 ++++--
 drivers/nvme/host/nvme.h                           |  2 +
 drivers/nvme/host/rdma.c                           | 18 ++--
 drivers/nvme/host/sysfs.c                          |  2 +-
 drivers/nvme/host/tcp.c                            | 12 +++
 drivers/nvme/host/zns.c                            |  4 +-
 drivers/nvme/target/auth.c                         |  6 ++
 drivers/nvme/target/configfs.c                     |  4 +-
 drivers/nvme/target/core.c                         |  9 +-
 drivers/nvme/target/nvmet.h                        |  2 +
 drivers/nvme/target/pr.c                           |  2 +-
 drivers/nvme/target/rdma.c                         | 15 ++--
 drivers/nvme/target/tcp.c                          | 10 +++
 include/linux/nvme-tcp.h                           | 18 ++--
 19 files changed, 228 insertions(+), 84 deletions(-)


