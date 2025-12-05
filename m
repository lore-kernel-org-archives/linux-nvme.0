Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D8CD374AE
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OAjWmmO+B56s1zRYVB7m80aIbs4PDN1ckG/Yo1vxAOI=; b=bIl9t93mO6JwCaRXmkHHhNa5KV
	l3bBXVxslB6Ix6Kr0ESzi3M4/++A8W/p/s5zVyYMYlTw7IRZylIkYma7pVCLyR7pl9v/sGvyeLbRD
	0YY4ztsAtpkHfU+uivO8AXLiQEKRU7kFv3xOwxbRCLZSMgMNGhlUg1qHeWsm/y/wwASxlmufa0lxa
	0RQ2s5EkB0RxlVmwbKTZDf+Ak7C0VstaJUeQGnOESKadqZwHx3fUC47oO6PEiBVSTxecJIU5C0Fo0
	gLG+erVrpavlVIlKrh8jSM1eqsLXvwEaRpUgRaiyQn3QZbzxubzD53XLjArdJIWfAw9460A0DJtLN
	J58sfK3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vReql-0000000AAmH-1cAN;
	Fri, 05 Dec 2025 23:04:31 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vReqj-0000000AAln-0tHE
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 23:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764975869; x=1796511869;
  h=date:from:to:cc:subject:message-id;
  bh=6mu/T5Rh158aWzZukzgSeYcNf3lbbaeR4WxFdFbWoSc=;
  b=NQp2qbYkSNk3AHohtxaoHT7lZqaLj0Ok+PeHSNuNO0Og1qSCtZbYwzPp
   0pCY3psHeLX3O7CH2lObOddSZ1iCJt6tSGlprHWiYBLP3EQtGy2AxfOTm
   LW4tt8wJodxorM3b8CosUMjSPxcvDEapZBkYMSsjGM/0Ym/1FPfEMPYL2
   7sLvUO47yBqsk/woCroMKC9p/YvShgrc/5YX6aoamslnW9lS9QGL0HHWF
   esgMffZ07pwX0t3lyCa68SpAnqWc+MHlaQXp4FDJozFYO879JdyBWgKZE
   dhD/dtojJ0W48neFkXImka734c8l9A1a1YQPp3/gA78eOKBuKsswA/rKO
   w==;
X-CSE-ConnectionGUID: E1kXB8AtQQ2Zy/jLqJY/vg==
X-CSE-MsgGUID: IH3/wesBTwK2YSL7AyTqkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66201818"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="66201818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:04:28 -0800
X-CSE-ConnectionGUID: fCO84ElnS5CohzMlcSoSjw==
X-CSE-MsgGUID: 1BdKtvwuTemDAqEynuExZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="195487151"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Dec 2025 15:04:27 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vReqe-00000000Fdp-3JGe;
	Fri, 05 Dec 2025 23:04:24 +0000
Date: Sat, 06 Dec 2025 07:04:09 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD SUCCESS
 13989207ee29c40501e719512e8dc90768325895
Message-ID: <202512060703.trIlO9Wa-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_150429_267761_CF12D34B 
X-CRM114-Status: UNSURE (   3.97  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.19
branch HEAD: 13989207ee29c40501e719512e8dc90768325895  nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

elapsed time: 1449m

configs tested: 155
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251205    clang-22
arm64                 randconfig-002-20251205    clang-22
arm64                 randconfig-003-20251205    clang-22
arm64                 randconfig-004-20251205    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251205    clang-22
csky                  randconfig-002-20251205    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251205    clang-22
hexagon               randconfig-002-20251205    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251205    clang-20
i386                  randconfig-002-20251205    clang-20
i386                  randconfig-003-20251205    clang-20
i386                  randconfig-004-20251205    clang-20
i386                  randconfig-005-20251205    clang-20
i386                  randconfig-006-20251205    clang-20
i386                  randconfig-007-20251205    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20251205    clang-22
loongarch             randconfig-002-20251205    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251205    clang-22
nios2                 randconfig-002-20251205    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251205    clang-22
parisc                randconfig-002-20251205    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251205    clang-22
powerpc               randconfig-002-20251205    clang-22
powerpc64             randconfig-001-20251205    clang-22
powerpc64             randconfig-002-20251205    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251205    gcc-13.4.0
riscv                 randconfig-002-20251205    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251205    gcc-13.4.0
s390                  randconfig-002-20251205    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251205    gcc-13.4.0
sh                    randconfig-002-20251205    gcc-13.4.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251205    gcc-14
x86_64      buildonly-randconfig-002-20251205    gcc-14
x86_64      buildonly-randconfig-003-20251205    gcc-14
x86_64      buildonly-randconfig-004-20251205    gcc-14
x86_64      buildonly-randconfig-005-20251205    gcc-14
x86_64      buildonly-randconfig-006-20251205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251205    clang-20
x86_64                randconfig-002-20251205    clang-20
x86_64                randconfig-003-20251205    clang-20
x86_64                randconfig-004-20251205    clang-20
x86_64                randconfig-005-20251205    clang-20
x86_64                randconfig-006-20251205    clang-20
x86_64                randconfig-011-20251205    clang-20
x86_64                randconfig-012-20251205    clang-20
x86_64                randconfig-013-20251205    clang-20
x86_64                randconfig-014-20251205    clang-20
x86_64                randconfig-015-20251205    clang-20
x86_64                randconfig-016-20251205    clang-20
x86_64                randconfig-071-20251205    gcc-14
x86_64                randconfig-072-20251205    gcc-14
x86_64                randconfig-073-20251205    gcc-14
x86_64                randconfig-074-20251205    gcc-14
x86_64                randconfig-075-20251205    gcc-14
x86_64                randconfig-076-20251205    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

