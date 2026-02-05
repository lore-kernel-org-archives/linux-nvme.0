Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A145CE91297
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6eiLqrIfxUySk2u3HOKah9qy6bXj/62jtRtpobz9Rnc=; b=Ehx2AkiezAcT7Q6cKWg3lkDa+w
	J8q1W2Pw/jecnuvTtZsQNnMcwNV67cj1d4fMj518MJZ8pTlzAq9Zkd6LJyVSVqgJT2AZZh93PvwCv
	vfnUhtnzEXjcMZa2ko4u9qGzBajTYtExSsFTpRxgtBF1r+TGxYfff05yDQ4a7X7a6s2rKURKkCnjZ
	j56HtDnTv6VxyJ4xFLnZwb/NY18Rjqnt2YMlNB3hQwirTinK92pJjXVVWIr5e6yz0HX9OhGE896i0
	4y8AbXwqh0bFhpa9F2kvbK+BP0P91j9cFon0NKn7s9v1qJ4khnZrE11ZW7CiUZX6cP0/t7EdG3XK9
	sLTpkK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo0Tx-0000000A2Ax-3eAR;
	Thu, 05 Feb 2026 14:37:21 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo0Tu-0000000A2A4-0BKs
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 14:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770302238; x=1801838238;
  h=date:from:to:cc:subject:message-id;
  bh=T7HOq9h2INurvdrGtUBco1yihoHiBCoN9+gh0ppmCSU=;
  b=RnY8Wxdg6fsiomW8L/0QVS1ckZA6Cab/qiw5sh+mx/vyRwO6hDyGl4vB
   gL2eSkiuKS+tbbfRem+fE5zrICkoN6n+tt0Dzd23MKq0CdIfPAcVEbunT
   OG91tJikTREq4vc8bh/6wYXkM0rrl4VSccxmIfscoIW6L59tqZC2LzsJ0
   6c2ebQ+38u5rfkvw+oRlbr+GmPqzgXQbm1zsvb2/H8pZfbfr/QYu8zTUp
   TK+BJs9l9RVW7k3oeAIv0fp+lCCO4AMVD+Ze3zNtcE1kKdq97OHD2defI
   Kfyf9E2QNmBdn6+mWR+jtqFFwxVO74UJi7So33HaDrDwYnROx6ljcIZJL
   A==;
X-CSE-ConnectionGUID: RVLX0Q0BTY6YgS4Y2HtVzw==
X-CSE-MsgGUID: y6umKhNXT3SJHXG5ftMGeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82871614"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82871614"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 06:37:16 -0800
X-CSE-ConnectionGUID: eOUxMf56RkyhHtXk2BsHsg==
X-CSE-MsgGUID: RsBI+yaJQOmDTi+SIWLeFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214709698"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 06:37:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo0Tk-00000000jsi-3w1g;
	Thu, 05 Feb 2026 14:37:08 +0000
Date: Thu, 05 Feb 2026 22:36:34 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.0] BUILD SUCCESS
 d6f88a05d0876dc18493c0098ced3caeede62b07
Message-ID: <202602052226.spmwNIqP-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_063719_031950_CEE50511 
X-CRM114-Status: UNSURE (   5.18  )
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
branch HEAD: d6f88a05d0876dc18493c0098ced3caeede62b07  nvme: add support for dynamic quirk configuration via module parameter

elapsed time: 733m

