Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57688D29FB1
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2n2nMuBscDaFIbvGres8cteYkeaToXFN3vuvSqNXw08=; b=AcI3GIX63o/dJlF1L5Y7g3MC70
	AgRkscTKZU+LRYk56c7dzBN2z7nv1dS0ZfulkV8i/ZpxA2Ulnx8Iv6em1g3oEgJj/nNEQwZ5TgX9K
	XSnOKJkURyABz9LM5mBCY2s+a5c7ZKtu0ucE4POtehfgIPCXlqO00br08AZ8TDZVaCiCmwBbSbnJ7
	GIMbxQERIVqS8OGkbDv7pVPINKhNAoycRMIElFWaWBIJmmMDRz+4am0U9WNB18G6Q4p/JDS46va8w
	bxmeHTjmXF1LAjOug4yY12Qgl+mdIE7ygzykz0DMn44XBm9CSYzyUUP7Y/4wL9Mwk0jwJj0biRFvl
	l2ikL7yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8aYo-000000027aT-1saY;
	Wed, 06 Nov 2024 07:34:38 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8aYl-000000027Zm-3BQR
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 07:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730878475; x=1762414475;
  h=date:from:to:cc:subject:message-id;
  bh=irEcZKabHDn9g9vZlnVfw0NEsVWWvVpgQCdpzeIqUfw=;
  b=UnLNXT9EFI/vCRkQnanKQ206EMtPFpeVgum266IvCIWDxyaJlt8BvqmH
   PZkGg4KBMcA9a+GD0DrveP2emLj35I9S0qXyMWe/J3rI8Yt86Ibx9FyU+
   KIUyK5NHDw/A31xlnB+ZC/DAXZrp3tZ6xCOVCF3z+n19fzz0YV65fqaaZ
   kixyTsQewb7Tg+FGjp94bcLs6oNAQ3BqgaCL5BAuQ+y070kiMLRzDHk+U
   /U4bKVYtKDKTAWw4DDTUsv4J+Ds2L/TUxHCdPJp5ULuF/mrfrUZy+OmGC
   wMfNDwfXvEgxn9+TyetsHmXhppcc0vcB0ND6DlIFHl5+doUdvJrZ7qfXT
   A==;
X-CSE-ConnectionGUID: hkYrQSgGQ4OpPHerxTAolw==
X-CSE-MsgGUID: aVtDxjDkQraitv/AIDguYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30542777"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="30542777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:34:31 -0800
X-CSE-ConnectionGUID: YLqbS6mtQlCkgFxjSCO6zA==
X-CSE-MsgGUID: vQO5Q7QVQnKvygqeMNM0gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84521227"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 23:34:15 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8aYO-000n3G-2s;
	Wed, 06 Nov 2024 07:34:12 +0000
Date: Wed, 06 Nov 2024 15:33:24 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 43d5d3b417410edcbe1584b17ac90bea9e633493
Message-ID: <202411061510.QclVSXRc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_233435_845031_42D7BAEC 
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: 43d5d3b417410edcbe1584b17ac90bea9e633493  nvme-core: remove repeated wq flags

elapsed time: 841m

configs tested: 258
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241106    gcc-14.2.0
arc                   randconfig-002-20241106    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    gcc-14.1.0
arm                         axm55xx_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                             mxs_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20241106    gcc-14.2.0
arm                   randconfig-002-20241106    gcc-14.2.0
arm                   randconfig-003-20241106    gcc-14.2.0
arm                   randconfig-004-20241106    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.1.0
arm                        shmobile_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm                           spitz_defconfig    gcc-14.2.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241106    gcc-14.2.0
arm64                 randconfig-002-20241106    gcc-14.2.0
arm64                 randconfig-003-20241106    gcc-14.2.0
arm64                 randconfig-004-20241106    gcc-14.2.0
csky                              allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241106    gcc-14.2.0
csky                  randconfig-002-20241106    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241106    gcc-14.2.0
hexagon               randconfig-002-20241106    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241106    gcc-12
i386        buildonly-randconfig-002-20241106    gcc-12
i386        buildonly-randconfig-003-20241106    gcc-12
i386        buildonly-randconfig-004-20241106    gcc-12
i386        buildonly-randconfig-005-20241106    gcc-12
i386        buildonly-randconfig-006-20241106    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241106    gcc-12
i386                  randconfig-002-20241106    gcc-12
i386                  randconfig-003-20241106    gcc-12
i386                  randconfig-004-20241106    gcc-12
i386                  randconfig-005-20241106    gcc-12
i386                  randconfig-006-20241106    gcc-12
i386                  randconfig-011-20241106    gcc-12
i386                  randconfig-012-20241106    gcc-12
i386                  randconfig-013-20241106    gcc-12
i386                  randconfig-014-20241106    gcc-12
i386                  randconfig-015-20241106    gcc-12
i386                  randconfig-016-20241106    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241106    gcc-14.2.0
loongarch             randconfig-002-20241106    gcc-14.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    clang-20
m68k                        mvme147_defconfig    clang-20
m68k                        mvme16x_defconfig    clang-20
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
mips                            gpr_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-20
mips                        vocore2_defconfig    gcc-14.1.0
nios2                         10m50_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241106    gcc-14.2.0
nios2                 randconfig-002-20241106    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241106    gcc-14.2.0
parisc                randconfig-002-20241106    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241106    gcc-14.2.0
powerpc               randconfig-002-20241106    gcc-14.2.0
powerpc               randconfig-003-20241106    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241106    gcc-14.2.0
powerpc64             randconfig-002-20241106    gcc-14.2.0
powerpc64             randconfig-003-20241106    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                    nommu_virt_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241106    gcc-14.2.0
riscv                 randconfig-002-20241106    gcc-14.2.0
s390                             allmodconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241106    gcc-14.2.0
s390                  randconfig-002-20241106    gcc-14.2.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20241106    gcc-14.2.0
sh                    randconfig-002-20241106    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.1.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241106    gcc-14.2.0
sparc64               randconfig-002-20241106    gcc-14.2.0
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241106    gcc-14.2.0
um                    randconfig-002-20241106    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241106    gcc-11
x86_64      buildonly-randconfig-002-20241106    gcc-11
x86_64      buildonly-randconfig-003-20241106    gcc-11
x86_64      buildonly-randconfig-004-20241106    gcc-11
x86_64      buildonly-randconfig-005-20241106    gcc-11
x86_64      buildonly-randconfig-006-20241106    gcc-11
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241106    gcc-11
x86_64                randconfig-002-20241106    gcc-11
x86_64                randconfig-003-20241106    gcc-11
x86_64                randconfig-004-20241106    gcc-11
x86_64                randconfig-005-20241106    gcc-11
x86_64                randconfig-006-20241106    gcc-11
x86_64                randconfig-011-20241106    gcc-11
x86_64                randconfig-012-20241106    gcc-11
x86_64                randconfig-013-20241106    gcc-11
x86_64                randconfig-014-20241106    gcc-11
x86_64                randconfig-015-20241106    gcc-11
x86_64                randconfig-016-20241106    gcc-11
x86_64                randconfig-071-20241106    gcc-11
x86_64                randconfig-072-20241106    gcc-11
x86_64                randconfig-073-20241106    gcc-11
x86_64                randconfig-074-20241106    gcc-11
x86_64                randconfig-075-20241106    gcc-11
x86_64                randconfig-076-20241106    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241106    gcc-14.2.0
xtensa                randconfig-002-20241106    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

