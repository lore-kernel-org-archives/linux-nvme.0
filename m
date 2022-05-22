Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD79C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 22 May 2022 05:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nzOJiaotvr1BNe/XlbrbRAOhWEtsOB7Efke3BvVE5mo=; b=WVB0vzuy0hFyWvYyOo0wHUiXKN
	AHDpKk8EtBuduybx+sne68cSKUtEf56vdRB8bNXcT3wZsyQ15wa2ta8vH8j2ugobhWOpIlRAa5Zox
	tBa9zmppJrj8ADHESBm3xcz54D5Z+HwRTgBbE5HkN6kql/jIkTApTaUUu/rkxlE39OQuPopHrw/DM
	8brVFui5jrr2kRrQtoUYm+ZaJQ/Hwz3Q+43ufNZ9mxpqTSPBevuWKIL+KkgimG8UYSHy+Q75yG7oY
	FdiJo/IVTJBT2D8ioxivIlwUghjZnIlGLhRZDIshgDu/S9kBSf8kYcf/VuOXrmNKPezWvh9m2+VDc
	kzpDbbHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsdpA-000abl-Lx; Sun, 22 May 2022 05:08:16 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsdp7-000abE-PG
 for linux-nvme@lists.infradead.org; Sun, 22 May 2022 05:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653196093; x=1684732093;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=gjYC8CkHf1L7icCIVatc2cbBGnOZoUInc26F9ma/BzU=;
 b=i1UNCGu6S1ypozO7p+SfSmtbJYjLWvzwwDLJemmFri/h39dnxnefHgRq
 znUkCP2mkGdF0l3piOzUpP42KEBXk5zH1pyhW/LUuRdfZKFVHUXf7jrsA
 7mbPkurw5gF7teEXsegi7bzKMEbdg8Af+ffOnQPZ9SK+hS1GrrGXmBVqS
 xiqm3mfzZb4djZJM1OE2UZMbSLphK2Qqb5pHaNTKmMMVkYCN0bt7oFYmd
 b2irJJxr3/Szh01kgban0n+3h3kf6WtS3NK38gdPkuMcyvEpAboCLE2w1
 3y0F3Twi8RbdSZkZaNfmmbCr+0Vf28+fh7IZXyx4nYPAySVGAVAodFeQe A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="335999140"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; d="scan'208";a="335999140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2022 22:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; d="scan'208";a="558112458"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 21 May 2022 22:08:06 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nsdp0-000011-7E;
 Sun, 22 May 2022 05:08:06 +0000
Date: Sun, 22 May 2022 13:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 78288665b5d0154978fed431985310cb4f166836
Message-ID: <6289c521.I/inG1tuAdMc7YE/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_220813_927379_D071A792 
X-CRM114-Status: UNSURE (   7.20  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 78288665b5d0154978fed431985310cb4f166836  nvme: set non-mdts limits in nvme_scan_work

elapsed time: 3428m

configs tested: 260
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
arm                       imx_v6_v7_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
mips                     loongson1b_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
sh                            titan_defconfig
sh                            migor_defconfig
arm                      footbridge_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
sh                         microdev_defconfig
sh                               j2_defconfig
um                                  defconfig
um                               alldefconfig
arm                        shmobile_defconfig
mips                      maltasmvp_defconfig
powerpc                    sam440ep_defconfig
powerpc                      cm5200_defconfig
s390                       zfcpdump_defconfig
arm                         axm55xx_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
sh                          rsk7269_defconfig
powerpc                     pq2fads_defconfig
parisc                           allyesconfig
mips                           ci20_defconfig
s390                             allyesconfig
xtensa                          iss_defconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
mips                  maltasmvp_eva_defconfig
riscv                            allyesconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
ia64                          tiger_defconfig
sh                           se7750_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
h8300                            allyesconfig
arm                          badge4_defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
arm                      jornada720_defconfig
powerpc                     sequoia_defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
sh                           se7206_defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
powerpc                      ppc40x_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
arm                        realview_defconfig
arm                            qcom_defconfig
sh                           se7343_defconfig
nios2                            alldefconfig
arc                        nsimosci_defconfig
powerpc                     stx_gp3_defconfig
sparc64                          alldefconfig
i386                                defconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          urquell_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
mips                             allyesconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
powerpc                       eiger_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
arc                          axs103_defconfig
sh                          sdk7786_defconfig
mips                 decstation_r4k_defconfig
um                             i386_defconfig
arm                           sama5_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
m68k                             allyesconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                     edosk2674_defconfig
arc                           tb10x_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
m68k                        mvme147_defconfig
arm                        keystone_defconfig
openrisc                 simple_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
arc                          axs101_defconfig
powerpc                     rainier_defconfig
powerpc                      mgcoge_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
sh                   secureedge5410_defconfig
m68k                           sun3_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                         3c120_defconfig
sh                        sh7757lcr_defconfig
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
arm                  randconfig-c002-20220522
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
arc                  randconfig-r043-20220519
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
arm                  randconfig-c002-20220522
s390                 randconfig-c005-20220522
powerpc              randconfig-c003-20220522
riscv                randconfig-c006-20220522
mips                 randconfig-c004-20220522
powerpc                          g5_defconfig
hexagon                             defconfig
mips                      pic32mzda_defconfig
arm                          ep93xx_defconfig
mips                     loongson2k_defconfig
powerpc                     tqm8560_defconfig
hexagon                          alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                              alldefconfig
arm                          ixp4xx_defconfig
powerpc                      pmac32_defconfig
powerpc                     tqm5200_defconfig
i386                             allyesconfig
powerpc                    socrates_defconfig
powerpc                   microwatt_defconfig
powerpc                      acadia_defconfig
riscv                          rv32_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
arm                         mv78xx0_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       spear13xx_defconfig
mips                           rs90_defconfig
powerpc                          allmodconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     tqm8540_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                  colibri_pxa300_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220522
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519
hexagon              randconfig-r045-20220521
hexagon              randconfig-r041-20220521
s390                 randconfig-r044-20220521
riscv                randconfig-r042-20220521

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

