Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B18C47079
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rumhYu+ptHR0+6h/vJr4736meVxT/XvKqV+52tW5dFk=; b=TfDd3LhpjH/HD8i4ZDGegLavGU
	v9jJt5foweWIkNuoW+VJHxr9JdfGNzGQ14Q24sT8hcUPX8yWf/7qcKVVSln350cvuglbE9OAzHn4v
	gRcE5f566Z3/1g0Z2tO5RklTgCOsNULLCcA4p6EhLeROI9ERtk8+DnxNmhILwSv9sma2YIENfS/Xo
	qIL5b1cB+Edi1sJh/ZeGfjxu/R7OCa3vbvOkMHDvqPhxXRAKe7xGciDUv02Qqi2MAR+eH6U8AxDO7
	wlv8qvDEa6Jz2Y4YqpMespE0ME6vhZL6FdgLIwLkdtw8y768HLCBnsggPY+qtwkTdl6DqCtR+66eo
	dB0Uj+WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNGkA-0098ck-2A;
	Tue, 09 Jan 2024 18:22:30 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNGk6-0098bR-2u
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 18:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704824547; x=1736360547;
  h=date:from:to:cc:subject:message-id;
  bh=foKITIovxqre4NAmYrlUaL3Jcb8fAOXGCooLE44oEeE=;
  b=d39OJ2c0qs7SMc4Hn3I9zE8sAwyQPyCzef0l1ZFXz/lPPhZAMkjjPH7N
   N24KkAA4xjKsDoZBm10qDXclWb6vCUCV/Ve79W3VpEAkVpWYb6a7rgFa2
   vnBpU/2BpQ/rRw/dUkOa7Dq/n6V8qqcIndf8LTyhRs1GoaLp3sTMgBjif
   lOs7KluS7lNj8B8Ug45WoTbj+okSZBAMrhUY88FvqypSICGMDFh73jzjG
   328vEiPffc1HqkRqDn0/3IFw8Ffumd/5P2K6Fvl0PDlVKIHOwMU0MUvoJ
   yfE0SfxErg7570B3aQ9pRpojVyHwWTLbfR73TKMb4J9t7tTBhVo6qL6M+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5059046"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5059046"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905245882"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="905245882"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2024 10:22:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNGjz-000694-1K;
	Tue, 09 Jan 2024 18:22:19 +0000
Date: Wed, 10 Jan 2024 02:21:46 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 9a1abc24850eb759e36a2f8869161c3b7254c904
Message-ID: <202401100244.arjNvShk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_102226_986473_5A48BF5A 
X-CRM114-Status: UNSURE (   5.84  )
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
branch HEAD: 9a1abc24850eb759e36a2f8869161c3b7254c904  nvmet-tcp: Fix the H2C expected PDU len calculation

elapsed time: 1448m

configs tested: 174
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
arc                   randconfig-001-20240109   gcc  
arc                   randconfig-002-20240109   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240109   clang
arm                   randconfig-002-20240109   clang
arm                   randconfig-003-20240109   clang
arm                   randconfig-004-20240109   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240109   clang
arm64                 randconfig-002-20240109   clang
arm64                 randconfig-003-20240109   clang
arm64                 randconfig-004-20240109   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240109   gcc  
csky                  randconfig-002-20240109   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240109   clang
hexagon               randconfig-002-20240109   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240109   clang
i386         buildonly-randconfig-002-20240109   clang
i386         buildonly-randconfig-003-20240109   clang
i386         buildonly-randconfig-004-20240109   clang
i386         buildonly-randconfig-005-20240109   clang
i386         buildonly-randconfig-006-20240109   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240109   clang
i386                  randconfig-002-20240109   clang
i386                  randconfig-003-20240109   clang
i386                  randconfig-004-20240109   clang
i386                  randconfig-005-20240109   clang
i386                  randconfig-006-20240109   clang
i386                  randconfig-011-20240109   gcc  
i386                  randconfig-012-20240109   gcc  
i386                  randconfig-013-20240109   gcc  
i386                  randconfig-014-20240109   gcc  
i386                  randconfig-015-20240109   gcc  
i386                  randconfig-016-20240109   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240109   gcc  
loongarch             randconfig-002-20240109   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                      bmips_stb_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240109   gcc  
nios2                 randconfig-002-20240109   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240109   gcc  
parisc                randconfig-002-20240109   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240109   clang
powerpc               randconfig-002-20240109   clang
powerpc               randconfig-003-20240109   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240109   clang
powerpc64             randconfig-002-20240109   clang
powerpc64             randconfig-003-20240109   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240109   clang
riscv                 randconfig-002-20240109   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240109   gcc  
s390                  randconfig-002-20240109   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240109   gcc  
sh                    randconfig-002-20240109   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240109   gcc  
sparc64               randconfig-002-20240109   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20240109   clang
um                    randconfig-002-20240109   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240109   clang
x86_64       buildonly-randconfig-002-20240109   clang
x86_64       buildonly-randconfig-003-20240109   clang
x86_64       buildonly-randconfig-004-20240109   clang
x86_64       buildonly-randconfig-005-20240109   clang
x86_64       buildonly-randconfig-006-20240109   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240109   gcc  
x86_64                randconfig-002-20240109   gcc  
x86_64                randconfig-003-20240109   gcc  
x86_64                randconfig-004-20240109   gcc  
x86_64                randconfig-005-20240109   gcc  
x86_64                randconfig-006-20240109   gcc  
x86_64                randconfig-011-20240109   clang
x86_64                randconfig-012-20240109   clang
x86_64                randconfig-013-20240109   clang
x86_64                randconfig-014-20240109   clang
x86_64                randconfig-015-20240109   clang
x86_64                randconfig-016-20240109   clang
x86_64                randconfig-071-20240109   clang
x86_64                randconfig-072-20240109   clang
x86_64                randconfig-073-20240109   clang
x86_64                randconfig-074-20240109   clang
x86_64                randconfig-075-20240109   clang
x86_64                randconfig-076-20240109   clang
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240109   gcc  
xtensa                randconfig-002-20240109   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

