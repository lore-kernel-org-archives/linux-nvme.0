Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C784EB64DC
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jul 2023 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VlhYpj+uVBexedXmW/ng1H9s+Re3FSYewWaAvj7oIUg=; b=SgCvobWrhTw2RwqSsfcinGG3Nr
	iQTB075JA+X8I75JX/MFhjXOZ0tqiLPDtGAqRmkyfSSK4blZko0xDUdARwd6vawi3RZQry65SL390
	NQagYPT3FHEGlMXHJFKll3EqPg0EznmcBJU/KRLTUVm5Ga4OfhA/hrfNSFHx1BxFgBddPdgD23KDr
	agPMD5F598oVCCzqV6s6LhCxNal4oq35ifPXEVmh6NYGd70SbXv370HGX/kAVkWScgu+P0UkZ8DUk
	pfBUSy9YmzLPHY2rdTwmecFrs3m+L8Rsl0m0wAqKhyBThA/DEF7zAmJaOIzE/I8sKRZtI1SFxM9Rl
	B/F9ObMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFUDL-005HrR-04;
	Sat, 01 Jul 2023 06:36:11 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFUDH-005Hqr-1i
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jul 2023 06:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688193367; x=1719729367;
  h=date:from:to:cc:subject:message-id;
  bh=BBXLtg0G9S1thI0Qy6/y58aHsAklLVcl0W/KyXZgqlQ=;
  b=I3UyO/vsSvNbVBpOFsfVyugPneFfWRt1fGFsqjuPnebFizRlpKKNdD83
   5nDQZK7yNTGWeF9rTUzdzHMmLU+3Fwr9HHKKM6LUx9789LL5ldYS02lsQ
   LazNOCm6XiiLVxc99ipbzIlXeb2lPva89StvmZ8UgeMMY7OPc8vYvMQ+b
   80yZTgTTT6ZZWqKwUl6zd+RGsQGhAC8PGhzjUCM6+ZJgvlQKTRbsnZOiE
   2+O2f7GQRCuDgk8gQEZldl4S+HQxYjmtNlpnDmOO69Cf1lhtaxdFxVwEg
   kyHbJoGzg3BFy1qe4BjKjH5WQOPCt7gXSr7p11cxcDOYgjmj5aITmbz64
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="347340292"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="347340292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 23:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="842105242"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="842105242"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 23:36:00 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qFUD9-000Flw-10;
	Sat, 01 Jul 2023 06:35:59 +0000
Date: Sat, 01 Jul 2023 14:35:18 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 4e69d4dabd2379af57b0b8fb9b0d62c23f9cd3b8
Message-ID: <202307011416.r5pCmdjD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_233607_670199_8063CEE5 
X-CRM114-Status: UNSURE (   6.28  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.5
branch HEAD: 4e69d4dabd2379af57b0b8fb9b0d62c23f9cd3b8  nvme: disable controller on reset state failure

elapsed time: 721m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230629   gcc  
alpha                randconfig-r025-20230629   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230630   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r012-20230630   gcc  
arm                  randconfig-r032-20230629   clang
arm                  randconfig-r046-20230630   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230630   gcc  
arm64                randconfig-r014-20230630   clang
arm64                randconfig-r015-20230630   clang
arm64                randconfig-r021-20230629   clang
arm64                randconfig-r031-20230629   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230630   gcc  
csky                 randconfig-r024-20230629   gcc  
hexagon              randconfig-r041-20230630   clang
hexagon              randconfig-r045-20230630   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230629   gcc  
i386         buildonly-randconfig-r005-20230629   gcc  
i386         buildonly-randconfig-r006-20230629   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230629   clang
i386                 randconfig-i012-20230629   clang
i386                 randconfig-i013-20230629   clang
i386                 randconfig-i014-20230629   clang
i386                 randconfig-i015-20230629   clang
i386                 randconfig-i016-20230629   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230629   gcc  
m68k                 randconfig-r034-20230629   gcc  
m68k                           virt_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                 randconfig-r002-20230630   clang
mips                 randconfig-r013-20230630   gcc  
mips                 randconfig-r026-20230629   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r036-20230629   gcc  
openrisc                         alldefconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230629   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230630   gcc  
riscv                randconfig-r023-20230629   clang
riscv                randconfig-r042-20230630   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230630   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230630   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230629   gcc  
x86_64       buildonly-randconfig-r002-20230629   gcc  
x86_64       buildonly-randconfig-r003-20230629   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230630   clang
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

