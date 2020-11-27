Return-Path: <SRS0=q43r=FB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EFC63777
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 01:36:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C823F22210
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 01:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2T4oJuSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C823F22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IdsWqxVDSF1ELJV9JDx21yRO0rBYuv0upw6wboz23MA=; b=2T4oJuShETHqFf7HRaBeVccCj+
	vqiNui40GvtBWrc0dB1sk/jLyC7Tei5660fNEqeKN34bebLQWmXKHk7ml7KTX6vVyYEF7hOK+UdC+
	LDbq5pxCTXVbTpeWoo5OPWzBN4nFvjIEM2IN8RxoTp2imn1EALBN7lV4wctJdhdERoTLAjmme8T4/
	BkNn+FbnGFR0b7jpuCfn/IYjPvozs8OONUmHmR+4tq6cOjGhsrPk774GKxACZDZvo14RUodYZ+BKO
	FHDY1eqcKr5v8BQPz6fqnjqPyJFjHdvevYXVIupnZJ53cIpHoiDyNwUDDZWN6zrcTHzYx8D8PcDfT
	+Vf4q0Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiSgJ-0001rA-AQ; Fri, 27 Nov 2020 01:36:15 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiSgF-0001pu-TB
 for linux-nvme@lists.infradead.org; Fri, 27 Nov 2020 01:36:13 +0000
IronPort-SDR: 04yEyb9GYtNHqGbB4vqxVby7trnPnAF8/UqLv29JXvlT4nuHXZK4tWXtQsTtx6MZj8jEMCu24p
 ZUAGRouzRzYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="171558061"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="171558061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 17:36:10 -0800
IronPort-SDR: nGTwo73n2D5iQwRg2si3rb8aJlLi82bOow8C6BSKSWMnWJA60wInT9Kyf7gzXvmR+XNyFuuRd0
 iGz1sSoGDjFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="547891747"
Received: from lkp-server02.sh.intel.com (HELO e51121f5de4e) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 26 Nov 2020 17:36:09 -0800
Received: from kbuild by e51121f5de4e with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kiSg1-00004o-F8; Fri, 27 Nov 2020 01:35:57 +0000
Date: Fri, 27 Nov 2020 09:35:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 2256901b0ceda48cb2e5067c1ae9a32047ce920c
Message-ID: <5fc057d3.DUOVXJU9sPSrYOo0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_203612_135107_655EF45E 
X-CRM114-Status: GOOD (  11.90  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.11
branch HEAD: 2256901b0ceda48cb2e5067c1ae9a32047ce920c  nvme-fabrics: reject I/O to offline device

elapsed time: 722m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        shmobile_defconfig
arm                           u8500_defconfig
xtensa                          iss_defconfig
sh                           se7619_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
powerpc                      ep88xc_defconfig
powerpc                        fsp2_defconfig
powerpc                      acadia_defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc83xx_defconfig
arm                           viper_defconfig
s390                                defconfig
xtensa                    xip_kc705_defconfig
parisc                generic-32bit_defconfig
arm                        magician_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
powerpc                      pasemi_defconfig
sh                          sdk7786_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
powerpc                     akebono_defconfig
arm                     davinci_all_defconfig
powerpc                   bluestone_defconfig
mips                           ip32_defconfig
c6x                        evmc6474_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa3xx_defconfig
mips                       rbtx49xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
arm                        trizeps4_defconfig
arm                         nhk8815_defconfig
arm                         ebsa110_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc8272_ads_defconfig
xtensa                              defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
i386                 randconfig-a004-20201126
i386                 randconfig-a003-20201126
i386                 randconfig-a002-20201126
i386                 randconfig-a005-20201126
i386                 randconfig-a001-20201126
i386                 randconfig-a006-20201126
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
x86_64               randconfig-a006-20201126
x86_64               randconfig-a003-20201126
x86_64               randconfig-a004-20201126
x86_64               randconfig-a005-20201126
x86_64               randconfig-a001-20201126
x86_64               randconfig-a002-20201126
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
i386                 randconfig-a012-20201126
i386                 randconfig-a013-20201126
i386                 randconfig-a011-20201126
i386                 randconfig-a016-20201126
i386                 randconfig-a014-20201126
i386                 randconfig-a015-20201126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201126
x86_64               randconfig-a011-20201126
x86_64               randconfig-a014-20201126
x86_64               randconfig-a016-20201126
x86_64               randconfig-a012-20201126
x86_64               randconfig-a013-20201126
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
