Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1A6C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+voEfVVgKOoyrSUOia2sgm9jNU+js1Ltsn07aSm3gjU=; b=ZQ8jRo71wr2keJi8TlBj3xs8t0
	oNCBVESyX1oZgKJ1+DEJQrRVO4HlQbblyOyfyN2bh3VSzU4dHS50GmzKIOUqHjXM6SFqFYLxTZ7aw
	al34iyD2ZXBqcgUT2p5vI9I2HvcYvZAkk1N5drsv6lXC4Ur7U06coD2xzhpdyh2IkVlDx4BdPyD8w
	ntBXL2urNSY51iAkL3hCHuQDOTFaTusx4x0E/DhrgIBLtuSdmvCb6xjQtH4QF34w0fhwaiaXmVfJS
	/uwID2ez+R9emNt2pnsBWrRuA9FAzJgjOQMpAotvhh+fijgjV+5wP8i/IZd4K/QmnwYcE0froUGM0
	pRmhJ1OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBNxG-00EEaA-1J;
	Thu, 07 Dec 2023 23:38:54 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBNxD-00EEZ9-2G
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 23:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701992332; x=1733528332;
  h=date:from:to:cc:subject:message-id;
  bh=L/GkLTrhMZ2wnp8bFG9S3lWy91go8Cz10t3xJlEQROE=;
  b=CNEpr5yMiZ+va6+WVcQ3flzD8+//VaFBBVKpRY9Homlyg7DLqqnTDJmj
   gBDeva8Nec20ZejJeCtHBDe51FvMhsu4TBdQtrPbBNdYUX9Oi0V4g9XqM
   fu1BWkbs3TyMi7aayVfZS73yoPWTz/FjnoYmWX0QLI7ynhUHMtYtnYXfd
   qrQYO4ZD+bsSl4UvFGJP+TDPlpdRHTqvRp6fVgBDKgP4yekhN/s8qYznh
   0IvSIqhxeWqQR4ZZaHBF4+T5DfmNHfkLmp0gHArjOT/Uk/a8iddQnJRTN
   nloiLtQysAKREl6w0+6SY6IYhVld574E9sParzT14u3/sHuaOCYOX8Ymp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7644075"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7644075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842390179"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="842390179"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 15:38:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBNx3-000Cz6-15;
	Thu, 07 Dec 2023 23:38:41 +0000
Date: Fri, 08 Dec 2023 07:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 2fcd3ab398260a113fd4434b4d72929066c73121
Message-ID: <202312080742.PyP0qI33-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_153851_754571_E0F92E92 
X-CRM114-Status: UNSURE (   6.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.8
branch HEAD: 2fcd3ab398260a113fd4434b4d72929066c73121  nvme-fabrics: check ioccsz and iorcsz

elapsed time: 1471m

configs tested: 229
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-001-20231208   gcc  
arc                   randconfig-002-20231207   gcc  
arc                   randconfig-002-20231208   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-001-20231208   gcc  
csky                  randconfig-002-20231207   gcc  
csky                  randconfig-002-20231208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231207   gcc  
i386         buildonly-randconfig-002-20231207   gcc  
i386         buildonly-randconfig-003-20231207   gcc  
i386         buildonly-randconfig-004-20231207   gcc  
i386         buildonly-randconfig-005-20231207   gcc  
i386         buildonly-randconfig-006-20231207   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231207   gcc  
i386                  randconfig-002-20231207   gcc  
i386                  randconfig-003-20231207   gcc  
i386                  randconfig-004-20231207   gcc  
i386                  randconfig-005-20231207   gcc  
i386                  randconfig-006-20231207   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231207   clang
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231207   clang
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231207   clang
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231207   clang
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231207   clang
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-001-20231208   gcc  
loongarch             randconfig-002-20231207   gcc  
loongarch             randconfig-002-20231208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-001-20231208   gcc  
nios2                 randconfig-002-20231207   gcc  
nios2                 randconfig-002-20231208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-001-20231208   gcc  
parisc                randconfig-002-20231207   gcc  
parisc                randconfig-002-20231208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231208   gcc  
s390                  randconfig-002-20231208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-001-20231208   gcc  
sh                    randconfig-002-20231207   gcc  
sh                    randconfig-002-20231208   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-001-20231208   gcc  
sparc64               randconfig-002-20231207   gcc  
sparc64               randconfig-002-20231208   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-001-20231208   clang
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-002-20231208   clang
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-003-20231208   clang
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-004-20231208   clang
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-005-20231208   clang
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64       buildonly-randconfig-006-20231208   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-011-20231208   clang
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-012-20231208   clang
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-013-20231208   clang
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-014-20231208   clang
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-015-20231208   clang
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-016-20231208   clang
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-071-20231208   clang
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-072-20231208   clang
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-073-20231208   clang
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-074-20231208   clang
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-075-20231208   clang
x86_64                randconfig-076-20231207   gcc  
x86_64                randconfig-076-20231208   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-001-20231208   gcc  
xtensa                randconfig-002-20231207   gcc  
xtensa                randconfig-002-20231208   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

