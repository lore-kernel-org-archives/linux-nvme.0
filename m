Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B94CDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9SBuECuIsOCRPKO6cDc2ceuCcPHneoLvQynr2mKqKjU=; b=DVS9c2sLna4j1UNvUED72DpFR/
	nkYNW4Q6kI92ZyXqcYOHob01SpxQsKxPkpx0V/lFJ2HUK4n9NjFEHQ0WamzBV7tO4O2MFrNov00Sw
	X84G9oxYH+gxTGmdN0ol239t2UyDUlgdvFyFBuV7oeKVwrGoq4S3ZrRNDPWn+uHPbxK75Bq/vgzAU
	+eOJqPqL2g2CGXv4IPe0m2Q78tgMZElJeZdpcOUIiH7vvXS7lXuNoVe3kZ0O5/jVM24herkUhDKGl
	zrGOEVvJTm0bAB38zgmriurwZFqxzp5ZPA/Lc+gYwezLhFkt1GebmGnIeAfZqCOGYWG9rbFwRFjaA
	JNUj/wUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcKGs-00000007Xn7-0OH7;
	Wed, 24 Jun 2026 09:51:50 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcKGp-00000007XmO-0Ygl
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 09:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782294707; x=1813830707;
  h=date:from:to:cc:subject:message-id;
  bh=XE6wP+IRCFAwk8STDETxO2T7BDmuNzqJpTdktRgMTmU=;
  b=gB3OomOoj8lPL/8pcWj2NTwvTbjEaIB1QoYiluSDVKCZYZr6MaMT+/qL
   4MjMn94o5Wg4J26gvopUFCgDTd1x2M5a7KgokoogaHn2ApUV7yH6Iq4XI
   ssUv34blZABB7mX+G3pOEeLlMxeD0sqKgoj4m1a+RGJvzyJJjVLCfvlwf
   0mgq4P14InncnDlnJxr9xjamqoEh9+r+tyMjbqrh6MKJuke2uRSqx3nW8
   36hOeLeKXdlg3JK2OLoxnK9VuwTHFoV4h1TM4fDDuJviybKaOSploNjG5
   96XNBFxCLYoZkg8Awvqd8VHwH36nYOJ6wbw2eomeClNJvQUu8gRPxX6Nf
   A==;
X-CSE-ConnectionGUID: x3o1lvkVS4qy5thbpl6Eyg==
X-CSE-MsgGUID: mRiOMb9wRxKMFa+f5rccFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83056700"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83056700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:51:44 -0700
X-CSE-ConnectionGUID: Q0hHjEWqQYKhFOZHGr0oDA==
X-CSE-MsgGUID: KvhGgzjsTwaMNMbL5F/Zsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="287911300"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Jun 2026 02:51:42 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcKGh-000000003GT-3jI6;
	Wed, 24 Jun 2026 09:51:39 +0000
Date: Wed, 24 Jun 2026 17:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.2] BUILD SUCCESS
 29264400dd2af703ecffae039c2ee799558e2d34
Message-ID: <202606241722.K8ReVFwK-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_025147_237521_2D6C6611 
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.2
branch HEAD: 29264400dd2af703ecffae039c2ee799558e2d34  Merge tag 'nvme-7.2-2026-06-23' of git://git.infradead.org/nvme into block-7.2

elapsed time: 1035m

configs tested: 277
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-001-20260624    gcc-9.5.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260624    clang-19
arm                   randconfig-001-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-8.5.0
arm                   randconfig-003-20260624    gcc-15.2.0
arm                   randconfig-004-20260624    clang-17
arm                   randconfig-004-20260624    gcc-15.2.0
arm                        vexpress_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-002-20260624    gcc-15.2.0
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-003-20260624    clang-23
arm64                 randconfig-004-20260624    clang-21
arm64                 randconfig-004-20260624    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-001-20260624    gcc-16.1.0
csky                  randconfig-002-20260624    clang-21
csky                  randconfig-002-20260624    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260624    clang-20
hexagon               randconfig-001-20260624    gcc-9.5.0
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260624    clang-23
hexagon               randconfig-002-20260624    gcc-9.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-14
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-14
i386        buildonly-randconfig-003-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-14
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-14
i386        buildonly-randconfig-006-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260624    clang-22
i386                  randconfig-001-20260624    gcc-14
i386                  randconfig-002-20260624    clang-22
i386                  randconfig-002-20260624    gcc-14
i386                  randconfig-003-20260624    clang-22
i386                  randconfig-003-20260624    gcc-14
i386                  randconfig-004-20260624    clang-22
i386                  randconfig-004-20260624    gcc-12
i386                  randconfig-005-20260624    clang-22
i386                  randconfig-006-20260624    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-007-20260624    gcc-14
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-012-20260624    gcc-14
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-015-20260624    gcc-14
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260624    gcc-16.1.0
loongarch             randconfig-001-20260624    gcc-9.5.0
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260624    gcc-15.2.0
loongarch             randconfig-002-20260624    gcc-9.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260624    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-9.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-14.3.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260624    clang-17
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-8.5.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-8.5.0
powerpc64             randconfig-002-20260624    gcc-11.5.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260624    clang-18
riscv                 randconfig-001-20260624    gcc-13.4.0
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260624    clang-18
s390                  randconfig-001-20260624    gcc-8.5.0
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260624    clang-18
s390                  randconfig-002-20260624    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260624    clang-18
sh                    randconfig-001-20260624    gcc-15.2.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260624    clang-18
sh                    randconfig-002-20260624    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-001-20260624    gcc-8.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260624    clang-20
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260624    clang-20
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260624    clang-23
um                    randconfig-001-20260624    gcc-14.3.0
um                             randconfig-002    clang-23
um                    randconfig-002-20260624    clang-17
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-001-20260624    gcc-14
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    gcc-14
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    gcc-14
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                randconfig-004-20260624    gcc-14
x86_64                randconfig-005-20260624    clang-22
x86_64                randconfig-006-20260624    gcc-14
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-12
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    clang-22
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    clang-22
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

