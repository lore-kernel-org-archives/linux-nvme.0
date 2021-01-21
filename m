Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB4C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 06:10:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA8B2389F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 06:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA8B2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o1BJDWvSJOZYcjVYlJs7pt/Jvt2xVQvJBVji/bCa0QU=; b=IlqQ2b0HKSkFsBsHW4kD81hHoK
	2znoi6kjFnqK33JoJ7/sV2JtB109fyCJRe2dxBAgF7S3LAs4ldyBWygrtQI7IJ+CBpBcwRso6Dj4e
	EVy54Hl469VfX2gTMvO8sc7g0arbMmqi9uVp8G7jDCQKLlp3kF62JBF8sNgIPwnR9jHbH6sjtdAYH
	hwGJFMhaVbogUDbf4gQtXKgwVcPURJt31hIREHLv1fW0wC32ooS3sR+uljLUDSEyOmm+r1ENriCvM
	OzWx1ukivS8J0w07vRMrvgGlubQmrvNibNagEh+ont9eefp1gBFrreLwHTQdd2Qj+pyL5fisvEqZW
	6XPZDkfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2TAJ-0007wZ-0j; Thu, 21 Jan 2021 06:09:55 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2TAF-0007vH-PY
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 06:09:53 +0000
IronPort-SDR: jObDTugHhteFyUox7XTAUGVbhGTXzcq9uu8H1WzHR+098M4OXtu7PTC9A4hnxazORcUkkud3DI
 xpDWF1eUW3jQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240763570"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; d="scan'208";a="240763570"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 22:09:43 -0800
IronPort-SDR: XilHgTOOvFTUKhzQDOUbcIrYIpSwxIC0hMFsPKUdOUz/EO7vLwyXPp95jUalZ0+pLX+kTiRazK
 R7oQQyjUfTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; d="scan'208";a="366662265"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 20 Jan 2021 22:09:42 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l2TA5-0006Kc-Mc; Thu, 21 Jan 2021 06:09:41 +0000
Date: Thu, 21 Jan 2021 14:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 fa0732168fa1369dd089e5b06d6158a68229f7b7
Message-ID: <60091a99.zIgYsOiLVUEr7h9A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_010952_005530_10B8CD7F 
X-CRM114-Status: GOOD (  10.12  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.11
branch HEAD: fa0732168fa1369dd089e5b06d6158a68229f7b7  nvme-pci: fix error unwind in nvme_map_data

elapsed time: 725m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
alpha                            alldefconfig
arm                           stm32_defconfig
sparc64                             defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     kilauea_defconfig
sh                     magicpanelr2_defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
s390                          debug_defconfig
mips                     cu1830-neo_defconfig
arm                          moxart_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     stx_gp3_defconfig
arm                             pxa_defconfig
mips                        maltaup_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
ia64                      gensparse_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  cadence_csp_defconfig
powerpc                  mpc885_ads_defconfig
arm                        cerfcube_defconfig
mips                        bcm47xx_defconfig
arm                          ixp4xx_defconfig
arm                            u300_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
openrisc                            defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      pcm030_defconfig
powerpc                     redwood_defconfig
mips                      pic32mzda_defconfig
ia64                          tiger_defconfig
openrisc                 simple_smp_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
xtensa                              defconfig
sparc                               defconfig
h8300                    h8300h-sim_defconfig
powerpc                     ppa8548_defconfig
arm                         nhk8815_defconfig
powerpc                    klondike_defconfig
powerpc                     rainier_defconfig
parisc                generic-32bit_defconfig
arm                          pxa168_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
mips                        jmr3927_defconfig
riscv                             allnoconfig
xtensa                         virt_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7760_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
xtensa                generic_kc705_defconfig
m68k                             alldefconfig
sh                           se7712_defconfig
arm                           spitz_defconfig
powerpc                      arches_defconfig
powerpc                       ppc64_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                         bcm2835_defconfig
sh                          sdk7786_defconfig
sparc                       sparc32_defconfig
mips                        nlm_xlp_defconfig
mips                         tb0287_defconfig
powerpc                    ge_imp3a_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
powerpc                      ppc6xx_defconfig
arm                          iop32x_defconfig
sparc                            alldefconfig
powerpc                        cell_defconfig
csky                             alldefconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
