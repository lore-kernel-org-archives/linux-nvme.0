Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C237C3ABC3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 05:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VkJJ+3LJXlA/RNA0feaiuKuG6A6NGyoAcA4VSHdg6mM=; b=psygM7nrDu32rGE5M4EiEIvtoP
	S+TusmSKIQjbZX65qwwFh+/Nu+y7l5h8sE3jiQYzNua+gSnPStIcVXqMvYRHx2N+lzZAi6bBEI6xZ
	nk0QYWfAj2CKVRiqGjH9DwO2iunzQxSGRXAUeblEhf6DEJCrTxQCTopawuPJytZqI82b0TgZspy0E
	5Zh/ZKbEO56zkyg9dV8hovqDSwUetHET/gLiwsEURL4cuRSPbOHLA0G6WpGz+/D9JlIEP5mKF5366
	ZVikMv9Vv4DE3sfXvCzwX+Bay1LeEwNTcfBAbQ0Y+6lomJUlo39CXIUDmrXvgT6vP1oJ2wayBN4bX
	RX216wxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDcoR-00000005Rhr-2TDR;
	Sat, 10 May 2025 05:31:51 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDcoO-00000005RhM-2qU7
	for linux-nvme@lists.infradead.org;
	Sat, 10 May 2025 05:31:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746855108; x=1778391108;
  h=date:from:to:cc:subject:message-id;
  bh=/dnva5+F+ga7YAEb13GnMt/hzbOH7oSYbcb8ozKhhNk=;
  b=J9QxMeOfJ5dVO6VqjVvhZHq9WXcPFPFrZilNlgWFc83smADivgOc3z9o
   BvpkHr9js9YPv7Zkbw1Ibneuy57JuJuyZypZUTuZfnXNuxl/pQYNCiXV4
   qOyzVLqDy3cfQ5sKySV7TDheNH4aXBGTQW0LbNpWDrRWKXHVsw5F7nE7S
   bRmfNF75whIsIDXu4jVyCRJUdDGsfxXYSdHFDbB4NEvLj/8GnCqIHRY9d
   fDxyCdt6dAQjXyqCwzIMnb8KClgDHf5IHNcGR3VDHdnXA0Y8YRTEB54ES
   QSNNqw5MrYLtGfJBqc/b3ZPm83zfLwmyxUL2TwL/VXYmDdUVoaD1jPwQk
   Q==;
X-CSE-ConnectionGUID: JIjqusd8Qny3KUlUr6GlWA==
X-CSE-MsgGUID: vSSK71c+T6OxRc07Duil3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="60036148"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="60036148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 22:31:40 -0700
X-CSE-ConnectionGUID: NUzGTq9vRxaq3+gJWA087A==
X-CSE-MsgGUID: xiUK9znPSQmEjlA6zPF5bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="141779275"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2025 22:31:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDcoD-000Cod-0x;
	Sat, 10 May 2025 05:31:37 +0000
Date: Sat, 10 May 2025 13:31:37 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS WITH WARNING
 a0136c6ac4a9aba90a47b9c691bc299a113b5259
Message-ID: <202505101316.wXg1kYFN-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_223148_760054_744FCE5C 
X-CRM114-Status: UNSURE (   5.14  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.16
branch HEAD: a0136c6ac4a9aba90a47b9c691bc299a113b5259  nvmet: simplify the nvmet_req_init() interface

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202505091619.QFU1fxsd-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202505100417.PlIkH5TX-lkp@intel.com

    drivers/nvme/target/core.c:1018:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]

