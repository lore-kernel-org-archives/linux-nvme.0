Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD4BC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yeclnd6XMcu500fh8aEHZJp8PVOMwEL0dRVhQM4c+hE=; b=uYejKSAG5Heac9ZuQcCFyhTCEa
	FBDyr2qiK4Z6hbmJntPFge4tZwFu+F94l1etn1Eeu2noZSGzDILlWJ8/sApnKEfzGGd5yi/eIZQNE
	ilC8NrC0Ua8gvqqwHboGP70xFMzsbyEcrQAaO64T5CK6uiwbFMp4IPQJxZ2qNHkVhi/UmnSmdBzhF
	MJqufHVI660z86DlC1fVastG15cU4OSUn2vmw6o5h1zskhwB7obsQuVS98LGh1z5f5UFGL2ENyNoF
	G0vkhiyUUHYzpV5g7xrjoeQteS0v5mGKbzTslq6WX3zKxhvLeON11Vxcn2oNPPosyg2w1EL31bDO5
	jLw9n2wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfdYL-0000000D7rp-2jJg;
	Thu, 29 Feb 2024 10:22:13 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfdYJ-0000000D7r8-14Y4
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 10:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709202131; x=1740738131;
  h=date:from:to:cc:subject:message-id;
  bh=4WRb5/Bf4YBrjkYAh+B52LKDb5MEaMhmPGsOfTgNC8E=;
  b=XghQkY0xq6pUlAyqkoPcLjyJQYYfQdT2qS2KbhUjUOm3bJVUgOpyef/l
   0gWHKtflFzHW/nYWFkGrRYHNj2+6p3RAgEDfxIotkXz3Na/leCSPsJRjB
   lmklkT2b3tSg+A1be0BLAnAL+8HpERDopO5nf6S2en/ej0ZXLbXS+d9RX
   vy5CN9ouUsE6wwX5SfEJzAjlZi4kgbALn9BDKkIryT7KQvqzGMkUfyazD
   0j59dT5ViQ0HQsPPoX+XOB6Dc8pWOWiwd9342FITLYAcelPQd+hzfDYo6
   eaWrC+KhZDDvf+BAOxjB04/dFhosNf9HH7x1HEHD/+1CGPIeO3RP9FrC0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3587019"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3587019"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7700220"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 Feb 2024 02:22:09 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfdXa-000CrL-1K;
	Thu, 29 Feb 2024 10:21:51 +0000
Date: Thu, 29 Feb 2024 18:19:33 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.9] BUILD SUCCESS
 48afc451f339744debf24bdb21a7a0b496e5a1be
Message-ID: <202402291830.77hHKOjW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_022211_362952_495987F4 
X-CRM114-Status: UNSURE (   5.64  )
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
branch HEAD: 48afc451f339744debf24bdb21a7a0b496e5a1be  nvme-fabrics: check max outstanding commands

elapsed time: 1035m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240229   gcc  
arc                   randconfig-002-20240229   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                   randconfig-001-20240229   gcc  
arm                   randconfig-002-20240229   gcc  
arm                   randconfig-004-20240229   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240229   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240229   gcc  
csky                  randconfig-002-20240229   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240229   clang
i386         buildonly-randconfig-004-20240229   clang
i386                                defconfig   clang
i386                  randconfig-001-20240229   clang
i386                  randconfig-003-20240229   clang
i386                  randconfig-013-20240229   clang
i386                  randconfig-014-20240229   clang
i386                  randconfig-015-20240229   clang
i386                  randconfig-016-20240229   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240229   gcc  
loongarch             randconfig-002-20240229   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240229   gcc  
nios2                 randconfig-002-20240229   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240229   gcc  
parisc                randconfig-002-20240229   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-002-20240229   gcc  
powerpc64             randconfig-001-20240229   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240229   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240229   gcc  
sh                    randconfig-002-20240229   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240229   gcc  
sparc64               randconfig-002-20240229   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240229   gcc  
um                    randconfig-002-20240229   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240229   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240229   clang
x86_64                randconfig-002-20240229   clang
x86_64                randconfig-003-20240229   clang
x86_64                randconfig-004-20240229   clang
x86_64                randconfig-005-20240229   clang
x86_64                randconfig-006-20240229   clang
x86_64                randconfig-071-20240229   clang
x86_64                randconfig-072-20240229   clang
x86_64                randconfig-073-20240229   clang
x86_64                randconfig-074-20240229   clang
x86_64                randconfig-076-20240229   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240229   gcc  
xtensa                randconfig-002-20240229   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

