Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D0C88CB2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 00:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Gl3Pj+FRG3MpR+8SsHBZqj8LYoAg7JSRqllZA983TTQ=; b=k1/GeGfWPoZ+iy/2i1GZG7pomy
	udM7E9pRCY8OMAJW6TqEQYICdrxnCm5JqZaQkM/3mRKLBnZFgxISgYyDadQ3U0uJYR+lxUuLYp9n5
	9qoeRZyzsPqXEmA4JNHH/AZVmU+QHo6eXDzw7kl8f+1uHjMZyBGMguPwz4T821aLE13a0isw8p9zN
	+D4TEe0ZX/y6mXFHZ9GbEbgTL5K5ewBbbk42w66bk3c1x60QYzI1isROEjfgWy8+Ijwn5X7lIYuti
	DPvodcn7dejk7rqp66TNYFKEN109eEnvtgkcOvW5fp2jciC1st4FWr0V4KtBN3LJuy6alacNU/L9A
	YZn8GVfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8rj4-006KtO-05;
	Tue, 13 Jun 2023 00:17:34 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8rj0-006KrP-12
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 00:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615450; x=1718151450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ftzyfGd7hEwXFU0TSLWK7eslrvKB6pKAoI9jV9Jv8F8=;
  b=dJpXe2ZLCPSWfoclLBByfzahNyzqKY6GCFujZQijp2SpqxD610M6RRdg
   rKhjtidX6FQDUJlqybiyZUL4apR6YDAPeuHjdcSSY/KibgiTHjavjiixL
   fxu6LlKIEel6XiUc+aB7OYi81qf3ufNG/vvLx/uM7yws/zT0eL1A5X/kt
   YNoISzyFw09yLZbwkaxAdIvl80z2Onb8WJ5YTkCIIZdgVMiTcCg7bt3sn
   3ciDAVeY3HBdgMi+pA7W/PdgTw3Xam7m2oO+DDItrEEaZ09VPV+QXXZOZ
   pUiua2ZMFujXA1Eu+ZzldeBSErZhDOe2hNtXEf207u0qXNXF3NxQqWFHG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="355690212"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="355690212"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688823020"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688823020"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 17:17:23 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q8ris-0000rU-1d;
	Tue, 13 Jun 2023 00:17:22 +0000
Date: Tue, 13 Jun 2023 08:17:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.5 26/26] drivers/nvme/host/core.c:2999:41: error:
 incompatible integer to pointer conversion passing 'unsigned long' to
 parameter of type 'const volatile unsigned long *'; take the address with &
Message-ID: <202306130839.SgF584xI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_171730_369529_E467DED9 
X-CRM114-Status: GOOD (  15.62  )
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
config: i386-randconfig-i002-20230612 (https://download.01.org/0day-ci/archive/20230613/202306130839.SgF584xI-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-6.5
        git checkout 9aa77a0506d6990714c9fbb1c03596cd8e1094c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306130839.SgF584xI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:2999:41: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const volatile unsigned long *'; take the address with & [-Wint-conversion]
               test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
                                                  ^~~~~~~~~~~
                                                  &
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
   #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
                                                                ^~~~
   include/linux/bitops.h:53:17: note: expanded from macro 'bitop'
            const##op(nr, addr) : op(nr, addr))
                          ^~~~
   include/asm-generic/bitops/generic-non-atomic.h:166:64: note: passing argument to parameter 'addr' here
   const_test_bit(unsigned long nr, const volatile unsigned long *addr)
                                                                  ^
>> drivers/nvme/host/core.c:2999:41: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const volatile unsigned long *'; take the address with & [-Wint-conversion]
               test_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags))
                                                  ^~~~~~~~~~~
                                                  &
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
   #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
                                                                ^~~~
   include/linux/bitops.h:53:32: note: expanded from macro 'bitop'
            const##op(nr, addr) : op(nr, addr))
                                         ^~~~
   include/asm-generic/bitops/instrumented-non-atomic.h:139:59: note: passing argument to parameter 'addr' here
   _test_bit(unsigned long nr, const volatile unsigned long *addr)
                                                             ^
>> drivers/nvme/host/core.c:3022:37: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'volatile unsigned long *'; take the address with & [-Wint-conversion]
                   set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
                                                     ^~~~~~~~~~~
                                                     &
   include/asm-generic/bitops/instrumented-atomic.h:26:70: note: passing argument to parameter 'addr' here
   static __always_inline void set_bit(long nr, volatile unsigned long *addr)
                                                                        ^
   3 errors generated.


vim +2999 drivers/nvme/host/core.c

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

