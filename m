Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBD8C43334
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jul 2022 04:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6mfx+/8PKMlmBNJ0bqcB9tusp0Z5Y47PneNRDTph6uQ=; b=X1rfwWgtcTQgkO9BQEU0Mr65Le
	JzwbOMyO4nBOfBH4TC7s4vKSFRaPnfxqnMJSzMlz83fdHvuwEdIlL0yUrKbMmjOE3xQ7RLMv1hCuC
	DWWmpKfBiBbv3/uYMNdg8UZx/WXPMwZwvwvwD+7bUus7UuUcYFGiBh9Knpk/6yzGn1dNl+0Iyc06o
	acM4in6lXmQKm8DrYZ5zzmbQfKLEKilKNbbJx13HQxbaONXzE/PaXbUQBrogSR/5UUPEOoSZ2aHOI
	cIUCsdAZdW4xYH+vEvAO68wmcQOH2YypXb3KlGimQBwlfKwDvmB9IekYzXSOZ9OWpZvQkqvuWbPx/
	v7kWHXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF75d-00Fnqu-4f; Sat, 23 Jul 2022 04:50:09 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF75a-00Fnpo-3Z
	for linux-nvme@lists.infradead.org; Sat, 23 Jul 2022 04:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658551806; x=1690087806;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Msqvl3Uu9cHbORu4i5vah37a9aPGyYiQWagKysrVv9A=;
  b=AtE3ilI1/trF2RvbHGdFJyEWrIToYGu808K3ldmUgFokQdtk+yeYl4/q
   qTjm5ck4EMLSchg1wevJkkb8z91rRQ81nor0SC3n/bQWl5ae8ZvuxkYQX
   OINW+iBgx3JGyXNEcp3bnx3DNB5RU0x1gwFt3vxJ2KU5QBeUMnKPetq9N
   PWKEUvvjAmDyZbvW4bBVFZ83Lq8wjBn7nOwCtb9ayCc5OEzGKeyOaNecq
   VSeV8hSotSQjMQTy2wM93VAu4DCwRF6oAM6RzaSHJWdXJCRfMTfzlgIaH
   Nhj2FH32eAt5IYc/N88lpFsApFEdiGNe0szNLXf0aB+hS+BqnrupY01JP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="288202142"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="288202142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 21:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="926281195"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jul 2022 21:50:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oF75W-0002Gb-1b;
	Sat, 23 Jul 2022 04:50:02 +0000
Date: Sat, 23 Jul 2022 12:49:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD REGRESSION
 db6c4eb373fed6bb78f4aab2c9e4de0cc8e9c7ed
Message-ID: <62db7ded.8ujUhgzC6JDqabDt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_215006_261042_FD1B87EF 
X-CRM114-Status: UNSURE (   5.57  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.20
branch HEAD: db6c4eb373fed6bb78f4aab2c9e4de0cc8e9c7ed  nvme: enable generic interface (/dev/ngXnY) for unknown command sets

Error/Warning reports:

https://lore.kernel.org/llvm/202207230815.GclNqpQx-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "nvme_get_opcode_str" [drivers/nvme/host/nvme.ko] undefined!

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc-randconfig-r012-20220721
    `-- ERROR:nvme_get_opcode_str-drivers-nvme-host-nvme.ko-undefined

elapsed time: 720m

configs tested: 91
configs skipped: 3

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
arm                           u8500_defconfig
sh                             shx3_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
arc                    vdk_hs38_smp_defconfig
alpha                               defconfig
parisc64                         alldefconfig
sh                           se7724_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
mips                           ci20_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
hexagon                             defconfig
mips                          ath79_defconfig
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
arm                       versatile_defconfig
powerpc                      ppc44x_defconfig
arm                         hackkit_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

