Return-Path: <SRS0=SkPw=EU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77847C5519F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 21:09:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0E022284
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 21:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VPPNqlRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0E022284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+vgGOtbk6n0iEV96GZ+C0MumyDy2mYaHy92577dNnCA=; b=VPPNqlRoh0ggF8EAqVteHyA1DB
	0SNIdw6us0SNSA2DtpfRiaJMHwJDwf1Ijm52Cd0qTzL3kqGwxgwKC5Qcceq1QGhaNViWnCiPL5H7s
	VFfbhp6z00wm6u0sUffqyrivBIdrgu6DXzFlikb4y7ETuDs1B1zu3UoYnzBEuvqHW20tF9YSkL0lo
	bsYxFiGFLoFKMHcsr3+JjK4bYjvcmjnRl0FgYtV8uVjnFO1Nju6V8GFxx3Au7FdUMnf9p1RkD6tNn
	jAV0ZGTa+pGnSqSaa6Aw7I591Gkbw/luTCabbPe7zqvomiegkev1ybU/Sv+mXDmepwWhzj4bDKgXM
	hPoa9kYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ke2ni-0001NH-RA; Sat, 14 Nov 2020 21:09:38 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ke2nf-0001MV-IV
 for linux-nvme@lists.infradead.org; Sat, 14 Nov 2020 21:09:36 +0000
IronPort-SDR: LnFGoE2FudY74ZtJ/bLa+qCwkq8kX4IVr/S70VsUJZsG2acxaVZFpEvUs6UV285dqLDpXLV6mt
 NRivhcEArzrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="167090541"
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; d="scan'208";a="167090541"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2020 13:09:32 -0800
IronPort-SDR: hQ8gE8aKKHxZnefjIOT8NZMit7ZDXY8rc1vCgCYjbwdyWM04D0J/ZHzRRzuhSQkUoFRBgrU47k
 uC1Oq4mXFnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; d="scan'208";a="543085398"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 14 Nov 2020 13:09:31 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ke2na-0000zD-L9; Sat, 14 Nov 2020 21:09:30 +0000
Date: Sun, 15 Nov 2020 05:09:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 5cecff7960fd529d609ec35ffedb12e927f086d3
Message-ID: <5fb04775.DyA1oZgcaIu3fzER%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201114_160935_780773_ED039040 
X-CRM114-Status: GOOD (  12.95  )
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
branch HEAD: 5cecff7960fd529d609ec35ffedb12e927f086d3  nvme-pci: don't allocate unused I/O queues

elapsed time: 723m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
mips                             allyesconfig
h8300                    h8300h-sim_defconfig
sh                             shx3_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                     sequoia_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
nios2                         10m50_defconfig
m68k                             allmodconfig
arm                      pxa255-idp_defconfig
arm                        cerfcube_defconfig
ia64                         bigsur_defconfig
mips                            gpr_defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         db1xxx_defconfig
sh                             espt_defconfig
mips                        jmr3927_defconfig
mips                        bcm47xx_defconfig
arm                         orion5x_defconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
arm                         assabet_defconfig
um                            kunit_defconfig
arm                            lart_defconfig
mips                       rbtx49xx_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          imote2_defconfig
xtensa                         virt_defconfig
arm                        shmobile_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
mips                           ip32_defconfig
riscv                               defconfig
sh                          kfr2r09_defconfig
mips                     loongson1c_defconfig
arm                   milbeaut_m10v_defconfig
arm                           spitz_defconfig
mips                         tb0226_defconfig
m68k                        m5272c3_defconfig
ia64                          tiger_defconfig
arm                            xcep_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201114
x86_64               randconfig-a005-20201114
x86_64               randconfig-a004-20201114
x86_64               randconfig-a002-20201114
x86_64               randconfig-a001-20201114
x86_64               randconfig-a006-20201114
i386                 randconfig-a006-20201114
i386                 randconfig-a005-20201114
i386                 randconfig-a001-20201114
i386                 randconfig-a002-20201114
i386                 randconfig-a004-20201114
i386                 randconfig-a003-20201114
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201114
i386                 randconfig-a014-20201114
i386                 randconfig-a016-20201114
i386                 randconfig-a011-20201114
i386                 randconfig-a015-20201114
i386                 randconfig-a013-20201114
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113
x86_64               randconfig-a015-20201114
x86_64               randconfig-a011-20201114
x86_64               randconfig-a014-20201114
x86_64               randconfig-a013-20201114
x86_64               randconfig-a016-20201114
x86_64               randconfig-a012-20201114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