Unverified Warning (likely false positive, kindly check if interested):

    drivers/nvme/target/core.c:1018 nvmet_sq_init() error: uninitialized symbol 'ret'.

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- hexagon-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- hexagon-allyesconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- hexagon-randconfig-001-20250509
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- i386-randconfig-141-20250510
|   `-- drivers-nvme-target-core.c-nvmet_sq_init()-error:uninitialized-symbol-ret-.
|-- powerpc-allyesconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- riscv-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- riscv-allyesconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- s390-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- s390-randconfig-002-20250509
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- um-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- x86_64-allmodconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- x86_64-allyesconfig
|   `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here
|-- x86_64-randconfig-161-20250510
|   `-- drivers-nvme-target-core.c-nvmet_sq_init()-error:uninitialized-symbol-ret-.
`-- x86_64-rhel-9.4-rust
    `-- drivers-nvme-target-core.c:warning:variable-ret-is-uninitialized-when-used-here

elapsed time: 1367m

configs tested: 250
configs skipped: 6

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
arc                   randconfig-001-20250509    gcc-13.3.0
arc                   randconfig-001-20250510    gcc-8.5.0
arc                   randconfig-002-20250509    gcc-13.3.0
arc                   randconfig-002-20250510    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-19
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250509    gcc-7.5.0
arm                   randconfig-001-20250510    gcc-8.5.0
arm                   randconfig-002-20250509    gcc-6.5.0
arm                   randconfig-002-20250510    gcc-8.5.0
arm                   randconfig-003-20250509    gcc-10.5.0
arm                   randconfig-003-20250510    gcc-8.5.0
arm                   randconfig-004-20250509    clang-21
arm                   randconfig-004-20250510    gcc-8.5.0
arm                          sp7021_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250509    gcc-7.5.0
arm64                 randconfig-001-20250510    gcc-8.5.0
arm64                 randconfig-002-20250509    gcc-7.5.0
arm64                 randconfig-002-20250510    gcc-8.5.0
arm64                 randconfig-003-20250509    clang-21
arm64                 randconfig-003-20250510    gcc-8.5.0
arm64                 randconfig-004-20250509    gcc-5.5.0
arm64                 randconfig-004-20250510    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250509    gcc-14.2.0
csky                  randconfig-001-20250510    clang-18
csky                  randconfig-002-20250509    gcc-13.3.0
csky                  randconfig-002-20250510    clang-18
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250509    clang-20
hexagon               randconfig-001-20250510    clang-18
hexagon               randconfig-002-20250509    clang-21
hexagon               randconfig-002-20250510    clang-18
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250509    gcc-11
i386        buildonly-randconfig-002-20250509    gcc-12
i386        buildonly-randconfig-003-20250509    clang-20
i386        buildonly-randconfig-004-20250509    clang-20
i386        buildonly-randconfig-005-20250509    gcc-12
i386        buildonly-randconfig-006-20250509    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-001-20250510    gcc-12
i386                  randconfig-002-20250510    gcc-12
i386                  randconfig-003-20250510    gcc-12
i386                  randconfig-004-20250510    gcc-12
i386                  randconfig-005-20250510    gcc-12
i386                  randconfig-006-20250510    gcc-12
i386                  randconfig-007-20250510    gcc-12
i386                  randconfig-011-20250510    clang-20
i386                  randconfig-012-20250510    clang-20
i386                  randconfig-013-20250510    clang-20
i386                  randconfig-014-20250510    clang-20
i386                  randconfig-015-20250510    clang-20
i386                  randconfig-016-20250510    clang-20
i386                  randconfig-017-20250510    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250509    gcc-13.3.0
loongarch             randconfig-001-20250510    clang-18
loongarch             randconfig-002-20250509    gcc-14.2.0
loongarch             randconfig-002-20250510    clang-18
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250509    gcc-13.3.0
nios2                 randconfig-001-20250510    clang-18
nios2                 randconfig-002-20250509    gcc-13.3.0
nios2                 randconfig-002-20250510    clang-18
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    clang-21
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250509    gcc-6.5.0
parisc                randconfig-001-20250510    clang-18
parisc                randconfig-002-20250509    gcc-14.2.0
parisc                randconfig-002-20250510    clang-18
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                       holly_defconfig    clang-21
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250509    clang-16
powerpc               randconfig-001-20250510    clang-18
powerpc               randconfig-002-20250509    gcc-5.5.0
powerpc               randconfig-002-20250510    clang-18
powerpc               randconfig-003-20250509    gcc-7.5.0
powerpc               randconfig-003-20250510    clang-18
powerpc64             randconfig-001-20250509    gcc-7.5.0
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250509    clang-21
powerpc64             randconfig-002-20250510    clang-18
powerpc64             randconfig-003-20250509    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-18
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250509    clang-21
riscv                 randconfig-001-20250510    clang-21
riscv                 randconfig-002-20250509    clang-21
riscv                 randconfig-002-20250510    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250509    clang-21
s390                  randconfig-001-20250510    clang-21
s390                  randconfig-002-20250509    clang-17
s390                  randconfig-002-20250510    clang-21
sh                               alldefconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    clang-21
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250509    gcc-9.3.0
sh                    randconfig-001-20250510    clang-21
sh                    randconfig-002-20250509    gcc-5.5.0
sh                    randconfig-002-20250510    clang-21
sh                          rsk7201_defconfig    clang-21
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250509    gcc-6.5.0
sparc                 randconfig-001-20250510    clang-21
sparc                 randconfig-002-20250509    gcc-6.5.0
sparc                 randconfig-002-20250510    clang-21
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250509    gcc-10.5.0
sparc64               randconfig-001-20250510    clang-21
sparc64               randconfig-002-20250509    gcc-6.5.0
sparc64               randconfig-002-20250510    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250509    clang-21
um                    randconfig-001-20250510    clang-21
um                    randconfig-002-20250509    gcc-12
um                    randconfig-002-20250510    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250509    gcc-11
x86_64      buildonly-randconfig-001-20250510    clang-20
x86_64      buildonly-randconfig-002-20250509    gcc-11
x86_64      buildonly-randconfig-002-20250510    clang-20
x86_64      buildonly-randconfig-003-20250509    clang-20
x86_64      buildonly-randconfig-003-20250510    clang-20
x86_64      buildonly-randconfig-004-20250509    clang-20
x86_64      buildonly-randconfig-004-20250510    clang-20
x86_64      buildonly-randconfig-005-20250509    gcc-12
x86_64      buildonly-randconfig-005-20250510    clang-20
x86_64      buildonly-randconfig-006-20250509    gcc-12
x86_64      buildonly-randconfig-006-20250510    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250510    clang-20
x86_64                randconfig-002-20250510    clang-20
x86_64                randconfig-003-20250510    clang-20
x86_64                randconfig-004-20250510    clang-20
x86_64                randconfig-005-20250510    clang-20
x86_64                randconfig-006-20250510    clang-20
x86_64                randconfig-007-20250510    clang-20
x86_64                randconfig-008-20250510    clang-20
x86_64                randconfig-071-20250510    gcc-11
x86_64                randconfig-072-20250510    gcc-11
x86_64                randconfig-073-20250510    gcc-11
x86_64                randconfig-074-20250510    gcc-11
x86_64                randconfig-075-20250510    gcc-11
x86_64                randconfig-076-20250510    gcc-11
x86_64                randconfig-077-20250510    gcc-11
x86_64                randconfig-078-20250510    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250509    gcc-12.4.0
xtensa                randconfig-001-20250510    clang-21
xtensa                randconfig-002-20250509    gcc-14.2.0
xtensa                randconfig-002-20250510    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

