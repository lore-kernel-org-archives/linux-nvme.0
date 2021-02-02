Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99875C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 22:52:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D9364F72
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 22:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D9364F72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qn42lBnq1VtPJ6vJdGgZ5ztsldSSN9LbkSgJCiBp750=; b=VyEVNneDOiq8QQ4+yTY9CgdWYf
	QO+j1td8KFmmz8cZLIJP2Z5Vt52jxDLhMkEbc9oFt7ekehLt4YfZHxoysmH+Rdb7Hc7VY+0rWdOkx
	M9xBRx+2xUsBmzw7mQAerBXg6USVgbU8+yuXLWI7zdnufJUPKRV8FDl06y5DwbQloeAaTZWWmKYV+
	eOszNZorqnmRrnYw2Qimm6QE9UHh3JWopHpTAbm7p22/4Q699WL1AO5DDiHLI+bLr1+E7KJTx6my/
	3Z7r29JJpueDe4ojJbn2eKwEJvo10IEGayKEV7DBwrt83JKTEFxsYaYdUNZz1z6EINAbWds31dAYp
	qXsc6Ouw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l74XQ-0000dw-SC; Tue, 02 Feb 2021 22:52:48 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l74XN-0000d3-M7
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 22:52:47 +0000
IronPort-SDR: pUwj8FbldMYWCWLO/nl5jJRwGlZvgZqEqtYL8ZIVkJqy7OKgddnQ0PWHAIxB5gPcrHX5yOvI5w
 v3s1f2kLbQ1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180172927"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="180172927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 14:52:40 -0800
IronPort-SDR: mwXlMUZsuCkzhDa+AvHpGyOD/vbTVLJXm12IxWxFb2jMP7Etv/XcFq7yTwo1G52wfNFLWyOGwn
 3mJRPSjdHGDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; d="scan'208";a="433104723"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 02 Feb 2021 14:52:38 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l74XG-0009jR-8F; Tue, 02 Feb 2021 22:52:38 +0000
Date: Wed, 03 Feb 2021 06:52:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 563c81586d0ab2841487a61fb34d6e9cd5efded7
Message-ID: <6019d7a3.aRcScetGqzreOAfa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_175245_920629_463B2932 
X-CRM114-Status: UNSURE (   9.64  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.12
branch HEAD: 563c81586d0ab2841487a61fb34d6e9cd5efded7  nvme-tcp: use cancel tagset helper for tear down

elapsed time: 727m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc               mpc834x_itxgp_defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
mips                           ip22_defconfig
powerpc                  mpc866_ads_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
arm                       multi_v4t_defconfig
c6x                        evmc6474_defconfig
m68k                          multi_defconfig
s390                             alldefconfig
arm                          exynos_defconfig
sh                              ul2_defconfig
powerpc                 mpc834x_mds_defconfig
s390                       zfcpdump_defconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
mips                      pistachio_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        cerfcube_defconfig
arm                         mv78xx0_defconfig
powerpc                    sam440ep_defconfig
arm                           omap1_defconfig
mips                       capcella_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
sh                           se7750_defconfig
sh                          rsk7264_defconfig
um                           x86_64_defconfig
arm                        realview_defconfig
mips                     cu1830-neo_defconfig
arm                             rpc_defconfig
sh                            shmin_defconfig
arm                          pxa910_defconfig
arm                           efm32_defconfig
nios2                         10m50_defconfig
c6x                              alldefconfig
sh                         ecovec24_defconfig
mips                      maltaaprp_defconfig
arm                     davinci_all_defconfig
arm                         axm55xx_defconfig
sparc                       sparc64_defconfig
powerpc                mpc7448_hpc2_defconfig
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
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
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
