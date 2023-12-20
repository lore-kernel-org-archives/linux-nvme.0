Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432BC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ejv30fd5fdAUnm3R3j0VAAckPhklDZ90pCFzdoWp1s=; b=pIrSFEbSOoL8YmiOLwVVI2f2G7
	+b1gtKokUFsyYXGksA0gFH9weW9nr5gX8OhR7ng93E3vzkwp7WiNOBARi7qOfMm/0fcGJiGn1e9eX
	0Tl5CixBEuZPuU9284ovRjcBhsy1lEAQv6gt88aTPq1Udcl5snOR9EY3iysll1BX/C1GU6CUiySiV
	RbjdKGbY0bC+y+cGRsKrspoN1gDDtfezrcJXKixBGmiGyOD2y6t2qwOwVaYbN0UA9w/cutcaiCk/w
	XE7BofaTLObUclbnK9DpPoV6zs9rEbDCJ/XPjLjU13iJQL+dwsQBHXqy1R+jNDa4Muy02LSjhYhJg
	Tzev23fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0wM-000efc-2r;
	Wed, 20 Dec 2023 18:05:06 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0wK-000eet-03
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 18:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703095504; x=1734631504;
  h=date:from:to:cc:subject:message-id;
  bh=A27IsJNkKfSlNXWuYPWqOvS/aF9AHxSL6VP8Cfa6yUA=;
  b=GwxGVEwB2OJLyNCoiJ70E8S+cBiHbfCS9Dkq733+p1w92hIY4OzVefOy
   bvqmqN/xjB0VKK02HmK2DF3+1iLyy99ckrsQKjxNKqMRc5mtfEOOC+/qD
   M69r/5WF/48F9+7tykrINsxCAyprqiRTSZohILhc5wwN5PTkCJxKDJWUg
   GS8aB+4UsCLUb6w1VTltTzl1X6P3tQv+yzIw38t0t1bAPAePum95QSAsL
   Ki0iNnv5tA2v+2U6Eweo5YmPR9BH1g1P6+qyRHskE6MGGQBm3oc9H//Xm
   ASa51xrI8SnJgmkbAQnmbFA4JT1qJUmTK2L9G7G9NAj1lSqeazpzBI3SQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462300530"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462300530"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 10:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="24654483"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2023 10:05:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG0wC-0007Ir-0v;
	Wed, 20 Dec 2023 18:04:56 +0000
Date: Thu, 21 Dec 2023 02:04:07 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 536ecccbaf1fe6319c3af635596748c19208e627
Message-ID: <202312210204.6WDqjKKy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_100504_152736_193783AA 
X-CRM114-Status: UNSURE (   4.80  )
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
branch HEAD: 536ecccbaf1fe6319c3af635596748c19208e627  nvmet: configfs: use ctrl->instance to track passthru subsystems

elapsed time: 1458m

configs tested: 165
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
arc                   randconfig-001-20231220   gcc  
arc                   randconfig-002-20231220   gcc  
arm                               allnoconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231220   gcc  
arm                   randconfig-002-20231220   gcc  
arm                   randconfig-003-20231220   gcc  
arm                   randconfig-004-20231220   gcc  
arm64                            alldefconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231220   gcc  
arm64                 randconfig-002-20231220   gcc  
arm64                 randconfig-003-20231220   gcc  
arm64                 randconfig-004-20231220   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231220   gcc  
csky                  randconfig-002-20231220   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231220   clang
hexagon               randconfig-002-20231220   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231220   gcc  
i386         buildonly-randconfig-002-20231220   gcc  
i386         buildonly-randconfig-003-20231220   gcc  
i386         buildonly-randconfig-004-20231220   gcc  
i386         buildonly-randconfig-005-20231220   gcc  
i386         buildonly-randconfig-006-20231220   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231220   gcc  
i386                  randconfig-002-20231220   gcc  
i386                  randconfig-003-20231220   gcc  
i386                  randconfig-004-20231220   gcc  
i386                  randconfig-005-20231220   gcc  
i386                  randconfig-006-20231220   gcc  
i386                  randconfig-011-20231220   clang
i386                  randconfig-012-20231220   clang
i386                  randconfig-013-20231220   clang
i386                  randconfig-014-20231220   clang
i386                  randconfig-015-20231220   clang
i386                  randconfig-016-20231220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231220   gcc  
loongarch             randconfig-002-20231220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                        maltaup_defconfig   clang
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231220   gcc  
nios2                 randconfig-002-20231220   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231220   gcc  
parisc                randconfig-002-20231220   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc               randconfig-001-20231220   gcc  
powerpc               randconfig-002-20231220   gcc  
powerpc               randconfig-003-20231220   gcc  
powerpc64             randconfig-001-20231220   gcc  
powerpc64             randconfig-002-20231220   gcc  
powerpc64             randconfig-003-20231220   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231220   gcc  
riscv                 randconfig-002-20231220   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231220   clang
s390                  randconfig-002-20231220   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231220   gcc  
sh                    randconfig-002-20231220   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231220   gcc  
sparc64               randconfig-002-20231220   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231220   gcc  
um                    randconfig-002-20231220   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231220   gcc  
x86_64       buildonly-randconfig-002-20231220   gcc  
x86_64       buildonly-randconfig-003-20231220   gcc  
x86_64       buildonly-randconfig-004-20231220   gcc  
x86_64       buildonly-randconfig-005-20231220   gcc  
x86_64       buildonly-randconfig-006-20231220   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231220   clang
x86_64                randconfig-002-20231220   clang
x86_64                randconfig-003-20231220   clang
x86_64                randconfig-004-20231220   clang
x86_64                randconfig-005-20231220   clang
x86_64                randconfig-006-20231220   clang
x86_64                randconfig-011-20231220   gcc  
x86_64                randconfig-012-20231220   gcc  
x86_64                randconfig-013-20231220   gcc  
x86_64                randconfig-014-20231220   gcc  
x86_64                randconfig-015-20231220   gcc  
x86_64                randconfig-016-20231220   gcc  
x86_64                randconfig-071-20231220   gcc  
x86_64                randconfig-072-20231220   gcc  
x86_64                randconfig-073-20231220   gcc  
x86_64                randconfig-074-20231220   gcc  
x86_64                randconfig-075-20231220   gcc  
x86_64                randconfig-076-20231220   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231220   gcc  
xtensa                randconfig-002-20231220   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

