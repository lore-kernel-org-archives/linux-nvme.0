Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F01DC25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 15 May 2024 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RctCcRRkIOTCyt3b9sRiHNaEzQgnz3JHbqT1g9L+YQ0=; b=utggh4UeMkAyY8GVWidF+LeY3M
	3rJSu0a7AQeIUmPX8A3ioJlizvuGvC996siD+LeUz+SV8BIjGQt6b1qSnJOF3J6ERdBx13n5kbUXw
	JRT1lkLVmVBGiKEUYVSAAdMrxb5Lx12hl2v/DYoaXWGcDs7Oc+HM3I1izz+u4WVBvAdvzF0UvL7ny
	b7HhnKBaIBChlz5dSzH0Zzi3kLO5xygzcbsTsT9LpzYlnw8/uyqC3+dD72nkmh37XGZBK4K3rDVlf
	8I1VTFuqhW0RU9yOSOYXTtBlQ1G+A9Yd1tPD7e4+4IGRnQzKnm6tbQyrhcqRbD9dYgjK4kCxCQAAW
	4XJ4DRLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s75pf-00000000Nus-27lx;
	Wed, 15 May 2024 04:01:35 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s75pc-00000000Nty-1xZk
	for linux-nvme@lists.infradead.org;
	Wed, 15 May 2024 04:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715745692; x=1747281692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4o5o8/E/agz++Q0onYaGr6q+aONflbBNmjrrJGqeJ8=;
  b=AkLE4GlkYfclHqvbzrmHRAQL1cUq3lsyXXYf5yfwQj4BdFgEXNYK1ybx
   SmThDkaBgYe5TwMBqeoYwHK31QRyOfySHQE4wxBy8jsqsoux2hd7QnMQc
   QgTCCQNB5mt1DLa4jLoTE/NH4fY8RruuTwHF962iOc3rji3U3tBkPclG1
   YBIC53rWhDmZp2DmpbcdTD6JCRAWnD1DOn5ws8KnQ+LWaXiPYu4pNyI0Z
   uo+wqUPl8EsdBQIeilw5v1qE6UoFIzU+lmXjXlZ8DO8J1VLIlUbKBIi4x
   JMYkgVuazIwywTvU4MK5nInpcUHwLEhg3Zd7qXt1ndxTyndWfWt+JbJyj
   g==;
X-CSE-ConnectionGUID: BMi0JEf9SOSEAXtSwf2G5g==
X-CSE-MsgGUID: x5mNUTixTDatqVtXai+Lxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15605252"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="15605252"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 21:01:23 -0700
X-CSE-ConnectionGUID: eoBQM39LSJ2YM2c1j8zSrg==
X-CSE-MsgGUID: 3rlZ+wnqQrCLAeRrJQSEJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="31330119"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 May 2024 21:01:20 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s75pO-000COd-0o;
	Wed, 15 May 2024 04:01:18 +0000
Date: Wed, 15 May 2024 12:00:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
Message-ID: <202405151142.8COQSJsa-lkp@intel.com>
References: <20240514173900.62207-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514173900.62207-6-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_210132_615212_E71A32E8 
X-CRM114-Status: GOOD (  17.92  )
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
[also build test ERROR on linus/master v6.9]
[cannot apply to next-20240514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/fs-mpage-avoid-negative-shift-for-large-blocksize/20240515-014146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240514173900.62207-6-hare%40kernel.org
patch subject: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240515/202405151142.8COQSJsa-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405151142.8COQSJsa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405151142.8COQSJsa-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bdev.c: In function 'set_init_blocksize':
   block/bdev.c:145:9: error: implicit declaration of function 'mapping_set_folio_min_order' [-Werror=implicit-function-declaration]
     145 |         mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/bdev.c: In function 'set_blocksize':
>> block/bdev.c:152:23: error: 'bs' undeclared (first use in this function); did you mean 'abs'?
     152 |         if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
         |                       ^~
         |                       abs
   block/bdev.c:152:23: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +152 block/bdev.c

   148	
   149	int set_blocksize(struct block_device *bdev, int size)
   150	{
   151		/* Size must be a power of two, and between 512 and MAX_PAGECACHE_ORDER*/
 > 152		if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
   153		    !is_power_of_2(size))
   154			return -EINVAL;
   155	
   156		/* Size cannot be smaller than the size supported by the device */
   157		if (size < bdev_logical_block_size(bdev))
   158			return -EINVAL;
   159	
   160		/* Don't change the size if it is same as current */
   161		if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
   162			sync_blockdev(bdev);
   163			bdev->bd_inode->i_blkbits = blksize_bits(size);
   164			mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
   165						    get_order(size));
   166			kill_bdev(bdev);
   167		}
   168		return 0;
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

