Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C47C3DA49
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1D7dgKg+PbpNa+rWjhxPp3vL8U1tCp307+VqW1l1Wi0=; b=1d7uHv5sur5l/UiOj+MpB6fQtt
	6qRLJFW+8CYy/3C/UQe/SCBIcd7fcQT4VExme3ETEj+hMuzktg73riOF9X4BqxbGKJ+fOhbr657s1
	/d5qrn8G/VnVhW3obeR8+U66rG/UfEzpvJjTDpEXqsICkHMWkR034Y61FDcB1QbxL01A1HoRyBne/
	fB6kk3NjP1b0a3BPxawobZgl2lcveQPzesIteV2+D2hoWTFuqhYwVCBoHXBubxnWeIIWqqWHFsg2y
	rNiQNRH8lw9RkpfnnUhAPpwYyzW+VYjduLIT+NfFhEJiP5YGVftkic/FguZXhcyx8mpEAc0jyzhzT
	a5HFg1Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFpk-00000003FQV-3uA4;
	Fri, 26 Jul 2024 07:57:48 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFph-00000003FPo-2tAB
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 07:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721980666; x=1753516666;
  h=date:from:to:cc:subject:message-id;
  bh=cwFYHKQlNZg0QHWI95F/dKOfbdu8xg23avwOGCNna/k=;
  b=ZvMKpcXSNWAG8TLE4aA9LF/sIiWMSLU7Z4Z47ghsY34RsopSypuUFdF9
   LAJ3y2jInJqEJ9UW6zA7Da/yl052nOMI8PHXqbulTYg4VMlnI1GQTqgP9
   /3UTB4cC6ENEltG3J0auNYKZ4ps0cTTr2UJKttnFSyJYISq4QboUALCfY
   Oqr7PWbPbxpjN0tFeTpOhW8kGPVLiK6Phije96w82/0Tn4bmHii0kltVP
   QQul5TC+6f83IZ/3UO2YpB9xp9mZ6nSew5t7BN1WaIz2rXcpOAMQSqImW
   w2m1J10VSuL8QVQQ5adkiC19yhPWNOn/IiBxM81W/UDokvt8PHAEcar+N
   g==;
X-CSE-ConnectionGUID: Xrg0cXVgRTee432K3Ch7aw==
X-CSE-MsgGUID: yQvQT1ZVRuejjmdIwX2ZbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19889271"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19889271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:57:44 -0700
X-CSE-ConnectionGUID: VwPaPSxPTkK/2qbKmwe6dg==
X-CSE-MsgGUID: XP/vKhbqRZ2JVRmQ9WMgPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="83826841"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jul 2024 00:57:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXFpc-000otO-0B;
	Fri, 26 Jul 2024 07:57:40 +0000
