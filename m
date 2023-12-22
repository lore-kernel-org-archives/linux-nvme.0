Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01612C46CD2
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+95TSg2/uQ9+vHYXQ1Td8p1TXm7ghTnYkXBUkO2C7is=; b=1Sen/J1zCs/V7XgL07Gzo78qT2
	sHe+SQAaZeECVpmlFCtkr6TWnL/F8g6WJcE4/9jkpHMZL263Rj1dtVnSLRMVJ3p5edRBIZ2RevAri
	VdkBjR3M3YPS7RhGbNI+RVSqxbT271gziaXZOKnHezGbfzq5ux09rjDwTtZb4KjMAF+OBOEZRnTgj
	AwC87t05gCCyH5//SRHkLswgtsQg/LyAg3fe9phFOwAstmqDmSCAgxjpBNt42Sh74zCIJMQoKvF5W
	nWpS2/bYbmSpfJiZ0kbzwqK1Gkd2VxENARSL63tsqRAkBOnNFnJ6CWROp0b4XyTv7L0eB0Kx9Len8
	PBewywMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGp4C-0071P5-1n;
	Fri, 22 Dec 2023 23:36:32 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGp49-0071Oh-0z
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 23:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703288189; x=1734824189;
  h=date:from:to:cc:subject:message-id;
  bh=lK3RYfjkAjrM4ZIF18AvBS1JpmaJsDC3ykwanob43IY=;
  b=NjsRzm8OSzWbELr3BzgzgXBxhlzKGhd4BnxnWOw5bGMxerjqBnAv/wTt
   jvQcuFH+Wm1+8SDvCIcflUWJKxwOXt/+L1M/st5Bc3qz+m+zTfKJ8b3Ji
   lAnuSMb3jb5KKj+T2Pk8y+iDhBQPbr4xvWMzRR6r8slhqm2bmi9nJqmuR
   WLjfg3gvlXp80nHCmTcBHon85RZ1pYarNqYf7GQb6PVM0myxmfb3aghBZ
   bhvtLk5S34rNHVT5IbI1b+tgvLPHqjqpqvydncNoIvKKhEFAsqfH++vor
   hyjAHbvDK425w6LyfDjpJRTfS761dtSVHFSC2Uzd+oyiAf6Stq8KF77/h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3007638"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3007638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777191139"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="777191139"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2023 15:36:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGp40-000A03-22;
	Fri, 22 Dec 2023 23:36:21 +0000
Date: Sat, 23 Dec 2023 07:35:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8-merge] BUILD SUCCESS
 9b056d5835e288320e5a0b06a0917a4147958bd1
Message-ID: <202312230717.g4PNhWBM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_153629_357438_49DE7BE5 
X-CRM114-Status: UNSURE (   6.01  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.8-merge
branch HEAD: 9b056d5835e288320e5a0b06a0917a4147958bd1  Merge remote-tracking branch 'nvme/nvme-6.8' into nvme-6.8-merge-v3

elapsed time: 1501m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231222   gcc  
arc                   randconfig-001-20231223   gcc  
arc                   randconfig-002-20231222   gcc  
arc                   randconfig-002-20231223   gcc  
arm                               allnoconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231222   gcc  
arm                   randconfig-002-20231222   gcc  
arm                   randconfig-003-20231222   gcc  
arm                   randconfig-004-20231222   gcc  
arm                        spear6xx_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231222   gcc  
arm64                 randconfig-002-20231222   gcc  
arm64                 randconfig-003-20231222   gcc  
arm64                 randconfig-004-20231222   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231222   gcc  
csky                  randconfig-001-20231223   gcc  
csky                  randconfig-002-20231222   gcc  
csky                  randconfig-002-20231223   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20231222   clang
i386                  randconfig-011-20231223   gcc  
i386                  randconfig-012-20231222   clang
i386                  randconfig-012-20231223   gcc  
i386                  randconfig-013-20231222   clang
i386                  randconfig-013-20231223   gcc  
i386                  randconfig-014-20231222   clang
i386                  randconfig-014-20231223   gcc  
i386                  randconfig-015-20231222   clang
i386                  randconfig-015-20231223   gcc  
i386                  randconfig-016-20231222   clang
i386                  randconfig-016-20231223   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231222   gcc  
loongarch             randconfig-001-20231223   gcc  
loongarch             randconfig-002-20231222   gcc  
loongarch             randconfig-002-20231223   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231222   gcc  
nios2                 randconfig-001-20231223   gcc  
nios2                 randconfig-002-20231222   gcc  
nios2                 randconfig-002-20231223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231222   gcc  
parisc                randconfig-001-20231223   gcc  
parisc                randconfig-002-20231222   gcc  
parisc                randconfig-002-20231223   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231222   gcc  
powerpc               randconfig-002-20231222   gcc  
powerpc               randconfig-003-20231222   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231222   gcc  
powerpc64             randconfig-002-20231222   gcc  
powerpc64             randconfig-003-20231222   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231222   gcc  
riscv                 randconfig-002-20231222   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231223   gcc  
s390                  randconfig-002-20231223   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231222   gcc  
sh                    randconfig-001-20231223   gcc  
sh                    randconfig-002-20231222   gcc  
sh                    randconfig-002-20231223   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231222   gcc  
sparc64               randconfig-001-20231223   gcc  
sparc64               randconfig-002-20231222   gcc  
sparc64               randconfig-002-20231223   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231222   gcc  
um                    randconfig-002-20231222   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231222   gcc  
x86_64       buildonly-randconfig-002-20231222   gcc  
x86_64       buildonly-randconfig-003-20231222   gcc  
x86_64       buildonly-randconfig-004-20231222   gcc  
x86_64       buildonly-randconfig-005-20231222   gcc  
x86_64       buildonly-randconfig-006-20231222   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231222   gcc  
x86_64                randconfig-012-20231222   gcc  
x86_64                randconfig-013-20231222   gcc  
x86_64                randconfig-014-20231222   gcc  
x86_64                randconfig-015-20231222   gcc  
x86_64                randconfig-016-20231222   gcc  
x86_64                randconfig-071-20231222   gcc  
x86_64                randconfig-072-20231222   gcc  
x86_64                randconfig-073-20231222   gcc  
x86_64                randconfig-074-20231222   gcc  
x86_64                randconfig-075-20231222   gcc  
x86_64                randconfig-076-20231222   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20231222   gcc  
xtensa                randconfig-001-20231223   gcc  
xtensa                randconfig-002-20231222   gcc  
xtensa                randconfig-002-20231223   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

