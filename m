Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B22EEB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 05:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+7vvkCLlINBOwl2qHx5zEYfRrn/dlab/vc2JyyXc/Pg=; b=SoCZED1BAptvgtFHxaaNBLPC/T
	Zfi7jPLOuQ92qqr3YwYP9oz1C5lNoCrfMsfYH14H/0wKqlc88eRIQicyMdlgInYwwUtLCny0LBQSh
	eB8jWrJgIY8cjbJplmphggqaPK5KN4hqTrWlaUWabR6KIW5tz9KcnOGgTDYMJ1M+gBGtatKrRTE5f
	IOIanEx33nz2eFsjt9ty/YFTl5CV72ZEyYz9RKLqVOIbh1zLyzxb8hSIogOizXeJ1WJ6W7jS3icvO
	PL7x5ePus165I0qVKDm1apK7yte366tWyYvIPylTmOx3XrsTA+k5OtQ7DG1giktnWt+xr/W1p0JFW
	AWrBd7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9JK7-00AGym-1y;
	Wed, 14 Jun 2023 05:45:39 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9JK2-00AGxE-38
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 05:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686721534; x=1718257534;
  h=date:from:to:cc:subject:message-id;
  bh=6TZtl0ZvSowwf5+ATiNMYmDCPFiQBlCT4zJS4Agt5Rk=;
  b=M3/0fWlS8+IBpfJHgAhgjGiO9ZHC0LJrQhOApqQVZbc8L/drawqX5iu2
   Ph51A+POnL30EQoQ8chc3IGVTWGyY5OPJvKyj/Bt+qAd7tq8J7bbQ/hZz
   ZiZQrB26jy6BKb1ExUlpM6Z8Kh449UrEIgvrqvtn7/3tf+/udG1G7XsoH
   OgJbWhp8B52fGaPCArOfsWwOppC+zle4gLY8hmrRqFiFRknbBdUuqzXkC
   Skd5O9MKxhX8xdpMRSl1ofOpsfBYbBPtIHmFwKAD0xcfHYZBBEqzkuIJu
   UxsQRJeCtIT+q+rm1ddDPE/2hz7a0NrE9Kd4w6IDmuyWKFFpAEw8Cc+nq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338881158"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338881158"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 22:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1042061104"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="1042061104"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 22:45:30 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q9JJx-0000EX-1R;
	Wed, 14 Jun 2023 05:45:29 +0000
Date: Wed, 14 Jun 2023 13:45:11 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5-merged] BUILD REGRESSION
 84a1df76eb397f3b8bf3a386bfcfb2e84f75554b
Message-ID: <202306141309.qAyrOS6U-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_224535_028200_5E174B59 
X-CRM114-Status: UNSURE (   4.52  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.5-merged
branch HEAD: 84a1df76eb397f3b8bf3a386bfcfb2e84f75554b  nvme: skip optional id ctrl csi if it failed

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306140401.DgFYAeVz-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/block/swim3.c:919:15: error: too many arguments to function 'floppy_locked_ioctl'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-buildonly-randconfig-r002-20230612
    `-- drivers-block-swim3.c:error:too-many-arguments-to-function-floppy_locked_ioctl

elapsed time: 720m

configs tested: 103
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230612   clang
arm64                randconfig-r021-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230612   gcc  
csky                 randconfig-r016-20230612   gcc  
csky                 randconfig-r032-20230612   gcc  
hexagon              randconfig-r014-20230612   clang
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
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230612   gcc  
microblaze           randconfig-r002-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230612   gcc  
mips                 randconfig-r031-20230612   gcc  
mips                 randconfig-r034-20230612   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r036-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230612   gcc  
parisc               randconfig-r005-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc              randconfig-r024-20230612   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230612   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

