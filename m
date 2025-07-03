Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C91CC83F03
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TE9d5/X4hmotvaaAaxofLyXGOMK0orezqoakTSP7+w=; b=ZSSrUBpiteLZKFI7fjxoIEqwU/
	ONgxhRG9HZnXUk2jaP8ikSK1LP+rJ8qxtnp0vIISDdRiObrep4/DyxDzk/jQvdLJoCJBXGcPsPLMO
	7PSyMrwZw/AQOcO2vNRD1xelA9PDvwa5sn68vuA61okEhu+OHZzqoqujwtiFKKfUcbMjtiRJ1i1/+
	MWnYf9aT+B5FET9RP5l84Ty29airftmmV6fhJgDvUY6NPPTFgg6Nrks9/XiEiggBubg3lOSvxQMes
	FLkW7yZ9VT6qYJLDPAODHidOG2KR5JayNi7xdktU0V4fvS0fg/kIIUG3DY1Ug5u07Lnw9YTaK0lLe
	7WjjRRaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXNcn-0000000C7Lp-0iM3;
	Thu, 03 Jul 2025 17:21:29 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXLDo-0000000Bifn-3JBL
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 14:47:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751554052; x=1783090052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rK9CghBMfaxHWwZL0Y+AWxw/v++vtFMy/hmsv9qL7LI=;
  b=NskcBr73mrEaMLBjyLvOVyeWBSHKb/1eNBtBrAx0UqGSLgst/PxK6oVS
   tCSupKJ6mWUAmsUuZuaZeoGrxz/tdjOXya1K5PfWkUgyXFIUnOWN+san5
   PWwoFEg9qv5rmFWbWbxKaVY0Ipd42uVA9fZEFuirOnJ/A0JqlmjdDKXRX
   jN8LG6/Im/v32u5t+oaPKZ2t3q+MOveG3pbdoBglOurCXl/tUZl56ogfp
   EFDXKFGkHwwfY3CjsCwGUZjrhLpZV8dp+6QPDNwtEO5tmcnPXHwks5WYz
   GSdG7cRBbJMxSA3lv5t50E7Y9DaoZvuK5HVgVFtv4nHrPhTManBOhEwzx
   Q==;
X-CSE-ConnectionGUID: YFSITkylROOEFZXRTxsyUg==
X-CSE-MsgGUID: i6pn8MAIRbqr1gTSJtHzzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53851722"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53851722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:47:30 -0700
X-CSE-ConnectionGUID: do+iUI8IT32SBrmjq0xoyg==
X-CSE-MsgGUID: kIJe5JEsQwmuIcgjNo0AQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153800515"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Jul 2025 07:47:17 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXLDT-0001vf-31;
	Thu, 03 Jul 2025 14:47:11 +0000
Date: Thu, 3 Jul 2025 22:47:01 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <202507032238.AoTmQnGP-lkp@intel.com>
References: <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_074732_881021_1E7CC0A0 
X-CRM114-Status: GOOD (  13.75  )
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

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 32f85e8468ce081d8e73ca3f0d588f1004013037]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/lib-group_cpus-Add-group_masks_cpus_evenly/20250703-003811
base:   32f85e8468ce081d8e73ca3f0d588f1004013037
patch link:    https://lore.kernel.org/r/20250702-isolcpus-io-queues-v7-8-557aa7eacce4%40kernel.org
patch subject: [PATCH v7 08/10] blk-mq: use hk cpus only when isolcpus=io_queue is enabled
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20250703/202507032238.AoTmQnGP-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f1a4bb62452d88a0edd9340b3ca7c9b11ad9193f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250703/202507032238.AoTmQnGP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507032238.AoTmQnGP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq-cpumap.c:155:16: error: array initializer must be an initializer list
     155 |         cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
         |                       ^
   block/blk-mq-cpumap.c:219:16: error: array initializer must be an initializer list
     219 |         cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
         |                       ^
   block/blk-mq-cpumap.c:220:16: error: array initializer must be an initializer list
     220 |         cpumask_var_t mask __free(free_cpumask_var) = NULL;
         |                       ^
   3 errors generated.


vim +155 block/blk-mq-cpumap.c

   144	
   145	/*
   146	 * blk_mq_map_hk_queues - Create housekeeping CPU to
   147	 *                        hardware queue mapping
   148	 * @qmap:	CPU to hardware queue map
   149	 *
   150	 * Create a housekeeping CPU to hardware queue mapping in @qmap. @qmap
   151	 * contains a valid configuration honoring the isolcpus configuration.
   152	 */
   153	static void blk_mq_map_hk_queues(struct blk_mq_queue_map *qmap)
   154	{
 > 155		cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
   156		struct cpumask *hk_masks __free(kfree) = NULL;
   157		const struct cpumask *mask;
   158		unsigned int queue, cpu, nr_masks;
   159	
   160		if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
   161			mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
   162		else
   163			goto fallback;
   164	
   165		if (!zalloc_cpumask_var(&active_hctx, GFP_KERNEL))
   166			goto fallback;
   167	
   168		/* Map housekeeping CPUs to a hctx */
   169		hk_masks = group_mask_cpus_evenly(qmap->nr_queues, mask, &nr_masks);
   170		if (!hk_masks)
   171			goto fallback;
   172	
   173		for (queue = 0; queue < qmap->nr_queues; queue++) {
   174			unsigned int idx = (qmap->queue_offset + queue) % nr_masks;
   175	
   176			for_each_cpu(cpu, &hk_masks[idx]) {
   177				qmap->mq_map[cpu] = idx;
   178	
   179				if (cpu_online(cpu))
   180					cpumask_set_cpu(qmap->mq_map[cpu], active_hctx);
   181			}
   182		}
   183	
   184		/* Map isolcpus to hardware context */
   185		queue = cpumask_first(active_hctx);
   186		for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
   187			qmap->mq_map[cpu] = (qmap->queue_offset + queue) % nr_masks;
   188			queue = cpumask_next_wrap(queue, active_hctx);
   189		}
   190	
   191		if (!blk_mq_hk_validate(qmap, active_hctx))
   192			goto fallback;
   193	
   194		return;
   195	
   196	fallback:
   197		/*
   198		 * Map all CPUs to the first hctx to ensure at least one online
   199		 * housekeeping CPU is serving it.
   200		 */
   201		for_each_possible_cpu(cpu)
   202			qmap->mq_map[cpu] = 0;
   203	}
   204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

