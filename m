Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DFCC98318
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 23:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LtQu+QbM6csCAGKavYAHOnHuh70TQbYWCmtMhj20+mI=; b=aIvJ7HULNq4vD5VH8rIeBgIueL
	XBZxMvlZpYPtfDQYyllgPyI9RHU+TvEhqcz63ySMGkzHg1111+kBMS2D1PUNealu2UpK8AKE13f6O
	YGA/AZbyo8S7CLxEdN9nQ2a1LcXsrlFlpUp2Yhy0GLtufvdnRPFxlp74IlsdVNyzPgoalbPWMIUWC
	tpvuscNe/w9sJg6jXYZamuXHyF6StTQWkgY4xKws/HaKxm+OnXSxZlyPyM4LT5QX8Itr7d25U96hF
	HbBYy7oW+AGSWFCRDM4FaDD5zHnvVDnMOvoxBxn0NrdlqDTwRqVfi320VzIuOz8IzlmARLpSculzu
	IFW94nNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9tG0-0000000CPei-0wQy;
	Thu, 24 Sep 2026 23:53:40 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9tFx-0000000CPdd-3F3Y
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 23:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790294018; x=1821830018;
  h=date:from:to:cc:subject:message-id;
  bh=lx/3crZwUvUM8eR96/I/9FTuvHP7/g+vePkXqwblhqc=;
  b=X2p27LFKiyZmSvjHyZazZUdBlj6ODup3OBL0xHi4+4SgiM3lMAFlW8J/
   9G0SWYilg0ZSyY3fz+UJy1lgOhmscL+BIj2WthOnGz7hY/T8rcIp3yhDg
   EbvZ5n+dxQzZoyp1K54F5vogch+7FWAPSBfMGsRQvxonzTtYuh2bBvDDv
   zVDjlhspGs5U/PHgcuOOcAOCxoDnCwj9il4fsT/wkcfc2S/N0Kh2WiGYk
   vryTyyJPDX9Q/siJxKb/ekQvAhBqin5aTku/jkK38h9RhDxHIHjKEXTFA
   0uxSnB3/CHZoIOncoylehwVOSA1Oew7ehaB/5ZskDNuCpjikY0AxhXEwG
   Q==;
X-CSE-ConnectionGUID: mF1R2IhiTWaOyXYilb0upg==
X-CSE-MsgGUID: jGNz4Oo8QLqE7iBQMUemKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90122785"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="90122785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 16:53:37 -0700
X-CSE-ConnectionGUID: 8j/9L9lqR2CWG86iMlHA+Q==
X-CSE-MsgGUID: ZLVzdBilRuG97B2krg7KRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273670644"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 16:53:31 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9tFo-00000000Joo-2LmA;
	Thu, 24 Sep 2026 23:53:28 +0000
Date: Fri, 25 Sep 2026 07:52:52 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS
 a2e4a89ed58100163ae36494ea07775f09f72e42
Message-ID: <202609250750.1jTjur6E-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_165337_918593_69EF4A28 
X-CRM114-Status: UNSURE (   5.15  )
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
branch HEAD: a2e4a89ed58100163ae36494ea07775f09f72e42  nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known

elapsed time: 3300m

