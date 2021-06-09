Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3CC47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 05:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2C761278
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 05:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2C761278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+Zr2x96IvrJ5eCstDeRw3+0yh7jlCi+8lu7/uSxE5J8=; b=l2ViZfRMlM0rua
	sl7yjnvpttkqo3bThxg4wVUZgVov9C9ZkiLbnqoyJAmfBMs3wnsFrsm5GyKBTnLDVXQJTA5ez8dtr
	FP9Eeas5h7HpcyN05JnIIW/74x9rhx6EWGwi6cwpsAvEiu+h1sP8tCFsgSX5EBVUq9Y9UL/+Rucmv
	SwZCVoH/U4IlrTOzv8uM5K+r2yjcCTLI7UupV77r+CiKwLgSBwSvRWvAGkRyrFX2BBX6xvFBrnVoC
	/TgBrfAhG1rIrvw2ZntqRVRUQi8yC66TsNlrwvV3IjJIIx55gPlzeC6L/MPyGVOVVbytG93q3xAU8
	SZHlDZ2FkM35gBgfHNXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqqwb-00BlwH-Or; Wed, 09 Jun 2021 05:40:01 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqqwI-00Blvz-Pk
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 05:39:44 +0000
IronPort-SDR: EIwCQYchV/sRwXZclFeh22R7VyJT0KmOJKA7xBsPE13f5NdXa0VKVfbw1FcTEOjl7Ld4EWOCvE
 pn8dGR/+AuPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="266160358"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="266160358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 22:39:35 -0700
IronPort-SDR: 3YK1Mdp84M/OiNrCHmoZfD+/ZkaRPWIt43WcB6AzmONbZzI2w0AZ9KNPj8SDq7p4u09R5J+DJx
 J9zl7zEImxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="448168055"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 08 Jun 2021 22:39:33 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lqqw9-0009Qf-56; Wed, 09 Jun 2021 05:39:33 +0000
Date: Wed, 09 Jun 2021 13:39:02 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.14] BUILD REGRESSION
 b0386eb167134d958f1876a1a7e39e113385c516
Message-ID: <60c053f6.eA3BFs9/MLJgLMRl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_223942_942114_8A53F18C 
X-CRM114-Status: UNSURE (   5.03  )
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
branch HEAD: b0386eb167134d958f1876a1a7e39e113385c516  nvme-pci: remove trailing lines for helpers

Error/Warning in current branch:

drivers/nvme/host/pci.c:539:7: error: implicit declaration of function 'nvme_ctrl_sgl_supported' [-Werror,-Wimplicit-function-declaration]
drivers/nvme/host/pci.c:539:7: error: implicit declaration of function 'nvme_ctrl_sgl_supported' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- alpha-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- arm-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- arm-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- i386-randconfig-a011-20210608
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- ia64-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- ia64-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- mips-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- parisc-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- powerpc-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- powerpc-pseries_defconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- riscv-allmodconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- riscv-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- s390-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- s390-defconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- sparc-allyesconfig
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- sparc-randconfig-r024-20210608
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- x86_64-kexec
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- x86_64-randconfig-a003-20210608
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- x86_64-rhel-8.3
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
|-- x86_64-rhel-8.3-kbuiltin
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported
`-- xtensa-allyesconfig
    `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported

clang_recent_errors
|-- powerpc-randconfig-r013-20210608
|   `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported-Werror-Wimplicit-function-declaration
`-- x86_64-randconfig-a011-20210608
    `-- drivers-nvme-host-pci.c:error:implicit-declaration-of-function-nvme_ctrl_sgl_supported-Werror-Wimplicit-function-declaration

elapsed time: 722m

configs tested: 94
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
sh                           se7722_defconfig
sh                           se7724_defconfig
arc                          axs103_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
xtensa                  nommu_kc705_defconfig
um                           x86_64_defconfig
sh                             espt_defconfig
powerpc                     pseries_defconfig
powerpc                    gamecube_defconfig
mips                      bmips_stb_defconfig
um                               alldefconfig
arm                          pxa168_defconfig
mips                           ip27_defconfig
h8300                               defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
