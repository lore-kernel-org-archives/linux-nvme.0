Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40232C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YsqTEetPQrYXnp+Hu/wtIaP9zOO76akQwIW4JGJw1lc=; b=YCJBP8cY1aWndqqqv1viC6TVzH
	KmV6GXCEii/bygiKAxIksZzX7uRMtYbhuRoXZ0Ev5ZfBwZHRNcs4YwcpOfe3i7xgG6WwUI48PKs4J
	4lBVZ5kK13XICfkY75JG31cEdY+jXWi73V7ZoT5e3m4yzSZJDRwSWhKqkJZXd3JQfEnKXrc1U38HB
	mFMsz0MJZVjOESKseExxaES65oFVLcS30gaqKw1XZfgd45spUMqCverHCsVl9HxlaDQJhwJ/GwkLp
	ITyqbRp/e1aJgMCU6DsRwQELDPTfOb5i6921loytsSYDY5JwK4rb7nlKHJx2MvMb3oVDyEZO+tNbd
	PdhL1E7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTerW-00000009x3S-1MlS;
	Tue, 16 Jul 2024 09:52:46 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTerS-00000009x1w-1rSH
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 09:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721123563; x=1752659563;
  h=date:from:to:cc:subject:message-id;
  bh=uKMQ7SPgA7AZa3jLE1Whr5evGJtyL3W72GW7bo1vClg=;
  b=N8WdzHw/ZHyLw8aAgq+S3aB6GhVv7W+fCA6tPfWCGB5LKWvX7LUYMK2c
   CIQYyPLy+4FC5ksYWDf0o5DAeKpOiAe7RBDMZ+6VSQQbhmc9IXOyHelm4
   Qt9tlvsP/QF9lXjyStyAgNrxa+rOEPPJrqZLubr/eCHpe95hWfAhjBwt/
   XX+rzpemwuPnGEHQo7rN+iVrK2X4ZdPpaGsF84ShSns6Q9bz5lmQ2cMG6
   SB8ofQ21XeWIecuJ4T13Heq858uGPdWWuaAHC5ashoz+/QsJFKzhy6V1p
   ZERboug3TUq4OGpg+iPRvoXnrSMPKRmFbIKWhS9QWXOnDFkvTZwLeDya7
   A==;
X-CSE-ConnectionGUID: roZfiPELTe2iW3sS4T9JtQ==
X-CSE-MsgGUID: wnOIGhuAQQqNlFnpq2Ee0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18702438"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18702438"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:52:01 -0700
X-CSE-ConnectionGUID: K5HO8MCARcKCELAju5ZKsg==
X-CSE-MsgGUID: XxZtt7T5TTq0SBYHok/ZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49876058"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jul 2024 02:51:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTeqY-000f6O-1Q;
	Tue, 16 Jul 2024 09:51:46 +0000
