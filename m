Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B065CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 19:33:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898A613B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 19:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898A613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UV3Bwd+Ob+QGF4trIELcMALxo2sCLGw2hwWii8Wxn14=; b=XLa5n/V6hXlqyzJmhZBxpHO/5/
	NwjSOw/1l+AHH35BrvTIM7cHE37Ljf94x+OMiMJ3yLM5zXJqDIsCJzZ5oOZAndx99LBzxjQoE/Byx
	aLbTt0m5k3FtIDM+IwXsVHUnAT/8oTVP2KZimdo4BxXjPi/Oe8h/b0OUJuzRaj50eNQ63qgjwnI12
	pg06COW6O5lml5QMIR/7K8E7T/TBDpNYSMVN5dgwY/VdDOKteBUpqQoNGhaAzgrucuRa0FnZfbvgZ
	E+oMAxXFWkIpWgD+EQjyFNzuw28GKep7u5Mc/KIbl0wd65jXbsQju2OppU69HeWVC4/F9a/oc/gZl
	TakhE/fw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbpvn-0049sZ-Bu; Wed, 28 Apr 2021 19:33:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbpvj-0049sL-VD
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 19:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=9jo5hGq/MHvhGcTgxFAKntfOLmCyfTM8kPhL7FbUHZk=; b=bqNuZeqjfBlBs+FIjEfK+jomWV
 qyeusoLDQV8Iimsb6b2suVRei8GPXEmn7rt+Q1/HUx9JVG96TM1Yz7TpwPGuid0DFTs1JPCEGR1aR
 wCgmYDHMDkn6r4ds5qtjWH1CP7z0POEsJRQlFDdZvd1wNnv9doMiLjgfxm4E1/zL/TBr3JgPCKAkv
 37cHiAxYah24KQglWIL9o02L/3FkKsBAo7El/CWTc3Loh/3h8nAFK/7vqPwexIGPw14EwN1yqGW/M
 092y/DxbkEojp6NCv4gwNuPyTFa9JdDqT7NcjmyQ9EDwAva1ygmYkN1AOGXyhb+guF13qlEL6tLpK
 RO1hPJMA==;
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbpvh-0008rH-7Q
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 19:33:02 +0000
IronPort-SDR: aLMVzHX+rHcbjA8aSZ8UvkIhW7o9tsDPzsnzaU2/55UN/LNudPfUa4caWkDkNth5Ksxte/m/HE
 TxkbagwkNdbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="260786628"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; d="scan'208";a="260786628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2021 12:32:59 -0700
IronPort-SDR: D0fcYZgPLB8hn7k9mXlxmF7z/gfplq1et0q4EVHG5yrzVBq5XYXaGuTlbXsHx8Lm0yXYzpfA4X
 CVLI1OGTazZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; d="scan'208";a="526634041"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2021 12:32:57 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lbpvd-0007Gs-80; Wed, 28 Apr 2021 19:32:57 +0000
Date: Thu, 29 Apr 2021 03:32:37 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 db56feef0e698dfe2b43776d00965b7a8e94942b
Message-ID: <6089b855.w9hdrApYGva7GOkV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_123301_342501_89E75D89 
X-CRM114-Status: UNSURE (   6.95  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.13
branch HEAD: db56feef0e698dfe2b43776d00965b7a8e94942b  nvme-pci: fix controller reset hang when racing with nvme_timeout

elapsed time: 721m

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
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         cm_x300_defconfig
m68k                       m5208evb_defconfig
sh                           se7712_defconfig
powerpc64                        alldefconfig
riscv                          rv32_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
mips                           mtx1_defconfig
arm                       netwinder_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
h8300                            allyesconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
powerpc                      pcm030_defconfig
arm                     eseries_pxa_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
mips                       lemote2f_defconfig
arm                           corgi_defconfig
powerpc                    socrates_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7619_defconfig
i386                             alldefconfig
mips                           ip27_defconfig
powerpc                      mgcoge_defconfig
mips                  maltasmvp_eva_defconfig
arm                       omap2plus_defconfig
mips                        jmr3927_defconfig
arm                      pxa255-idp_defconfig
mips                         bigsur_defconfig
powerpc                 mpc8560_ads_defconfig
mips                       capcella_defconfig
arm                         s5pv210_defconfig
powerpc                        warp_defconfig
um                               alldefconfig
arm                    vt8500_v6_v7_defconfig
m68k                             alldefconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         nhk8815_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
