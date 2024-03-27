Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B19C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Z2NQ8sdg2dUoUea2C8OYeL0CnfcnMcZaHFFL3RyvWE=; b=kFv01qrPKkTIvr5EM4vZnJTSOM
	NygAEn8vtqT4DKEe6dViGtn9J1RHW9uJG+H9WZ18wYL4ePrj2izSiKtxiPc2+CPuco1jTfZCNoy3v
	mSapU2qMpQImV7fF8q/lZh5u9L0at3t1hbo5KwRrwRwM3rEVPnSai1dAjYzVWleeJGktACdbb8O8L
	VgadOy2OuA62lPu5rh+weyKAeWb9O0CVOe3j5rxq3vFOYSuYEG5maezDNJ04MtZVrpLgC5RC1aE4b
	hsMF1msDyzskCOUTspCUH8bMbiWq9k3Cj5+QajToujPsGxpL39+ca80aEJYSsgPBhB8pOwTHat7bs
	EX5xz0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpaOB-0000000B7oS-0xzJ;
	Wed, 27 Mar 2024 21:00:51 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpaO7-0000000B7na-29Ys
	for linux-nvme@lists.infradead.org;
	Wed, 27 Mar 2024 21:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711573247; x=1743109247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DILcLNoZMqAuKsYiRUGTjQP8xjU8ZF97HNeHjd8jYyU=;
  b=A6JF/ekCQ+3ne4xYpRhcwadflILYu13RJnQeWv5d5OEGPzlGlI92mcGV
   5fe8UkyZVAUShHopNgkxJhjTjhPUcsMQY757o5lTteE3LWr0LUvGCx5Dh
   Id4EZKKgBBbw/TLgf8SrivoESzl+ISLjz1mdawycycPchAtmUVS7Sz6Q6
   YNxMoI32ObTKnZ4W0l/IPXaig4nw0cZeM8OoDE4+QektZb9GvBUYtJXKU
   1LhJYH6MY1kjVzpveE+VedSpRiZ0DKg8GL1e29EfNU0gO7xCtr0nT3vTL
   1w2OsyjBp/ZFfSSzoOQnrAVUdcrpPSVn75GfTwuH3hPNQwsZYcm83k5uf
   g==;
X-CSE-ConnectionGUID: ur6Ni2PER4+2sJEtruEmDQ==
X-CSE-MsgGUID: H06WcwZNToShwycfZrPG3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24196233"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="24196233"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="47630938"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Mar 2024 14:00:41 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpaNy-0001Tq-2U;
	Wed, 27 Mar 2024 21:00:38 +0000
Date: Thu, 28 Mar 2024 04:59:45 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202403280412.Ojp0tGKt-lkp@intel.com>
References: <20240326153529.75989-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153529.75989-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_140047_616411_55502D90 
X-CRM114-Status: GOOD (  16.03  )
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

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240326-234521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240326153529.75989-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: arm-randconfig-001-20240327 (https://download.01.org/0day-ci/archive/20240328/202403280412.Ojp0tGKt-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280412.Ojp0tGKt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280412.Ojp0tGKt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/aic7xxx/aic79xx_pci.c:44:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:46:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/scsi/aic7xxx/aic79xx_pci.c:44:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:57:
   In file included from include/scsi/scsi_cmnd.h:7:
   In file included from include/linux/t10-pi.h:6:
   include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   2 warnings and 2 errors generated.
--
   In file included from drivers/scsi/aic7xxx/aic79xx_core.c:43:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:46:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/scsi/aic7xxx/aic79xx_core.c:43:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:57:
   In file included from include/scsi/scsi_cmnd.h:7:
   In file included from include/linux/t10-pi.h:6:
   include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   drivers/scsi/aic7xxx/aic79xx_core.c:5694:13: warning: variable 'data_addr' set but not used [-Wunused-but-set-variable]
    5694 |                         uint64_t data_addr;
         |                                  ^
   3 warnings and 2 errors generated.
--
   In file included from drivers/scsi/aic7xxx/aic7xxx_core.c:43:
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.h:63:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/scsi/aic7xxx/aic7xxx_core.c:43:
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.h:74:
   In file included from include/scsi/scsi_cmnd.h:7:
   In file included from include/linux/t10-pi.h:6:
   include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   drivers/scsi/aic7xxx/aic7xxx_core.c:4171:13: warning: variable 'data_addr' set but not used [-Wunused-but-set-variable]
    4171 |                         uint32_t data_addr;
         |                                  ^
   3 warnings and 2 errors generated.
--
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.c:123:
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.h:63:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.c:123:
   In file included from drivers/scsi/aic7xxx/aic7xxx_osm.h:74:
   In file included from include/scsi/scsi_cmnd.h:7:
   In file included from include/linux/t10-pi.h:6:
   include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1435:24: warning: bitwise operation between different enumeration types ('ahc_feature' and 'ahc_flag') [-Wenum-enum-conversion]
    1435 |             && (ahc->features & AHC_SCB_BTT) == 0) {
         |                 ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   3 warnings and 2 errors generated.
--
   In file included from drivers/scsi/aic7xxx/aic79xx_osm_pci.c:42:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:46:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/scsi/aic7xxx/aic79xx_osm_pci.c:42:
   In file included from drivers/scsi/aic7xxx/aic79xx_osm.h:57:
   In file included from include/scsi/scsi_cmnd.h:7:
   In file included from include/linux/t10-pi.h:6:
   include/linux/blk-mq.h:1240:15: error: unknown type name 'in'
    1240 | static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
         |               ^
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nodelat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   drivers/scsi/aic7xxx/aic79xx_osm_pci.c:177:25: warning: shift count >= width of type [-Wshift-count-overflow]
     177 |                     dma_set_mask(dev, DMA_BIT_MASK(64)) == 0)
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   3 warnings and 2 errors generated.


vim +/blk_nodelat_latency +1242 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nodelat_enable(struct request_queue *q);
  1236	void blk_nodelat_disable(struct request_queue *q);
  1237	u64 blk_nodelat_latency(struct request_queue *q, int node);
  1238	int blk_nodelat_init(struct gendisk *disk);
  1239	#else
> 1240	static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
  1241	static inline void blk_nodelat_disable(struct request_queue *q) {}
> 1242	u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

