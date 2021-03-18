Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40458C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:18:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0DE64F1D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0DE64F1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b7yWio1LQl+wzlJWPTbKxOM8se2VroV85tajAlOK2+4=; b=QVCIw/JICff4tkPnyQkuLNNI4G
	Ps9+qnMkn33BP/ySY7ItofgZ13uTZDacyS7krZPvgH2qBg5Q230jT0uHa24HvnlSXn89MI7RakCau
	tPlUIkvQXHZ1lXX5c33xr7A3PB6lYwoq5o8ePDCNvl6KKr9xv009sYblJaAu8WjE8eEup52z9tkTM
	bJfKtnOD4N2okIYI0rPzOQc6Yml8zDGL+6Z6aummLFqGcji25bXI97/XAn0IIy7eCsCQh/dpGtrae
	cgzQ49cKdGr5q+nyf+mHr4dJkv1bLNOF5XLClXSJ7mlVXvgkCv/15YO5YgkG1kbLsyYe7UBRjEeI5
	52Emaeew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxDZ-005pkN-Fj; Thu, 18 Mar 2021 18:17:57 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxDV-005piq-Fi
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:17:56 +0000
IronPort-SDR: wuaS3yCP+cFKtDJQeSvH+EFrce1+4dtN+LipTLDIFcDjR560fs71IS9Aj3vjVN5vTao0b875lo
 eYeVxnqYeaCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="187385647"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="187385647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 11:17:47 -0700
IronPort-SDR: wOqwP2sjzkbrvGSCqpcnsB3pwjvKsXs3GGIBCiHJnFnAvzTeC6prCVAsXDpskFEh8Joq13abQq
 v2UT1+7/Pa6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="512228730"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2021 11:17:46 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lMxDO-0001Mh-0Z; Thu, 18 Mar 2021 18:17:46 +0000
Date: Fri, 19 Mar 2021 02:17:17 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 24e238c9218621e1beb648f781001a784b10b79d
Message-ID: <6053992d.L6mOfq6pa7TeLNqG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_181753_929159_C051FAE0 
X-CRM114-Status: UNSURE (   7.45  )
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
branch HEAD: 24e238c9218621e1beb648f781001a784b10b79d  nvme: warn of unhandled effects only once

elapsed time: 723m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       omap2plus_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
powerpc                      pcm030_defconfig
powerpc                     taishan_defconfig
arm                       cns3420vb_defconfig
mips                        jmr3927_defconfig
powerpc                     sbc8548_defconfig
arm                        magician_defconfig
mips                         tb0226_defconfig
arm                          moxart_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
sh                            migor_defconfig
riscv                          rv32_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
powerpc                   lite5200b_defconfig
csky                             alldefconfig
powerpc                      acadia_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
powerpc                  mpc866_ads_defconfig
s390                             allyesconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
arm                        multi_v7_defconfig
arm                            mmp2_defconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
mips                        vocore2_defconfig
mips                           ci20_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
powerpc                      ppc64e_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
