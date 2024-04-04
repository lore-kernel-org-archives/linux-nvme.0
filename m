Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6789DCD1288
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cywjqOzHURDShVVDi4Uu/65afZkKZZzI9pljE+FDRIU=; b=o3Y6OEzauPDP2ESrONFCui6Pgy
	oQ/3XilbaWiqZE+dUUgAR2pi3M3dF3xStZDGao90Mp3ESh9oNiEsJG2ojiYdjYXn8hUGDjxo4dAB6
	zPgJXjJch+1wIgLuPkMp7B4d88Ig2Io0DHFkkpvuiFtOqAkh4UlnUJRdHqtqMhJNrkypf6T0pYqbm
	VWh2+iMxy8Av1fpLucn8TVGn/fUf4LsTddi/kSM2DMbt8yPnSUdode2RGJ2G1+K099qoKWoW69gba
	lrdwKg6jvCEuoRiVdqPejy01bQ4LmpY7jLIxwCYHWzznUzGz40XSIhTTiGwXpM//rzodGp/K9/mYf
	eTSyjXOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsDHG-000000012hx-2e2y;
	Thu, 04 Apr 2024 02:56:34 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsDHD-000000012hB-00XH
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 02:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712199391; x=1743735391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZ3B+Y3kGLvbRC1vtgiD3hn88kEkWmHYb5d0DaFyzRk=;
  b=VxhSgWPpsojXYoZ2o+kltXlD/qWbVxD3i/gD7tZBf6eJhgLV28m8LkH7
   TBlN6LUa5wjVoi6o7mxz1jeGa7E4Tidtdwisl55BbdhZ4j1MMaSBAYZ3E
   kmCaQVGx4krH+MZAvRvqu9jtynGGGwkhDohI9fswU1+7taHxHb+7b0OaL
   OOQJbRNCRJZzZhZWyZ/oRgpDR6DlSt0dlbDV4qC2ukSbxoVmUzbLECzRE
   wJt+Mbw2knzmbzI5WfTSiF0NkWJ9oq25C3mkZK4lwr+x3YntuZsXN0PrI
   QxJJ9vbxYD7QV16mTLk8fjH1v2gT1sXi2IudXjUqvJee8P4W99x9sv+hg
   w==;
X-CSE-ConnectionGUID: RG30dZ7jRdqiiRbiDU9ILA==
X-CSE-MsgGUID: 6pciMPlhQXuHAkdd8gWScg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7321324"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7321324"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:56:26 -0700
X-CSE-ConnectionGUID: rlCLA8E1ReqDLCu14DKmBQ==
X-CSE-MsgGUID: fQJ5gaW4QcWFE2DzzaqJxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="49587626"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Apr 2024 19:56:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsDH2-0000Wk-2L;
	Thu, 04 Apr 2024 02:56:20 +0000
Date: Thu, 4 Apr 2024 10:55:25 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 1/2] block: track per-node I/O latency
Message-ID: <202404041045.bLSpHDFH-lkp@intel.com>
References: <20240403141756.88233-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403141756.88233-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_195631_158800_4C05A638 
X-CRM114-Status: GOOD (  15.58  )
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
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240404/202404041045.bLSpHDFH-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404041045.bLSpHDFH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404041045.bLSpHDFH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/bdev.c:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
>> include/linux/blk-mq.h:1242:5: warning: no previous prototype for function 'blk_nlat_latency' [-Wmissing-prototypes]
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         |     ^
   include/linux/blk-mq.h:1242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1242 | u64 blk_nlat_latency(struct gendisk *disk, int node) { return 0; }
         | ^
         | static 
   include/linux/blk-mq.h:1243:15: error: unknown type name 'in'
    1243 | static inline in blk_nlat_init(struct gendisk *disk) { return -ENOTSUPP; }
         |               ^
   14 warnings and 1 error generated.


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

