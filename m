Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D90FC83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WHulDFA07TDgEd/bEEsG+1Pgq2T2a/D5jv5hJtTPbgA=; b=T8aERtBsOCmQG5uCyIjCHFRXYP
	6hmmAqkLF4y4IrH30J/EHaobxZc9HBgBQskDsm8O7HqASmS+eayWNjtSHL8RkpU/ZDI+X6DoOMuoC
	vDNn9GGuLVxlnM6rcqW/Y5BPC9LYjaLlYnQaLHGOt0syyPA1mWrkFz7m/A0aSCHlzRu2irXprqPLm
	HarEIu0aoYXhw0XCHqAHWZstsEbnVjfsiphg6ivkJXb5ITsPThsrOtHh+3bmK4lPoQeW2hGfXAx39
	f8Y727Ztf+AEnEfDHEae2O1F/w++g3JU177ATfRwKHLstUGFj+0XzWm6bjCS9r9dj7LOFXoGqRmgT
	P1RDADHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQd-0000000G5Qc-0enh;
	Tue, 29 Jul 2025 07:07:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQV-0000000G5PJ-36WC
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D1A0041B62;
	Tue, 29 Jul 2025 07:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D708C4CEEF;
	Tue, 29 Jul 2025 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772825;
	bh=ge0qsPzkE3f4JVd2tk8h1Onzkq42+NJ5pgE1U9bqAWk=;
	h=From:To:Cc:Subject:Date:From;
	b=VU+7Lad0pXDaY0KHuRh0tgdtEwVJKEIWvH/V1xCuzblSKbkeaLWBlqQ4H+Sz59HRF
	 MGjsOHk7pHotIl/JErqctplrym5i0PEi5JbNJsGkTyt1bc/omP/OU3K7kiKYJN01Li
	 VOUAWSEugPjA4fGeJsMFuL5LntzqTLL8twB/kAh3KpZgmWVf6c3w37nv3R8XUc1PPY
	 hBSSTWi722YS3dJSfYvLUOmt1uEYuCL/s/1rwq5ALfjDR6r93XqtNgPwThclKxApS4
	 oJVPSjDldN0O0Coj7L3rQ1t8JTxTH8x64g2l/RELz7D5U1RUEnVgtad2VxZXMURZZv
	 dQpb4DxN843yQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [RFC PATCH 0/6] nvme multipath eBPF path selector
Date: Tue, 29 Jul 2025 09:06:47 +0200
Message-ID: <20250729070653.125258-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000707_895748_1FB4C515 
X-CRM114-Status: GOOD (  17.56  )
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

From: Hannes Reinecke <hare@kernel.org>

Hi all,

there are discussion on having to deploy more complex I/O scheduling
algorithms for NVMe, but then there's the question whether we really
want to carry these in the kernel.
Which sounded like an ideal testbed for eBPF struct_ops to me.
Taking a cue from Ming Lei's patchset for eBPF on ublk (thanks, Ming!)
I've started messing around with eBPF.

So here's a patchset to implement nvme multipath eBPF path selectors.
Idea's quite simple: the eBPF 'struct_ops' program is providing a
'select_path' function, which selects a nvme_ns struct to use for
the I/O starting at a given sector.
Unfortunately ePBF doesn't allow to pass pointers, _and_ the definitions
for 'struct nvme_ns_head' and 'struct nvme_ns' are internal to the
nvme subsystem. So I kept those structures as opaque pointers for
ePBF, and introduced a 'nvme_bpf_iter' structure as a path iterator.
There are two functions 'nvme_bpf_first_path' and 'nvme_bpf_next_path'
which can be used for an open-coded loop over all paths.
I've also added sample code as an example how the loop can be coded.

It's all pretty rudimentary (as I'm sure people will need accessors
to get to any namespace or controller details), but that's why I sent
it out as an RFC. And I am by no means an eBPF expert, so I'd be
glad for any corrections or suggestions for a better eBPF integration.

The entire patchset can be found at:
git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
branch nvme-bpf

As usual, reviews and comments are welcome.

Hannes Reinecke (6):
  nvme-multipath: do not assign ->current_path in __nvme_find_path()
  nvme: export nvme_find_get_subsystem()/nvme_put_subsystem()
  nvme: add per-namespace iopolicy sysfs attribute
  nvme: add 'sector' parameter to nvme_find_path()
  nvme-bpf: eBPF struct_ops path selectors
  tools/testing/selftests: add sample nvme bpf path selector

 drivers/nvme/host/Kconfig                     |   9 +
 drivers/nvme/host/Makefile                    |   1 +
 drivers/nvme/host/bpf.h                       |  33 ++
 drivers/nvme/host/bpf_ops.c                   | 347 ++++++++++++++++++
 drivers/nvme/host/core.c                      |  17 +-
 drivers/nvme/host/ioctl.c                     |   7 +-
 drivers/nvme/host/multipath.c                 |  69 +++-
 drivers/nvme/host/nvme.h                      |  11 +-
 drivers/nvme/host/pr.c                        |   2 +-
 drivers/nvme/host/sysfs.c                     |   9 +-
 include/linux/nvme-bpf.h                      |  54 +++
 .../selftests/bpf/progs/bpf_nvme_simple.c     |  52 +++
 12 files changed, 585 insertions(+), 26 deletions(-)
 create mode 100644 drivers/nvme/host/bpf.h
 create mode 100644 drivers/nvme/host/bpf_ops.c
 create mode 100644 include/linux/nvme-bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nvme_simple.c

-- 
2.43.0


