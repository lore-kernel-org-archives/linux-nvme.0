Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC7C388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 23:01:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247792083B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 23:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="brB7xPeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247792083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sJJxc/+6msqxIk1Bv6M2yg5rwrFpZs/Fsn9D1eF90aQ=; b=brB7xPeRbXF2/AubKpPBHfrct2
	4oqcvLpcM7EDTn/uZwPPwcMzB+7PGWPPE/RqBNr1XpCaVbEQzuqALUcMFKASyUv/xtsxFCS+EoN/G
	6rARMIZ742Uqhy922JqR0JDHMFhSRnaG3USojDv4l1+bKtxjgh9H1iGcXU4Emd9TMhJrpVJ4tc1st
	JLW4eeDRHQhB0gV/9CfdamT6dT+yLH4B29hPFOHtf769oPWLW71fDprRde3f206LPiAeHZC92wGg+
	o/DMHywpXfuoWtGour1xrn2AwdfgaDnZNa5c7LodleTPFPkeNS/6+ZfHSKSkr2GiEPztkKFbQGerb
	ARQ1PGHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW63P-0002Id-VG; Fri, 23 Oct 2020 23:01:00 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW63L-0002ID-Pa
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 23:00:56 +0000
IronPort-SDR: mumpuqfTlRfnaYAQASp45paW+ZsGHaD84uyEY/OeUUauP/1TTGI4ezAo8rylJQv84ir3GsMApk
 VuW2GALswTLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="147031397"
X-IronPort-AV: E=Sophos;i="5.77,410,1596524400"; d="scan'208";a="147031397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 16:00:52 -0700
IronPort-SDR: h5+uJzNGTgDIBXHva8daH5NWdjjV3WDxxnnBPX3gqIUkWU35Y9HNnHYHDlaDl4jPbyB+aHVc3b
 UZvynVZnIZ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,410,1596524400"; d="scan'208";a="467236571"
Received: from lkp-server01.sh.intel.com (HELO cda15bb6d7bd) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 23 Oct 2020 16:00:50 -0700
Received: from kbuild by cda15bb6d7bd with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kW63G-0000El-08; Fri, 23 Oct 2020 23:00:50 +0000
Date: Sat, 24 Oct 2020 07:00:47 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 f673714a1247669bc90322dfb14a5cf553833796
Message-ID: <5f93609f.sAqs90OmcCMrXE3S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_190056_032268_230A4616 
X-CRM114-Status: GOOD (  10.84  )
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
branch HEAD: f673714a1247669bc90322dfb14a5cf553833796  nvme-fc: shorten reconnect delay if possible for FC

elapsed time: 725m

configs tested: 185
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arc                        vdk_hs38_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
sh                      rts7751r2d1_defconfig
nios2                            allyesconfig
powerpc                     ep8248e_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          tango4_defconfig
powerpc                  mpc885_ads_defconfig
arm                         s3c6400_defconfig
mips                     loongson1c_defconfig
mips                        jmr3927_defconfig
powerpc                     ppa8548_defconfig
sh                               allmodconfig
powerpc                          g5_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
arm                         orion5x_defconfig
arm                        spear6xx_defconfig
riscv                            alldefconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
powerpc                     ksi8560_defconfig
mips                     cu1830-neo_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc8272_ads_defconfig
arm                      tct_hammer_defconfig
c6x                              allyesconfig
powerpc                 canyonlands_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
arm                     am200epdkit_defconfig
microblaze                          defconfig
m68k                        m5307c3_defconfig
s390                             allyesconfig
powerpc                   currituck_defconfig
arm                          pxa910_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
arm                       aspeed_g5_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
arm                            zeus_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
arm                      jornada720_defconfig
sh                          lboxre2_defconfig
sh                           se7705_defconfig
sh                          polaris_defconfig
arm                           stm32_defconfig
powerpc                         wii_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
powerpc                    sam440ep_defconfig
xtensa                         virt_defconfig
m68k                          atari_defconfig
powerpc                      bamboo_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
ia64                             allyesconfig
arm                          lpd270_defconfig
powerpc                   motionpro_defconfig
nios2                         10m50_defconfig
mips                          ath79_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     akebono_defconfig
sh                           se7343_defconfig
arm                            dove_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  iss476-smp_defconfig
m68k                             alldefconfig
mips                      fuloong2e_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                               defconfig
sh                        edosk7705_defconfig
powerpc                      ppc6xx_defconfig
arm                       versatile_defconfig
h8300                               defconfig
m68k                        stmark2_defconfig
powerpc                        icon_defconfig
nios2                               defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201023
x86_64               randconfig-a003-20201023
x86_64               randconfig-a006-20201023
x86_64               randconfig-a004-20201023
x86_64               randconfig-a005-20201023
i386                 randconfig-a002-20201022
i386                 randconfig-a005-20201022
i386                 randconfig-a003-20201022
i386                 randconfig-a001-20201022
i386                 randconfig-a006-20201022
i386                 randconfig-a004-20201022
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
x86_64               randconfig-a002-20201023
x86_64               randconfig-a011-20201022
x86_64               randconfig-a013-20201022
x86_64               randconfig-a016-20201022
x86_64               randconfig-a015-20201022
x86_64               randconfig-a012-20201022
x86_64               randconfig-a014-20201022
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
i386                 randconfig-a016-20201023
i386                 randconfig-a014-20201023
i386                 randconfig-a015-20201023
i386                 randconfig-a012-20201023
i386                 randconfig-a013-20201023
i386                 randconfig-a011-20201023
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022
x86_64               randconfig-a011-20201023
x86_64               randconfig-a013-20201023
x86_64               randconfig-a016-20201023
x86_64               randconfig-a015-20201023
x86_64               randconfig-a012-20201023
x86_64               randconfig-a014-20201023

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
