Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F47BE7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WE7I1RdCaiFsGWQP/POaH7wjDvuk5+mZK0Pk8r0WDGg=; b=ia0RN9EUFtXxuymXRaFWzMRPGA
	UHNk+FyIJILaX750W4NCedSQaIr2/8vZ+hM+7B9+uqZBgmZMdl9rD3PqYxtbC5IxDzmo/i/N5j1y5
	cxkJLICjqgsjq6tPDWgJ9JR6vqIJa9plzAMgZr0cYkmZ/cGDIuUFqy20G5eDNsWerrRTXeazT1Xfl
	h/aayls6LtseGrmXvWJUcgHAYOgC2a0A8gWKbTdKqoJrHpN7td/v91Ty4x7mBI4ec/X3ib4+A0I7s
	QA2naa8Ol33Z9QszQC+l82DLis9lsmGHAhj6PpEwt7NZPiV/A22FB7xtRhKZG/+Ytldy6Nz7Ez4Dk
	4UKEMtSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNIHu-0000000BNF9-0Wht;
	Mon, 16 Dec 2024 21:05:58 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNIHm-0000000BNDi-2hz3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 21:05:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734383150; x=1765919150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ruA/fM3L78iMPD6pDUO2Hh+Hw86GR3xyBSYIE59vrc=;
  b=AxubyFBn7QAx2c53Q7SaNIOAZ8EELJ92IR7O0AfNqMH/oiH35QYZhIxz
   vZgtpWnKNeYiiyfmumYAQ/SDABdliSxE6lMHl6l121xGZVIxxieZAISK8
   flUsOnFDMyq0XjCbcwAghdQUuVMTqWkY3dyNJul/WnyzdYD1KXio8rw49
   bxJOfY/t41GPR3QcHodUmPn6ri0dn6l7WPIOXr6qvnw9nFnqsmXAf5ajp
   dn5IcoEqSzQ4H6o2mZdAddP+BRqlPWczJRKGBiGBJ49Uu10Sd/FPfK2u/
   YMRVLOHlwatKw7i8RrEDgOqHyDH5OwId99CbgkfPxzj9K7K8sd47Saf6u
   A==;
X-CSE-ConnectionGUID: AtwIdNg8SHil66ZZFOKTGw==
X-CSE-MsgGUID: Ec3e6g8UTZKLN7gYxZ88aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="46198983"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="46198983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 13:05:48 -0800
X-CSE-ConnectionGUID: n+dVGZE8SHSBjPQs7IPDvA==
X-CSE-MsgGUID: DhWqMBeJROCKcJmBl25rQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="102346360"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Dec 2024 13:05:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNIHe-000ETS-2L;
	Mon, 16 Dec 2024 21:05:42 +0000
Date: Tue, 17 Dec 2024 05:05:20 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412170432.ZuybGalF-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_130551_334383_6422D30B 
X-CRM114-Status: GOOD (  14.69  )
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

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.13-rc3 next-20241216]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-Add-vendor_id-and-subsys_vendor_id-subsystem-attributes/20241210-174321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241210093408.105867-17-dlemoal%40kernel.org
patch subject: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
config: i386-randconfig-003-20241217 (https://download.01.org/0day-ci/archive/20241217/202412170432.ZuybGalF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412170432.ZuybGalF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412170432.ZuybGalF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_iod_name':
   drivers/nvme/target/pci-ep.c:658:16: error: implicit declaration of function 'nvme_opcode_str'; did you mean 'nvme_opcode_name'? [-Werror=implicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~
         |                nvme_opcode_name
>> drivers/nvme/target/pci-ep.c:658:16: warning: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:7,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from arch/x86/include/asm/div64.h:8,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:12,
                    from drivers/nvme/target/pci-ep.c:10:
   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_enable_ctrl':
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1842:26: note: in expansion of macro 'GENMASK'
    1842 |         pci_addr = acq & GENMASK(63, 12);
         |                          ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1852:26: note: in expansion of macro 'GENMASK'
    1852 |         pci_addr = asq & GENMASK(63, 12);
         |                          ^~~~~~~
   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_init_bar':
>> include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1949:23: note: in expansion of macro 'GENMASK'
    1949 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/nvme/target/pci-ep.c:1949:23: note: in expansion of macro 'GENMASK'
    1949 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~
   cc1: some warnings being treated as errors


vim +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

