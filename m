Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4910FC7EE2E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zVe/Et3+Ncx109cdzIiQm69hGqDhFjgXRKkMIQz87ho=; b=xPHCVOqNa+IujhuLpbwE74PYQP
	ONQucAKelza6iOjnaOnVK6PkmQLkh+tAwk7o4UaxiEI6OeumsV4mIr+XvR3iLwGDjK57rUmYI44aa
	JgO4X8szKQNPhTem6LxfvBSI6ayqjt6J0mN7CCAkiKw//F1/Uzeoz501bHG1n1/yCgiPkunowG4Ud
	TW6VH02YyKSwp9vroU8dqqfTIFTpBQ9MWnA4iQKlwuNA2NmB6uBJKqi4N8DewjsLp4vgg2E9Yco3u
	XBW62cbJGfzyq7iBERw4PaEk5NCqxz8OldF0Y5cj78gW+jVHKE/fih6NzfryMUEvlbXv2eN2VPA2L
	Volspohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sJ9-006TVf-1H;
	Tue, 13 Jun 2023 00:54:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sJ8-006TVD-0V
	for linux-nvme@bombadil.infradead.org;
	Tue, 13 Jun 2023 00:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zVe/Et3+Ncx109cdzIiQm69hGqDhFjgXRKkMIQz87ho=; b=Nw3DOEBkl+XqZjvRwuZn6Ulv6u
	lz3LbVTItUdnxiAqPQPxwZkgJE39TmvBWyYc95I+2tP7mjyNDhHRSbfR9cQvEtHu3oD6rbWzaombh
	/ipPiX2FaOUQXlN8xAhcfjkBEejqnEPaNpv7/kvs5nqLxeQFJsdf1dmwDbhB2BRQLI+XveWi3ZYga
	SueSRBtu0YCNgsKnMod7pzzo0+GAIP5a4SCGO0n13oyH+oBW1mcqeLO40caiKFytXyCUKypTqcuuf
	Dv8oAUrhpxsz+IqzYipZBmAp9sAsoorDcoVGId2GZbA5jNY89Ev/lvqXTPvooeRR6ERBIgZGgEGoL
	P9+hlG1A==;
Received: from mga12.intel.com ([192.55.52.136])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8qbL-0093z3-39
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 23:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686611131; x=1718147131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PxLmthxbn66Y9f085uI2IbozWMtbjqXN5EjsLkeNJg0=;
  b=lTDfh8XJQGwi2weLFsjLNlQQrRqMPVWCaQcS8VdIw8cCbxGANOdqXsIo
   gDopcGwkYHk48TtLmVKl9AE9MUS0vjFWlDcT876+INZM4ufCBjsEM75l8
   XOwwZMIy6uEbj3WICEDiBCR6K7YyDRalBWqTtYP4Q8njce7FobSH2OueK
   hT2o+VEJJvElBb3VVW3TmG0ICCZrS3RnN0fzeCgvFnENac3Jwdn3S7CKl
   XTUcC5sjCjG+0zyXQFe88bDDY/ox0LIYZmDiksJG60fgUPZ7HaQ5Wr00t
   dLpKJy0gQHTTi+SJDY08hVma7KgkJgINl3I/qcyAB6Fw3Riv74YxqrhmT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337816699"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="337816699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 16:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781405349"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="781405349"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2023 16:05:20 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q8qb9-0000p2-28;
	Mon, 12 Jun 2023 23:05:19 +0000
Date: Tue, 13 Jun 2023 07:05:17 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.5 26/26] drivers/nvme/host/core.c:3022:55:
 warning: passing argument 2 of 'bset_mem_set_bit' makes pointer from integer
 without a cast
Message-ID: <202306130610.FXxV2Jqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_000534_218817_6405FF4C 
X-CRM114-Status: GOOD (  17.50  )
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230613/202306130610.FXxV2Jqp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-6.5
        git checkout 9aa77a0506d6990714c9fbb1c03596cd8e1094c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvme/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306130610.FXxV2Jqp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
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
   drivers/nvme/host/core.c:2999:52: warning: passing argument 2 of 'const_test_bit' makes pointer from integer without a cast [-Wint-conversion]
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
   drivers/nvme/host/core.c:2999:52: warning: passing argument 2 of 'generic_test_bit' makes pointer from integer without a cast [-Wint-conversion]
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
   In file included from include/linux/bitops.h:68:
>> drivers/nvme/host/core.c:3022:55: warning: passing argument 2 of 'bset_mem_set_bit' makes pointer from integer without a cast [-Wint-conversion]
    3022 |                 set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
         |                                                   ~~~~^~~~~~~
         |                                                       |
         |                                                       long unsigned int
   arch/m68k/include/asm/bitops.h:64:54: note: in definition of macro 'set_bit'
      64 |                                 bset_mem_set_bit(nr, vaddr) : \
         |                                                      ^~~~~
   arch/m68k/include/asm/bitops.h:41:69: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      41 | static inline void bset_mem_set_bit(int nr, volatile unsigned long *vaddr)
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
>> drivers/nvme/host/core.c:3022:55: warning: passing argument 2 of 'bfset_mem_set_bit' makes pointer from integer without a cast [-Wint-conversion]
    3022 |                 set_bit(NVME_CTRL_SKIP_ID_CNS_CS, ctrl->flags);
         |                                                   ~~~~^~~~~~~
         |                                                       |
         |                                                       long unsigned int
   arch/m68k/include/asm/bitops.h:65:55: note: in definition of macro 'set_bit'
      65 |                                 bfset_mem_set_bit(nr, vaddr))
         |                                                       ^~~~~
   arch/m68k/include/asm/bitops.h:50:70: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      50 | static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
         |                                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~


vim +/bset_mem_set_bit +3022 drivers/nvme/host/core.c

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

