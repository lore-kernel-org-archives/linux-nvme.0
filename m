Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A079C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 21:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9057B61977
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 21:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057B61977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dPWoEKbjI0KORyjGkR6gVGEIqo9BUkfkFlBL7AAq5BQ=; b=FzOQOYGTnEIbp8
	hHJSME/347J69u6q0vCMFh6Ox7AXqtP7li3XJ1ji4Ym+RejfzmFQcmbf5rD31lp2mruKOFfntmnvI
	a/rhv4+tuvQVnP2s59x4AmgTso/pjXMWb23GTTUzUpmi3/LBFH+U0bl5rnXUzmv2Okmt1kdkxrFph
	KmGeLw5ANMktn96cRFAeIu/AKBu7Rbg5NTj3OC3G+OXefzM3G2Eg+Fm/h0cltdgZyo055ZG1H4acw
	cC6n5G2GDNKOuyeXvV7afm9D/l+4LJOxjNlKe6HpT2PQ7+eqtR+4UacoeDazRpwk1osa5blVlNrVt
	nfs3v/MYTpYzmgQRRrOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0WYW-009wsF-0H; Mon, 05 Jul 2021 21:55:08 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0WYR-009wrV-LC
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 21:55:05 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="208981870"
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; d="scan'208";a="208981870"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 14:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; d="scan'208";a="485646035"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2021 14:54:57 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m0WYL-000Cbx-0P; Mon, 05 Jul 2021 21:54:57 +0000
Date: Tue, 06 Jul 2021 05:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.14] BUILD SUCCESS
 0755d3be2d9bb6ea38598ccd30d6bbaa1a5c3a50
Message-ID: <60e37f87.y7g/KA/8xm4glBJN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_145503_806421_1B15D676 
X-CRM114-Status: UNSURE (   7.59  )
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
branch HEAD: 0755d3be2d9bb6ea38598ccd30d6bbaa1a5c3a50  nvme-tcp: can't set sk_user_data without write_lock

elapsed time: 727m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
arc                                 defconfig
arm                            pleb_defconfig
xtensa                    smp_lx200_defconfig
arc                        nsim_700_defconfig
arm                        vexpress_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      pmac32_defconfig
mips                     loongson2k_defconfig
arm                        mvebu_v5_defconfig
x86_64                           alldefconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8560_defconfig
arm                     davinci_all_defconfig
arm                         socfpga_defconfig
mips                     loongson1c_defconfig
mips                        maltaup_defconfig
sparc64                          alldefconfig
xtensa                          iss_defconfig
sh                      rts7751r2d1_defconfig
arc                        vdk_hs38_defconfig
powerpc                       holly_defconfig
sh                             shx3_defconfig
sh                           se7619_defconfig
mips                           ci20_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
mips                       rbtx49xx_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         cm_x300_defconfig
sh                           se7750_defconfig
arm                       multi_v4t_defconfig
s390                             allyesconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8540_defconfig
m68k                          hp300_defconfig
mips                         tb0219_defconfig
powerpc                     ep8248e_defconfig
mips                       capcella_defconfig
mips                           gcw0_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
arc                        nsimosci_defconfig
arm                         axm55xx_defconfig
arm                       imx_v6_v7_defconfig
arm                      footbridge_defconfig
parisc                generic-32bit_defconfig
powerpc                     taishan_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    mvme5100_defconfig
sparc                       sparc64_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    ge_imp3a_defconfig
arm                        realview_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
powerpc                      makalu_defconfig
powerpc                      pcm030_defconfig
mips                      fuloong2e_defconfig
s390                       zfcpdump_defconfig
mips                  cavium_octeon_defconfig
m68k                       m5475evb_defconfig
mips                     cu1000-neo_defconfig
sh                           se7206_defconfig
m68k                          atari_defconfig
arm                        multi_v5_defconfig
ia64                            zx1_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
mips                          ath25_defconfig
openrisc                  or1klitex_defconfig
arm                       aspeed_g5_defconfig
arm                       cns3420vb_defconfig
um                             i386_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        mvme16x_defconfig
m68k                         amcore_defconfig
parisc                           allyesconfig
sh                           se7721_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
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
x86_64               randconfig-a004-20210705
x86_64               randconfig-a002-20210705
x86_64               randconfig-a005-20210705
x86_64               randconfig-a006-20210705
x86_64               randconfig-a003-20210705
x86_64               randconfig-a001-20210705
i386                 randconfig-a004-20210705
i386                 randconfig-a006-20210705
i386                 randconfig-a001-20210705
i386                 randconfig-a003-20210705
i386                 randconfig-a005-20210705
i386                 randconfig-a002-20210705
i386                 randconfig-a015-20210705
i386                 randconfig-a016-20210705
i386                 randconfig-a012-20210705
i386                 randconfig-a011-20210705
i386                 randconfig-a014-20210705
i386                 randconfig-a013-20210705
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210705
x86_64               randconfig-a015-20210705
x86_64               randconfig-a014-20210705
x86_64               randconfig-a012-20210705
x86_64               randconfig-a011-20210705
x86_64               randconfig-a016-20210705
x86_64               randconfig-a013-20210705

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
