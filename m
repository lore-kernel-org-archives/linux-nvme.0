Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF775C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Feb 2022 02:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rVp+h7vKkeRU0UijeIFFyNAU9q1TiEpvN66G/na+KdM=; b=hFmvMDthzeFGLfknfyhdykOC1o
	gupM8D1Pzoa+CSl1WVXMn1+qAQBksHmcGy7WW8ytZkmKTOdHeTuiAejmZPsRptM1QJCcyy+CoXcvY
	wiaD9FYU6HOaAw7hCkx+mv3NvTl41T1c2smFj9VROj3+eb0NYfgYHJuZMS4uhGpb6bcUVZn2Zv7ZJ
	Z84E14Xdb+Nl4mwk0AUyijgblPHgTRVH9MKd6m6dCrDCYkYeJWvDO/h+hsI3ARVkNNuuSfZAu4Dar
	BxgVCUKQafNkVIwCu9MYouyf11LWo6fokbset3IB/pgcGEKHf/AHyNXQGyxzAn7oK3imhcKi5qEja
	8h1HB4Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKtOX-00CkF8-CP; Fri, 18 Feb 2022 02:53:17 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKtOT-00CkES-9L
 for linux-nvme@lists.infradead.org; Fri, 18 Feb 2022 02:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645152793; x=1676688793;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=eAAFMxxXsfmYiN/8oRnF83WLiLsXhVRaJa7jOz73WWo=;
 b=kLTP22aVwWmmq6CC7uG31seA/Wg0TARqFVMYvA5Gia8zy8ow2P7peC2i
 d5e0Q3KIEAk03FefN2ccORNnd+ssRt/WjJJuiigQj/VAPOXStTR8SnMYl
 7E7B+uumwJW33Ag00KKbrZAs9j7mjWpvfbd8ke/QDdWOEwyF9WBeOr+oy
 H02l5ILKiO/7L8Rz3gVRqOLbEmPAc4g+alzJc+fyekmJYpCCT/xQycPgu
 EPJpFzFhwt6rKIJ4o0PFFtnrd7ogflVBEDbLB0DDJdybD6YQH1Yur45M0
 AI3ICUvPIE+70nAh9oCr9zCTVSt4Edn0cx6hwDXPICSQDy0Zn42U2Srgs Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="314301570"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="314301570"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 18:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="777830668"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2022 18:53:10 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKtOP-0000rg-Lv; Fri, 18 Feb 2022 02:53:09 +0000
Date: Fri, 18 Feb 2022 10:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:swiotlb-init-cleanup] BUILD REGRESSION
 2cfb7ec6b2292ac81243cacda06a2ca79b06f2c2
Message-ID: <620f0a02.WHXqQPwcrLGUCQXj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_185313_413161_C3EA9FAA 
X-CRM114-Status: UNSURE (   6.86  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git swiotlb-init-cleanup
branch HEAD: 2cfb7ec6b2292ac81243cacda06a2ca79b06f2c2  x86: remove cruft from <asm/dma-mapping.h>

Error/Warning reports:

https://lore.kernel.org/linux-nvme/202202180251.LDy8F41C-lkp@intel.com
https://lore.kernel.org/linux-nvme/202202180341.LKRIvHrs-lkp@intel.com

Error/Warning in current branch:

arch/x86/kernel/pci-dma.c:92:41: error: 'x86_swiotlb_flags' undeclared (first use in this function); did you mean 'x86_swiotlb_enable'?
arch/x86/kernel/pci-dma.c:92:41: error: use of undeclared identifier 'x86_swiotlb_flags'; did you mean 'x86_power_flags'?
arch/x86/kernel/pci-dma.c:94:35: error: 'x86_swiotlb_flags' undeclared (first use in this function); did you mean 'x86_swiotlb_enable'?
arch/x86/kernel/pci-dma.c:94:35: error: use of undeclared identifier 'x86_swiotlb_flags'; did you mean 'x86_power_flags'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-defconfig
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a003
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a005
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a012
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a014
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-a016
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-c021
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
|-- i386-randconfig-s001
|   `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)
`-- i386-randconfig-s002
    `-- arch-x86-kernel-pci-dma.c:error:x86_swiotlb_flags-undeclared-(first-use-in-this-function)

clang_recent_errors
|-- i386-randconfig-a002
|   `-- arch-x86-kernel-pci-dma.c:error:use-of-undeclared-identifier-x86_swiotlb_flags
|-- i386-randconfig-a004
|   `-- arch-x86-kernel-pci-dma.c:error:use-of-undeclared-identifier-x86_swiotlb_flags
|-- i386-randconfig-a011
|   `-- arch-x86-kernel-pci-dma.c:error:use-of-undeclared-identifier-x86_swiotlb_flags
|-- i386-randconfig-a013
|   `-- arch-x86-kernel-pci-dma.c:error:use-of-undeclared-identifier-x86_swiotlb_flags
`-- i386-randconfig-a015
    `-- arch-x86-kernel-pci-dma.c:error:use-of-undeclared-identifier-x86_swiotlb_flags

elapsed time: 725m

configs tested: 102
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
riscv                            allyesconfig
xtensa                  nommu_kc705_defconfig
nios2                         3c120_defconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
arm                            lart_defconfig
arc                         haps_hs_defconfig
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
um                             i386_defconfig
m68k                         amcore_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                        cell_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220217
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220217
arm                  randconfig-c002-20220217
i386                          randconfig-c001
mips                 randconfig-c004-20220217
arm                     davinci_all_defconfig
arm                      tct_hammer_defconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

