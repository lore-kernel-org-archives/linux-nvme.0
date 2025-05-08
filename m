Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D037C3ABC6
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WPRAYHHVCIi2GA6lIpnznVyhM462y5MgbJdSFMelh8o=; b=kp9QfRaaGdBhZlImJhCfUMIxgb
	xiIB3AhEn2mD7NxoaJQaNUDESED5aq494nY3r3KyxeRXUMh7x5IraBcae//f+t5cxp5wq1HULMFWQ
	ymw9d1uhhSOoXnEMOTqqwjHO1xN3qOQw4MNbwQwLn7BDkErBtOVgh+Ye/o3/xsPt8gzalLcBx4CFB
	t38TTgzS/fK0bZxaG0YkTMbyfRZ7bqR77IP4hYpHr4Ec/ugGI4CkzI6jksWf7XzFFCJEVha9HdMnX
	iUPyh6/bTXejGvWT4yXPi2FPLtmVdi2ge5Ml+6SSd4kzIlAKZXnErwtUge3TDoOPZMqUrj1npy53g
	H3+5pMEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD8au-00000001pQN-02H1;
	Thu, 08 May 2025 21:15:52 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD8aq-00000001pPm-33lt
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 21:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746738948; x=1778274948;
  h=date:from:to:cc:subject:message-id;
  bh=Uobto6WCBgZyjf2M8n8aZJqaqxpXZ7/538evF2FVK18=;
  b=jdIIjmayWi/y50FLV6z2INpD7HpfIrxcP535JocPPfRjXRIeVpAsc0k8
   4aSn3MIJHu5QNU+wlKjOnBW6VwY9lVsOfSiG78a0CrR6BVpKwBlN+3O0o
   0kcpeLQJ34iNmjrQHIKcvSjOBMeVL6kFiaCutI+zNFSMSjj70hUFhDL3a
   CXFJIm24uUxvHW3LWj78YW5gXIz1t4K/LVlwHCZ/6+gLz6BVbVYoUPBNx
   XFi0AuEEh78i/nOr9vwOOMyHfcIN2yQ1GnZSpkQ5hJ4omEQeX/+zXga1D
   HmUKxmdCITYfBIDLHS5/XdFaUxlE0XU39wzex2sU54JaBsUuyh1BYZ760
   A==;
X-CSE-ConnectionGUID: zQ6LxwSaTPmp9EJYHtjNqQ==
X-CSE-MsgGUID: 9JVUlUbRTEeWlGA3V4cAGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48462381"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48462381"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 14:15:47 -0700
X-CSE-ConnectionGUID: ck/EL8LSS4C5k1gfPnNkbA==
X-CSE-MsgGUID: hupr8awFS7GAxt6eJ7ckVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136800480"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2025 14:15:46 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD8am-000BNn-0w;
	Thu, 08 May 2025 21:15:44 +0000
Date: Fri, 09 May 2025 05:15:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 650415fca0a97472fdd79725e35152614d1aad76
Message-ID: <202505090517.8MfvAvd2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_141548_815835_1175F248 
X-CRM114-Status: UNSURE (   5.52  )
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
branch HEAD: 650415fca0a97472fdd79725e35152614d1aad76  nvme: unblock ctrl state transition for firmware update

elapsed time: 842m

configs tested: 156
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    clang-18
arc                        nsimosci_defconfig    clang-18
arc                 nsimosci_hs_smp_defconfig    clang-18
arc                   randconfig-001-20250508    gcc-8.5.0
arc                   randconfig-001-20250509    clang-21
arc                   randconfig-002-20250508    gcc-12.4.0
arc                   randconfig-002-20250509    clang-21
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                           h3600_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-21
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250508    clang-17
arm                   randconfig-001-20250509    clang-21
arm                   randconfig-002-20250508    clang-21
arm                   randconfig-002-20250509    clang-21
arm                   randconfig-003-20250508    clang-21
arm                   randconfig-003-20250509    clang-21
arm                   randconfig-004-20250508    gcc-7.5.0
arm                   randconfig-004-20250509    clang-21
arm                         s5pv210_defconfig    clang-18
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250508    clang-21
arm64                 randconfig-001-20250509    clang-21
arm64                 randconfig-002-20250508    clang-21
arm64                 randconfig-002-20250509    clang-21
arm64                 randconfig-003-20250508    gcc-8.5.0
arm64                 randconfig-003-20250509    clang-21
arm64                 randconfig-004-20250508    gcc-8.5.0
arm64                 randconfig-004-20250509    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250508    gcc-14.2.0
csky                  randconfig-002-20250508    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250508    clang-20
hexagon               randconfig-002-20250508    clang-21
i386                             alldefconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250509    clang-20
i386        buildonly-randconfig-001-20250509    gcc-11
i386        buildonly-randconfig-002-20250509    clang-20
i386        buildonly-randconfig-002-20250509    gcc-12
i386        buildonly-randconfig-003-20250509    clang-20
i386        buildonly-randconfig-004-20250509    clang-20
i386        buildonly-randconfig-005-20250509    clang-20
i386        buildonly-randconfig-005-20250509    gcc-12
i386        buildonly-randconfig-006-20250509    clang-20
i386        buildonly-randconfig-006-20250509    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-011-20250509    gcc-12
i386                  randconfig-012-20250509    gcc-12
i386                  randconfig-013-20250509    gcc-12
i386                  randconfig-014-20250509    gcc-12
i386                  randconfig-015-20250509    gcc-12
i386                  randconfig-016-20250509    gcc-12
i386                  randconfig-017-20250509    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250508    gcc-14.2.0
loongarch             randconfig-002-20250508    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250508    gcc-14.2.0
nios2                 randconfig-002-20250508    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    clang-18
parisc                randconfig-001-20250508    gcc-9.3.0
parisc                randconfig-002-20250508    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250508    gcc-6.5.0
powerpc               randconfig-002-20250508    clang-21
powerpc               randconfig-003-20250508    gcc-6.5.0
powerpc64             randconfig-001-20250508    clang-21
powerpc64             randconfig-002-20250508    gcc-6.5.0
powerpc64             randconfig-003-20250508    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20250508    clang-16
riscv                 randconfig-002-20250508    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250508    gcc-6.5.0
s390                  randconfig-002-20250508    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250508    gcc-14.2.0
sh                    randconfig-002-20250508    gcc-10.5.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250508    gcc-13.3.0
sparc                 randconfig-002-20250508    gcc-6.5.0
sparc64               randconfig-001-20250508    gcc-13.3.0
sparc64               randconfig-002-20250508    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250508    clang-21
um                    randconfig-002-20250508    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250509    gcc-11
x86_64      buildonly-randconfig-002-20250509    gcc-11
x86_64      buildonly-randconfig-003-20250509    clang-20
x86_64      buildonly-randconfig-003-20250509    gcc-11
x86_64      buildonly-randconfig-004-20250509    clang-20
x86_64      buildonly-randconfig-004-20250509    gcc-11
x86_64      buildonly-randconfig-005-20250509    gcc-11
x86_64      buildonly-randconfig-005-20250509    gcc-12
x86_64      buildonly-randconfig-006-20250509    gcc-11
x86_64      buildonly-randconfig-006-20250509    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250508    gcc-7.5.0
xtensa                randconfig-002-20250508    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

