Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FD5C88E77
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rPN2ms+81rPO6mO5sutVo3A1s7aZ+f58T9vQgz20bJM=; b=W8zCpXoXEhjUnp4Y+L7r2ZMYN8
	pFHvHGz7D36Kh/5YlHHWGK0s37gixcoUCuUQOzaF0rvGqyrSMZUFeaaxDJTu7DBJJV9TvX6yaZJGr
	3wkfmFqxf41h15Vx0UZUnUsXeAtp8U5DnebQYqYABZT3g9fH07hdJ2GdIxBdAYddljidhH5BY2Odp
	mN/pbTrntr16PCK5mrHIWotviGFq8wvMtTlT4NJEBHKKL7008XcoO7wfPaioi0nbRcgDpPdTngOAs
	B+JPum/FOMp5y4j+6CYWt6B8oOfgeT95XJsNUj9yWCFzTAgYbWxj8BT4rUHOn2wp+5GXxatkam/B9
	YlODNLDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o13-0000000967r-0k5t;
	Wed, 16 Sep 2026 11:41:29 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6o10-0000000967G-3Ykk
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 11:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789558887; x=1821094887;
  h=date:from:to:cc:subject:message-id;
  bh=3EyA0vaMzttETdc5x3X4wIkMW89FXrbfLfE4IKR8OMs=;
  b=J80zZ/Y8m3F3qYUh9udMSiVk43snuDtJifg6yQ7kGOm+JCgabFOPuWBg
   qGpwl5QLLOpc6+nL4Sy6PR45ja200GsWVYFHU16A05g2mBGItbahbTqd3
   F928TqBnhz1pALKhECYkaY6NymlJ936Luqx0XmKi9p4daoBMjQQmbQ1Py
   l9Pbpq83zCfkVlGT3DN7zZYO0O50IQp41gIATxi7z6oxw+t+6tKHgPXuy
   KcMTcVM7s+d1irBUauwqgiBRcmuRERm0dfUVIcS8JuIE08XBlvVR2NqRH
   799txyLNIO+bWH3IPQW1FeCa+aM6RRX4TbLIvsOcuvDr9kQPWZGWGqybc
   Q==;
X-CSE-ConnectionGUID: AMvYgS5NSNK+XipEOumJmg==
X-CSE-MsgGUID: ZDSCSRXCR/mgaIS3KN7IIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89802709"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89802709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 04:41:25 -0700
X-CSE-ConnectionGUID: Wuw5mxMgStGmvuRldiXodg==
X-CSE-MsgGUID: QTD5Atw8QZyN0D6Lcdv81g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="303203013"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Sep 2026 04:41:23 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6o0v-000000005wz-01w9;
	Wed, 16 Sep 2026 11:41:21 +0000
Date: Wed, 16 Sep 2026 19:40:43 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS
 d2d7acf786afba1bf87b82dbad2d7708268af929
