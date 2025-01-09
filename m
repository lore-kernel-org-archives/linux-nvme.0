Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DB8E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ln8YbR1XZm/SzSLmvfnrW/FXZEjocMOkYfNwh16vXbQ=; b=1stezIgUO22bVZAAbliIHYDJBl
	0Ps6355U9nHeu7Pe6B/VJRxJ5kCZWQ/z1u2D2riTZXjXoBiNGqaskYJ8DFwX7rB/5ykri0JPNKG2B
	gV/6eXK774DznJr2RtB2SfO/Yo2klfTznmxO1zL8cVGHfjexfy/fh8mbCxBAZvvpkEP2ZzV0j2Xp9
	K8THgcC7aMQ/XdQTorExpzEwXDzOtGo03vebNfcwVX/Nx2sBtql3HP3bWZZWJ44eu3M9lD9c1dXDg
	WPfMTQqZfsiwDcdjAY99sf1u56EHBrIjqnfyOvEivVtTsFFg0VMOUXdU2NlCFtSM7CrJcMVabHn0j
	1LG/bJyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVkjo-0000000Aljw-3akr;
	Thu, 09 Jan 2025 05:05:44 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVkjl-0000000AljU-2TFA
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 05:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736399143; x=1767935143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=icHa+z701R0gciadam6t0R2syIFwZSsfhqdtDeITtXI=;
  b=CuS+/Flr8W+fTc3C1llHvQqtnVnQ0ZpyWLjVkm6ci9w+MoArnVhAoNd3
   yxcesF/R0yu5GQTFFzolKEDC3HVZHS4DF0mrG7bkXLgF9i8J7N/8AzoPn
   FKVtdurR0nc6UNr4hi+/v1CgSA48pAvME5TXiX5bX0BUdgk4cQ50p5HSR
   C1uT5zNKchldngnUSdfc0xnMvIDeZc81k13BEYWQO8Qhq3MJL5hF7An5v
   Or9JSqk0UuqvkwqvPCHujuyVD6189+bpMQyREoRIQ/NP2JP3opGHKM3kI
   1y1j6ZFEjJR8TfPY3CpcGewtqGM0WzFqPqjVkEOeNUwRzFqECGkJCCTZD
   Q==;
X-CSE-ConnectionGUID: U1UU7crORSKYm/sfDk7vbg==
X-CSE-MsgGUID: BqU0kVoxQgSfTO1Xxd9DAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="54063566"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="54063566"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 21:05:38 -0800
X-CSE-ConnectionGUID: ba3H0r7PQ6+U3X1SRLkbkg==
X-CSE-MsgGUID: lhaVkVYPQrOmroobyHtgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103104711"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2025 21:05:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVkjc-000H47-2L;
	Thu, 09 Jan 2025 05:05:32 +0000
Date: Thu, 9 Jan 2025 13:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.14 2/36] drivers/nvme/host/tcp.c:1594:13:
 warning: variable 'mq_map' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202501091328.r4kJ6xhy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_210541_763261_068BB489 
X-CRM114-Status: GOOD (  15.00  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.14
head:   b9973aa4d0507c4969ad87763b535edb77b7dceb
commit: bd0f5c10310122f4f1d9468467a59a6f69e46f92 [2/36] nvme-tcp: Fix I/O queue cpu spreading for multiple controllers
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250109/202501091328.r4kJ6xhy-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501091328.r4kJ6xhy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/tcp.c:7:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1583:11: warning: variable 'n' set but not used [-Wunused-but-set-variable]
    1583 |         int cpu, n = 0, min_queues = INT_MAX, io_cpu;
         |                  ^
>> drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1594 |         } else if (nvme_tcp_poll_queue(queue)) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1599:15: note: uninitialized use occurs here
    1599 |         if (WARN_ON(!mq_map))
         |                      ^~~~~~
   arch/s390/include/asm/bug.h:54:25: note: expanded from macro 'WARN_ON'
      54 |         int __ret_warn_on = !!(x);                      \
         |                                ^
   drivers/nvme/host/tcp.c:1594:9: note: remove the 'if' if its condition is always true
    1594 |         } else if (nvme_tcp_poll_queue(queue)) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/host/tcp.c:1582:22: note: initialize the variable 'mq_map' to silence this warning
    1582 |         unsigned int *mq_map;
         |                             ^
         |                              = NULL
   5 warnings generated.


vim +1594 drivers/nvme/host/tcp.c

  1567	
  1568	/**
  1569	 * Track the number of queues assigned to each cpu using a global per-cpu
  1570	 * counter and select the least used cpu from the mq_map. Our goal is to spread
  1571	 * different controllers I/O threads across different cpu cores.
  1572	 *
  1573	 * Note that the accounting is not 100% perfect, but we don't need to be, we're
  1574	 * simply putting our best effort to select the best candidate cpu core that we
  1575	 * find at any given point.
  1576	 */
  1577	static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
  1578	{
  1579		struct nvme_tcp_ctrl *ctrl = queue->ctrl;
  1580		struct blk_mq_tag_set *set = &ctrl->tag_set;
  1581		int qid = nvme_tcp_queue_id(queue) - 1;
  1582		unsigned int *mq_map;
  1583		int cpu, n = 0, min_queues = INT_MAX, io_cpu;
  1584	
  1585		if (wq_unbound)
  1586			goto out;
  1587	
  1588		if (nvme_tcp_default_queue(queue)) {
  1589			mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
  1590			n = qid;
  1591		} else if (nvme_tcp_read_queue(queue)) {
  1592			mq_map = set->map[HCTX_TYPE_READ].mq_map;
  1593			n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
> 1594		} else if (nvme_tcp_poll_queue(queue)) {
  1595			mq_map = set->map[HCTX_TYPE_POLL].mq_map;
  1596			n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
  1597					ctrl->io_queues[HCTX_TYPE_READ];
  1598		}
  1599		if (WARN_ON(!mq_map))
  1600			goto out;
  1601	
  1602		/* Search for the least used cpu from the mq_map */
  1603		io_cpu = WORK_CPU_UNBOUND;
  1604		for_each_online_cpu(cpu) {
  1605			int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
  1606	
  1607			if (mq_map[cpu] != qid)
  1608				continue;
  1609			if (num_queues < min_queues) {
  1610				io_cpu = cpu;
  1611				min_queues = num_queues;
  1612			}
  1613		}
  1614		if (io_cpu != WORK_CPU_UNBOUND) {
  1615			queue->io_cpu = io_cpu;
  1616			atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
  1617			set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
  1618		}
  1619	out:
  1620		dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
  1621			qid, queue->io_cpu);
  1622	}
  1623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

