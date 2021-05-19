Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D9C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 19:32:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1896F61184
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 19:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1896F61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kP8PrV5STeoxLB1ib+PnNOHUGV0TzKq3ZWdGQ5wHSAM=; b=CH6qzsJI8sJExJit63ZUJtNLbp
	Y2O1KQ5iWTKj0r18L2fxXR6uvpF47+uZ0hFIBc9MergEdtyaZrDtKyOnUrjAbJKa+lAQysqimIbIt
	i1EDOW5ER5XtcJFlav60DGUeA8/0oQUbPx+trkOvPktIGqTev4QxoQUMCqGVPohwR/RPyNTrGYD+9
	NrtyTtrHdojjtZxEXAv+4osP/NizwmIX0RGJ/NoCqyLfoPOsQ+v/FeRdRSrcY/JdFD9BzkNIOAGcH
	qSkZAbC8dFylQUW3zR8x8x4Le3h9Qr89SDn2xhHuX8Te6XlrtkTDkZLhHDhqkf9p4Vcm2Y2I3EBDR
	1ClCzelg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljRuj-004ttm-H0; Wed, 19 May 2021 19:31:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljRp3-004sdk-FH
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 19:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=M2+sVS5CJ/A8DjEnVd0GKsbuNFrCXxIM2TmGW3kPvkU=; b=0nsbzzLVB0FQRnYnVa+ZXa2GCM
 thNSwZ6IqjO/UmvvGa/2864VamyJ3lZYKryzR0YZMTV7A0xzIMJn3KOxiUhkd7Yspa28wJzF+Qtpm
 7SpzhSfDj7+lRhf+L07MiokS68KqUSRq+jMkzEQxEXM9NcYIkuudSF9p3TzLMk2SadLgJhpITzWyl
 IW2XAIaxZmzDWUxPVTW24HHHKaN2WvCx4JzOaGGGBjHW9i8dOFjAcXHLBtl6jMFOyPy4h/ZhWNJwm
 +HhBC3ET7FOFNgOti0lLrJF5cuKnNs3BbOPGmPm7HnUlh5inwbuJA4qjAuyP1SbinJNy90unxbW/1
 OgxNHMtQ==;
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljRp0-00Fjb3-E7
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 19:25:36 +0000
IronPort-SDR: +l1Ai3pF4l/q6YMu8U/c4ybVl91hJFeQz9Ia99L1x7E1egPugYm3BgqGkAcV8ZydidhyqggZma
 g4rnybXyyO2g==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286587975"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286587975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 12:25:33 -0700
IronPort-SDR: ziQzI4SezrED2eNom9I9aV49khGG5tCGxwn00AQcH0eQyYhJel0rbQ7gdnK/D/33rxUFxZSh3Y
 EajCcj1dOFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="461411102"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 19 May 2021 12:25:29 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ljRou-0000ED-Tq; Wed, 19 May 2021 19:25:28 +0000
Date: Thu, 20 May 2021 03:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 a7d139145a6640172516b193abf6d2398620aa14
Message-ID: <60a56612.7e6Ro4nffZMtR6gP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_122534_526566_BC528A22 
X-CRM114-Status: UNSURE (   7.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.13
branch HEAD: a7d139145a6640172516b193abf6d2398620aa14  nvme-fc: clear q_live at beginning of association teardown

elapsed time: 720m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
powerpc                      ppc40x_defconfig
mips                            e55_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa3xx_defconfig
arm                         axm55xx_defconfig
powerpc                      arches_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arc                              alldefconfig
sh                      rts7751r2d1_defconfig
sh                         apsh4a3a_defconfig
s390                             allmodconfig
arm                          exynos_defconfig
sh                           se7724_defconfig
mips                    maltaup_xpa_defconfig
i386                                defconfig
arm                        magician_defconfig
sparc                       sparc32_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       bvme6000_defconfig
m68k                       m5275evb_defconfig
h8300                            alldefconfig
mips                           ip27_defconfig
sh                          rsk7264_defconfig
ia64                                defconfig
arm                          pcm027_defconfig
m68k                          sun3x_defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
powerpc                 canyonlands_defconfig
sh                               allmodconfig
h8300                    h8300h-sim_defconfig
ia64                            zx1_defconfig
powerpc                      pcm030_defconfig
mips                     cu1000-neo_defconfig
mips                            gpr_defconfig
arm                         s3c2410_defconfig
arm                        spear3xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     taishan_defconfig
mips                        nlm_xlr_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
arm                   milbeaut_m10v_defconfig
arm                         vf610m4_defconfig
arm                        clps711x_defconfig
sh                          sdk7786_defconfig
sh                          r7785rp_defconfig
powerpc                     asp8347_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7705_defconfig
s390                             alldefconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
powerpc                           allnoconfig
arm                    vt8500_v6_v7_defconfig
arm                       omap2plus_defconfig
arm                             ezx_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
mips                           xway_defconfig
xtensa                  cadence_csp_defconfig
arm                       mainstone_defconfig
m68k                        m5307c3_defconfig
s390                             allyesconfig
arm                       netwinder_defconfig
powerpc                       ppc64_defconfig
mips                   sb1250_swarm_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
powerpc                       holly_defconfig
arm                           tegra_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   currituck_defconfig
s390                       zfcpdump_defconfig
arm                     davinci_all_defconfig
m68k                         amcore_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
m68k                             allyesconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
x86_64                           allyesconfig
sh                ecovec24-romimage_defconfig
arm                       cns3420vb_defconfig
powerpc                      ppc6xx_defconfig
arc                           tb10x_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     powernv_defconfig
sh                        apsh4ad0a_defconfig
arm                           viper_defconfig
csky                                defconfig
mips                           ci20_defconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
arm                        mvebu_v7_defconfig
sh                            shmin_defconfig
powerpc                          allyesconfig
powerpc                 mpc837x_mds_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
arm                          simpad_defconfig
arm                         lpc18xx_defconfig
sh                           se7712_defconfig
sh                        dreamcast_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ep88xc_defconfig
arm                             mxs_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arc                              allyesconfig
mips                            ar7_defconfig
mips                  decstation_64_defconfig
m68k                        stmark2_defconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
