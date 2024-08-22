Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D0C52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=; b=cDVJdtOplYBX7D
	Lpucc7Hwx/S47FzFad4lmmzUPZN4lHhe3nQyhbfnJNbNnX6HOMo+WGUhRGuoigh/tm8d64Pnc8hKY
	jb3OEpEFzDPwh+o5lNFNp7AyDCle9HxJF+Ic6QBCQ/1Dxs1FDSdyPwWoPzn/nY+AB8vIP7vrf94L/
	Tfil1MX1SsmUNPKr4P+JHZ4VAWjbl9e2jC2AHUltznQF3bobtvwRHKQpkUX8mq2E1f00VEWdrnlfN
	gpqSP/GnAAZ37bZzbKIKV+eHwQdNTQHfmiS5M7e24UdDC+SBp/jotJ5tWO48Xbx7bdcgyu/HU2kw2
	E+QIrea8tMCK0jxVt9Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgv-0000000Dy5v-26n5;
	Thu, 22 Aug 2024 18:37:49 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgs-0000000Dy54-3jSV
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:48 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-202376301e6so9642505ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351865; x=1724956665; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=N4Tg0Z7bXVh+u50jl9+KGPsR2cfyM70z2PahvYQqA0MCu0iHut7ioRpAkLm2gnedrw
         it390A5ghe3E0j9gG5dCKcao98CWochXyI60awlnKRbXNaapg3sCSkq74YHgA32L1XMK
         jVxP2T/yFPoFUIMsf89sfswkduPtJi6M+6kSFuqUu9XmWizN/CDHXgVkxbnxyESKX6tM
         ZWSBr3wcVZlBgvr6zzsTYDAOFMnqIXKqkk3s9vaPuKF4cYXuJh2st2NHXN5l0dpsONrV
         CTjJVVGulKxoxM7ZiH/MYZQ2Njaf8HCfi5nIjEzVBuVd7PXUiI7/w9DlH+r+q2QLsbnz
         t4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351865; x=1724956665;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=FQZr1SCHlbfFGmzswT8mq/veuv8vJCz1pk9WFy6QpFsbLLYOt5gbG74d7pR/OHiNvc
         gK4rdoPlOCj28iWcuRQK1MhNC/WIn9pl/IioOheqgGQPqmdQlcOmDe5kUWylTJt6fGkU
         Sdwqda/kFAyebxZFvUOuWGspRc/mSD8+6qDEgktPN0+cUFwsGbQmN7Sh4rIGipW2OWdr
         RS1bEptdjiCNSUWfX2sBKQP3upIkYcxi7WhAdSu9fK0P8JXdTsbJgHjtYT7nfYz+BGwK
         FzJL8fobumUfSRyk9mS7+WCL2voO0fsS5fWGpazYHL+1KwCPkifIXtVo7lIoc1OeWgJi
         vOpg==
X-Forwarded-Encrypted: i=1; AJvYcCVwmpFTiEkUouP8S2sxYSLid8ztWHWHO6zFeTxx0ZDZzzinF9/l/XePdeP96zVk1YznHtwEmFAjY7JG@lists.infradead.org
X-Gm-Message-State: AOJu0YxP0ZfJNbs2qeLXp0oCci9434BdsZUGUuUWtB0up6X1gwUWV06O
	0VbVxTTHi1TUoC7eyUw0FiuXhOXgFpcz02HgnAACM/XinDbF2PnC
X-Google-Smtp-Source: AGHT+IEl3He9Aim4HWajrK80+KqOIG9qzlUskCayv41SgJM9s3grubdRM7QHgHTRWUeXewRIkkN6lw==
X-Received: by 2002:a17:902:d48c:b0:202:32cf:5db1 with SMTP id d9443c01a7336-20388b6a84cmr38489205ad.44.1724351865300;
        Thu, 22 Aug 2024 11:37:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:44 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 0/7] Introduce swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:11 -0700
