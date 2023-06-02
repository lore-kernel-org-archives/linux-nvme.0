Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D429C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 06:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d8H31nxA1vCVRzYk6feIgl/gNy6yhqyQZxB+F+gw3SU=; b=Je8CoUUk+pLQMcNL/6x5VodaMj
	Oee0GsiitRSKl2gIaULJeuxZ6p4SBw6FgCXoUXHs0fQ+TLpmA3cq5q8pdDqkxkVS5twBhLVtYmK5L
	Iz3/lhqXB90lNOoCDl6qCSC4XpWrR7MVKuQg/2Y5PCfOy/98o5fK5810dLUDqaoNjBXHyjdF1phl+
	ik7ePj6MzY4BXFFDkQmIVp6ZTUeFSKf3nflcjo/D9jFajQ8MU6NjeRSIkTiYxDja9a+LdSTEaF9/6
	9Z4idH3tjN5DKh/5K9znBa8WI6HLSzEleotK6EnfxiUfB+sC2HhX7ZAmAJ3e12Ay9mdECazG3qRKo
	aEzqi6tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xsh-005qRk-19;
	Fri, 02 Jun 2023 06:03:23 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xsd-005qOu-2S
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 06:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685685799; x=1717221799;
  h=date:from:to:cc:subject:message-id;
  bh=iII9jjIziOec9daUoFnZg4UGz5qsMq82Gx6K9jHWDpg=;
  b=ElbVe6s4s1Mz8aZO0uo8kARSpXzsgqnPFipVWjHduDRQbEgJuDquj3hE
   nL9B7CFBOvHVJvle0HMZ8nNs1XIipEzTIcVN3XLSGA3Hx/pKu8gAMkxC5
   Wszvrt4JS2H/A+Oy7xRr28HO39+QbhROqPoLwSamjSPn1sm0910/ZPY7w
   lg1wj9eAEkB+yszpvgPQhwEFdR8WkKWOSnCe4lCA3FO3KNehBBw3w3dGc
   6vYFYr+gZtGRfIw8ffPOG+7VQSWdnE9z6M9lvyLZctaQTOKjcdmXeLsdf
   ZMe6Ym6anYkkB/nCE0FRCqHl0WELuqDPRIuhJa0BuYl3+xkKTzWWR6iWf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353276661"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="353276661"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="710797713"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="710797713"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2023 23:03:14 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q4xsX-00009O-27;
	Fri, 02 Jun 2023 06:03:13 +0000
Date: Fri, 02 Jun 2023 14:03:05 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 14ad91f7a9a29562f23bedd205ef209255d8b8d1
Message-ID: <20230602060305.R1J4F%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_230319_864701_0233DDE0 
X-CRM114-Status: UNSURE (   7.39  )
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
branch HEAD: 14ad91f7a9a29562f23bedd205ef209255d8b8d1  nvme: Increase block size variable size to 32-bit

Unverified Warning (likely false positive, please contact us if interested):

drivers/nvme/host/fabrics.c:96:2-8: preceding lock on line 85

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-c023-20230531
|   `-- drivers-nvme-host-fabrics.c:preceding-lock-on-line
|-- parisc-randconfig-c043-20230531
|   `-- drivers-nvme-host-fabrics.c:preceding-lock-on-line
`-- riscv-randconfig-c032-20230531
    `-- drivers-nvme-host-fabrics.c:preceding-lock-on-line

elapsed time: 721m

configs tested: 115
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230531   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230531   gcc  
arm                         s5pv210_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230531   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230531   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r015-20230531   gcc  
microblaze           randconfig-r021-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230531   gcc  
openrisc             randconfig-r002-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230531   gcc  
parisc               randconfig-r006-20230531   gcc  
parisc               randconfig-r016-20230531   gcc  
parisc               randconfig-r026-20230531   gcc  
parisc               randconfig-r036-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc      buildonly-randconfig-r001-20230531   clang
powerpc                        cell_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r022-20230531   clang
powerpc              randconfig-r023-20230531   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230531   clang
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                   randconfig-r033-20230531   gcc  
sh                           se7751_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230531   gcc  
sparc        buildonly-randconfig-r006-20230531   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r024-20230531   gcc  
sparc64              randconfig-r032-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230531   gcc  
xtensa               randconfig-r035-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

