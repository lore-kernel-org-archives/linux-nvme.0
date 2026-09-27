Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC50CA5FA2
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=si9EfvW8NtSkxhLJH1e26sIC3Ng/NgDfcj950Jv2QHQ=; b=XX0JQPPK4vTYzVCRoA+ULqkq79
	AEfG+I5CbV3KA17qzTcFD/sx5V0FDROaFf7LXjftU75WRKqydVJqJyP4kdtX4B/i0HrhTIs5rehvU
	SHFlmpHx1JxRylK82gcWBcxhN4GWcQFw/Epl//87AN5T4CGUc3UPJEGaT0vzHFAMB8kcDWj3WCUQf
	dBztjrhJ91T5Un4Tr4nX/q2vc4Rzj2ae3oHJLg/x++DZ6FNbBfd6WROhq0czx8nANTPU3A5Fl/xYz
	4CiPnt9n6ZB/PVo9c7eSa1mIvdVn/+uUheZg1WR1Q608kzSAy0oYoCIUZARBgdDJa9NE6oKSG9/SP
	P376Hlag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAyks-0000000H2bf-0eXl;
	Sun, 27 Sep 2026 23:58:02 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAykq-0000000H2bK-2JKj
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 23:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790553480; x=1822089480;
  h=date:from:to:cc:subject:message-id;
  bh=RSplwbMTxxh8tMipEBs3yhCp7vdL0fwidU0rHwNGAP4=;
  b=kz73JIpHO8vkcKOUaVfIHMJ4o/N5iwKuiXxGoAh2kafMCeJn6uqNr5nu
   DORAcuFjFWHUEezQuDEXsgRlcR2s5zAaY9bGgN9nVdDIdD7BxdUBLEoPn
   7GoDDZH0VzO6hSVCF/fRxeMr5sKkmNxECFstsgsfVo12IQffWAJNJdLUf
   U6BqOgd5MwFFm3j0XQCjOMx4tTGT6gsdaE5CQHzxageNXck4xbj2zkH3p
   6sY7GxA8ABYQoqi+Bgf++zEJOabbZWWHr+1MuiqpjbTR7sQEzNKdRw5Ti
   i9wwVxRgn29cl1/O1p2TgefMK2EveoLwLo02gIxCa9qrIhuHu+IJuMTSr
   w==;
X-CSE-ConnectionGUID: rk2AXjKPTx2ApT38MGqShw==
X-CSE-MsgGUID: J0ZJsA9mQF6jtMhmuOfUAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="78811504"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="78811504"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 16:58:00 -0700
X-CSE-ConnectionGUID: D6NLqIG1TO2J7X6ggaBBMg==
X-CSE-MsgGUID: XZSVX4CETZihrCSRE9mVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="302838776"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Sep 2026 16:57:58 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xAykm-00000000NHa-1POs;
	Sun, 27 Sep 2026 23:57:56 +0000
Date: Mon, 28 Sep 2026 07:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.4] BUILD SUCCESS
 2ee54f01f07c0307deaf90ca8691a4643ae0357b
Message-ID: <202609280701.p0ehsW9J-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_165800_633256_485032CF 
X-CRM114-Status: UNSURE (   4.91  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.4
branch HEAD: 2ee54f01f07c0307deaf90ca8691a4643ae0357b  nvme: apple: add t8132 (M4) ANS2 NVMe support

elapsed time: 2370m

configs tested: 253
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    clang-24
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1000-20260928    clang-24
arc                   randconfig-1001-20260927    gcc-11.5.0
arc                   randconfig-1001-20260928    clang-24
arc                            tb10x_defconfig    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1000-20260928    clang-24
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1001-20260928    clang-24
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1002-20260928    clang-24
arm                   randconfig-1003-20260927    gcc-11.5.0
arm                   randconfig-1003-20260928    clang-24
arm                           sp7021_defconfig    gcc-11.5.0
arm                            tegra_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1000-20260928    gcc-15.2.0
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1001-20260928    gcc-15.2.0
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1002-20260928    gcc-15.2.0
arm64                 randconfig-1003-20260927    clang-17
arm64                 randconfig-1003-20260928    gcc-15.2.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1000-20260928    gcc-15.2.0
csky                  randconfig-1001-20260927    clang-17
csky                  randconfig-1001-20260928    gcc-15.2.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1000-20260928    gcc-8.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260928    gcc-8.5.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1000-20260928    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1001-20260928    clang-22
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1002-20260928    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1003-20260928    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1004-20260928    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386        buildonly-randconfig-1005-20260928    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1000-20260928    gcc-14
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1001-20260928    gcc-14
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1002-20260928    gcc-14
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1003-20260928    gcc-14
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1004-20260928    gcc-14
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1005-20260928    gcc-14
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1006-20260928    gcc-14
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1007-20260928    clang-22
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1008-20260928    clang-22
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1009-20260928    clang-22
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1010-20260928    clang-22
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1011-20260928    clang-22
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1012-20260928    clang-22
i386                  randconfig-1013-20260927    gcc-14
i386                  randconfig-1013-20260928    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1000-20260928    gcc-8.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260928    gcc-8.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-24
m68k                        m5208evb_defconfig    gcc-11.5.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    gcc-11.5.0
mips                            ip22_defconfig    clang-24
nios2                             alldefconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1000-20260928    gcc-8.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260928    gcc-8.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1000-20260928    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc                randconfig-1001-20260928    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1000-20260928    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc               randconfig-1001-20260928    clang-24
powerpc                      tqm8541_defconfig    gcc-11.5.0
powerpc                      tqm8548_defconfig    gcc-11.5.0
powerpc                      tqm8555_defconfig    gcc-11.5.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1000-20260928    clang-24
powerpc64             randconfig-1001-20260927    clang-24
powerpc64             randconfig-1001-20260928    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1000-20260928    clang-24
riscv                 randconfig-1001-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260928    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1000-20260928    clang-24
s390                  randconfig-1001-20260927    gcc-16.1.0
s390                  randconfig-1001-20260928    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1000-20260928    clang-24
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                    randconfig-1001-20260928    clang-24
sh                            se7722_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1000-20260928    clang-17
sparc                 randconfig-1001-20260927    clang-24
sparc                 randconfig-1001-20260928    clang-17
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1000-20260928    clang-17
sparc64               randconfig-1001-20260927    clang-24
sparc64               randconfig-1001-20260928    clang-17
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1000-20260928    clang-17
um                    randconfig-1001-20260927    clang-24
um                    randconfig-1001-20260928    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1006-20260928    gcc-14
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1007-20260928    gcc-14
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1008-20260928    gcc-14
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1009-20260928    gcc-14
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1010-20260928    gcc-14
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1011-20260928    gcc-14
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1012-20260928    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1013-20260928    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1014-20260928    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1015-20260928    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1016-20260928    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                randconfig-1017-20260928    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1000-20260928    clang-17
xtensa                randconfig-1001-20260927    clang-24
xtensa                randconfig-1001-20260928    clang-17
xtensa                     smp_lx200_defconfig    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

