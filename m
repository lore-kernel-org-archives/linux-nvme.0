Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD37C47DA9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 03:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8OruwK+JgI3kK6HcT/ARVlh3TmF03IIHkgYuanEtNq4=; b=OWCFSKR1ZghEMEfIo0OJ/9EWGK
	X+8suGQTgQIReS8+tr7uDAC65APQG3UhTt/C91/pEUY0KgjiKn0VdgGBfmovSMl8z/kBqJK6bNQGl
	3iYYvgl9YUEYKhgu+FmBsSGYvT07Nyr8KWYIFBZc9FicSLA9nkcdOOhZbx+T9srzVQDt6BgDYoPtv
	arwDogQCPUm7Td/tooxqBfkOD3aDZw3tGJDtk5wmOpMgInSvVdEeivuvU0VTpEriot0myu98JlHB5
	eHKmxCTcwwQDMP/0Wv/5u8TAt32psJxaBu29I2wgtNMUQ5gdtIMSfAy498//RcERKWMA1KiTeW1x7
	/DR+d+Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUeyU-0000000F9Zy-2toJ;
	Tue, 30 Jan 2024 03:39:50 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUeyR-0000000F9ZL-3668
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 03:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706585987; x=1738121987;
  h=date:from:to:cc:subject:message-id;
  bh=eu8jwTqX3AIjaVarjyCKebNBEuaZPec5JCNAz1M4qB8=;
  b=EPT/uE2xOOux2Vb+97m3WIM1HIOxsyY8m0HNKTVeo0PkpTxiqduAZahN
   OJJAhnLCiB0pFtiP54f2zUd1w5aCKn50Sj7jaTSMBwyhl1g7ufd2jfUWa
   v/pFJSlQkYsXxB6a1GZT0Os4HdiwOp+bj/NHlOP8k6tAhs6MiuthheIL/
   0niogkgo4YKVQbLc7x2Uk2xYmG7xTl/jb2ihG74sJxEc5a36bJfHDy4vv
   IzsOFkJBmPkah25VtXfFJS+R0SrAUR50vhv2xaNGt6PoqiqrHqAEUwfBd
   bLO0Rx5pibl3mWkaCPbMrsLXzZsTSSqhFmDhmzIv8crNpChY8bWJ5z1r4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="400301167"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="400301167"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3613418"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Jan 2024 19:39:45 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUeyM-0004ts-1k;
	Tue, 30 Jan 2024 03:39:42 +0000
Date: Tue, 30 Jan 2024 11:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 5fe6c9668aba004242895f99c19ed9b828453e90
Message-ID: <202401301116.YAQP9ZTA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_193947_843898_754C1CBF 
X-CRM114-Status: UNSURE (   6.38  )
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
branch HEAD: 5fe6c9668aba004242895f99c19ed9b828453e90  nvme-auth: open-code single-use macros

elapsed time: 727m

configs tested: 154
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
arc                   randconfig-001-20240130   gcc  
arc                   randconfig-002-20240130   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                   randconfig-001-20240130   gcc  
arm                   randconfig-002-20240130   gcc  
arm                   randconfig-003-20240130   gcc  
arm                   randconfig-004-20240130   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240130   gcc  
arm64                 randconfig-002-20240130   gcc  
arm64                 randconfig-003-20240130   gcc  
arm64                 randconfig-004-20240130   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240130   gcc  
csky                  randconfig-002-20240130   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240130   clang
hexagon               randconfig-002-20240130   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240130   gcc  
i386         buildonly-randconfig-002-20240130   gcc  
i386         buildonly-randconfig-003-20240130   gcc  
i386         buildonly-randconfig-004-20240130   gcc  
i386         buildonly-randconfig-005-20240130   gcc  
i386         buildonly-randconfig-006-20240130   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240130   gcc  
i386                  randconfig-002-20240130   gcc  
i386                  randconfig-003-20240130   gcc  
i386                  randconfig-004-20240130   gcc  
i386                  randconfig-005-20240130   gcc  
i386                  randconfig-006-20240130   gcc  
i386                  randconfig-011-20240130   clang
i386                  randconfig-012-20240130   clang
i386                  randconfig-013-20240130   clang
i386                  randconfig-014-20240130   clang
i386                  randconfig-015-20240130   clang
i386                  randconfig-016-20240130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240130   gcc  
loongarch             randconfig-002-20240130   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240130   gcc  
nios2                 randconfig-002-20240130   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240130   gcc  
parisc                randconfig-002-20240130   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240130   gcc  
powerpc               randconfig-002-20240130   gcc  
powerpc               randconfig-003-20240130   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240130   gcc  
powerpc64             randconfig-002-20240130   gcc  
powerpc64             randconfig-003-20240130   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240130   gcc  
riscv                 randconfig-002-20240130   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240130   clang
s390                  randconfig-002-20240130   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240130   gcc  
sh                    randconfig-002-20240130   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240130   gcc  
sparc64               randconfig-002-20240130   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240130   gcc  
um                    randconfig-002-20240130   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240130   gcc  
xtensa                randconfig-002-20240130   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