configs tested: 255
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1303-20260925    gcc-14.3.0 sparse
alpha                randconfig-r1304-20260924    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260924    clang-24
arc                   randconfig-1000-20260925    clang-24
arc                   randconfig-1001-20260924    clang-24
arc                   randconfig-1001-20260925    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20260924    clang-24
arm                   randconfig-1000-20260925    clang-24
arm                   randconfig-1001-20260924    clang-24
arm                   randconfig-1001-20260925    clang-24
arm                   randconfig-1002-20260924    clang-24
arm                   randconfig-1002-20260925    clang-24
arm                   randconfig-1003-20260924    clang-24
arm                   randconfig-1003-20260925    clang-24
arm                  randconfig-r1305-20260924    gcc-16.1.0 sparse
arm                         spear6xx_defconfig    clang-24
arm                            stm32_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260924    gcc-11.5.0
arm64                 randconfig-1001-20260924    gcc-11.5.0
arm64                 randconfig-1002-20260924    gcc-11.5.0
arm64                 randconfig-1003-20260924    gcc-11.5.0
arm64                randconfig-r1302-20260924    gcc-16.1.0 sparse
arm64                randconfig-r1307-20260924    gcc-11.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260924    gcc-11.5.0
csky                  randconfig-1001-20260924    gcc-11.5.0
csky                 randconfig-r1300-20260924    gcc-16.1.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260924    gcc-8.5.0
hexagon               randconfig-1000-20260925    gcc-9.5.0
hexagon               randconfig-1001-20260924    gcc-8.5.0
hexagon               randconfig-1001-20260925    gcc-9.5.0
hexagon              randconfig-r1301-20260924    gcc-16.1.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260924    gcc-14
i386        buildonly-randconfig-1000-20260925    clang-22
i386        buildonly-randconfig-1001-20260924    gcc-14
i386        buildonly-randconfig-1001-20260925    clang-22
i386        buildonly-randconfig-1002-20260924    gcc-14
i386        buildonly-randconfig-1002-20260925    clang-22
i386        buildonly-randconfig-1003-20260924    gcc-14
i386        buildonly-randconfig-1003-20260925    clang-22
i386        buildonly-randconfig-1004-20260924    gcc-14
i386        buildonly-randconfig-1004-20260925    clang-22
i386        buildonly-randconfig-1005-20260924    gcc-14
i386        buildonly-randconfig-1005-20260925    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260924    gcc-12
i386                  randconfig-1001-20260924    gcc-12
i386                  randconfig-1002-20260924    gcc-12
i386                  randconfig-1003-20260924    gcc-12
i386                  randconfig-1004-20260924    gcc-12
i386                  randconfig-1005-20260924    gcc-12
i386                  randconfig-1006-20260924    gcc-12
i386                  randconfig-1007-20260924    clang-22
i386                  randconfig-1008-20260924    clang-22
i386                  randconfig-1009-20260924    clang-22
i386                  randconfig-1010-20260924    clang-22
i386                  randconfig-1011-20260924    clang-22
i386                  randconfig-1012-20260924    clang-22
i386                  randconfig-1013-20260924    clang-22
i386                  randconfig-1300-20260924    clang-22   sparse
i386                  randconfig-1301-20260924    clang-22   sparse
i386                  randconfig-1302-20260924    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260924    gcc-8.5.0
loongarch             randconfig-1000-20260925    gcc-9.5.0
loongarch             randconfig-1001-20260924    gcc-8.5.0
loongarch             randconfig-1001-20260925    gcc-9.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r1304-20260925    gcc-14.3.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                 randconfig-r1309-20260924    gcc-11.5.0 sparse
mips                            xway_defconfig    clang-24
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260924    gcc-8.5.0
nios2                 randconfig-1000-20260925    gcc-9.5.0
nios2                 randconfig-1001-20260924    gcc-8.5.0
nios2                 randconfig-1001-20260925    gcc-9.5.0
nios2                randconfig-r1303-20260924    gcc-16.1.0 sparse
nios2                randconfig-r1306-20260924    gcc-11.5.0 sparse
openrisc                          allmodconfig    gcc-11.5.0
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    clang-24
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260924    gcc-8.5.0
parisc                randconfig-1000-20260925    clang-24
parisc                randconfig-1001-20260924    gcc-8.5.0
parisc                randconfig-1001-20260925    clang-24
parisc               randconfig-r1301-20260925    gcc-14.3.0 sparse
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                       mgcoge_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260924    gcc-8.5.0
powerpc               randconfig-1000-20260925    clang-24
powerpc               randconfig-1001-20260924    gcc-8.5.0
powerpc               randconfig-1001-20260925    clang-24
powerpc64             randconfig-1000-20260924    gcc-8.5.0
powerpc64             randconfig-1000-20260925    clang-24
powerpc64             randconfig-1001-20260924    gcc-8.5.0
powerpc64             randconfig-1001-20260925    clang-24
powerpc64            randconfig-r1300-20260925    gcc-14.3.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260924    gcc-15.2.0
riscv                 randconfig-1000-20260925    clang-24
riscv                 randconfig-1001-20260924    gcc-15.2.0
riscv                 randconfig-1001-20260925    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260924    gcc-15.2.0
s390                  randconfig-1000-20260925    clang-24
s390                  randconfig-1001-20260924    gcc-15.2.0
s390                  randconfig-1001-20260925    clang-24
s390                 randconfig-r1308-20260924    gcc-11.5.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260924    gcc-15.2.0
sh                    randconfig-1000-20260925    clang-24
sh                    randconfig-1001-20260924    gcc-15.2.0
sh                    randconfig-1001-20260925    clang-24
sh                   randconfig-r1305-20260925    gcc-14.3.0 sparse
sh                            se7780_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260924    clang-17
sparc                 randconfig-1000-20260925    gcc-12
sparc                 randconfig-1001-20260924    clang-17
sparc                 randconfig-1001-20260925    gcc-12
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260924    clang-17
sparc64               randconfig-1000-20260925    gcc-12
sparc64               randconfig-1001-20260924    clang-17
sparc64               randconfig-1001-20260925    gcc-12
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260924    clang-17
um                    randconfig-1000-20260925    gcc-12
um                    randconfig-1001-20260924    clang-17
um                    randconfig-1001-20260925    gcc-12
um                   randconfig-r1302-20260925    gcc-14.3.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260924    clang-22
x86_64      buildonly-randconfig-1000-20260925    clang-22
x86_64      buildonly-randconfig-1001-20260924    clang-22
x86_64      buildonly-randconfig-1001-20260925    clang-22
x86_64      buildonly-randconfig-1002-20260924    clang-22
x86_64      buildonly-randconfig-1002-20260925    clang-22
x86_64      buildonly-randconfig-1003-20260924    clang-22
x86_64      buildonly-randconfig-1003-20260925    clang-22
x86_64      buildonly-randconfig-1004-20260924    clang-22
x86_64      buildonly-randconfig-1004-20260925    clang-22
x86_64      buildonly-randconfig-1005-20260924    clang-22
x86_64      buildonly-randconfig-1005-20260925    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260924    clang-22
x86_64                randconfig-1000-20260925    gcc-14
x86_64                randconfig-1001-20260924    clang-22
x86_64                randconfig-1001-20260925    gcc-14
x86_64                randconfig-1002-20260924    clang-22
x86_64                randconfig-1002-20260925    gcc-14
x86_64                randconfig-1003-20260924    clang-22
x86_64                randconfig-1003-20260925    gcc-14
x86_64                randconfig-1004-20260924    clang-22
x86_64                randconfig-1004-20260925    gcc-14
x86_64                randconfig-1005-20260924    clang-22
x86_64                randconfig-1005-20260925    gcc-14
x86_64                randconfig-1006-20260924    clang-22
x86_64                randconfig-1006-20260925    clang-22
x86_64                randconfig-1007-20260924    clang-22
x86_64                randconfig-1007-20260925    clang-22
x86_64                randconfig-1008-20260924    clang-22
x86_64                randconfig-1008-20260925    clang-22
x86_64                randconfig-1009-20260924    clang-22
x86_64                randconfig-1009-20260925    clang-22
x86_64                randconfig-1010-20260924    clang-22
x86_64                randconfig-1010-20260925    clang-22
x86_64                randconfig-1011-20260924    clang-22
x86_64                randconfig-1011-20260925    clang-22
x86_64                randconfig-1012-20260924    clang-22
x86_64                randconfig-1013-20260924    clang-22
x86_64                randconfig-1014-20260924    clang-22
x86_64                randconfig-1015-20260924    clang-22
x86_64                randconfig-1016-20260924    clang-22
x86_64                randconfig-1017-20260924    clang-22
x86_64                randconfig-1300-20260924    clang-22   sparse
x86_64                randconfig-1301-20260924    clang-22   sparse
x86_64                randconfig-1302-20260924    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                randconfig-1000-20260924    clang-17
xtensa                randconfig-1000-20260925    gcc-12
xtensa                randconfig-1001-20260924    clang-17
xtensa                randconfig-1001-20260925    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

