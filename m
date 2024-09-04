Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88722CD4F30
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=feEA21dFWLMnkXHYFTMtCUX3B7FhzpmBRliKoinTaqk=; b=DHtAAt8DHqCN7tfaXSd2NwoPDs
	+1H/J1V0ZTHp2dCf0ycnLwrpLC7hnVIgc+xfyPEK/3PydTrXeo3SfX/64dsRxFIOQrpWSJWijKiF2
	R1MLO0Llmh6o5+Sd0OtpDBFHbDvR867xoqDZjhZfbs6NJg9c4b2dwsN+Ge/mGs1WdvXu71If79rvb
	ojE4GzOYTaULno7+fk51xqQbSVDqCb1HO1dXhq6TtLVv3RAKBiFH0Dr+r3Y49xt0XNdVEdH8vcsxg
	utInfKJEkcbLaQNFoh0MbcvFoBH/7eaBGgYX7T/8h+pbGyazrXUx1wJRxbUc9tMFETRo9DKqLCAOG
	BqxfnohQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slwwG-000000062gn-0Etj;
	Wed, 04 Sep 2024 20:49:16 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slwvt-000000062aE-2MWV
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 20:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725482933; x=1757018933;
  h=date:from:to:cc:subject:message-id;
  bh=ir8mA6D1C2U8v258BW+g9rLFWj5TasYk3x+sWeZCtZM=;
  b=iZYLfMIL6hLMcyGrkuL+6aXYifroCAcgY0ySmglUawMbm6TdCiETO0sw
   z7hEi42mpQin3uDx4F2rjAyQ8ljkoIGmFjJZEwOXXEg0ImL7h5EaHiiBG
   o+jKYEIK/OSoVs1tmZnKIa0RmRPl2iG7x/bIVY69D7hS+OxlZfaMgDvd4
   e2K3Q5tgJgLP9N/LDf0VCZ9MpvKfGs/osgHhc9eLllz74oLq9XVoqIvis
   7hxX0vcf0krcAXe0ub5Kdyvtqsm+eeTvLp+xvMAUWovrvFGA0xqCPJhwr
   +kivHce22+ALK02NTb3UAj4PP//h3KuFHo8UpSWkbCfJCeia9DRPiJLzI
   A==;
X-CSE-ConnectionGUID: adgKih+TTQWp5A58ks8iVg==
X-CSE-MsgGUID: GcXCJznTRhe45IQDDTXQOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41644625"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="41644625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 13:48:41 -0700
X-CSE-ConnectionGUID: YanA7sBASQmcuTRj5pRBBw==
X-CSE-MsgGUID: 9tIbPINPSiG5dbeFvFz8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="96195699"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Sep 2024 13:48:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slwvd-0008XB-1p;
	Wed, 04 Sep 2024 20:48:37 +0000
Date: Thu, 05 Sep 2024 04:47:51 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9
Message-ID: <202409050448.aL6lRWh1-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_134853_701857_6B5A3EDF 
X-CRM114-Status: UNSURE (   5.27  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9  nvme: fix metadata handling in nvme-passthrough

elapsed time: 2261m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240904   gcc-13.2.0
arc                   randconfig-002-20240904   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                   randconfig-001-20240904   clang-20
arm                   randconfig-002-20240904   clang-20
arm                   randconfig-003-20240904   clang-20
arm                   randconfig-004-20240904   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240904   clang-15
arm64                 randconfig-002-20240904   gcc-14.1.0
arm64                 randconfig-003-20240904   gcc-14.1.0
arm64                 randconfig-004-20240904   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240904   gcc-14.1.0
csky                  randconfig-002-20240904   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240904   clang-15
hexagon               randconfig-002-20240904   clang-16
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240904   clang-18
i386         buildonly-randconfig-002-20240904   gcc-12
i386         buildonly-randconfig-003-20240904   clang-18
i386         buildonly-randconfig-004-20240904   clang-18
i386         buildonly-randconfig-005-20240904   clang-18
i386         buildonly-randconfig-006-20240904   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240904   clang-18
i386                  randconfig-002-20240904   clang-18
i386                  randconfig-003-20240904   clang-18
i386                  randconfig-004-20240904   clang-18
i386                  randconfig-005-20240904   gcc-12
i386                  randconfig-006-20240904   gcc-12
i386                  randconfig-011-20240904   clang-18
i386                  randconfig-012-20240904   clang-18
i386                  randconfig-013-20240904   gcc-12
i386                  randconfig-014-20240904   clang-18
i386                  randconfig-015-20240904   clang-18
i386                  randconfig-016-20240904   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240904   gcc-14.1.0
loongarch             randconfig-002-20240904   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240904   gcc-14.1.0
nios2                 randconfig-002-20240904   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240904   gcc-14.1.0
parisc                randconfig-002-20240904   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240904   gcc-14.1.0
powerpc               randconfig-002-20240904   clang-20
powerpc64             randconfig-001-20240904   gcc-13.2.0
powerpc64             randconfig-002-20240904   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   gcc-12
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

