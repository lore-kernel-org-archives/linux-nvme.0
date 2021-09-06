Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE93C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 21:21:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C97E60238
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 21:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C97E60238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vxKyxpdaWyFwQ5kvTU+enq8lm9ppavRxl8aV3biN7io=; b=vtRU0VaaxD57r/
	47TKeThCXrjF7NXt3sbgDOigVbNCIivaDcgRQLEjdhocwOs3AOg28mEQpE6xyPHcKcys8P8UvlOh8
	wieh1IJCfsFXP/STvR32BTpDqL2MPV0O8QwKR77OXHe8YDqayWipb5Bd2HGDPj8dG1HJNFMy1PRwa
	eQ5ijF/kyqD1Dgkixtzm9gpN83ivcKSxsXtdVgxKVpHT3x7Ml3lPM9rH4++103UvnSPplOuE4k67M
	kSUdVeUlSOMFsvhjncBq7mNIO+O+MHVsFdI7LqkgWVkIAXlYzJxO9BVnSmkH9N12jLQsMxk5Hwt6l
	N2f6dOYkw8QwPSAcNJBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNM2t-001yEF-Ri; Mon, 06 Sep 2021 21:20:51 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNM2q-001yDe-Bz
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 21:20:50 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="283749296"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; d="scan'208";a="283749296"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2021 14:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; d="scan'208";a="691872764"
Received: from lkp-server01.sh.intel.com (HELO 53c23d017ad5) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2021 14:20:43 -0700
Received: from kbuild by 53c23d017ad5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mNM2l-00017E-3B; Mon, 06 Sep 2021 21:20:43 +0000
Date: Tue, 07 Sep 2021 05:20:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 aff959c2840858d55d9ee155d555b3aa7e068b32
Message-ID: <6136861c.yW0LTO0ml60WC+KP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_142048_516306_2CCC250D 
X-CRM114-Status: UNSURE (   6.48  )
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
branch HEAD: aff959c2840858d55d9ee155d555b3aa7e068b32  nvme: update MAINTAINERS email address

elapsed time: 720m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210906
mips                           ip28_defconfig
m68k                            mac_defconfig
powerpc                      pmac32_defconfig
powerpc                        icon_defconfig
arm                        multi_v7_defconfig
arm                          moxart_defconfig
powerpc                     sequoia_defconfig
m68k                        mvme147_defconfig
sparc                               defconfig
riscv                    nommu_virt_defconfig
powerpc                    ge_imp3a_defconfig
arm                            qcom_defconfig
arm                           stm32_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
mips                 decstation_r4k_defconfig
mips                           ip27_defconfig
s390                             alldefconfig
sh                            hp6xx_defconfig
powerpc                         ps3_defconfig
sh                         ap325rxa_defconfig
mips                      malta_kvm_defconfig
ia64                      gensparse_defconfig
powerpc64                        alldefconfig
s390                                defconfig
mips                     cu1830-neo_defconfig
mips                           mtx1_defconfig
powerpc                 canyonlands_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     tqm8541_defconfig
mips                         tb0219_defconfig
x86_64                              defconfig
arm                            zeus_defconfig
powerpc                     mpc83xx_defconfig
mips                      maltasmvp_defconfig
riscv                          rv32_defconfig
powerpc                       maple_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc832x_mds_defconfig
s390                             allmodconfig
powerpc                      tqm8xx_defconfig
s390                          debug_defconfig
arm                            lart_defconfig
um                                  defconfig
arm                          pxa910_defconfig
mips                       lemote2f_defconfig
powerpc                     tqm5200_defconfig
powerpc                       ebony_defconfig
arm                        mvebu_v7_defconfig
h8300                               defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20210906
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                              defconfig
parisc                           allyesconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20210906
i386                 randconfig-a004-20210906
i386                 randconfig-a006-20210906
i386                 randconfig-a002-20210906
i386                 randconfig-a003-20210906
i386                 randconfig-a001-20210906
i386                 randconfig-a012-20210905
x86_64               randconfig-a006-20210906
x86_64               randconfig-a004-20210906
x86_64               randconfig-a003-20210906
x86_64               randconfig-a005-20210906
x86_64               randconfig-a001-20210906
x86_64               randconfig-a002-20210906
arc                  randconfig-r043-20210906
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210906
mips                 randconfig-c004-20210906
powerpc              randconfig-c003-20210906
i386                 randconfig-c001-20210906
arm                  randconfig-c002-20210906
x86_64               randconfig-c007-20210906
riscv                randconfig-c006-20210906
i386                 randconfig-a015-20210906
i386                 randconfig-a016-20210906
i386                 randconfig-a011-20210906
i386                 randconfig-a012-20210906
i386                 randconfig-a013-20210906
i386                 randconfig-a014-20210906

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
