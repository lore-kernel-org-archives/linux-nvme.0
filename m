Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53876C10F04
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TRvMAlcxOpcdRFCUGoIOYoawGqQ/3O6ZZ/BN9fQ0x8k=; b=BBBnXY/6Qlhk5PxRZAb2CKFtKG
	vtXL2TJS9IB4NhXExxHh66/RNOl11inpfGeZ2ngYIKZ2Keo1NkYW7nEO4pgrne12POA3cVjuYlkN7
	G0UClGE8uAqU/h/LVEyUBYar61jWiauYfSPrpEBdEwA2o1Vz3P/rvcv/RIex1iDzpQFMSd9gNOWYE
	YtLDV/yKjHx7/VZbKcBz8osA9mcdF2+RDZK43yfmyixJUWqZRPnsK/FHdC92RkG5kQQu5Ae5j8Pdx
	x1JW9GPgTJgfGHKtqmJcf3riQhjUV/Gsnmedu1mIzOHzV/WHu77gHTgC1tF7gr7cycelcgxlKW5Ka
	q0aJLG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBiC1-00GaJq-2j;
	Fri, 08 Dec 2023 21:15:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBiC0-00GaJA-11
	for linux-nvme@bombadil.infradead.org;
	Fri, 08 Dec 2023 21:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TRvMAlcxOpcdRFCUGoIOYoawGqQ/3O6ZZ/BN9fQ0x8k=; b=kGz62ugmmVzRwNv7wUanRLq1V8
	Vfh7WmGHRoZbOsMH98mIpmOZ4N25+SxcUaHuLhrHEqNabx6aNTfh1HQnVee2ak704hIWzKecQU264
	roGQzKA8/Gjc74t+X/+4DOvEsx1myLaLWK4wLVRNgqrQL6KgEie7jY9ZizU1XS/v4HpHL6W7MoHDO
	YExtpO4y7Kjv7Y5xccr+qiIEimCBjWyXnYTn/B7zAwG/REKKoMNPfQqBh2bnTCA7r32pVOb6gTyzL
	3qNPDHxB4carH6J7H3COraDhWHJFzHEDGNEsNlXnLva+HD7ZRQzgvX6emO1n3Wikk2Ym383/T9wEe
	ygHZgddA==;
Received: from mgamail.intel.com ([198.175.65.13])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBiBw-006ad3-4k
	for linux-nvme@lists.infradead.org; Fri, 08 Dec 2023 21:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702070125; x=1733606125;
  h=date:from:to:cc:subject:message-id;
  bh=Falm9qqRM6/qOl2F5SqnWlaPKjjIgUo44DCtyLuJSbE=;
  b=PpJEEkd97ymTPXE/XicTGFc8jXr3TjPXq5C56mlQpKEjY805k1CqQBsF
   Uk7RARlilIwgzbctrLASlRzV164DQDY8QwatNkZREnVLAXhObwKcYl+N5
   jyc7mqestPJxn1mNBLgE362W3HzlvYNa4Fc7IZydfngPPZ8m99QxoaX6p
   G19+sSw6o0meAhj2wZaz9B6pFuXN1EXFWQZxd68d/TNAnFOdpE0qmpYl3
   dTtMzl2GGDlDhxn7uLoUa2LGrsbm8GiIXjQyTaCd6bb7bqau6Egmvp2o4
   swmOzOGjFOUiS+JCKw/fcygRrqD45xbufrE10UidUm8znTEQ1+fVtolWb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1531739"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1531739"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772261732"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772261732"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2023 13:14:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBiB8-000ENz-0U;
	Fri, 08 Dec 2023 21:14:34 +0000
Date: Sat, 09 Dec 2023 05:14:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 107b4e063d78c300b21e2d5291b1aa94c514ea5b
Message-ID: <202312090525.5IsnNZPg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_211524_551052_4B734B74 
X-CRM114-Status: UNSURE (   5.99  )
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
branch HEAD: 107b4e063d78c300b21e2d5291b1aa94c514ea5b  nvme-pci: Add sleep quirk for Kingston drives

elapsed time: 1647m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                   randconfig-004-20231209   gcc  
arm                           sama5_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231209   gcc  
arm64                 randconfig-002-20231209   gcc  
arm64                 randconfig-003-20231209   gcc  
arm64                 randconfig-004-20231209   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231209   gcc  
csky                  randconfig-002-20231209   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231209   clang
hexagon               randconfig-002-20231209   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231209   gcc  
loongarch             randconfig-002-20231209   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                      maltaaprp_defconfig   clang
mips                      pic32mzda_defconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231209   gcc  
nios2                 randconfig-002-20231209   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231209   gcc  
parisc                randconfig-002-20231209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20231209   gcc  
powerpc               randconfig-002-20231209   gcc  
powerpc               randconfig-003-20231209   gcc  
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-001-20231209   gcc  
powerpc64             randconfig-002-20231209   gcc  
powerpc64             randconfig-003-20231209   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231209   gcc  
riscv                 randconfig-002-20231209   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231209   clang
s390                  randconfig-002-20231209   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231209   gcc  
sh                    randconfig-002-20231209   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231209   gcc  
sparc64               randconfig-002-20231209   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231209   gcc  
um                    randconfig-002-20231209   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231209   gcc  
xtensa                randconfig-002-20231209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

