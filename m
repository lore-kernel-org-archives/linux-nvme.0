Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E19AC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Apr 2022 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NlOC9QCi27AREF2MvOYbStO27lkupkguRRXw3Yu77RE=; b=hpB0MktO04fK4G++jbb6/rFUcd
	nHBJJvtnG+MoRD1Oj56XD3H3HViX8SM2zTfN/p3R96OABza5J/A4lSiEJ/qg0tUKn/z/8kwBZ6hWS
	dBTay0HEulBNoYwI4irQ7dby82pF/y3gtqap6+T1fqSmkTIMOYY0fZ3P26qInm8FvSCM8eaYF/Fc6
	TUMhTckESEOOk2jshmi1XUXe36OEVVYsQI4F2dP5j9Z13kDFR6p9ls8EwZ8cJCqqxwMdoWkAwORd7
	b0zKHCI3r4TpDLDj57yIHVkJI6nP/66dZcYdCZSX5+wN5pJU4sCyWJag5BJ53mRlaIKznnjm2eEwp
	aLS7AJrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nflhc-00DGMy-R7; Sat, 16 Apr 2022 16:55:16 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nflhZ-00DGLz-Mt
 for linux-nvme@lists.infradead.org; Sat, 16 Apr 2022 16:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650128113; x=1681664113;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=GEWP3kFotCvfQRODBhpY0qZmWZgnoP45yKrTkvzLrUU=;
 b=a4OnuZoSPED3u5iUqISOIigDk2rqQ0c+muR0bX47BVhGqmbcMmThKu/d
 YGB0AxCCkhnhm4toWHBSO/PxWKD13239nejCeEvfSezrU+zj2Y787x3z4
 FVYnIjN4aATvIHq8UySMJ5BRUSCVGj6drX0ag0PfgoS1bjWYYjVOC3cPZ
 Ys6wAwHHqfgzfqh49YMccTo6pAsqtVHsG1Qd7KcBw4x2P4TwejX29rRU8
 a64OfzhM33hEqoiWeHIw28Od+3bylMFl6Hg7em03lFBHcfLzzGstYW5lm
 VumzeU1UIoEKhgJzq5wrww309+Dw5zVS2sdAeRkFTn9685JZQKXD5PQfG w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243888559"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="243888559"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 09:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="646389472"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2022 09:55:12 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nflhX-0003KT-BH;
 Sat, 16 Apr 2022 16:55:11 +0000
Date: Sun, 17 Apr 2022 00:54:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 66dd346b84d79fde20832ed691a54f4881eac20d
Message-ID: <625af4cb.10hdKCJBx7lI/Gr2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220416_095513_820933_435C3755 
X-CRM114-Status: UNSURE (   6.27  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 66dd346b84d79fde20832ed691a54f4881eac20d  nvme-pci: disable namespace identifiers for Qemu controllers

elapsed time: 1761m

configs tested: 163
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220415
powerpc              randconfig-c003-20220414
powerpc                     tqm8548_defconfig
sh                            shmin_defconfig
s390                          debug_defconfig
powerpc                      ep88xc_defconfig
um                           x86_64_defconfig
h8300                       h8s-sim_defconfig
um                             i386_defconfig
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
arm                       imx_v6_v7_defconfig
sh                               j2_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
arc                     haps_hs_smp_defconfig
ia64                                defconfig
arm                        trizeps4_defconfig
mips                         db1xxx_defconfig
mips                      fuloong2e_defconfig
arm                             pxa_defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
powerpc                       eiger_defconfig
powerpc                 linkstation_defconfig
powerpc                    amigaone_defconfig
m68k                             allyesconfig
sh                        dreamcast_defconfig
m68k                          sun3x_defconfig
powerpc                        cell_defconfig
xtensa                    smp_lx200_defconfig
powerpc                 mpc834x_itx_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc83xx_defconfig
sh                        sh7757lcr_defconfig
mips                      maltasmvp_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
openrisc                            defconfig
sh                           se7724_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
arm                           imxrt_defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
powerpc64                        alldefconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
i386                             alldefconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
powerpc                   motionpro_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
xtensa                  cadence_csp_defconfig
xtensa                  nommu_kc705_defconfig
sh                         microdev_defconfig
um                                  defconfig
x86_64                              defconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
arm                  randconfig-c002-20220416
arm                  randconfig-c002-20220415
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220415
s390                 randconfig-r044-20220415
riscv                randconfig-r042-20220415
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
arm                  colibri_pxa270_defconfig
powerpc                   microwatt_defconfig
powerpc                    mvme5100_defconfig
arm                       mainstone_defconfig
arm                         lpc32xx_defconfig
mips                         tb0287_defconfig
i386                             allyesconfig
powerpc                     kmeter1_defconfig
powerpc                     akebono_defconfig
arm                        neponset_defconfig
powerpc                        icon_defconfig
riscv                          rv32_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc836x_rdk_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220415
hexagon              randconfig-r041-20220415
riscv                randconfig-r042-20220416
riscv                randconfig-r042-20220414
hexagon              randconfig-r041-20220414
hexagon              randconfig-r041-20220416
hexagon              randconfig-r045-20220414
hexagon              randconfig-r045-20220416

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

