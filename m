Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C88DEE6B76
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 05:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hpx97bctXZQiGBarF+UDIb3ib1PnlBkkF4PLzIrfb90=; b=yFLom8o/gCoBTITEdFse2tDQ+C
	BROCh8w/zc7sfUdmKQW2bGfcoIq0oA+nTB+vDDqkZwCfT+fkmTGXYvtuL9rdssPXFPj1LymV/DhVS
	UatUcLsOHchrqZMDIo8fKohLcwIphKb97neqA9TBmo2r6xFZMmGJ37nLwrfRVGSZQsLEZs/vOC6vP
	mLVBYukLn5vasNnTzPr6D6s7QoAiSuQOYworUHV4o4yZdyuoU6sYOMwNFd4Ra3SZH3Gk8WmX09QJK
	0qn9j2Dh3eoX4Ci964ZEZEoYW9XTixWBw4nAkDueGFIOnH9jkR+PExadVYmSnceGseiFelHT6K+r8
	U9jLRxbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voap8-0000000C9H7-3QAi;
	Sat, 07 Feb 2026 05:25:38 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voap5-0000000C9Go-394N
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 05:25:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770441936; x=1801977936;
  h=date:from:to:cc:subject:message-id;
  bh=IwZPaQ7YkCqsau+n68qTkU8K9voLPboF2KZQLIhS2H8=;
  b=iKeCI4L5BGQMHch/VvsyvwnfrcKs9Tg/dYGrzDgGWqdfJir0mDgqQQPh
   HDL1LwVUonXg0TwWVngP2j+CtyJ486T+mCQ812qFhYnGGwO8fXRlfmEjj
   NeCMFZhDyUyzl2ouOat2sA321J3o+TveKQ2wYE1dV77m1r1jl4pLhtNxG
   uiWFWyutkUwpojLRlDaZPtyeaNT7ZRn5hRprSIkL/ulxPxykRGoPqTCs6
   diMJXkZnip1fjty49YDIWkOhs9SdRMH9Qle3kSzyex4Stg4jTku2Jb9JR
   UOrD+n8IWeR34Ozuqz2axdOnoBcXzcqIcrP/Vlw4gv37QiZjKTsY4apyq
   Q==;
X-CSE-ConnectionGUID: DYVh0LsiR6aAn5XuabGa+w==
X-CSE-MsgGUID: rgKj2oc7SNaacbFabuTHQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="74245097"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="74245097"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 21:25:32 -0800
X-CSE-ConnectionGUID: FgUmBtxVQIGqPcxq/FrvGA==
X-CSE-MsgGUID: qtZlhw4NSRW9ecX5cCP4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="215231882"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Feb 2026 21:25:31 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voaox-00000000lPY-3xQL;
	Sat, 07 Feb 2026 05:25:27 +0000
Date: Sat, 07 Feb 2026 13:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.0] BUILD SUCCESS
 3ddfbfbc78ac1d3d9e95098fb6a32b57b8a0dcae
Message-ID: <202602071358.qDWqNxkB-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_212535_867948_E23790EA 
X-CRM114-Status: UNSURE (   4.56  )
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
branch HEAD: 3ddfbfbc78ac1d3d9e95098fb6a32b57b8a0dcae  nvme: correct comment about nvme_ns_remove()

elapsed time: 801m

configs tested: 212
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20260207    gcc-8.5.0
arc                   randconfig-002-20260207    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    gcc-15.2.0
arm                   randconfig-001-20260207    gcc-8.5.0
arm                   randconfig-002-20260207    gcc-8.5.0
arm                   randconfig-003-20260207    gcc-8.5.0
arm                   randconfig-004-20260207    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260207    gcc-15.2.0
arm64                 randconfig-002-20260207    gcc-15.2.0
arm64                 randconfig-003-20260207    gcc-15.2.0
arm64                 randconfig-004-20260207    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260207    gcc-15.2.0
csky                  randconfig-002-20260207    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260207    clang-22
hexagon               randconfig-002-20260207    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260207    clang-20
i386        buildonly-randconfig-002-20260207    clang-20
i386        buildonly-randconfig-003-20260207    clang-20
i386        buildonly-randconfig-004-20260207    clang-20
i386        buildonly-randconfig-005-20260207    clang-20
i386        buildonly-randconfig-006-20260207    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260207    clang-20
i386                  randconfig-002-20260207    clang-20
i386                  randconfig-003-20260207    clang-20
i386                  randconfig-004-20260207    clang-20
i386                  randconfig-005-20260207    clang-20
i386                  randconfig-006-20260207    clang-20
i386                  randconfig-007-20260207    clang-20
i386                  randconfig-011-20260207    clang-20
i386                  randconfig-012-20260207    clang-20
i386                  randconfig-013-20260207    clang-20
i386                  randconfig-014-20260207    clang-20
i386                  randconfig-015-20260207    clang-20
i386                  randconfig-016-20260207    clang-20
i386                  randconfig-017-20260207    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260207    clang-22
loongarch             randconfig-002-20260207    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    clang-22
m68k                          amiga_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                          eyeq6_defconfig    clang-22
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260207    clang-22
nios2                 randconfig-002-20260207    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260207    gcc-14.3.0
parisc                randconfig-002-20260207    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                     mpc5200_defconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260207    gcc-14.3.0
powerpc               randconfig-002-20260207    gcc-14.3.0
powerpc64             randconfig-001-20260207    gcc-14.3.0
powerpc64             randconfig-002-20260207    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260207    clang-18
riscv                 randconfig-002-20260207    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260207    clang-18
s390                  randconfig-002-20260207    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260207    clang-18
sh                    randconfig-002-20260207    clang-18
sh                          rsk7203_defconfig    clang-22
sh                           se7712_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260207    gcc-15.2.0
sparc                 randconfig-002-20260207    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260207    gcc-15.2.0
sparc64               randconfig-002-20260207    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260207    gcc-15.2.0
um                    randconfig-002-20260207    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260207    gcc-14
x86_64      buildonly-randconfig-002-20260207    gcc-14
x86_64      buildonly-randconfig-003-20260207    gcc-14
x86_64      buildonly-randconfig-004-20260207    gcc-14
x86_64      buildonly-randconfig-005-20260207    gcc-14
x86_64      buildonly-randconfig-006-20260207    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260207    clang-20
x86_64                randconfig-002-20260207    clang-20
x86_64                randconfig-003-20260207    clang-20
x86_64                randconfig-004-20260207    clang-20
x86_64                randconfig-005-20260207    clang-20
x86_64                randconfig-006-20260207    clang-20
x86_64                randconfig-011-20260207    gcc-14
x86_64                randconfig-012-20260207    gcc-14
x86_64                randconfig-013-20260207    gcc-14
x86_64                randconfig-014-20260207    gcc-14
x86_64                randconfig-015-20260207    gcc-14
x86_64                randconfig-016-20260207    gcc-14
x86_64                randconfig-071-20260207    gcc-14
x86_64                randconfig-072-20260207    gcc-14
x86_64                randconfig-073-20260207    gcc-14
x86_64                randconfig-074-20260207    gcc-14
x86_64                randconfig-075-20260207    gcc-14
x86_64                randconfig-076-20260207    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260207    gcc-15.2.0
xtensa                randconfig-002-20260207    gcc-15.2.0
xtensa                    smp_lx200_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

