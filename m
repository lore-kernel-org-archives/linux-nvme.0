Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2BBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YKkJa1KSsWGmBSVojkO9TLyKKJwydQu2Wi2dGwTk+mM=; b=wXEVX85f/ClUzwCLDX3r1QzmdP
	Q3Sb+5APuuv69I/yJfnLi5jyJzyGFzaJVY5ydw/b+0/DVWCnRFeJr9eqQ+y6YyOu0Pp+j6su1I2M+
	zCWN6pu6IPlNV6twZZLT5mu46ey7+2KR4Bs/7M97SXoDqL4euw49dR85BLzHpGhZSQ82Vs0eqP/+a
	T94WhSr5Xt+B6Wi3ilAQEOHuFYiF3PjrcvR48V7KG60xCroFBeiV0iQtzQwKu7MDrKPU83gvrD2R0
	hCIJkFvlLaCVIcrpoUg1l5w882EHU5G97t/4pi8Pes5RNuFLokvggbySg61C7kH3E4KtYFx13YLah
	AVcSFwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKmlT-00BwKv-No; Thu, 17 Feb 2022 19:48:31 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKml6-00BwDE-M2
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 19:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645127288; x=1676663288;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=fD1rjuZDeXx2/tl5EfB8PfVB9JlEOwO/9Oinm6H58Zk=;
 b=m6nyhQ1U7bWE2H1GAbBUEwGfAvJzlcdbOAIweoqx+bWbtyyC8vdtJGi4
 SDNNfHdNxuLWJs0I4urrtj44/H1kz4hzCI1dy5XvF0r2SHdJZb0csAVnT
 xxXSpUlSGY5d8zWBRjMmmfOuptbO54olQNxLBFyR38En5hIrerQZ04RX3
 iIaU1DayjjT4B9zO0NVvCI6BkcGajlA8vWMyHc6zSNplcwx0o7KV6hxgX
 JeIIm1DlLO6SvnMedlKQ0W3rGssK03Z5Tbfpa8WA240eV9QbsEkl+yc8Q
 +4UcVUisfXrIIkkULugCg7h0ghT+n7zeQqDbW6QWya+cYuoQ0Nkq9ujeu g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238363688"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="238363688"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 11:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="545818691"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 11:48:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKmkz-0000Xc-Ee; Thu, 17 Feb 2022 19:48:01 +0000
Date: Fri, 18 Feb 2022 03:47:23 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org
Subject: [linux-nvme:swiotlb-init-cleanup 8/11]
 arch/x86/kernel/pci-dma.c:94:35: error: 'x86_swiotlb_flags' undeclared; did
 you mean 'x86_swiotlb_enable'?
Message-ID: <202202180251.LDy8F41C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_114808_810445_B2C3D29F 
X-CRM114-Status: GOOD (  15.64  )
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
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220218/202202180251.LDy8F41C-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme swiotlb-init-cleanup
        git checkout 563c044b3b3c098f73df34a500203b45cd6708b0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/pci-dma.c: In function 'pci_iommu_alloc':
>> arch/x86/kernel/pci-dma.c:94:35: error: 'x86_swiotlb_flags' undeclared (first use in this function); did you mean 'x86_swiotlb_enable'?
      94 |  swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
         |                                   ^~~~~~~~~~~~~~~~~
         |                                   x86_swiotlb_enable
   arch/x86/kernel/pci-dma.c:94:35: note: each undeclared identifier is reported only once for each function it appears in


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

