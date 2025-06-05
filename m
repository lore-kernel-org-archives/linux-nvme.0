Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBCFC5B543
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jun 2025 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hqvvLQuO4ppYxinLskRqknaIA31LD7R/5Y/k1qGArgA=; b=D/5WYsZXx7eCDZkmFmWT6GM7LZ
	VKVV+bt4Y2mYbMYiL6uiKQCVzbuX3HyHOOfxrNKZl3xu3GPDKo3wg7UDysx9o1pnC7Ro3v74z3UtE
	8ae1K/7SCwlX9+yZLqAhKraFkI4r2BKwMDDhtdVMfSh6cIAvttSCbfHNcLW8kc3H+3l6c1B4NJSn2
	qHT56/5g4B8Qbx5VWQLyghApABFN1pjHu19pZvKnOmYpI2VGaDfQeZ7/O5iEAQriIyWG2sNfaRwHQ
	IzBigReUfN03NkllyypeRAqrpUH3AsvQCgREzX+glo7bBZVwHfBL1n5wBPdwVepnLUIt7ktBhRpzF
	H/Z54znQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN7q1-0000000FFRo-1Mgg;
	Thu, 05 Jun 2025 10:28:45 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6j1-0000000F9A3-1wzI
	for linux-nvme@lists.infradead.org;
	Thu, 05 Jun 2025 09:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749115047; x=1780651047;
  h=date:from:to:cc:subject:message-id;
  bh=yAxlklIz6DJz2RTsRWMJpJtkWUflzBTK079Puk8F7iM=;
  b=dT9LzszHauCPZ2QFCe5PNTV3D4khow6Wwy1GWEtOijXCZWvwzaNXVRxC
   ADcNqMpSHHuix0ldomwCh+xBzGEZEJgKBgPs9iT8iBy1V9njOdln68Uvh
   hmh3uJAygQ7x+PFul66+JGzTMwAbMag4XgdCmHIyVoRPmU1NvVGy7EIQx
   1a1uTvHVdcvBFEHDgZj/w2rMhlD+hdV9vjg/McDeCdwq0FwkZMk0Xg3G+
   ZrUjJoXtdeOHhkuQWZzrObBr67nwcusUwFQxkTIaipc9kLmH/poqCRj+Q
   kpanDpSFvk/LZH5xgBSyLvH4iKFzlYAn/ZpetTikyCekwgYoUvFAMOZp+
   w==;
X-CSE-ConnectionGUID: FbKEumiNTeSNuNHujRnGGA==
X-CSE-MsgGUID: +wMVEO1TRz+6TQkMi6UNJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="68665072"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="68665072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 02:17:27 -0700
X-CSE-ConnectionGUID: mVrsINzTSXO/rLgobYRSOg==
X-CSE-MsgGUID: S0pFSBEISseBtAI1HoJKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150340370"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Jun 2025 02:17:25 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uN6ix-0003x7-12;
	Thu, 05 Jun 2025 09:17:23 +0000
Date: Thu, 05 Jun 2025 17:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS
 44e479d7202070c3bc7f084a4951ee8689769f71
