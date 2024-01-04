Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2373C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oAhTZg6s8VerO9I9mMlNCgyZG0vJIfc3IPsHsPYjL6A=; b=ajnq1ERK9JrpwYmP9d2Ytik0m7
	eHhGG6JlBM18gI4fCZx9Qg8n9fk1PqdPbuq5+2QFCFx40ntWL2GTMb8TyH09A+iBqDidquGWceelo
	AC650unX1VhZ2NzR/JB5Vv+0YweIzqEy2DB3RKU2Up6FEYPgmbffAaBNDB3UF3L3dsvjAfDSGiifd
	VzjQ0xe/a5jGO9Az8LmxhiehyK4FzRzB+z88pja5geniPFAqMBWU8sbTuTbplIyACgUfgoOOe7ecJ
	BQlorcNHub9qZSNwFUQF5iE/ESSD9H1if2ZNsm6GcqIuWWL4rnZ2LPauHtjIPLltRCVsHjaHD0JGy
	fR0gqtrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRIV-00EmUK-2x;
	Thu, 04 Jan 2024 17:14:23 +0000
Received: from mgamail.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRIR-00EmSz-0q
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 17:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704388459; x=1735924459;
  h=date:from:to:cc:subject:message-id;
  bh=Bh2nO/Yg3kzsDZ8uhdjz2WxjH2vpZvl9asDXJrgo4uE=;
  b=MQ4sohzRBF67cFb2AY4s3k8iL4L/RURztmfxf1KjooAF70me3b/tmZlv
   l68xiN+nbQIXb0p/j9D9YiardKenC+U5LSrzuMX7Nuzxzfa/NsGy1Avly
   wPqHgI9G7gof1s6uEJLw4b9UVfhHbJqjYBhxDKz39ZUYLE3kfJdbULv6h
   oQoDdKXM9uFs8yEM5tjxv9qO99oSEMNY0uJoCX5OQQILD3v5ngDBkGcsK
   vSUnoGssSKciRrUyKCADnHTh10l6b1KHTFio7Zt5proMm1coCKkPGKoru
   1pS5/EPJwjnMVyHjUcaYbWIDtwV6qXU3DEuBSjeWzrgL5hK1F4+D60vUJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376797039"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="376797039"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="14963501"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jan 2024 09:14:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLRIE-0000Eg-20;
	Thu, 04 Jan 2024 17:14:06 +0000
Date: Fri, 05 Jan 2024 01:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 620a6a938a716c6bd10129ec265731d5cb098a27
Message-ID: <202401050113.BfjRhZz2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_091419_308156_D9D8D78C 
X-CRM114-Status: UNSURE (   5.50  )
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
branch HEAD: 620a6a938a716c6bd10129ec265731d5cb098a27  nvme: introduce nvme_disk_is_ns_head helper

elapsed time: 1477m

configs tested: 147
configs skipped: 0

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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240104   gcc  
arc                   randconfig-002-20240104   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240104   gcc  
arm                   randconfig-002-20240104   gcc  
arm                   randconfig-003-20240104   gcc  
arm                   randconfig-004-20240104   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                 randconfig-001-20240104   gcc  
arm64                 randconfig-002-20240104   gcc  
arm64                 randconfig-003-20240104   gcc  
arm64                 randconfig-004-20240104   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240104   gcc  
csky                  randconfig-002-20240104   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20240104   clang
hexagon               randconfig-002-20240104   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240104   gcc  
i386         buildonly-randconfig-002-20240104   gcc  
i386         buildonly-randconfig-003-20240104   gcc  
i386         buildonly-randconfig-004-20240104   gcc  
i386         buildonly-randconfig-005-20240104   gcc  
i386         buildonly-randconfig-006-20240104   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240104   gcc  
i386                  randconfig-002-20240104   gcc  
i386                  randconfig-003-20240104   gcc  
i386                  randconfig-004-20240104   gcc  
i386                  randconfig-005-20240104   gcc  
i386                  randconfig-006-20240104   gcc  
i386                  randconfig-011-20240104   clang
i386                  randconfig-012-20240104   clang
i386                  randconfig-013-20240104   clang
i386                  randconfig-014-20240104   clang
i386                  randconfig-015-20240104   clang
i386                  randconfig-016-20240104   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20240104   gcc  
loongarch             randconfig-002-20240104   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20240104   gcc  
nios2                 randconfig-002-20240104   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240104   gcc  
parisc                randconfig-002-20240104   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20240104   gcc  
powerpc               randconfig-002-20240104   gcc  
powerpc               randconfig-003-20240104   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc64             randconfig-001-20240104   gcc  
powerpc64             randconfig-002-20240104   gcc  
powerpc64             randconfig-003-20240104   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20240104   gcc  
riscv                 randconfig-002-20240104   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240104   clang
s390                  randconfig-002-20240104   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20240104   gcc  
sh                    randconfig-002-20240104   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240104   gcc  
sparc64               randconfig-002-20240104   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20240104   gcc  
um                    randconfig-002-20240104   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240104   gcc  
x86_64       buildonly-randconfig-002-20240104   gcc  
x86_64       buildonly-randconfig-003-20240104   gcc  
x86_64       buildonly-randconfig-004-20240104   gcc  
x86_64       buildonly-randconfig-005-20240104   gcc  
x86_64       buildonly-randconfig-006-20240104   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240104   clang
x86_64                randconfig-002-20240104   clang
x86_64                randconfig-003-20240104   clang
x86_64                randconfig-004-20240104   clang
x86_64                randconfig-005-20240104   clang
x86_64                randconfig-006-20240104   clang
x86_64                randconfig-011-20240104   gcc  
x86_64                randconfig-012-20240104   gcc  
x86_64                randconfig-013-20240104   gcc  
x86_64                randconfig-014-20240104   gcc  
x86_64                randconfig-015-20240104   gcc  
x86_64                randconfig-016-20240104   gcc  
x86_64                randconfig-071-20240104   gcc  
x86_64                randconfig-072-20240104   gcc  
x86_64                randconfig-073-20240104   gcc  
x86_64                randconfig-074-20240104   gcc  
x86_64                randconfig-075-20240104   gcc  
x86_64                randconfig-076-20240104   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240104   gcc  
xtensa                randconfig-002-20240104   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

