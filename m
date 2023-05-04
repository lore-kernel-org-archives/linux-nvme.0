Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D3BC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 05:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9gP/wgJ2VJei0N6OlfkbnZ8pyhAJhaLcx9l8pZGE/Io=; b=WeZnfYQzxSfBd9uJkr3BamSfn0
	iZe8Y4dfodUg+rIUwnxdQRYdGUJR4S8pN60mxm6I8H+iCVe+efDLOO6pbj1e8nMcK1VevBPpAPJuf
	tYB3p/fFfiyIkzZdB3KKtw6ea+f/HO89R2ZY0fzh0/k0bVl2lozhBWnrTvjeUOXUmA0jXo0QiGhre
	Xg56PM9AbMU45AjL94KqejWKCwveSCI11kLibErsvEDLoWHsgr8uFl/17nx867oUEMkBiP/VXIa1f
	LrRPkvzpJ7V5O0APgUKzGgkdIqm6vVi7AI8RvTZP4xKeGyPhEveKwlrT5vlMX6Dg90m5SuZZEyuFK
	XvT7EAoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puRD6-006cac-0b;
	Thu, 04 May 2023 05:08:56 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puRD3-006cZh-2F
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 05:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683176933; x=1714712933;
  h=date:from:to:cc:subject:message-id;
  bh=XdWQQXO9Jx6ku8B50e1et5uNqdLvMl8ESVU2jpxfWW0=;
  b=hajD0RsybO+Xgf2b6owAdvv8fqpafLDE6DsEh5gafO1EhJHccbiQLXwv
   FQk2Q4IWygNuqwAvSEmbLyhpSDaWoLzju1jssCkSmrNB7tO0f13eXOmV5
   sqRE0PlqSxvVmH7qc+o0mfw1cTGc387dszjPW1EUwNzk15x7IpxUSVCCZ
   +cGtsQ0ALjNt0BjWtdyGAT2x2nxtGf1UJESjbuwgY4g3SB0O7O8UDYcmQ
   q4qADOtZr8Fi3n42WAGIwdcOzfTQgmar5HbKGyywqEZfgGaStt2Z2HFcu
   HX2dABALc5he1JqtZHOyRzI0ZQNvw7keXPVxlzRiddeluc0Ahy73+nEBI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348878825"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348878825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 22:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="696872003"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="696872003"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2023 22:08:49 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1puRCz-0002an-0v;
	Thu, 04 May 2023 05:08:49 +0000
Date: Thu, 04 May 2023 13:08:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd
Message-ID: <20230504050800.jo9RD%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_220853_769351_0593C165 
X-CRM114-Status: UNSURE (   7.56  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.4
branch HEAD: 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd  nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

elapsed time: 722m

configs tested: 155
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230502   gcc  
alpha        buildonly-randconfig-r006-20230502   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230430   gcc  
arc          buildonly-randconfig-r006-20230430   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230501   gcc  
arc                  randconfig-r022-20230502   gcc  
arc                  randconfig-r031-20230501   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230501   gcc  
arm                  randconfig-r032-20230430   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230430   gcc  
arm64                randconfig-r015-20230501   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230501   gcc  
csky                 randconfig-r006-20230502   gcc  
csky                 randconfig-r012-20230502   gcc  
hexagon              randconfig-r015-20230430   clang
hexagon              randconfig-r015-20230502   clang
hexagon              randconfig-r023-20230502   clang
hexagon              randconfig-r036-20230501   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
i386                 randconfig-r012-20230501   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230501   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230501   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230430   gcc  
loongarch            randconfig-r025-20230430   gcc  
loongarch            randconfig-r035-20230430   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230430   gcc  
m68k         buildonly-randconfig-r002-20230501   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230501   gcc  
m68k                 randconfig-r001-20230502   gcc  
m68k                 randconfig-r013-20230501   gcc  
m68k                 randconfig-r016-20230502   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230501   clang
nios2        buildonly-randconfig-r003-20230430   gcc  
nios2        buildonly-randconfig-r003-20230502   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230501   gcc  
openrisc     buildonly-randconfig-r005-20230430   gcc  
openrisc             randconfig-r004-20230502   gcc  
openrisc             randconfig-r024-20230502   gcc  
parisc       buildonly-randconfig-r006-20230501   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230430   gcc  
parisc               randconfig-r003-20230502   gcc  
parisc               randconfig-r013-20230502   gcc  
parisc               randconfig-r024-20230501   gcc  
parisc               randconfig-r031-20230430   gcc  
parisc               randconfig-r032-20230501   gcc  
parisc               randconfig-r033-20230501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230502   gcc  
powerpc              randconfig-r013-20230430   clang
powerpc              randconfig-r014-20230430   clang
powerpc              randconfig-r026-20230501   clang
powerpc              randconfig-r034-20230501   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230502   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230430   gcc  
riscv                randconfig-r002-20230502   clang
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r025-20230501   clang
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230501   clang
s390                                defconfig   gcc  
s390                 randconfig-r011-20230502   gcc  
s390                 randconfig-r012-20230430   clang
s390                 randconfig-r014-20230501   clang
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230502   gcc  
sh                   randconfig-r011-20230430   gcc  
sh                   randconfig-r022-20230430   gcc  
sh                   randconfig-r033-20230430   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230430   gcc  
sparc64              randconfig-r001-20230430   gcc  
sparc64              randconfig-r002-20230501   gcc  
sparc64              randconfig-r016-20230430   gcc  
sparc64              randconfig-r016-20230501   gcc  
sparc64              randconfig-r021-20230430   gcc  
sparc64              randconfig-r021-20230501   gcc  
sparc64              randconfig-r034-20230430   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r005-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230502   gcc  
xtensa               randconfig-r035-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

