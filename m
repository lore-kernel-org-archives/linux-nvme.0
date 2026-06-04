Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6831ECD6E74
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u/ohDQtOxUHzk7MDlk76j7G3Z+QOKtMK+Uu1cGOtCOY=; b=35DnriQO3ete7slv5Wy1ugVDT4
	R6CPGSWx40Rv72ZZotKlxS7pcq/Rhhau3jOjAlSeWbUgcHT0ko00adToEJHZcJ5qDea7N2XAPr5+e
	oPstrNMes1he8EjBYx+yBj6GHnnVEPPf7KuYWRD9TmYyZaOaH6Y7CeBL9YJexmq7++FHk38lWsrj3
	G8iD+kCTe1YwfRlKC3Gig+XxWew8E7I5WJVzmLUEOj+iOsLDrd/Q81S17DbPi8dUDWg4RWEzdJBPs
	S3rvJ2D4tjW/J0iq9fRtFPT+iDxgusOjk8HqJFHOZSLhmvO+EMDX5qxO1yOH2DAat9vhD3W6zv3c5
	CoMyCwAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV5gH-0000000Gb4I-1v6S;
	Thu, 04 Jun 2026 10:52:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV5gG-0000000Gb40-2CSK
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 10:52:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F0ABF43662;
	Thu,  4 Jun 2026 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AB71F00893;
	Thu,  4 Jun 2026 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780570327;
	bh=u/ohDQtOxUHzk7MDlk76j7G3Z+QOKtMK+Uu1cGOtCOY=;
	h=Date:From:To:Cc:Subject;
	b=NoA7b/dGfCTM6lmoEg6llsavGQtHTXrdGsmfqu6xabFiJsNWhTbjrFNFxcoU4dn/8
	 KRXPKV5Se1PF+P/SLt0ucNYen/SRF0GQgrwVw2+ueW/RL6kkHCmp2UIJKpZbGyS+tu
	 G6k4/JnAqMKlOvgk9Ie/4niyEF9gZAwchhU1nOCs7DbyYzyosVYe3AGJJdBFNcVXZd
	 OBWffYuKJ9QeyF6/88IfgUy+jHdMfm0sWYvL5fzBL5xeAgrxGw2ZAF3VlO22wDnzZN
	 K9iz/j8mBou9jz+IkSxtKYYa9o9hhWr9GqnK8MI4bGiXfXHmWbOXYAh7vBwYpWTbeL
	 5HQor4DNzoAfQ==
Date: Thu, 4 Jun 2026 11:52:02 +0100
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 7.2
Message-ID: <aiFY0kfy2Xt-nPQO@kbusch-mbp>
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

The following changes since commit be34ec59ef061a1cc435a3e066ad71ca675c7fcd:

  block: unexport bio_{set,check}_pages_dirty (2026-05-15 08:46:45 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.2-2026-06-04

for you to fetch changes up to 3c8c284dfcdfce81a02fe3c911196d9876468ae4:

  nvme: export controller reconnect event count via sysfs (2026-06-04 01:57:40 -0700)

----------------------------------------------------------------
nvme updates for Linux 7.2

  - Per-controller timeouts
  - Multipath telemetry
  - Namespace format validation
  - Various other fixes

----------------------------------------------------------------
Achkinazi, Igor (1):
      nvme-multipath: set BIO_REMAPPED on bios remapped to per-path namespace disks

Bryam Vargas (1):
      nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page

Chao Shi (1):
      nvme: core: reject invalid LBA data size from Identify Namespace

Geliang Tang (2):
      nvmet-tcp: fix page fragment cache leak in error path
      nvmet-tcp: check return value of nvmet_tcp_set_queue_sock

John Garry (2):
      nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for multipath_sysfs
      nvme-multipath: pass NS head to nvme_mpath_revalidate_paths()

Kuniyuki Iwashima (1):
      nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is false.

Mateusz Nowicki (1):
      nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools

Maurizio Lombardi (7):
      nvme: remove redundant timeout argument from nvme_wait_freeze_timeout
      nvme: add sysfs attribute to change admin timeout per nvme controller
      nvme: add sysfs attribute to change IO timeout per controller
      nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
      nvmet-loop: do not alloc admin tag set during reset
      nvme-core: warn on allocating admin tag set with existing queue
      nvme-core: fix unsigned comparison warning in nvme_wait_freeze_timeout

Maximilian Heyne (1):
      nvme: Let the blocklayer set timeouts for requests

Nilay Shroff (9):
      nvme-multipath: fix flex array size in struct nvme_ns_head
      nvme: add diag attribute group under sysfs
      nvme: export command retry count via sysfs
      nvme: export multipath failover count via sysfs
      nvme: export command error counters via sysfs
      nvme: export I/O requeue count when no path is usable via sysfs
      nvme: export I/O failure count when no path is available via sysfs
      nvme: export controller reset event count via sysfs
      nvme: export controller reconnect event count via sysfs

Shin'ichiro Kawasaki (2):
      nvme-tcp: move nvme_tcp_reclassify_socket()
      nvme-tcp: lockdep: use dynamic lockdep keys per socket instance

Tianchu Chen (1):
      nvmet-auth: validate reply message payload bounds against transfer length

Wentao Liang (1):
      nvme: target: rdma: fix ndev refcount leak on queue connect

Yao Sang (1):
      nvme: refresh multipath head zoned limits from path limits

liuxixin (2):
      nvme: fix FDP fdpcidx bounds check
      nvme: validate FDP configuration descriptor sizes

liyouhong (1):
      nvme-multipath: require exact iopolicy names for module parameter

 drivers/nvme/host/apple.c              |   2 +-
 drivers/nvme/host/core.c               |  74 +++++---
 drivers/nvme/host/fc.c                 |   3 +
 drivers/nvme/host/multipath.c          | 137 +++++++++++++--
 drivers/nvme/host/nvme.h               |  21 ++-
 drivers/nvme/host/pci.c                |  14 +-
 drivers/nvme/host/rdma.c               |   4 +-
 drivers/nvme/host/sysfs.c              | 311 ++++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c                |  98 ++++++-----
 drivers/nvme/target/discovery.c        |  23 ++-
 drivers/nvme/target/fabrics-cmd-auth.c |  15 +-
 drivers/nvme/target/loop.c             |  31 ++--
 drivers/nvme/target/rdma.c             |   6 +-
 drivers/nvme/target/tcp.c              |  11 +-
 14 files changed, 631 insertions(+), 119 deletions(-)


