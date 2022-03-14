Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D476CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t1VO4GXYcK/3F39gMF1wBcvzj5V2kgq8J6MXFo3zz/8=; b=JxVl4WcnogCvtNiC2kBXA4k5Id
	L1E89G5wAbvnvGnt7Ag9Px6/UzXgx6HuCbeZmBRALxAEWzQVW9OHDS9DQZwVJ1FNO3X/NT/HUlNlP
	Mfbb0g/93s2oFuTD0ylLH+mow02CDOPsOSHL65gvVeCrVH7+smTkpsyemc9U4Exx5G/l3hp8QmIE3
	W6iSpmmWw423tO5Awbm2Ka0r8AQx0LywNIvy3KBvssWifD38quOdSoFpe6RV7UFYVL0XHlB38JBQ1
	ph9cd4Hg/U/ZPGkpP64mpEr1odZe9fPCktGh6yLK3E20Wj/+1e8sLKHblJCmMA21RISzFHxOkKrmr
	l7h7TO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTsFR-006sdI-Sh; Mon, 14 Mar 2022 21:29:01 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTsFO-006scz-PK
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 21:29:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647293338; x=1678829338;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=vZzGuoeaD1srMsQclbKv0suhojLWmveURfOnYbE+BsE=;
 b=Dn3xoX/5PXZUXQTcaAzXCSGyPrLi/SLBeR+/4rmvkXDLyWgDaYFn1yML
 i7lEFt+NTHF5fZSZexVK05w1hZuygrfFHXLiSabwbBWNX3zUczsV4TORr
 AkxlOwzGefzH9CXBM8HnJ3tvIlyYJi74dCRJHF3wuCDAh8JE+WcTPiZz4
 8cxmVommWF1blbYRbmKegKNy0Y5f6+SKiVfNqMFcRziLM2UEQz4rBoV1O
 PdAtvxiGlISw7/URnPFUTnDQSG/AXffrl/tdrSuctGDKUdzfAfyxVnCP+
 ouZTiL1aha4SIFjtRlleP3RbXbUdGs9ZWeuPTrLZ3mcmLPh6AJt87RvU3 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="254980148"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="254980148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 14:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="580272756"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 14:28:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nTsFJ-000AFB-Im; Mon, 14 Mar 2022 21:28:53 +0000
Date: Tue, 15 Mar 2022 05:28:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD REGRESSION
 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538