Message-Id: <20240822183718.1234-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113746_965695_FA1DC1BF 
X-CRM114-Status: GOOD (  35.16  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

Background
==========
Linux device drivers may make DMA map/unmap calls in contexts that
cannot block, such as in an interrupt handler. Consequently, when a
DMA map call must use a bounce buffer, the allocation of swiotlb
memory must always succeed immediately. If swiotlb memory is
exhausted, the DMA map call cannot wait for memory to be released. The
call fails, which usually results in an I/O error.

Bounce buffers are usually used infrequently for a few corner cases,
so the default swiotlb memory allocation of 64 MiB is more than
sufficient to avoid running out and causing errors. However, recently
introduced Confidential Computing (CoCo) VMs must use bounce buffers
for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
swiotlb memory. This large allocation reduces the likelihood of a
spike in usage causing DMA map failures. Unfortunately for most
workloads, this insurance against spikes comes at the cost of
potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
memory can't be used for other purposes.

Approach
========
The goal is to significantly reduce the amount of memory reserved as
swiotlb memory in CoCo VMs, while not unduly increasing the risk of
DMA map failures due to memory exhaustion.

To reach this goal, this patch set introduces the concept of swiotlb
throttling, which can delay swiotlb allocation requests when swiotlb
memory usage is high. This approach depends on the fact that some
DMA map requests are made from contexts where it's OK to block.
Throttling such requests is acceptable to spread out a spike in usage.

Because it's not possible to detect at runtime whether a DMA map call
is made in a context that can block, the calls in key device drivers
must be updated with a MAY_BLOCK attribute, if appropriate. When this
attribute is set and swiotlb memory usage is above a threshold, the
swiotlb allocation code can serialize swiotlb memory usage to help
ensure that it is not exhausted.

In general, storage device drivers can take advantage of the MAY_BLOCK
option, while network device drivers cannot. The Linux block layer
already allows storage requests to block when the BLK_MQ_F_BLOCKING
flag is present on the request queue. In a CoCo VM environment,
relatively few device types are used for storage devices, and updating
these drivers is feasible. This patch set updates the NVMe driver and
the Hyper-V storvsc synthetic storage driver. A few other drivers
might also need to be updated to handle the key CoCo VM storage
devices.

Because network drivers generally cannot use swiotlb throttling, it is
still possible for swiotlb memory to become exhausted. But blunting
the maximum swiotlb memory used by storage devices can significantly
reduce the peak usage, and a smaller amount of swiotlb memory can be
allocated in a CoCo VM. Also, usage by storage drivers is likely to
overall be larger than for network drivers, especially when large
numbers of disk devices are in use, each with many I/O requests in-
flight.

swiotlb throttling does not affect the context requirements of DMA
unmap calls. These always complete without blocking, even if the
corresponding DMA map call was throttled.

Patches
=======
Patches 1 and 2 implement the core of swiotlb throttling. They define
DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
indicate that a DMA map call is allowed to block, and therefore can be
throttled. They update swiotlb_tbl_map_single() to detect this flag and
implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
updated to handle a previously throttled request that has now freed
its swiotlb memory.

Patch 3 adds the dma_recommend_may_block() call that device drivers
can use to know if there's benefit in using the MAY_BLOCK option on
DMA map calls. If not in a CoCo VM, this call returns "false" because
swiotlb is not being used for all DMA I/O. This allows the driver to
set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
there is benefit.

Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
variant to allow passing the MAY_BLOCK attribute.

Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
is used for storage in CoCo VMs in the Azure public cloud.

Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.

Discussion
==========
* Since swiotlb isn't visible to device drivers, I've specifically
named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
something swiotlb specific. While this patch set consumes MAY_BLOCK
only on the DMA direct path to do throttling in the swiotlb code,
there might be other uses in the future outside of CoCo VMs, or
perhaps on the IOMMU path.

* The swiotlb throttling code in this patch set throttles by
serializing the use of swiotlb memory when usage is above a designated
threshold: i.e., only one new swiotlb request is allowed to proceed at
a time. When the corresponding unmap is done to release its swiotlb
memory, the next request is allowed to proceed. This serialization is
global and without knowledge of swiotlb areas. From a storage I/O
performance standpoint, the serialization is a bit restrictive, but
the code isn't trying to optimize for being above the threshold. If a
workload regularly runs above the threshold, the size of the swiotlb
memory should be increased.

* Except for knowing how much swiotlb memory is currently allocated,
throttle accounting is done without locking or atomic operations. For
example, multiple requests could proceed in parallel when usage is
just under the threshold, putting usage above the threshold by the
aggregate size of the parallel requests. The threshold must already be
set relatively conservatively because of drivers that can't enable
throttling, so this slop in the accounting shouldn't be a problem.
It's better than the potential bottleneck of a globally synchronized
reservation mechanism.

* In a CoCo VM, mapping a scatter/gather list makes an independent
swiotlb request for each entry. Throttling each independent request
wouldn't really work, so the code throttles only the first SGL entry.
Once that entry passes any throttle, subsequent entries in the SGL
proceed without throttling. When the SGL is unmapped, entries 1 thru
N-1 are unmapped first, then entry 0 is unmapped, allowing the next
serialized request to proceed.

Open Topics
===========
1. swiotlb allocations from Xen and the IOMMU code don't make use of
throttling. This could be added if beneficial.

2. The throttling values are currently exposed and adjustable in
/sys/kernel/debug/swiotlb. Should any of this be moved so it is
visible even without CONFIG_DEBUG_FS?

3. I have not changed the current heuristic for the swiotlb memory
size in CoCo VMs. It's not clear to me how to link this to whether the
key storage drivers have been updated to allow throttling. For now,
the benefit of reduced swiotlb memory size must be realized using the
swiotlb= kernel boot line option.

4. I need to update the swiotlb documentation to describe throttling.

This patch set is built against linux-next-20240816.

Michael Kelley (7):
  swiotlb: Introduce swiotlb throttling
  dma: Handle swiotlb throttling for SGLs
  dma: Add function for drivers to know if allowing blocking is useful
  scsi_lib_dma: Add _attrs variant of scsi_dma_map()
  scsi: storvsc: Enable swiotlb throttling
  nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
  nvme: Enable swiotlb throttling for NVMe PCI devices

 drivers/nvme/host/core.c    |   4 +-
 drivers/nvme/host/nvme.h    |   2 +-
 drivers/nvme/host/pci.c     |  18 ++++--
 drivers/nvme/host/tcp.c     |   3 +-
 drivers/scsi/scsi_lib_dma.c |  13 ++--
 drivers/scsi/storvsc_drv.c  |   9 ++-
 include/linux/dma-mapping.h |  13 ++++
 include/linux/swiotlb.h     |  15 ++++-
 include/scsi/scsi_cmnd.h    |   7 ++-
 kernel/dma/Kconfig          |  13 ++++
 kernel/dma/direct.c         |  41 +++++++++++--
 kernel/dma/direct.h         |   1 +
 kernel/dma/mapping.c        |  10 ++++
 kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
 14 files changed, 227 insertions(+), 36 deletions(-)

-- 
2.25.1


