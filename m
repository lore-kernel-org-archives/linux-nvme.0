Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4304E69188
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R6MTjTyP3ie9BgHmb9rDaJ4hwLGoCJjcmd25P8o5COE=; b=1DnknaGTcSEqGPd+t7mTgtvU2y
	c8kwqvJMLBJLBk0BFiv9J+G0nA4+MENDgqrz1LXse2a+EgtZdH95p87raIdh4ojrZi/zUhtuUjEiO
	HS2UfWKkuEGLN6tLyhNxheiafZxh2k9FGo6Fh3TqD4ZSx+NG+DvM8zJLHZ8HMjAh8Pehhu8aLDGRb
	yN80zBuhnEcjyXRwfK/F9N9mMhxP8IFJuvPpG7XsNt1lQw5mXA3X+y0jF6nmv6fRkRMq2hUo5WvRl
	P4QHzI2jn31u0FTxI5IIgW7UKl+iPybpnC99ewmBDGltL0FSTL9QsYDm3qY6CfR0p9XFquSDgh9Cd
	EkuhiSQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYnB-000000039eB-0TVz;
	Fri, 22 Nov 2024 18:54:09 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYn8-000000039ds-38QK
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 18:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732301646; x=1763837646;
  h=date:from:to:cc:subject:message-id;
  bh=vw48XuMxKmHO9T2BSqGfR7LSnMIp5Ir8ptiwx9iXjxI=;
  b=SkS9S47+abzlpuPSvUSDyDRCgSuOPh6pmO53hJGZz99Gq60qU9yZnzrd
   oH9v4L5Pk60uK/KTLxg4Oh+q0ilWbaBVG6BIWZz05jZ4cGJZXeHG9z2lr
   FEM1zZrQPdHZbK+mBI82WwCB39LY34QImq8Oe/GWQfjMrnAMz04VwgWc/
   0olJJK7SZ0+V88san1lTzh94y2ctf153E9tNiIfAjDrtNh5wCCKRyaXLr
   qaxR4wpViLe3iUXBD518+mMicDdB3XTxnG6Iq41CJUnKkCMA9lFuNJnQo
   VxFDU1XzZtS2svIsqtouagy46OgQbxPzE58bDiRblqhtk4cKmbpWQV+VM
   Q==;
X-CSE-ConnectionGUID: Fe0GM0UxRxW0xg/58Hll7A==
X-CSE-MsgGUID: oebEeqUqQqKBM+MFDWBX9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49987340"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="49987340"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 10:54:03 -0800
X-CSE-ConnectionGUID: tvZTEDYXSZmMdylqhEyrJA==
X-CSE-MsgGUID: zdztZN6UTaaTgY0SvgNo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="128163332"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Nov 2024 10:54:03 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEYn2-00048p-0u;
	Fri, 22 Nov 2024 18:54:00 +0000
