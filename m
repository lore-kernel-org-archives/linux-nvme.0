Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAC8CD5BA4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZTxOplBZ99WL6ryOZcDkrImxZ1QQ0yKjzGXBNfq8f4c=; b=ElvD2e0Okz0x01Cpj/lyXguJFY
	0zI6w3Ymf0cBad2+x4AV2jIbbiBZ4jjxxJ0EAlUMmiXw0Gx6pF5X8UHFM6KLVd3C/hCbRJT+bPr2F
	kSLdaEcYCmG2uNLWwJ+3iKtccR4+srk07KyMg/Pg4VZaQtv0G54v8krt6l4WMTyg6P56Ay1zTWGCC
	62QZtOkNZPM3IljayRqBEmKToi47HmfliKAoThwoeve5wKjDktp5nr7oXYwVNiA6b7uIdGnI8vup0
	+6kWfu6iW5ZSHhjRxBcJMiliB8JRr20ChetlMPwJfYc5x6vKW7raD9FygwO8J55c6FJ3Mx3a6JC7Y
	mfCWeYmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPz3I-00000007CZ3-1rmf;
	Thu, 21 May 2026 08:46:48 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPz3F-00000007CYT-3w2W
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 08:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779353205; x=1810889205;
  h=date:from:to:cc:subject:message-id;
  bh=2a6AGTjQO5A4MjwBsv3g//zbgaB+yFxsILGts7KQovw=;
  b=gBlERSOQo2mFe+ZozSnpxc+x3bFWIXnUyxBzuLG1tmr5AwX9Qe1aZDKk
   1FA3p8X+Lb/lZQEiHGDSvGcx07J8xhxQ5Ax/wNVx1xbyG8wV9KCFb6ZPg
   Xr6CgiV1HL/safjsQ99GeL9OY4s7QajLeTz3GmGDGEWv69xJv5aP4cwx1
   IwpJjg+DZo7BHku+cCgigiHFfCQcSztV7TNLm1axc4goOGVUKMnxNXF8M
   TI7E698x5helT68LjBJREtDkxE2I2txWwyFOvpzeLb6Y4gWI8afTQAcAX
   IGhtWf3/jv8W8ssU3tWqnX691fVsgU6Iz2KZgwo3G4wc3NOgsam6c6L9J
   Q==;
X-CSE-ConnectionGUID: 0K6ocfUOQ6uXtVtnMXrZ4w==
X-CSE-MsgGUID: lothmA3kSo+PB86NelcZ/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97838940"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="97838940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:46:45 -0700
X-CSE-ConnectionGUID: DmI+fwl2TRKZmWI2UvjFaw==
X-CSE-MsgGUID: 5C7b0xAjSkm2poyMPFwl9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="245504024"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2026 01:46:44 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPz3B-000000004gH-3z59;
	Thu, 21 May 2026 08:46:41 +0000
Date: Thu, 21 May 2026 16:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.2] BUILD SUCCESS WITH UNVERIFIED WARNING
 00d7b33351aac0ea55d17167561e12bbeca73138
