Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4AC4363D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 16:41:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B69B206BE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9CouAhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B69B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Hlj7G5TzLgE6Cqk8lkeEiwgCHilsaqVnCAa84+0xAo=; b=b9CouAhuJHEakx5vZCYGOdOysC
	FaTQfe88FWzt8XUV04q0mjkOLPRHLJYeQlUiq44Qcpyz5e6IV6E4vt8FK+/uuBEAbtEV6MA00OX9e
	xQX9E6DwjDo+tAehckXLr8od+KHjRio3IOa4N0/hGOnoVl52lZzk2KBoGzZuCm13zK746ElibRQFZ
	mbtvN3rULWSY2t9Uqp29S4JqfZ0KngS9YX/j3fi2lgTNqU7/lRW8kescOxutlkSENSlnNglTxMzVJ
	hcwRHcNg9T0rbwOt9yU4NdTAoAHkwmoeA/WWbIquhh4VL56Bgy2+QKr8lt9zLr3RcC8u4ghOW4rSF
	iQFjcGDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLqnA-0004vT-5P; Fri, 25 Sep 2020 16:41:52 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLqn7-0004v5-HH
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 16:41:50 +0000
IronPort-SDR: 78K/9V2kJPCBiuV7RV6GrkoJD7vx5FIMcG8RhXZ+kN4wll2jLXdnmSdWKfq8XlfQjAt2ths6Bp
 C0f4SAT3LiDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158936239"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="158936239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 09:41:43 -0700
IronPort-SDR: qzctZbkqdwiVn9NUnPyROsppZ5/qwD5OxFTtQkjQyoSUpuYV5NvWzYtaIMs1pOpxYqcTw7PFgO
 v5vKDkJSRyOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="349826613"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 25 Sep 2020 09:41:38 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kLqmv-0000Bm-1Z; Fri, 25 Sep 2020 16:41:37 +0000
Date: Sat, 26 Sep 2020 00:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 e865ff4810943111a25f8891d6ebac390cc57b93
Message-ID: <5f6e1dab./953RSatPdHs1kOb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_124149_720469_2189C517 
X-CRM114-Status: GOOD (  12.96  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: e865ff4810943111a25f8891d6ebac390cc57b93  nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue

elapsed time: 721m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
riscv                    nommu_k210_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           efm32_defconfig
powerpc                     akebono_defconfig
sh                         apsh4a3a_defconfig
sh                           se7712_defconfig
sh                        sh7757lcr_defconfig
sh                      rts7751r2d1_defconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
arm                           sunxi_defconfig
arm                          imote2_defconfig
c6x                                 defconfig
ia64                        generic_defconfig
ia64                      gensparse_defconfig
sh                           se7721_defconfig
mips                         bigsur_defconfig
mips                     loongson1c_defconfig
m68k                       m5275evb_defconfig
powerpc                         ps3_defconfig
sh                           se7705_defconfig
powerpc                    klondike_defconfig
ia64                             alldefconfig
mips                           ip22_defconfig
arm                        spear3xx_defconfig
mips                           mtx1_defconfig
m68k                          atari_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
