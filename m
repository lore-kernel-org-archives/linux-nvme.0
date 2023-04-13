Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F59C77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rDUSLp9QZyD2Ltl0P+K4SYnvIAC18AZDtvxKb0jDFww=; b=TB/ttpKKUj7iibai6mZEwLDrwE
	AQx3RMo3mJXmvb4Le4IivSbCM6ZtHnPTf5qulsnRA7bYgMDCQHSu6KxW6vIDllG0287xOT3IwpdQ7
	95ES4D8W2jND+1kPVoRRjnO0e+/n4dI/+rBe1qtXD6CVv09SNuec/broLMZf4A/v/USfH5J8/F5t2
	NcQlPzapKqVqiheixOrVsYRJrutg/R5vXU44ror8adO0Jr4ykBXw6HxPnF+X4sJNI4tVnQ20tSIon
	o3Y1bk+rxu8RQ9o+t1rMF8QuxuM5KrNUIoQK4z9Ck+MWKgUGIFg/dYR6ebr3Tt9YxNRVkBU/uJ8/7
	rnKXXq9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn2rm-00725Z-00;
	Thu, 13 Apr 2023 19:44:22 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn2ri-00724n-1a
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 19:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681415058; x=1712951058;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jwrYyEkt9LbKpftTu+SOZa/YCq/W5Ac2RwJkIRa6dd8=;
  b=j1+NWL1QrrmLMwt64ixRPMa0gi+d6G6xsGAqHVV2cCbIUX7buHgZWT8w
   gOUITyGFLDiNoceLgf5jZC7/InWI1SCa8xx1KAD63V+ABVHEQ+/UmFuJw
   IIBLn/47wVGGE+vxWzgUL2V4tnVaueR17zbhhTPWod2LhyW1YP/oTYQKF
   KngO96D+oqr1PTxY1b9ffTL0wNyYJ64biokCAVECLDPavNFJ7VEh2iOIn
   +bf0dWmROOGYQroAgJO34IlDcxgkbdkDXoKlOYbSlAxzXg1S+RQJxE/r2
   TWD6QUVovPs+5gXgjrAiQmtsCJSuHxGE2FA3r5fymMr08tvf6D9NXhCii
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="323908270"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="323908270"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 12:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="778914031"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="778914031"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2023 12:44:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pn2rQ-000YuM-1h;
	Thu, 13 Apr 2023 19:44:00 +0000
Date: Fri, 14 Apr 2023 03:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 4f86a6ff6fbd891232dda3ca97fd1b9630b59809
Message-ID: <64385b4d.A9DCHfjRWIk/0nwr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_124418_663629_446436F0 
X-CRM114-Status: UNSURE (   6.58  )
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
branch HEAD: 4f86a6ff6fbd891232dda3ca97fd1b9630b59809  nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"

elapsed time: 723m

