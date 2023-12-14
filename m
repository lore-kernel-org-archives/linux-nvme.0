Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B8C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 23:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o0X/N7X2ZwNt0T+qUUIcDcsfteHtjOHyLULpRMs6mUw=; b=RhlILrzV3d6VPRbCr7JzYXAxou
	5as0Fdsk4SPQzOu4jFMKXdlWmm1THH+ARXvn1OH105VWMImX5ara7VMHbTzviS8yIjZryl3o/bJJ2
	28z8GQkxpThR49F4t9jGBe0dsLoNtIxmXeiyLEe2GA9Z5mwTNkMiXWwK+mLc6TdZ9FRbWm1TeEHPz
	yxtQcGXI1qObGBf1S4N6qnmVHJYgwSPUHeOpWwO4ForQbVscDUDAg6McvvXdjngmCWh/BFciS2eEq
	78FPPSKGwFub/12re9JK953zBMaclvxVRhDEKDa+aoxkDwkHmceJQAhFdUgAqV2qRnLRebnL1XSt+
	IiQfLN0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDv5N-001Y0z-25;
	Thu, 14 Dec 2023 23:25:45 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDv5I-001Y0e-2e
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 23:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702596340; x=1734132340;
  h=date:from:to:cc:subject:message-id;
  bh=DeoMVFMtZ0adQxxFwpI3zfQsZOQxjETELfbU/YKVXTE=;
  b=f5IBseb+NwpYjghDGP/5+/Jse6ZIIwuu9x2cUnv+qBK/tCNpWnysSAEL
   Mv8DzE3jra4Wl17DTo9mijHpmJrYb3Y6+U6JLhIn79CBTBOB7M8MzIDr6
   kRN67NSp+4SeAhaUaH0KKf12G7nIudeM50lW+y2QPjCkJ9T4CJdfYwYsk
   IxclNi38kC3TrK/zKkR6gTK3RW6kGX6oBRcM9mbGdwa6PgfvP4dPpCINB
   yNYqkBN7ZrmRQTgjr0QrQqx45SBdT4mukIjEWMthPPXW/1TJKiCqnrtnU
   ye72BSbajNmKZPK6hz7W6xL/xZwJWkY6Q4V+oXMopUbtFEqXtkt41Ed1H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426333224"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="426333224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803489323"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="803489323"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2023 15:25:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDv55-000MjK-2Z;
	Thu, 14 Dec 2023 23:25:27 +0000
Date: Fri, 15 Dec 2023 07:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:for-6.8/block] BUILD SUCCESS
 e3eea14279fd861d53a0d64a80262f2387dbce31
Message-ID: <202312150702.2YaqRsMx-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_152540_900596_372886BA 
X-CRM114-Status: UNSURE (   5.69  )
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

tree/branch: git://git.infradead.org/nvme.git for-6.8/block
branch HEAD: e3eea14279fd861d53a0d64a80262f2387dbce31  nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl

elapsed time: 1460m

configs tested: 236
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231214   gcc  
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231214   gcc  
arc                   randconfig-002-20231215   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231214   gcc  
arm                   randconfig-002-20231214   gcc  
arm                   randconfig-003-20231214   gcc  
arm                   randconfig-004-20231214   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231214   gcc  
arm64                 randconfig-002-20231214   gcc  
arm64                 randconfig-003-20231214   gcc  
arm64                 randconfig-004-20231214   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231214   gcc  
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231214   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231214   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231214   clang
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231214   clang
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231214   clang
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231214   clang
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231214   clang
i386                  randconfig-016-20231215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231214   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231214   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231214   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231214   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231214   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231214   gcc  
parisc                randconfig-002-20231215   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231214   gcc  
powerpc               randconfig-002-20231214   gcc  
powerpc               randconfig-003-20231214   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231214   gcc  
powerpc64             randconfig-002-20231214   gcc  
powerpc64             randconfig-003-20231214   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231214   gcc  
riscv                 randconfig-002-20231214   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231214   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231214   gcc  
sh                    randconfig-002-20231215   gcc  
sh                          rsk7203_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231214   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231214   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231214   gcc  
um                    randconfig-002-20231214   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231214   gcc  
x86_64       buildonly-randconfig-001-20231215   clang
x86_64       buildonly-randconfig-002-20231214   gcc  
x86_64       buildonly-randconfig-002-20231215   clang
x86_64       buildonly-randconfig-003-20231214   gcc  
x86_64       buildonly-randconfig-003-20231215   clang
x86_64       buildonly-randconfig-004-20231214   gcc  
x86_64       buildonly-randconfig-004-20231215   clang
x86_64       buildonly-randconfig-005-20231214   gcc  
x86_64       buildonly-randconfig-005-20231215   clang
x86_64       buildonly-randconfig-006-20231214   gcc  
x86_64       buildonly-randconfig-006-20231215   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231214   gcc  
x86_64                randconfig-011-20231215   clang
x86_64                randconfig-012-20231214   gcc  
x86_64                randconfig-012-20231215   clang
x86_64                randconfig-013-20231214   gcc  
x86_64                randconfig-013-20231215   clang
x86_64                randconfig-014-20231214   gcc  
x86_64                randconfig-014-20231215   clang
x86_64                randconfig-015-20231214   gcc  
x86_64                randconfig-015-20231215   clang
x86_64                randconfig-016-20231214   gcc  
x86_64                randconfig-016-20231215   clang
x86_64                randconfig-071-20231214   gcc  
x86_64                randconfig-071-20231215   clang
x86_64                randconfig-072-20231214   gcc  
x86_64                randconfig-072-20231215   clang
x86_64                randconfig-073-20231214   gcc  
x86_64                randconfig-073-20231215   clang
x86_64                randconfig-074-20231214   gcc  
x86_64                randconfig-074-20231215   clang
x86_64                randconfig-075-20231214   gcc  
x86_64                randconfig-075-20231215   clang
x86_64                randconfig-076-20231214   gcc  
x86_64                randconfig-076-20231215   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231214   gcc  
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231214   gcc  
xtensa                randconfig-002-20231215   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

