Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CF1C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pw5/Z+DgaLdYyN0/OCSiQlCAaTWUhn+DfcONdH3dpOg=; b=ELVg5FA+hWf7GzifXYPCK/h/1r
	I8ppK7LYxnUaVEbrrAFyJ1DhMm3tBaj8Z8W4Q3O6FeBVW1GiwMZC/Qq4ErGdiaXIBVAxlcFucCd2j
	Vc45zaisOpfFsSMs7s2Vp/Emb0MszVy0iqpKmZSSsCUEiON6gZYCM4Xg5YBUiDGauo5b8KHCHZBPE
	aOS2f8y6ks8fKUcM9306ZvU2J0xjnrNPs9/gdKd3NaVD1LYLz5TMemKbayEo0qJ/cWD6szphrYcw8
	py9zyhFCmCU/5KRRm29WDyPXDfUF/rsSCaErb2jhk5waOtwKtOTbxGk6zWZIF3Ml3nw3emWfqxQ5k
	i7EvV3hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Yqa-0000000AQMM-046J;
	Wed, 23 Apr 2025 12:05:00 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Xxl-0000000AG9K-48QN
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 11:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745406502; x=1776942502;
  h=date:from:to:cc:subject:message-id;
  bh=42nBpXHXtRoX4LeHWgBlBebAmicyl7c84i4XFbVrnOk=;
  b=oHrQ0IYO8jy7Ek3z5k4qmobnJjKVZZ4t/c8ADrZNcfZdOec8n7hsc/UC
   q1V6Wt5CNsMCLBlSPgcgaXRo5I3WSM20hyRh5zg9jT568wHRskRP3yX4T
   90XJTyv4GEgYkkEN8cly37E0N9mJXUvPs3gLfm+wt7G1goVLZs1LV49m4
   BnJFoaAGe/RAIegkMS78Ca1c42E1dtUSOQN21Dlk4FR7xBsWNT2Vy+Isv
   zIrLOgzGnLstunWGtUOZaPXrSKKcOAJfzf1rUQie9d9NV/i+8330+B6TP
   PCHCjiJ46wAAoM5sDkPEmEI/S5ZqL/o+AHQY/ueDD78wH9KAZoR42fH6y
   g==;
X-CSE-ConnectionGUID: 7VDL9vKQQymE5Rv6f1gPZg==
X-CSE-MsgGUID: P1j8c4CxS/qo98nNLQGPBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49658902"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="49658902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:08:19 -0700
X-CSE-ConnectionGUID: R+JeDuoJTJKhhflH7R15/w==
X-CSE-MsgGUID: 6f7TEDatRNe8It5sSqQMiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132275988"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2025 04:08:18 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7Xxg-0001uc-0Y;
	Wed, 23 Apr 2025 11:08:16 +0000
