Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A46AC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 08:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tQBh2064E/IVWwXS3iojValOe3JPGqx4pg2Tb529p8o=; b=jbgnDhyNihoa/GzaxAhtBTT5WK
	3qqqx+h32y/UfJLZ9zil7OJcP/yTFwSdpwGOi6WxN2XrribE1M+mgTG+QvuwlQo77Qmsz+wQQW1ec
	+sxmyE/GzJPBKIKOKnzEyZK9AJ3B+0haUUnwprtV/YrofLrK8WQIII5s26qpOApq1/sTaHQ2xaNcI
	5GJ2QfgnZwXwT80Ox90/BGcUrC7gCxFYMXFxPfMv5NbwaWIwabEX1MyeiX4+3IEqIJZhFLtRHddXU
	waOuRyGboTVu8MgB7iqApdZvwCJxKKFNRWY8KKMkeADP4VP2FTi3lWhe6n44l+oXf1Edrq/BQTWSx
	0FC1WEsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEnax-000OnV-HL; Mon, 09 Jan 2023 08:33:27 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEnaq-000Om2-Rx
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 08:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673253200; x=1704789200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jGf3RSlnQ+GwAr5WWEORw8KZDFxF2f899i0i/Aw3dnM=;
  b=aMVaBRbnHYoJDXRlTry/HttQqrNjD+XJ67UsuRkAAbpYq3qmEA5v4MWF
   XTyrOHOcv3FsRj8Gc9pXHggtETzHyK2Ky2TZDHIRdEFUO7T9L0RyaRRcc
   Gv54PPv8QHMszJv7ydBj9brItg+5zr0qECD0+wyJVEa5P/6XVmZabwP19
   s4fXY6hnjmBZAWrNuJQdopQpR6zJS0fbBaeY3zNozsOuG0meBRzFrAn/u
   HMUme8ejOxdMkaXUu3et8NWXlpAqzUnGoCDZ07R9UkupI0ozqvQs5+e53
   9ddGlaZhBQGYFACpPrYgqXuBfODwiLeezJVi17XE4TIlQJfVFs50XWIge
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322897706"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322897706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 00:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="901927158"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="901927158"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2023 00:33:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pEnan-0006Ug-07;
	Mon, 09 Jan 2023 08:33:17 +0000
Date: Mon, 09 Jan 2023 16:32:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 33cdfd15fd37ce18cc3c13af705f42e2da700883
Message-ID: <63bbd133.85CEWdN4v2SgaBaz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_003321_216898_76C744BE 
X-CRM114-Status: UNSURE (   6.71  )
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
branch HEAD: 33cdfd15fd37ce18cc3c13af705f42e2da700883  nvme-pci: place descriptor addresses in iod

elapsed time: 811m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                            allnoconfig
x86_64                              defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
arm                                 defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a015-20230109
i386                 randconfig-a016-20230109
arc                                 defconfig
s390                             allmodconfig
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a012-20230109
x86_64               randconfig-a014-20230109
x86_64                           rhel-8.3-bpf
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a016-20230109
s390                                defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
s390                             allyesconfig
x86_64               randconfig-a015-20230109
arm                  randconfig-r046-20230108
mips                             allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20230108
arm                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                      makalu_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                           sun3_defconfig
sparc64                          alldefconfig
powerpc                 mpc837x_rdb_defconfig
arm                        oxnas_v6_defconfig
arm                        multi_v7_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig
i386                          randconfig-c001
arm                         axm55xx_defconfig
sparc                            alldefconfig
mips                 decstation_r4k_defconfig
arm                       omap2plus_defconfig
um                                  defconfig
mips                         db1xxx_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
openrisc                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                         apsh4a3a_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7780mp_defconfig
arm                        mvebu_v7_defconfig
sh                   sh7770_generic_defconfig
alpha                             allnoconfig
powerpc                     tqm8548_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                     taishan_defconfig
parisc                           allyesconfig
arm                          iop32x_defconfig
m68k                       bvme6000_defconfig
arm                        mini2440_defconfig
powerpc                        warp_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
xtensa                       common_defconfig
arm                           stm32_defconfig
powerpc                 linkstation_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108
i386                 randconfig-a001-20230109
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a005-20230109
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
x86_64                        randconfig-k001
mips                        qi_lb60_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

