Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477CC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 04:12:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799CF61212
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 04:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 799CF61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FDIqBT/cM6LajQkmAGQJFikENm1Z/s7gaAoyX95TYjs=; b=x35kBAK9Nokada
	Yb0eAbr/nG3Kd5jcyJ6jDJngIcehfMubSpwvfhtNjY8KNWNVEXrNl+dX0auzFmxHttNsNJTB9cPex
	pRcLSzZ1cHcHb56TMq/u7MvWF8sZN1jZIY+ntWqbJqAWWhZTtC+n2+I8yIi6mkvXPdaef04sAHplV
	+YTRQkSOiVVYnu5mp/kxV3LhMcVaADLTuaAJqbvBrtFjQOG3GTnlsM1JnrTj31nbSgpDnjwPZbI1/
	YlRn7PIP/UVhLE0JBOyezLdYqhJTpHBQJmwD4PgpfofOnD65UG+2qucoA0drtRiDd+jJm8AF3/+Ja
	Qy1SHt8ElTyHWm7mhGBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPGqN-00FnpA-Qj; Sun, 12 Sep 2021 04:11:51 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPGqJ-00Fnok-P8
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 04:11:49 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="243712756"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; d="scan'208";a="243712756"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2021 21:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; d="scan'208";a="468336128"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2021 21:11:42 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mPGqD-0006FR-Fs; Sun, 12 Sep 2021 04:11:41 +0000
Date: Sun, 12 Sep 2021 12:11:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 7f18200bbe8bdfd9d975a82754049f3f41f12748
Message-ID: <613d7df1.kTQ9NYbPboKSllA5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210911_211147_911532_7A101E62 
X-CRM114-Status: UNSURE (   7.69  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.15
branch HEAD: 7f18200bbe8bdfd9d975a82754049f3f41f12748  nvme: avoid race in shutdown namespace removal

elapsed time: 3656m

configs tested: 307
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
i386                 randconfig-c001-20210910
i386                 randconfig-c001-20210911
powerpc                 xes_mpc85xx_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
sh                          kfr2r09_defconfig
sh                        apsh4ad0a_defconfig
xtensa                    xip_kc705_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
um                           x86_64_defconfig
mips                        omega2p_defconfig
powerpc                     asp8347_defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_itx_defconfig
sh                        sh7763rdp_defconfig
xtensa                    smp_lx200_defconfig
arm                          collie_defconfig
sh                                  defconfig
ia64                         bigsur_defconfig
powerpc                     kmeter1_defconfig
powerpc                   bluestone_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                             allyesconfig
openrisc                  or1klitex_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sequoia_defconfig
arm                      integrator_defconfig
nios2                         3c120_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pxa168_defconfig
microblaze                          defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
sparc                       sparc32_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         mv78xx0_defconfig
arc                          axs103_defconfig
nds32                               defconfig
powerpc                     akebono_defconfig
sh                         ap325rxa_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
ia64                            zx1_defconfig
openrisc                 simple_smp_defconfig
arm                         lpc18xx_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
sh                            shmin_defconfig
mips                      maltaaprp_defconfig
arm                         s3c6400_defconfig
powerpc                    gamecube_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
xtensa                           alldefconfig
sh                           se7206_defconfig
arm                        oxnas_v6_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
arm                        mini2440_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
mips                          ath79_defconfig
mips                           ip28_defconfig
powerpc                      bamboo_defconfig
mips                           ci20_defconfig
sh                          rsk7264_defconfig
arc                    vdk_hs38_smp_defconfig
arm                           stm32_defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
s390                       zfcpdump_defconfig
mips                         db1xxx_defconfig
xtensa                  cadence_csp_defconfig
arm                        multi_v7_defconfig
arc                          axs101_defconfig
parisc                generic-32bit_defconfig
arm                       versatile_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
arm                         lubbock_defconfig
sh                   sh7770_generic_defconfig
arm                          pxa910_defconfig
sh                          urquell_defconfig
mips                          malta_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
ia64                        generic_defconfig
arm                         vf610m4_defconfig
mips                           ip32_defconfig
powerpc                    sam440ep_defconfig
mips                        workpad_defconfig
arm                         nhk8815_defconfig
mips                         tb0287_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
powerpc                     ksi8560_defconfig
sh                           se7712_defconfig
parisc                              defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
arm                  colibri_pxa300_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
powerpc                     redwood_defconfig
x86_64                           alldefconfig
mips                         tb0219_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  iss476-smp_defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
powerpc                     taishan_defconfig
mips                           ip22_defconfig
sh                           se7721_defconfig
arm                      tct_hammer_defconfig
arm                          ixp4xx_defconfig
ia64                             allyesconfig
powerpc                      pmac32_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5208evb_defconfig
powerpc                 canyonlands_defconfig
alpha                            alldefconfig
m68k                        m5407c3_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7724_defconfig
csky                             alldefconfig
sh                        edosk7760_defconfig
arm                           h5000_defconfig
openrisc                    or1ksim_defconfig
mips                        qi_lb60_defconfig
m68k                       bvme6000_defconfig
powerpc                     ppa8548_defconfig
x86_64               randconfig-c001-20210908
x86_64               randconfig-c001-20210912
i386                 randconfig-c001-20210912
arm                  randconfig-c002-20210912
x86_64               randconfig-c001-20210910
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a004-20210911
i386                 randconfig-a005-20210911
i386                 randconfig-a002-20210911
i386                 randconfig-a006-20210911
i386                 randconfig-a001-20210911
i386                 randconfig-a003-20210911
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
x86_64               randconfig-a002-20210911
x86_64               randconfig-a003-20210911
x86_64               randconfig-a004-20210911
x86_64               randconfig-a006-20210911
x86_64               randconfig-a005-20210911
x86_64               randconfig-a001-20210911
x86_64               randconfig-a013-20210910
x86_64               randconfig-a016-20210910
x86_64               randconfig-a012-20210910
x86_64               randconfig-a011-20210910
x86_64               randconfig-a014-20210910
x86_64               randconfig-a015-20210910
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
arc                  randconfig-r043-20210908
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20210910
mips                 randconfig-c004-20210910
powerpc              randconfig-c003-20210910
i386                 randconfig-c001-20210910
s390                 randconfig-c005-20210910
riscv                randconfig-c006-20210911
x86_64               randconfig-c007-20210911
mips                 randconfig-c004-20210911
powerpc              randconfig-c003-20210911
i386                 randconfig-c001-20210911
s390                 randconfig-c005-20210911
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a001-20210910
i386                 randconfig-a004-20210910
i386                 randconfig-a005-20210910
i386                 randconfig-a002-20210910
i386                 randconfig-a006-20210910
i386                 randconfig-a001-20210910
i386                 randconfig-a003-20210910
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
x86_64               randconfig-a013-20210911
x86_64               randconfig-a016-20210911
x86_64               randconfig-a012-20210911
x86_64               randconfig-a011-20210911
x86_64               randconfig-a014-20210911
x86_64               randconfig-a015-20210911
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
i386                 randconfig-a016-20210911
i386                 randconfig-a011-20210911
i386                 randconfig-a015-20210911
i386                 randconfig-a012-20210911
i386                 randconfig-a013-20210911
i386                 randconfig-a014-20210911
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
s390                 randconfig-r044-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
