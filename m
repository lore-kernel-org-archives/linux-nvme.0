Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DC1EF48C4
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o+LZ+J4uyVOMCvUquFErK6CrYMsGx3/XxbR8H4rZ5wM=; b=oYt3d2Jy3D9HvNrEQvtomKYXZe
	v5A6NHPqJVDJDRkBt29CT4Ajlkg3rluzfFNMufqFNlBgojZkl0+J2E+/IDdTZx2epIRFnbO7MmJv4
	NdGKRu0ap3UwplbgsWvY1iFfuCXA22x3sYWoJpHTnsAYl+bbgSWdY1v4kwg8zTA/e2AzWU9DWxUfW
	5a/Wro0z1YrEA6mTqQtQSNo02DhXKvh7267DTwdIzAOKbGKYTSZVA6TGGW+jpu7wORA00Seh8EkYc
	b8B81jJNfgTPdHbH8g6LTIOi1zIcjIHCJylw28MEFx8+QvduBJK7fLG8+XQG+uLbFQx+MHV1RDjxl
	kiHiWR9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrEK8-00000004Vce-2QIX;
	Sat, 14 Feb 2026 12:00:32 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrEK5-00000004VcL-2jDV
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 12:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771070430; x=1802606430;
  h=date:from:to:cc:subject:message-id;
  bh=r2UbkDJS6HHwTIwMMsdAabUDdX8SdFHE1BDGc0bCUy4=;
  b=CcS0iEQ77PFo5AJRVwFN0KrHv7pW7XQzQ+v2jKPwN60j5nc2fHZPROzk
   GYrFVHZpycCOOg5fhwt4Chneuj3DpYNn08t3ZcyDTSAnKyP3f1FlSDw7C
   i/H7ZOP1KOSzK+IF5pGz7r1d/wZLZr8403s20QPLXs6wNrvbidItydV9y
   Y2wZ5VG4TUZo2IWY5uFVVhFrJJFCsmZ/JG6DYVk8hIuFXUHUM+YT8jz+c
   lDd83vSTvDMs4wijPZEpevkHIQlnHLfX4Z6sP2ZLQgYA2lY/MXYixV9OI
   HAQfNh235S79g+Awhohzo35rbTwM0DDMO6iOKY0aqL/Y+/Ri3hnI0xjNw
   Q==;
X-CSE-ConnectionGUID: Fcnhg0wTS26dJrFb+11NAA==
X-CSE-MsgGUID: hKfux4I4SKa36mplvw7ipA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72281067"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="72281067"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 04:00:27 -0800
X-CSE-ConnectionGUID: 431epK3USOa7W6luqWRGAQ==
X-CSE-MsgGUID: yxMSta8/R7umBO6GrQ1JbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="212997951"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2026 04:00:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrEJz-00000000wVa-0sBu;
	Sat, 14 Feb 2026 12:00:23 +0000
Date: Sat, 14 Feb 2026 19:59:49 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.0] BUILD SUCCESS
 baa47c4f89eb2e7614e6a06dd5957632e38c4e74
Message-ID: <202602141941.9hpBaioh-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260214_040029_814697_842B8AC3 
X-CRM114-Status: UNSURE (   4.99  )
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
branch HEAD: baa47c4f89eb2e7614e6a06dd5957632e38c4e74  nvme-pci: do not try to add queue maps at runtime

elapsed time: 1208m

