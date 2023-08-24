Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF8C27C40
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sMPCfBhSYFISqb6/ekZIbedWyWu7dm1YEI9KJGSq988=; b=NvoHiCuKMb+Iuu9QfUOwPDg9Qo
	QbvahT9XFNS8UhkEHslLpDHEnctCVSKwqjO0GJzdrI91WtRbOHK8Xivf4DQ8cRW0w0aYbEhuUNC3R
	8rZqEDh7FKgvOeKaMZiyqxTPALSb0kZQX31onM2OQKafFUesxhiUPNUxzWKrW0IHfTBUn5teLGu4Z
	jegO3WcXdh7DLCBDZwlp6YMt6GaHJ9ircHfYD88rD5snAywSqtC3WSU7i/APu2+6fqZmBj16VnSUy
	6OlvfOIvMGf4cgthCOzudq91SrT9vYeksHVcbOKlljVr7/r/hV7s+juHEyukwOdq/509FgM7upEYR
	h7Mrw/jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ9T1-0033ae-1C;
	Thu, 24 Aug 2023 12:29:39 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZ9Sx-0033aF-1X
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 12:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880175; x=1724416175;
  h=date:from:to:cc:subject:message-id;
  bh=dvTB5dQiJEIvSLSJ5lJgLxF+AphUO2JVBjNc6WRajX4=;
  b=BELN0rG+bzeURMf7acPM7GDGL7PLfxcMwa3DeJVnuRjSb3iC688O6qBF
   g/kO4PMtskhD9AVZg7e2nqW44BIL6w7XHHn/2dlpVjZkOZuOqOXJ/KYhE
   Im3s5ZkVzjKfkUnEUy/8/JzM6ScVanCLWlTa3+lfS+zfKkT0ktGEdi+bf
   Ew/4W052w7ZWC+7d0f1RhbN3ZMyl2ClpcfroYk3YjAWOH084ogZnhp4mI
   S9FMjr4IG/zaIcuaxqdPz1PC34JAlnVBXTT3ALkeASMBCbEy8BVdy3bzn
   xv+yGh+yEAWyXjkcVQpqKkF+s+Iud1psDjxEdjgvh45y8aZdxr6LtEaGo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438358210"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438358210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860683663"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860683663"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 05:29:33 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qZ9Su-0002Qk-25;
	Thu, 24 Aug 2023 12:29:32 +0000
Date: Thu, 24 Aug 2023 20:29:03 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.6] BUILD SUCCESS
 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c
Message-ID: <202308242002.sbeJg63u-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_052935_566635_3D52A582 
X-CRM114-Status: UNSURE (   5.43  )
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
branch HEAD: 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c  nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

elapsed time: 3777m

configs tested: 175
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
arc                   randconfig-001-20230822   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20230822   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230822   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230822   clang
hexagon               randconfig-002-20230822   clang
hexagon              randconfig-r003-20230822   clang
hexagon              randconfig-r031-20230822   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230822   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230822   gcc  
i386                  randconfig-002-20230822   gcc  
i386                  randconfig-003-20230822   gcc  
i386                  randconfig-004-20230822   gcc  
i386                  randconfig-011-20230822   clang
i386                  randconfig-012-20230822   clang
i386                  randconfig-013-20230822   clang
i386                  randconfig-014-20230822   clang
i386                  randconfig-015-20230822   clang
i386                  randconfig-016-20230822   clang
i386                 randconfig-r016-20230822   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230822   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r014-20230822   gcc  
m68k                 randconfig-r033-20230822   gcc  
m68k                 randconfig-r036-20230822   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230822   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r022-20230822   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230822   gcc  
nios2                randconfig-r013-20230822   gcc  
nios2                randconfig-r035-20230822   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r004-20230822   gcc  
openrisc             randconfig-r011-20230822   gcc  
openrisc             randconfig-r034-20230822   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r005-20230822   gcc  
powerpc              randconfig-r023-20230822   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230822   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230822   clang
s390                 randconfig-r015-20230822   clang
s390                 randconfig-r036-20230822   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r026-20230822   gcc  
sh                          sdk7780_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230822   gcc  
um                   randconfig-r032-20230822   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20230822   gcc  
x86_64       buildonly-randconfig-002-20230822   gcc  
x86_64       buildonly-randconfig-003-20230822   gcc  
x86_64       buildonly-randconfig-004-20230822   gcc  
x86_64       buildonly-randconfig-005-20230822   gcc  
x86_64       buildonly-randconfig-006-20230822   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-006-20230822   clang
x86_64                randconfig-011-20230822   gcc  
x86_64                randconfig-012-20230822   gcc  
x86_64                randconfig-013-20230822   gcc  
x86_64                randconfig-071-20230822   gcc  
x86_64                randconfig-072-20230822   gcc  
x86_64                randconfig-073-20230822   gcc  
x86_64                randconfig-074-20230822   gcc  
x86_64                randconfig-075-20230822   gcc  
x86_64               randconfig-r012-20230822   clang
x86_64               randconfig-r024-20230822   clang
x86_64               randconfig-r025-20230822   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r006-20230822   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

