Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D2DCD128A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40Dmp7y01M8YV+p8cy306w6ck2tp7r13MEc+KjFXbRg=; b=mXfKAG4+xhB3DaVCG03sH1SBzU
	nZm4pfEAHG++2Vf2FQbk9IMfGnaZbCitb9BiOl/Zambmn/0q58kxAjyJ6qHJ6IQjJy3rqq0YBTtz0
	Td4sKghR8m1qJyDD36dUJ0L5ekbFIKbgeqFtJTsyM09l+W5zIFXXn9Kdij+m49vWehG0RugN57HW/
	Qml4N5JOpQHE+3PMN9R9uM7/cULV9nkYqZGUefZZQh37cAtZzx24eOEzDMst+u9ilXixsMPwFv07c
	TwYtSqvpdhApKFm84+h72OFt1cXnrItLYMw/s/265W9EhWXNb22LrvPfc/2OsyqJKUTQCaI7Bz8cR
	wYDCPh5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsClF-00000000yqF-2S7y;
	Thu, 04 Apr 2024 02:23:29 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsClB-00000000ypn-2lZs
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 02:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712197406; x=1743733406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOXl+c6fjnGSgBdKeGU7MYyvF2VkR4Gp4ish3zSpPUs=;
  b=KchnouC31nhcM2bixrTpKSWmoWzVYB3TTc0aiYxuzmaQLmoyxkeYSK5n
   SaiJw6iCb5GxRq6qUcffzMEPEvbLLV/DDrfzDVTt1fTBYtwyX1Jh80JDS
   Ebj46bwZIKs0ndkZjXkcDk01cr7ms+obzkw3/XixFRB/RXhOT98zaIF7Z
   waUZn+sb8Wg7iBZA5avFSBbZNsH5uhzgXErButAqEA4U6NfKMCQsGIODJ
   0SBMAbwyHyd5Sb3u5LOGG7Uvetyxqxbfbbnh3NhSUK95E1rtqK4No5ote
   ZXA4EpgnXsweiAf6w/gK6YLPU87ubZf1M4l/AX5IQagH56KgstXlAjeyE
   Q==;
X-CSE-ConnectionGUID: gF2wLCUZT0i15OCmJerLew==
X-CSE-MsgGUID: mYtm4MTLSEG95PkNinIZSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7698332"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7698332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:23:24 -0700
X-CSE-ConnectionGUID: O2se1tykSFiiDIIO5vVv/A==
X-CSE-MsgGUID: nP6sjbbBTluHPIL8KhE1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18609355"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Apr 2024 19:23:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsCl5-0000Uv-2L;
	Thu, 04 Apr 2024 02:23:19 +0000
Date: Thu, 4 Apr 2024 10:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404041051.89LVIrNh-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_192325_894832_965BFF3B 
X-CRM114-Status: GOOD (  12.72  )
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
[also build test WARNING on linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/block-track-per-node-I-O-latency/20240403-222254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240403141756.88233-2-hare%40kernel.org
patch subject: [PATCH 1/2] block: track per-node I/O latency
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240404/202404041051.89LVIrNh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404041051.89LVIrNh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404041051.89LVIrNh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:5,
                    from block/bdev.c:15:
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^~


vim +/blk_nlat_latency +1242 include/linux/blk-mq.h

  1233	
  1234	#ifdef CONFIG_BLK_NODE_LATENCY
  1235	int blk_nlat_enable(struct gendisk *disk);
  1236	void blk_nlat_disable(struct gendisk *disk);
  1237	u64 blk_nlat_latency(struct gendisk *disk, int node);
  1238	int blk_nlat_init(struct gendisk *disk);
  1239	#else
  1240	static inline int blk_nlat_enable(struct gendisk *disk) { return 0; }
  1241	static inline void blk_nlat_disable(struct gendisk *disk) {}
> 1242	u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

