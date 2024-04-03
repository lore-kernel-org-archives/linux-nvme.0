Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B2C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 04:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkqwDaW8jIKNyLRe4mqpRVMFkUl8u1JAtqofF84ESvg=; b=FLZosmUGoIFErZn87LnnVbLXTS
	Y84EpjjavRpAqZo8SfaLHOF2d4FjrvhzNo0YZs8i1oO2+Y1GClUE/6V12rMDUKjXrMxadS4DZGYPO
	BJ6+CbQq2qHeKiocavCVlaevsftWabC1luBnmPV94u0k0g8SkwIPlRzte3Bu7Im/XVMZKI0cqQm3j
	7IAlJ9jmye/m1PhRQ06GmPUExnAKtKlFskqOIAcn17dBa7iaZ+iig2plMWMg9iLJhfTM1DC16+jc6
	++c3aW+o/2NVgt3fdlQlqx1XGWJ6j1hJDtiPlSXK4yhBu7UCsk8BOB1ZGio06LMCQmLkVIGEHCr4j
	Giz3yEgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrsAZ-0000000Dvym-04Tb;
	Wed, 03 Apr 2024 04:24:15 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrsAV-0000000DvyF-1WQA
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 04:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712118251; x=1743654251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kvZKyFnzaSdzkHLInBECq2A4x1BE0FyawGZWZBsWnfY=;
  b=Dk8HI2HtezWMgVHBwdYodVprWXwzaSEq/9rhcdb+DLH6v/IOAS5+Lkdf
   D/hQNrgKweFQMrKBtZYyHa9gnR6scYfbkClHosDnqrC3npgkaERf0OhyA
   l5PpdxFOgQaYvt0Ftd1bW+rXXk0w7RKSeeBsM4pFB+OETTFzfYaH+c84g
   bVGRQqzDU0RGEqJcJ/S8gSHbIiLLsTwk/Lo5nw71tp7Cu6SbcYjOb/CZX
   pVCJw12xskyQNTZBXeN7l0UDSSQ0yscRe4hjXzOVEq9Y/+RLCR34lS81a
   bvRwCw3Xog409H+j1YLgEL/6vv8fliYtpUIr7c9qYReBbhcmrHYTKWJBZ
   w==;
X-CSE-ConnectionGUID: NxstJNnzS2yeHez4Voqqow==
X-CSE-MsgGUID: JUvnsFeQQaWX8d0fQc0v4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11104931"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11104931"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 21:24:09 -0700
X-CSE-ConnectionGUID: vr7UOS3ATjqARwTETHCDhA==
X-CSE-MsgGUID: bcwQ72D4S1KwGBlIGF571A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22779970"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Apr 2024 21:24:06 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrsAO-0001qZ-07;
	Wed, 03 Apr 2024 04:24:04 +0000
Date: Wed, 3 Apr 2024 12:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 07/28] block: Introduce zone write plugging
Message-ID: <202404031242.Oy7q9BWh-lkp@intel.com>
References: <20240402123907.512027-8-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402123907.512027-8-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_212411_442946_215CB257 
X-CRM114-Status: GOOD (  14.21  )
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

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc2 next-20240402]
[cannot apply to jejb-scsi/for-next device-mapper-dm/for-next mkp-scsi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/block-Restore-sector-of-flush-requests/20240402-204657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240402123907.512027-8-dlemoal%40kernel.org
patch subject: [PATCH v4 07/28] block: Introduce zone write plugging
config: i386-buildonly-randconfig-003-20240403 (https://download.01.org/0day-ci/archive/20240403/202404031242.Oy7q9BWh-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404031242.Oy7q9BWh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404031242.Oy7q9BWh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-zoned.c:1435:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1435 |                 return ret;
         |                        ^~~
   block/blk-zoned.c:1415:9: note: initialize the variable 'ret' to silence this warning
    1415 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +1435 block/blk-zoned.c

  1410	
  1411	static int disk_alloc_zone_resources(struct gendisk *disk,
  1412					     unsigned int pool_size)
  1413	{
  1414		unsigned int i;
  1415		int ret;
  1416	
  1417		disk->zone_wplugs_hash_bits =
  1418			min(ilog2(pool_size) + 1, BLK_ZONE_WPLUG_MAX_HASH_BITS);
  1419	
  1420		disk->zone_wplugs_hash =
  1421			kcalloc(disk_zone_wplugs_hash_size(disk),
  1422				sizeof(struct hlist_head), GFP_KERNEL);
  1423		if (!disk->zone_wplugs_hash)
  1424			return -ENOMEM;
  1425	
  1426		for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++)
  1427			INIT_HLIST_HEAD(&disk->zone_wplugs_hash[i]);
  1428	
  1429		disk->zone_wplugs_pool = mempool_create_kmalloc_pool(pool_size,
  1430							sizeof(struct blk_zone_wplug));
  1431		if (!disk->zone_wplugs_pool) {
  1432			kfree(disk->zone_wplugs_hash);
  1433			disk->zone_wplugs_hash = NULL;
  1434			disk->zone_wplugs_hash_bits = 0;
> 1435			return ret;
  1436		}
  1437	
  1438		return 0;
  1439	}
  1440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

