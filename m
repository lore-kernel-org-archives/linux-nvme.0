Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A156C5472D
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6SN9lLX07X3mghlwh/njye0r6qL9XU9tu3ScdVIthS8=; b=f/fJfuQa4uVX2EuMhLsmep1iy2
	JgaWPB5tkg5U2INoazfmlz9JpW46RXs+in+Y1Yne7rEU9UkC/WOc4MYl7Tq5YW4QkzcTGfMKx47ZP
	Jjztfy0YjWA6G2ADApNf1na488I3FsNWDjWEVg21VU4Pxi/pmmNnj0sDujM7ggrK19kIITlWu7din
	KHoiwjqT4ZIFfk2ZX9MNNFrszf4/lVw0Jxw9n61urR6iemw7K1Ipy3Vj/wBqzQ66n3X+cMRgSpyZJ
	N0JdDmtFVxgUrHkmKXW2gwMToyJXXVOYAyNVRWtfb2gt2YVfe83bTfOj6v8suQNxrgxK9BqctmZE5
	52d9ORpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shv8F-00000002egj-3fdb;
	Sat, 24 Aug 2024 18:04:59 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shv7Y-00000002eZG-0eup
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 18:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724522656; x=1756058656;
  h=date:from:to:cc:subject:message-id;
  bh=6rY+w3kptvRRd5X5RNyVvIFiQklm8mqezQ+xmtVEq5s=;
  b=fL9EsjjI/9yQQsPxbcb1v20hYJT7pwwJyIaKrsV0w+jktzIgjYhIWw7U
   Xe4NfZI3Oh6/TAK2GJl1KFuRx3l4oc4ThTepSEcTuY0o2AzvNPp8nR8St
   q6atm0zCJeXNuUoeKfdx+6Tv1LOxGxCTcFXqmfVN6kctsYhSZnmHPNwql
   D13lhVv0w2Ip4WFW3jQEqUiXsOnlc4pye8aDFDkUkIIAE/Ow968zntLbG
   UiZ+sut++qe/TsWmvbyUVIHwTvJiRAhtRuSgLoIyE88qEqvT26zj+dC+W
   wURoXh+BdA9zlMgD7PoKZ5mfQ4epdE+K1WvZAz/LfNomLJX3/M8Fu0PPH
   g==;
X-CSE-ConnectionGUID: VdiKLCsSTKKZUsoQe1n2XA==
X-CSE-MsgGUID: vB5jyHneTf+mh/FQQLDNLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33604819"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="33604819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 11:04:12 -0700
X-CSE-ConnectionGUID: +buLfAv6TZyJs0ByttzBRQ==
X-CSE-MsgGUID: P8AgyR8IR4aYiDRkzBIvvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66910971"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Aug 2024 11:04:11 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shv7Q-000EfD-2N;
	Sat, 24 Aug 2024 18:04:08 +0000
Date: Sun, 25 Aug 2024 02:03:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 5a6d3a638c93881b7a7c13df870238b91399578a
Message-ID: <202408250225.vbCJ4Hzc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_110416_234881_325A2CD9 
X-CRM114-Status: UNSURE (   4.49  )
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
branch HEAD: 5a6d3a638c93881b7a7c13df870238b91399578a  nvme: use better description for async reset reason

elapsed time: 1450m

configs tested: 177
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240824   gcc-13.2.0
arc                   randconfig-002-20240824   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-20
arm                      integrator_defconfig   clang-20
arm                       multi_v4t_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   clang-20
arm                   randconfig-001-20240824   gcc-13.2.0
arm                   randconfig-002-20240824   gcc-13.2.0
arm                   randconfig-003-20240824   gcc-13.2.0
arm                   randconfig-004-20240824   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                           spitz_defconfig   clang-20
arm                           sunxi_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240824   gcc-13.2.0
arm64                 randconfig-002-20240824   gcc-13.2.0
arm64                 randconfig-003-20240824   gcc-13.2.0
arm64                 randconfig-004-20240824   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240824   gcc-13.2.0
csky                  randconfig-002-20240824   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240824   clang-18
i386         buildonly-randconfig-002-20240824   clang-18
i386         buildonly-randconfig-003-20240824   clang-18
i386         buildonly-randconfig-004-20240824   clang-18
i386         buildonly-randconfig-005-20240824   clang-18
i386         buildonly-randconfig-006-20240824   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240824   clang-18
i386                  randconfig-002-20240824   clang-18
i386                  randconfig-003-20240824   clang-18
i386                  randconfig-004-20240824   clang-18
i386                  randconfig-005-20240824   clang-18
i386                  randconfig-006-20240824   clang-18
i386                  randconfig-011-20240824   clang-18
i386                  randconfig-012-20240824   clang-18
i386                  randconfig-013-20240824   clang-18
i386                  randconfig-014-20240824   clang-18
i386                  randconfig-015-20240824   clang-18
i386                  randconfig-016-20240824   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240824   gcc-13.2.0
loongarch             randconfig-002-20240824   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                         cobalt_defconfig   clang-20
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240824   gcc-13.2.0
nios2                 randconfig-002-20240824   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240824   gcc-13.2.0
parisc                randconfig-002-20240824   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   clang-20
powerpc                     ep8248e_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                      katmai_defconfig   clang-20
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      pasemi_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                     powernv_defconfig   clang-20
powerpc                      ppc64e_defconfig   clang-20
powerpc               randconfig-001-20240824   gcc-13.2.0
powerpc                     tqm8548_defconfig   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc                         wii_defconfig   clang-20
powerpc64             randconfig-001-20240824   gcc-13.2.0
powerpc64             randconfig-002-20240824   gcc-13.2.0
powerpc64             randconfig-003-20240824   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240824   gcc-13.2.0
riscv                 randconfig-002-20240824   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                          debug_defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240824   gcc-13.2.0
s390                  randconfig-002-20240824   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240824   gcc-13.2.0
sh                    randconfig-002-20240824   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240824   gcc-13.2.0
sparc64               randconfig-002-20240824   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240824   gcc-13.2.0
um                    randconfig-002-20240824   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240824   clang-18
x86_64       buildonly-randconfig-002-20240824   clang-18
x86_64       buildonly-randconfig-003-20240824   clang-18
x86_64       buildonly-randconfig-004-20240824   clang-18
x86_64       buildonly-randconfig-005-20240824   clang-18
x86_64       buildonly-randconfig-006-20240824   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240824   clang-18
x86_64                randconfig-002-20240824   clang-18
x86_64                randconfig-003-20240824   clang-18
x86_64                randconfig-004-20240824   clang-18
x86_64                randconfig-005-20240824   clang-18
x86_64                randconfig-006-20240824   clang-18
x86_64                randconfig-011-20240824   clang-18
x86_64                randconfig-012-20240824   clang-18
x86_64                randconfig-013-20240824   clang-18
x86_64                randconfig-014-20240824   clang-18
x86_64                randconfig-015-20240824   clang-18
x86_64                randconfig-016-20240824   clang-18
x86_64                randconfig-071-20240824   clang-18
x86_64                randconfig-072-20240824   clang-18
x86_64                randconfig-073-20240824   clang-18
x86_64                randconfig-074-20240824   clang-18
x86_64                randconfig-075-20240824   clang-18
x86_64                randconfig-076-20240824   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240824   gcc-13.2.0
xtensa                randconfig-002-20240824   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

