Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201FC64EC4
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Mar 2023 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ax5qSZPTuJwAl6LshgHZKsreKW6F4oqNGZf7BqVOhfU=; b=JeyvX3E5tq7nOI5mp3sOChEKoB
	doRlcVEpJFAY1lgnUH07PADERaGouU4mZOoz1FTFK4pLjA1ccblfuhqDLup4sMP4Yc/PholV8HKTx
	8eL121VozxaVHGKlgjdKwHCC1GGdv8j6KCp8s5uezkSHbE0UEjDLmIbp+2N2Z2eAS0Bof5Xab2sSA
	s1uUryBLstgw1WHbZZXsCSM8REYfmZ55UEmHwAKJ/fj3e+G8dGu+2qwRY3r3pLavol967JiI83t/J
	Cdb3FEbiwZgESQECYFJ02lQB9sjlDtyf9F5SvIURqoFp2/2ANyQ0KR6efNW+HAPn55N9bLNac8v4i
	FUusIQ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXBJC-00Ek40-HJ; Wed, 01 Mar 2023 01:31:06 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXBJ9-00Ek2F-F8
	for linux-nvme@lists.infradead.org; Wed, 01 Mar 2023 01:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677634263; x=1709170263;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0VNLiP2hCwItRILgYeAc090AqQbsvvO2uThdklF9Byg=;
  b=kzQhQO7brLsJVYH3QaL2W9oHNI5kJBbyGaA8S5ikJq1e7hz6icjzlJBf
   oja9lKz2lCMAWMOEBbu2yElLiYPmcbWCig1kUBuq1Aydp6tUqiyl0k9ry
   Ps7xsNnDrqWVv2e6zoHHRq0hXMud0xRQtkCcGXlX/STGUYL3XlA/Nhvhr
   O88AGtURaIFZtkD/97xgbijAwjAQ4MxZxlY/iuGw+mpgV7qLbazWrIHsM
   tfE1USnQnK/gpEHI0sEtM05jm/sDUSPnpEQ/TNID51DANW3R6v42WhrAo
   lN3czV7SR1qi0yA9KGuf/wjiOptGEvFCrPMs/HNCaFxlK3bUrAaza0kly
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="331774489"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="331774489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676537570"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="676537570"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2023 17:30:59 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pXBJ4-0005mp-28;
	Wed, 01 Mar 2023 01:30:58 +0000
Date: Wed, 01 Mar 2023 09:30:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 26a57cb35548ae67c14871cccbf50da3edb01ea4
Message-ID: <63feaab7.luuhrdne0Yqa0bJ8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_173103_555708_5AE62ECD 
X-CRM114-Status: UNSURE (   8.15  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.3
branch HEAD: 26a57cb35548ae67c14871cccbf50da3edb01ea4  nvme-fabrics: show well known discovery name

elapsed time: 727m

configs tested: 154
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230226   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230227   gcc  
alpha                randconfig-r006-20230227   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230226   gcc  
arc                  randconfig-r013-20230226   gcc  
arc                  randconfig-r035-20230227   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230227   clang
arm          buildonly-randconfig-r006-20230227   clang
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230227   gcc  
arm                  randconfig-r011-20230226   gcc  
arm                  randconfig-r012-20230226   gcc  
arm                  randconfig-r015-20230227   clang
arm                  randconfig-r034-20230227   gcc  
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230227   clang
csky                                defconfig   gcc  
csky                 randconfig-r036-20230226   gcc  
hexagon              randconfig-r016-20230226   clang
hexagon              randconfig-r023-20230227   clang
hexagon              randconfig-r032-20230227   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230227   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230227   clang
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230227   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230227   clang
i386                          randconfig-a005   gcc  
i386                 randconfig-a006-20230227   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                 randconfig-r012-20230227   gcc  
i386                 randconfig-r014-20230227   gcc  
i386                 randconfig-r025-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230226   gcc  
ia64                 randconfig-r004-20230227   gcc  
ia64                 randconfig-r022-20230227   gcc  
ia64                 randconfig-r024-20230226   gcc  
ia64                 randconfig-r033-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230226   gcc  
loongarch            randconfig-r015-20230226   gcc  
loongarch            randconfig-r031-20230226   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230226   gcc  
m68k                 randconfig-r024-20230227   gcc  
microblaze           randconfig-r003-20230226   gcc  
microblaze           randconfig-r034-20230226   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230227   clang
nios2        buildonly-randconfig-r003-20230227   gcc  
nios2        buildonly-randconfig-r004-20230226   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230226   gcc  
nios2                randconfig-r021-20230226   gcc  
nios2                randconfig-r032-20230226   gcc  
openrisc     buildonly-randconfig-r001-20230227   gcc  
openrisc             randconfig-r004-20230226   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r023-20230226   gcc  
parisc       buildonly-randconfig-r006-20230226   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230226   gcc  
parisc               randconfig-r005-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230226   clang
powerpc              randconfig-r001-20230227   clang
powerpc              randconfig-r006-20230226   gcc  
powerpc              randconfig-r022-20230226   clang
powerpc              randconfig-r025-20230226   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230226   clang
riscv                randconfig-r015-20230226   clang
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230227   gcc  
s390                 randconfig-r026-20230226   clang
s390                 randconfig-r033-20230227   clang
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230227   gcc  
sh                   randconfig-r011-20230226   gcc  
sh                   randconfig-r035-20230226   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230227   gcc  
sparc64              randconfig-r001-20230227   gcc  
sparc64              randconfig-r012-20230226   gcc  
sparc64              randconfig-r014-20230226   gcc  
sparc64              randconfig-r036-20230227   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230227   clang
x86_64       buildonly-randconfig-r005-20230227   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r014-20230227   gcc  
x86_64               randconfig-r015-20230227   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

