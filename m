Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662FFCCFA05
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 22:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wCNbq7yT6wSsvSvyzcYZRfzJmFVzctw9aHyqlgBZJAo=; b=Z0/tjUtBHvpJvPKN4mTQuWJD68
	71XDLw2XG2rdGKPFToCVtmdLhkEwq2z2/6ZjUiRiBQNOdizBz8Sm+4o04Y5xyMAp8lzAZbFQUg5vV
	gPZhVyg6jcB63+TTpGTpcojWMP9SQ/dvYphJIHPlTjvb9HPSHjv2dM3awuxiM34LFQZfMsOgeM+/T
	oNz0DTheraEzg/bLUBSufcHGsF3YfC0SSpxairLGcWSSOR4WmjY/m7x0nR8viSELtX0B42JIgpStN
	gbRStMMFLa/lC8EDiKLYdv5eOr7NEgiEuQk3OokiPt9r8uMj2U/oNZerZ6X61Ls23PmbBKgAgnXcy
	LvPK82yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stauI-00000006hxl-3Q9c;
	Wed, 25 Sep 2024 22:54:50 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stauF-00000006hxG-2vtG
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 22:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727304888; x=1758840888;
  h=date:from:to:cc:subject:message-id;
  bh=4/IVserCb9W/kYHMy+aYXUpyvW2IgsZDUTV5fh9Bjn8=;
  b=NNgkLLaPDVoigPaPLiUPZytAQ0oAomEi6BQp0inq/H06MwPFSqCdJpnk
   BxIVwvL4uUSafleCSfDHbHUF8xkXl1bSipCHSfFaiD+JbwvNcvhbAG4hH
   HuuZpw1XHL1dUmDf74eTBSF6VB3glop8ahXELPPjAuKNP2K4BO3pXav9U
   HI64mGVN+bd6s9zT+FJ+srNaO/M0UORRGb9q4Ho0fdUpU9C02g7nYh+X1
   X0OpchUxmrsKL0zwOUDmPbWbqRxeF0Xk3Ikn4mzXyV2ffaU9ar3PnqT40
   5xKh4BD9WU422BNnOB29omcdyG5VlveCuaV1+GvwzmM4YazskCMmAsvbw
   g==;
X-CSE-ConnectionGUID: poe/zEBuQZOuSxjWP/zXcw==
X-CSE-MsgGUID: KrJSsrVLSUiJCKKx7EftzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="51796690"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="51796690"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:54:42 -0700
X-CSE-ConnectionGUID: B5zFCW7hT7umECcDDWhVKQ==
X-CSE-MsgGUID: EkGWwQK7RhynPB3wMeDNjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76732758"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Sep 2024 15:54:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stau6-000K15-1a;
	Wed, 25 Sep 2024 22:54:38 +0000
