Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A53C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KoHLnq4DxD8GSWVKxlFW18MmrjmUlDAfX7rQHlaOzyY=; b=VBrt7jaU8WW/pKzUgYpr13yOP6
	2Kndf7/1H6TwGIGKj0oD+QVA5C/LxyerkZy1lYfmXtLkPm4GqsoZB2PIYfBHmxszjq8H0JGeiKH5c
	95aANnGDFO1u2FGcMxdAMZsMlxX3jB+DehHlnH0qC5Y/p8YDzzfmp5GCJVecUTmPMlgarmn2tKNTU
	rIu3lrf32p3f8jEuI/m4NHAA6DXHI3fkQRv2QxVAbzf7F+35ugHIh8jArQ0PPCWPSd5nCwBJpvtes
	nBbZWkXkEA1eUzYsl5mECuq4nC2tGYgw8VV2q6gTTCEc5p2iIT9VAyBSjEVfZlXq0eP+ts+14xkq6
	eLbPrs4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuZVQ-00000001KDW-1fLn;
	Thu, 13 Aug 2026 17:46:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuZVP-00000001KDO-2BNX
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 17:46:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CBAF0600AD;
	Thu, 13 Aug 2026 17:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F81F000E9;
	Thu, 13 Aug 2026 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786643174;
	bh=KoHLnq4DxD8GSWVKxlFW18MmrjmUlDAfX7rQHlaOzyY=;
	h=Date:From:To:Cc:Subject;
	b=C+4C8lfGCBCo2LaWtlVVtXay2t3C9ufECPW7wOwsb1mKgt03W+9OxFBK3utM9Ca2f
	 aBnQVBKPODeyxWJ59Ia2e1QUoFgiWaTeyLwGhdLUwrkaPJCI8DzxOgmd2LLPdljmC4
	 6sJT+wAuO7V1PJaZHxNx749W64W+DwDJ7SAr7ZW1uftkR3iYLyCTew2In686gWjrOk
	 stTj3G+L/udtJ33pfwBKCws9+Hk6tNyOfQzDYdZbVKGIHvisx5lNNOr9AkGTorlEL6
	 5j98F5drmv5Xfg6Aczb0KLAiJE219TVuvIEHbTJqMQrbQLXT8dIAyhGw/e17VWqQMz
	 5ctklMGn3Py1A==
Date: Thu, 13 Aug 2026 11:46:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: [GIT PULL] nvme updates for Linux 7.3
Message-ID: <an4C5I9K70UhVBpN@kbusch-mbp>
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

