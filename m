Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1CBCD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6a3qLPNc3D0QF2xDih3z7zXm7XpBt2EeStE6+7nqdxs=; b=LBMx7PZkD/39e4JnEX7b0TS8Fn
	OtTxm8nIoPFXJgU3eAO+zlK16saP8aLY/gpEii3Eq7xHVG9ng3oyHFia0qK4QdHc41bkXR25SaGcA
	I9Gn64ooSadl7Xp1+Ro9azB6Nd8900s0FaFRkrTde28OM+CeqyZEwKQpKvcvv2CP8OdAfSznA5u0M
	3FsYi7DL4Pvfhryzep5NcFYOIj9Bv+09ig1HUwAoFOpvf+xnsb/cT/V7ldFQTgT24plKPNUevnirA
	DSMdn9hpdUNG0s2JHydHSIuOb6/DxkxSL++SfYIK1jisB4T6jT089f64LzY4Rky/k0HyVGNjNT/2l
	UPuecX+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsS9C-00000003uWI-04yw;
	Thu, 04 Apr 2024 18:49:14 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsS97-00000003uVF-2iZa
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 18:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712256550; x=1743792550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1yHR13LMvqMhssupELkMLJy9srd8c4LfjZpuES3zNQ=;
  b=EOPjt6ij1uk661H8Ix6kLThNmbRfiQXCooFPlYWFZWzHAnPdiF9qHvXO
   3OVHD1SuCJR7HaVE2dQGRzyeKn4/g4aSyX4ZGueTnWfijgPzReTcCimI1
   6DtBO6VYwCqhb4Uc7Dn0y29xqAOiEkzCzjsPK18pR+A8MQq415xL+XWox
   edsdtSKBJHB/I2IqJcBffHhbWRsrnPIY+aYwbr0TM3vtXsAELsghlWLlq
   w53kh4aYoJW5RgK3EnwTkzwOcqxrImk7TJT48BJC2gapsvC1sSGAbWQBN
   rrdGJkx92VX2oYS4UYgrOE8gPY8/ZSXrSt9IqzWTEXPk765M+H6tEzGTL
   g==;
X-CSE-ConnectionGUID: FDeiBEIgT5eZQRzYTdRt9A==
X-CSE-MsgGUID: o+kqtrR/Rba9Dj5cjkbLbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7800051"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7800051"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:49:07 -0700
X-CSE-ConnectionGUID: Gjwf6HfMTtKWRqxdtEmlOA==
X-CSE-MsgGUID: ZplNi7DnQimuLodTgr0YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23542046"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 11:49:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsS91-0001O2-0K;
	Thu, 04 Apr 2024 18:49:03 +0000
Date: Fri, 5 Apr 2024 02:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404050222.vYNG4y3i-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_114909_777502_7443D705 
X-CRM114-Status: GOOD (  12.46  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.9-rc2 next-20240404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240403-222254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240403141756.88233-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240405/202404050222.vYNG4y3i-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050222.vYNG4y3i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050222.vYNG4y3i-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/loop.c:36:
   include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~
>> include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/in +1243 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nlat_enable(struct gendisk *disk);
  1236	void blk_nlat_disable(struct gendisk *disk);
  1237	u64 blk_nlat_latency(struct gendisk *disk, int node);
  1238	int blk_nlat_init(struct gendisk *disk);
  1239	#else
  1240	static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
  1241	static inline void blk_nlat_disable(struct gendisk *disk) {}
  1242	u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
> 1243	static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

