Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15663EE49B3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2kjYpbgopP1OekkWr2gO/dKu6w9ZxVU7jyFDkCgce7A=; b=jeJN+m/m7HBZSntSCEyRSirDWq
	73L2tHm5DU9JY9Lj4fKcCXveCiGyPHuAutiHTojvqZyg4Mdq44DERiBlCwfktCdc/LRdVZ6SQQz+6
	/ehgACuG8Vh4HOsah0qn5k5Hp1HWjR47k2TCuslq/NWn1Iq92vnRgNA/A1RTnE5JKsc1flj9qsTTI
	Qo/p9dwBH25oeMmidxZLZ8bWucYUeTz7nS48EbRo1AOSKZF9PLhUTgxIfyAOKZGSxncZnDS3OumP+
	RFuo2KNhE5QVmkV3Blog6+IV6Gjas5ikwkybJbO7Yi1X4uklLqTyjpB6uNrbWsbgX8zloBLO9tqUd
	SI1CbJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOEB-00000009sa8-3PJI;
	Wed, 11 Sep 2024 14:21:51 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soNmF-00000009mnk-2AR9
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 13:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726062780; x=1757598780;
  h=date:from:to:cc:subject:message-id;
  bh=U3r6isMPxf+TsxzT11wBWMOTxn4rnNpVu2qW6JlmSis=;
  b=fpfy3KsVaneegUS+LWsLDCDymt48ZVvfoqkEiR/zqhYqZqoyWTYfwrZL
   TS8o1RUvy/oBoFryhntLmd7qY2rG79LqMS01ZIFykDljaz6dXmF7gV29m
   w4Ss+qKJDGXIcf4+1sGgfCDkzYCwM1rcOm3Vwco25sWDlT7NHlt2I4r5G
   kkKdfp2KUbTiZ+JOLuS9hYhevr01mS1ibxKGa/GrZZX7GFIU4vRQacqpZ
   fnFTq5Y3+CyOmYwIlG0JpET5qpvO/wbRXdgyZu14/fyw0+kk5KbaqivwA
   qRrNgHXya2jjzBpBZpvdI76tlh1HdP+GjYqXNGhAfpB7A1jwcK640cmnS
   A==;
X-CSE-ConnectionGUID: LlqZ9tR+TqyfzMlDxtJfcg==
X-CSE-MsgGUID: ku8UNN+wQDaX6q1nZ8SSEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25007721"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="25007721"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 06:52:57 -0700
X-CSE-ConnectionGUID: Q9Mhh3UsTtWOGL23WoHfTA==
X-CSE-MsgGUID: I0UfEZ4ITwmMTNYJpmPSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="98215241"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Sep 2024 06:52:55 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soNm9-0003eM-2C;
	Wed, 11 Sep 2024 13:52:53 +0000
Date: Wed, 11 Sep 2024 21:52:24 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 2d5a333e09c388189238291577e443221baacba0
Message-ID: <202409112122.P8SWcU5S-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_065259_677288_799A9D7E 
X-CRM114-Status: UNSURE (   4.96  )
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
branch HEAD: 2d5a333e09c388189238291577e443221baacba0  nvme-tcp: fix link failure for TCP auth

elapsed time: 1327m

configs tested: 210
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-14.1.0
arc                              alldefconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   clang-20
arm                              allmodconfig   clang-20
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                          exynos_defconfig   clang-20
arm                      footbridge_defconfig   clang-20
arm                            hisi_defconfig   gcc-14.1.0
arm                          moxart_defconfig   clang-20
arm                        multi_v7_defconfig   clang-20
arm                       netwinder_defconfig   gcc-14.1.0
arm                   randconfig-001-20240911   gcc-13.2.0
arm                   randconfig-002-20240911   gcc-13.2.0
arm                   randconfig-003-20240911   gcc-13.2.0
arm                   randconfig-004-20240911   gcc-13.2.0
arm                         socfpga_defconfig   gcc-14.1.0
arm                           tegra_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   gcc-13.2.0
arm64                 randconfig-002-20240911   gcc-13.2.0
arm64                 randconfig-003-20240911   gcc-13.2.0
arm64                 randconfig-004-20240911   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-13.2.0
csky                  randconfig-002-20240911   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240911   gcc-13.2.0
hexagon               randconfig-002-20240911   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240911   clang-18
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   clang-18
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   clang-18
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   clang-18
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   clang-18
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   clang-18
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   clang-18
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   clang-18
i386                  randconfig-016-20240911   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-13.2.0
loongarch             randconfig-002-20240911   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   gcc-14.1.0
mips                          rb532_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-13.2.0
nios2                 randconfig-002-20240911   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240911   gcc-13.2.0
parisc                randconfig-002-20240911   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                        icon_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                     mpc512x_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
powerpc               randconfig-003-20240911   gcc-13.2.0
powerpc                         wii_defconfig   clang-20
powerpc64             randconfig-001-20240911   gcc-13.2.0
powerpc64             randconfig-002-20240911   gcc-13.2.0
powerpc64             randconfig-003-20240911   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240911   gcc-13.2.0
riscv                 randconfig-002-20240911   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240911   gcc-13.2.0
s390                  randconfig-002-20240911   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240911   gcc-13.2.0
sh                    randconfig-002-20240911   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            alldefconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240911   gcc-13.2.0
sparc64               randconfig-002-20240911   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240911   gcc-13.2.0
um                    randconfig-002-20240911   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240911   clang-18
x86_64       buildonly-randconfig-002-20240911   clang-18
x86_64       buildonly-randconfig-003-20240911   clang-18
x86_64       buildonly-randconfig-004-20240911   clang-18
x86_64       buildonly-randconfig-005-20240911   clang-18
x86_64       buildonly-randconfig-006-20240911   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240911   clang-18
x86_64                randconfig-002-20240911   clang-18
x86_64                randconfig-003-20240911   clang-18
x86_64                randconfig-004-20240911   clang-18
x86_64                randconfig-005-20240911   clang-18
x86_64                randconfig-006-20240911   clang-18
x86_64                randconfig-011-20240911   clang-18
x86_64                randconfig-012-20240911   clang-18
x86_64                randconfig-013-20240911   clang-18
x86_64                randconfig-014-20240911   clang-18
x86_64                randconfig-015-20240911   clang-18
x86_64                randconfig-016-20240911   clang-18
x86_64                randconfig-071-20240911   clang-18
x86_64                randconfig-072-20240911   clang-18
x86_64                randconfig-073-20240911   clang-18
x86_64                randconfig-074-20240911   clang-18
x86_64                randconfig-075-20240911   clang-18
x86_64                randconfig-076-20240911   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240911   gcc-13.2.0
xtensa                randconfig-002-20240911   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

