Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE38C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KVN8sR4di0+Vxqq8aC1+qO1dM1grkRCw9mbb8x/NbmQ=; b=J3jrvjzCd5aIjK
	Z5pVgDNgSWO4+3ugzmv1OZml0+mytQeLKQw+3rmOZB9UFHxHO2kzxg+RGbWpUx83NSp1d15Kz571a
	j7LvOhG627CmUYsogwSY17ED2yKCoT5S7qCU0a4ZyKLYZPd3WuWuLMOVD0Mtyd8gzJTIOvG2Ixk5i
	w5d2NLFsBgc59thDrBK07d+kudOv3ySNj7DoQcO8OVrU/uvaQatbLhzPqbfoXbZBYpBltPmH7Nyvl
	j693aAvZbwltclcv00hSMGRoxNmk3dkSjsBpjmv8p4QJYDuKkHs0as8dY4YrHRvJ+uacu/c08PnQP
	YiH3RNAPKmkJcsYixqUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81Ar-0000000Ezm0-3LOX;
	Thu, 24 Apr 2025 18:19:49 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81Ap-0000000EzlA-1gl5
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:19:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0696AA4D052;
	Thu, 24 Apr 2025 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20898C4CEE3;
	Thu, 24 Apr 2025 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518785;
	bh=VqAYPuJ5J0/bH4w7gmZOsvSTqkaJVps+Ly/tB5vJwcM=;
	h=From:Subject:Date:To:Cc:From;
	b=AWURydopIE0CiWhfMynMTkk/xIOsRAI4gEiAhNjnW9IOpXUFlvExiNsFwsMKx46fo
	 mRta86ddHbXGsHNv+r5KX4CL7EoksB2R9lPfiJ/9/+pF5Dc8IUMLndYdsauvWaQ+Uw
	 MT0nnWDrli9MQRWztcflmba/+vc05WO13hi1BnhJeL15QQg2atxJUep4yZP6mXBQha
	 i2lb0ygiNqbEcUD0WqSmK2oLjhToqeSw45uYyQpe8Xrpb3EpevIu6TaRRPoq02jwZy
	 cpehhNPlmACv4VSYCfTNlEsgjwoXPbwmyGXKrrYNbsjc7cbX+V2DrL1WoNqHTOcUlU
	 hXnnGhBPdtWvA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v6 0/9] blk: honor isolcpus configuration
Date: Thu, 24 Apr 2025 20:19:39 +0200
Message-Id: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuACmgC/23RTW7CMBAF4Ksgr2s047+4rLhH1UWcjMEqisHGE
 Qjl7jVQ2kbK8o3kz+PnG8uUAmW2Wd1YojHkEIcazNuKdft22BEPfc1MgFBgBPCQ46E7lsxD5Kd
 ChTLH1lpyqvHeOlYPHhP5cHmgH58170M+x3R93DHiffricIkbkQO3Ds278wrBym0umdY9sTs2i
 v9AswiICgjTSkGyU77Rc0D+ARbMIiAr0LdA1Hlq66vmgPoFUODyBqoCupdae+eQUG2/KA10WMe
 0exr6ZWhAXGx11NUAUh7RGgsOZsb07DnRqdQ/O/+UPU3fQtAZNtEBAAA=
X-Change-ID: 20240620-isolcpus-io-queues-1a88eb47ff8b
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_111947_581113_5FE582C2 
X-CRM114-Status: GOOD (  17.32  )
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

I've added back the isolcpus io_queue agrument. This avoids any semantic
changes of managed_irq. I don't like it but I haven't found a
better way to deal with it. Ming clearly stated managed_irq should not
change.

Another change is to prevent offlining a housekeeping CPU which is still
serving an isolated CPU instead just warning. Seem way saner way to
handle this situation. Thanks Mathieu!

Here details what's the difference is between managed_irq and io_queue.

* nr cpus <= nr hardware queue

(e.g. 8 CPUs, 8 hardware queues)

