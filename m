Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D77C44508
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=52tQ7n3GuCjp4Sewxu42YpiOfepWamn517hsrlm8XvM=; b=h3WmEbSI1WVdNIny7B+d/pQfp4
	5jb5Aok/WSPFvIRHr7M5+wf1gOjoZC2aaRZNAquPRIanUAd/gV3Mba/BKcbkZvBgRlXZw1eOpXwS3
	RtBQWV7mCCevQJDzKwEhbk9FsImElIMDLyiSdKpY4wZecjMnRUJLoCLD1aCJvXnyq4xdK8rcVOKY0
	O2cTfLI77mDTW0g49ykQjptko5PonB4AWfquCGHnT4Lz9hSASGWao0ixmK7CE4J93DvlSDOHCDgUY
	FYI7YmEEsj/oo1Yci4No4WAWi8AkwALtBAeYsDkV5XynXiUx/O3YHRJRaj1b1NW0OdPc8K3UfBhMY
	yufa07FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjufF-0000000E6rx-0ld7;
	Wed, 15 Jul 2026 08:08:21 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjufC-0000000E6rL-1Tn6
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 08:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784102898; x=1815638898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IIgcK7fDzxnbaMlAcZz6Mnndkl5qCmW4G+4LmjqUl6U=;
  b=UEfDz7LypA7UOFaVbwqWfbAhgdcRu77/OmqY2IY5RndMPOQjf7cY5n8D
   o3MlSAS6DZscTK38CYw+qHLTs2z5UxmXq3ARa+wha2Aip/HNeeOHHOrCI
   ffMs4je/z4Tmnr8DkKEte6PNlni94FrA8Q4EurFfggSUWOOlxksL/XVkZ
   Xr/rYi2SbtWF00WNrdFCHzueExDHQGfiWMGH6YflF6gc/wjx8bH13DsUO
   YR6XCYY33QFF7F2DN99js6D3PAgnFnj2ZO1nuiKl0eesgB8WJ1hqDVgiN
   hsElPX2vr3OzfX480szd6Cdc+cGyb/eYntV+tcDKnQNzgqvxEd7vDqfyI
   A==;
X-CSE-ConnectionGUID: kOotW5mxSDiRaHRSVRJWCQ==
X-CSE-MsgGUID: O0JMHuyJSIqbSAwNS8RrEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84849397"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84849397"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:08:17 -0700
X-CSE-ConnectionGUID: eB6hVkVfSG6EzlX5YHCrAA==
X-CSE-MsgGUID: T5BgwfCnSuSjrRnYebAzHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254984186"
Received: from sh14l02shfs0402.sh.intel.com ([10.239.12.240])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:08:14 -0700
From: Jun Zeng <jun1.zeng@intel.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@intel.com,
	gang.cao@intel.com,
	jun.i.jin@intel.com,
	yong.hu@intel.com,
	Jun Zeng <jun1.zeng@intel.com>
Subject: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
Date: Wed, 15 Jul 2026 15:57:02 +0800
Message-ID: <20260715075703.15578-1-jun1.zeng@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_010818_433904_BFAE463C 
X-CRM114-Status: UNSURE (   7.73  )
X-CRM114-Notice: Please train this message.
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

Background
==========

Nowadays, with the high performance PCIe 5.0 NVMe drives been used
more increasingly and widely, it's important to maintain and fully
realize NVMe drive's performance at the system level in
scenarios where multiple NVMe drives are used simultaneously.

Problem
=======

With PCIe 5.0 NVMe drives, the interrupt count can reach very high
levels in burst when running IOPS workloads (e.g., 4k/8k randread)
with multiple queues across many NVMe drives. These high interrupts
generated instantaneously may put pressure on current CPU handling
mechanism.

Specifically, IOPS with small IO (e.g., 4k/8k randread) does not
meet expectations when running with multiple queues among many NVMe
drives (e.g., 6-8 NVMe drives per socket), even with each queue and
job assigned to separate CPU cores.

The IOPS for small IO can be significantly improved when enabling
interrupt coalescing in this case. However, in some cases (e.g., big
IO for bandwidth or latency-sensitive tests with small IO and small
queue depth), interrupt coalescing has side effects.

Solution
========

Monitor the IOPS and average queue depth of inflight IO periodically
on each NVMe drive and enable/disable interrupt coalescing
automatically without user intervention. This feature is enabled by
default and can be disabled/enabled through debugfs during runtime.

Test Results
============

1. IOPS improved from < 20M to 55M for 4k randread with fio job=8,
   qd=128 across 16 PCIe Gen5 NVMe drives on Intel Xeon GNR CPUs.
   - Latency not affected for 4k randread with job=1/2/4/8,
     qd=1/2/4/8/16/32
   - Bandwidth not affected for 32k/64k/128k read/write with
     job=1/2/4/8, qd=128

2. Tested with several mainstream PCIe Gen5 SSD vendors and Intel
   CPUs (including AMD) with improved 4K random read IOPS.

Notes
=====

1. Interrupt coalescing is a per-drive feature, not per-queue
   feature. Each queue has a separate interrupt, but coalescing is
   controlled globally per drive. We introduce thresholds for
   IO_DELTA, AVG_QUEUE_DEPTH, and TOTAL_PENDING_IO to judge
   workload status.

2. Tunable parameters exposed via debugfs at
   /sys/kernel/debug/nvme_pci/:
   - disable_adaptive_interrupt_coalescing: 0=enabled, 1=disabled
   - high_io_delta: IO count threshold per cycle (default: 45000)
   - avg_qd_threshold: average queue depth threshold (default: 32)
   - total_inflight_io_threshold: total inflight IO threshold
     (default: 256)

3. The default threshold values are derived from empirical testing
   on various PCIe Gen5 NVMe drives.

Jun Zeng (1):
  nvme-pci: adaptive interrupt coalescing

 drivers/nvme/host/pci.c | 540 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 539 insertions(+), 1 deletion(-)


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.43.0


