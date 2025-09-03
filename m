Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCFCA0FF2
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkAQKvamdNI9/yxeGyE5J4Umhegr9VA97uf7u7suFl0=; b=qBDsmdAZNCoFa+6Acu/zmLiAm0
	mk+Lzo91+J9nHn5Q7nomhHBgL3F8vX6qtYI0QDk4lpdh5cfZiXEzGdNEo5STT46xQPDlqbPB/X49x
	19gFaV78HzLO+vB0PN66NIhc2T7H6hsVn2C/3zq1FpuYkYsuj9cfD4TnsXjFKrWIcVnc9IIEtIh74
	jPymCZocgMiKwlV826Y+lXbDF4iIIRkz1Ilpn7r7A0uGHTWYKzxG243t6InpWGDGg5rg2v3RX+MBV
	jO7LEvwWc9jF2AxDB0ze17ggqqHDyZc5dq+JxuOdkyH4hBSv6x1MQhXBkorTTk3CIxTEgwDhFjBfp
	AxcoAR3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utmJx-00000006LPs-2rv7;
	Wed, 03 Sep 2025 12:10:37 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utlH6-00000006Ag1-3Qpi
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 11:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756897417; x=1788433417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mK48HJuRtxhk+rOliRCyAqWX/GoUBTZ5QYLNKbcRyYw=;
  b=i+GulbRQOhz5XA2fUUUTdIgIZo21RMriofJL7LdrPg7Oowo5rhaDPize
   eLLAowWI4dHkXHm9V3g+dk/5z3XuAybA/w59KRuZYSHkCa2umTNQG6QDy
   t+RqV0ZwQuDLJ7wDzwE03mtUOuiBoUhJj2Xm2GeGVAg9LKUYDcPZS/b//
   mNcdC2SxV6ZpVZGcKd/oj7YBOWaV2qlxW8AUsE/CIwUsSvgi473K1jh3q
   FML3/ctZBVUiDypVO3tyHenK94yPOe9G0Vi08vKwrqmm/0ZJKevz1pQNC
   rARxDeTJDtfqfnls6/dgUfhaYm5OefAvSgvV59h2t+Q2U1g9ykBvKq/q6
   w==;
X-CSE-ConnectionGUID: Crbh8jKnRDiYHTGEyCznrw==
X-CSE-MsgGUID: iFPBc6NHRJC2vRXGFaPRUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58904964"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="58904964"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:03:36 -0700
X-CSE-ConnectionGUID: gRJxoQ3FRNGAf1Y59gxKfg==
X-CSE-MsgGUID: VBmY371+T4aCAUCQNZWhcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="175914870"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2025 04:03:33 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utlH0-0003lf-2w;
	Wed, 03 Sep 2025 11:03:30 +0000
Date: Wed, 3 Sep 2025 19:02:40 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com, leon@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <202509031816.qq7ODYRv-lkp@intel.com>
References: <20250902200121.3665600-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902200121.3665600-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_040336_912131_2651641D 
X-CRM114-Status: GOOD (  13.69  )
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
[also build test ERROR on next-20250903]
[cannot apply to linus/master linux-nvme/for-next hch-configfs/for-next v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-integrity-enable-p2p-source-and-destination/20250903-040417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250902200121.3665600-3-kbusch%40meta.com
patch subject: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250903/202509031816.qq7ODYRv-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031816.qq7ODYRv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031816.qq7ODYRv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/bdev.c:15:
>> include/linux/blk-integrity.h:127:20: error: redefinition of 'blk_rq_dma_unmap'
     127 | static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
         |                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/blk-integrity.h:7:
   include/linux/blk-mq-dma.h:71:20: note: previous definition of 'blk_rq_dma_unmap' with type 'bool(struct request *, struct device *, struct dma_iova_state *, size_t)' {aka '_Bool(struct request *, struct device *, struct dma_iova_state *, unsigned int)'}
      71 | static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
         |                    ^~~~~~~~~~~~~~~~


vim +/blk_rq_dma_unmap +127 include/linux/blk-integrity.h

   101	
   102	/*
   103	 * Return the current bvec that contains the integrity data. bip_iter may be
   104	 * advanced to iterate over the integrity data.
   105	 */
   106	static inline struct bio_vec rq_integrity_vec(struct request *rq)
   107	{
   108		return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
   109					 rq->bio->bi_integrity->bip_iter);
   110	}
   111	#else /* CONFIG_BLK_DEV_INTEGRITY */
   112	static inline int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
   113					   struct logical_block_metadata_cap __user *argp)
   114	{
   115		return -ENOIOCTLCMD;
   116	}
   117	static inline int blk_rq_count_integrity_sg(struct request_queue *q,
   118						    struct bio *b)
   119	{
   120		return 0;
   121	}
   122	static inline int blk_rq_map_integrity_sg(struct request *q,
   123						  struct scatterlist *s)
   124	{
   125		return 0;
   126	}
 > 127	static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
   128			struct dma_iova_state *state, size_t mapped_len)
   129	{
   130		return false;
   131	}
   132	static inline int blk_rq_integrity_map_user(struct request *rq,
   133						    void __user *ubuf,
   134						    ssize_t bytes)
   135	{
   136		return -EINVAL;
   137	}
   138	static inline bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   139			struct device *dma_dev,  struct dma_iova_state *state,
   140			struct blk_dma_iter *iter)
   141	{
   142		return false;
   143	}
   144	static inline bool blk_rq_integrity_dma_map_iter_next(struct request *req,
   145			struct device *dma_dev, struct blk_dma_iter *iter)
   146	{
   147		return false;
   148	}
   149	static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
   150	{
   151		return NULL;
   152	}
   153	static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
   154	{
   155		return NULL;
   156	}
   157	static inline bool
   158	blk_integrity_queue_supports_integrity(struct request_queue *q)
   159	{
   160		return false;
   161	}
   162	static inline unsigned short
   163	queue_max_integrity_segments(const struct request_queue *q)
   164	{
   165		return 0;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

