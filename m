Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD9C54E66
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Mar 2024 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JCu9m7YwwjUg57oPtb6P6PMmR8klPF6MrEqYJwAsbus=; b=nzEUG7LzoO1gpw1VhfaKXM0Z9C
	j4Cj/nhlg2VqBIX92ZPkYPjSMVSe05Z7BL4s+I71c80RPz3nmxCk0Um+fvh8vVv9corLHeRvVI7jF
	Pp15a2tq0ouGOF0oWbvS5nhC8pLTueh/raRpqxkUG/wKoEfdySwSOeljxXrv8RnX6TKoAiGImT+Ro
	YO0cAofiJUVcHl2eyquedoW/GYWL6Pe/xot6q7lenuZ8XFyh+6Ip4OXHR1a5zs067hVV8T2JcM9n3
	rkeXRqASZUNngfie/tysk9zR6VKq0Gac6/SYBWMyo/WbC0s/Zpo53UY4cqsoIwBoySe6wBggsIQhJ
	mMkKGMjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl1lb-0000000Gvfu-0X9Z;
	Fri, 15 Mar 2024 07:14:11 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl1lV-0000000GvfE-0sGn
	for linux-nvme@lists.infradead.org;
	Fri, 15 Mar 2024 07:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710486845; x=1742022845;
  h=date:from:to:cc:subject:message-id;
  bh=Jk3T/JqTGf//fm0+AXqwU0HdvJO4+9sPM0Whzq3chUM=;
  b=fledtYghPkHaxHXo9NoZWXPctcsgbWHf/+e/DkKCxTX55JwWc+GJOpCY
   fGd93AH+7lSHlXF23XARCSh3P8qJ3Cj6cKKgjHl0hC9PG3mYhuXnUxFLm
   qX6yRRz28h3L7QOwSRn896Vb9V7cVh9lbi1gdRjpjIKsYHw6idSy3xTIZ
   Mqb9Czwu4tH1Npo06GrFJgq7c5MoUHXCPM2zb5uba3UtXfmKh7tPvlmLb
   ++76YZ3TdLYNhv+iuIYVqI8UfU1hG2I1VE3K8Co/NFWruMpQfnQE9lGkJ
   TvPGGH7hSS2fmlZ2pmAlDr/KFQV9Z4y6gATVyozPDBD+9vtsbugvd51S8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5944052"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5944052"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:14:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12494668"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Mar 2024 00:13:59 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl1lN-000EDi-1H;
	Fri, 15 Mar 2024 07:13:57 +0000
Date: Fri, 15 Mar 2024 15:13:48 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.9] BUILD SUCCESS
 798edad968ace3c15c3180ba72e427630022e2d9
Message-ID: <202403151544.fBaqpVLa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_001405_289511_35C47D11 
X-CRM114-Status: UNSURE (   4.65  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.9
branch HEAD: 798edad968ace3c15c3180ba72e427630022e2d9  nvme: parse format command's lbafu when tracing

elapsed time: 739m

configs tested: 171
configs skipped: 3

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
arc                   randconfig-001-20240315   gcc  
arc                   randconfig-002-20240315   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240315   clang
arm                   randconfig-002-20240315   gcc  
arm                   randconfig-003-20240315   gcc  
arm                   randconfig-004-20240315   gcc  
arm                         socfpga_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240315   gcc  
arm64                 randconfig-002-20240315   gcc  
arm64                 randconfig-003-20240315   gcc  
arm64                 randconfig-004-20240315   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240315   gcc  
csky                  randconfig-002-20240315   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240315   clang
hexagon               randconfig-002-20240315   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240315   clang
i386         buildonly-randconfig-002-20240315   clang
i386         buildonly-randconfig-003-20240315   gcc  
i386         buildonly-randconfig-004-20240315   clang
i386         buildonly-randconfig-005-20240315   gcc  
i386         buildonly-randconfig-006-20240315   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240315   gcc  
i386                  randconfig-002-20240315   clang
i386                  randconfig-003-20240315   clang
i386                  randconfig-004-20240315   clang
i386                  randconfig-005-20240315   gcc  
i386                  randconfig-006-20240315   clang
i386                  randconfig-011-20240315   clang
i386                  randconfig-012-20240315   gcc  
i386                  randconfig-013-20240315   gcc  
i386                  randconfig-014-20240315   clang
i386                  randconfig-015-20240315   gcc  
i386                  randconfig-016-20240315   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240315   gcc  
loongarch             randconfig-002-20240315   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240315   gcc  
nios2                 randconfig-002-20240315   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240315   gcc  
parisc                randconfig-002-20240315   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      cm5200_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240315   clang
powerpc               randconfig-002-20240315   gcc  
powerpc               randconfig-003-20240315   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240315   clang
powerpc64             randconfig-002-20240315   gcc  
powerpc64             randconfig-003-20240315   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240315   clang
riscv                 randconfig-002-20240315   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240315   gcc  
s390                  randconfig-002-20240315   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240315   gcc  
sh                    randconfig-002-20240315   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240315   gcc  
sparc64               randconfig-002-20240315   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240315   gcc  
um                    randconfig-002-20240315   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-005-20240315   clang
x86_64       buildonly-randconfig-006-20240315   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240315   clang
x86_64                randconfig-004-20240315   clang
x86_64                randconfig-011-20240315   clang
x86_64                randconfig-015-20240315   clang
x86_64                randconfig-016-20240315   clang
x86_64                randconfig-071-20240315   clang
x86_64                randconfig-072-20240315   clang
x86_64                randconfig-075-20240315   clang
x86_64                randconfig-076-20240315   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240315   gcc  
xtensa                randconfig-002-20240315   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