Date: Wed, 23 Apr 2025 19:08:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 3d7aa0c7b4e96cd460826d932e44710cdeb3378b
Message-ID: <202504231950.PuguO92y-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_040822_068795_D4CDE970 
X-CRM114-Status: UNSURE (   4.99  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.15
branch HEAD: 3d7aa0c7b4e96cd460826d932e44710cdeb3378b  nvmet: fix out-of-bounds access in nvmet_enable_port

elapsed time: 1456m

configs tested: 263
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250422    gcc-8.5.0
arc                   randconfig-001-20250423    gcc-14.2.0
arc                   randconfig-002-20250422    gcc-14.2.0
arc                   randconfig-002-20250423    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250422    gcc-8.5.0
arm                   randconfig-001-20250423    gcc-14.2.0
arm                   randconfig-002-20250422    gcc-8.5.0
arm                   randconfig-002-20250423    gcc-14.2.0
arm                   randconfig-003-20250422    gcc-7.5.0
arm                   randconfig-003-20250423    gcc-14.2.0
arm                   randconfig-004-20250422    gcc-7.5.0
arm                   randconfig-004-20250423    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250422    gcc-6.5.0
arm64                 randconfig-001-20250423    gcc-14.2.0
arm64                 randconfig-002-20250422    clang-21
arm64                 randconfig-002-20250423    gcc-14.2.0
arm64                 randconfig-003-20250422    clang-18
arm64                 randconfig-003-20250423    gcc-14.2.0
arm64                 randconfig-004-20250422    gcc-8.5.0
arm64                 randconfig-004-20250423    gcc-14.2.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250422    gcc-10.5.0
csky                  randconfig-001-20250423    gcc-7.5.0
csky                  randconfig-002-20250422    gcc-14.2.0
csky                  randconfig-002-20250423    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250422    clang-21
hexagon               randconfig-001-20250423    gcc-7.5.0
hexagon               randconfig-002-20250422    clang-21
hexagon               randconfig-002-20250423    gcc-7.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250422    clang-20
i386        buildonly-randconfig-001-20250423    gcc-12
i386        buildonly-randconfig-002-20250422    clang-20
i386        buildonly-randconfig-002-20250423    gcc-12
i386        buildonly-randconfig-003-20250422    gcc-12
i386        buildonly-randconfig-003-20250423    gcc-12
i386        buildonly-randconfig-004-20250422    gcc-12
i386        buildonly-randconfig-004-20250423    gcc-12
i386        buildonly-randconfig-005-20250422    clang-20
i386        buildonly-randconfig-005-20250423    gcc-12
i386        buildonly-randconfig-006-20250422    clang-20
i386        buildonly-randconfig-006-20250423    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250423    gcc-12
i386                  randconfig-002-20250423    gcc-12
i386                  randconfig-003-20250423    gcc-12
i386                  randconfig-004-20250423    gcc-12
i386                  randconfig-005-20250423    gcc-12
i386                  randconfig-006-20250423    gcc-12
i386                  randconfig-007-20250423    gcc-12
i386                  randconfig-011-20250423    clang-20
i386                  randconfig-012-20250423    clang-20
i386                  randconfig-013-20250423    clang-20
i386                  randconfig-014-20250423    clang-20
i386                  randconfig-015-20250423    clang-20
i386                  randconfig-016-20250423    clang-20
i386                  randconfig-017-20250423    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250422    gcc-14.2.0
loongarch             randconfig-001-20250423    gcc-7.5.0
loongarch             randconfig-002-20250422    gcc-14.2.0
loongarch             randconfig-002-20250423    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.1.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                      maltaaprp_defconfig    clang-21
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250422    gcc-10.5.0
nios2                 randconfig-001-20250423    gcc-7.5.0
nios2                 randconfig-002-20250422    gcc-14.2.0
nios2                 randconfig-002-20250423    gcc-7.5.0
openrisc                         alldefconfig    clang-21
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250422    gcc-7.5.0
parisc                randconfig-001-20250423    gcc-7.5.0
parisc                randconfig-002-20250422    gcc-11.5.0
parisc                randconfig-002-20250423    gcc-7.5.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250422    clang-21
powerpc               randconfig-001-20250423    gcc-7.5.0
powerpc               randconfig-002-20250422    gcc-6.5.0
powerpc               randconfig-002-20250423    gcc-7.5.0
powerpc               randconfig-003-20250422    clang-16
powerpc               randconfig-003-20250423    gcc-7.5.0
powerpc                     sequoia_defconfig    clang-21
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20250422    clang-21
powerpc64             randconfig-001-20250423    gcc-7.5.0
powerpc64             randconfig-002-20250422    gcc-6.5.0
powerpc64             randconfig-002-20250423    gcc-7.5.0
powerpc64             randconfig-003-20250422    gcc-6.5.0
powerpc64             randconfig-003-20250423    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250422    clang-21
riscv                 randconfig-001-20250423    gcc-12
riscv                 randconfig-002-20250422    gcc-14.2.0
riscv                 randconfig-002-20250423    gcc-12
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250422    gcc-7.5.0
s390                  randconfig-001-20250423    gcc-12
s390                  randconfig-002-20250422    clang-21
s390                  randconfig-002-20250423    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.1.0
sh                    randconfig-001-20250422    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-12
sh                    randconfig-002-20250422    gcc-6.5.0
sh                    randconfig-002-20250423    gcc-12
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250422    gcc-10.3.0
sparc                 randconfig-001-20250423    gcc-12
sparc                 randconfig-002-20250422    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-12
sparc                       sparc64_defconfig    clang-21
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250422    gcc-7.5.0
sparc64               randconfig-001-20250423    gcc-12
sparc64               randconfig-002-20250422    gcc-13.3.0
sparc64               randconfig-002-20250423    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250422    gcc-12
um                    randconfig-001-20250423    gcc-12
um                    randconfig-002-20250422    gcc-12
um                    randconfig-002-20250423    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250422    gcc-12
x86_64      buildonly-randconfig-001-20250423    gcc-12
x86_64      buildonly-randconfig-002-20250422    clang-20
x86_64      buildonly-randconfig-002-20250423    gcc-12
x86_64      buildonly-randconfig-003-20250422    gcc-12
x86_64      buildonly-randconfig-003-20250423    gcc-12
x86_64      buildonly-randconfig-004-20250422    gcc-12
x86_64      buildonly-randconfig-004-20250423    gcc-12
x86_64      buildonly-randconfig-005-20250422    clang-20
x86_64      buildonly-randconfig-005-20250423    gcc-12
x86_64      buildonly-randconfig-006-20250422    clang-20
x86_64      buildonly-randconfig-006-20250423    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250423    clang-20
x86_64                randconfig-002-20250423    clang-20
x86_64                randconfig-003-20250423    clang-20
x86_64                randconfig-004-20250423    clang-20
x86_64                randconfig-005-20250423    clang-20
x86_64                randconfig-006-20250423    clang-20
x86_64                randconfig-007-20250423    clang-20
x86_64                randconfig-008-20250423    clang-20
x86_64                randconfig-071-20250423    gcc-12
x86_64                randconfig-072-20250423    gcc-12
x86_64                randconfig-073-20250423    gcc-12
x86_64                randconfig-074-20250423    gcc-12
x86_64                randconfig-075-20250423    gcc-12
x86_64                randconfig-076-20250423    gcc-12
x86_64                randconfig-077-20250423    gcc-12
x86_64                randconfig-078-20250423    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20250422    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-12
xtensa                randconfig-002-20250422    gcc-9.3.0
xtensa                randconfig-002-20250423    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

