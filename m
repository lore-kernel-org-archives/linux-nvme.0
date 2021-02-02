Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6716BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 22:52:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0705964F6A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 22:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0705964F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UoC5zOJntq24fyR1lMYl2nnF2W/IN/7ecAPQk7CU7n4=; b=eS+NWEc4gMvg9hF9dFr716/evZ
	xqt4lyv5elfw1I2rpjRKwjcrNQa//O8gqYiPr3WF3YfSKnpHY2BgjSGy7LFmix1glc0CjYeUA/jTU
	5UlYJ7bOfN7gouooSk9KuZu65/DX+W45bOhDfngmLsgK6YjhYYgDmdcdHC4Pk4wnAyFbeEi44bHBa
	6rJLAPhtWU08U6T+C+k1NdbTEXjXE5NSi5YBl93Qpgkr/p0ucsXbqwHssd9sGU4EBisjtv2huNBZD
	LFGGCopm8DmAzbff/oy/DzZiF6Xbryv9lSmJOcoD08znJsKwM8ZZnuwhYSv4H+zJ/ZfvJWOa0JgRi
	H9MxNU8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l74XN-0000d4-JC; Tue, 02 Feb 2021 22:52:45 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l74XJ-0000cd-RW
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 22:52:43 +0000
IronPort-SDR: ITJEFbD0xxOU/z0AN1sIBDGcF709BGKevLgZqXqHUE3AI3S33dTf8JNfKEFfh9uVU1q61Peiop
 VV/1hHLaYQFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181022567"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="181022567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 14:52:40 -0800
IronPort-SDR: 5tTDso63T45swK/6Am0iWFD/OoIaYdH/hp/y8MC+6qax+ZcE4axxzQ0vPh04J9/O7CGSAkZwUK
 +wLyc9sLXnlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="507521867"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 02 Feb 2021 14:52:39 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l74XG-0009jX-DW; Tue, 02 Feb 2021 22:52:38 +0000
Date: Wed, 03 Feb 2021 06:52:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 46121fa7c2dc55bcbb729b6a2ab323aa1e8986cf
Message-ID: <6019d7a8.IK+/fneCXftyxpm+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_175242_102216_52E1B18F 
X-CRM114-Status: UNSURE (   8.46  )
X-CRM114-Notice: Please train this message.
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
branch HEAD: 46121fa7c2dc55bcbb729b6a2ab323aa1e8986cf  update the email address for Keith Bush

elapsed time: 727m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7722_defconfig
sh                        edosk7760_defconfig
sh                        dreamcast_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
c6x                        evmc6457_defconfig
powerpc                      mgcoge_defconfig
mips                        qi_lb60_defconfig
mips                        nlm_xlr_defconfig
powerpc                     kilauea_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
mips                           ip22_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
powerpc                    klondike_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
riscv                               defconfig
powerpc                  mpc866_ads_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
arm                       multi_v4t_defconfig
c6x                        evmc6474_defconfig
s390                             alldefconfig
arm                          exynos_defconfig
sh                              ul2_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                            q40_defconfig
powerpc                     asp8347_defconfig
powerpc                     stx_gp3_defconfig
arc                          axs103_defconfig
s390                       zfcpdump_defconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
mips                      pistachio_defconfig
powerpc                 mpc85xx_cds_defconfig
nios2                               defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
powerpc                       holly_defconfig
mips                       lemote2f_defconfig
arm                        cerfcube_defconfig
arm                         mv78xx0_defconfig
arm                         cm_x300_defconfig
sh                           se7206_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
arm                      integrator_defconfig
mips                        bcm63xx_defconfig
powerpc                    sam440ep_defconfig
arm                           omap1_defconfig
mips                       capcella_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
arm                            mmp2_defconfig
powerpc                     tqm8555_defconfig
arm                            hisi_defconfig
m68k                            mac_defconfig
m68k                           sun3_defconfig
riscv                            allmodconfig
sh                           se7750_defconfig
sh                          rsk7264_defconfig
um                           x86_64_defconfig
arm                        realview_defconfig
mips                     cu1830-neo_defconfig
arm                             rpc_defconfig
sh                            shmin_defconfig
arm                          pxa910_defconfig
i386                             allyesconfig
arm                            pleb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          ep93xx_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
sparc                               defconfig
mips                       rbtx49xx_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
arm                           efm32_defconfig
nios2                         10m50_defconfig
c6x                              alldefconfig
sh                         ecovec24_defconfig
mips                      maltaaprp_defconfig
arm                     davinci_all_defconfig
arm                         axm55xx_defconfig
sparc                       sparc64_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        fsp2_defconfig
arm                        keystone_defconfig
powerpc                      ppc40x_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
