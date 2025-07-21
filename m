Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEFEC83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 03:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h8JrXscKdqgB0b633F3GYTkHcVRba5tLgnQCR94H+BY=; b=za9xG+H4uzL66BJ4DtVexD7T4R
	UF2kq9F58rdQtUSIGACS48MnFzjFsjMRq0C7pOmKVlwd84Ghfpxw9dbTAWsEd+w5YtGnFnfmLmSmh
	R+Czcg1ju8P4y24mrn/sBYvNKsJAPMJb0obVvKf68LvcBzrRlPNEnpQkUVNK5t5nx08JamgS/FzJL
	UYca4nV6TrLDgFRhHVSh7X07JCh1rUVbj4UWJUG5WiQC7BdFnqbaX6liAXaz7KqfaDUndgvPiLONA
	uq5NCl7ScJ2k3Yh2+SHh7cllk7G7bps9N5GcRtYFFBL9obfokBQ47Lpy2RKcWLl9FiXb6W0lGFmaS
	mmFtE8xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udhEo-0000000G5xz-2yyX;
	Mon, 21 Jul 2025 03:30:50 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udh2o-0000000G4y1-1M4O
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 03:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753067906; x=1784603906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NB/3g3CKXVMN+VyWjazs/iNfNp4t6kaGPAFZ6ryxo30=;
  b=XcpofzTa61pICo2C0pGihZ/AQTruqaA0J8OE6lQILaOC11jJJunkxeqM
   KhRwXB0xgIPmzCn0Djf3m0L9necarXOqVYM4WdZKKFT+bz6rxpDx0GLwf
   gbZNKOVgOLAdu3PhtoklCW9IjB+hQ/U1wm6Tx5AYUuXAYMpZRXKd0yCQD
   XletiPgihigxrGzJi0cWBUxs2WaIluYk/GOfEMavN3lxofcG/aizfq/W2
   9hcOiwWPDK40sfU0K9h5l5s2qyJplGO6AslnjgraQdwjo6LGwNW/fZtpK
   epoSych2ytW+qJaawH9B9Wq7BhjrqhGwqWua2Ilc5tfbh2t+w6tYmZSWK
   A==;
X-CSE-ConnectionGUID: P1yH/qDzQkOhA/l/kDee8A==
X-CSE-MsgGUID: 6v6y5BwDRR+iQey3dA7Pdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55154517"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55154517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 20:18:25 -0700
X-CSE-ConnectionGUID: 21tY3aaWT2uX9lHI3haEKQ==
X-CSE-MsgGUID: uatQ71rUTMe5O77rcYQr1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="163264139"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jul 2025 20:18:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udh2i-000GRB-1z;
	Mon, 21 Jul 2025 03:18:20 +0000
Date: Mon, 21 Jul 2025 11:18:18 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <202507211037.lzkMQLrY-lkp@intel.com>
References: <20250720184040.2402790-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_201826_520983_5178BB5B 
X-CRM114-Status: GOOD (  15.46  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc7 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-dma-move-the-bio-and-bvec_iter-to-blk_dma_iter/20250721-024616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250720184040.2402790-7-kbusch%40meta.com
patch subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
config: riscv-randconfig-001-20250721 (https://download.01.org/0day-ci/archive/20250721/202507211037.lzkMQLrY-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507211037.lzkMQLrY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507211037.lzkMQLrY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/blk-mq.c:13:
>> include/linux/blk-integrity.h:117:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_start' [-Wmissing-prototypes]
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         |      ^
   include/linux/blk-integrity.h:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         | ^
         | static 
>> include/linux/blk-integrity.h:123:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_next' [-Wmissing-prototypes]
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         |      ^
   include/linux/blk-integrity.h:123:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         | ^
         | static 
   2 warnings generated.
--
   In file included from block/blk-mq-dma.c:5:
>> include/linux/blk-integrity.h:117:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_start' [-Wmissing-prototypes]
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         |      ^
   include/linux/blk-integrity.h:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     117 | bool blk_rq_integrity_dma_map_iter_start(struct request *req,
         | ^
         | static 
>> include/linux/blk-integrity.h:123:6: warning: no previous prototype for function 'blk_rq_integrity_dma_map_iter_next' [-Wmissing-prototypes]
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         |      ^
   include/linux/blk-integrity.h:123:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     123 | bool blk_rq_integrity_dma_map_iter_next(struct request *req,
         | ^
         | static 
   block/blk-mq-dma.c:23:27: error: no member named 'bi_integrity' in 'struct bio'
      23 |                 iter->iter = iter->bio->bi_integrity->bip_iter;
         |                              ~~~~~~~~~  ^
   block/blk-mq-dma.c:24:27: error: no member named 'bi_integrity' in 'struct bio'
      24 |                 iter->bvec = iter->bio->bi_integrity->bip_vec;
         |                              ~~~~~~~~~  ^
   2 warnings and 2 errors generated.


vim +/blk_rq_integrity_dma_map_iter_start +117 include/linux/blk-integrity.h

    90	
    91	/*
    92	 * Return the current bvec that contains the integrity data. bip_iter may be
    93	 * advanced to iterate over the integrity data.
    94	 */
    95	static inline struct bio_vec rq_integrity_vec(struct request *rq)
    96	{
    97		return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
    98					 rq->bio->bi_integrity->bip_iter);
    99	}
   100	#else /* CONFIG_BLK_DEV_INTEGRITY */
   101	static inline int blk_rq_count_integrity_sg(struct request_queue *q,
   102						    struct bio *b)
   103	{
   104		return 0;
   105	}
   106	static inline int blk_rq_map_integrity_sg(struct request *q,
   107						  struct scatterlist *s)
   108	{
   109		return 0;
   110	}
   111	static inline int blk_rq_integrity_map_user(struct request *rq,
   112						    void __user *ubuf,
   113						    ssize_t bytes)
   114	{
   115		return -EINVAL;
   116	}
 > 117	bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   118			struct device *dma_dev,  struct dma_iova_state *state,
   119			struct blk_dma_iter *iter)
   120	{
   121		return false;
   122	}
 > 123	bool blk_rq_integrity_dma_map_iter_next(struct request *req,
   124			struct device *dma_dev, struct blk_dma_iter *iter)
   125	{
   126		return false;
   127	}
   128	static inline struct blk_integrity *bdev_get_integrity(struct block_device *b)
   129	{
   130		return NULL;
   131	}
   132	static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
   133	{
   134		return NULL;
   135	}
   136	static inline bool
   137	blk_integrity_queue_supports_integrity(struct request_queue *q)
   138	{
   139		return false;
   140	}
   141	static inline unsigned short
   142	queue_max_integrity_segments(const struct request_queue *q)
   143	{
   144		return 0;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

