Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0245BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 21:14:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B4D61A0B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 21:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4B4D61A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0Rlywh57G7sQ6278LBwv7eDWezUxVkZJ4/A8AedTz5w=; b=1nC/k0rzuA3o+e
	y3LgdL+944wGwf63fbynO0/aNsoLeJxqusto8RzPCT0Pg46GJV8UMcO9fT/kLP97raTdRJsLgQBnt
	q8ho9mHiZqZoRyUEltO3VPO/a6+pfr5pCkUh3m6+93uXhVppvTabldF5bNsaT/ybWza+8Pp0RaqCh
	BN347sXLo3Jz2k+MkGxdWiqW8fPBQm5KDgXiNZ4mzOF8uAW2NjV1ZDBhNC75TG8KF5Bl/KMSjXqtK
	wybxn5Iw2x0nR9cPjTDmjUaJgF2sQo8wKUPWUZZkL5Thl5++coSjU/Xm71QEtYgTNIQpi9xJR8VsW
	FF/1a4f7ds0Al0KzsyFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mW3NK-00G1A8-V0; Thu, 30 Sep 2021 21:13:54 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mW3NG-00G19l-Hp
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 21:13:54 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225331067"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="225331067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 14:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="539693023"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2021 14:13:46 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mW3NB-0000Q5-Sw; Thu, 30 Sep 2021 21:13:45 +0000
Date: Fri, 01 Oct 2021 05:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 298ba0e3d4af539cc37f982d4c011a0f07fca48c
Message-ID: <6156287b.qlcf+vKjd5FU/704%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_141350_734390_4AB8D170 
X-CRM114-Status: UNSURE (   8.40  )
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
branch HEAD: 298ba0e3d4af539cc37f982d4c011a0f07fca48c  nvme: keep ctrl->namespaces ordered

elapsed time: 1163m

configs tested: 264
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210929
i386                 randconfig-c001-20210930
powerpc              randconfig-c003-20210930
mips                malta_qemu_32r6_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
mips                        nlm_xlr_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
csky                             alldefconfig
mips                        workpad_defconfig
arc                        vdk_hs38_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
sh                      rts7751r2d1_defconfig
nios2                            alldefconfig
arm                         s3c6400_defconfig
mips                        qi_lb60_defconfig
arm                          lpd270_defconfig
mips                     loongson2k_defconfig
mips                         mpc30x_defconfig
mips                          rb532_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
x86_64                              defconfig
mips                        vocore2_defconfig
arm                        spear3xx_defconfig
riscv                    nommu_k210_defconfig
arm                       mainstone_defconfig
powerpc                     stx_gp3_defconfig
powerpc                    amigaone_defconfig
sparc                       sparc64_defconfig
riscv                               defconfig
mips                            gpr_defconfig
sh                           se7721_defconfig
arc                              allyesconfig
arm                      pxa255-idp_defconfig
arm                         lpc32xx_defconfig
sh                               alldefconfig
mips                           mtx1_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8541_defconfig
powerpc                      mgcoge_defconfig
mips                          rm200_defconfig
powerpc                     mpc83xx_defconfig
arm                          gemini_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                           stm32_defconfig
m68k                          sun3x_defconfig
powerpc                         ps3_defconfig
sh                                  defconfig
sh                   secureedge5410_defconfig
arm                          iop32x_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arm                        oxnas_v6_defconfig
sh                          rsk7264_defconfig
powerpc                 linkstation_defconfig
arm                         palmz72_defconfig
mips                          ath25_defconfig
sh                   sh7724_generic_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    klondike_defconfig
powerpc                     taishan_defconfig
powerpc                       maple_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
xtensa                  nommu_kc705_defconfig
arm                  colibri_pxa300_defconfig
arm                         at91_dt_defconfig
sh                ecovec24-romimage_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc836x_mds_defconfig
arm                    vt8500_v6_v7_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         bcm2835_defconfig
sh                            titan_defconfig
openrisc                            defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
arm                        multi_v7_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            lart_defconfig
riscv                            alldefconfig
mips                          malta_defconfig
m68k                         amcore_defconfig
riscv                          rv32_defconfig
arc                              alldefconfig
sh                  sh7785lcr_32bit_defconfig
openrisc                    or1ksim_defconfig
s390                          debug_defconfig
powerpc                      pcm030_defconfig
csky                                defconfig
ia64                             alldefconfig
powerpc                     tqm5200_defconfig
powerpc64                           defconfig
x86_64                           alldefconfig
powerpc                      ppc64e_defconfig
mips                            e55_defconfig
mips                           ip27_defconfig
powerpc                      walnut_defconfig
sh                        sh7757lcr_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          ixp4xx_defconfig
powerpc                     mpc512x_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                            qcom_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
powerpc                     redwood_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
sh                         ecovec24_defconfig
arc                          axs101_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
arm                            zeus_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                       eiger_defconfig
arm                      footbridge_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
sh                          lboxre2_defconfig
xtensa                    xip_kc705_defconfig
arc                         haps_hs_defconfig
arm                   milbeaut_m10v_defconfig
arc                           tb10x_defconfig
arm                  randconfig-c002-20210930
x86_64               randconfig-c001-20210930
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210929
x86_64               randconfig-a005-20210929
x86_64               randconfig-a001-20210929
x86_64               randconfig-a006-20210929
x86_64               randconfig-a003-20210929
x86_64               randconfig-a004-20210929
x86_64               randconfig-a004-20210930
x86_64               randconfig-a001-20210930
x86_64               randconfig-a002-20210930
x86_64               randconfig-a005-20210930
x86_64               randconfig-a006-20210930
x86_64               randconfig-a003-20210930
i386                 randconfig-a003-20210930
i386                 randconfig-a001-20210930
i386                 randconfig-a004-20210930
i386                 randconfig-a002-20210930
i386                 randconfig-a006-20210930
i386                 randconfig-a005-20210930
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
arc                  randconfig-r043-20210929
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20210929
mips                 randconfig-c004-20210929
arm                  randconfig-c002-20210929
x86_64               randconfig-c007-20210929
riscv                randconfig-c006-20210929
s390                 randconfig-c005-20210929
i386                 randconfig-c001-20210929
i386                 randconfig-c001-20210930
arm                  randconfig-c002-20210930
powerpc              randconfig-c003-20210930
mips                 randconfig-c004-20210930
s390                 randconfig-c005-20210930
riscv                randconfig-c006-20210930
x86_64               randconfig-c007-20210930
x86_64               randconfig-a015-20210930
x86_64               randconfig-a011-20210930
x86_64               randconfig-a012-20210930
x86_64               randconfig-a013-20210930
x86_64               randconfig-a016-20210930
x86_64               randconfig-a014-20210930
x86_64               randconfig-a014-20210929
x86_64               randconfig-a011-20210929
x86_64               randconfig-a013-20210929
x86_64               randconfig-a015-20210929
x86_64               randconfig-a012-20210929
x86_64               randconfig-a016-20210929
i386                 randconfig-a014-20210930
i386                 randconfig-a013-20210930
i386                 randconfig-a011-20210930
i386                 randconfig-a015-20210930
i386                 randconfig-a016-20210930
i386                 randconfig-a012-20210930
i386                 randconfig-a014-20210929
i386                 randconfig-a013-20210929
i386                 randconfig-a016-20210929
i386                 randconfig-a011-20210929
i386                 randconfig-a015-20210929
i386                 randconfig-a012-20210929
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929
riscv                randconfig-r042-20210930
hexagon              randconfig-r041-20210930
s390                 randconfig-r044-20210930
hexagon              randconfig-r045-20210930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