Date: Tue, 16 Jul 2024 17:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 92fc2c469eb26060384e9b2cd4cb0cc228aba582
Message-ID: <202407161733.h1ICgzBo-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_025242_532514_AB4E2D00 
X-CRM114-Status: UNSURE (   4.98  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: 92fc2c469eb26060384e9b2cd4cb0cc228aba582  nvme-pci: Fix the instructions for disabling power management

elapsed time: 726m

configs tested: 210
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240716   gcc-13.2.0
arc                   randconfig-002-20240716   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-14.1.0
arm                       imx_v6_v7_defconfig   gcc-14.1.0
arm                      jornada720_defconfig   gcc-13.2.0
arm                        multi_v7_defconfig   gcc-14.1.0
arm                          pxa3xx_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240716   gcc-13.2.0
arm                   randconfig-002-20240716   gcc-13.2.0
arm                   randconfig-003-20240716   gcc-13.2.0
arm                   randconfig-004-20240716   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240716   gcc-13.2.0
arm64                 randconfig-002-20240716   gcc-13.2.0
arm64                 randconfig-003-20240716   gcc-13.2.0
arm64                 randconfig-004-20240716   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240716   gcc-13.2.0
csky                  randconfig-002-20240716   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240716   clang-18
i386         buildonly-randconfig-002-20240716   clang-18
i386         buildonly-randconfig-003-20240716   clang-18
i386         buildonly-randconfig-004-20240716   clang-18
i386         buildonly-randconfig-005-20240716   clang-18
i386         buildonly-randconfig-006-20240716   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240716   clang-18
i386                  randconfig-002-20240716   clang-18
i386                  randconfig-003-20240716   clang-18
i386                  randconfig-003-20240716   gcc-9
i386                  randconfig-004-20240716   clang-18
i386                  randconfig-004-20240716   gcc-7
i386                  randconfig-005-20240716   clang-18
i386                  randconfig-006-20240716   clang-18
i386                  randconfig-006-20240716   gcc-9
i386                  randconfig-011-20240716   clang-18
i386                  randconfig-011-20240716   gcc-8
i386                  randconfig-012-20240716   clang-18
i386                  randconfig-013-20240716   clang-18
i386                  randconfig-013-20240716   gcc-8
i386                  randconfig-014-20240716   clang-18
i386                  randconfig-015-20240716   clang-18
i386                  randconfig-016-20240716   clang-18
i386                  randconfig-016-20240716   gcc-10
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240716   gcc-13.2.0
loongarch             randconfig-002-20240716   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   gcc-13.2.0
mips                        bcm47xx_defconfig   gcc-14.1.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240716   gcc-13.2.0
nios2                 randconfig-002-20240716   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240716   gcc-13.2.0
parisc                randconfig-002-20240716   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                    adder875_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240716   gcc-13.2.0
powerpc               randconfig-002-20240716   gcc-13.2.0
powerpc               randconfig-003-20240716   gcc-13.2.0
powerpc64             randconfig-001-20240716   gcc-13.2.0
powerpc64             randconfig-002-20240716   gcc-13.2.0
powerpc64             randconfig-003-20240716   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240716   gcc-13.2.0
riscv                 randconfig-002-20240716   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240716   gcc-13.2.0
s390                  randconfig-002-20240716   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                    randconfig-001-20240716   gcc-13.2.0
sh                    randconfig-002-20240716   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7751_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-14.1.0
sh                           sh2007_defconfig   gcc-14.1.0
sh                            shmin_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            alldefconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240716   gcc-13.2.0
sparc64               randconfig-002-20240716   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240716   gcc-13.2.0
um                    randconfig-002-20240716   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240716   gcc-13
x86_64       buildonly-randconfig-002-20240716   gcc-13
x86_64       buildonly-randconfig-003-20240716   gcc-13
x86_64       buildonly-randconfig-004-20240716   gcc-13
x86_64       buildonly-randconfig-005-20240716   gcc-13
x86_64       buildonly-randconfig-006-20240716   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240716   gcc-13
x86_64                randconfig-002-20240716   gcc-13
x86_64                randconfig-003-20240716   gcc-13
x86_64                randconfig-004-20240716   gcc-13
x86_64                randconfig-005-20240716   gcc-13
x86_64                randconfig-006-20240716   gcc-13
x86_64                randconfig-011-20240716   gcc-13
x86_64                randconfig-012-20240716   gcc-13
x86_64                randconfig-013-20240716   gcc-13
x86_64                randconfig-014-20240716   gcc-13
x86_64                randconfig-015-20240716   gcc-13
x86_64                randconfig-016-20240716   gcc-13
x86_64                randconfig-071-20240716   gcc-13
x86_64                randconfig-072-20240716   gcc-13
x86_64                randconfig-073-20240716   gcc-13
x86_64                randconfig-074-20240716   gcc-13
x86_64                randconfig-075-20240716   gcc-13
x86_64                randconfig-076-20240716   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240716   gcc-13.2.0
xtensa                randconfig-002-20240716   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

