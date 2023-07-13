Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE1CEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7cBNJBln13Z4ZTZ8QaglSA6V6Fhc7Ft4Msj5/RmlglQ=; b=RurY78v4bV9SVErt79uKSokpD5
	3K/H+foxM+CDdylImVBUPtSqybQA956KZMJm4CyqU+uJYU1kZcTYqo3qq7Zf0XnHOGfiPiyG2lsQD
	UlR5z1WnQg/wbLlAIQbJa6Cj9PFU4kkr9rXFV2Qz2tf9OmYzLhz7Rssd6WAnqXVAU4yJjjIcbM42z
	nAcdwsCSOxomGCoaGy3WKmw5cyQ+UvKsMC9jemBPIFUry0qylZ92TXa8GHei1Fi1uQru/npgp7Ql/
	QziJ736A5ozmfDvass1rSQlKjBj3cMkK+qIBpskyZg687b2pepeEDujSUniQ+wCy7ZA62Sq8BIidf
	MRIgVHrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJp2K-0021Yz-3A;
	Thu, 13 Jul 2023 05:38:45 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJp2I-0021Xg-1G
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 05:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689226722; x=1720762722;
  h=date:from:to:cc:subject:message-id;
  bh=O+vRI+4PElzHIIBCZfKyWeaCXg3xutL3wEZEp891/2I=;
  b=XQ1ccnMPuZcQgV6nATXik08r68lMqW47MBNIoU7AEaSupfBBSedHUeaM
   fqB285OMs8GBjAM+oHDg1nHbHN2nsxcplYi5KrpugT5WBS1dPTS+cSiW8
   OkCynVXvSQcnoEjOdLFaFowa8JHNVNzNztnf1C+duXcQK07oUJfTpw+Ml
   Xgmldmr+Zuq3NOKk85uiWisvThgiYVoTeQijGaOU9ZfLlKQVPxTaHf1hk
   zxOJqn5mtO51Asy9t1HGsqXQ5v9mUZPPFMefRzlp1Md0oUaRLRyc//eAy
   4GeMsCcKZT58x/bCEp92YIT21bxOP08ujv53q6uqunLKFjNIfpz888duz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367718820"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="367718820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 22:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="721793989"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="721793989"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2023 22:38:37 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qJp2C-0006Gf-16;
	Thu, 13 Jul 2023 05:38:36 +0000
Date: Thu, 13 Jul 2023 13:38:08 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 71a5bb153be104d9175636e95166fd5e37466649
Message-ID: <202307131306.SLdeTek4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_223842_491345_A7873387 
X-CRM114-Status: UNSURE (   7.34  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.5
branch HEAD: 71a5bb153be104d9175636e95166fd5e37466649  nvme: ensure disabling pairs with unquiesce

elapsed time: 726m

configs tested: 148
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230713   gcc  
arc                  randconfig-r036-20230712   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r046-20230712   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r012-20230713   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230712   gcc  
csky                 randconfig-r006-20230712   gcc  
csky                 randconfig-r014-20230713   gcc  
csky                 randconfig-r016-20230713   gcc  
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230710   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230712   gcc  
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230712   clang
i386                 randconfig-i016-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230712   gcc  
loongarch            randconfig-r023-20230712   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230713   gcc  
microblaze           randconfig-r004-20230712   gcc  
microblaze           randconfig-r005-20230712   gcc  
microblaze           randconfig-r012-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 randconfig-r002-20230712   clang
mips                 randconfig-r034-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230713   gcc  
openrisc             randconfig-r022-20230712   gcc  
openrisc             randconfig-r023-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230713   gcc  
parisc               randconfig-r035-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc              randconfig-r014-20230713   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230713   gcc  
riscv                randconfig-r026-20230712   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230712   gcc  
s390                 randconfig-r011-20230713   gcc  
s390                 randconfig-r044-20230710   clang
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230712   gcc  
sparc                randconfig-r005-20230712   gcc  
sparc                randconfig-r033-20230712   gcc  
sparc64              randconfig-r024-20230712   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230713   gcc  
x86_64               randconfig-r031-20230712   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