Date: Thu, 26 Sep 2024 06:54:32 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 9064610348b16356d43e59e286aedfec31825541
Message-ID: <202409260624.MusM8izy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_155447_816610_97F077F8 
X-CRM114-Status: UNSURE (   5.39  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 9064610348b16356d43e59e286aedfec31825541  nvme: remove CC register read-back during enabling

elapsed time: 922m

configs tested: 211
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240925    gcc-14.1.0
arc                   randconfig-002-20240925    gcc-14.1.0
arc                           tb10x_defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              alldefconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     am200epdkit_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                      jornada720_defconfig    clang-20
arm                        multi_v5_defconfig    clang-20
arm                       netwinder_defconfig    clang-20
arm                           omap1_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240925    gcc-14.1.0
arm                   randconfig-002-20240925    gcc-14.1.0
arm                   randconfig-003-20240925    gcc-14.1.0
arm                   randconfig-004-20240925    gcc-14.1.0
arm                         s3c6400_defconfig    clang-20
arm                           tegra_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm                        vexpress_defconfig    clang-20
arm                         vf610m4_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240925    gcc-14.1.0
arm64                 randconfig-002-20240925    gcc-14.1.0
arm64                 randconfig-003-20240925    gcc-14.1.0
arm64                 randconfig-004-20240925    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240925    gcc-14.1.0
csky                  randconfig-002-20240925    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240925    gcc-14.1.0
hexagon               randconfig-002-20240925    gcc-14.1.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240925    clang-18
i386        buildonly-randconfig-002-20240925    clang-18
i386        buildonly-randconfig-003-20240925    clang-18
i386        buildonly-randconfig-004-20240925    clang-18
i386        buildonly-randconfig-005-20240925    clang-18
i386        buildonly-randconfig-006-20240925    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240925    clang-18
i386                  randconfig-002-20240925    clang-18
i386                  randconfig-003-20240925    clang-18
i386                  randconfig-004-20240925    clang-18
i386                  randconfig-005-20240925    clang-18
i386                  randconfig-006-20240925    clang-18
i386                  randconfig-011-20240925    clang-18
i386                  randconfig-012-20240925    clang-18
i386                  randconfig-013-20240925    clang-18
i386                  randconfig-014-20240925    clang-18
i386                  randconfig-015-20240925    clang-18
i386                  randconfig-016-20240925    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240925    gcc-14.1.0
loongarch             randconfig-002-20240925    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-20
m68k                        m5407c3_defconfig    clang-20
m68k                        m5407c3_defconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    clang-20
mips                           ip27_defconfig    clang-20
mips                           ip28_defconfig    clang-20
mips                     loongson1b_defconfig    clang-20
mips                        omega2p_defconfig    clang-20
mips                           rs90_defconfig    clang-20
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240925    gcc-14.1.0
nios2                 randconfig-002-20240925    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240925    gcc-14.1.0
parisc                randconfig-002-20240925    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    clang-20
powerpc                       holly_defconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    gcc-14.1.0
powerpc                       maple_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                   microwatt_defconfig    clang-20
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc64e_defconfig    clang-20
powerpc                     rainier_defconfig    clang-20
powerpc               randconfig-001-20240925    gcc-14.1.0
powerpc               randconfig-002-20240925    gcc-14.1.0
powerpc                     skiroot_defconfig    clang-20
powerpc64             randconfig-001-20240925    gcc-14.1.0
powerpc64             randconfig-002-20240925    gcc-14.1.0
powerpc64             randconfig-003-20240925    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20240925    gcc-14.1.0
riscv                 randconfig-002-20240925    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240925    gcc-14.1.0
s390                  randconfig-002-20240925    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-20
sh                    randconfig-001-20240925    gcc-14.1.0
sh                    randconfig-002-20240925    gcc-14.1.0
sh                          rsk7203_defconfig    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sh                   secureedge5410_defconfig    clang-20
sh                        sh7757lcr_defconfig    gcc-14.1.0
sh                   sh7770_generic_defconfig    gcc-14.1.0
sh                        sh7785lcr_defconfig    gcc-14.1.0
sparc                            alldefconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240925    gcc-14.1.0
sparc64               randconfig-002-20240925    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240925    gcc-14.1.0
um                    randconfig-002-20240925    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240925    clang-18
x86_64      buildonly-randconfig-002-20240925    clang-18
x86_64      buildonly-randconfig-003-20240925    clang-18
x86_64      buildonly-randconfig-004-20240925    clang-18
x86_64      buildonly-randconfig-005-20240925    clang-18
x86_64      buildonly-randconfig-006-20240925    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20240925    clang-18
x86_64                randconfig-002-20240925    clang-18
x86_64                randconfig-003-20240925    clang-18
x86_64                randconfig-004-20240925    clang-18
x86_64                randconfig-005-20240925    clang-18
x86_64                randconfig-006-20240925    clang-18
x86_64                randconfig-011-20240925    clang-18
x86_64                randconfig-012-20240925    clang-18
x86_64                randconfig-013-20240925    clang-18
x86_64                randconfig-014-20240925    clang-18
x86_64                randconfig-015-20240925    clang-18
x86_64                randconfig-016-20240925    clang-18
x86_64                randconfig-071-20240925    clang-18
x86_64                randconfig-072-20240925    clang-18
x86_64                randconfig-073-20240925    clang-18
x86_64                randconfig-074-20240925    clang-18
x86_64                randconfig-075-20240925    clang-18
x86_64                randconfig-076-20240925    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240925    gcc-14.1.0
xtensa                randconfig-002-20240925    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

