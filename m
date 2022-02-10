Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53616C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 02:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=62lHLJO478Fefw3ywuHqMIbdm2Gl/z38DW+//iYoEzI=; b=KnhI7CYsCB/P5CXUpibqZaVB5W
	QoBlL7BSSf/3FqXvjnHiak72ZaDJRkt6feJ8et++B0XQ412SqWkCE9KgolONmbCSg+V7KVi+ybpd8
	f9zfKEUL9GDsYHFpeOSosEwe/xj6DSageV4eg10q9FtzNDcwzhNVoF9f9L6rSyPHnt7AhY393z61M
	1tAo4i1/DGIhb83oe8ZX8fM6sNJjH9z0DbQ67V+SMlrzYD0FFjvNG4DzJ5VRFZAqaDkiN7DcRyqa7
	A9MCh121bv13n93w1Qfa/Ly0ZIxLnCoImcwaugFyqSjK9pgWHDeWVHJj867vuYhmn6AN/RXWAkZJ/
	69PsaVSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHymC-002GAG-K7; Thu, 10 Feb 2022 02:01:40 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHym5-002G7t-64
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 02:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644458493; x=1675994493;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=jPBOoTP96m/k7Jl0NOlEds5FGgNvg80+dLQkNvghSmM=;
 b=RcKY0rPjqVQihF8yf+L/gcEj1p8mSPheXE+EcQhaHIxxmOKTd4hxs3DU
 IbZ9qNcjJ1mDRRd8rZoM1UzUFzxZ7DIcq6nLQWrTo1LHBOOORHyYRdoBq
 +Xu0+CqsV/SfUyTkpFfRSvwgVpadbtg0UKW72YHTxEQHMXkQwfXn6qgpr
 YnzkW+rnUlamhfST0scgmx1YHeHgI5Nee2ob9V3e53AO7k9AXcJxx/Wxa
 tt8+YrbVIpJJ8EX5P6Xsqb2eLY5Wv26B8v26Qb1YoeuySRIH0/jKXEM0R
 mZx+ifY+DBqn+kg/BVSFNRVGs3/gvbasXMMQga4Lr8HFT91dwqm71rwwf Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249335567"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="249335567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 18:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="568474994"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 09 Feb 2022 18:01:20 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nHylr-0002Yc-VR; Thu, 10 Feb 2022 02:01:19 +0000
Date: Thu, 10 Feb 2022 10:01:04 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 63573807b27e0faf8065a28b1bbe1cbfb23c0130
Message-ID: <620471e0.AmNa1Eu+nLV0BuZA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_180133_347281_F76411EA 
X-CRM114-Status: UNSURE (   7.81  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: 63573807b27e0faf8065a28b1bbe1cbfb23c0130  nvme-tcp: fix bogus request completion when failing to send AER

elapsed time: 724m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
sh                         microdev_defconfig
arm                            hisi_defconfig
xtensa                  nommu_kc705_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
riscv                            allyesconfig
sh                          r7785rp_defconfig
h8300                               defconfig
mips                         cobalt_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
powerpc                      mgcoge_defconfig
powerpc                 canyonlands_defconfig
powerpc                     stx_gp3_defconfig
sh                          r7780mp_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
sh                              ul2_defconfig
mips                           jazz_defconfig
s390                             allyesconfig
powerpc                     sequoia_defconfig
powerpc                      chrp32_defconfig
sh                             sh03_defconfig
h8300                            allyesconfig
sh                          kfr2r09_defconfig
arm                          badge4_defconfig
h8300                    h8300h-sim_defconfig
powerpc64                        alldefconfig
mips                         db1xxx_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      ppc40x_defconfig
arm                         nhk8815_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
x86_64                              defconfig
mips                            gpr_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arc                              alldefconfig
um                                  defconfig
powerpc                      tqm8xx_defconfig
sh                          polaris_defconfig
csky                             alldefconfig
arc                           tb10x_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20220209
arm                  randconfig-c002-20220210
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220209
arc                  randconfig-r043-20220208
arc                  randconfig-r043-20220209
riscv                randconfig-r042-20220210
riscv                randconfig-r042-20220209
arc                  randconfig-r043-20220210
s390                 randconfig-r044-20220210
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220209
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220209
i386                          randconfig-c001
mips                 randconfig-c004-20220209
arm                  randconfig-c002-20220209
riscv                randconfig-c006-20220210
powerpc              randconfig-c003-20220210
arm                  randconfig-c002-20220210
mips                 randconfig-c004-20220210
powerpc                     ksi8560_defconfig
arm                       aspeed_g4_defconfig
mips                            e55_defconfig
arm                        spear3xx_defconfig
powerpc                    mvme5100_defconfig
powerpc                     kilauea_defconfig
powerpc                  mpc885_ads_defconfig
mips                         tb0287_defconfig
powerpc                      ppc64e_defconfig
arm                          collie_defconfig
i386                             allyesconfig
arm                       spear13xx_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
mips                          ath79_defconfig
powerpc                   microwatt_defconfig
riscv                             allnoconfig
powerpc                     mpc512x_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208
hexagon              randconfig-r045-20220210
hexagon              randconfig-r041-20220210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

