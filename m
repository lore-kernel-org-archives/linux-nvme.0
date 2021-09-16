Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BDEC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 04:42:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7A561186
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 04:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB7A561186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=55PrXi6hrA0wllT9lLUwdi1f6T2zYz0nRTKtaU2m1lI=; b=HdQVaWVfQ6fgEg
	M6B8eH380dofjBXnrdyFwv5sbpqOTDKlg7sfQjq+iS0ibj5IPRMzC4V5S0fIMUOIGXRlDviLLRjFG
	dgfR9fnRAQHCR2aNFfZK4xGlcgHutjD+DpW7mhgUWF9vYi0IfjI2+mCO94eT0pJ0F8Y9P+5lPY3n4
	RcmdGfWtybPPot9i7PEp3L2qtdrPhop1OkXlDogajbCvZjCMY5fIMkuSv3skTqbSqBiBe4GZDofOW
	RJH8d1dZfK3ADzeiwmN7GXPD836XgTRtGLc4/aJRkOWXOPAqY+hls9KexXkpD8u2THn+kq7TPM/GL
	nKcaliExDfLO6qgJvMsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQjDV-00AJcv-EF; Thu, 16 Sep 2021 04:41:45 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQjDR-00AJcL-EC
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 04:41:43 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="222141577"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; d="scan'208";a="222141577"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 21:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; d="scan'208";a="452791846"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 15 Sep 2021 21:41:32 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mQjDH-0000jg-O9; Thu, 16 Sep 2021 04:41:31 +0000
Date: Thu, 16 Sep 2021 12:41:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b
Message-ID: <6142cae6.wzfEcDheqP1g0uQ8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_214141_561117_F56F4832 
X-CRM114-Status: UNSURE (   7.91  )
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
branch HEAD: 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b  nvme-tcp: fix io_work priority inversion

elapsed time: 2646m

configs tested: 227
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210916
i386                 randconfig-c001-20210914
nds32                            alldefconfig
parisc                generic-64bit_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
sh                        sh7785lcr_defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                      ppc40x_defconfig
sh                          rsk7201_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    socrates_defconfig
powerpc                      cm5200_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        magician_defconfig
arm                         cm_x300_defconfig
sh                          polaris_defconfig
mips                        omega2p_defconfig
arm                        multi_v5_defconfig
arc                          axs103_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
m68k                            mac_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
powerpc                      obs600_defconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
arm                           sunxi_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                          ixp4xx_defconfig
arm                          lpd270_defconfig
ia64                          tiger_defconfig
arm                      pxa255-idp_defconfig
arc                           tb10x_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                  cavium_octeon_defconfig
arm                         s5pv210_defconfig
arm                         assabet_defconfig
mips                      pic32mzda_defconfig
sh                        sh7763rdp_defconfig
arm                        cerfcube_defconfig
ia64                                defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
arm                       cns3420vb_defconfig
mips                        nlm_xlr_defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
arm                           spitz_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                        icon_defconfig
sh                                  defconfig
riscv                    nommu_virt_defconfig
i386                                defconfig
s390                       zfcpdump_defconfig
m68k                       m5249evb_defconfig
powerpc                   lite5200b_defconfig
mips                         cobalt_defconfig
arm                         shannon_defconfig
arm                  colibri_pxa300_defconfig
s390                             alldefconfig
riscv                          rv32_defconfig
x86_64               randconfig-c001-20210914
arm                  randconfig-c002-20210914
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210915
x86_64               randconfig-a003-20210915
x86_64               randconfig-a004-20210915
x86_64               randconfig-a006-20210915
x86_64               randconfig-a005-20210915
x86_64               randconfig-a001-20210915
i386                 randconfig-a004-20210915
i386                 randconfig-a005-20210915
i386                 randconfig-a006-20210915
i386                 randconfig-a002-20210915
i386                 randconfig-a001-20210915
i386                 randconfig-a003-20210915
x86_64               randconfig-a013-20210914
x86_64               randconfig-a016-20210914
x86_64               randconfig-a012-20210914
x86_64               randconfig-a011-20210914
x86_64               randconfig-a014-20210914
x86_64               randconfig-a015-20210914
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210914
i386                 randconfig-a015-20210914
i386                 randconfig-a011-20210914
i386                 randconfig-a012-20210914
i386                 randconfig-a013-20210914
i386                 randconfig-a014-20210914
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210914
x86_64               randconfig-c007-20210914
powerpc              randconfig-c003-20210914
arm                  randconfig-c002-20210914
i386                 randconfig-c001-20210914
s390                 randconfig-c005-20210914
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210914
i386                 randconfig-a005-20210914
i386                 randconfig-a006-20210914
i386                 randconfig-a002-20210914
i386                 randconfig-a001-20210914
i386                 randconfig-a003-20210914
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
x86_64               randconfig-a013-20210915
x86_64               randconfig-a016-20210915
x86_64               randconfig-a012-20210915
x86_64               randconfig-a011-20210915
x86_64               randconfig-a014-20210915
x86_64               randconfig-a015-20210915
x86_64               randconfig-a002-20210914
x86_64               randconfig-a003-20210914
x86_64               randconfig-a004-20210914
x86_64               randconfig-a006-20210914
x86_64               randconfig-a005-20210914
x86_64               randconfig-a001-20210914
i386                 randconfig-a016-20210915
i386                 randconfig-a015-20210915
i386                 randconfig-a011-20210915
i386                 randconfig-a012-20210915
i386                 randconfig-a013-20210915
i386                 randconfig-a014-20210915
hexagon              randconfig-r045-20210914
hexagon              randconfig-r041-20210914
riscv                randconfig-r042-20210915
hexagon              randconfig-r045-20210915
s390                 randconfig-r044-20210915
hexagon              randconfig-r041-20210915

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
