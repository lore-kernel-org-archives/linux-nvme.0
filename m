Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B358C7EE2E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0i53q92PBjrQu0LEZ5VbZdf1wdVa8GKE6rU2Etl2zb4=; b=2JL3K1+wn5BkAtaUmdcub8IjeL
	Gy6SgmZ8F5o5FBQIOlGeCoU/lPp7VWYAJY+PU7iYVNPFG3GjMkiN74mR+TjCLlWBV18ma9dUIJLyM
	wwquOtfSBBqTkNSt+81dhsaY465XJpPS+9bsP3Hh7Srq8O5DlHk9oEZBUC32TJ3qgzGMcw9g9xjUU
	IbODixivgM/14kVROIVuPX9cW3x0Je2Lka2nueFrqPm44hhA5RuF1bh8PoA4xu831bCE3uXOggkwA
	XuOy/l7I4G/LjlcN9QP3p20ICv4ISEorPjFSPS19tMUtfkXENv5tb2+gpyFlbP3x0nrn7MBTeT2RR
	px3SYqiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q90gJ-007Yq6-0I;
	Tue, 13 Jun 2023 09:51:19 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q90gE-007YpB-0J
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 09:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686649874; x=1718185874;
  h=date:from:to:cc:subject:message-id;
  bh=qBcXxS/BzFgjSlzcCowr6IswNh8CTfYSQKSV8UO59pc=;
  b=lGdofqEFkK5nCrR8eJ+T+P4uTc9nF0wOeRmUexkArFjr02B+GhPtTc2M
   AuoFPj27zg8aquiN4T8/E/dvl4xKR6TmVwS9PmJUboDQLaorJ/5BEqEcU
   vgfo962gj5ywdBgIBHcjrcpJFxRQ+pnR3G4dmk+5mcTzJQRasPmO5kNVc
   zVib3id7H2Y1uLrtCyLZL53Sd0K4pMrjC1r1ckaiMME+av3DMZI7vpQh/
   DiYrEziR3laxFFfZ5bDB2TwfE5qTuItSaDD03H2NjRwagm59inZFdH235
   xwucbR2FHK+nsRBPsAuhRJkuvF+BxlCaWi7IGmJmb4JDrWms+yKSVZrgR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361653401"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="361653401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741368419"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="741368419"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2023 02:50:47 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q90fm-0001CY-21;
	Tue, 13 Jun 2023 09:50:46 +0000
Date: Tue, 13 Jun 2023 17:50:04 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:for-6.5/block] BUILD SUCCESS
 d97b4111b3228122284df0263200f02fd44751fd
Message-ID: <202306131700.QpIxLHuv-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_025114_177975_C5D972DF 
X-CRM114-Status: UNSURE (   5.46  )
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

tree/branch: git://git.infradead.org/nvme.git for-6.5/block
branch HEAD: d97b4111b3228122284df0263200f02fd44751fd  nvmet-fcloop: Do not wait on completion when unregister fails

elapsed time: 740m

configs tested: 103
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230612   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r015-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
m68k                 randconfig-r036-20230612   gcc  
microblaze           randconfig-r002-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230612   gcc  
mips                 randconfig-r004-20230612   gcc  
mips                 randconfig-r024-20230612   clang
mips                 randconfig-r031-20230612   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r003-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230612   gcc  
parisc               randconfig-r005-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r023-20230612   gcc  
sparc                randconfig-r033-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230613   clang
x86_64               randconfig-a012-20230613   clang
x86_64               randconfig-a013-20230613   clang
x86_64               randconfig-a014-20230613   clang
x86_64               randconfig-a015-20230613   clang
x86_64               randconfig-a016-20230613   clang
x86_64               randconfig-r012-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230612   gcc  
xtensa               randconfig-r014-20230612   gcc  
xtensa               randconfig-r016-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

