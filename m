Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C0C07E95
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 21:07:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848E0610C7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 21:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848E0610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LrZztad5mq9Q4/TwuiC7Ks6Cj08/b7brgoZUebHI4NM=; b=x436LFquIcjO4f
	lBOXj09EKar/yD46WHd1ESn0QNIBjyULhxz/tGTFKUV6y2k/cCgw6EGQ2QXJtdw/bM5Ug6xE/P9cr
	PHvi2gHgi3nLcCfkcsqon8TKNkUXynLai33wZk9oGEOkhR7ZRlg3F7+UFwdG09CLYtNuPY/apvlBu
	VIuMZI0FcurtBswDNlMW64dMcepAAV1ArYq5kHF5K24X1I7A5CRB793zwIMrsgjiJksNUczSsZ3Ey
	68/bqXW0R5haXkBkx2o9UCJJcDC4chERKwTgfhFLXAwD8FpYrgvwzhnjeJwkM+A47Z6OiGF7rnfv1
	5a/ZxsUkOP9OxJBtyOEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5aTs-00BLSb-Lh; Mon, 19 Jul 2021 21:07:16 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5aTp-00BLSH-39
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 21:07:14 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191411859"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="191411859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 14:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="660924755"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2021 14:07:08 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m5aTj-0000nO-VE; Mon, 19 Jul 2021 21:07:07 +0000
Date: Tue, 20 Jul 2021 05:07:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.14] BUILD SUCCESS
 8e0103634bcd48c84caead8e88f2371e80426ea5
Message-ID: <60f5e975.L3bC9GCrT27YhHj5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_140713_288196_839E1084 
X-CRM114-Status: UNSURE (   6.65  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.14
branch HEAD: 8e0103634bcd48c84caead8e88f2371e80426ea5  nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING

elapsed time: 2578m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlr_defconfig
h8300                            allyesconfig
powerpc                     tqm8541_defconfig
powerpc                      bamboo_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
sh                           se7750_defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    ge_imp3a_defconfig
sh                           se7206_defconfig
sparc64                             defconfig
sh                        sh7785lcr_defconfig
arm                        multi_v7_defconfig
powerpc                  iss476-smp_defconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
sh                               allmodconfig
ia64                                defconfig
powerpc                     rainier_defconfig
x86_64                              defconfig
mips                        bcm63xx_defconfig
mips                   sb1250_swarm_defconfig
arm                        shmobile_defconfig
sh                        dreamcast_defconfig
arm                        neponset_defconfig
sh                     sh7710voipgw_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
powerpc                        cell_defconfig
sh                ecovec24-romimage_defconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
parisc                generic-32bit_defconfig
h8300                     edosk2674_defconfig
mips                     cu1830-neo_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         at91_dt_defconfig
mips                           rs90_defconfig
mips                  maltasmvp_eva_defconfig
arm                         mv78xx0_defconfig
arm                         lpc32xx_defconfig
arm                          imote2_defconfig
powerpc                     tqm5200_defconfig
xtensa                  audio_kc705_defconfig
m68k                        m5272c3_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
mips                           ip32_defconfig
um                           x86_64_defconfig
mips                     loongson1c_defconfig
powerpc                      katmai_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
powerpc                    klondike_defconfig
arm                            mmp2_defconfig
arc                              alldefconfig
powerpc                      ppc44x_defconfig
riscv                               defconfig
arm                       imx_v4_v5_defconfig
sh                          polaris_defconfig
m68k                        m5307c3_defconfig
parisc                              defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                   microwatt_defconfig
arm                        spear6xx_defconfig
m68k                           sun3_defconfig
microblaze                          defconfig
riscv                    nommu_virt_defconfig
arm                   milbeaut_m10v_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                  mpc885_ads_defconfig
ia64                            zx1_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         axm55xx_defconfig
powerpc                        fsp2_defconfig
powerpc                     pseries_defconfig
arc                          axs103_defconfig
powerpc                      chrp32_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                             allyesconfig
mips                         bigsur_defconfig
sh                          sdk7780_defconfig
arm                          pcm027_defconfig
sh                         ecovec24_defconfig
sh                     magicpanelr2_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                          r7780mp_defconfig
arm                           u8500_defconfig
powerpc                      ep88xc_defconfig
mips                          rb532_defconfig
openrisc                         alldefconfig
arm                          gemini_defconfig
xtensa                    xip_kc705_defconfig
arm                           spitz_defconfig
openrisc                            defconfig
arm                            dove_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
x86_64               randconfig-a005-20210718
x86_64               randconfig-a004-20210718
x86_64               randconfig-a002-20210718
x86_64               randconfig-a003-20210718
x86_64               randconfig-a006-20210718
x86_64               randconfig-a001-20210718
i386                 randconfig-a005-20210718
i386                 randconfig-a004-20210718
i386                 randconfig-a006-20210718
i386                 randconfig-a001-20210718
i386                 randconfig-a003-20210718
i386                 randconfig-a002-20210718
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
x86_64               randconfig-a013-20210719
x86_64               randconfig-a012-20210719
x86_64               randconfig-a015-20210719
x86_64               randconfig-a014-20210719
x86_64               randconfig-a011-20210719
x86_64               randconfig-a016-20210719
i386                 randconfig-a014-20210718
i386                 randconfig-a015-20210718
i386                 randconfig-a011-20210718
i386                 randconfig-a013-20210718
i386                 randconfig-a016-20210718
i386                 randconfig-a012-20210718
i386                 randconfig-a014-20210719
i386                 randconfig-a015-20210719
i386                 randconfig-a011-20210719
i386                 randconfig-a013-20210719
i386                 randconfig-a016-20210719
i386                 randconfig-a012-20210719
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210718
x86_64               randconfig-b001-20210719
x86_64               randconfig-a005-20210719
x86_64               randconfig-a004-20210719
x86_64               randconfig-a002-20210719
x86_64               randconfig-a003-20210719
x86_64               randconfig-a006-20210719
x86_64               randconfig-a001-20210719
x86_64               randconfig-a013-20210718
x86_64               randconfig-a015-20210718
x86_64               randconfig-a012-20210718
x86_64               randconfig-a014-20210718
x86_64               randconfig-a011-20210718
x86_64               randconfig-a016-20210718

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
