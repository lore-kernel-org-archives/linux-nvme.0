Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F73FCC9DA
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GFhmy4FzlP+tNglqSVdDgQM/MOP2fy8y4UNGEkabZAE=; b=ZMlJaifb8Lnd7Xe7LStpf/qxCy
	t49D2NnstMVYqvjZSpiqu9Fsv1q4fYWJvN/q4weJoXlAg/msNQ2IslpdnYZzt8nBJUrjcRERaCA+w
	Vma6gTbgDjMZ1pviE84I5FLdfB35/B+NP6fXtUieI43ypLX1UMODz7oV7NzPHZtpIE31j+uviiwZ3
	rbih4LGdJ5n0iq2CyX5cQBjXWPl47q1H3nAr06j9GXSJVD3Da+6f/d92bptyU8mRndC/GV613psDX
	a1bsk8TRx+TcfYh/2msQh4RAfULJe+TeQ34UwcR428lBYolp+bNeCJKDQfYAAmBI/3nuzUbiqyxhB
	VLcW4MLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzrqo-00000008sAX-1stG;
	Tue, 10 Mar 2026 07:49:58 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzrqj-00000008s9o-1oeW
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 07:49:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773128994; x=1804664994;
  h=date:from:to:cc:subject:message-id;
  bh=JUa45Js/famzfZqORmm+bqu+0Uw//H2VgrsgNoOHvH8=;
  b=ZkpeLyCinmXHWdXMYpu1ssTBapKvzAMuNnA1gDs9+g2AI3V0DxLXOm6B
   S8dj4MbwNcCaAPhEA3Yy6Tcg/ViDJQ3//q8P3Sx+Cl4I0lBbqRWDYp2wk
   rWlhHk64HimnzkLrE0gqcgWYjMR+EtaPG5ferJ3DRTu5qICfZ87Gt3a3o
   xoeObitIoRR9VKKPVeLJrVO6RSYEOdO+MPPIqxSuWeLvwYBmoYzP9L4Of
   ohlC9YM2awtBeadkcNIZ19CZy68XQdE95rfZE2cVOVhgblsNjo2tBZzct
   9lAwtJb3LFM7fZoVmqU/B4bFr7HTPJRERO+5b4wojMP6eTGKZ2nm6gbw/
   w==;
X-CSE-ConnectionGUID: zUeOVVjnShK/Ndehai8b8w==
X-CSE-MsgGUID: H/3EdqEPRB+j5LFrXvoVZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84803009"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="84803009"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:49:47 -0700
X-CSE-ConnectionGUID: 0nEENWfFRH6MbSJRLIJbWw==
X-CSE-MsgGUID: 4wYPDsOGQfqRwsXr/QjfrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="219980759"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2026 00:49:45 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzrqY-000000001XQ-0lPZ;
	Tue, 10 Mar 2026 07:49:42 +0000
Date: Tue, 10 Mar 2026 15:48:57 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 c8414ea09f238d924a7ed04049c1893a188c0ee3
Message-ID: <202603101551.Om2xobNf-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_004953_504886_1C896D2B 
X-CRM114-Status: UNSURE (   4.72  )
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
branch HEAD: c8414ea09f238d924a7ed04049c1893a188c0ee3  nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C

elapsed time: 994m

