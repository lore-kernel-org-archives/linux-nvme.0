Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD3C432BE
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 20:15:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278B761002
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 20:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 278B761002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GxJ3WvJiBCa5YfWjxgD6Amgwh91ozW64qItVadfR69w=; b=mwk5Z8CGSHSXTP
	0QNjSNUlpono4mT69O73dahWH/5tpLPqMFcPRVB5oJEa1h1gwUUuKUP8ME0XVDZUuRF1JojiaE8OA
	0mszaKg9hGD2qAX7oZfQ//Gh9YkUC7+do/0TYpaVs7ms0lcYClusoVIFQxCfSu8oOrlRHQChqXOHC
	DOjZxTb0zNTubEqOymu68wrOHATMHaQl8b37OQXXkrLg1I4otJ+ukHb1MN0JM+BVFCaruSIPNqwLr
	mr9HS0+HUiRRpnXP2cxPuyWEWbskRFvZ3RMNyT97CwJOxKE+JGtfc55VFXdgQuLy4wfd83N8xYxzT
	FLpCIe0hyga7KtoZd1og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIzIr-008QFN-08; Wed, 25 Aug 2021 20:15:17 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIzIl-008QEV-Av
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 20:15:15 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="197843460"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; d="scan'208";a="197843460"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2021 13:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; d="scan'208";a="456192605"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2021 13:14:31 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mIzI6-0000Wi-Bc; Wed, 25 Aug 2021 20:14:30 +0000
Date: Thu, 26 Aug 2021 04:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 d692c18d58229e084e92395d0831b3381f6d5ab9
Message-ID: <6126a491.aqadm0r6cCYLCdiM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_131511_458078_BE102403 
X-CRM114-Status: UNSURE (   6.40  )
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
branch HEAD: d692c18d58229e084e92395d0831b3381f6d5ab9  nvme-multipath: revalidate paths during rescan

elapsed time: 734m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210825
powerpc                       ebony_defconfig
arm                           sama5_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
xtensa                       common_defconfig
h8300                               defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
mips                           ip32_defconfig
m68k                            mac_defconfig
arm                       aspeed_g4_defconfig
mips                      bmips_stb_defconfig
arm                            xcep_defconfig
arm                            mps2_defconfig
sparc                            alldefconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
powerpc                   currituck_defconfig
arm                            dove_defconfig
arc                        vdk_hs38_defconfig
sh                        edosk7760_defconfig
powerpc                    klondike_defconfig
powerpc                     mpc83xx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ep88xc_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         axm55xx_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            migor_defconfig
arm                          pcm027_defconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
m68k                                defconfig
arc                          axs103_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           ci20_defconfig
sh                           se7722_defconfig
mips                  maltasmvp_eva_defconfig
mips                          malta_defconfig
mips                           rs90_defconfig
mips                   sb1250_swarm_defconfig
sh                             sh03_defconfig
m68k                        mvme16x_defconfig
i386                                defconfig
mips                         tb0226_defconfig
xtensa                         virt_defconfig
mips                     loongson2k_defconfig
powerpc                    socrates_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath25_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     ksi8560_defconfig
powerpc                       holly_defconfig
parisc                generic-32bit_defconfig
arm                        trizeps4_defconfig
arm                        spear3xx_defconfig
arm                           stm32_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
arm                             pxa_defconfig
powerpc                     tqm8540_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     tqm8548_defconfig
ia64                             allyesconfig
powerpc                    adder875_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
arm                          pxa910_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8541_defconfig
sh                   sh7770_generic_defconfig
arm                         assabet_defconfig
sh                ecovec24-romimage_defconfig
sh                            hp6xx_defconfig
powerpc64                        alldefconfig
arm                       imx_v4_v5_defconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
m68k                       m5249evb_defconfig
powerpc                        warp_defconfig
um                               alldefconfig
arm                          collie_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210825
x86_64               randconfig-a015-20210825
x86_64               randconfig-a016-20210825
x86_64               randconfig-a013-20210825
x86_64               randconfig-a012-20210825
x86_64               randconfig-a011-20210825
i386                 randconfig-a011-20210825
i386                 randconfig-a016-20210825
i386                 randconfig-a012-20210825
i386                 randconfig-a014-20210825
i386                 randconfig-a013-20210825
i386                 randconfig-a015-20210825
arc                  randconfig-r043-20210825
riscv                randconfig-r042-20210825
s390                 randconfig-r044-20210825
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
s390                 randconfig-c005-20210825
i386                 randconfig-c001-20210825
arm                  randconfig-c002-20210825
riscv                randconfig-c006-20210825
powerpc              randconfig-c003-20210825
x86_64               randconfig-c007-20210825
x86_64               randconfig-a005-20210825
x86_64               randconfig-a001-20210825
x86_64               randconfig-a006-20210825
x86_64               randconfig-a003-20210825
x86_64               randconfig-a004-20210825
x86_64               randconfig-a002-20210825
i386                 randconfig-a006-20210825
i386                 randconfig-a001-20210825
i386                 randconfig-a002-20210825
i386                 randconfig-a005-20210825
i386                 randconfig-a004-20210825
i386                 randconfig-a003-20210825

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