Date: Fri, 26 Jul 2024 15:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 c31fad1470389666ac7169fe43aa65bf5b7e2cfd
Message-ID: <202407261544.HUNo59m0-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_005745_832343_AA369F5E 
X-CRM114-Status: UNSURE (   5.52  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: c31fad1470389666ac7169fe43aa65bf5b7e2cfd  nvme-pci: add missing condition check for existence of mapped data

elapsed time: 1042m

configs tested: 233
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240726   gcc-13.2.0
arc                   randconfig-002-20240726   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240726   gcc-14.1.0
arm                   randconfig-002-20240726   gcc-14.1.0
arm                   randconfig-003-20240726   clang-20
arm                   randconfig-004-20240726   clang-20
arm                           sama7_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                       versatile_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240726   clang-15
arm64                 randconfig-002-20240726   gcc-14.1.0
arm64                 randconfig-003-20240726   gcc-14.1.0
arm64                 randconfig-004-20240726   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240726   gcc-14.1.0
csky                  randconfig-002-20240726   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240726   clang-20
hexagon               randconfig-002-20240726   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240726   gcc-13
i386         buildonly-randconfig-002-20240726   clang-18
i386         buildonly-randconfig-002-20240726   gcc-13
i386         buildonly-randconfig-003-20240726   gcc-13
i386         buildonly-randconfig-004-20240726   clang-18
i386         buildonly-randconfig-004-20240726   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-7
i386         buildonly-randconfig-006-20240726   clang-18
i386         buildonly-randconfig-006-20240726   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240726   gcc-13
i386                  randconfig-002-20240726   gcc-13
i386                  randconfig-003-20240726   clang-18
i386                  randconfig-003-20240726   gcc-13
i386                  randconfig-004-20240726   gcc-13
i386                  randconfig-005-20240726   clang-18
i386                  randconfig-005-20240726   gcc-13
i386                  randconfig-006-20240726   clang-18
i386                  randconfig-006-20240726   gcc-13
i386                  randconfig-011-20240726   gcc-13
i386                  randconfig-012-20240726   gcc-13
i386                  randconfig-012-20240726   gcc-8
i386                  randconfig-013-20240726   gcc-10
i386                  randconfig-013-20240726   gcc-13
i386                  randconfig-014-20240726   gcc-13
i386                  randconfig-015-20240726   clang-18
i386                  randconfig-015-20240726   gcc-13
i386                  randconfig-016-20240726   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240726   gcc-14.1.0
loongarch             randconfig-002-20240726   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5272c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240726   gcc-14.1.0
nios2                 randconfig-002-20240726   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
openrisc                       virt_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240726   gcc-14.1.0
parisc                randconfig-002-20240726   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240726   clang-20
powerpc               randconfig-002-20240726   gcc-14.1.0
powerpc               randconfig-003-20240726   gcc-14.1.0
powerpc64             randconfig-001-20240726   clang-20
powerpc64             randconfig-002-20240726   clang-20
powerpc64             randconfig-003-20240726   clang-20
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240726   gcc-14.1.0
riscv                 randconfig-002-20240726   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240726   gcc-14.1.0
s390                  randconfig-002-20240726   clang-16
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240726   gcc-14.1.0
sh                    randconfig-002-20240726   gcc-14.1.0
sh                          rsk7201_defconfig   gcc-13.2.0
sh                     sh7710voipgw_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240726   gcc-14.1.0
sparc64               randconfig-002-20240726   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240726   gcc-7
um                    randconfig-002-20240726   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240726   gcc-13
x86_64       buildonly-randconfig-002-20240726   gcc-13
x86_64       buildonly-randconfig-003-20240726   clang-18
x86_64       buildonly-randconfig-003-20240726   gcc-13
x86_64       buildonly-randconfig-004-20240726   gcc-13
x86_64       buildonly-randconfig-004-20240726   gcc-9
x86_64       buildonly-randconfig-005-20240726   gcc-13
x86_64       buildonly-randconfig-006-20240726   gcc-11
x86_64       buildonly-randconfig-006-20240726   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240726   gcc-13
x86_64                randconfig-002-20240726   gcc-13
x86_64                randconfig-002-20240726   gcc-8
x86_64                randconfig-003-20240726   gcc-13
x86_64                randconfig-004-20240726   gcc-13
x86_64                randconfig-005-20240726   gcc-13
x86_64                randconfig-006-20240726   gcc-10
x86_64                randconfig-006-20240726   gcc-13
x86_64                randconfig-011-20240726   gcc-11
x86_64                randconfig-011-20240726   gcc-13
x86_64                randconfig-012-20240726   clang-18
x86_64                randconfig-012-20240726   gcc-13
x86_64                randconfig-013-20240726   gcc-13
x86_64                randconfig-014-20240726   clang-18
x86_64                randconfig-014-20240726   gcc-13
x86_64                randconfig-015-20240726   gcc-11
x86_64                randconfig-015-20240726   gcc-13
x86_64                randconfig-016-20240726   clang-18
x86_64                randconfig-016-20240726   gcc-13
x86_64                randconfig-071-20240726   clang-18
x86_64                randconfig-071-20240726   gcc-13
x86_64                randconfig-072-20240726   clang-18
x86_64                randconfig-072-20240726   gcc-13
x86_64                randconfig-073-20240726   gcc-13
x86_64                randconfig-074-20240726   clang-18
x86_64                randconfig-074-20240726   gcc-13
x86_64                randconfig-075-20240726   gcc-13
x86_64                randconfig-075-20240726   gcc-7
x86_64                randconfig-076-20240726   gcc-11
x86_64                randconfig-076-20240726   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240726   gcc-14.1.0
xtensa                randconfig-002-20240726   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

