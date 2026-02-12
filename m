Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30059EE36AE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hGlG7dGbIHxD2x6G7YAvvFkEjzu0zs4sYjYLvAd1WY8=; b=F/QNY/MdBunHtVvW5vR4bB0eCq
	tk89bohXq1ktcIJGeZr3H0trYcnb0dh+Nf4d3qxWYjdQlAxHaMVUp0aq9graEnU9yRL3xmlgt6AkJ
	guDMUXghLmGIhWtxT/4Pupfs0y/KVQq/O1oooQLkEcixztGWWgdKpVc1t9q6O2qSZlRF7rr9U1602
	mVQ/P0vWlDXiaNdrD95/NpMrj22UiOdt9W0EW2kw7aOA91rmGhGXs1eu/0JyKqM/9Q8/UuOM9KpV6
	x5N8AO8AZYX/ySZ7WpKsYH7t5JgSXg2pHRZsuJPkUrjSkppgCbG5eBpV5ZA1Lxh8Vzpku0uTFj8oj
	/DsNasWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqaoX-00000002TKw-1D0v;
	Thu, 12 Feb 2026 17:49:17 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqaoU-00000002TK5-1FN4
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 17:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770918554; x=1802454554;
  h=date:from:to:cc:subject:message-id;
  bh=P7tb3Cn2uEfBFl5j7lyK36NEPRqHOsJ+qOlJZ4LicJQ=;
  b=kVRciyLo2KGLcGzwGrs0Ken+AHHVIf6/JwGtmardyGOkte64uiDotzOk
   FMrCH9mVzBk+rdbpVRgTklaW+GMy3MVWTsbzZwx5/5mO6Z0K0E0pFY1Fp
   4WW2d7WDyy9z9OX321Js4VMGGjY1pXv+uTsdeMCJzR1/nOmmQCS1zgQnh
   iP7dvxeiSu3RzQ5S2pNtJKu920fQQqAZiUJ84skqdx25IFekw3QMcGsc9
   nmYYTcJxgr9OAUmta//rLqhFthjyoUdJJEtqKL8hE7qRku/UTiilS/3wv
   cNT6OrtOL+RDVGwIuVgvwrxpcW14s1IupiQAdTvgU4VgyxhlyDxfQc1gN
   w==;
X-CSE-ConnectionGUID: aDkJ7Ap3THuev7cBFIkQYA==
X-CSE-MsgGUID: QeTuTy5EQ2a0qvZvZll7ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82424942"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82424942"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 09:49:13 -0800
X-CSE-ConnectionGUID: vzWw4QEmRiO6PcADd8RMiw==
X-CSE-MsgGUID: sHwKrgmWTi2QGDKEmT6Q1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="212775772"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Feb 2026 09:49:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqaoP-00000000s4q-3Yiy;
	Thu, 12 Feb 2026 17:49:09 +0000
Date: Fri, 13 Feb 2026 01:48:56 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.0] BUILD SUCCESS
 bbdaa8c17cae18b977f4509911d7a390aa8a6597