configs tested: 309
configs skipped: 30

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230413   gcc  
alpha        buildonly-randconfig-r004-20230413   gcc  
alpha        buildonly-randconfig-r005-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230413   gcc  
alpha                randconfig-r013-20230409   gcc  
alpha                randconfig-r024-20230413   gcc  
alpha                randconfig-r034-20230409   gcc  
alpha                randconfig-r034-20230412   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc          buildonly-randconfig-r002-20230412   gcc  
arc          buildonly-randconfig-r006-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230409   gcc  
arc                  randconfig-r014-20230413   gcc  
arc                  randconfig-r015-20230413   gcc  
arc                  randconfig-r016-20230410   gcc  
arc                  randconfig-r016-20230413   gcc  
arc                  randconfig-r032-20230410   gcc  
arc                  randconfig-r032-20230413   gcc  
arc                  randconfig-r033-20230409   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230412   gcc  
arc                  randconfig-r043-20230413   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r006-20230413   clang
arm                  randconfig-r012-20230413   gcc  
arm                  randconfig-r021-20230413   gcc  
arm                  randconfig-r026-20230409   clang
arm                  randconfig-r026-20230413   gcc  
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r033-20230412   gcc  
arm                  randconfig-r046-20230412   clang
arm                  randconfig-r046-20230413   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230413   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
arm64                randconfig-r014-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r025-20230412   gcc  
arm64                randconfig-r026-20230409   gcc  
arm64                randconfig-r031-20230413   gcc  
arm64                randconfig-r032-20230413   gcc  
arm64                randconfig-r034-20230413   gcc  
arm64                randconfig-r035-20230413   gcc  
arm64                randconfig-r036-20230413   gcc  
csky                             alldefconfig   gcc  
csky         buildonly-randconfig-r003-20230410   gcc  
csky         buildonly-randconfig-r004-20230411   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
csky                 randconfig-r026-20230413   gcc  
hexagon              randconfig-r002-20230413   clang
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r045-20230412   clang
hexagon              randconfig-r045-20230413   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r011-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64         buildonly-randconfig-r006-20230411   gcc  
ia64         buildonly-randconfig-r006-20230413   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r013-20230409   gcc  
ia64                 randconfig-r016-20230411   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r034-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230410   gcc  
loongarch    buildonly-randconfig-r003-20230409   gcc  
loongarch    buildonly-randconfig-r004-20230409   gcc  
loongarch    buildonly-randconfig-r006-20230413   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r015-20230411   gcc  
loongarch            randconfig-r021-20230410   gcc  
loongarch            randconfig-r024-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r011-20230412   gcc  
m68k                 randconfig-r011-20230413   gcc  
m68k                 randconfig-r012-20230409   gcc  
m68k                 randconfig-r013-20230412   gcc  
m68k                 randconfig-r015-20230410   gcc  
m68k                 randconfig-r036-20230409   gcc  
microblaze   buildonly-randconfig-r003-20230411   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r013-20230413   gcc  
microblaze           randconfig-r016-20230413   gcc  
microblaze           randconfig-r025-20230413   gcc  
microblaze           randconfig-r033-20230413   gcc  
microblaze           randconfig-r035-20230409   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r001-20230410   gcc  
mips         buildonly-randconfig-r002-20230409   gcc  
mips                     decstation_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r014-20230413   gcc  
mips                 randconfig-r023-20230413   gcc  
mips                 randconfig-r024-20230413   gcc  
mips                 randconfig-r025-20230409   clang
mips                 randconfig-r026-20230410   clang
mips                 randconfig-r031-20230410   gcc  
nios2        buildonly-randconfig-r003-20230413   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230409   gcc  
nios2                randconfig-r014-20230413   gcc  
nios2                randconfig-r015-20230413   gcc  
nios2                randconfig-r016-20230409   gcc  
nios2                randconfig-r016-20230410   gcc  
nios2                randconfig-r022-20230413   gcc  
nios2                randconfig-r024-20230410   gcc  
nios2                randconfig-r035-20230409   gcc  
openrisc     buildonly-randconfig-r002-20230411   gcc  
openrisc     buildonly-randconfig-r002-20230413   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
openrisc     buildonly-randconfig-r006-20230409   gcc  
openrisc     buildonly-randconfig-r006-20230413   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r012-20230410   gcc  
openrisc             randconfig-r015-20230410   gcc  
openrisc             randconfig-r022-20230413   gcc  
openrisc             randconfig-r023-20230409   gcc  
openrisc             randconfig-r023-20230413   gcc  
openrisc             randconfig-r024-20230412   gcc  
openrisc             randconfig-r025-20230413   gcc  
openrisc             randconfig-r035-20230413   gcc  
parisc       buildonly-randconfig-r002-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r011-20230410   gcc  
parisc               randconfig-r011-20230413   gcc  
parisc               randconfig-r013-20230411   gcc  
parisc               randconfig-r014-20230409   gcc  
parisc               randconfig-r016-20230412   gcc  
parisc               randconfig-r021-20230413   gcc  
parisc               randconfig-r022-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc               randconfig-r031-20230412   gcc  
parisc               randconfig-r032-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc      buildonly-randconfig-r002-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230409   gcc  
powerpc                       holly_defconfig   gcc  
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r014-20230412   gcc  
powerpc              randconfig-r015-20230409   gcc  
powerpc              randconfig-r015-20230410   gcc  
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r025-20230410   gcc  
powerpc              randconfig-r034-20230413   gcc  
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230412   gcc  
riscv                randconfig-r042-20230413   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230409   gcc  
s390         buildonly-randconfig-r005-20230410   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230409   gcc  
s390                 randconfig-r022-20230409   gcc  
s390                 randconfig-r023-20230409   gcc  
s390                 randconfig-r025-20230410   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230412   gcc  
s390                 randconfig-r044-20230413   clang
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r001-20230412   gcc  
sh           buildonly-randconfig-r004-20230410   gcc  
sh           buildonly-randconfig-r005-20230411   gcc  
sh           buildonly-randconfig-r005-20230413   gcc  
sh                               j2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r012-20230412   gcc  
sh                   randconfig-r013-20230410   gcc  
sh                   randconfig-r023-20230409   gcc  
sh                   randconfig-r023-20230410   gcc  
sh                   randconfig-r026-20230409   gcc  
sh                   randconfig-r032-20230412   gcc  
sh                   randconfig-r036-20230413   gcc  
sh                           se7724_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230409   gcc  
sparc        buildonly-randconfig-r003-20230413   gcc  
sparc        buildonly-randconfig-r005-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230410   gcc  
sparc                randconfig-r015-20230412   gcc  
sparc                randconfig-r021-20230409   gcc  
sparc                randconfig-r023-20230412   gcc  
sparc                randconfig-r026-20230410   gcc  
sparc                randconfig-r031-20230409   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc64      buildonly-randconfig-r001-20230409   gcc  
sparc64      buildonly-randconfig-r004-20230413   gcc  
sparc64      buildonly-randconfig-r005-20230410   gcc  
sparc64      buildonly-randconfig-r005-20230412   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r013-20230413   gcc  
sparc64              randconfig-r014-20230413   gcc  
sparc64              randconfig-r016-20230410   gcc  
sparc64              randconfig-r021-20230409   gcc  
sparc64              randconfig-r021-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r006-20230410   clang
x86_64               randconfig-r022-20230410   gcc  
x86_64               randconfig-r025-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230411   gcc  
xtensa       buildonly-randconfig-r001-20230413   gcc  
xtensa       buildonly-randconfig-r003-20230413   gcc  
xtensa       buildonly-randconfig-r006-20230409   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r016-20230409   gcc  
xtensa               randconfig-r034-20230410   gcc  
xtensa               randconfig-r035-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