Message-ID: <622fb36f.IcDKTHS4r0igbu4s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_142858_926326_1F1ED44F 
X-CRM114-Status: UNSURE (   7.33  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 0ad57fcd030f0bda79a3b6c2fb8fc29b871d9538  nvmet: open code nvmet_get_feat_kato()

Error/Warning reports:

https://lore.kernel.org/linux-nvme/202203142114.jASwxczN-lkp@intel.com
https://lore.kernel.org/linux-nvme/202203142117.gVyaPma6-lkp@intel.com
https://lore.kernel.org/linux-nvme/202203142144.HC6i8FxB-lkp@intel.com
https://lore.kernel.org/llvm/202203142235.GRM0KrZ4-lkp@intel.com

Error/Warning:

arc-elf-ld: discovery.c:(.text+0xe8): undefined reference to `nvmet_get_feat_async_event'
arm-linux-gnueabi-ld: discovery.c:(.text+0x27a): undefined reference to `nvmet_get_feat_async_event'
discovery.c:(.text+0x144): undefined reference to `nvmet_get_feat_kato'
discovery.c:(.text+0x300): undefined reference to `nvmet_get_feat_kato'
discovery.c:(.text+0xe8): undefined reference to `nvmet_get_feat_kato'
ld.lld: error: undefined symbol: nvmet_get_feat_async_event
nios2-linux-ld: discovery.c:(.text+0x154): undefined reference to `nvmet_get_feat_async_event'

Unverified Error/Warning (likely false positive, please contact us if interested):

ERROR: modpost: "nvmet_get_feat_async_event" [drivers/nvme/target/nvmet.ko] undefined!
ERROR: modpost: "nvmet_get_feat_kato" [drivers/nvme/target/nvmet.ko] undefined!
aarch64-linux-ld: discovery.c:(.text+0x3ac): undefined reference to `nvmet_get_feat_async_event'
arc-elf-ld: discovery.c:(.text+0x136): undefined reference to `nvmet_get_feat_async_event'
arc-elf-ld: discovery.c:(.text+0xd4): undefined reference to `nvmet_get_feat_kato'
arc-elf-ld: discovery.c:(.text+0xf8): undefined reference to `nvmet_get_feat_kato'
discovery.c:(.text+0x1d4): undefined reference to `nvmet_get_feat_async_event'
discovery.c:(.text+0x1f2): undefined reference to `nvmet_get_feat_kato'
discovery.c:(.text+0x318): undefined reference to `nvmet_get_feat_async_event'
discovery.c:(.text+0xf8): undefined reference to `nvmet_get_feat_kato'
discovery.c:(.text.nvmet_execute_disc_get_features+0x9c): undefined reference to `nvmet_get_feat_kato'
drivers/nvme/target/discovery.c:340: undefined reference to `nvmet_get_feat_kato'
ia64-linux-ld: discovery.c:(.text+0x232): undefined reference to `nvmet_get_feat_async_event'
ld.lld: error: undefined symbol: nvmet_get_feat_kato
ld: drivers/nvme/target/discovery.c:343: undefined reference to `nvmet_get_feat_async_event'
m68k-linux-ld: discovery.c:(.text+0x14c): undefined reference to `nvmet_get_feat_async_event'
mips-linux-ld: discovery.c:(.text.nvmet_execute_disc_get_features+0xb4): undefined reference to `nvmet_get_feat_async_event'
powerpc-linux-ld: discovery.c:(.text+0x1e8): undefined reference to `nvmet_get_feat_async_event'
riscv64-linux-ld: discovery.c:(.text+0x230): undefined reference to `nvmet_get_feat_async_event'
s390-linux-ld: discovery.c:(.text+0x13a): undefined reference to `nvmet_get_feat_async_event'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-buildonly-randconfig-r001-20220314
|   |-- arc-elf-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|   `-- arc-elf-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|-- arc-randconfig-r043-20220313
|   |-- arc-elf-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|   |-- arc-elf-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|   `-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|-- arm-randconfig-c002-20220314
|   `-- arm-linux-gnueabi-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- arm64-randconfig-r013-20220313
|   `-- aarch64-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- i386-randconfig-a001-20220314
|   |-- drivers-nvme-target-discovery.c:undefined-reference-to-nvmet_get_feat_kato
|   `-- ld:drivers-nvme-target-discovery.c:undefined-reference-to-nvmet_get_feat_async_event
|-- ia64-allyesconfig
|   `-- ia64-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- m68k-allyesconfig
|   `-- m68k-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- mips-allyesconfig
|   |-- discovery.c:(.text.nvmet_execute_disc_get_features):undefined-reference-to-nvmet_get_feat_kato
|   `-- mips-linux-ld:discovery.c:(.text.nvmet_execute_disc_get_features):undefined-reference-to-nvmet_get_feat_async_event
|-- nios2-allyesconfig
|   |-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|   `-- nios2-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- powerpc-randconfig-r033-20220314
|   `-- powerpc-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- riscv-allyesconfig
|   `-- riscv64-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|-- riscv-randconfig-r042-20220313
|   |-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
|   `-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|-- s390-allyesconfig
|   `-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|-- s390-randconfig-r044-20220313
|   |-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_kato
|   `-- s390-linux-ld:discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event
`-- xtensa-allyesconfig
    `-- discovery.c:(.text):undefined-reference-to-nvmet_get_feat_async_event

clang_recent_errors
|-- i386-randconfig-a013-20220314
|   |-- ERROR:nvmet_get_feat_async_event-drivers-nvme-target-nvmet.ko-undefined
|   `-- ERROR:nvmet_get_feat_kato-drivers-nvme-target-nvmet.ko-undefined
|-- i386-randconfig-a016-20220314
|   |-- ld.lld:error:undefined-symbol:nvmet_get_feat_async_event
|   `-- ld.lld:error:undefined-symbol:nvmet_get_feat_kato
`-- riscv-randconfig-r042-20220314
    `-- ld.lld:error:undefined-symbol:nvmet_get_feat_async_event

elapsed time: 726m

configs tested: 119
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
powerpc                      bamboo_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                       omap2plus_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        spear6xx_defconfig
powerpc                      mgcoge_defconfig
sh                            hp6xx_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_mds_defconfig
h8300                       h8s-sim_defconfig
arm                  randconfig-c002-20220314
arm                  randconfig-c002-20220313
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a003-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
arc                  randconfig-r043-20220314
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                     loongson2k_defconfig
powerpc                      obs600_defconfig
powerpc                      ppc64e_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                          allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                     cu1000-neo_defconfig
arm                           omap1_defconfig
mips                          ath25_defconfig
arm                         shannon_defconfig
x86_64               randconfig-a011-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a014-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a012-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
hexagon              randconfig-r045-20220313
hexagon              randconfig-r045-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

