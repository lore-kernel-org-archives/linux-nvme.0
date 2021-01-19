Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299DEC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:11:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC5F22C9D
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC5F22C9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EzLmGjTGqu28kRGw6NEQsnBMWOJVu8hLFlVDVBnK0Lw=; b=UXUCJHIbx7UBhrEw1ximiTHCAC
	xLFaRr27DOdOPX7dJ2UPO/9tC1sNs3AsYp6mXRHpIJDslfCSYLgmmziHgZb1PNgqaFuTNbnexMTH+
	cGphCQnKwnAWpkHW7B/Fa+fBVBGRwDzqNuFdvVGg2idiE3WkZIKoGAfi44eSoHbtOaOQ4x0dC2GD9
	MizFbOAcB0nLrl4dpkI6ZYsqbPyPuXmWG2dZU06gWIe+hrAejVN9kRCszn/5SxBiYAYflaWbQdQKF
	tdcIEQ1IneciN6Zee1gCVXQuiwabj7efP44bk3yb7rsg32IZ1RCQIp7Za6hc4cXDTvOaCHBCUXlpo
	C9KPqEbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1kDW-0003Qu-IN; Tue, 19 Jan 2021 06:10:14 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1kDT-0003QL-LP
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 06:10:13 +0000
IronPort-SDR: TQXdxd9psrxJz/a/5tLiB1wEajCSbX6FDQU3FD8YYbcDBDBEDxvpOJ0e96Y59m2BSRVhmMxECW
 U+cWp9pz3oig==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="242952469"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; d="scan'208";a="242952469"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2021 22:10:02 -0800
IronPort-SDR: V3RW9bcUWBG4uDXPueiZP1EEXzftO7etxFgugz8/gV50gwXP/9SxyzVI7SDoxt39pk4ICVNebf
 o6CRSXdBTG+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; d="scan'208";a="365547948"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 18 Jan 2021 22:10:01 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l1kDI-0004ll-Fm; Tue, 19 Jan 2021 06:10:00 +0000
Date: Tue, 19 Jan 2021 14:09:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 bffcd507780ea614b5543c66f2e37ce0d55cd449
Message-ID: <600677ad.FOQOU+qZcfQ3BgvI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_011011_865850_0DC17872 
X-CRM114-Status: UNSURE (   9.75  )
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
branch HEAD: bffcd507780ea614b5543c66f2e37ce0d55cd449  nvmet: set right status on error in id-ns handler

elapsed time: 724m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
sparc                            allyesconfig
sparc64                             defconfig
arm                          pxa910_defconfig
powerpc                         ps3_defconfig
arm                     am200epdkit_defconfig
mips                      loongson3_defconfig
ia64                             alldefconfig
powerpc                      tqm8xx_defconfig
sh                          polaris_defconfig
m68k                        mvme147_defconfig
arm                          tango4_defconfig
powerpc                  iss476-smp_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
powerpc                      mgcoge_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         nhk8815_defconfig
h8300                     edosk2674_defconfig
mips                     decstation_defconfig
mips                malta_qemu_32r6_defconfig
arm                         s3c2410_defconfig
sh                              ul2_defconfig
m68k                          multi_defconfig
powerpc                      pcm030_defconfig
sh                   sh7724_generic_defconfig
xtensa                    smp_lx200_defconfig
arm                             ezx_defconfig
arm                           viper_defconfig
arm                            zeus_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         vf610m4_defconfig
arm                        shmobile_defconfig
arm                       netwinder_defconfig
parisc                generic-32bit_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8548_defconfig
mips                          rm200_defconfig
arm                        magician_defconfig
h8300                               defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                      tct_hammer_defconfig
mips                           jazz_defconfig
powerpc                     skiroot_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm5200_defconfig
m68k                         amcore_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
i386                             alldefconfig
m68k                            q40_defconfig
powerpc                 mpc8560_ads_defconfig
csky                                defconfig
mips                    maltaup_xpa_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210118
i386                 randconfig-a005-20210118
i386                 randconfig-a006-20210118
i386                 randconfig-a001-20210118
i386                 randconfig-a003-20210118
i386                 randconfig-a004-20210118
x86_64               randconfig-a015-20210118
x86_64               randconfig-a013-20210118
x86_64               randconfig-a012-20210118
x86_64               randconfig-a016-20210118
x86_64               randconfig-a011-20210118
x86_64               randconfig-a014-20210118
i386                 randconfig-a011-20210118
i386                 randconfig-a012-20210118
i386                 randconfig-a016-20210118
i386                 randconfig-a015-20210118
i386                 randconfig-a013-20210118
i386                 randconfig-a014-20210118
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