configs tested: 245
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260310    gcc-8.5.0
arc                   randconfig-001-20260310    gcc-9.5.0
arc                   randconfig-002-20260310    gcc-15.2.0
arc                   randconfig-002-20260310    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                   randconfig-001-20260310    clang-23
arm                   randconfig-001-20260310    gcc-8.5.0
arm                   randconfig-002-20260310    gcc-12.5.0
arm                   randconfig-002-20260310    gcc-8.5.0
arm                   randconfig-003-20260310    gcc-10.5.0
arm                   randconfig-003-20260310    gcc-8.5.0
arm                   randconfig-004-20260310    gcc-8.5.0
arm                           sama7_defconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260310    clang-16
arm64                 randconfig-001-20260310    gcc-11.5.0
arm64                 randconfig-002-20260310    gcc-11.5.0
arm64                 randconfig-002-20260310    gcc-13.4.0
arm64                 randconfig-003-20260310    gcc-11.5.0
arm64                 randconfig-004-20260310    gcc-11.5.0
arm64                 randconfig-004-20260310    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260310    gcc-11.5.0
csky                  randconfig-001-20260310    gcc-15.2.0
csky                  randconfig-002-20260310    gcc-11.5.0
csky                  randconfig-002-20260310    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260310    gcc-11.5.0
hexagon               randconfig-002-20260310    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260310    clang-20
i386        buildonly-randconfig-001-20260310    gcc-14
i386        buildonly-randconfig-002-20260310    clang-20
i386        buildonly-randconfig-003-20260310    clang-20
i386        buildonly-randconfig-003-20260310    gcc-14
i386        buildonly-randconfig-004-20260310    clang-20
i386        buildonly-randconfig-004-20260310    gcc-14
i386        buildonly-randconfig-005-20260310    clang-20
i386        buildonly-randconfig-005-20260310    gcc-14
i386        buildonly-randconfig-006-20260310    clang-20
i386        buildonly-randconfig-006-20260310    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260310    clang-20
i386                  randconfig-001-20260310    gcc-14
i386                  randconfig-002-20260310    clang-20
i386                  randconfig-002-20260310    gcc-14
i386                  randconfig-003-20260310    clang-20
i386                  randconfig-004-20260310    clang-20
i386                  randconfig-005-20260310    clang-20
i386                  randconfig-005-20260310    gcc-14
i386                  randconfig-006-20260310    clang-20
i386                  randconfig-006-20260310    gcc-14
i386                  randconfig-007-20260310    clang-20
i386                  randconfig-007-20260310    gcc-12
i386                  randconfig-011-20260310    clang-20
i386                  randconfig-011-20260310    gcc-14
i386                  randconfig-012-20260310    clang-20
i386                  randconfig-013-20260310    clang-20
i386                  randconfig-013-20260310    gcc-14
i386                  randconfig-014-20260310    clang-20
i386                  randconfig-015-20260310    clang-20
i386                  randconfig-016-20260310    clang-20
i386                  randconfig-016-20260310    gcc-14
i386                  randconfig-017-20260310    clang-20
i386                  randconfig-017-20260310    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260310    gcc-11.5.0
loongarch             randconfig-002-20260310    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260310    gcc-11.5.0
nios2                 randconfig-002-20260310    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260310    gcc-14.3.0
parisc                randconfig-001-20260310    gcc-15.2.0
parisc                randconfig-002-20260310    gcc-13.4.0
parisc                randconfig-002-20260310    gcc-15.2.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260310    gcc-15.2.0
powerpc               randconfig-001-20260310    gcc-9.5.0
powerpc               randconfig-002-20260310    clang-23
powerpc               randconfig-002-20260310    gcc-15.2.0
powerpc64             randconfig-001-20260310    gcc-15.2.0
powerpc64             randconfig-002-20260310    gcc-15.2.0
powerpc64             randconfig-002-20260310    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260310    clang-19
riscv                 randconfig-001-20260310    gcc-15.2.0
riscv                 randconfig-002-20260310    gcc-15.2.0
riscv                 randconfig-002-20260310    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260310    gcc-15.2.0
s390                  randconfig-001-20260310    gcc-9.5.0
s390                  randconfig-002-20260310    clang-19
s390                  randconfig-002-20260310    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260310    gcc-15.2.0
sh                    randconfig-002-20260310    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260310    gcc-12.5.0
sparc                 randconfig-001-20260310    gcc-15.2.0
sparc                 randconfig-002-20260310    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260310    clang-20
sparc64               randconfig-001-20260310    gcc-12.5.0
sparc64               randconfig-002-20260310    clang-23
sparc64               randconfig-002-20260310    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260310    gcc-12.5.0
um                    randconfig-001-20260310    gcc-14
um                    randconfig-002-20260310    clang-23
um                    randconfig-002-20260310    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260310    gcc-14
x86_64      buildonly-randconfig-002-20260310    gcc-14
x86_64      buildonly-randconfig-003-20260310    gcc-12
x86_64      buildonly-randconfig-003-20260310    gcc-14
x86_64      buildonly-randconfig-004-20260310    gcc-12
x86_64      buildonly-randconfig-004-20260310    gcc-14
x86_64      buildonly-randconfig-005-20260310    gcc-14
x86_64      buildonly-randconfig-006-20260310    clang-20
x86_64      buildonly-randconfig-006-20260310    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260310    clang-20
x86_64                randconfig-001-20260310    gcc-14
x86_64                randconfig-002-20260310    clang-20
x86_64                randconfig-003-20260310    clang-20
x86_64                randconfig-004-20260310    clang-20
x86_64                randconfig-005-20260310    clang-20
x86_64                randconfig-006-20260310    clang-20
x86_64                randconfig-006-20260310    gcc-14
x86_64                randconfig-011-20260310    clang-20
x86_64                randconfig-012-20260310    clang-20
x86_64                randconfig-013-20260310    clang-20
x86_64                randconfig-014-20260310    clang-20
x86_64                randconfig-015-20260310    clang-20
x86_64                randconfig-016-20260310    clang-20
x86_64                randconfig-071-20260310    clang-20
x86_64                randconfig-072-20260310    clang-20
x86_64                randconfig-073-20260310    clang-20
x86_64                randconfig-074-20260310    clang-20
x86_64                randconfig-074-20260310    gcc-14
x86_64                randconfig-075-20260310    clang-20
x86_64                randconfig-075-20260310    gcc-14
x86_64                randconfig-076-20260310    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260310    gcc-12.5.0
xtensa                randconfig-001-20260310    gcc-15.2.0
xtensa                randconfig-002-20260310    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

