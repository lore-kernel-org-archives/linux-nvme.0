Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v/IAflxGX13KNcswi56W9uGtbdpX9Jd1zoxEU44w3fU=; b=SrFC31V6H21m44ZUN5NpZv94Ae
	bnHxwgERKkyF4Js+tafVl170E9AaHjHO944D/5kCBWiyQwY/soDjP4cvK2BWxuntCZUQpguum3x4F
	ukxvg6Hqx/B0+WzsSwu0GlXh09WMNEgir7Ij0tU8hbu6ui5usgt40cP2zdMIs4Mhp0XAwKFCnz0px
	/zlWAgoPUMxjMFWS36jiaJP9ChjnPRmSh8Jrw0f/Gum36h3jQXjVWhDeg0R3QxKed3wduhD1lQ4nx
	isYHG9U7wTMS32oZ2oLmFOO8v4hDvovb1OmRGgThuA6eFXTpj5Qj4PB0Vo+pSzDoEQUlmWAYixvay
	U9N4hACA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKml5-00BwD6-7D; Thu, 17 Feb 2022 19:48:07 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKml2-00BwBl-EX
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 19:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645127284; x=1676663284;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=qTtkFq2coxen7O/toH2iFhWHUoYOLSfaGvGEa2a3ndo=;
 b=a3iqgy3kbF3tDBLQoxhaEXB4dHpcTY3vsZbk7G+jdsSJT06PayEiKVY2
 yPvQwASRai/38aku0bkGWB/di64dM0MxtaVUbgpHYqOT42OCSGy2Auskz
 C+LptJvYPT8O2Y84QicyW8X48D4LBrDep6qApqM6UeP+bBvgYUmU0gfNK
 cOvO+6uwRiTbgCqGx/nLzC+vrhtJ/Ka3a9JWoJJ75o9IvD4VUGF0oUlWp
 pxt8QOCnnHgMi7z7SvWpNA5dAYt8AhmjVLg3o5WQTz5/sD5EofY1hJeOX
 h+D//cB5nDfUzzQxGSEOwGGdlKhycrzgnx61QcvxXb+jup/NggUqlDxhT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251159177"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="251159177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 11:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="637327784"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 11:48:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKmkz-0000XM-Ar; Thu, 17 Feb 2022 19:48:01 +0000
Date: Fri, 18 Feb 2022 03:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
 linux-nvme@lists.infradead.org
Subject: [linux-nvme:swiotlb-init-cleanup 8/11]
 arch/x86/kernel/pci-dma.c:94:35: error: use of undeclared identifier
 'x86_swiotlb_flags'; did you mean 'x86_power_flags'?
Message-ID: <202202180341.LKRIvHrs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_114804_527871_06D800D6 
X-CRM114-Status: GOOD (  11.24  )
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

tree:   git://git.infradead.org/nvme.git swiotlb-init-cleanup
head:   2cfb7ec6b2292ac81243cacda06a2ca79b06f2c2
commit: 563c044b3b3c098f73df34a500203b45cd6708b0 [8/11] swiotlb: make the swiotlb_init interface more useful
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220218/202202180341.LKRIvHrs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme swiotlb-init-cleanup
        git checkout 563c044b3b3c098f73df34a500203b45cd6708b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/pci-dma.c:94:35: error: use of undeclared identifier 'x86_swiotlb_flags'; did you mean 'x86_power_flags'?
           swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
                                            ^~~~~~~~~~~~~~~~~
                                            x86_power_flags
   arch/x86/include/asm/cpufeature.h:39:27: note: 'x86_power_flags' declared here
   extern const char * const x86_power_flags[32];
                             ^
   1 error generated.


vim +94 arch/x86/kernel/pci-dma.c

    86	
    87	void __init pci_iommu_alloc(void)
    88	{
    89		pci_swiotlb_detect_4gb();
    90		gart_iommu_hole_init();
    91		amd_iommu_detect();
    92		detect_intel_iommu();
    93	
  > 94		swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
    95	}
    96	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

