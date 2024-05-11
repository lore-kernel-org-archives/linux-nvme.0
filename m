Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF9BC04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 05:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JkZuWGlRfHym36UO4w5Bcd2IQ3gualG2h4aQGRAyf3Q=; b=bFw2EpWkrmJAFOVL1LTuoaloVa
	iGmRjU8OLPZVwloHvJSqhZaO31qvgmWJouxSsYms3GOxFZGccRbhsSA4HHyCMZPmcV9VEyb3iSjm/
	vy8YqSIaDe5A6Bd/z6qwPfBvSfybo6HWx4qwPt9uKiJvP56ls61DD2G3V/He8cDa7yDmmhgpKkFEY
	yCvHP9OMQTYoCAsi5X88s8B9l/BfzoFFMRyAYN6MKRjpaOMUPlDaGpezrzWHSUIMK4zqsB0/x/336
	1YHVXMOTYjFHp50lz5iHl3J/tqPuwNh4sv/0jQ2FSHBj/fdF/U4r+7+KghJHzJUddOSWHeGWjQqUD
	jvfYNS8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5exi-00000007IGW-07TU;
	Sat, 11 May 2024 05:07:58 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5exe-00000007IDZ-0bF2
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 05:07:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715404074; x=1746940074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhuGySNFVnhWhalL8yrD18z/SpIq1B3xcXvrRhoNlFY=;
  b=WOzWnGFBHB++ht2EElDnr8i6AxYXHTpv0xCZ5xqrCHWQEKTjdTGwg0qI
   nbjvh5WYSc79ubyplKYczp5AoAJzQHMd/m2BigM5LV65/TNa8WH+Lbvbm
   W5ZAiD9mocqAeaSO6uYXsuhsWDPbRg4sJRv6NjxAXfEtEGvYiEX+2vFte
   ezZA5wvaQwzNEqav3BHPd1hV6lGu6aoxOASdBugbccOLI9tT4qmzr2Ey4
   WABPN6VPAkKEtOIv4fXII2dolUZrAf3GKekpjNWdIMURnMUAX25ESU9Ep
   kjlCWFcHYea7ai4/Iqt2BE5HWAoXWSnNqE/v/LsVw5QFVVilbTi6w8kuO
   w==;
X-CSE-ConnectionGUID: qI/hcFKCTcSibPEOZAGU0A==
X-CSE-MsgGUID: 9/IC23+CROuJDF0wmn7Veg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22804988"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22804988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:07:50 -0700
X-CSE-ConnectionGUID: X0NDfPKSRN6tw7QcZhAsog==
X-CSE-MsgGUID: T6Ukoa2yQKGF6t5NFw+a6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29835654"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 May 2024 22:07:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5exV-0006xb-0T;
	Sat, 11 May 2024 05:07:45 +0000
Date: Sat, 11 May 2024 13:07:08 +0800
From: kernel test robot <lkp@intel.com>
To: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <202405111234.wXN5f0fB-lkp@intel.com>
References: <20240510102906.51844-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-5-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_220754_208196_0AB5C6E9 
X-CRM114-Status: GOOD (  11.74  )
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

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.9-rc7]
[cannot apply to next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hare-kernel-org/fs-mpage-use-blocks_per_folio-instead-of-blocks_per_page/20240510-183146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240510102906.51844-5-hare%40kernel.org
patch subject: [PATCH 4/5] block/bdev: enable large folio support for large logical block sizes
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240511/202405111234.wXN5f0fB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111234.wXN5f0fB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111234.wXN5f0fB-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bdev.c: In function 'set_init_blocksize':
>> block/bdev.c:145:9: error: implicit declaration of function 'mapping_set_folio_min_order' [-Werror=implicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mapping_set_folio_min_order +145 block/bdev.c

   133	
   134	static void set_init_blocksize(struct block_device *bdev)
   135	{
   136		unsigned int bsize = bdev_logical_block_size(bdev);
   137		loff_t size = i_size_read(bdev->bd_inode);
   138	
   139		while (bsize < PAGE_SIZE) {
   140			if (size & bsize)
   141				break;
   142			bsize <<= 1;
   143		}
   144		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 > 145		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
   146					    get_order(bsize));
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

