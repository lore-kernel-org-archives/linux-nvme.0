Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02194FEEF24
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/4PO6RU2tTsVxQBiUV4bbIPXlwaU4f/X6FwmAfO1Uas=; b=oH/7CoQYMudorz4iKn8eOtt9WV
	8V62/Y34YfiBzQ/XdUHmKiExMG01lcVe9ES5Xj1ZHTu+FrRCqu9lKMzzQgPxX4aC3CpUmINujPOA7
	elYZyhQNn0gyEyBGP7f1yShzvXrT8IplOuGZxJhTltdA5+RSZvLP1Ov6y5mZ6zbBLEDS0sS7vE9gg
	+n2xrZ0dIfN0G85lhTtc8bktU2EZTxQUgfV/R2QQTYmP7VogzrnesAq97OR2JjVcuu0rLAXUCFSoE
	ibG//wZZaJSJ2MQNC3+VxcP4+SV3u1JLHFhFMIcho6a/WFkBgF0gdodSEAYlkmY9dD1+2JFiYWFOJ
	xU0Hqtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA4Zj-00000006N0G-3P9r;
	Tue, 07 Apr 2026 11:26:31 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA4Zg-00000006MzS-2gFL
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 11:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775561188; x=1807097188;
  h=date:from:to:cc:subject:message-id;
  bh=Ghym6z564B/WByNvBN/N3aJ1QCrM08qncp9fSR1850g=;
  b=dPQZAKuACv+3TPrBdtvY0Z2tLtVsdcbLybUQ6I94vop+s3RZnGm7L+pw
   pcPTz2GxjDYhJ4jKYRwKYefEaqGTOjo5cxlAmWOmy+wzbaRcRhzkkh/RM
   Lf+1mPxznbdb08RMM0mTjtOxLX/XTEr84Cc2Dpse4qUP5ADGOR/UVurq5
   4En8JuqTq/XEv6NRn1052SmX1c4fX77AgCm0Xn0Jf0vMYM5OaQK1aj3O+
   B1TcR6QLvPWpeT0Ba8YkGW9pzcm9U04JKICTfg7bbUAqdq1geDyG1JQWi
   4B5QcEG8l6K2WhFK2otoeFoho4+3EqH8xR7JvWSrzyCiYIdX0BBdpGUwf
   g==;
X-CSE-ConnectionGUID: ZaheIbBbTCucjKpXsIKcUQ==
X-CSE-MsgGUID: rH+oRTX+QR+jRezUUODcuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76486727"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76486727"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:26:25 -0700
X-CSE-ConnectionGUID: z4DQQegfTNy2Slf+lyqDEA==
X-CSE-MsgGUID: jKGw+U7+TGG/PzGpNYTTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="232181883"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Apr 2026 04:26:25 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wA4Za-000000000W5-0ky4;
	Tue, 07 Apr 2026 11:26:22 +0000
Date: Tue, 07 Apr 2026 19:25:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 e9b004ff83067cdf96774b45aea4b239ace99a2f
Message-ID: <202604071942.dOnzp5Ud-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_042628_768876_BB80163B 
X-CRM114-Status: UNSURE (   4.87  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.1
branch HEAD: e9b004ff83067cdf96774b45aea4b239ace99a2f  blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()

elapsed time: 777m

configs tested: 181
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260407    clang-23
arc                   randconfig-002-20260407    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-19
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260407    clang-23
arm                   randconfig-002-20260407    clang-23
arm                   randconfig-003-20260407    clang-23
arm                   randconfig-004-20260407    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260407    gcc-9.5.0
arm64                 randconfig-002-20260407    gcc-9.5.0
arm64                 randconfig-003-20260407    gcc-9.5.0
arm64                 randconfig-004-20260407    gcc-9.5.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260407    gcc-9.5.0
csky                  randconfig-002-20260407    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260407    clang-23
hexagon               randconfig-002-20260407    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260407    clang-20
i386        buildonly-randconfig-002-20260407    clang-20
i386        buildonly-randconfig-003-20260407    clang-20
i386        buildonly-randconfig-004-20260407    clang-20
i386        buildonly-randconfig-005-20260407    clang-20
i386        buildonly-randconfig-006-20260407    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260407    gcc-14
i386                  randconfig-002-20260407    gcc-14
i386                  randconfig-003-20260407    gcc-14
i386                  randconfig-004-20260407    gcc-14
i386                  randconfig-005-20260407    gcc-14
i386                  randconfig-006-20260407    gcc-14
i386                  randconfig-007-20260407    gcc-14
i386                  randconfig-011-20260407    clang-20
i386                  randconfig-012-20260407    clang-20
i386                  randconfig-013-20260407    clang-20
i386                  randconfig-014-20260407    clang-20
i386                  randconfig-015-20260407    clang-20
i386                  randconfig-016-20260407    clang-20
i386                  randconfig-017-20260407    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260407    clang-23
loongarch             randconfig-002-20260407    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260407    clang-23
nios2                 randconfig-002-20260407    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260407    gcc-10.5.0
parisc                randconfig-002-20260407    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc               randconfig-001-20260407    gcc-10.5.0
powerpc               randconfig-002-20260407    gcc-10.5.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260407    gcc-10.5.0
powerpc64             randconfig-002-20260407    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260407    gcc-14.3.0
riscv                 randconfig-002-20260407    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260407    gcc-14.3.0
s390                  randconfig-002-20260407    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260407    gcc-14.3.0
sh                    randconfig-002-20260407    gcc-14.3.0
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260407    gcc-12
sparc                 randconfig-002-20260407    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260407    gcc-12
sparc64               randconfig-002-20260407    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260407    gcc-12
um                    randconfig-002-20260407    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260407    gcc-14
x86_64      buildonly-randconfig-002-20260407    gcc-14
x86_64      buildonly-randconfig-003-20260407    gcc-14
x86_64      buildonly-randconfig-004-20260407    gcc-14
x86_64      buildonly-randconfig-005-20260407    gcc-14
x86_64      buildonly-randconfig-006-20260407    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260407    gcc-14
x86_64                randconfig-002-20260407    gcc-14
x86_64                randconfig-003-20260407    gcc-14
x86_64                randconfig-004-20260407    gcc-14
x86_64                randconfig-005-20260407    gcc-14
x86_64                randconfig-006-20260407    gcc-14
x86_64                randconfig-011-20260407    clang-20
x86_64                randconfig-012-20260407    clang-20
x86_64                randconfig-013-20260407    clang-20
x86_64                randconfig-014-20260407    clang-20
x86_64                randconfig-015-20260407    clang-20
x86_64                randconfig-016-20260407    clang-20
x86_64                randconfig-071-20260407    clang-20
x86_64                randconfig-072-20260407    clang-20
x86_64                randconfig-073-20260407    clang-20
x86_64                randconfig-074-20260407    clang-20
x86_64                randconfig-075-20260407    clang-20
x86_64                randconfig-076-20260407    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260407    gcc-12
xtensa                randconfig-002-20260407    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

