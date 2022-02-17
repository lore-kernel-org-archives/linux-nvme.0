Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0292C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qRniPUJZtjZnSV+8nonIC4rqJAuc3pAXhWRTSHOoWnw=; b=N9hFIWI8Mz0oLUy4h6g/8xAtbi
	btKBNAtm65ESc0MrYg8QttBlKBkMENtWYGWHZ/sPcOW5b9KBx2pnGr9tpvBBLZNMU22w8m2FZouN9
	Qpm8sj2XMbEuVmn62WCIQB0ZSHm4S5JA25snAMfNpWcpg2t4o3EG/OXkYn2Gct5xgVJTSnGKPjR6c
	yIgdSRNWZ3iYXlrSvrGClTEcGLtGWI8quaPv9uI/PkWGO/01mD7nGyIJUxtaw2F2n6mjFX3ThMA/p
	cg35Vr2gSGfi69qHt6lTACtiWIbpoQ47WDLU+6GhNZlJtw0WNlW5N525Tv325BaNcnhLYHqyWLXOu
	NyTfHMmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKnYy-00CApo-Qm; Thu, 17 Feb 2022 20:39:40 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKnOj-00C5f3-9j
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 20:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645129745; x=1676665745;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=L6kK9hQv+OAYWR5wX0EGNDVTgs/6wFC2QcqBhDOwtiQ=;
 b=WGB1UmQzI6iEA2Hm7o8YYzPtmC+B4i0yMxvKWtX8DSnfsx9S7CZ0N2Jo
 bkGwR1Tnd6cedVULmMkwHAPx0eWgBBybce/CvM5Qec8UbMI63KQofBT9n
 OJyDtEj2BhIKHcHUwkI2GJolF2le2dZ/uwmDHhvcCuaQTfqpIibx16uZ6
 YwJ4WOpZx3qCUiWseym2pE2L9QEfAKqGdGskUx6gEp71gIS+jnW1msCJg
 KdiY/6dPzwXufbFFfAV92imDeyHtsE00R9T3hiSKmVgyiP69KUP4lBV0b
 SS65hLAM3jboiSy4ZY6dBPwlORTnAuna++N8JOjt/kQoOddhpBasaGPih A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311711074"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="311711074"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 12:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; d="scan'208";a="488678227"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 12:29:03 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKnOg-0000cP-Pm; Thu, 17 Feb 2022 20:29:02 +0000
Date: Fri, 18 Feb 2022 04:28:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 f7505c1aab23cbcbf99dbed6ec9a1c3924705309
Message-ID: <620eafec.4fQvAU2P6HoOFeed%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_122905_522444_BBDE2373 
X-CRM114-Status: UNSURE (   7.20  )
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
branch HEAD: f7505c1aab23cbcbf99dbed6ec9a1c3924705309  nvme: also mark passthrough-only namespaces ready in nvme_update_ns_info

elapsed time: 731m

configs tested: 171
configs skipped: 4

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
arm                          exynos_defconfig
sh                            migor_defconfig
arc                          axs103_defconfig
arm                       omap2plus_defconfig
nios2                         3c120_defconfig
arm                            xcep_defconfig
mips                         mpc30x_defconfig
powerpc                       maple_defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
arc                                 defconfig
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
powerpc                    amigaone_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                      gensparse_defconfig
xtensa                    xip_kc705_defconfig
powerpc64                           defconfig
mips                            ar7_defconfig
arc                           tb10x_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       ppc64_defconfig
arm                        keystone_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
powerpc                    klondike_defconfig
sh                               j2_defconfig
arc                          axs101_defconfig
sh                            shmin_defconfig
powerpc                      bamboo_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
arm                           corgi_defconfig
sh                          sdk7780_defconfig
x86_64                           alldefconfig
m68k                        m5272c3_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                        cell_defconfig
sh                 kfr2r09-romimage_defconfig
sh                   sh7724_generic_defconfig
sh                           se7712_defconfig
m68k                       m5208evb_defconfig
arm                             ezx_defconfig
sparc                       sparc32_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220217
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
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220217
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220217
arm                  randconfig-c002-20220217
i386                          randconfig-c001
mips                 randconfig-c004-20220217
mips                           ip27_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
arm                             mxs_defconfig
arm                     am200epdkit_defconfig
x86_64                           allyesconfig
arm                      tct_hammer_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

