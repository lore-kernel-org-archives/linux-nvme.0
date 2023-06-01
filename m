Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AAFC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f1WFigbsVMZV/ulkPPXukE9fSgdbSVejgEDwRCO6yiA=; b=q6aySuuZWByb3gZvzAihlUqzec
	twVmvfMX677dJ5TgsrNTxVG2/gJ28rzQVq/PRIGxNJ2diNLuvO2WnKcLtmJ8qhHF/YN6dKhKpLBUZ
	mvePnEjAah6g04r0vQe/V22w2Fz9kBLuS/ZCL3KpepCvZyJcosP667EKks5of+Vpz/SwFAWkBfd4U
	0WaP1fs66z959vpKeRLYxw+rp9+coUaVZwjODL6S6UKuCAYtpriGFQ+9E2QbHOS1qzARgFus/Mp9f
	L0O1i40oPviCjeib7lmly0qiEVsf5fNpKqCA3BSmkAS+yFnYwIgKp6Jklupn/xh7V/8wv4DRLQ3pb
	FHeUUW6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4bdY-0029VU-0T;
	Thu, 01 Jun 2023 06:18:16 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4bdV-0029Ue-0x
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 06:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685600293; x=1717136293;
  h=date:from:to:cc:subject:message-id;
  bh=j+BQQCONWS2SZUrIeDZ8exGQc0hKRzYGyMeqommLFD4=;
  b=buO726AEt8LqRt2t7whDxZ4VN+QBbEgSgX1Ww1NF5mXBt95hV/rRNbNK
   QUcnQhCICBNHWB082GaIg7mKF4EMlhE3lVmomLxDuLGIpcnHl9OvqGN7H
   uWkf/Djnhs/IXDD3TLDxO66Ky0NhfONDMkGJYrobFodQ0SyYxFNPocufw
   hokQnlfwAOOcG0TBOGTHiwrjq9VmnPSj5m5yj5XsF8GR2Z77EE86WJFYl
   5Qp9blHJ0RKV7MjSu9kyKsDjjA1ShRLBjyatAsawVPhUQdAzUtlAUuo99
   tY7LrVyAglez8mX9p5yGKy9NfX26/kDaS4wAsILk3RSpWlH1kVBjLojQH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344992448"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="344992448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 23:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="851524645"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="851524645"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2023 23:18:06 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q4bdO-0001zb-1B;
	Thu, 01 Jun 2023 06:18:06 +0000
Date: Thu, 01 Jun 2023 14:18:05 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4-rc4-pull] BUILD SUCCESS
 856303797724d28f1d65b702f0eadcee1ea7abf5
Message-ID: <20230601061805.SBzLV%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_231813_379978_95A88A5C 
X-CRM114-Status: UNSURE (   9.00  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.4-rc4-pull
branch HEAD: 856303797724d28f1d65b702f0eadcee1ea7abf5  nvme: fix the name of Zone Append for verbose logging

elapsed time: 834m

configs tested: 132
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230531   gcc  
csky                 randconfig-r036-20230531   gcc  
hexagon              randconfig-r025-20230531   clang
hexagon              randconfig-r031-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230531   gcc  
loongarch            randconfig-r013-20230531   gcc  
loongarch            randconfig-r014-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                 randconfig-r003-20230531   gcc  
m68k                 randconfig-r026-20230531   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r035-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r015-20230531   gcc  
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r006-20230531   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230531   gcc  
nios2                randconfig-r024-20230531   gcc  
openrisc             randconfig-r004-20230531   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                     powernv_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230531   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230531   gcc  
sparc64              randconfig-r032-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230531   clang
x86_64               randconfig-a012-20230531   clang
x86_64               randconfig-a013-20230531   clang
x86_64               randconfig-a014-20230531   clang
x86_64               randconfig-a015-20230531   clang
x86_64               randconfig-a016-20230531   clang
x86_64               randconfig-r006-20230531   gcc  
x86_64               randconfig-x051-20230531   clang
x86_64               randconfig-x052-20230531   clang
x86_64               randconfig-x053-20230531   clang
x86_64               randconfig-x054-20230531   clang
x86_64               randconfig-x055-20230531   clang
x86_64               randconfig-x056-20230531   clang
x86_64               randconfig-x061-20230531   clang
x86_64               randconfig-x062-20230531   clang
x86_64               randconfig-x063-20230531   clang
x86_64               randconfig-x064-20230531   clang
x86_64               randconfig-x065-20230531   clang
x86_64               randconfig-x066-20230531   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230531   gcc  
xtensa               randconfig-r034-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

