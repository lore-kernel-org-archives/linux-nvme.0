Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31454CA5534
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FzNC0JG55R559sujHsCaqqRQG6IN2LAGW+4WOw9aLQQ=; b=XSm8TtU4NDzljbTRWGuy5iAaIq
	rOTAmd673eJEiDZfHxndwgu34eakTzq6RwL3GB/DosdxH98W1A+oGmuVU2ohWfrndudLhg8N/NL5S
	13pfNv5gqvED1lm2f5OkdFiBCiMoNyR6KjnRrjUlM9Wp6qj0I8xVtnlJGl+77RwxDTJmYI3Z5q55g
	1yVtFay+T4aOhyolfYDWICsrqByViYL2arHvc/NBW0l8NyUJP16slMPS2vJAESkXFlKtTSdOd6VIm
	lYdTXwbx/lSxvyGgwwZ098KhGg6V81t7ou/Bv4Y8XpdBrj0YXg/4ZeiboVOHzQdwB3glEc32ekZa6
	2yo+Zq8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgMsG-005Nm9-0z;
	Wed, 13 Sep 2023 10:13:32 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgMsC-005NlY-2W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600008; x=1726136008;
  h=date:from:to:cc:subject:message-id;
  bh=DQrBAvjqbFmuBNqoj3tX2f+rHyy3qO1DkkKnBqeg+bE=;
  b=lIe8oUSZPk8XhlvpgnpgBfFhfsd5tb3WHrPom0q9mw1NRlct818PGtuH
   TbLHZXkCXNTeBHGpJ2kChFbC7Y2+vVhyyNR2993st/NNqf/o8JMN4nALG
   8izBIqU+Q55DjL0bRtwhfMQDBFPs/VpmuEULaXApGdEeTDo/2YG8XMibg
   3CafbOdaO/yp6DJCK3WCkHQMuiNEUk9shmVDXi2fMSaGHimJpd5lcz5eo
   1InWSmlLB5eMcuW8iZK0+8u/4A6g02zDC4itmi98xGMBlZMWJ5rko7sdM
   fbUkcElc98N59veoQUjborOBee0wP6dDqzCWm+hu501KImlTFoxPU9AUT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377530391"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377530391"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990867016"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="990867016"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2023 03:13:20 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgMs3-0000NW-02;
	Wed, 13 Sep 2023 10:13:19 +0000
Date: Wed, 13 Sep 2023 18:12:40 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.6] BUILD SUCCESS
 dad651b2a44eb6b201738f810254279dca29d30d
