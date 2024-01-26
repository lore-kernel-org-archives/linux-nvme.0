Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF04BC47DDB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/E6SchMT/MBTkigsKRtKzMaww505l1rRLlIaIQ2soUg=; b=xzOLFhnyL+QzuWqCr+bVEeZwkH
	8jeyTGDg+4xYubyft07X3zai9JU59kKnHLTUXe66pZ0BTSUTYB1uRvwstDtDyNPOaZqXjRsikA/C7
	jEo9DwPy0vPdEKyAplC5MkZrslfqzuJ0j3R2gHne6Bsce1uU1IPL873NVOxKei3Jss7M/WELsZrSq
	qn3q9S3vNRa6fJyAwH30dwAIbmDSRIZGpQKH5Lz/LjWGNiOIHUKdlQVyJqvBun4iW5eIbhwNLasSa
	0Eeo92ehcjf0BwOzydzfkZVCUnjge48yDLooVvMXZ2cBljaQS4ieGM73MNSy+yj2CaDyW1IOy6S3c
	2206I1Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTUJY-00000005XQZ-0Q1X;
	Fri, 26 Jan 2024 22:04:44 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTUJV-00000005XP7-0Ms9
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 22:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706306681; x=1737842681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PgTmG/yzGVqUhuwJ1i6jbTUkm8ADJwrhKbzlIpQ+M9M=;
  b=JWJ+sv26MxX9zZJmjGYli49OTh8cPFCG54mRzHgNoTZPBE1O/zcsCzFL
   wlPgWR6b1tSXS7CS0cTvtgaWGCjK6tXSb/MSK095SGVzxmX09UNrcBJha
   AzjP9BF7tDrvCuJKALpqLQHutR/+7Gwd5uCzDJdR13pjmmYw8D1cfdeUt
   Lt0tWIe55UBkbRxypmxOob0U801hhOtEODMJ1hPhwhTGpfr4fuefu7lQn
   uVHT/qDrU+knsxI4f7TEbFG2dLPr2peXrMbskhwKEHFaWG58E4QFbcFcX
   EdK6ZZbLaD5N50W9nrC8RfuRfkiHtWaugJm8UTN76S32tMMXZsnitY2O1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="406317874"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="406317874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2716758"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jan 2024 14:04:33 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTUJL-0001NK-01;
	Fri, 26 Jan 2024 22:04:31 +0000
Date: Sat, 27 Jan 2024 06:03:58 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Message-ID: <202401270524.3SWUUYR8-lkp@intel.com>
References: <20240123-zonefs_nofs-v1-5-cc0b0308ef25@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-zonefs_nofs-v1-5-cc0b0308ef25@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_140441_199917_047CD616 
X-CRM114-Status: GOOD (  14.50  )
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

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/zonefs-pass-GFP_KERNEL-to-blkdev_zone_mgmt-call/20240123-174911
base:   7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
patch link:    https://lore.kernel.org/r/20240123-zonefs_nofs-v1-5-cc0b0308ef25%40wdc.com
patch subject: [PATCH 5/5] block: remove gfp_flags from blkdev_zone_mgmt
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240127/202401270524.3SWUUYR8-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401270524.3SWUUYR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270524.3SWUUYR8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/md/dm-zoned-metadata.c:8:
   In file included from drivers/md/dm-zoned.h:12:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/md/dm-zoned-metadata.c:8:
   In file included from drivers/md/dm-zoned.h:12:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/md/dm-zoned-metadata.c:8:
   In file included from drivers/md/dm-zoned.h:12:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/md/dm-zoned-metadata.c:1661:34: error: too many arguments to function call, expected 4, have 5
    1659 |                 ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
         |                       ~~~~~~~~~~~~~~~~
    1660 |                                        dmz_start_sect(zmd, zone),
    1661 |                                        zmd->zone_nr_sectors, GFP_KERNEL);
         |                                                              ^~~~~~~~~~
   include/linux/gfp_types.h:327:20: note: expanded from macro 'GFP_KERNEL'
     327 | #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blkdev.h:327:5: note: 'blkdev_zone_mgmt' declared here
     327 | int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
         |     ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     328 |                 sector_t sectors, sector_t nr_sectors);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +1661 drivers/md/dm-zoned-metadata.c

3b1a94c88b798d Damien Le Moal     2017-06-07  1639  
3b1a94c88b798d Damien Le Moal     2017-06-07  1640  /*
3b1a94c88b798d Damien Le Moal     2017-06-07  1641   * Reset a zone write pointer.
3b1a94c88b798d Damien Le Moal     2017-06-07  1642   */
3b1a94c88b798d Damien Le Moal     2017-06-07  1643  static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
3b1a94c88b798d Damien Le Moal     2017-06-07  1644  {
3b1a94c88b798d Damien Le Moal     2017-06-07  1645  	int ret;
3b1a94c88b798d Damien Le Moal     2017-06-07  1646  
3b1a94c88b798d Damien Le Moal     2017-06-07  1647  	/*
3b1a94c88b798d Damien Le Moal     2017-06-07  1648  	 * Ignore offline zones, read only zones,
3b1a94c88b798d Damien Le Moal     2017-06-07  1649  	 * and conventional zones.
3b1a94c88b798d Damien Le Moal     2017-06-07  1650  	 */
3b1a94c88b798d Damien Le Moal     2017-06-07  1651  	if (dmz_is_offline(zone) ||
3b1a94c88b798d Damien Le Moal     2017-06-07  1652  	    dmz_is_readonly(zone) ||
3b1a94c88b798d Damien Le Moal     2017-06-07  1653  	    dmz_is_rnd(zone))
3b1a94c88b798d Damien Le Moal     2017-06-07  1654  		return 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1655  
3b1a94c88b798d Damien Le Moal     2017-06-07  1656  	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
8f22272af7a727 Hannes Reinecke    2020-06-02  1657  		struct dmz_dev *dev = zone->dev;
3b1a94c88b798d Damien Le Moal     2017-06-07  1658  
6c1b1da58f8c7a Ajay Joshi         2019-10-27  1659  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
3b1a94c88b798d Damien Le Moal     2017-06-07  1660  				       dmz_start_sect(zmd, zone),
c4d4977392621f Johannes Thumshirn 2024-01-23 @1661  				       zmd->zone_nr_sectors, GFP_KERNEL);
3b1a94c88b798d Damien Le Moal     2017-06-07  1662  		if (ret) {
3b1a94c88b798d Damien Le Moal     2017-06-07  1663  			dmz_dev_err(dev, "Reset zone %u failed %d",
b71228739851a9 Hannes Reinecke    2020-05-11  1664  				    zone->id, ret);
3b1a94c88b798d Damien Le Moal     2017-06-07  1665  			return ret;
3b1a94c88b798d Damien Le Moal     2017-06-07  1666  		}
3b1a94c88b798d Damien Le Moal     2017-06-07  1667  	}
3b1a94c88b798d Damien Le Moal     2017-06-07  1668  
3b1a94c88b798d Damien Le Moal     2017-06-07  1669  	/* Clear write error bit and rewind write pointer position */
3b1a94c88b798d Damien Le Moal     2017-06-07  1670  	clear_bit(DMZ_SEQ_WRITE_ERR, &zone->flags);
3b1a94c88b798d Damien Le Moal     2017-06-07  1671  	zone->wp_block = 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1672  
3b1a94c88b798d Damien Le Moal     2017-06-07  1673  	return 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1674  }
3b1a94c88b798d Damien Le Moal     2017-06-07  1675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