The following changes since commit f01f5275feb77bac9fefbbf7cc584fe0b3850a92:

  ublk: snapshot batch commands before preparing I/O (2026-07-02 06:25:21 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.3-2026-08-13

for you to fetch changes up to f1a8846e06388113dfdbb89dee005083fa9afdf9:

  nvmet: fix max_qid race between configfs and controller allocation (2026-08-13 09:26:44 -0700)

----------------------------------------------------------------
nvme updates for Linux 7.3

----------------------------------------------------------------
Bryam Vargas (1):
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Chao Shi (2):
      nvme: reject passthrough of driver-managed Set Features
      nvme: ratelimit the completion-path messages driven by device data

Dmitry Bogdanov (1):
      nvme-tcp: fix usage of page_frag_cache

Eric Biggers (1):
      nvme-auth: Avoid C=1 warning in nvme_auth_derive_tls_psk()

Ewan D. Milne (1):
      nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

Greg Kroah-Hartman (1):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations

Gui-Dong Han (1):
      nvme-apple: Use acquire/release for queue enabled state

Guixin Liu (16):
      nvme: fix typos in reservation related constants
      nvmet: add namespace-level debugfs directory
      nvmet: expose reservation state through debugfs
      nvme: add ABI documentation for host sysfs interfaces
      nvmet: add ABI documentation for target configfs interfaces
      MAINTAINERS: add missing NVMe documentation files
      nvmet: fix return status of RMI log page on allocation failure
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvme-pci: return error when parsing a quirk string fails
      nvmet: reject out-of-range mdts values in configfs store
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()
      nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
      nvme-pci: release descriptor pools on probe failure
      nvme: raise FDP placement handle cap to U8_MAX and warn on overflow
      nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

Hari Mishal (3):
      nvme: bound ns descriptor header and body to identify buffer
      nvme: clamp FDP nruhsd to allocated RUH status descriptor count
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list

Ibrahim Hashimov (1):
      nvmet-tcp: bound SGL data length before allocating command buffers

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

John Garry (5):
      nvme: handle positive error codes in nuse_show()
      nvme: swap synchronization ordering in nvme_remove_head()
      nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()
      nvme: add nvme_get_ns_head()
      nvme: fix cdev lifetime

Marco Elver (1):
      list: Permit context-unguarded access with list_empty_careful()

Maurizio Lombardi (1):
      nvmet: fix max_qid race between configfs and controller allocation

Myeonghun Pak (1):
      nvme-pci: disable controller on admin queue IRQ setup failure

Nilay Shroff (19):
      list: introduce LIST_HEAD_GUARDED
      nvme: update nvme_passthru_end() signature
      nvme: add context annotations for nvme_passthru_{start|stop}
      nvme: add context annotations for nvme_ns_head::srcu
      nvme: remove redundant initialization of nvme_ns_head::requeue_list
      nvme: add context annotations for nvme_ns_head::requeue_list
      nvme: add context annotations for nvme_ns_head::current_path
      nvme: add context annotations for nvme_dev::shutdown_lock
      nvme: remove redundant initialization of delayed_removal_secs
      nvme: add context annotations for nvme_subsystem::lock
      nvme: add context annotations for nvme_ctrl::ana_lock
      nvme: add context annotations for nvme_subsystems_lock
      nvme: add context annotations in fabric.c
      nvme: add context annotations for nvme_queue::sq_lock
      nvme: add context annotations in rdma.c
      nvme: fix context analysis warning in rdma.c
      nvme: add context annotations in tcp.c
      nvme: fix context analysis warning in tcp.c
      nvme: enable context analysis support for nvme host driver

Pan Chuang (1):
      nvme-apple: Remove redundant dev_err_probe()

Shin'ichiro Kawasaki (3):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown
      nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()

Surabhi Gogte (2):
      nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
      nvme-rdma: parallelize I/O queue allocation and startup

Sven Peter (6):
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme: Add a quirk for page aligned admin queue buffers
      nvme-apple: Require page aligned buffers on the admin queue
      nvme-apple: Drop the PRP null check chicken bit

Xixin Liu (4):
      nvme: zns: cap zone report nr_zones by DMA buffer size
      nvme: zns: include zone index in invalid zone type error
      nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
      nvmet: zns: reject full zone report when buffer is too small

Yang Xiuwei (1):
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Yao Sang (1):
      nvme-multipath: revalidate zones for namespace heads

Yehyeong Lee (4):
      nvme: zero the discard fallback page
      nvme-tcp: reject a read that transferred too few bytes
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: fix host memory disclosure on R2T for a read command

Yifei Gao (1):
      nvmet: pci-epf: put CQ ref on create_cq mapping failure

Zhengrong Li (1):
      nvmet: fix Reservation Register Replace for unregistered host with IEKEY

 Documentation/ABI/stable/configfs-nvmet | 352 +++++++++++++++++++++++++
 Documentation/ABI/stable/sysfs-nvme     | 453 ++++++++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-nvme    |  13 -
 MAINTAINERS                             |   4 +
 drivers/nvme/common/auth.c              |  13 +-
 drivers/nvme/host/Makefile              |   1 +
 drivers/nvme/host/apple.c               |  66 +++--
 drivers/nvme/host/auth.c                |   3 +-
 drivers/nvme/host/core.c                |  52 +++-
 drivers/nvme/host/fabrics.c             |   4 +-
 drivers/nvme/host/fc.c                  |   8 +-
 drivers/nvme/host/ioctl.c               | 121 ++++++---
 drivers/nvme/host/multipath.c           |  64 ++---
 drivers/nvme/host/nvme.h                |  67 +++--
 drivers/nvme/host/pci.c                 |  31 ++-
 drivers/nvme/host/rdma.c                | 160 ++++++-----
 drivers/nvme/host/sysfs.c               |   4 +-
 drivers/nvme/host/tcp.c                 |  71 ++++-
 drivers/nvme/host/zns.c                 |  11 +-
 drivers/nvme/target/admin-cmd.c         |  14 +-
 drivers/nvme/target/configfs.c          |  10 +-
 drivers/nvme/target/core.c              |  54 ++--
 drivers/nvme/target/debugfs.c           | 103 ++++++++
 drivers/nvme/target/debugfs.h           |   5 +
 drivers/nvme/target/fabrics-cmd-auth.c  |  17 +-
 drivers/nvme/target/fabrics-cmd.c       |   2 +-
 drivers/nvme/target/fc.c                |   2 +-
 drivers/nvme/target/nvmet.h             |   9 +
 drivers/nvme/target/passthru.c          |   9 +
 drivers/nvme/target/pci-epf.c           |  12 +-
 drivers/nvme/target/pr.c                |  37 ++-
 drivers/nvme/target/rdma.c              |  31 ++-
 drivers/nvme/target/tcp.c               |  19 +-
 drivers/nvme/target/zns.c               |  15 +-
 include/linux/list.h                    |   9 +
 include/linux/nvme.h                    |   4 +-
 36 files changed, 1561 insertions(+), 289 deletions(-)
 create mode 100644 Documentation/ABI/stable/configfs-nvmet
 create mode 100644 Documentation/ABI/stable/sysfs-nvme
 delete mode 100644 Documentation/ABI/testing/sysfs-nvme


