Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3AC4320E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 18:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED7660FE6
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 18:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ED7660FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DAC4mKL48hUt5mgS1bQmhs+R7v894jat/QVGgvdlLr8=; b=OtcsJgmqUJDYdE
	i3u9tqJ1tom7sBTK5B1qm4SkekJdfEXKUYNpnsvi/67G59RPcpF8AWvDi2Sy4S6CJgxhLc48+p4Pd
	CVS73qrDei6Ax2pWC2vHEIq+1L5omTriZr2zTIrC9V1JtbtE5A7uCs0W02L0aSb0SVkoa1JjPOWil
	QpzaZvM59hoQ8suerIF5B2yuzKVoJ6lwq58nzJHYis0Aq/yesl36ruwz8Gh7Al1YQ8EJHM52737vG
	G/9UXAsfPEC4XJ39SZAExpZD++p94FZEqUgTiWOZcYYozj7QoFHgFeiXR81zKvvVHFePgGpOrXMvD
	T3bpC4FkJzuaA5rS9JdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG3SG-003BpA-Lr; Tue, 17 Aug 2021 18:04:52 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG3SB-003BoA-5U
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 18:04:51 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="301742073"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="301742073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 11:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="424011375"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 17 Aug 2021 11:04:41 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mG3S4-000S5i-EE; Tue, 17 Aug 2021 18:04:40 +0000
Date: Wed, 18 Aug 2021 02:03:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 9891668e43c8e9f2d0d50088b151edefc2e560e5
Message-ID: <611bf9fc.zeAc5fUE0Y24Znnv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_110447_283963_6536ACA6 
X-CRM114-Status: UNSURE (   6.98  )
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
branch HEAD: 9891668e43c8e9f2d0d50088b151edefc2e560e5  nvme: remove the unused NVME_NS_* enum

elapsed time: 725m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lpc18xx_defconfig
arm                         lubbock_defconfig
arc                          axs101_defconfig
mips                           gcw0_defconfig
arm                        keystone_defconfig
arm                           h5000_defconfig
arm                  colibri_pxa270_defconfig
sh                            hp6xx_defconfig
mips                         rt305x_defconfig
s390                          debug_defconfig
arm                        clps711x_defconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
powerpc                 linkstation_defconfig
arm                       cns3420vb_defconfig
powerpc                     mpc512x_defconfig
arm                          lpd270_defconfig
sh                          lboxre2_defconfig
powerpc                        cell_defconfig
mips                          ath79_defconfig
mips                      maltaaprp_defconfig
powerpc                  mpc885_ads_defconfig
arm                          gemini_defconfig
arm                            hisi_defconfig
mips                  decstation_64_defconfig
mips                        vocore2_defconfig
powerpc                  iss476-smp_defconfig
arc                            hsdk_defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     ppa8548_defconfig
arm                         nhk8815_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
x86_64               randconfig-a011-20210817
x86_64               randconfig-a013-20210817
x86_64               randconfig-a016-20210817
x86_64               randconfig-a012-20210817
x86_64               randconfig-a015-20210817
x86_64               randconfig-a014-20210817
i386                 randconfig-a011-20210817
i386                 randconfig-a015-20210817
i386                 randconfig-a014-20210817
i386                 randconfig-a013-20210817
i386                 randconfig-a016-20210817
i386                 randconfig-a012-20210817
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
i386                 randconfig-c001-20210816
i386                 randconfig-a004-20210817
i386                 randconfig-a003-20210817
i386                 randconfig-a001-20210817
i386                 randconfig-a002-20210817
i386                 randconfig-a006-20210817
i386                 randconfig-a005-20210817
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
