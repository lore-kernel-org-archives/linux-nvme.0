Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90390C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YjDIrzpjhuINOmJ1YFsWlz4+bpY58YC9nrJ1f5Z480w=; b=og25YB7LLGoPQW+OxEjG3Don6y
	Cfek/2xdd9GNxH9x50cB6HlcA7d6BQWIO+Qnu0fIfzl4Jip/T4UIwHcfh+Aq1uAa6OJRdNwz2jSN0
	Pfudq5+isU5XDk9TwINN1gm71wo030DZ+N90cG2rIHsvbCv6GX0L4duw8EYDZMqg3lvEn6NQS+NvS
	FKApsauiFSsUapLVFKP1Xqh0sbgmzxVeptFWUpdXYErM9i6RM8xDWllAu0Gd88DNUKsX8e19OuIN8
	ICpinw3VtM0wkT5v5cb31s7IN97KIFXOoGekGqmuFJ0KXtwNKxrN6/V9JqYZA3IhigSJnmkeWMMbI
	IuLWGpEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAYxw-0080JL-1q;
	Tue, 05 Dec 2023 17:12:12 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAYxt-0080HX-29
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 17:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796329; x=1733332329;
  h=date:from:to:cc:subject:message-id;
  bh=TpsBhWu/DIsqi+hYzCLBVhXiJ3NDZ2MmuQ6CNXXXwYk=;
  b=ALV6hIDbRLE1cVLgFmGJafD92O+SpZHkAr1zWcDxuAD2luARG3CVDkbt
   l8WijS5XIIFjllvosAGaD8uz5ZWdguuC2adszp+JuaoKFmlBQLJt+Hfy8
   VIe4dhJM1ayuG7wDZJR+0kzvIoKuFRauO9A1kuM1kbCyfVl1+If+fHyn2
   oQbAouwGDEPsuQ+CL2R+Nok9etULNRGzZfCeKdhXWKRRNVv/DuCeTouuP
   t42HYKEnCLVzaXjquDy33kOrfVvG3l64hJkxqVNw340+lwqCJrCuVOjpg
   RKm9VZVOt6ZvwejcReVsGVvPhqtU57Ruqnbi3kvZNi2JokwSpMhUSrWQM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396719417"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="396719417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018278434"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018278434"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 09:09:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAYut-0009QF-0k;
	Tue, 05 Dec 2023 17:09:03 +0000
Date: Wed, 06 Dec 2023 01:08:30 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 839a40d1e730977d4448d141fa653517c2959a88
Message-ID: <202312060128.WxlOz810-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_091209_829345_D4B7B09A 
X-CRM114-Status: UNSURE (   4.83  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.7
branch HEAD: 839a40d1e730977d4448d141fa653517c2959a88  nvme: fix deadlock between reset and scan

elapsed time: 1453m

configs tested: 136
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                   randconfig-001-20231205   gcc  
arc                   randconfig-002-20231205   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                   randconfig-001-20231205   gcc  
arm                   randconfig-002-20231205   gcc  
arm                   randconfig-003-20231205   gcc  
arm                   randconfig-004-20231205   gcc  
arm64                 randconfig-001-20231205   gcc  
arm64                 randconfig-002-20231205   gcc  
arm64                 randconfig-003-20231205   gcc  
arm64                 randconfig-004-20231205   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231205   gcc  
csky                  randconfig-002-20231205   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20231205   clang
hexagon               randconfig-002-20231205   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231205   gcc  
i386         buildonly-randconfig-002-20231205   gcc  
i386         buildonly-randconfig-003-20231205   gcc  
i386         buildonly-randconfig-004-20231205   gcc  
i386         buildonly-randconfig-005-20231205   gcc  
i386         buildonly-randconfig-006-20231205   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231205   gcc  
i386                  randconfig-002-20231205   gcc  
i386                  randconfig-003-20231205   gcc  
i386                  randconfig-004-20231205   gcc  
i386                  randconfig-005-20231205   gcc  
i386                  randconfig-006-20231205   gcc  
i386                  randconfig-011-20231205   clang
i386                  randconfig-012-20231205   clang
i386                  randconfig-013-20231205   clang
i386                  randconfig-014-20231205   clang
i386                  randconfig-015-20231205   clang
i386                  randconfig-016-20231205   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231205   gcc  
loongarch             randconfig-002-20231205   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231205   gcc  
nios2                 randconfig-002-20231205   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231205   gcc  
parisc                randconfig-002-20231205   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc               randconfig-001-20231205   gcc  
powerpc               randconfig-002-20231205   gcc  
powerpc               randconfig-003-20231205   gcc  
powerpc64             randconfig-001-20231205   gcc  
powerpc64             randconfig-002-20231205   gcc  
powerpc64             randconfig-003-20231205   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231205   gcc  
riscv                 randconfig-002-20231205   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                  randconfig-001-20231205   clang
s390                  randconfig-002-20231205   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231205   gcc  
sh                    randconfig-002-20231205   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231205   gcc  
sparc64               randconfig-002-20231205   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231205   gcc  
um                    randconfig-002-20231205   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231205   gcc  
x86_64       buildonly-randconfig-002-20231205   gcc  
x86_64       buildonly-randconfig-003-20231205   gcc  
x86_64       buildonly-randconfig-004-20231205   gcc  
x86_64       buildonly-randconfig-005-20231205   gcc  
x86_64       buildonly-randconfig-006-20231205   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231205   clang
x86_64                randconfig-002-20231205   clang
x86_64                randconfig-003-20231205   clang
x86_64                randconfig-004-20231205   clang
x86_64                randconfig-005-20231205   clang
x86_64                randconfig-006-20231205   clang
x86_64                randconfig-011-20231205   gcc  
x86_64                randconfig-012-20231205   gcc  
x86_64                randconfig-013-20231205   gcc  
x86_64                randconfig-014-20231205   gcc  
x86_64                randconfig-015-20231205   gcc  
x86_64                randconfig-016-20231205   gcc  
x86_64                randconfig-071-20231205   gcc  
x86_64                randconfig-072-20231205   gcc  
x86_64                randconfig-073-20231205   gcc  
x86_64                randconfig-074-20231205   gcc  
x86_64                randconfig-075-20231205   gcc  
x86_64                randconfig-076-20231205   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231205   gcc  
xtensa                randconfig-002-20231205   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

