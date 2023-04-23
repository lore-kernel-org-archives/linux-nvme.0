Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1A9C77B60
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l18qsRhqfdsc7LWMuyLOAnbojzMFodIA/Ey3jgXmOEM=; b=2GVYAa33WnNE9lgyuEtiU22/TG
	zYl41DvMEuxToAt9RLa2s0w9fxpLeBvbmmuezkfvQN+/6BLaehvIcMXgFlB5QlmmR0L8Vs52U3KCD
	zvNZADx2HMyzffIyGMy7jCzZBArPfeAjBmtbLAJOPZUvjCy4OVD+NkcdTI0xJblxR3vTk+a+ZFxpB
	x6IgC1OPY9YUPnTv7Ya2Zt4H/UDlV07Yjk/oC6QnuhStLCrhvCXZLF9RW7qA5oazOrX99i4NOTZpS
	0Kpzd7MOD37MokTuf1e1qwmeMilx4/LCkFoXxztm1pbn0x/vOdt45d4e2FBLRXoSwyrXXwwaCcXdy
	52lWNB+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqcgT-00EVZs-09;
	Sun, 23 Apr 2023 16:35:29 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqcgP-00EVYi-24
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 16:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682267725; x=1713803725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hzO7VB7ThmmtvuOzr/ov1Ionhi5MfpQ3nTgowpMQSEU=;
  b=gq5iyMy2gdrwVTNdhaf/ya0DQcx3J2P+7jMFtL0+a220taD9BOYEvMY6
   U4ulSSu0uzdrrRxuAu9PO1SKix9AbYOyTStqdzSc3OmAfavZePRw3T/4e
   ShBRBEEf+RthPKG/UwbrJ5+I2M9HXNVovViIqK8tSxfchZDi5CIXRRpNp
   iQPfxSR2NUSaumtzvC6TLa3iZiyo+1jI/W3Y6oUsfav2IMKgx/kB8c0cx
   7IRW1AhNOKjYj7MTAkoRYHQ6/0KUPpCx+v3q5Q7QiPCKkUgRfxQneUney
   TLG6UGbHBLd0fvtnUQPqQPtQCu49OKtUwivWU+QW+cQc4D6STlIpheNkc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="330505634"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="330505634"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 09:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="939051419"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="939051419"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2023 09:35:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pqcgC-000hyQ-0N;
	Sun, 23 Apr 2023 16:35:12 +0000
Date: Mon, 24 Apr 2023 00:34:28 +0800
From: kernel test robot <lkp@intel.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
	israelr@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free
 func
Message-ID: <202304240022.AvNPfDhp-lkp@intel.com>
References: <20230423141330.40437-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141330.40437-2-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_093525_808522_D61A5C5B 
X-CRM114-Status: GOOD (  13.83  )
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

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on hch-configfs/for-next linus/master v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230423141330.40437-2-mgurtovoy%40nvidia.com
patch subject: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free func
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20230424/202304240022.AvNPfDhp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1459ddb310ef47b008de7669cc2c57e02edf4edb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
        git checkout 1459ddb310ef47b008de7669cc2c57e02edf4edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304240022.AvNPfDhp-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:17,
                    from init/main.c:86:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   init/main.c:779:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     779 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:791:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     791 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:793:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     793 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from include/linux/blkdev.h:17,
                    from init/do_mounts.h:3,
                    from init/do_mounts.c:28:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/blkdev.h:17,
                    from kernel/exit.c:52:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   kernel/exit.c:1915:32: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1915 | __weak __function_aligned void abort(void)
         |                                ^~~~~
--
   In file included from include/linux/blkdev.h:17,
                    from block/bdev.c:14:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from block/bdev.c:31:
>> block/blk.h:248:20: error: redefinition of 'bio_integrity_free'
     248 | static inline void bio_integrity_free(struct bio *bio)
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/bio.h:768:6: note: previous definition of 'bio_integrity_free' with type 'void(struct bio *)'
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/blkdev.h:17,
                    from lib/vsprintf.c:46:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/blkdev.h:17,
                    from block/partitions/check.h:3,
                    from block/partitions/core.c:13:
>> include/linux/bio.h:768:6: warning: no previous prototype for 'bio_integrity_free' [-Wmissing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from block/partitions/check.h:4:
>> block/partitions/../blk.h:248:20: error: redefinition of 'bio_integrity_free'
     248 | static inline void bio_integrity_free(struct bio *bio)
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/bio.h:768:6: note: previous definition of 'bio_integrity_free' with type 'void(struct bio *)'
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~


vim +/bio_integrity_free +248 block/blk.h

43b729bfe9cf30 Christoph Hellwig 2018-09-24  240  
5a48fc147d7f27 Dan Williams      2015-10-21  241  static inline void blk_flush_integrity(void)
5a48fc147d7f27 Dan Williams      2015-10-21  242  {
5a48fc147d7f27 Dan Williams      2015-10-21  243  }
7c20f11680a441 Christoph Hellwig 2017-07-03  244  static inline bool bio_integrity_endio(struct bio *bio)
7c20f11680a441 Christoph Hellwig 2017-07-03  245  {
7c20f11680a441 Christoph Hellwig 2017-07-03  246  	return true;
7c20f11680a441 Christoph Hellwig 2017-07-03  247  }
ece841abbed2da Justin Tee        2019-12-05 @248  static inline void bio_integrity_free(struct bio *bio)
ece841abbed2da Justin Tee        2019-12-05  249  {
ece841abbed2da Justin Tee        2019-12-05  250  }
614310c9c8ca15 Luis Chamberlain  2021-08-18  251  static inline int blk_integrity_add(struct gendisk *disk)
581e26004a09c5 Christoph Hellwig 2020-03-25  252  {
614310c9c8ca15 Luis Chamberlain  2021-08-18  253  	return 0;
581e26004a09c5 Christoph Hellwig 2020-03-25  254  }
581e26004a09c5 Christoph Hellwig 2020-03-25  255  static inline void blk_integrity_del(struct gendisk *disk)
581e26004a09c5 Christoph Hellwig 2020-03-25  256  {
581e26004a09c5 Christoph Hellwig 2020-03-25  257  }
43b729bfe9cf30 Christoph Hellwig 2018-09-24  258  #endif /* CONFIG_BLK_DEV_INTEGRITY */
8324aa91d1e11a Jens Axboe        2008-01-29  259  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