configs tested: 276
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    clang-22
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-16
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260205    clang-22
arm                   randconfig-001-20260205    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-003-20260205    clang-22
arm                   randconfig-003-20260205    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm64                            alldefconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260205    gcc-10.5.0
arm64                 randconfig-002-20260205    gcc-10.5.0
arm64                 randconfig-003-20260205    gcc-10.5.0
arm64                 randconfig-004-20260205    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260205    gcc-10.5.0
csky                  randconfig-002-20260205    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260205    clang-22
hexagon               randconfig-001-20260205    gcc-15.2.0
hexagon               randconfig-002-20260205    clang-22
hexagon               randconfig-002-20260205    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260205    gcc-13
i386        buildonly-randconfig-001-20260205    gcc-14
i386        buildonly-randconfig-002-20260205    clang-20
i386        buildonly-randconfig-002-20260205    gcc-14
i386        buildonly-randconfig-003-20260205    clang-20
i386        buildonly-randconfig-003-20260205    gcc-14
i386        buildonly-randconfig-004-20260205    clang-20
i386        buildonly-randconfig-004-20260205    gcc-14
i386        buildonly-randconfig-005-20260205    gcc-14
i386        buildonly-randconfig-006-20260205    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260205    gcc-13
i386                  randconfig-001-20260205    gcc-14
i386                  randconfig-002-20260205    clang-20
i386                  randconfig-002-20260205    gcc-13
i386                  randconfig-003-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-14
i386                  randconfig-005-20260205    clang-20
i386                  randconfig-005-20260205    gcc-13
i386                  randconfig-006-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-14
i386                  randconfig-011-20260205    clang-20
i386                  randconfig-011-20260205    gcc-14
i386                  randconfig-012-20260205    clang-20
i386                  randconfig-013-20260205    clang-20
i386                  randconfig-013-20260205    gcc-14
i386                  randconfig-014-20260205    clang-20
i386                  randconfig-015-20260205    clang-20
i386                  randconfig-015-20260205    gcc-14
i386                  randconfig-016-20260205    clang-20
i386                  randconfig-017-20260205    clang-20
i386                  randconfig-017-20260205    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260205    clang-22
loongarch             randconfig-001-20260205    gcc-15.2.0
loongarch             randconfig-002-20260205    gcc-15.2.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-14
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-14
mips                         db1xxx_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           ip22_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-14
mips                          malta_defconfig    gcc-14
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                  maltasmvp_eva_defconfig    clang-18
mips                        maltaup_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260205    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-15.2.0
nios2                 randconfig-002-20260205    gcc-11.5.0
nios2                 randconfig-002-20260205    gcc-15.2.0
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
parisc                randconfig-001-20260205    gcc-9.5.0
parisc                randconfig-002-20260205    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    clang-18
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                       eiger_defconfig    clang-22
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-14
powerpc                       holly_defconfig    clang-18
powerpc                   lite5200b_defconfig    gcc-14
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-18
powerpc               randconfig-001-20260205    gcc-15.2.0
powerpc               randconfig-001-20260205    gcc-9.5.0
powerpc               randconfig-002-20260205    clang-16
powerpc               randconfig-002-20260205    gcc-9.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20260205    clang-22
powerpc64             randconfig-001-20260205    gcc-9.5.0
powerpc64             randconfig-002-20260205    clang-22
powerpc64             randconfig-002-20260205    gcc-9.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-002-20260205    clang-19
riscv                 randconfig-002-20260205    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260205    clang-18
s390                  randconfig-001-20260205    clang-19
s390                  randconfig-002-20260205    clang-19
s390                  randconfig-002-20260205    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260205    clang-19
sh                    randconfig-001-20260205    gcc-15.2.0
sh                    randconfig-002-20260205    clang-19
sh                    randconfig-002-20260205    gcc-10.5.0
sh                          rsk7201_defconfig    clang-18
sh                          rsk7264_defconfig    clang-22
sh                      rts7751r2d1_defconfig    clang-22
sh                           se7343_defconfig    clang-22
sh                           se7619_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    clang-18
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260205    gcc-12.5.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260205    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260205    gcc-12.5.0
um                    randconfig-002-20260205    gcc-12.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260205    gcc-14
x86_64      buildonly-randconfig-002-20260205    gcc-14
x86_64      buildonly-randconfig-003-20260205    gcc-14
x86_64      buildonly-randconfig-004-20260205    gcc-14
x86_64      buildonly-randconfig-005-20260205    gcc-14
x86_64      buildonly-randconfig-006-20260205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260205    clang-20
x86_64                randconfig-001-20260205    gcc-12
x86_64                randconfig-002-20260205    clang-20
x86_64                randconfig-003-20260205    clang-20
x86_64                randconfig-004-20260205    clang-20
x86_64                randconfig-005-20260205    clang-20
x86_64                randconfig-005-20260205    gcc-14
x86_64                randconfig-006-20260205    clang-20
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-012-20260205    clang-20
x86_64                randconfig-012-20260205    gcc-14
x86_64                randconfig-013-20260205    clang-20
x86_64                randconfig-013-20260205    gcc-14
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-015-20260205    clang-20
x86_64                randconfig-015-20260205    gcc-14
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-071-20260205    clang-20
x86_64                randconfig-072-20260205    clang-20
x86_64                randconfig-073-20260205    clang-20
x86_64                randconfig-074-20260205    clang-20
x86_64                randconfig-075-20260205    clang-20
x86_64                randconfig-076-20260205    clang-20
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
xtensa                randconfig-001-20260205    gcc-12.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