Message-ID: <202605211625.OlcUBnsf-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_014646_024355_2E3B32CE 
X-CRM114-Status: UNSURE (   4.01  )
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
branch HEAD: 00d7b33351aac0ea55d17167561e12bbeca73138  nvme-core: warn on allocating admin tag set with existing queue

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202605211257.STzj2Ujv-lkp@intel.com

    drivers/nvme/host/core.c:5259 nvme_wait_freeze_timeout() warn: 'timeout' unsigned <= 0
    drivers/nvme/host/core.c:5261 nvme_wait_freeze_timeout() warn: 'timeout' unsigned <= 0

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20260521
|   `-- drivers-nvme-host-core.c-nvme_wait_freeze_timeout()-warn:timeout-unsigned
`-- s390-randconfig-r073-20260521
    `-- drivers-nvme-host-core.c-nvme_wait_freeze_timeout()-warn:timeout-unsigned

elapsed time: 767m

configs tested: 203
configs skipped: 2

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
arc                   randconfig-001-20260521    gcc-8.5.0
arc                   randconfig-002-20260521    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20260521    gcc-8.5.0
arm                   randconfig-002-20260521    gcc-8.5.0
arm                   randconfig-003-20260521    gcc-8.5.0
arm                   randconfig-004-20260521    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260521    gcc-8.5.0
arm64                 randconfig-002-20260521    gcc-8.5.0
arm64                 randconfig-003-20260521    gcc-8.5.0
arm64                 randconfig-004-20260521    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260521    gcc-8.5.0
csky                  randconfig-002-20260521    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260521    gcc-11.5.0
hexagon               randconfig-002-20260521    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260521    clang-20
i386        buildonly-randconfig-002-20260521    clang-20
i386        buildonly-randconfig-003-20260521    clang-20
i386        buildonly-randconfig-004-20260521    clang-20
i386        buildonly-randconfig-005-20260521    clang-20
i386        buildonly-randconfig-006-20260521    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260521    clang-20
i386                  randconfig-002-20260521    clang-20
i386                  randconfig-003-20260521    clang-20
i386                  randconfig-004-20260521    clang-20
i386                  randconfig-005-20260521    clang-20
i386                  randconfig-006-20260521    clang-20
i386                  randconfig-007-20260521    clang-20
i386                  randconfig-011-20260521    gcc-14
i386                  randconfig-012-20260521    gcc-14
i386                  randconfig-013-20260521    gcc-14
i386                  randconfig-014-20260521    gcc-14
i386                  randconfig-015-20260521    gcc-14
i386                  randconfig-016-20260521    gcc-14
i386                  randconfig-017-20260521    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260521    gcc-11.5.0
loongarch             randconfig-002-20260521    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         rt305x_defconfig    clang-23
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260521    gcc-11.5.0
nios2                 randconfig-002-20260521    gcc-11.5.0
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
parisc                randconfig-001-20260521    gcc-12.5.0
parisc                randconfig-002-20260521    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260521    gcc-12.5.0
powerpc               randconfig-002-20260521    gcc-12.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260521    gcc-12.5.0
powerpc64             randconfig-002-20260521    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260521    gcc-15.2.0
riscv                 randconfig-002-20260521    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260521    gcc-15.2.0
s390                  randconfig-002-20260521    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260521    gcc-15.2.0
sh                    randconfig-002-20260521    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260521    gcc-8.5.0
sparc                 randconfig-002-20260521    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260521    gcc-8.5.0
sparc64               randconfig-002-20260521    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260521    gcc-8.5.0
um                    randconfig-002-20260521    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260521    clang-20
x86_64      buildonly-randconfig-002-20260521    clang-20
x86_64      buildonly-randconfig-003-20260521    clang-20
x86_64      buildonly-randconfig-004-20260521    clang-20
x86_64      buildonly-randconfig-005-20260521    clang-20
x86_64      buildonly-randconfig-006-20260521    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260521    clang-20
x86_64                randconfig-002-20260521    clang-20
x86_64                randconfig-003-20260521    clang-20
x86_64                randconfig-004-20260521    clang-20
x86_64                randconfig-005-20260521    clang-20
x86_64                randconfig-006-20260521    clang-20
x86_64                randconfig-011-20260521    gcc-14
x86_64                randconfig-012-20260521    gcc-14
x86_64                randconfig-013-20260521    gcc-14
x86_64                randconfig-014-20260521    gcc-14
x86_64                randconfig-015-20260521    gcc-14
x86_64                randconfig-016-20260521    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260521    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260521    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260521    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260521    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260521    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260521    clang-20
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
xtensa                randconfig-001-20260521    gcc-8.5.0
xtensa                randconfig-002-20260521    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

