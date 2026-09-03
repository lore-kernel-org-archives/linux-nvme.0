Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D2C624D7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qEXHsnDDmMxBXafY5cPR9R/uN2Ql07/wOBZdMfvH8eo=; b=bumPndMw826asoGpnBrfyWgcJV
	oM8AGY3t4D8n1DG+j+DDRdZ6gg5Znv8CY6GDbrEsx6Z2i1Kuq66V8KafFeKm66WJ7UYNEi/OyaUoD
	mvjii0JP+lWEyXlHdty+zT3pXZS/FhXP/+5brnCqZ8UeJZ39VlYFcK4bOQXatvSOrDTxIsGd76XUy
	bG+5LKnnRYCXIbUaHXR9BfIGRMtBVkhyOIh4ABrSa0upJFfkMOrAxYq+k55PT0UUnYomeA4kXepX6
	zJUP0CSGZzsDF6QHxep+8hYK1u37U/9cmJhwaucsM6fjuka3ERSL2wayx8v0mwEbfPg/iSKTEvath
	fGQh/HTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Esi-00000000d4Q-32ta;
	Thu, 03 Sep 2026 21:22:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Esi-00000000d4J-0WWM
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 21:22:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EBE941880;
	Thu,  3 Sep 2026 21:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5221F000E9;
	Thu,  3 Sep 2026 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470518;
	bh=qEXHsnDDmMxBXafY5cPR9R/uN2Ql07/wOBZdMfvH8eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Go7538VkqZffgXnLqInFETkbtzzEjUumhmTfr7lciUfxbLJU9lq+03ybYX5uqI9/v
	 IoGyF3jqicNY1yBIKBINgpeaeBan50GpsWuP2KrXmKipri9r4POJRDGZYQTQ644Lix
	 Gg0ySNv8V7d7pJzb4lnXnpXmCjfeLtU7fNT8ADPvpR3WKRx+QTUl13TyO8nl+BWw5d
	 CMJ1aQDN3IonGup3rn45ZGj3YHQ8iBYyckzonayAVUnh45XX3WPfs8aEy3xGa9WAwJ
	 twf2wDNu1Gv6ysgMeoyo/e0Q+Hn7Fa6KDtleI2daDlfHZ7IU5T/WQrKLg1iCKGMnlc
	 AUNKgFbafo/mA==
Date: Thu, 3 Sep 2026 15:21:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [GIT PULL] nvme fixes for Linux 7.3
Message-ID: <apnk9Uoj1X3PKM-k@kbusch-mbp>
References: <apnhXnr8bFqNl-o6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apnhXnr8bFqNl-o6@kbusch-mbp>
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

Terribly sorry, the previous message was from a stale tree with the
wrong SHAs. This is the intended pull request:

The following changes since commit 326d49039c10b65522ac7277b19b9b5c42ed1aeb:

  nbd: add pre_defined_connections module parameter for pre-created devices (2026-08-15 20:01:20 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.3-2026-09-03

for you to fetch changes up to fd9beb8870736e1c6a0b2351d88a161aaeb2b326:

  nvme-tcp.h: drop kernel-doc comments, fix a few descriptions (2026-09-03 14:15:11 -0700)

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

