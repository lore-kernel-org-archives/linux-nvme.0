Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B5C76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ALOB1S8yZ/v+0nI30DoauK5xU/oLRNZb0MdssZkI8nw=; b=JTsmD4aTPnRzSnlINkI4+RcAsU
	aNOZ9wqH1Rz5d4afuug8JGuJK2Wozci4k5QZaHX1jmJbvFV81jXYB2h4LRpSIcgU9kEO4Im6uxf3i
	kURcdEMchxBEIHw9ctUnYR5SqrZyeD5HQ7Z+40zpBBtIH+nT8P6ac3juamxalV97hhc2WWpHFZ3co
	4ZL8uqsAs7fU11tUxjEZUq7pkXsqpwvf2HkcTjQ50t6VSbSK7gldwI+EplE6Sdk8EYoNCgC+vSfZz
	4OLVTqtCwtvZHE2qFC3yECNgKNI0C/kfOy4qbRlAOTOSCPmpKkHSrl9387X8Wir/cDamLQjnUJNPc
	ghXV1q9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkGOf-006EFf-2i;
	Thu, 06 Apr 2023 03:34:49 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkGOa-006EEX-0P
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 03:34:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680752084; x=1712288084;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/jM9GEXXyS0bA2H+fzNgQMTIOh1lJNhd9pptVE6c9nA=;
  b=FpvsivWJaLL4JaiGvuixA2ViGZDBoga0URgyR9l++wrwDEkzTeoLlfMO
   Ab61AfVfPofNWHx+lVReuRaWkvaL8AL3quAXyVhvl+0rZWZVg6Z1BUOxQ
   mJNvsqTDUVPF7J1JzOaWZJmdVRtC9W16RiUPYcqTX1/+jAOsfmLlJelAx
   fmg8Is+qT/pWYZDUF0Udih6UUZHNLdBb5nQ07hT/hhYWnbAEsxonds3/p
   SiaW61KnsBwCP7xpurJztTsnixs6pzNtXMYCBZd4W4KVAVU9inJIz/rFL
   PRbAKhu9fB1SPirO2ICKAocF529lswA+/whGbg5qsJbKhZAtUY4wSmkcS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="323005948"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="323005948"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 20:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751497525"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="751497525"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 20:34:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pkGOR-000R1M-0z;
	Thu, 06 Apr 2023 03:34:35 +0000
Date: Thu, 06 Apr 2023 11:33:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 d3205ab75e99a47539ec91ef85ba488f4ddfeaa9
Message-ID: <642e3d9d.mPdTSCb+//uXwLjc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_203444_177295_14D65FDB 
X-CRM114-Status: UNSURE (   5.93  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.3
branch HEAD: d3205ab75e99a47539ec91ef85ba488f4ddfeaa9  nvme: fix discard support without oncs

elapsed time: 723m

configs tested: 107
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r025-20230405   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r024-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
hexagon              randconfig-r024-20230403   clang
hexagon              randconfig-r024-20230405   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-r026-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                 randconfig-r022-20230405   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r014-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

