Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8739AEB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 05:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CTzYylXFf5/kv6vZEBn6T2Mo8TWnOWIAucvgFAeSqGs=; b=XcFmwnVvBBSfGw+MwS6bheXdht
	rLfqTUjphbnKn2wgmg+mFxJWtzPXL52gowyyatuHIuAr49r8LcYc2juZyEkdsOI4ASFv7Fozi86j5
	6AEy/x+lt2xrnoprkrH3v0/OnCZStkxa0plgRj3ddhruKEm+T/TZIYGDMQv17VmGSarbA7z47C69d
	VENFrydK46n1oXpSMwMoir6hY+GxoRSEfKWAlNH/RiF2j+8q7DkzGPfJzJgd2WofcLfkNGmbyCPQX
	VbzJ6PjNJ8oQLVJly5BFaUURakmGNzMxSHBpkBEgu663gVXpWiwEFPUZq50BDCmqnvm7V6BkLNdkK
	3aoOzf2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ5uf-00DkjH-2Y;
	Tue, 11 Jul 2023 05:27:49 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ5uc-00Dkif-0q
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 05:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689053266; x=1720589266;
  h=date:from:to:cc:subject:message-id;
  bh=RuQu+glZEPOxqRqsrhUmm5npoYmDaMcR8IDj5iWF8D8=;
  b=Zhvqh03/ylMEgpwJ0mgP05dQj8BsFVCS6CgGT2q4GXhELDYAW+7/Wsy6
   7VzTl/O15BDCr/FDALrYEUaGdStKFk+gUrVbqukOpBR07d8q8h0t6KN9B
   raoQLtQUDOjJ9yBsj9SFI4G6qOgCTsB/TXzTUanrtLk0hUArjrNDDVrHJ
   MbMJxos+6ME4Y+/0jFWDRjZZZt32qGWl10m3TkwD26AHMNqlXg4d3x8MP
   qeg1jVk6fdDhbAvvNbr35SZA1ed6WDqUN1W9ANPBIMV8BlWeeP52uhUyu
   zQ/W9yqOYRjlHrkuegcjEAIr+R165b2O0yVf0XysXTFfxFPLaTo8QLbNi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361990053"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="361990053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 22:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="715060354"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715060354"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2023 22:27:42 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qJ5uY-0004Lj-0d;
	Tue, 11 Jul 2023 05:27:42 +0000
Date: Tue, 11 Jul 2023 13:26:58 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 b938e6603660652dc3db66d3c915fbfed3bce21d
Message-ID: <202307111356.2e198BKP-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_222746_337487_6147FEA9 
X-CRM114-Status: UNSURE (   6.68  )
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
branch HEAD: b938e6603660652dc3db66d3c915fbfed3bce21d  nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

elapsed time: 728m

configs tested: 144
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230710   gcc  
alpha                randconfig-r011-20230710   gcc  
alpha                randconfig-r014-20230710   gcc  
alpha                randconfig-r022-20230710   gcc  
alpha                randconfig-r025-20230710   gcc  
alpha                randconfig-r036-20230710   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        neponset_defconfig   clang
arm                  randconfig-r046-20230710   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230710   gcc  
arm64                randconfig-r006-20230710   gcc  
arm64                randconfig-r034-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230710   gcc  
csky                 randconfig-r031-20230710   gcc  
csky                 randconfig-r034-20230710   gcc  
hexagon              randconfig-r033-20230710   clang
hexagon              randconfig-r035-20230710   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230710   gcc  
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r035-20230710   gcc  
i386                 randconfig-r036-20230710   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230710   gcc  
loongarch            randconfig-r032-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230710   gcc  
m68k                 randconfig-r004-20230710   gcc  
m68k                 randconfig-r016-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                 randconfig-r004-20230710   clang
mips                 randconfig-r026-20230710   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230710   gcc  
nios2                randconfig-r013-20230710   gcc  
openrisc             randconfig-r002-20230710   gcc  
openrisc             randconfig-r022-20230710   gcc  
openrisc             randconfig-r032-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc              randconfig-r013-20230710   clang
powerpc              randconfig-r021-20230710   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230710   gcc  
riscv                randconfig-r023-20230710   clang
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230710   gcc  
s390                 randconfig-r033-20230710   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230710   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230710   gcc  
sparc64              randconfig-r002-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230710   gcc  
um                   randconfig-r024-20230710   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r014-20230710   clang
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

