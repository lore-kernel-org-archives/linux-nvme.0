Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E56C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 20:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4+Zwo36e4/Os1J8A+KV440+bPIHGKdPlqVOtpNtPads=; b=U3J/Ym/j9N0fnhRj7mvYyq8Zej
	RXDbFuKgH/SznsvlCZgPY9AVdLOfdYGuuRlJQ5vJXNhOa/xeXe2/9I9qsea6hAfUz/Pzmyvih7GXX
	XehgrGQhcdqTEcjkt5iTYSc1c80P3O6RkS7CX4nMPXycUcrTf+d5lqNOIYX7GGzj4smOyhfkku7hq
	9DXAABWuOpS7dnR4XBJUF6ENY2Ev9tYAo7N6mSsq6phaPPPtKqcuD36Zg42WBkS8a3lUbgBD1gOVv
	w0VI6Uk/5+GtdDWB86gv9ldX4/6g7e55vFluFBFNXoXICm0365EM2jGs2gKD7njJqFZd8aF5kgL1v
	IxhjkXwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmKkC-0016Kc-25;
	Tue, 11 Apr 2023 20:37:36 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmKk9-0016K9-2t
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 20:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681245453; x=1712781453;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5kLOpo4CP4uRuzZwpMPzqboecnj9unFlyFpERsXWFQI=;
  b=H38ofLWkfUtdx7uSh4VcWPXS5HGGd7aBoNKQWBiVplVuQIdBO9GOKB75
   KC9wr1Oaw19iKL+hWdBYFmmj9thXXBhbXTdfhhHUMtJC4YiszMmP/tJ0Q
   hOrmFsR6N3G1eKbOMgrGrFOkmmRed47md0CjUTiNhnkOI4XnFabsVRvpQ
   JKxGyK72JRugl/ABQ5s+AWvg2XtQcZGw28W+JamR5MX42A/OHqiN0mXBw
   iam0FZbUAKqEnKci+/3HW+nyleZ4vKywgI6zd1yd8CqVYlOIH6htftT18
   wftlh7xS9dRtxeRhb+pn334ZcHoVbRDL8Xh0sgTiJYEUvDixW04KFNwYk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345521518"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345521518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 13:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863041230"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="863041230"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2023 13:37:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmKk2-000WgP-2X;
	Tue, 11 Apr 2023 20:37:26 +0000
Date: Wed, 12 Apr 2023 04:37:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 078808f1c9f327eaaabfb482a1873bc4037d2b9c
Message-ID: <6435c4f3.wyUeckPNA+pcyfu3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_133734_013624_BEFAFEDD 
X-CRM114-Status: UNSURE (   7.06  )
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
branch HEAD: 078808f1c9f327eaaabfb482a1873bc4037d2b9c  nvme-rdma: minor cleanup in nvme_rdma_create_cq()

elapsed time: 803m

configs tested: 143
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230409   gcc  
alpha        buildonly-randconfig-r004-20230410   gcc  
alpha        buildonly-randconfig-r005-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230409   gcc  
alpha                randconfig-r034-20230409   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230410   clang
arm                                 defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                  randconfig-r011-20230409   clang
arm                  randconfig-r012-20230409   clang
arm                  randconfig-r016-20230409   clang
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230409   clang
arm64                randconfig-r021-20230410   gcc  
arm64                randconfig-r032-20230410   clang
csky         buildonly-randconfig-r002-20230409   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230410   gcc  
hexagon              randconfig-r011-20230409   clang
hexagon              randconfig-r026-20230410   clang
hexagon              randconfig-r031-20230409   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
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
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r011-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230410   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230410   gcc  
ia64                 randconfig-r006-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230409   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230410   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230410   gcc  
microblaze   buildonly-randconfig-r001-20230409   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230410   clang
mips                 randconfig-r012-20230410   clang
mips                 randconfig-r031-20230410   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230409   gcc  
nios2                randconfig-r002-20230409   gcc  
nios2                randconfig-r016-20230410   gcc  
nios2                randconfig-r023-20230410   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
openrisc             randconfig-r015-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc              randconfig-r015-20230409   gcc  
powerpc              randconfig-r035-20230410   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r036-20230409   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230410   clang
s390                 randconfig-r012-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230409   gcc  
sparc        buildonly-randconfig-r002-20230410   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230410   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc64              randconfig-r026-20230409   gcc  
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
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r005-20230410   gcc  
xtensa               randconfig-r034-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