managed_irq is working nicely for situation where there hardware has at
least as many hardware queues as CPUs, e.g. enterprise nvme-pci devices.

managed_irq will assign each CPU its own hardware queue and ensures that
non unbound IO is scheduled to a isolated CPU. As long the isolated CPU
is not issuing any IO there will be no block layer 'noise' on the
isolated CPU.

  - irqaffinity=0 isolcpus=managed_ird,2-3,6-7

	queue mapping for /dev/nvme0n1
	        hctx0: default 0
	        hctx1: default 1
	        hctx2: default 2
	        hctx3: default 3
	        hctx4: default 4
	        hctx5: default 5
	        hctx6: default 6
	        hctx7: default 7

	IRQ mapping for nvme0n1
	        irq 40 affinity 0 effective 0  nvme0q0
	        irq 41 affinity 0 effective 0  nvme0q1
	        irq 42 affinity 1 effective 1  nvme0q2
	        irq 43 affinity 2 effective 2  nvme0q3
	        irq 44 affinity 3 effective 3  nvme0q4
	        irq 45 affinity 4 effective 4  nvme0q5
	        irq 46 affinity 5 effective 5  nvme0q6
	        irq 47 affinity 6 effective 6  nvme0q7
	        irq 48 affinity 7 effective 7  nvme0q8

With this configuration io_queue will create four hctx for the four
housekeeping CPUs:

  - irqaffinity=0 isolcpus=io_queue,2-3,6-7

	queue mapping for /dev/nvme0n1
	        hctx0: default 0 2
	        hctx1: default 1 3
	        hctx2: default 4 6
	        hctx3: default 5 7

	IRQ mapping for /dev/nvme0n1
	        irq 36 affinity 0 effective 0  nvme0q0
	        irq 37 affinity 0 effective 0  nvme0q1
	        irq 38 affinity 1 effective 1  nvme0q2
	        irq 39 affinity 4 effective 4  nvme0q3
	        irq 40 affinity 5 effective 5  nvme0q4

* nr cpus > nr hardware queue

(e.g. 8 CPUs, 2 hardware queues)

managed_irq is creating two hctx and all CPUs could handle IRQs. In this
case an isolated CPU is selected to handle all IRQs for a given hctx:

  - irqaffinity=0 isolcpus=managed_ird,2-3,6-7

	queue mapping for /dev/nvme0n1
	        hctx0: default 0 1 2 3
	        hctx1: default 4 5 6 7

	IRQ mapping for /dev/nvme0n1
	        irq 40 affinity 0 effective 0  nvme0q0
	        irq 41 affinity 0-3 effective 3  nvme0q1
	        irq 42 affinity 4-7 effective 7  nvme0q2

io_queue also creates also two hctxs but only assigns housekeeping CPUs
to handle the IRQs:

  - irqaffinity=0 isolcpus=io_queue,2-3,6-7

	queue mapping for /dev/nvme0n1
	        hctx0: default 0 1 2 6
	        hctx1: default 3 4 5 7

	IRQ mapping for /dev/nvme0n1
	        irq 36 affinity 0 effective 0  nvme0q0
	        irq 37 affinity 0-1 effective 1  nvme0q1
	        irq 38 affinity 4-5 effective 5  nvme0q2

The case that there are less hardware queues than CPUs is more common
with the SCSI HBAs so with the io_queue approach not just nvme-pci are
supported.

Something completely different: we got several bug reports for kdump and
SCSI HBAs. The issue is that the SCSI drivers are allocating too many
resources when it's a kdump kernel. This series will fix this as well,
because the number of queues will be limitted by
blk_mq_num_possible_queues() instead of num_possible_cpus(). This will
avoid sprinkling is_kdump_kernel() around.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v6:
- added io_queue isolcpus type back
- prevent offlining hk cpu if a isol cpu is still present isntead just warning
- Link to v5: https://lore.kernel.org/r/20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org

