Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A135D6409A
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UcdhsZARZekNlNxawrki4JPWc5fxyMnFZswqS2Xe9Fc=; b=MPtbq8J0EkJmvw4CD3sfuo+0Se
	RLEGLXb2yS89MuylNuCv+eZhUlChNnWyatSTnlsud6uYC9ERmHs/S4/F9GY/2YJa+lmG2P57x3ZtC
	iqO2c+wAvUORGox+qUq4KqZw+wIOPPnVnNndIfgsJZZ8An+Mq5PO+y1DbIjlfuIJiIPGwqJO4YJN3
	LrPtCVjcouDT3ytg1g+Om+7uyADtamsY2W8DLtcYikaEsERrJhLWmTgaJAb2L6ygVxRsvW01UXCYf
	nbTY1Hf1BLVZr85JqKfTo5hJV27nZ71zf/YDZzuLrBqSLo/Pm8OPsLaD6v6yJ1iPDuV0YZd6j5pcq
	POy8zduQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9eav-0000000Cl9F-2SGU;
	Sat, 09 Nov 2024 06:05:13 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9eVW-0000000Ckl4-1I9O
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 05:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731131979; x=1762667979;
  h=date:from:to:cc:subject:message-id;
  bh=PUnHPwWat+I45iG7JFcIHS6YBL/4qfREZrCJct8MOJ0=;
  b=MstjaPZdwhAsOR4NeDY5+bZ9/5f/FCx2Svjnd9MYAbhGG8VkFTZPuPFu
   GQeWWSen8aRzOUajinhsovGwKeosm13BknN5ILcc5rqDsOfeowB+rS4y+
   jwnOCefmtr/LYnzjkqG0btLZRWjZS4bbmJSgoalIGUlqqmPwNTvAeAcsj
   Tr8g7Ht6xz1anJomigX6Mbt6t+GJ0P1yq9XZom2UG0h8tMp+cFVTV/xop
   vmj1K7oSp3tBOYXVOTdn15+Eewe6F1hVR+RORt2FBfuHaKvbbDytDqMSq
   ciuoqPg3boA8lhY91SxVmKv3gLmaz437dtj9XSJysbo1slp8xHcnMHi8E
   A==;
X-CSE-ConnectionGUID: 8KadzAAMShy+Ydu7K6EZrQ==
X-CSE-MsgGUID: 0afSKnNWRBS0sZmroTSazA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30978856"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30978856"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 21:59:36 -0800
X-CSE-ConnectionGUID: x9NAt91FSmadfATxE8TyPg==
X-CSE-MsgGUID: rm30NbjqS4qicC2NIdJrAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="86697417"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Nov 2024 21:59:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9eVP-000s7e-2Y;
	Sat, 09 Nov 2024 05:59:31 +0000
Date: Sat, 09 Nov 2024 13:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 cf1a0a13bf4669bbc4d4e452de058eb4eb800f12
Message-ID: <202411091334.Pf6bRN3L-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_215938_422887_DBEA5FD9 
X-CRM114-Status: UNSURE (   4.80  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: cf1a0a13bf4669bbc4d4e452de058eb4eb800f12  nvme: check ns's volatile write cache not present

elapsed time: 724m

configs tested: 167
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    clang-14
arc                        nsimosci_defconfig    gcc-14.2.0
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-20
arm                            mps2_defconfig    gcc-14.2.0
arm                        neponset_defconfig    clang-14
arm                            qcom_defconfig    gcc-14.2.0
arm                        realview_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    clang-14
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241109    clang-19
i386        buildonly-randconfig-002-20241109    clang-19
i386        buildonly-randconfig-003-20241109    clang-19
i386        buildonly-randconfig-004-20241109    clang-19
i386        buildonly-randconfig-005-20241109    clang-19
i386        buildonly-randconfig-006-20241109    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241109    clang-19
i386                  randconfig-002-20241109    clang-19
i386                  randconfig-003-20241109    clang-19
i386                  randconfig-004-20241109    clang-19
i386                  randconfig-005-20241109    clang-19
i386                  randconfig-006-20241109    clang-19
i386                  randconfig-011-20241109    clang-19
i386                  randconfig-012-20241109    clang-19
i386                  randconfig-013-20241109    clang-19
i386                  randconfig-014-20241109    clang-19
i386                  randconfig-015-20241109    clang-19
i386                  randconfig-016-20241109    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    clang-14
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    clang-20
mips                        qi_lb60_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-14
mips                           xway_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    clang-14
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-14
powerpc                     ep8248e_defconfig    clang-14
powerpc                        fsp2_defconfig    clang-14
powerpc                  iss476-smp_defconfig    clang-14
powerpc                  iss476-smp_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                     mpc512x_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-14
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-14
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-14
powerpc                     redwood_defconfig    clang-14
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241109    gcc-12
x86_64      buildonly-randconfig-002-20241109    gcc-12
x86_64      buildonly-randconfig-003-20241109    gcc-12
x86_64      buildonly-randconfig-004-20241109    gcc-12
x86_64      buildonly-randconfig-005-20241109    gcc-12
x86_64      buildonly-randconfig-006-20241109    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241109    gcc-12
x86_64                randconfig-002-20241109    gcc-12
x86_64                randconfig-003-20241109    gcc-12
x86_64                randconfig-004-20241109    gcc-12
x86_64                randconfig-005-20241109    gcc-12
x86_64                randconfig-006-20241109    gcc-12
x86_64                randconfig-011-20241109    gcc-12
x86_64                randconfig-012-20241109    gcc-12
x86_64                randconfig-013-20241109    gcc-12
x86_64                randconfig-014-20241109    gcc-12
x86_64                randconfig-015-20241109    gcc-12
x86_64                randconfig-016-20241109    gcc-12
x86_64                randconfig-071-20241109    gcc-12
x86_64                randconfig-072-20241109    gcc-12
x86_64                randconfig-073-20241109    gcc-12
x86_64                randconfig-074-20241109    gcc-12
x86_64                randconfig-075-20241109    gcc-12
x86_64                randconfig-076-20241109    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