Message-ID: <202506051747.01D7t75x-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_021727_579993_50D5CDBD 
X-CRM114-Status: UNSURE (   5.61  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.16
branch HEAD: 44e479d7202070c3bc7f084a4951ee8689769f71  nvme: spelling fixes

elapsed time: 1445m

configs tested: 301
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    clang-19
arc                   randconfig-001-20250604    gcc-12.4.0
arc                   randconfig-001-20250605    clang-21
arc                   randconfig-002-20250604    gcc-12.4.0
arc                   randconfig-002-20250605    clang-21
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                     davinci_all_defconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                          exynos_defconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                      integrator_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-15.1.0
arm                         nhk8815_defconfig    clang-21
arm                          pxa910_defconfig    gcc-15.1.0
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250604    gcc-14.3.0
arm                   randconfig-001-20250605    clang-21
arm                   randconfig-002-20250604    clang-18
arm                   randconfig-002-20250605    clang-21
arm                   randconfig-003-20250604    gcc-10.5.0
arm                   randconfig-003-20250605    clang-21
arm                   randconfig-004-20250604    clang-21
arm                   randconfig-004-20250605    clang-21
arm                             rpc_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-21
arm                           stm32_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250604    gcc-6.5.0
arm64                 randconfig-001-20250605    clang-21
arm64                 randconfig-002-20250604    clang-21
arm64                 randconfig-002-20250605    clang-21
arm64                 randconfig-003-20250604    gcc-6.5.0
arm64                 randconfig-003-20250605    clang-21
arm64                 randconfig-004-20250604    gcc-12.3.0
arm64                 randconfig-004-20250605    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250604    gcc-12.4.0
csky                  randconfig-001-20250605    clang-21
csky                  randconfig-002-20250604    gcc-15.1.0
csky                  randconfig-002-20250605    clang-21
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250604    clang-21
hexagon               randconfig-001-20250605    clang-21
hexagon               randconfig-002-20250604    clang-21
hexagon               randconfig-002-20250605    clang-21
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250604    clang-20
i386        buildonly-randconfig-001-20250605    clang-20
i386        buildonly-randconfig-002-20250604    gcc-12
i386        buildonly-randconfig-002-20250605    clang-20
i386        buildonly-randconfig-003-20250604    gcc-12
i386        buildonly-randconfig-003-20250605    clang-20
i386        buildonly-randconfig-004-20250604    gcc-12
i386        buildonly-randconfig-004-20250605    clang-20
i386        buildonly-randconfig-005-20250604    clang-20
i386        buildonly-randconfig-005-20250605    clang-20
i386        buildonly-randconfig-006-20250604    gcc-12
i386        buildonly-randconfig-006-20250605    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250605    clang-20
i386                  randconfig-002-20250605    clang-20
i386                  randconfig-003-20250605    clang-20
i386                  randconfig-004-20250605    clang-20
i386                  randconfig-005-20250605    clang-20
i386                  randconfig-006-20250605    clang-20
i386                  randconfig-007-20250605    clang-20
i386                  randconfig-011-20250605    clang-20
i386                  randconfig-012-20250605    clang-20
i386                  randconfig-013-20250605    clang-20
i386                  randconfig-014-20250605    clang-20
i386                  randconfig-015-20250605    clang-20
i386                  randconfig-016-20250605    clang-20
i386                  randconfig-017-20250605    clang-20
loongarch                        alldefconfig    clang-19
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch                 loongson3_defconfig    clang-19
loongarch             randconfig-001-20250604    gcc-15.1.0
loongarch             randconfig-001-20250605    clang-21
loongarch             randconfig-002-20250604    gcc-15.1.0
loongarch             randconfig-002-20250605    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-21
mips                           ip22_defconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250604    gcc-13.3.0
nios2                 randconfig-001-20250605    clang-21
nios2                 randconfig-002-20250604    gcc-7.5.0
nios2                 randconfig-002-20250605    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250604    gcc-7.5.0
parisc                randconfig-001-20250605    clang-21
parisc                randconfig-002-20250604    gcc-14.3.0
parisc                randconfig-002-20250605    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-21
powerpc                        icon_defconfig    clang-21
powerpc                        icon_defconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    clang-21
powerpc                       ppc64_defconfig    clang-21
powerpc                       ppc64_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    clang-21
powerpc               randconfig-001-20250604    clang-21
powerpc               randconfig-001-20250605    clang-21
powerpc               randconfig-002-20250604    clang-18
powerpc               randconfig-002-20250605    clang-21
powerpc               randconfig-003-20250604    gcc-8.5.0
powerpc               randconfig-003-20250605    clang-21
powerpc                     taishan_defconfig    clang-17
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250604    gcc-12.4.0
powerpc64             randconfig-001-20250605    clang-21
powerpc64             randconfig-002-20250604    gcc-11.5.0
powerpc64             randconfig-002-20250605    clang-21
powerpc64             randconfig-003-20250604    clang-21
powerpc64             randconfig-003-20250605    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250604    clang-19
riscv                 randconfig-001-20250605    clang-21
riscv                 randconfig-002-20250604    gcc-15.1.0
riscv                 randconfig-002-20250605    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250604    clang-18
s390                  randconfig-001-20250605    clang-21
s390                  randconfig-002-20250604    gcc-9.3.0
s390                  randconfig-002-20250605    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                          landisk_defconfig    clang-21
sh                    randconfig-001-20250604    gcc-11.5.0
sh                    randconfig-001-20250605    clang-21
sh                    randconfig-002-20250604    gcc-7.5.0
sh                    randconfig-002-20250605    clang-21
sh                          rsk7201_defconfig    clang-21
sh                          rsk7264_defconfig    gcc-15.1.0
sh                          rsk7269_defconfig    clang-21
sh                           se7619_defconfig    clang-21
sh                   sh7770_generic_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250604    gcc-10.3.0
sparc                 randconfig-001-20250605    clang-21
sparc                 randconfig-002-20250604    gcc-11.5.0
sparc                 randconfig-002-20250605    clang-21
sparc                       sparc32_defconfig    gcc-15.1.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250604    gcc-14.3.0
sparc64               randconfig-001-20250605    clang-21
sparc64               randconfig-002-20250604    gcc-15.1.0
sparc64               randconfig-002-20250605    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250604    clang-17
um                    randconfig-001-20250605    clang-21
um                    randconfig-002-20250604    clang-21
um                    randconfig-002-20250605    clang-21
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250604    gcc-12
x86_64      buildonly-randconfig-001-20250605    clang-20
x86_64      buildonly-randconfig-002-20250604    gcc-12
x86_64      buildonly-randconfig-002-20250605    clang-20
x86_64      buildonly-randconfig-003-20250604    gcc-12
x86_64      buildonly-randconfig-003-20250605    clang-20
x86_64      buildonly-randconfig-004-20250604    gcc-12
x86_64      buildonly-randconfig-004-20250605    clang-20
x86_64      buildonly-randconfig-005-20250604    gcc-12
x86_64      buildonly-randconfig-005-20250605    clang-20
x86_64      buildonly-randconfig-006-20250604    clang-20
x86_64      buildonly-randconfig-006-20250605    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250605    gcc-12
x86_64                randconfig-002-20250605    gcc-12
x86_64                randconfig-003-20250605    gcc-12
x86_64                randconfig-004-20250605    gcc-12
x86_64                randconfig-005-20250605    gcc-12
x86_64                randconfig-006-20250605    gcc-12
x86_64                randconfig-007-20250605    gcc-12
x86_64                randconfig-008-20250605    gcc-12
x86_64                randconfig-071-20250605    clang-20
x86_64                randconfig-072-20250605    clang-20
x86_64                randconfig-073-20250605    clang-20
x86_64                randconfig-074-20250605    clang-20
x86_64                randconfig-075-20250605    clang-20
x86_64                randconfig-076-20250605    clang-20
x86_64                randconfig-077-20250605    clang-20
x86_64                randconfig-078-20250605    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250604    gcc-13.3.0
xtensa                randconfig-001-20250605    clang-21
xtensa                randconfig-002-20250604    gcc-11.5.0
xtensa                randconfig-002-20250605    clang-21
xtensa                         virt_defconfig    gcc-15.1.0
xtensa                    xip_kc705_defconfig    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

