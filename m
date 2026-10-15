Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA31CCA464
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T0u58p6uY/06O6J4f00BlGR6GWCMJINCHvDTBIE5wEI=; b=AElc8O8yWxJZURAIt+bCL4MmwG
	iAng11QO8oif/WKLAIOT7cRG2U2qNC7/MYUy5EyE24G2XtTMh7wJo0ttJ/0g3yy9m6sB7e2Gv8EkM
	lo4MxyVjNVDOjdgEeh1+qEjDujHlpEpKLzwQxTLIfRCdMNvVWEKP0y38sxj8MHs//XKhiAUZkmIcD
	nC/Qr+lCLBaT7esFVjoab+J69j4+gy3m1SQzTzf4N2WCS1VJ8c3wxSUfnP1+MSAYXWrfCDs0WVZeW
	oN0M7V4ik22NR2hjuQcCrMHzotELrEW/5uU/xeOMOJ8Zg2kYfshCjyqa7yT9hWtA3uBNvjLYzLd0W
	kc2fC6Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSPq-00000001Nn8-2HKC;
	Thu, 15 Oct 2026 20:51:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHSPp-00000001Nmt-1kCM
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 20:51:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 26D0C4038E;
	Thu, 15 Oct 2026 20:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DEF1F000C4;
	Thu, 15 Oct 2026 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792097465;
	bh=T0u58p6uY/06O6J4f00BlGR6GWCMJINCHvDTBIE5wEI=;
	h=Date:From:To:Cc:Subject;
	b=k7ZWGAfsn4AwVS2N2LcPszhdli/Om2y5xb2De7muGTCpfbGPz5sfOjGwRUaOwPj0o
	 acbUr+8qjhMmYcCuY15J8NZg3qWcuispdLz6SGfqINvoYAcjsXglx97v82ddCij68e
	 PwI2diJjD3r0Ubp0835OpcUA6+JY7TOcckUPpAbCSG8rtzLtH0TL4GLzReVlVm+l/Q
	 AWPsRCaRR8BPbPbGgD4KSU/haT+ZJ26pXrQIat/EoGaw6VU6pvEOuiPfggaWT19q5A
	 o+6ChtoA1h7IppWxRMqfhzyAKctH7+aY1FaxVNcu6pB8hEoE/XGxEMiTkQeqwQyHO7
	 T9L6aTQqe9TJQ==
Date: Thu, 15 Oct 2026 14:51:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 7.4
Message-ID: <atE8t_Gi-aJATAbh@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The following changes since commit 85bffad4d2fea373a72d68bed8012e8cbccb8ee7:

  block: simplify disk_zone_set_cond() (2026-09-15 06:53:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.4-2026-10-15

for you to fetch changes up to 2e8e30b3cf9f165e1a1d079331543cb7f2ad0e0c:

  Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation" (2026-10-15 07:20:49 -0700)

----------------------------------------------------------------
nvme updates for Linux 7.4

 - Parallelize nvme-tcp I/O queue setup and use the caller's network
   namespace
 - New multipath sysfs attributes for path state, available
   iopolicies, and fail on controller loss
 - Multipath fixes for failfast/ANA path evaluation and discovery
   subsystem iopolicy reporting
 - Apple M4 ANS2 NVMe support
 - Traffic based keep alive support for the target
 - DH-HMAC-CHAP hardening for host and target: enforce bidirectional
   auth, require auth before property set, fix state UAF, reject short
   payloads, restrict secret visibility
 - Target reservation preempt fixes
 - Target passthru I/O use-after-free fix
 - Fix out-of-bounds reads and memory leaks from device and host
   supplied data: FDP config log, ZNS zone reports, file namespace
   range errors
 - Enforce partition checks for unprivileged passthrough
 - nvme-rdma fix for bogus remote invalidation
 - nvmet-fc fix for recursive locking hang on port unlink
 - Revert DMA opt max_hw_sectors clamp due to performance regressions
 - Misc cleanups

----------------------------------------------------------------
Andrea Parri (1):
      nvmet: zns: don't leak stale memory in zone management receive

Christoph Hellwig (1):
      Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation"

Daejun Park (2):
      nvmet: fix use-after-free of the old registrant in nvmet_pr_preempt()
      nvmet: fix preempt of another registrant by the reservation holder

Guixin Liu (1):
      nvme-multipath: expose path_state via sysfs

Jesse Taube (1):
      nvmet: Add traffic based keep alive support to configfs

Jérémy Jean (2):
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nvmet: free the bvec on file namespace range errors

Krishna Iyer (2):
      nvme-multipath: fix path state evaluation for failfast and ANA
      nvme-multipath: add fail_on_ctrl_loss sysfs attribute

Laurence Oberman (1):
      nvme-multipath: add iopolicies sysfs attribute

Martin Belanger (1):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only

Martin George (1):
      nvme-multipath: report "none" iopolicy for discovery subsystems

Nilay Shroff (2):
      nvmet: introduce struct nvmet_passthru
      nvmet: fix use-after-free in passthru I/O hotpath

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Peng Fan (1):
      nvme: use assign_bit() where applicable

Sung Byeongchan (2):
      nvmet: require authentication before property set
      nvmet-auth: reject undersized AUTH_SEND payloads

Surabhi Gogte (3):
      nvme-tcp: store and use the caller's network namespace
      nvme-tcp: refactor I/O queue setup path
      nvme-tcp: parallelize I/O queue allocation and startup

Yao Sang (1):
      nvme: pass partition flags to passthrough checks

Yehyeong Lee (3):
      nvme-rdma: don't complete a request after a bogus remote invalidation
      nvme-auth: fail when the controller does not authenticate itself
      nvme: bound FDP config log reads to the received buffer

Yureka Lilian (2):
      dt-bindings: nvme: Add apple,t8132-nvme-ans2 compatible
      nvme: apple: add t8132 (M4) ANS2 NVMe support

 Documentation/ABI/stable/sysfs-nvme                |  52 +++++++
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |   1 +
 drivers/nvme/host/apple.c                          |  39 +++++-
 drivers/nvme/host/auth.c                           |  15 +-
 drivers/nvme/host/core.c                           |  15 +-
 drivers/nvme/host/ioctl.c                          |   2 +-
 drivers/nvme/host/multipath.c                      | 153 ++++++++++++++++++---
 drivers/nvme/host/nvme.h                           |   4 +
 drivers/nvme/host/pci.c                            |   2 +-
 drivers/nvme/host/rdma.c                           |   1 +
 drivers/nvme/host/sysfs.c                          |  23 ++--
 drivers/nvme/host/tcp.c                            | 139 +++++++++++++------
 drivers/nvme/target/admin-cmd.c                    |   4 +-
 drivers/nvme/target/auth.c                         |   1 +
 drivers/nvme/target/configfs.c                     | 119 ++++++++++++++--
 drivers/nvme/target/core.c                         |  19 ++-
 drivers/nvme/target/fabrics-cmd-auth.c             |  38 ++++-
 drivers/nvme/target/fabrics-cmd.c                  |   4 +
 drivers/nvme/target/fc.c                           |  15 +-
 drivers/nvme/target/io-cmd-file.c                  |   4 +-
 drivers/nvme/target/nvmet.h                        |  70 +++++++++-
 drivers/nvme/target/passthru.c                     | 103 +++++++++++---
 drivers/nvme/target/pr.c                           |   4 +-
 drivers/nvme/target/zns.c                          |  10 ++
 24 files changed, 696 insertions(+), 141 deletions(-)


