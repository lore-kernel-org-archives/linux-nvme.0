Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7382C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 04:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED3960E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 04:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5ED3960E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bRI5/R1NuoAA2ctHnrDtHCEV+7bYyr1pqLtwgiqwAIo=; b=iFzvR0Nmp3Cz+8
	MnpuqbhOyNmLjvWAgP8BWfoU+Nwwbm0k0MSu3bCz4sLzKVz+re3/8iqLAGb0I9ebbo4Fgulhq/9wW
	O/9Ag5NHEntfhrXbGFJt5kL5ODwaunS3xAS7F01yOdWYfmyOh7+B5w6SLlYrn998HQSQuhQvfrHQR
	JWWD5jljrWCijzw9Ej4Prfq/ZluBqmFB9HT2PvYh+4DMpvUXbcyLb4JKACoziXaDoizHTHz6T+fRB
	rxInc3rgD8B1SEG6z26HnwWOwAUwH4+zWDGdBmrh/HWcyCXB9usEFG8CoY41PLFMNgEBEttfEV383
	bApJu02rdmVQHO0Eo67g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ06b-004AZH-4Y; Tue, 14 Sep 2021 04:31:37 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ069-004AYw-06
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 04:31:10 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221543670"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; d="scan'208";a="221543670"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2021 21:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; d="scan'208";a="650611733"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 13 Sep 2021 21:30:51 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mQ05r-0008BQ-2r; Tue, 14 Sep 2021 04:30:51 +0000
Date: Tue, 14 Sep 2021 12:29:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 49d417553b07ed9cf5f30b69d7600aea96d6c903
Message-ID: <6140253f.QfmnrNDSAzfZNUNH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_213109_117216_156D8398 
X-CRM114-Status: UNSURE (   6.95  )
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
branch HEAD: 49d417553b07ed9cf5f30b69d7600aea96d6c903  nvme-tcp: fix io_work priority inversion

elapsed time: 725m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210913
powerpc                   motionpro_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5307c3_defconfig
powerpc                      ppc6xx_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
arm                          pxa168_defconfig
arm                          pxa910_defconfig
mips                     loongson1b_defconfig
powerpc                     taishan_defconfig
arm                         s3c2410_defconfig
arm                            mps2_defconfig
xtensa                  cadence_csp_defconfig
arm                     davinci_all_defconfig
powerpc                     redwood_defconfig
arm                       netwinder_defconfig
powerpc                        cell_defconfig
mips                      maltasmvp_defconfig
mips                        workpad_defconfig
m68k                            q40_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    gamecube_defconfig
sh                                  defconfig
mips                           ip27_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8555_defconfig
arm                          ixp4xx_defconfig
mips                   sb1250_swarm_defconfig
xtensa                         virt_defconfig
sparc64                          alldefconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
mips                         bigsur_defconfig
mips                        maltaup_defconfig
arc                        nsim_700_defconfig
arm                             mxs_defconfig
powerpc                  iss476-smp_defconfig
arm                         bcm2835_defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
sh                           se7721_defconfig
mips                         rt305x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
arm                       aspeed_g5_defconfig
riscv                    nommu_virt_defconfig
xtensa                  audio_kc705_defconfig
alpha                               defconfig
s390                             alldefconfig
sh                      rts7751r2d1_defconfig
openrisc                         alldefconfig
m68k                        mvme16x_defconfig
powerpc                     ep8248e_defconfig
powerpc                      arches_defconfig
riscv                               defconfig
h8300                            allyesconfig
arm                        neponset_defconfig
powerpc                     stx_gp3_defconfig
arm                           viper_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
x86_64               randconfig-c001-20210913
arm                  randconfig-c002-20210913
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210913
x86_64               randconfig-a003-20210913
x86_64               randconfig-a006-20210913
x86_64               randconfig-a004-20210913
x86_64               randconfig-a005-20210913
x86_64               randconfig-a001-20210913
i386                 randconfig-a004-20210913
i386                 randconfig-a005-20210913
i386                 randconfig-a002-20210913
i386                 randconfig-a006-20210913
i386                 randconfig-a003-20210913
i386                 randconfig-a001-20210913
arc                  randconfig-r043-20210913
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
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
riscv                randconfig-c006-20210913
x86_64               randconfig-c007-20210913
mips                 randconfig-c004-20210913
powerpc              randconfig-c003-20210913
i386                 randconfig-c001-20210913
arm                  randconfig-c002-20210913
s390                 randconfig-c005-20210913
x86_64               randconfig-a016-20210913
x86_64               randconfig-a013-20210913
x86_64               randconfig-a012-20210913
x86_64               randconfig-a011-20210913
x86_64               randconfig-a014-20210913
x86_64               randconfig-a015-20210913
i386                 randconfig-a016-20210913
i386                 randconfig-a011-20210913
i386                 randconfig-a015-20210913
i386                 randconfig-a012-20210913
i386                 randconfig-a013-20210913
i386                 randconfig-a014-20210913
riscv                randconfig-r042-20210913
hexagon              randconfig-r045-20210913
s390                 randconfig-r044-20210913
hexagon              randconfig-r041-20210913

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
