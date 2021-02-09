Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E39C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 20:09:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9082B64E9C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 20:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9082B64E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jul+8qxAXNA6d2MIz4XjuzR9oXqFhqXFkJ7bEUJkeVg=; b=XUi7uxslHvK25ikQ628HLKMIV+
	jVIRHvMZO9Y+swbbUigaoLSuBxcDvnpi0a7CkJ5OlwTREQUHyW/OeHBqVv6DrlTNvHutYxIgbf3ud
	u7t/ijkWh3QVRFGXoD68AWc9rZcnfoqP/sMSDpys8T1/V8hOuBTB3oD5xFY9b1uVLYLFBM7CSB3XW
	Webneuo/Po8IGaSWBHfMLNTbOSrCb20R3mdetK10Jg7ixU3sufKRorQhO0fq6NodBP2+fWYoW+Bg5
	ZjTMKE7spDyCp2NA6YXiNBpU18zCQWuS+Zay/hNLSbn/OL28bpb86gBky8UFYdIrBf5NqJ30SdPga
	v1XEWtYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9ZJy-0002ZX-Qt; Tue, 09 Feb 2021 20:09:14 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9ZJt-0002XL-LD
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 20:09:12 +0000
IronPort-SDR: 9zCSGIZIiRCfAogoPYJH1EEqHw1wQCC3QFAAbFmYKfA92Xy0s3Q0BHt9tIXXsAEHN3bEYIFZH0
 L9TcHHdIZzzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169076548"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; d="scan'208";a="169076548"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 12:09:03 -0800
IronPort-SDR: l19uJOWa7Nod4IGdZstuXblwmjoeKJ0rPs1rTfEOko07rVTh/3WjMNO+6xL1qmdEl6U0Q9Iy8j
 m1xtxiTVRJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; d="scan'208";a="419697612"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2021 12:09:00 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l9ZJk-0002HQ-9O; Tue, 09 Feb 2021 20:09:00 +0000
Date: Wed, 10 Feb 2021 04:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 bef623436fdc53642f45a48f54f38e0f78d62e9c
Message-ID: <6022ebaf.uJ9qwtiYMmBKshbj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_150909_842064_87B0FD3C 
X-CRM114-Status: GOOD (  10.84  )
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
branch HEAD: bef623436fdc53642f45a48f54f38e0f78d62e9c  nvmet-fc: add a missing __rcu annotation to nvmet_fc_tgt_assoc.queues

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
m68k                       m5208evb_defconfig
sh                        edosk7760_defconfig
sparc                            alldefconfig
arm                         palmz72_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      ep88xc_defconfig
arm                              zx_defconfig
x86_64                           alldefconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                   motionpro_defconfig
mips                     cu1000-neo_defconfig
csky                             alldefconfig
sh                             sh03_defconfig
mips                           rs90_defconfig
sparc64                             defconfig
sh                             shx3_defconfig
powerpc                     ksi8560_defconfig
powerpc                         ps3_defconfig
sh                        apsh4ad0a_defconfig
sh                        sh7785lcr_defconfig
mips                        vocore2_defconfig
mips                     cu1830-neo_defconfig
arm                        mini2440_defconfig
arm                          ep93xx_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
powerpc                    amigaone_defconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
um                           x86_64_defconfig
m68k                       m5249evb_defconfig
arm                        realview_defconfig
csky                                defconfig
powerpc                         wii_defconfig
riscv                    nommu_k210_defconfig
mips                          rm200_defconfig
arm                       aspeed_g5_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5475evb_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
arm                          badge4_defconfig
arc                            hsdk_defconfig
arm                           omap1_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
