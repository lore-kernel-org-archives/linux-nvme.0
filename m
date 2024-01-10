Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C6FC4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z0SCFDs/xyWFcKjL8HivuaaJIZoauQ3R/9rYxDl4VMQ=; b=xacC2S8apSDWWNUt5/dXXljwGD
	ZuU4eJfZIX1TYqOsBgElL763qGBFVhOZlIQ99jUXcxdcf/QSPC0/snkkVJMHJCv54AtmoUmha8zYM
	y7/pL3uPL1fm2e1skbmD9orSO04p3E7AokprYCt/nCAtT0JNLFUDBhUbaE6htK3tMo7waj91RwIi4
	w03EAWFEtOGCSrYs7BcTXDYKIeMwI1rAqKyvkP7vNhdjVA+s3iplwX2lkMknTIBc8k+sV6yT0q9rY
	uhLMjBDinJm4n9VVo3kqOXHy+wRrvUgPb3mSyqMiZSbxnSHKrYvhpSkDDKmKODh5zCj2I/dnFf/dQ
	GdCMRzIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNgJe-00EJht-10;
	Wed, 10 Jan 2024 21:40:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNgJb-00EJhI-0W
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 21:40:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7A544CE1DB4;
	Wed, 10 Jan 2024 21:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFDC433C7;
	Wed, 10 Jan 2024 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922844;
	bh=+924m4T7CsS7DG0o/yOp+h8q/EsxpbdrvBT8B3DZr74=;
	h=Date:From:To:Cc:Subject:From;
	b=AHGBnn27gnVOrWZQ+ogvjs8djyJyoyuweisOL2kOaMKdrNElkfKzF0oiY+FJ/b3AR
	 mBgd876uL7s5GuwQ8ppe6NcHs65nDlUMYd91DCU0DPoOYGNj+AO8Ao7pOT6fn2dfRI
	 df+rKXKhjF+Y+CjkH+vO84f0Y9qZjta9Lpf5YOFuOjYotaMxAlVcRn97g3k1INW+2R
	 qdS37jDNsRSG9c5szb/RC0zb+uUxJtvnuPL9w1TBX4xYKK7FRpN38Z7w2u8Bt3cMwF
	 H6medJHW9A1Z8WVulI6L9vxDArD8ZR/6mh3VHXKzAg4gzJTf6HIMU4eLEIqKGoxQu6
	 uenYDtryzHMAA==
Date: Wed, 10 Jan 2024 14:40:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme follow-up updates for Linux 6.8
Message-ID: <ZZ8O2rVaFSnPQoGG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_134047_542113_92B3731C 
X-CRM114-Status: GOOD (  10.17  )
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

The following changes since commit 31e4fac930814f2f92eb6ebac9c4d4e3b09f7aaf:

  mtd_blkdevs: use the default discard granularity (2023-12-29 08:44:12 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.8-2024-1-10

for you to fetch changes up to 31deaeb11ba7a885116c9c30892b9f763c04d59c:

  nvmet-rdma: avoid circular locking dependency on install_queue() (2024-01-10 13:27:45 -0800)

----------------------------------------------------------------
nvme follow-up updates for Linux 6.8

 - tcp, fc, and rdma target fixes (Maurizio, Daniel, Hannes, Christoph)
 - discard fixes and improvements (Christoph)
 - timeout debug improvements (Keith, Max)
 - various cleanups (Daniel, Max, Giuxen)
 - trace event string fixes (Arnd)
 - shadow doorbell setup on reset fix (William)
 - a write zeroes quirk for SK Hynix (Jim)

----------------------------------------------------------------
Arnd Bergmann (2):
      nvmet: re-fix tracing strncpy() warning
      nvme: trace: avoid memcpy overflow warning

Christoph Hellwig (6):
      nvme-common: mark nvme_tls_psk_prio static
      nvmet-tcp: fix a missing endianess conversion in nvmet_tcp_try_peek_pdu
      nvme: update the explanation for not updating the limits in nvme_config_discard
      nvme: also skip discard granularity updates in nvme_config_discard
      nvme: fix max_discard_sectors calculation
      nvme: simplify the max_discard_segments calculation

Daniel Wagner (3):
      nvmet-fc: remove unnecessary bracket
      nvmet-trace: avoid dereferencing pointer too early
      nvmet-fcloop: Remove remote port from list when unlinking

Guixin Liu (2):
      nvme: tcp: remove unnecessary goto statement
      nvme: introduce nvme_disk_is_ns_head helper

Hannes Reinecke (2):
      nvmet-tcp: avoid circular locking dependency on install_queue()
      nvmet-rdma: avoid circular locking dependency on install_queue()

Jim.Lin (1):
      nvme-pci: disable write zeroes for SK Hynix BC901

Keith Busch (1):
      nvme-pci: enhance timeout kernel log

Maurizio Lombardi (4):
      nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
      nvmet-tcp: fix a crash in nvmet_req_complete()
      nvmet-tcp: remove boilerplate code
      nvmet-tcp: Fix the H2C expected PDU len calculation

Max Gurtovoy (3):
      nvme: remove unused definition
      nvme-rdma: enhance timeout kernel log
      nvme-tcp: enhance timeout kernel log

William Butler (1):
      nvme-pci: set doorbell config before unquiescing

 drivers/nvme/common/keyring.c |  2 +-
 drivers/nvme/host/core.c      | 41 ++++++++++++++++++++---------------------
 drivers/nvme/host/nvme.h      | 16 +++++++++++++---
 drivers/nvme/host/pci.c       | 27 ++++++++++++++++-----------
 drivers/nvme/host/pr.c        |  2 +-
 drivers/nvme/host/rdma.c      | 11 ++++++++---
 drivers/nvme/host/sysfs.c     |  8 ++++----
 drivers/nvme/host/tcp.c       | 11 +++++------
 drivers/nvme/target/fc.c      |  2 +-
 drivers/nvme/target/fcloop.c  |  7 ++-----
 drivers/nvme/target/rdma.c    | 19 ++++++++++++++++---
 drivers/nvme/target/tcp.c     | 48 +++++++++++++++++++++++++++++++++++++-----------
 drivers/nvme/target/trace.c   |  6 +++---
 drivers/nvme/target/trace.h   | 33 +++++++++++++++++++--------------
 include/linux/nvme.h          |  1 -
 15 files changed, 146 insertions(+), 88 deletions(-)