Message-ID: <202602130148.Ua52uITa-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_094914_434354_A2ACE36C 
X-CRM114-Status: UNSURE (   5.09  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.0
branch HEAD: bbdaa8c17cae18b977f4509911d7a390aa8a6597  nvme: fix memory leak in quirks_param_set()

elapsed time: 862m

configs tested: 242
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260212    gcc-10.5.0
arc                   randconfig-001-20260213    clang-22
arc                   randconfig-002-20260212    gcc-10.5.0
arc                   randconfig-002-20260213    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260212    gcc-10.5.0
arm                   randconfig-001-20260213    clang-22
arm                   randconfig-002-20260212    gcc-10.5.0
arm                   randconfig-002-20260213    clang-22
arm                   randconfig-003-20260212    gcc-10.5.0
arm                   randconfig-003-20260213    clang-22
arm                   randconfig-004-20260212    gcc-10.5.0
arm                   randconfig-004-20260213    clang-22
arm                         s5pv210_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260212    gcc-10.5.0
arm64                 randconfig-002-20260212    gcc-10.5.0
arm64                 randconfig-003-20260212    gcc-10.5.0
arm64                 randconfig-004-20260212    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260212    gcc-10.5.0
csky                  randconfig-002-20260212    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260212    clang-18
hexagon               randconfig-002-20260212    clang-18
i386                             alldefconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260212    gcc-14
i386        buildonly-randconfig-002-20260212    gcc-14
i386        buildonly-randconfig-003-20260212    gcc-14
i386        buildonly-randconfig-004-20260212    gcc-14
i386        buildonly-randconfig-005-20260212    gcc-14
i386        buildonly-randconfig-006-20260212    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260212    clang-20
i386                  randconfig-002-20260212    clang-20
i386                  randconfig-003-20260212    clang-20
i386                  randconfig-004-20260212    clang-20
i386                  randconfig-005-20260212    clang-20
i386                  randconfig-006-20260212    clang-20
i386                  randconfig-007-20260212    clang-20
i386                  randconfig-011-20260212    gcc-12
i386                  randconfig-011-20260212    gcc-14
i386                  randconfig-012-20260212    gcc-12
i386                  randconfig-013-20260212    clang-20
i386                  randconfig-013-20260212    gcc-12
i386                  randconfig-014-20260212    clang-20
i386                  randconfig-014-20260212    gcc-12
i386                  randconfig-015-20260212    clang-20
i386                  randconfig-015-20260212    gcc-12
i386                  randconfig-016-20260212    gcc-12
i386                  randconfig-016-20260212    gcc-14
i386                  randconfig-017-20260212    clang-20
i386                  randconfig-017-20260212    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260212    clang-18
loongarch             randconfig-002-20260212    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip28_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260212    clang-18
nios2                 randconfig-002-20260212    clang-18
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260212    gcc-10.5.0
parisc                randconfig-001-20260213    clang-20
parisc                randconfig-002-20260212    gcc-10.5.0
parisc                randconfig-002-20260213    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260212    gcc-10.5.0
powerpc               randconfig-001-20260213    clang-20
powerpc               randconfig-002-20260212    gcc-10.5.0
powerpc               randconfig-002-20260213    clang-20
powerpc                     stx_gp3_defconfig    gcc-15.2.0
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    gcc-15.2.0
powerpc64             randconfig-001-20260212    gcc-10.5.0
powerpc64             randconfig-001-20260213    clang-20
powerpc64             randconfig-002-20260212    gcc-10.5.0
powerpc64             randconfig-002-20260213    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260212    gcc-9.5.0
riscv                 randconfig-001-20260213    gcc-11.5.0
riscv                 randconfig-002-20260212    gcc-9.5.0
riscv                 randconfig-002-20260213    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260212    gcc-9.5.0
s390                  randconfig-001-20260213    gcc-11.5.0
s390                  randconfig-002-20260212    gcc-9.5.0
s390                  randconfig-002-20260213    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260212    gcc-9.5.0
sh                    randconfig-001-20260213    gcc-11.5.0
sh                    randconfig-002-20260212    gcc-9.5.0
sh                    randconfig-002-20260213    gcc-11.5.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7619_defconfig    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260212    gcc-13.4.0
sparc                 randconfig-002-20260212    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260212    gcc-13.4.0
sparc64               randconfig-002-20260212    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260212    gcc-13.4.0
um                    randconfig-002-20260212    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260212    clang-20
x86_64      buildonly-randconfig-002-20260212    clang-20
x86_64      buildonly-randconfig-003-20260212    clang-20
x86_64      buildonly-randconfig-004-20260212    clang-20
x86_64      buildonly-randconfig-005-20260212    clang-20
x86_64      buildonly-randconfig-006-20260212    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260212    clang-20
x86_64                randconfig-002-20260212    clang-20
x86_64                randconfig-003-20260212    clang-20
x86_64                randconfig-004-20260212    clang-20
x86_64                randconfig-005-20260212    clang-20
x86_64                randconfig-006-20260212    clang-20
x86_64                randconfig-011-20260212    gcc-14
x86_64                randconfig-012-20260212    gcc-14
x86_64                randconfig-013-20260212    gcc-14
x86_64                randconfig-014-20260212    gcc-14
x86_64                randconfig-015-20260212    gcc-14
x86_64                randconfig-016-20260212    gcc-14
x86_64                randconfig-071-20260212    gcc-14
x86_64                randconfig-072-20260212    gcc-14
x86_64                randconfig-073-20260212    gcc-14
x86_64                randconfig-074-20260212    gcc-14
x86_64                randconfig-075-20260212    gcc-14
x86_64                randconfig-076-20260212    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260212    gcc-13.4.0
xtensa                randconfig-002-20260212    gcc-13.4.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

