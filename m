Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DDDD1268C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 02:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OW7KJJEr8g2MZZHq0EXgPZMTTcjIjppyorMqFGgPxZg=; b=Yeb/Lbwc7UUw0wHN0mi2KTSxjX
	SxlDmBzq7lz5xaIjl6HsLy+TfbZ2CCE4AN9L6USCIpH77/jb5l4P/zmk0YJ/5idf7TDkMHO2/0Q5V
	VfD4SlRVTm3iKPW/dM+5GlZcwAdQtIcU8dhChq/y0Ln7nIGmsHS7DRftGrW44aY9YK3NCZ0ygsQ+s
	oyOwde1RSurJfwDsmS7hQaVyGHGw/INbeHkm7NcRIeRWBRWC+UOZqdwrqp+wyMikQdd5StKnAE2Yr
	+gmqNwwOFlekwMe2REUigV88oUIs7WUngyaemB6+3iqGq10UNYTvJaCNfUdu5CilRUcJSC246V5Hr
	kHp+CfOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQcFx-000000061e1-0b6h;
	Wed, 03 Dec 2025 02:06:13 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQcFs-000000061de-1ZvQ
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 02:06:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764727568; x=1796263568;
  h=date:from:to:cc:subject:message-id;
  bh=jceUMuq4LDzGuNEq+hvAnUQ2IyOv31X765VSKDTARPg=;
  b=VpvSyRrGaNX03qnQLk557AgDf8pIDaKcBtnBLClTC/ZYU66bv4IRjDvn
   N0IuP6coN7DSPTVnPGMiyoZXxt7p7mV5Am7SF5XXiTlpZg8yplmLaf5PG
   aVN3mzj9ow+XOD8i2Z0WCXeDS6ZRdwD114fm6lzTGotsK7Th3tQEN3r/0
   fpe06Qc3oFp1dtV4VeYELsxszVTFxtaOz7dycVM04H0CVTEfhTJfa5J0c
   7epPZzT4mkXI8XvuS0W8gCz9Fgn1ui+2u7KfdyQQGmCE1Nc2frVvT6zN/
   bUjs4ehilEv9a52uzC9faj2pyl+eqetEGys9jb1s8hwSHyZM3tTwkPBX7
   w==;
X-CSE-ConnectionGUID: 5t4nZkIoSAqxZas2WSA2ZA==
X-CSE-MsgGUID: fuYvDg+eTu6KPIlEMXLTiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84110279"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="84110279"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 18:06:05 -0800
X-CSE-ConnectionGUID: ZuMVjEUwRCuCTF3jZ25U0g==
X-CSE-MsgGUID: 9nLlqrTGR/yLl9osowd1Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="199665526"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 18:06:04 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQcFl-00000000AQa-2vdy;
	Wed, 03 Dec 2025 02:06:01 +0000
Date: Wed, 03 Dec 2025 10:05:47 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD SUCCESS
 fd87c8a7982fdb555133a6d225b636984d12c7db
Message-ID: <202512031041.EOXHlXyA-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_180608_478873_20D44735 
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.19
branch HEAD: fd87c8a7982fdb555133a6d225b636984d12c7db  nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

elapsed time: 1460m

configs tested: 165
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251202    gcc-8.5.0
arc                   randconfig-002-20251202    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                         assabet_defconfig    clang-18
arm                                 defconfig    clang-22
arm                            dove_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251202    clang-17
arm                   randconfig-002-20251202    clang-22
arm                   randconfig-003-20251202    clang-22
arm                   randconfig-004-20251202    gcc-14.3.0
arm                        vexpress_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251202    clang-22
arm64                 randconfig-002-20251202    clang-22
arm64                 randconfig-003-20251202    clang-16
arm64                 randconfig-004-20251202    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251202    gcc-13.4.0
csky                  randconfig-002-20251202    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251202    clang-22
hexagon               randconfig-002-20251202    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251202    clang-20
i386        buildonly-randconfig-002-20251202    gcc-14
i386        buildonly-randconfig-003-20251202    clang-20
i386        buildonly-randconfig-004-20251202    clang-20
i386        buildonly-randconfig-005-20251202    clang-20
i386        buildonly-randconfig-006-20251202    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251202    clang-20
i386                  randconfig-002-20251202    gcc-14
i386                  randconfig-003-20251202    gcc-14
i386                  randconfig-004-20251202    clang-20
i386                  randconfig-005-20251202    gcc-14
i386                  randconfig-006-20251202    clang-20
i386                  randconfig-007-20251202    clang-20
i386                  randconfig-011-20251203    clang-20
i386                  randconfig-012-20251203    gcc-14
i386                  randconfig-013-20251203    clang-20
i386                  randconfig-014-20251203    gcc-14
i386                  randconfig-015-20251203    gcc-13
i386                  randconfig-016-20251203    clang-20
i386                  randconfig-017-20251203    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251202    gcc-15.1.0
loongarch             randconfig-002-20251202    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
mips                         rt305x_defconfig    clang-22
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251202    gcc-8.5.0
nios2                 randconfig-002-20251202    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251202    gcc-9.5.0
parisc                randconfig-002-20251202    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251202    clang-22
powerpc               randconfig-002-20251202    gcc-10.5.0
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251202    clang-22
powerpc64             randconfig-002-20251202    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251202    gcc-9.5.0
riscv                 randconfig-002-20251202    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251202    clang-17
s390                  randconfig-002-20251202    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251202    gcc-15.1.0
sh                    randconfig-002-20251202    gcc-12.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251202    gcc-8.5.0
sparc                 randconfig-002-20251202    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251202    gcc-8.5.0
sparc64               randconfig-002-20251202    gcc-10.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251202    clang-17
um                    randconfig-002-20251202    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251202    gcc-14
x86_64      buildonly-randconfig-002-20251202    gcc-14
x86_64      buildonly-randconfig-003-20251202    clang-20
x86_64      buildonly-randconfig-004-20251202    gcc-13
x86_64      buildonly-randconfig-005-20251202    gcc-14
x86_64      buildonly-randconfig-006-20251202    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251202    clang-20
x86_64                randconfig-002-20251202    clang-20
x86_64                randconfig-003-20251202    gcc-14
x86_64                randconfig-004-20251202    gcc-14
x86_64                randconfig-005-20251202    gcc-14
x86_64                randconfig-006-20251202    clang-20
x86_64                randconfig-011-20251202    clang-20
x86_64                randconfig-012-20251202    gcc-13
x86_64                randconfig-013-20251202    gcc-14
x86_64                randconfig-014-20251202    clang-20
x86_64                randconfig-015-20251202    clang-20
x86_64                randconfig-016-20251202    clang-20
x86_64                randconfig-071-20251202    clang-20
x86_64                randconfig-072-20251202    clang-20
x86_64                randconfig-073-20251202    clang-20
x86_64                randconfig-074-20251202    clang-20
x86_64                randconfig-075-20251202    clang-20
x86_64                randconfig-076-20251202    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251202    gcc-11.5.0
xtensa                randconfig-002-20251202    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

