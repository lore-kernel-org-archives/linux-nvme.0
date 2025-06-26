Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA33C7EE30
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0ZhEKF4/9gdpK7KxU6YhqpuOosLCwKGVMV36ARTXpA=; b=KydmimaK5VX7mJH4i8aqS6oZb0
	kq2JeT5j1RUxn4z2mWgC/1IkM2g5O+Mbzw5fuo77suSiGBiIhRHBzH+mEYhCeYoKZNGZ9DAhX/E0D
	zISwHYXFuCJ4pP390eMz5YfsTDBLZc/1i9DjJoKsWF+2ELiHnjunbHBgjKGfU5TZRMWKWaUoYOhK2
	BBGYBt/WcCfhnMs3XRI47HSFpYuGUagpY1LFEFEwUmqBzG3LuIw4Oev9jiq6Cf7t6hBfvf1dqxsuf
	VfDzCdgsmBL7xfx9a9Y46n6gyelsY25GxClE62seoT7lsmVjHp/8/KtseE+/jurPLBJRDUJBRoDwa
	RxihXFnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn73-0000000BpWp-13JX;
	Thu, 26 Jun 2025 13:58:01 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn5R-0000000BoSP-0ebg
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 13:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946181; x=1782482181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jaqXXG5R4koVOdTArTjFoKG688MrkA8k9DmX3GDeMlU=;
  b=mxxV0PZRrsaNSN0P7yjiPna4aotf6LblGGq/3hVa3WWJZaCiRL6Xr7T+
   64FCsB3P6Ax8bgN5RzEfScPL6AeUb3cF/k+ebLpyHeqKj4GBWAAwSHQcE
   hZ3UCldFV005ewhmKrD6ap/TLY1UrXnb94gTkm9QwBsQeI/6cHQ0tV3Ph
   ZwzurpbMB2Jo4UMsjmYheuV+c2RywKPTnZ4AVFvIUQf5e1m8Ljtmkdrvr
   /CoJRr4wF8Ze8p2c+NNA6gyMUmiz8n8L9UctvNTOcNeExlYHOkXM9VqpS
   Rp62/EBMOdVD1zRW/3G7mfZcItr2UeGtsBGaRB0Rk66iTccQLRtTg+3V9
   g==;
X-CSE-ConnectionGUID: uhnc0CJWRZuPyRrkBC47wA==
X-CSE-MsgGUID: IYKVYPLvRQ6VAhsDx+ck7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53183636"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="53183636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:56:19 -0700
X-CSE-ConnectionGUID: NGH7T0xSTASuJYnDRCPHKw==
X-CSE-MsgGUID: iW5K/uxGRXqFk+6Dxx6XNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="158024990"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2025 06:56:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUn5K-000U72-2R;
	Thu, 26 Jun 2025 13:56:14 +0000
Date: Thu, 26 Jun 2025 21:55:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leon@kernel.org, joshi.k@samsung.com, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Message-ID: <202506262128.hNOOLoxM-lkp@intel.com>
References: <20250625204445.1802483-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_065621_203929_A4F40DD8 
X-CRM114-Status: GOOD (  12.58  )
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

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on next-20250626]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-convert-metadata-mapping-to-dma-iter/20250626-044623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250625204445.1802483-2-kbusch%40meta.com
patch subject: [PATCH 2/2] nvme: convert metadata mapping to dma iter
config: i386-buildonly-randconfig-002-20250626 (https://download.01.org/0day-ci/archive/20250626/202506262128.hNOOLoxM-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506262128.hNOOLoxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506262128.hNOOLoxM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/pci.c:1023:7: error: call to undeclared function 'blk_rq_integrity_dma_map_iter_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1023 |         if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
         |              ^
   drivers/nvme/host/pci.c:1023:7: note: did you mean 'blk_rq_dma_map_iter_start'?
   include/linux/blk-mq-dma.h:21:6: note: 'blk_rq_dma_map_iter_start' declared here
      21 | bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
         |      ^
>> drivers/nvme/host/pci.c:1041:11: error: call to undeclared function 'blk_rq_integrity_dma_map_iter_next'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1041 |         } while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
         |                  ^
   drivers/nvme/host/pci.c:3336:41: warning: shift count >= width of type [-Wshift-count-overflow]
    3336 |                 dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 2 errors generated.


vim +/blk_rq_integrity_dma_map_iter_start +1023 drivers/nvme/host/pci.c

  1012	
  1013	static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
  1014	{
  1015		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
  1016		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
  1017		struct nvme_dev *dev = nvmeq->dev;
  1018		struct nvme_sgl_desc *sg_list;
  1019		struct blk_dma_iter iter;
  1020		dma_addr_t sgl_dma;
  1021		int i = 0;
  1022	
> 1023		if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
  1024			return iter.status;
  1025	
  1026		sg_list = dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
  1027				&sgl_dma);
  1028		if (!sg_list)
  1029			return BLK_STS_RESOURCE;
  1030	
  1031		iod->meta_descriptor = sg_list;
  1032		iod->meta_dma = sgl_dma;
  1033	
  1034		iod->cmd.common.flags = NVME_CMD_SGL_METASEG;
  1035		iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
  1036	
  1037		sgl_dma += sizeof(*sg_list);
  1038	
  1039		do {
  1040			nvme_pci_sgl_set_data(&sg_list[++i], &iter);
> 1041		} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
  1042	
  1043		nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
  1044		iod->nr_meta_descriptors = i;
  1045		return BLK_STS_OK;
  1046	}
  1047	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