Message-ID: <202309131838.HhSlsQnJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_031328_868137_639B19DC 
X-CRM114-Status: UNSURE (   6.44  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.6
branch HEAD: dad651b2a44eb6b201738f810254279dca29d30d  nvme-pci: do not set the NUMA node of device if it has none

elapsed time: 1058m

configs tested: 250
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230913   gcc  
alpha                randconfig-r005-20230913   gcc  
alpha                randconfig-r015-20230913   gcc  
alpha                randconfig-r021-20230913   gcc  
alpha                randconfig-r032-20230913   gcc  
alpha                randconfig-r036-20230913   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r005-20230913   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r016-20230913   gcc  
arm                  randconfig-r024-20230913   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r035-20230913   gcc  
arm64                randconfig-r036-20230913   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230913   gcc  
csky                 randconfig-r011-20230913   gcc  
csky                 randconfig-r025-20230913   gcc  
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230913   clang
hexagon              randconfig-r005-20230913   clang
hexagon              randconfig-r022-20230913   clang
hexagon              randconfig-r034-20230913   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230913   gcc  
i386         buildonly-randconfig-002-20230913   gcc  
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-004-20230913   gcc  
i386         buildonly-randconfig-005-20230913   gcc  
i386         buildonly-randconfig-006-20230913   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-003-20230913   gcc  
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-006-20230913   gcc  
i386                  randconfig-011-20230913   clang
i386                  randconfig-012-20230913   clang
i386                  randconfig-013-20230913   clang
i386                  randconfig-014-20230913   clang
i386                  randconfig-015-20230913   clang
i386                  randconfig-016-20230913   clang
i386                 randconfig-r003-20230913   gcc  
i386                 randconfig-r005-20230913   gcc  
i386                 randconfig-r006-20230913   gcc  
i386                 randconfig-r035-20230913   gcc  
i386                 randconfig-r036-20230913   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230913   gcc  
loongarch            randconfig-r001-20230913   gcc  
loongarch            randconfig-r004-20230913   gcc  
loongarch            randconfig-r005-20230913   gcc  
loongarch            randconfig-r006-20230913   gcc  
loongarch            randconfig-r032-20230913   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                 randconfig-r003-20230913   gcc  
m68k                 randconfig-r004-20230913   gcc  
m68k                 randconfig-r011-20230913   gcc  
m68k                 randconfig-r012-20230913   gcc  
m68k                 randconfig-r014-20230913   gcc  
m68k                 randconfig-r022-20230913   gcc  
m68k                 randconfig-r023-20230913   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230913   gcc  
microblaze           randconfig-r013-20230913   gcc  
microblaze           randconfig-r023-20230913   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                 randconfig-r006-20230913   clang
mips                 randconfig-r016-20230913   gcc  
mips                 randconfig-r025-20230913   gcc  
mips                 randconfig-r031-20230913   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230913   gcc  
nios2                randconfig-r031-20230913   gcc  
nios2                randconfig-r033-20230913   gcc  
nios2                randconfig-r034-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r004-20230913   gcc  
openrisc             randconfig-r016-20230913   gcc  
openrisc             randconfig-r021-20230913   gcc  
openrisc             randconfig-r031-20230913   gcc  
openrisc             randconfig-r032-20230913   gcc  
openrisc             randconfig-r033-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r005-20230913   gcc  
parisc               randconfig-r006-20230913   gcc  
parisc               randconfig-r024-20230913   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r001-20230913   gcc  
powerpc              randconfig-r003-20230913   gcc  
powerpc              randconfig-r006-20230913   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64            randconfig-r001-20230913   gcc  
powerpc64            randconfig-r004-20230913   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r001-20230913   gcc  
riscv                randconfig-r024-20230913   clang
riscv                randconfig-r033-20230913   gcc  
riscv                randconfig-r035-20230913   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230913   clang
s390                 randconfig-r031-20230913   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r002-20230913   gcc  
sh                   randconfig-r011-20230913   gcc  
sh                   randconfig-r012-20230913   gcc  
sh                   randconfig-r015-20230913   gcc  
sh                   randconfig-r021-20230913   gcc  
sh                   randconfig-r026-20230913   gcc  
sh                   randconfig-r036-20230913   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230913   gcc  
sparc64              randconfig-r013-20230913   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230913   clang
um                   randconfig-r016-20230913   gcc  
um                   randconfig-r022-20230913   gcc  
um                   randconfig-r026-20230913   gcc  
um                   randconfig-r034-20230913   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230913   clang
x86_64                randconfig-002-20230913   clang
x86_64                randconfig-003-20230913   clang
x86_64                randconfig-004-20230913   clang
x86_64                randconfig-005-20230913   clang
x86_64                randconfig-006-20230913   clang
x86_64                randconfig-011-20230913   gcc  
x86_64                randconfig-012-20230913   gcc  
x86_64                randconfig-013-20230913   gcc  
x86_64                randconfig-014-20230913   gcc  
x86_64                randconfig-015-20230913   gcc  
x86_64                randconfig-016-20230913   gcc  
x86_64                randconfig-071-20230913   gcc  
x86_64                randconfig-072-20230913   gcc  
x86_64                randconfig-073-20230913   gcc  
x86_64                randconfig-074-20230913   gcc  
x86_64                randconfig-075-20230913   gcc  
x86_64                randconfig-076-20230913   gcc  
x86_64               randconfig-r015-20230913   clang
x86_64               randconfig-r026-20230913   clang
x86_64               randconfig-r034-20230913   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r014-20230913   gcc  
xtensa               randconfig-r034-20230913   gcc  
xtensa               randconfig-r035-20230913   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