Changes in v5:
- rebased on latest for-6.14/block
- udpated documetation on managed_irq
- updated commit message "blk-mq: issue warning when offlining hctx with online isolcpus"
- split input/output parameter in "lib/group_cpus: let group_cpu_evenly return number of groups"
- dropped "sched/isolation: document HK_TYPE housekeeping option"
- Link to v4: https://lore.kernel.org/r/20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org

Changes in v4:
- added "blk-mq: issue warning when offlining hctx with online isolcpus"
- fixed check in cgroup_cpus_evenly, the if condition needs to use
  housekeeping_enabled() and not cpusmask_weight(housekeeping_masks),
  because the later will always return a valid mask.
- dropped fixed tag from "lib/group_cpus.c: honor housekeeping config when
  grouping CPUs"
- fixed overlong line "scsi: use block layer helpers to calculate num
  of queues"
- dropped "sched/isolation: Add io_queue housekeeping option",
  just document the housekeep enum hk_type
- added "lib/group_cpus: let group_cpu_evenly return number of groups"
- collected tags
- splitted series into a preperation series:
  https://lore.kernel.org/linux-nvme/20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org/
- Link to v3: https://lore.kernel.org/r/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

Changes in v3:
- lifted a couple of patches from
  https://lore.kernel.org/all/20210709081005.421340-1-ming.lei@redhat.com/
  "virito: add APIs for retrieving vq affinity"
  "blk-mq: introduce blk_mq_dev_map_queues"
- replaces all users of blk_mq_[pci|virtio]_map_queues with
  blk_mq_dev_map_queues
- updated/extended number of queue calc helpers
- add isolcpus=io_queue CPU-hctx mapping function
- documented enum hk_type and isolcpus=io_queue
- added "scsi: pm8001: do not overwrite PCI queue mapping"
- Link to v2: https://lore.kernel.org/r/20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de

Changes in v2:
- updated documentation
- splitted blk/nvme-pci patch
- dropped HK_TYPE_IO_QUEUE, use HK_TYPE_MANAGED_IRQ
- Link to v1: https://lore.kernel.org/r/20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de

---
Daniel Wagner (9):
      lib/group_cpus: let group_cpu_evenly return number initialized masks
      blk-mq: add number of queue calc helper
      nvme-pci: use block layer helpers to calculate num of queues
      scsi: use block layer helpers to calculate num of queues
      virtio: blk/scsi: use block layer helpers to calculate num of queues
      isolation: introduce io_queue isolcpus type
      lib/group_cpus: honor housekeeping config when grouping CPUs
      blk-mq: use hk cpus only when isolcpus=io_queue is enabled
      blk-mq: prevent offlining hk CPU with associated online isolated CPUs

 block/blk-mq-cpumap.c                     | 116 +++++++++++++++++++++++++++++-
 block/blk-mq.c                            |  46 +++++++++++-
 drivers/block/virtio_blk.c                |   5 +-
 drivers/nvme/host/pci.c                   |   5 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |  15 ++--
 drivers/scsi/qla2xxx/qla_isr.c            |  10 +--
 drivers/scsi/smartpqi/smartpqi_init.c     |   5 +-
 drivers/scsi/virtio_scsi.c                |   1 +
 drivers/virtio/virtio_vdpa.c              |   9 +--
 fs/fuse/virtio_fs.c                       |   6 +-
 include/linux/blk-mq.h                    |   2 +
 include/linux/group_cpus.h                |   3 +-
 include/linux/sched/isolation.h           |   1 +
 kernel/irq/affinity.c                     |   9 +--
 kernel/sched/isolation.c                  |   7 ++
 lib/group_cpus.c                          |  90 +++++++++++++++++++++--
 16 files changed, 290 insertions(+), 40 deletions(-)
---
base-commit: 3b607b75a345b1d808031bf1bb1038e4dac8d521
change-id: 20240620-isolcpus-io-queues-1a88eb47ff8b

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


