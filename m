Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6822EEB28FB
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rRhqQcJQE++WTWXUhHch2KPQ+Ct7SsI9l7wtkfhIWjQ=; b=g60r2Ca7PF1KJqui7MXjRBdvC0
	DpO1T2m4mf0qyfWYzix3YLcMRtUdGGU0eJyEz2QlCz2qH45iUXMdPArKyMXNmqM24YkPvD9SRlqiM
	jg550oZ1ckn4x8flTq5LZXzCBq/RxOM3gcJsupMXgg0p1zoVUx8BBruMIpMPmrMJIIy68Fbr8q9EU
	Kft/3UdhZ0btDy81sQIkFk7ny6dmncp+huuIzLho21SAWpIOtfBKSdxXnLBCm+fC3/K1pq1ZKau5Z
	vxFWVNxEafpgkSEUVL0PklIc9jpYOGDjI1bQCsvFd5yjy0+p9dZfBpNQHJr8AndJ64sLA+Ly8643V
	Va5QBRZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voHtX-0000000B5IA-2buv;
	Fri, 06 Feb 2026 09:12:55 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voHtV-0000000B5Hk-0kS6
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 09:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770369173; x=1801905173;
  h=date:from:to:cc:subject:message-id;
  bh=1dN7ndWtQl/CghVTMEPcDuoVz6daeKEsD28Ub9B0l9k=;
  b=ZOnCh3eoVehwImwvbCy7lY10YbPMU6NLtPDvkohNwCFnwudxOEHhD4CR
   L1CLfhqEewWY7dYewpYcZTLrQ7Yxr3DgePFcLzMviOgYHdlbKNRgqweVa
   igD+CVtQrvuIO/D2X7GbukkU9haOfpz4tErhqCY33xQchn8yVXLfOZq1d
   BpwqtC/kMNTPnuUsKnE1UJERyJbNkEejSoBrJiUP47PXDPipFA2f6MsEG
   ftkzyzrgEmDBSdBpJlYM69tC6T7xBLJQffZ3t5W5f8LTSDH/QnLVn3p/I
   w4Myp7kmHc7/B3hfZ6xRe2f1JMceeMCPTCVumACcfyxgoA+PnwCZnf4XD
   g==;
X-CSE-ConnectionGUID: lLe1r8V9QMOYDWKO69iZxA==
X-CSE-MsgGUID: laDuG3JPQD+8i6zzpRqONw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82209772"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="82209772"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 01:12:52 -0800
X-CSE-ConnectionGUID: tL6I5FhUSW+ZH6YsicDG9w==
X-CSE-MsgGUID: 3nF6w+wSRQ6a1FpzXnSpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215403037"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 01:12:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voHtQ-00000000kbG-218K;
	Fri, 06 Feb 2026 09:12:48 +0000
Date: Fri, 06 Feb 2026 17:12:11 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD SUCCESS
 52a0a98549344ca20ad81a4176d68d28e3c05a5c
Message-ID: <202602061703.r7rWbpzk-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_011253_239444_DE572DF1 
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.19
branch HEAD: 52a0a98549344ca20ad81a4176d68d28e3c05a5c  nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

elapsed time: 1047m

configs tested: 221
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260206    gcc-8.5.0
arc                   randconfig-002-20260206    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         at91_dt_defconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20260206    gcc-8.5.0
arm                   randconfig-002-20260206    gcc-8.5.0
arm                   randconfig-003-20260206    gcc-8.5.0
arm                   randconfig-004-20260206    gcc-8.5.0
arm                           sunxi_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260206    gcc-13.4.0
arm64                 randconfig-002-20260206    gcc-13.4.0
arm64                 randconfig-003-20260206    gcc-13.4.0
arm64                 randconfig-004-20260206    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260206    gcc-13.4.0
csky                  randconfig-002-20260206    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260206    clang-22
hexagon               randconfig-002-20260206    clang-22
i386                             alldefconfig    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260206    clang-20
i386        buildonly-randconfig-002-20260206    clang-20
i386        buildonly-randconfig-003-20260206    clang-20
i386        buildonly-randconfig-004-20260206    clang-20
i386        buildonly-randconfig-005-20260206    clang-20
i386        buildonly-randconfig-006-20260206    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260206    gcc-14
i386                  randconfig-002-20260206    gcc-14
i386                  randconfig-003-20260206    gcc-14
i386                  randconfig-004-20260206    gcc-14
i386                  randconfig-005-20260206    gcc-14
i386                  randconfig-006-20260206    gcc-14
i386                  randconfig-007-20260206    gcc-14
i386                  randconfig-011-20260206    clang-20
i386                  randconfig-012-20260206    clang-20
i386                  randconfig-013-20260206    clang-20
i386                  randconfig-014-20260206    clang-20
i386                  randconfig-015-20260206    clang-20
i386                  randconfig-016-20260206    clang-20
i386                  randconfig-017-20260206    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260206    clang-22
loongarch             randconfig-002-20260206    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                  decstation_64_defconfig    clang-22
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip28_defconfig    gcc-15.2.0
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260206    clang-22
nios2                 randconfig-002-20260206    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260206    gcc-8.5.0
parisc                randconfig-002-20260206    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                  iss476-smp_defconfig    clang-22
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    gcc-15.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20260206    gcc-8.5.0
powerpc               randconfig-002-20260206    gcc-8.5.0
powerpc64             randconfig-001-20260206    gcc-8.5.0
powerpc64             randconfig-002-20260206    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260206    clang-22
riscv                 randconfig-002-20260206    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260206    clang-22
s390                  randconfig-002-20260206    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.2.0
sh                    randconfig-001-20260206    clang-22
sh                    randconfig-002-20260206    clang-22
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260206    gcc-12.5.0
sparc                 randconfig-002-20260206    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260206    gcc-12.5.0
sparc64               randconfig-002-20260206    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260206    gcc-12.5.0
um                    randconfig-002-20260206    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260206    gcc-14
x86_64      buildonly-randconfig-002-20260206    gcc-14
x86_64      buildonly-randconfig-003-20260206    gcc-14
x86_64      buildonly-randconfig-004-20260206    gcc-14
x86_64      buildonly-randconfig-005-20260206    gcc-14
x86_64      buildonly-randconfig-006-20260206    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260206    gcc-14
x86_64                randconfig-002-20260206    gcc-14
x86_64                randconfig-003-20260206    gcc-14
x86_64                randconfig-004-20260206    gcc-14
x86_64                randconfig-005-20260206    gcc-14
x86_64                randconfig-006-20260206    gcc-14
x86_64                randconfig-011-20260206    gcc-14
x86_64                randconfig-012-20260206    clang-20
x86_64                randconfig-012-20260206    gcc-14
x86_64                randconfig-013-20260206    gcc-14
x86_64                randconfig-014-20260206    gcc-14
x86_64                randconfig-015-20260206    gcc-14
x86_64                randconfig-016-20260206    clang-20
x86_64                randconfig-016-20260206    gcc-14
x86_64                randconfig-071-20260206    gcc-14
x86_64                randconfig-072-20260206    gcc-14
x86_64                randconfig-073-20260206    gcc-14
x86_64                randconfig-074-20260206    gcc-14
x86_64                randconfig-075-20260206    gcc-14
x86_64                randconfig-076-20260206    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260206    gcc-12.5.0
xtensa                randconfig-002-20260206    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