Date: Sat, 23 Nov 2024 02:53:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 029cc98dec2eadb5d0978b5fea9ae6c427f2a020
Message-ID: <202411230217.xSTTcctD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_105406_807399_6EB027BD 
X-CRM114-Status: UNSURE (   4.81  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: 029cc98dec2eadb5d0978b5fea9ae6c427f2a020  nvme: tuning pr code by using defined structs and macros

elapsed time: 1416m

configs tested: 244
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241122    gcc-13.2.0
arc                   randconfig-001-20241122    gcc-14.2.0
arc                   randconfig-002-20241122    gcc-13.2.0
arc                   randconfig-002-20241122    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20241122    clang-17
arm                   randconfig-001-20241122    gcc-14.2.0
arm                   randconfig-002-20241122    gcc-14.2.0
arm                   randconfig-003-20241122    clang-20
arm                   randconfig-003-20241122    gcc-14.2.0
arm                   randconfig-004-20241122    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241122    gcc-14.2.0
arm64                 randconfig-002-20241122    gcc-14.2.0
arm64                 randconfig-003-20241122    gcc-14.2.0
arm64                 randconfig-004-20241122    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241122    gcc-14.2.0
csky                  randconfig-002-20241122    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241122    clang-20
hexagon               randconfig-001-20241122    gcc-14.2.0
hexagon               randconfig-002-20241122    clang-20
hexagon               randconfig-002-20241122    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241122    clang-19
i386        buildonly-randconfig-002-20241122    clang-19
i386        buildonly-randconfig-003-20241122    clang-19
i386        buildonly-randconfig-004-20241122    clang-19
i386        buildonly-randconfig-005-20241122    clang-19
i386        buildonly-randconfig-005-20241122    gcc-12
i386        buildonly-randconfig-006-20241122    clang-19
i386        buildonly-randconfig-006-20241122    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241122    clang-19
i386                  randconfig-001-20241122    gcc-12
i386                  randconfig-002-20241122    clang-19
i386                  randconfig-003-20241122    clang-19
i386                  randconfig-003-20241122    gcc-12
i386                  randconfig-004-20241122    clang-19
i386                  randconfig-005-20241122    clang-19
i386                  randconfig-005-20241122    gcc-12
i386                  randconfig-006-20241122    clang-19
i386                  randconfig-006-20241122    gcc-12
i386                  randconfig-011-20241122    clang-19
i386                  randconfig-011-20241122    gcc-12
i386                  randconfig-012-20241122    clang-19
i386                  randconfig-012-20241122    gcc-12
i386                  randconfig-013-20241122    clang-19
i386                  randconfig-013-20241122    gcc-12
i386                  randconfig-014-20241122    clang-19
i386                  randconfig-014-20241122    gcc-12
i386                  randconfig-015-20241122    clang-19
i386                  randconfig-015-20241122    gcc-12
i386                  randconfig-016-20241122    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241122    gcc-14.2.0
loongarch             randconfig-002-20241122    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                            gpr_defconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241122    gcc-14.2.0
nios2                 randconfig-002-20241122    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    clang-20
openrisc                 simple_smp_defconfig    clang-20
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241122    gcc-14.2.0
parisc                randconfig-002-20241122    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20241122    gcc-14.2.0
powerpc               randconfig-002-20241122    clang-20
powerpc               randconfig-002-20241122    gcc-14.2.0
powerpc               randconfig-003-20241122    clang-20
powerpc               randconfig-003-20241122    gcc-14.2.0
powerpc64             randconfig-001-20241122    gcc-14.2.0
powerpc64             randconfig-002-20241122    gcc-14.2.0
powerpc64             randconfig-003-20241122    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241122    gcc-14.2.0
riscv                 randconfig-002-20241122    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241122    clang-20
s390                  randconfig-001-20241122    gcc-14.2.0
s390                  randconfig-002-20241122    clang-20
s390                  randconfig-002-20241122    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20241122    gcc-14.2.0
sh                    randconfig-002-20241122    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                           se7724_defconfig    clang-20
sh                        sh7757lcr_defconfig    clang-20
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241122    gcc-14.2.0
sparc64               randconfig-002-20241122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241122    clang-17
um                    randconfig-001-20241122    gcc-14.2.0
um                    randconfig-002-20241122    gcc-11
um                    randconfig-002-20241122    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241122    clang-19
x86_64      buildonly-randconfig-002-20241122    clang-19
x86_64      buildonly-randconfig-003-20241122    clang-19
x86_64      buildonly-randconfig-004-20241122    clang-19
x86_64      buildonly-randconfig-005-20241122    clang-19
x86_64      buildonly-randconfig-006-20241122    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241122    clang-19
x86_64                randconfig-002-20241122    clang-19
x86_64                randconfig-003-20241122    clang-19
x86_64                randconfig-004-20241122    clang-19
x86_64                randconfig-005-20241122    clang-19
x86_64                randconfig-006-20241122    clang-19
x86_64                randconfig-011-20241122    clang-19
x86_64                randconfig-012-20241122    clang-19
x86_64                randconfig-013-20241122    clang-19
x86_64                randconfig-014-20241122    clang-19
x86_64                randconfig-015-20241122    clang-19
x86_64                randconfig-016-20241122    clang-19
x86_64                randconfig-071-20241122    clang-19
x86_64                randconfig-072-20241122    clang-19
x86_64                randconfig-073-20241122    clang-19
x86_64                randconfig-074-20241122    clang-19
x86_64                randconfig-075-20241122    clang-19
x86_64                randconfig-076-20241122    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241122    gcc-14.2.0
xtensa                randconfig-002-20241122    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