configs tested: 261
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260214    clang-22
arc                   randconfig-002-20260214    clang-22
arc                        vdk_hs38_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                          collie_defconfig    gcc-15.2.0
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-22
arm                          moxart_defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-22
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260214    clang-22
arm                   randconfig-002-20260214    clang-22
arm                   randconfig-003-20260214    clang-22
arm                   randconfig-004-20260214    clang-22
arm                         s5pv210_defconfig    clang-22
arm                           sama7_defconfig    clang-22
arm                        shmobile_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260214    clang-22
arm64                 randconfig-001-20260214    gcc-8.5.0
arm64                 randconfig-002-20260214    gcc-8.5.0
arm64                 randconfig-003-20260214    gcc-14.3.0
arm64                 randconfig-003-20260214    gcc-8.5.0
arm64                 randconfig-004-20260214    gcc-14.3.0
arm64                 randconfig-004-20260214    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260214    gcc-12.5.0
csky                  randconfig-001-20260214    gcc-8.5.0
csky                  randconfig-002-20260214    gcc-14.3.0
csky                  randconfig-002-20260214    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260214    clang-22
hexagon               randconfig-002-20260214    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260214    clang-20
i386        buildonly-randconfig-002-20260214    clang-20
i386        buildonly-randconfig-003-20260214    clang-20
i386        buildonly-randconfig-004-20260214    clang-20
i386        buildonly-randconfig-005-20260214    clang-20
i386        buildonly-randconfig-006-20260214    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260214    clang-20
i386                  randconfig-002-20260214    clang-20
i386                  randconfig-003-20260214    clang-20
i386                  randconfig-004-20260214    clang-20
i386                  randconfig-005-20260214    clang-20
i386                  randconfig-006-20260214    clang-20
i386                  randconfig-007-20260214    clang-20
i386                  randconfig-011-20260214    gcc-14
i386                  randconfig-012-20260214    gcc-14
i386                  randconfig-013-20260214    gcc-14
i386                  randconfig-014-20260214    gcc-14
i386                  randconfig-015-20260214    gcc-14
i386                  randconfig-016-20260214    gcc-14
i386                  randconfig-017-20260214    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260214    clang-22
loongarch             randconfig-002-20260214    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                            q40_defconfig    clang-22
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    gcc-15.2.0
mips                        bcm63xx_defconfig    gcc-15.2.0
mips                         cobalt_defconfig    clang-22
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                           ip22_defconfig    gcc-15.2.0
mips                           ip27_defconfig    clang-22
mips                       lemote2f_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                          rm200_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260214    clang-22
nios2                 randconfig-002-20260214    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260214    clang-22
parisc                randconfig-001-20260214    gcc-9.5.0
parisc                randconfig-002-20260214    clang-22
parisc                randconfig-002-20260214    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260214    clang-18
powerpc               randconfig-001-20260214    clang-22
powerpc               randconfig-002-20260214    clang-22
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260214    clang-22
powerpc64             randconfig-002-20260214    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260214    clang-20
riscv                 randconfig-002-20260214    clang-20
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260214    clang-20
s390                  randconfig-002-20260214    clang-20
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-22
sh                         ecovec24_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    clang-22
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260214    clang-20
sh                    randconfig-002-20260214    clang-20
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7206_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260214    gcc-14.3.0
sparc                 randconfig-001-20260214    gcc-8.5.0
sparc                 randconfig-002-20260214    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260214    gcc-14.3.0
sparc64               randconfig-001-20260214    gcc-9.5.0
sparc64               randconfig-002-20260214    gcc-14.3.0
sparc64               randconfig-002-20260214    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260214    gcc-14
um                    randconfig-001-20260214    gcc-14.3.0
um                    randconfig-002-20260214    clang-22
um                    randconfig-002-20260214    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260214    clang-20
x86_64      buildonly-randconfig-002-20260214    clang-20
x86_64      buildonly-randconfig-003-20260214    clang-20
x86_64      buildonly-randconfig-004-20260214    clang-20
x86_64      buildonly-randconfig-005-20260214    clang-20
x86_64      buildonly-randconfig-006-20260214    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260214    clang-20
x86_64                randconfig-002-20260214    clang-20
x86_64                randconfig-003-20260214    clang-20
x86_64                randconfig-004-20260214    clang-20
x86_64                randconfig-005-20260214    clang-20
x86_64                randconfig-006-20260214    clang-20
x86_64                randconfig-011-20260214    gcc-14
x86_64                randconfig-012-20260214    gcc-14
x86_64                randconfig-013-20260214    gcc-14
x86_64                randconfig-014-20260214    gcc-14
x86_64                randconfig-015-20260214    gcc-14
x86_64                randconfig-016-20260214    gcc-14
x86_64                randconfig-071-20260214    clang-20
x86_64                randconfig-072-20260214    clang-20
x86_64                randconfig-073-20260214    clang-20
x86_64                randconfig-074-20260214    clang-20
x86_64                randconfig-075-20260214    clang-20
x86_64                randconfig-076-20260214    clang-20
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    clang-22
xtensa                randconfig-001-20260214    gcc-14.3.0
xtensa                randconfig-001-20260214    gcc-15.2.0
xtensa                randconfig-002-20260214    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

