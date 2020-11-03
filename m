Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72792C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 21:37:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1906F2074B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IfLCSI+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1906F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hxBSJPH8iE/byHPufOGvTtoMDBDOt+2NNlgpdoDGSc4=; b=IfLCSI+lb2il8Uc2qvL82QxvXQ
	pwL6RhXVOVLbXk33y2So52nt4BV+HoDU0bXZkMtsPNTGzeqG5OjrP9vtFjU/TZmf18YUFbiJOKp83
	PV4oRQDMsXCre5I9yu3ZOzMLgVQTXbJyCZiHOuEwVk0y1EhxuUrGhXNIGy5TBklznP/4itKj9/xd7
	y0giHfVi9FFG8PpmsHfsvCWa23VzKV31WvEPsfczTzK6BLoOGXt2P789ktwJd25HlB5SWiLGKYkct
	r8suNsrknYvjGbCToHY1pmiOMZcX8LmvW7QX2wrNUDrL1hyUgifE/9AyiQW+Z0SJIf+vrrkQOx2VG
	TVZvEBFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ka3zi-0007ER-K4; Tue, 03 Nov 2020 21:37:34 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ka3zf-0007DZ-7B
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 21:37:32 +0000
IronPort-SDR: EqdsfygJ2YUz4/tXB6q2foHyRHwIzXtzhriXju/M2SvGSeGLBGjnpxWvUGGxtCI4uuErEj6JyR
 LMglqsOCfbbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="230755604"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; d="scan'208";a="230755604"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 13:37:28 -0800
IronPort-SDR: lme3tYw3LRXmGhqfMb1JMtVXMO/3AkUY/mc5mnjinZIok9mpnfmd51TW5k8/MmgubDoG6CTot+
 uByU9/o9x/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; d="scan'208";a="325370918"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 13:37:26 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ka3za-0000X3-2e; Tue, 03 Nov 2020 21:37:26 +0000
Date: Wed, 04 Nov 2020 05:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 0a8a2c85b83589a5c10bc5564b796836bf4b4984
Message-ID: <5fa1cd7a.xVLylYQGRadA8YkD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_163731_434143_EA192608 
X-CRM114-Status: GOOD (  11.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: 0a8a2c85b83589a5c10bc5564b796836bf4b4984  nvme-tcp: avoid repeated request completion

elapsed time: 724m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
arm                        spear3xx_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       rbtx49xx_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
arc                     nsimosci_hs_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
arm                            zeus_defconfig
powerpc                     tqm5200_defconfig
ia64                          tiger_defconfig
sh                         ecovec24_defconfig
powerpc                    sam440ep_defconfig
powerpc                   bluestone_defconfig
arc                        vdk_hs38_defconfig
arm                            qcom_defconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
arm                           spitz_defconfig
powerpc                   currituck_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
mips                          rm200_defconfig
powerpc                    mvme5100_defconfig
mips                             allmodconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7264_defconfig
powerpc                     asp8347_defconfig
powerpc                        fsp2_defconfig
arm                          ep93xx_defconfig
powerpc                  iss476-smp_defconfig
arm                     davinci_all_defconfig
arm                       omap2plus_defconfig
sh                             sh03_defconfig
arm                      pxa255-idp_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
m68k                          sun3x_defconfig
mips                           gcw0_defconfig
xtensa                    smp_lx200_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
nios2                            alldefconfig
arm                            mmp2_defconfig
arm                        cerfcube_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
mips                      malta_kvm_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
arm                       aspeed_g5_defconfig
powerpc                     pseries_defconfig
arm                           viper_defconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
sh                   sh7770_generic_defconfig
mips                           ip32_defconfig
arm                             mxs_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
mips                     cu1000-neo_defconfig
sh                         apsh4a3a_defconfig
powerpc                      acadia_defconfig
powerpc                     ppa8548_defconfig
powerpc                         ps3_defconfig
powerpc                     rainier_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
h8300                     edosk2674_defconfig
arm                       mainstone_defconfig
xtensa                  audio_kc705_defconfig
arm                         lpc18xx_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
