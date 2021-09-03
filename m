Return-Path: <SRS0=9hiF=NZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70615C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Sep 2021 02:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5DA60E93
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Sep 2021 02:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F5DA60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7T5Dne0D1/i0/qdP9Say9c8giSHf6rLjXOKyD9ZPsVE=; b=JAxGEKwpy5+/Ud
	h8zW4JsyYrzBE+D42NdYRmxpVfpLCFH4k3Uh6s9H2mroIUD+lickT03kak1V6tyHIOX7x9sPaCpRC
	XEVaP6OefirCwo9w/y5ZM9njiMlAFtzPSLXpa55fsMSgQ0cSgNoe0nyyQ+E1V0D+FoGAIBj+rA1VC
	vG5ZgqDiqPW5PZxbjPrT83JbxGDe85OdBHsu+ENd6bAAUp5w5Kh8cXBljGTdJJVwu+eOED2EJR6JU
	pJ2sfnYvfhDfwyz1EDuuVFw0FccN8gSJetXehVc05TS3jypTKLWReVCqoM+kiuvCe0KAZEStbtxOg
	RVEtyeQ+S5entxLSt4RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLylm-00Ar4y-2Y; Fri, 03 Sep 2021 02:17:30 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLylf-00Ar4S-Sv
 for linux-nvme@lists.infradead.org; Fri, 03 Sep 2021 02:17:28 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="283008173"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; d="scan'208";a="283008173"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 19:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; d="scan'208";a="521472114"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 19:17:21 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mLylc-0009Vi-Dk; Fri, 03 Sep 2021 02:17:20 +0000
Date: Fri, 03 Sep 2021 10:17:11 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 a4fdd46bb30f9f392e5e4f70bb61c442b37b8329
Message-ID: <613185a7.5S8bljP1GpFXFTr5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_191724_044305_D0842EB5 
X-CRM114-Status: UNSURE (   7.93  )
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
branch HEAD: a4fdd46bb30f9f392e5e4f70bb61c442b37b8329  nvme-tcp: Do not reset transport on data digest errors

elapsed time: 729m

configs tested: 179
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210903
i386                 randconfig-c001-20210902
i386                 randconfig-c001-20210831
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
mips                          ath25_defconfig
mips                      fuloong2e_defconfig
s390                             alldefconfig
powerpc                       eiger_defconfig
sh                        dreamcast_defconfig
arm                           viper_defconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
ia64                        generic_defconfig
mips                         mpc30x_defconfig
sh                           se7343_defconfig
arm                          ixp4xx_defconfig
mips                        maltaup_defconfig
powerpc                     pseries_defconfig
arm                        multi_v5_defconfig
arm                         lpc18xx_defconfig
x86_64                           alldefconfig
arm                      integrator_defconfig
arm                            xcep_defconfig
powerpc                   microwatt_defconfig
arm                       multi_v4t_defconfig
sh                            hp6xx_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
h8300                            alldefconfig
nios2                            alldefconfig
arm                           corgi_defconfig
arm                         assabet_defconfig
arm                           tegra_defconfig
arm                        trizeps4_defconfig
m68k                        m5307c3_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
arm                         lpc32xx_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
nds32                               defconfig
arm                          collie_defconfig
arm                         s3c6400_defconfig
sh                             sh03_defconfig
mips                           jazz_defconfig
m68k                          multi_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
arm                         s3c2410_defconfig
sh                           se7619_defconfig
sh                        edosk7705_defconfig
nios2                            allyesconfig
nios2                         10m50_defconfig
powerpc                        cell_defconfig
arm                              alldefconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
x86_64               randconfig-a004-20210902
x86_64               randconfig-a006-20210902
x86_64               randconfig-a003-20210902
x86_64               randconfig-a005-20210902
x86_64               randconfig-a001-20210902
x86_64               randconfig-a002-20210902
i386                 randconfig-a005-20210902
i386                 randconfig-a004-20210902
i386                 randconfig-a006-20210902
i386                 randconfig-a002-20210902
i386                 randconfig-a001-20210902
i386                 randconfig-a003-20210902
x86_64               randconfig-a016-20210903
x86_64               randconfig-a011-20210903
x86_64               randconfig-a012-20210903
x86_64               randconfig-a015-20210903
x86_64               randconfig-a014-20210903
x86_64               randconfig-a013-20210903
i386                 randconfig-a012-20210903
i386                 randconfig-a015-20210903
i386                 randconfig-a011-20210903
i386                 randconfig-a013-20210903
i386                 randconfig-a014-20210903
i386                 randconfig-a016-20210903
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210903
mips                 randconfig-c004-20210903
x86_64               randconfig-c007-20210903
powerpc              randconfig-c003-20210903
i386                 randconfig-c001-20210903
arm                  randconfig-c002-20210903
riscv                randconfig-c006-20210903
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
i386                 randconfig-a005-20210903
i386                 randconfig-a004-20210903
i386                 randconfig-a006-20210903
i386                 randconfig-a002-20210903
i386                 randconfig-a001-20210903
i386                 randconfig-a003-20210903
i386                 randconfig-a012-20210902
i386                 randconfig-a015-20210902
i386                 randconfig-a011-20210902
i386                 randconfig-a013-20210902
i386                 randconfig-a014-20210902
i386                 randconfig-a016-20210902
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
