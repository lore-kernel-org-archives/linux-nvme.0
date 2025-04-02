Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFABC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hknq8jCMWc/qn/BjYALigmn72oUqtw6jyzUxdcbQv04=; b=ZlXjOAJYPg8feo5luqjP1zh5bn
	wSdxd1ENhybIESkkXjHEgTW9hcu5kpM1GUmwgQUkbTyQUTIKwTn1FeziafwTB6VJ5efJTggnXOTHg
	O/U7PquFPIpNyEXfd6WFZMcWRGJIDiVZ2KCPA5s2KehhVPoOSgPGbpuizJ/L5xugxkesANcqmIz8K
	0TajsYzhm/I70RIOQikar84Hezrf4GcQSf083RXCo6w56kzIOXANRHPMDPjGo0R8qmBUH2nsYDN7N
	oxwmywOckaiZNI7mD34lR6zmfhxu/cZNAPjnHoWMpPRt93AOch+CRqs4sAUl9E6udJCanmvKOWe0Z
	zn1RKzWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u018I-00000006fHY-1qYB;
	Wed, 02 Apr 2025 16:40:06 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u018F-00000006fH4-2J0B
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 16:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743612003; x=1775148003;
  h=date:from:to:cc:subject:message-id;
  bh=J5/Bst7JRhw7Y7w8yhGZT7oCQ+VH9j2RutJC9ezimck=;
  b=iq3+VM/aBVJTfi8oA075gViqgu+1UTPO6NyC8RPhQk6JF1WrS0PCpwut
   93KZGfuvCfEuuiFiTlCPvvOVTHty1mkrTSTIVyGxdAh0HAmEigYS9Y97U
   iwDml/mG3K444oTsni7iiEtEka7lY5R9HtEdg29iDCqeqMASfBQ4RADDZ
   NsFOv0KWRdVHC+NiZ7lnWgG6v9cGGUB/5tS46iam3fG7m24IPhuT+KgIi
   hCHnimrrOijU17GQOcnHmPYMSh1yyTCvEToaaOmygUIts5FMfLbncARQL
   eFgDxs6yvdMGxLwKylK7WCSmO9y/S8mRmOF3V5s4lZ9NbweWno1gzb+bh
   w==;
X-CSE-ConnectionGUID: oqmvVyA7SFaZH4cSU8L+Hg==
X-CSE-MsgGUID: S16zqsemRSKtevWJZN3owg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44698810"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44698810"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 09:40:00 -0700
X-CSE-ConnectionGUID: a+H3ubNpSbWWDSul2lY+Gw==
X-CSE-MsgGUID: sESZKMvUSN6ulZuexQvjmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="130878493"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Apr 2025 09:39:58 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0188-000AtA-3A;
	Wed, 02 Apr 2025 16:39:56 +0000
Date: Thu, 03 Apr 2025 00:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 288ff0d10beb069355036355d5f7612579dc869c
Message-ID: <202504030018.8dDMt4sC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_094003_627770_8EC1CB86 
X-CRM114-Status: UNSURE (   5.05  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.15
branch HEAD: 288ff0d10beb069355036355d5f7612579dc869c  nvme-pci: skip nvme_write_sq_db on empty rqlist

elapsed time: 1447m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250402    gcc-14.2.0
arc                   randconfig-002-20250402    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250402    clang-20
arm                   randconfig-002-20250402    clang-16
arm                   randconfig-003-20250402    clang-20
arm                   randconfig-004-20250402    clang-16
arm                        spear6xx_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250402    gcc-5.5.0
arm64                 randconfig-002-20250402    gcc-7.5.0
arm64                 randconfig-003-20250402    gcc-9.5.0
arm64                 randconfig-004-20250402    clang-17
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250402    gcc-9.3.0
csky                  randconfig-002-20250402    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250402    clang-21
hexagon               randconfig-002-20250402    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250402    gcc-12
i386        buildonly-randconfig-002-20250402    gcc-12
i386        buildonly-randconfig-003-20250402    gcc-12
i386        buildonly-randconfig-004-20250402    gcc-12
i386        buildonly-randconfig-005-20250402    gcc-11
i386        buildonly-randconfig-006-20250402    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250402    gcc-14.2.0
loongarch             randconfig-002-20250402    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
mips                           ip27_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250402    gcc-7.5.0
nios2                 randconfig-002-20250402    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250402    gcc-14.2.0
parisc                randconfig-002-20250402    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc               randconfig-001-20250402    clang-21
powerpc               randconfig-002-20250402    gcc-9.3.0
powerpc               randconfig-003-20250402    clang-21
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250402    clang-21
powerpc64             randconfig-002-20250402    clang-21
powerpc64             randconfig-003-20250402    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250402    gcc-9.3.0
riscv                 randconfig-002-20250402    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250402    clang-15
s390                  randconfig-002-20250402    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250402    gcc-7.5.0
sh                    randconfig-002-20250402    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250402    gcc-12.4.0
sparc                 randconfig-002-20250402    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250402    gcc-14.2.0
sparc64               randconfig-002-20250402    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250402    gcc-12
um                    randconfig-002-20250402    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250402    clang-20
x86_64      buildonly-randconfig-002-20250402    gcc-12
x86_64      buildonly-randconfig-003-20250402    clang-20
x86_64      buildonly-randconfig-004-20250402    gcc-12
x86_64      buildonly-randconfig-005-20250402    clang-20
x86_64      buildonly-randconfig-006-20250402    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250402    gcc-8.5.0
xtensa                randconfig-002-20250402    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