Message-ID: <202609161939.Ab6epJNV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_044127_000720_67F2F68D 
X-CRM114-Status: UNSURE (   5.04  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: d2d7acf786afba1bf87b82dbad2d7708268af929  nvme-tcp: delay nvme_tcp_reclassify_socket()

elapsed time: 1395m

configs tested: 195
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20260916    clang-24
arc                   randconfig-002-20260916    clang-24
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                           h3600_defconfig    gcc-16.1.0
arm                   randconfig-001-20260916    clang-24
arm                   randconfig-002-20260916    clang-24
arm                   randconfig-003-20260916    clang-24
arm                   randconfig-004-20260916    clang-24
arm                  randconfig-r133-20260916    gcc-16.1.0 sparse
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260916    gcc-16.1.0
arm64                 randconfig-002-20260916    gcc-16.1.0
arm64                 randconfig-003-20260916    gcc-16.1.0
arm64                 randconfig-004-20260916    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260916    gcc-16.1.0
csky                  randconfig-002-20260916    gcc-16.1.0
csky                 randconfig-r111-20260916    clang-24 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260916    gcc-16.1.0
hexagon               randconfig-002-20260916    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260916    clang-22
i386        buildonly-randconfig-002-20260916    clang-22
i386        buildonly-randconfig-003-20260916    clang-22
i386        buildonly-randconfig-004-20260916    clang-22
i386        buildonly-randconfig-005-20260916    clang-22
i386        buildonly-randconfig-006-20260916    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260916    gcc-14
i386                  randconfig-002-20260916    gcc-14
i386                  randconfig-003-20260916    gcc-14
i386                  randconfig-004-20260916    gcc-14
i386                  randconfig-005-20260916    gcc-14
i386                  randconfig-006-20260916    gcc-14
i386                  randconfig-007-20260916    gcc-14
i386                  randconfig-011-20260916    clang-22
i386                  randconfig-012-20260916    clang-22
i386                  randconfig-013-20260916    clang-22
i386                  randconfig-014-20260916    clang-22
i386                  randconfig-015-20260916    clang-22
i386                  randconfig-016-20260916    clang-22
i386                  randconfig-017-20260916    clang-22
i386                 randconfig-r131-20260916    gcc-16.1.0 sparse
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260916    gcc-16.1.0
loongarch             randconfig-002-20260916    gcc-16.1.0
loongarch            randconfig-r111-20260916    gcc-12.5.0 sparse
loongarch            randconfig-r121-20260916    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5329evb_defconfig    clang-20
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                 randconfig-r113-20260916    clang-24 sparse
mips                 randconfig-r123-20260916    gcc-12.5.0 sparse
mips                           rs90_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260916    gcc-16.1.0
nios2                 randconfig-002-20260916    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r134-20260916    gcc-16.1.0 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260916    clang-24
parisc                randconfig-002-20260916    clang-24
parisc               randconfig-r122-20260916    gcc-12.5.0 sparse
parisc               randconfig-r132-20260916    gcc-11.5.0 sparse
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                        cell_defconfig    gcc-16.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20260916    clang-24
powerpc               randconfig-002-20260916    clang-24
powerpc              randconfig-r113-20260916    gcc-12.5.0 sparse
powerpc              randconfig-r122-20260916    clang-24 sparse
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260916    clang-24
powerpc64             randconfig-002-20260916    clang-24
powerpc64            randconfig-r112-20260916    gcc-12.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260916    gcc-16.1.0
riscv                 randconfig-002-20260916    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260916    gcc-16.1.0
s390                  randconfig-002-20260916    gcc-16.1.0
s390                 randconfig-r133-20260916    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-001-20260916    gcc-16.1.0
sh                    randconfig-002-20260916    gcc-16.1.0
sh                   randconfig-r123-20260916    clang-24 sparse
sh                          sdk7786_defconfig    clang-20
sh                           se7751_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260916    gcc-14.3.0
sparc                 randconfig-002-20260916    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260916    gcc-14.3.0
sparc64               randconfig-002-20260916    gcc-14.3.0
sparc64              randconfig-r112-20260916    clang-24 sparse
sparc64              randconfig-r134-20260916    gcc-11.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260916    gcc-14.3.0
um                    randconfig-002-20260916    gcc-14.3.0
um                   randconfig-r121-20260916    clang-24 sparse
um                   randconfig-r132-20260916    gcc-16.1.0 sparse
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-24
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260916    clang-22
x86_64                randconfig-002-20260916    clang-22
x86_64                randconfig-003-20260916    clang-22
x86_64                randconfig-004-20260916    clang-22
x86_64                randconfig-005-20260916    clang-22
x86_64                randconfig-006-20260916    clang-22
x86_64                randconfig-011-20260916    gcc-14
x86_64                randconfig-012-20260916    gcc-14
x86_64                randconfig-013-20260916    gcc-14
x86_64                randconfig-014-20260916    gcc-14
x86_64                randconfig-015-20260916    gcc-14
x86_64                randconfig-016-20260916    gcc-14
x86_64                randconfig-071-20260916    gcc-14
x86_64                randconfig-072-20260916    gcc-14
x86_64                randconfig-073-20260916    gcc-14
x86_64                randconfig-074-20260916    gcc-14
x86_64                randconfig-075-20260916    gcc-14
x86_64                randconfig-076-20260916    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260916    gcc-14.3.0
xtensa                randconfig-002-20260916    gcc-14.3.0
xtensa               randconfig-r131-20260916    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

