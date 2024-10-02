Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA18CF6D5F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o9rsYasBw9QxaWZrRFDyzfejzTjRwktJcuN0JllLqiY=; b=VkeKGy23Pe4IGEaMwWLC7KZeah
	cI1wBO6wkJKOZ0cTKMcZB/PTr/VPJm3mEHXvhKOw9AA8FVuEtxQjN8p7cVMOV5N7qT3bKWk1VnnOc
	vfGv1n+/y5DLyMGH7f0NlNT7r5wz60OI1AJfhAFs0k7ZSaGip+Vh3pSWqnszp4zyuAo0On1NWxFM9
	WCMQKmL1OTWYVoO70xPNGp8ZXkEWlASFti2y9t/fpf3IWSqv5CYJ4SL8xNrprq22hl2jJZBW6wbqQ
	Zyiy5GKfZ+VWXxhIumNrQuSWZWJpqXEbracZ5Mzb1aIotXDkoWKTeJfQ/0E/p4YM4/lzpiDxfPP8U
	v+F/iHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw2sg-000000071yd-3yW2;
	Wed, 02 Oct 2024 17:11:18 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw2rr-000000071tN-1wP6
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 17:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727889027; x=1759425027;
  h=date:from:to:cc:subject:message-id;
  bh=VzBCXMVouXcJSQ/ZlyGIyD9j9UwYYA/j+Bizj0NaZyk=;
  b=TAd/YhgIXOO7Cpr08mFE0Jv37vx4oCVJe/NtJUGkyxu8194eAaR+VLVZ
   WkEOeGTXzQBGFIOown4ujdni7qpFnvvVMWryP/YQRs71tp04ThqMQtGM9
   pQq4mKq8/Ib+dTllm+01iRO4eQHWHdHGH5lYOKbcWmYzl81ZOAPgYuXzK
   4BUAgQ691WfQHpjWssCZ1ZrhX9lnUR4oXkq/hMKpntM87MAM84RNDsncT
   2SbDtFF9FmPeSSUm1mjSww79iTetS0orOBg45PyMq9jxbyBfpNsCHaOzx
   9tBn75eA5vcOsiI6xn2GQiT5bqJTd0Y4z8or+VmHBUs2LStRyiFozKKjm
   A==;
X-CSE-ConnectionGUID: r7P+2v2BRwKsFTuUgodkPA==
X-CSE-MsgGUID: pSI2o4aFSm2bWo+Q65/cAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26570746"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26570746"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:10:27 -0700
X-CSE-ConnectionGUID: +8fnfzd2SaewTgxYaUCLiA==
X-CSE-MsgGUID: zWZJ4KjKRoy4aJM21ZD9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="74489422"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Oct 2024 10:10:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw2rn-000UHr-0F;
	Wed, 02 Oct 2024 17:10:23 +0000
Date: Thu, 03 Oct 2024 01:10:14 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 e38dad438fc08162e20c600ae899e9e60688f72e
Message-ID: <202410030103.RaLtBcYm-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_101027_543596_1272352D 
X-CRM114-Status: UNSURE (   5.41  )
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
branch HEAD: e38dad438fc08162e20c600ae899e9e60688f72e  nvmet-passthru: clear EUID/NGUID/UUID while using loop target

elapsed time: 1170m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241002    gcc-13.2.0
arc                   randconfig-002-20241002    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                   randconfig-001-20241002    gcc-14.1.0
arm                   randconfig-002-20241002    clang-20
arm                   randconfig-003-20241002    clang-14
arm                   randconfig-004-20241002    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241002    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241002    clang-18
i386        buildonly-randconfig-002-20241002    clang-18
i386        buildonly-randconfig-003-20241002    clang-18
i386        buildonly-randconfig-003-20241002    gcc-12
i386        buildonly-randconfig-004-20241002    clang-18
i386        buildonly-randconfig-004-20241002    gcc-12
i386        buildonly-randconfig-005-20241002    clang-18
i386        buildonly-randconfig-005-20241002    gcc-12
i386        buildonly-randconfig-006-20241002    clang-18
i386        buildonly-randconfig-006-20241002    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241002    clang-18
i386                  randconfig-001-20241002    gcc-12
i386                  randconfig-002-20241002    clang-18
i386                  randconfig-002-20241002    gcc-12
i386                  randconfig-003-20241002    clang-18
i386                  randconfig-004-20241002    clang-18
i386                  randconfig-005-20241002    clang-18
i386                  randconfig-006-20241002    clang-18
i386                  randconfig-006-20241002    gcc-12
i386                  randconfig-011-20241002    clang-18
i386                  randconfig-012-20241002    clang-18
i386                  randconfig-013-20241002    clang-18
i386                  randconfig-013-20241002    gcc-12
i386                  randconfig-014-20241002    clang-18
i386                  randconfig-015-20241002    clang-18
i386                  randconfig-016-20241002    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                          r7785rp_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

