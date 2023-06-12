Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327DC7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 23:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2aGLEa4TwRRQUVKVNqXL+x+uHcFLmq2yPFyC/mgL37s=; b=ufRh/EC5oLn7uxPjJGzBALrCaY
	6oJmV22wN/3nLrwR2oCkqxu0P8Wvoww35KR3DtYibRFYHk9E8iZ8zUll3jx0hVB42tAeZfASYDfqw
	L4XxLYulcKvS+hs50+NMQmngNT4m2TimKUZmnN3JjAaRDk7r5Kbfz3/wp3/aYfTliEtRbNQjfGwzU
	LalHF6MShKqSIEaKZuGHAjhZdW4SjdiQU7lMx2TXeRw4c/7f90UAS0VXRqAHPBQQnbEKCOXV0dAlu
	dv7sj8bfkSA3qyQ8Sy1WFzvQMJmhDavFCo+Si9ng/zH1oIO5REDoBbUO/XReUHspUGErvauGvvoXF
	/ELfdKzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8qlx-0063fQ-0K;
	Mon, 12 Jun 2023 23:16:29 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8qlt-0063dZ-0D
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 23:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686611785; x=1718147785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DSwI0e3m6wOlAf8gQGQ1v8T320lYTOa7XwDp9Fkdd60=;
  b=L6h1IpFGRazZcLqpxiTtQJy8bkiSwTyi08fjedOs/lxFlCoFAnsQDefv
   0fUCpY2in2bqly3jIGsDVzOomtdBL57gh0tGWKsQ3GFFqD74dSFAVM1n2
   LVe9S7TOKpVcQkNMjZ9U6DHVrC1HLszEp4M/lDVxRZvdVs2+1hKnImBNq
   X92VdnpqBNI0LJFnKKnBey3RNBHYrqRiUIHDGghlh1FuwzGkBhRkAY4/M
   R2Nn3/8aPE5Gws4p+9M159yhjqnQ8Fu9U/cncnvq2/AxcsgM7cMkRuM4K
   HmJD2xu4h4iPqJjAbLIsV6IGbF308tYLisq57Nu9K2ObA0XMzfq9nzLRt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358181768"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358181768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 16:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714568301"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="714568301"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2023 16:16:20 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q8qlo-0000pc-05;
	Mon, 12 Jun 2023 23:16:20 +0000
Date: Tue, 13 Jun 2023 07:15:51 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.5 26/26] drivers/nvme/host/core.c:2999:52:
 warning: passing argument 2 of 'const_test_bit' makes pointer from integer
 without a cast
Message-ID: <202306130727.dlc4hcMB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_161625_147958_50969530 
X-CRM114-Status: GOOD (  16.60  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.5
head:   9aa77a0506d6990714c9fbb1c03596cd8e1094c7
commit: 9aa77a0506d6990714c9fbb1c03596cd8e1094c7 [26/26] nvme: skip optional id ctrl csi if it failed
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230613/202306130727.dlc4hcMB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-6.5
        git checkout 9aa77a0506d6990714c9fbb1c03596cd8e1094c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/nvme/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306130727.dlc4hcMB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/nvme/host/core.c:7:
   drivers/nvme/host/core.c: In function 'nvme_init_non_mdts_limits':
>> drivers/nvme/host/core.c:2999:52: warning: passing argument 2 of 'const_test_bit' makes pointer from integer without a cast [-Wint-conversion]
    2999 |             test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
         |                                                ~~~~^~~~~~~
         |                                                    |
         |                                                    long unsigned int
   include/linux/bitops.h:53:24: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   drivers/nvme/host/core.c:2999:13: note: in expansion of macro 'test_bit'
    2999 |             test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
         |             ^~~~~~~~
   In file included from include/linux/bitops.h:34:
   include/asm-generic/bitops/generic-non-atomic.h:166:64: note: expected 'const volatile long unsigned int *' but argument is of type 'long unsigned int'
     166 | const_test_bit(unsigned long nr, const volatile unsigned long *addr)
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/host/core.c:2999:52: warning: passing argument 2 of 'generic_test_bit' makes pointer from integer without a cast [-Wint-conversion]
    2999 |             test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
         |                                                ~~~~^~~~~~~
         |                                                    |
         |                                                    long unsigned int
   include/linux/bitops.h:53:39: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   drivers/nvme/host/core.c:2999:13: note: in expansion of macro 'test_bit'
    2999 |             test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
         |             ^~~~~~~~
   include/asm-generic/bitops/generic-non-atomic.h:121:66: note: expected 'const volatile long unsigned int *' but argument is of type 'long unsigned int'
     121 | generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/host/core.c:3022:55: warning: passing argument 2 of 'set_bit' makes pointer from integer without a cast [-Wint-conversion]
    3022 |                 set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
         |                                                   ~~~~^~~~~~~
         |                                                       |
         |                                                       long unsigned int
   In file included from include/linux/bitops.h:68:
   arch/alpha/include/asm/bitops.h:29:43: note: expected 'volatile void *' but argument is of type 'long unsigned int'
      29 | set_bit(unsigned long nr, volatile void * addr)
         |                           ~~~~~~~~~~~~~~~~^~~~


vim +/const_test_bit +2999 drivers/nvme/host/core.c

  2970	
  2971	static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
  2972	{
  2973		struct nvme_command c = { };
  2974		struct nvme_id_ctrl_nvm *id;
  2975		int ret;
  2976	
  2977		if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
  2978			ctrl->max_discard_sectors = UINT_MAX;
  2979			ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
  2980		} else {
  2981			ctrl->max_discard_sectors = 0;
  2982			ctrl->max_discard_segments = 0;
  2983		}
  2984	
  2985		/*
  2986		 * Even though NVMe spec explicitly states that MDTS is not applicable
  2987		 * to the write-zeroes, we are cautious and limit the size to the
  2988		 * controllers max_hw_sectors value, which is based on the MDTS field
  2989		 * and possibly other limiting factors.
  2990		 */
  2991		if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
  2992		    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
  2993			ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
  2994		else
  2995			ctrl->max_zeroes_sectors = 0;
  2996	
  2997		if (ctrl->subsys->subtype != NVME_NQN_NVME ||
  2998		    nvme_ctrl_limited_cns(ctrl) ||
> 2999		    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
  3000			return 0;
  3001	
  3002		id = kzalloc(sizeof(*id), GFP_KERNEL);
  3003		if (!id)
  3004			return -ENOMEM;
  3005	
  3006		c.identify.opcode = nvme_admin_identify;
  3007		c.identify.cns = NVME_ID_CNS_CS_CTRL;
  3008		c.identify.csi = NVME_CSI_NVM;
  3009	
  3010		ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
  3011		if (ret)
  3012			goto free_data;
  3013	
  3014		if (id->dmrl)
  3015			ctrl->max_discard_segments = id->dmrl;
  3016		ctrl->dmrsl = le32_to_cpu(id->dmrsl);
  3017		if (id->wzsl)
  3018			ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
  3019	
  3020	free_data:
  3021		if (ret > 0)
> 3022			set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
  3023		kfree(id);
  3024		return ret;
  3025	}
  3026	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

