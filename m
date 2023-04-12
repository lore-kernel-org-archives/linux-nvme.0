Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523FBC7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lplo5S/f3u70a8E177pjMM6XSGrFK1Yu5T6Cbe3CdTc=; b=QEO9QaIXD/uy0VdHULoq7b7CCQ
	eNThMlTKTZmZ/48cj08/FZqud91FOUvqscgwSkwr/I+WNOFPoxTszp+arbcMLxP+lD+hLnSjOazFu
	wsDQAj6PY8iYHwe4xjbtlenl1cr1T3qdZWrEnNTair1OS3kSgFQdr1xMqH/QvAMYueOBsCxm72tf3
	OoFdxHU6Hsp5tXBsG9U1myaZNhgVPkUg1IFVx/wZ0+FfZChRnGq3ZppAJKJbVixag/YjHzx645OTY
	IHkJ+5vF58ENEafBO2NtzvmoFtfLvEpd1cqXEZsLbsNWzbMBCahg2gABYd6FeEQatkMoHPp7vvAV3
	pP1G2CAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmfX8-0045yb-2R;
	Wed, 12 Apr 2023 18:49:30 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmfX5-0045y5-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 18:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681325367; x=1712861367;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ExN+MwBHMCft2h2pdSo6MGTDYP8AJBKy6l68xyUZQGc=;
  b=app9BAKzB/n7nBj4EeWhGR2AqTokhEWtBiohbcgOGrtDC60dl0TRzdtP
   BeWL/h3+RrL36Ofjzf70VIvo3zvy61x0vE0mu3FATtIiP/zzfnn/jFXJW
   5wi15qK3e3wP8nPmfDOAhv4MDK4FKuC65D3yC0UnWs4SNK52F0uuEn2aS
   esbK1htpqXdPSR/BrVSxAQhpPF5LJqbyVzPAt5nYIJKalAFnROF8zh7yF
   s4agimb5xv/ucoMu94m7ByPgPprJHYWt+nOQWhziQu3vmNd6oU8ZL724h
   Hw8vJCvQoYlu5baZC51TM6ZfF0s+GA9q+d1amOM3OxB7S+2xmPcIwjXN8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="409132642"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="409132642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="1018837231"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="1018837231"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2023 11:49:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmfWz-000Xzd-0S;
	Wed, 12 Apr 2023 18:49:21 +0000
Date: Thu, 13 Apr 2023 02:49:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 0f8e84f6053cba04353411ea3e930a7b21fea8b3
Message-ID: <6436fd24.q2ezIbAqgyClYoaZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_114927_222296_E7687ED9 
X-CRM114-Status: UNSURE (   6.25  )
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
branch HEAD: 0f8e84f6053cba04353411ea3e930a7b21fea8b3  blk-mq-rdma: remove queue mapping helper for rdma devices

elapsed time: 724m

configs tested: 192
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
alpha                randconfig-r013-20230410   gcc  
alpha                randconfig-r016-20230409   gcc  
alpha                randconfig-r023-20230410   gcc  
alpha                randconfig-r026-20230410   gcc  
alpha                randconfig-r034-20230410   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r016-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230412   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230409   clang
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r022-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r026-20230409   gcc  
arm64                randconfig-r035-20230409   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r015-20230409   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
hexagon              randconfig-r033-20230409   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230410   clang
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
i386                 randconfig-r006-20230410   clang
i386                 randconfig-r036-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230412   gcc  
ia64                 randconfig-r012-20230412   gcc  
ia64                 randconfig-r013-20230409   gcc  
ia64                 randconfig-r022-20230409   gcc  
ia64                 randconfig-r032-20230412   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230410   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230410   gcc  
loongarch            randconfig-r012-20230409   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
loongarch            randconfig-r015-20230410   gcc  
loongarch            randconfig-r022-20230412   gcc  
loongarch            randconfig-r024-20230409   gcc  
loongarch            randconfig-r031-20230412   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230410   gcc  
m68k         buildonly-randconfig-r005-20230409   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230412   gcc  
m68k                 randconfig-r013-20230412   gcc  
m68k                 randconfig-r016-20230410   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
m68k                 randconfig-r032-20230409   gcc  
microblaze   buildonly-randconfig-r006-20230409   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
microblaze           randconfig-r032-20230410   gcc  
microblaze           randconfig-r033-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r036-20230412   gcc  
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r036-20230409   gcc  
openrisc     buildonly-randconfig-r002-20230409   gcc  
openrisc             randconfig-r024-20230410   gcc  
openrisc             randconfig-r031-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r011-20230410   gcc  
parisc               randconfig-r016-20230412   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r034-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230410   gcc  
powerpc                 mpc834x_mds_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r002-20230410   clang
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r013-20230412   gcc  
powerpc              randconfig-r014-20230412   gcc  
powerpc              randconfig-r015-20230410   gcc  
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r026-20230410   gcc  
powerpc              randconfig-r034-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230410   gcc  
riscv                randconfig-r014-20230412   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r024-20230410   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230410   gcc  
s390                 randconfig-r024-20230412   gcc  
s390                 randconfig-r025-20230410   gcc  
s390                 randconfig-r026-20230409   gcc  
s390                 randconfig-r033-20230410   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r012-20230412   gcc  
sh                   randconfig-r013-20230409   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230409   gcc  
sh                   randconfig-r025-20230409   gcc  
sh                          rsk7264_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230409   gcc  
sparc                randconfig-r015-20230412   gcc  
sparc                randconfig-r035-20230409   gcc  
sparc64              randconfig-r011-20230409   gcc  
sparc64              randconfig-r022-20230410   gcc  
sparc64              randconfig-r023-20230412   gcc  
sparc64              randconfig-r025-20230410   gcc  
sparc64              randconfig-r036-20230410   gcc  
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
x86_64               randconfig-r021-20230410   gcc  
x86_64               randconfig-r022-20230410   gcc  
x86_64               randconfig-r034-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r016-20230409   gcc  
xtensa               randconfig-r025-20230412   gcc  
xtensa               randconfig-r034-20230412   gcc  
xtensa               randconfig-r035-20230410   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

