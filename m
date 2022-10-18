Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912E8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XpfA7mLhMJPlV2QW8oNIG32F6COMJ5ccO//P7gJmNYM=; b=Cz2xLhNI57bJdDJSsrLyOliAaV
	Tdq4hEn3L+AIY7QDEccRvyViEGRIp5wKC9NbUcEqLZ3fDTXwNvwdnJTt+/PzD2iRGZzGCFtNQ4M+2
	pknWA+hdz3ZaOniOBKQjfz4SbEPMlGtUXNW4+5WAsZKWLZl46DfAwcwgWaT8F84pPrelJyiJEYVUC
	tmiT6BW9X/CMjne3zOFJMxtk4ADh/kSDC/ZD5nNQNZk0YvKf3qvT28s+1eCPJHovVrng7pZSbXuqi
	sqb+jKgOp6KhpXXt1Qz9mCR3kc5J9zV205maf1D0Dp6YEHMdewNI0PazfJf5IL+N85jNqBwGdNndm
	H37+NPpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oktUQ-00APSp-RA; Tue, 18 Oct 2022 20:47:06 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oktUL-00APOS-5I
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 20:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126021; x=1697662021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9AOxdo8S/Qmq9IqXGkkZOQh0Fg5Zcz8Dpi1RLr/jhMU=;
  b=IWR+9BLdO5rQ5HBN9KiKTRH1MPTPyOjhRdFMaftt95ffKw2YZ+YwCrFY
   K8wLnW1l6Z6W/+aJCSK90JYoe7PxrxAIw+ARBI2hawwG9Gg/OtALq4SQN
   9DLF5sZ+gjCAxmEKUx0uIdsF9X5fxACQhO7jPDfpYoFko3d8m2oFic9zY
   Y/puS/hG7oBk9VQec6gRc1CdqRksGgeqBn2etvUIIlvE21WhjIqilP7fI
   RHZ11IO0Z1P4V9XIhrJuuoIxgyNnXJgpcNNZqcGPbIt1joViqX3lo0zRz
   8lLKXGjFmJW4Ee6kzIADAb+ukYarreeqsnN0JciKdIvkWRWjF7yFM/SY2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370452901"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="370452901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="628910258"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="628910258"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2022 13:46:57 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oktUG-00020o-2i;
	Tue, 18 Oct 2022 20:46:56 +0000
Date: Wed, 19 Oct 2022 04:46:22 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 5097d0ef33371237f9a395f03ca5c80e6849d6e5
Message-ID: <634f109e.TJ7m/VL4zkaZqAVv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_134701_440115_028B30E0 
X-CRM114-Status: UNSURE (   7.68  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: 5097d0ef33371237f9a395f03ca5c80e6849d6e5  nvmet: fix workqueue MEM_RECLAIM flushing dependency

elapsed time: 2194m

configs tested: 270
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                        spear6xx_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221017
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                   secureedge5410_defconfig
arc                        nsimosci_defconfig
m68k                          multi_defconfig
csky                             alldefconfig
m68k                        m5407c3_defconfig
powerpc                  iss476-smp_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        mvme16x_defconfig
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
sh                        edosk7760_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 canyonlands_defconfig
arc                        nsim_700_defconfig
riscv                               defconfig
powerpc                 mpc837x_mds_defconfig
i386                 randconfig-c001-20221017
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
m68k                             alldefconfig
arm                         assabet_defconfig
mips                  maltasmvp_eva_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
loongarch                         allnoconfig
microblaze                          defconfig
arm                          gemini_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                    adder875_defconfig
sh                           se7751_defconfig
parisc                           alldefconfig
nios2                               defconfig
mips                        vocore2_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
loongarch                           defconfig
sh                             sh03_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
m68k                          hp300_defconfig
sh                          rsk7203_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
powerpc                        warp_defconfig
sh                          polaris_defconfig
arm                            lart_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
i386                 randconfig-a002-20221017
loongarch                        allmodconfig
x86_64               randconfig-a003-20221017
powerpc                         wii_defconfig
arm                        realview_defconfig
arc                        vdk_hs38_defconfig
powerpc                      chrp32_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           h3600_defconfig
x86_64               randconfig-c001-20221017
arm                  randconfig-c002-20221017
powerpc                     taishan_defconfig
m68k                       bvme6000_defconfig
mips                             allmodconfig
sparc                       sparc32_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
csky                              allnoconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                            hp6xx_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm                       imx_v6_v7_defconfig
m68k                          amiga_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
powerpc                          allyesconfig
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
xtensa                    xip_kc705_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
sh                         ap325rxa_defconfig
arm                          pxa3xx_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                                  defconfig
m68k                                defconfig
powerpc                      ppc40x_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         at91_dt_defconfig
microblaze                      mmu_defconfig
sh                           se7343_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           jazz_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         cm_x300_defconfig
openrisc                 simple_smp_defconfig
mips                            gpr_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
arm                        mvebu_v7_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018

clang tested configs:
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
x86_64               randconfig-k001-20221017
arm                          collie_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
arm                        mvebu_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
mips                          rm200_defconfig
powerpc                      ppc44x_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                         socfpga_defconfig
arm                       mainstone_defconfig
arm                          sp7021_defconfig
powerpc                    mvme5100_defconfig
x86_64                        randconfig-k001
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

