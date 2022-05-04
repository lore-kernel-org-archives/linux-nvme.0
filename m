Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04041C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ugmR3jLM8veLVIUa3OI/j0BaZYhzol4hxt5zceJiBtA=; b=Mngc4DnW9UnD4V26IMMwbzeiIO
	hhLUvStyBOqazHEPnXqeYXt4ndaa4Gp4GrbCM9WgLmYjNhQFlRNv6ejRjWIL32QviIn2m+L0ADSmZ
	H2XyBIt/lQ+ZXXE8k32AE7tAm704zEVwSeavzvKQw989IttDFHmz3j4mpt5JcbItWwptVaaOVq6wt
	GXPtBkM5iuisgztLbm7GulvAxozjsJo0t3rfusKw/g/P4mIkI+AAWT6Oz3HNjW7EWrWYvhGm7bvU1
	ealMEKatKilKiE/zOwIOqnwav4Eo8+veR49t5NPhG4BV7Wr78o0SZQ2jGcvch6JJHB+b8tgvTpbNI
	fQQRCXUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nm2aI-0088Gt-Td; Wed, 04 May 2022 00:09:38 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nm2aG-0088Fy-3Z
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 00:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651622976; x=1683158976;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=tIw3wxR3TTtP/toaQyavTjacsD6h8Kqv0lWT1ic8sCs=;
 b=mYWqUVEcS98czl06+bjLe6P1iFVh/4vbNH5wK5SzkpfqxsWSFlZIeSNX
 fFmimvINRKAAJju5+aYNOGSo58ZfFWbjuZ3pP7y6VG07rNDHS/qAsB2Kf
 zVKD07Pw87kiiRcC/Yc3H6ZNSq0KYUBJFHZvFzkJW5PPbAZC4KEn4pY2q
 GKZMn745WpigHGODR6VGpHp4yPc+Iad74wxQT2H6wtwL+pViD7N4vAqUk
 BiarmLZcyOR/jXZt2aFTlbEOJnZ8N0t6MdNZ0hjTFh/Gcp7uWdS9pOIHL
 3DYI/oOc3g13/vB1NDnqbpSX83IG7TFZN24QdywdYYiMcyuNmEKg01rXf A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266468039"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; d="scan'208";a="266468039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2022 17:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; d="scan'208";a="547993784"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 03 May 2022 17:09:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nm2aA-000Atn-9w;
 Wed, 04 May 2022 00:09:30 +0000
Date: Wed, 04 May 2022 08:09:03 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 20ebcca0ac7c821749f30be3b29686b99f463edd
Message-ID: <6271c41f.NKmrDm6W7ybHioiD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_170936_224269_2A8A9ECD 
X-CRM114-Status: UNSURE (   8.39  )
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
branch HEAD: 20ebcca0ac7c821749f30be3b29686b99f463edd  nvme: fix a NULL pointer dereference in nvme_alloc_admin_tags

elapsed time: 7685m

configs tested: 317
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          lboxre2_defconfig
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
m68k                         amcore_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
xtensa                           allyesconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           ci20_defconfig
sh                        sh7763rdp_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
parisc                              defconfig
sh                         microdev_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                          rb532_defconfig
mips                        vocore2_defconfig
powerpc                      ppc6xx_defconfig
arm                      jornada720_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
parisc                generic-32bit_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
powerpc                    klondike_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
ia64                      gensparse_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
m68k                          sun3x_defconfig
arm                         nhk8815_defconfig
powerpc                    amigaone_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                        apsh4ad0a_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                           sun3_defconfig
powerpc                     pq2fads_defconfig
sh                        sh7785lcr_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
m68k                       m5208evb_defconfig
xtensa                  cadence_csp_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
arm                       omap2plus_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
powerpc                      mgcoge_defconfig
m68k                       bvme6000_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                       m5475evb_defconfig
xtensa                         virt_defconfig
arm                            qcom_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7724_generic_defconfig
powerpc                        cell_defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arc                         haps_hs_defconfig
arm                        cerfcube_defconfig
arm                      integrator_defconfig
um                               alldefconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
sh                           se7751_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
mips                         rt305x_defconfig
ia64                             alldefconfig
mips                       capcella_defconfig
mips                      maltasmvp_defconfig
sh                             espt_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
arm                       aspeed_g5_defconfig
arm                         cm_x300_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                   currituck_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
sh                          landisk_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
sparc                       sparc64_defconfig
powerpc                     asp8347_defconfig
mips                       bmips_be_defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
m68k                             allmodconfig
openrisc                    or1ksim_defconfig
sh                           se7705_defconfig
powerpc                    sam440ep_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220429
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220429
s390                 randconfig-r044-20220429
riscv                randconfig-r042-20220429
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                        workpad_defconfig
arm                          collie_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
powerpc                  mpc885_ads_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
arm                            dove_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                 linkstation_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220428
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
s390                 randconfig-r044-20220428
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

