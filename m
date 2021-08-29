Return-Path: <SRS0=NAJj=NU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E7BC432BE
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Aug 2021 18:05:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C167B60E97
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Aug 2021 18:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C167B60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EFPwnsoowuEsm5BlviXBCHPIhOsYHOGsdZ+YBMFPz58=; b=Gik+ezXPW55I8V
	PmLfNulJls+MizzeySf0tAZuxrJgOFVS6Sk7SJb3W7ep80krUMAnU9nnvCe+i0ZmIc59LFxYyTWEI
	twP02jf5JyKImgdxMIKjZcfDgY0AnavjzIoK+vUFF/UGVbI2TLDXAGLAi4E53xbfhIyQPtlMSGB+u
	qnHg8AP44rlopBQBkiQI2DWcBssWhcTEQEOhknjUbjMK0eRCWjIT1M0FhKz7dC92R0lXAkXB5CKAz
	5V1xDzJRTFad2j4AfMH5bW1iCAyToQuTilVnp+/HOoPZ7heeptmXtrpLtCEIuK7+IzmWTH4G5kayL
	vhgNmG1C+C8W9Xmx8NEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKPBB-00FrQ6-Ly; Sun, 29 Aug 2021 18:05:13 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKPB6-00FrIC-Aw
 for linux-nvme@lists.infradead.org; Sun, 29 Aug 2021 18:05:12 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="205303417"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; d="scan'208";a="205303417"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2021 11:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; d="scan'208";a="458780847"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2021 11:05:03 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mKPB1-0004Uo-3C; Sun, 29 Aug 2021 18:05:03 +0000
Date: Mon, 30 Aug 2021 02:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 9a6810fde787d16f9e05e58e4e6f6ef426573464
Message-ID: <612bcc43.4dHSdcS3YlIeF7R4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210829_110508_490212_C30B6E50 
X-CRM114-Status: UNSURE (   7.39  )
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
branch HEAD: 9a6810fde787d16f9e05e58e4e6f6ef426573464  nvmet: return bool from nvmet_passthru_ctrl and nvmet_is_passthru_req

elapsed time: 722m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210829
um                             i386_defconfig
arm                        mini2440_defconfig
x86_64                            allnoconfig
powerpc                      ppc44x_defconfig
arm                      footbridge_defconfig
um                               alldefconfig
microblaze                      mmu_defconfig
m68k                          multi_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc32_defconfig
arm                           sunxi_defconfig
s390                             allyesconfig
sh                   sh7770_generic_defconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
s390                                defconfig
mips                     loongson2k_defconfig
powerpc                     redwood_defconfig
sh                           se7724_defconfig
arm                           stm32_defconfig
s390                             alldefconfig
m68k                        m5307c3_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        multi_v5_defconfig
mips                        nlm_xlp_defconfig
sh                           se7750_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         at91_dt_defconfig
mips                            ar7_defconfig
mips                           xway_defconfig
powerpc                          g5_defconfig
powerpc                      chrp32_defconfig
arm                       multi_v4t_defconfig
xtensa                    xip_kc705_defconfig
mips                     decstation_defconfig
mips                          malta_defconfig
sparc64                          alldefconfig
mips                       bmips_be_defconfig
sh                          rsk7203_defconfig
arm                            lart_defconfig
sh                        apsh4ad0a_defconfig
arm                           h5000_defconfig
powerpc                     mpc83xx_defconfig
parisc                           allyesconfig
arm                         lubbock_defconfig
arc                     nsimosci_hs_defconfig
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
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210829
x86_64               randconfig-a016-20210829
x86_64               randconfig-a015-20210829
x86_64               randconfig-a012-20210829
x86_64               randconfig-a013-20210829
x86_64               randconfig-a011-20210829
i386                 randconfig-a011-20210829
i386                 randconfig-a016-20210829
i386                 randconfig-a012-20210829
i386                 randconfig-a014-20210829
i386                 randconfig-a013-20210829
i386                 randconfig-a015-20210829
arc                  randconfig-r043-20210829
riscv                randconfig-r042-20210829
s390                 randconfig-r044-20210829
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210829
i386                 randconfig-c001-20210829
arm                  randconfig-c002-20210829
riscv                randconfig-c006-20210829
x86_64               randconfig-c007-20210829
powerpc              randconfig-c003-20210829
mips                 randconfig-c004-20210829
x86_64               randconfig-a001-20210829
x86_64               randconfig-a006-20210829
x86_64               randconfig-a005-20210829
x86_64               randconfig-a003-20210829
x86_64               randconfig-a004-20210829
x86_64               randconfig-a002-20210829
i386                 randconfig-a001-20210829
i386                 randconfig-a006-20210829
i386                 randconfig-a005-20210829
i386                 randconfig-a004-20210829
i386                 randconfig-a003-20210829

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
