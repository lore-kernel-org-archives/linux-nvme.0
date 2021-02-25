Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 05:06:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB7D64EC8
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 05:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB7D64EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NIgFqZPB8qQrceB8fFxz/cX4Ni5k1oJQ0k4v/MmIeZw=; b=EXkhLIdAfSkOMGKPorv6ROSMMO
	Qc30y++MYLUxZN1j8eMd+Vmd5J/DrUGshs+kplIkdQOibDVim3ZtqFVyTiSpl27rYISfH33ZhLcyZ
	q7/sXlGWpQj7zddhOI4CxnfuK/cdthVdgINoUbaBJgh3JGLqWxOur+8IkwHwNmGtrvig91PpOkc4S
	VoqDuRxxfTgB3/KExKOrMgMk3W5pGzx66PK5OyFn7Rmio9YAaNRe48UM2smub2xmAD1GDa5QNvBIl
	7Oo5B0gpOzGpnyl1cVWp0n0EgHqCLV9zbUmprVULewqlKQCDNCx/+GQRzvB3QOUmPDKFEkMqbViHO
	pVXWFQ+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF8r4-0003kQ-LO; Thu, 25 Feb 2021 05:06:26 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF8qz-0003jj-RZ
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 05:06:23 +0000
IronPort-SDR: NZy16iPBbtVKtnbsEHMWhFk9Trno4sClMYlUPL0Slt0ptTdXJTyKu0PVtXf5Ew42ocgVVV5qFv
 d6MJC9J4wYFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="182950099"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; d="scan'208";a="182950099"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 21:06:13 -0800
IronPort-SDR: nHtJHnfnfj8AJtKWVnsYaaYQKsGGoceASp0RsOun1VcoSGgye7hIRe03OCT2wJL3JeojHLDDVj
 DA+0naIC6gKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; d="scan'208";a="593924823"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2021 21:06:12 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lF8qp-0002VZ-WE; Thu, 25 Feb 2021 05:06:12 +0000
Date: Thu, 25 Feb 2021 13:05:20 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 e41e43a0a4c03b165cd975dbec806fe68dfc9c2b
Message-ID: <60373010.I1MCSECZqTL92FEA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_000622_057965_1145E3F5 
X-CRM114-Status: UNSURE (   8.59  )
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
branch HEAD: e41e43a0a4c03b165cd975dbec806fe68dfc9c2b  nvmet: allow setting model_number only once

elapsed time: 728m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm5200_defconfig
mips                         db1xxx_defconfig
arm                          pcm027_defconfig
ia64                            zx1_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         s3c6400_defconfig
arm                        magician_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
arc                        nsim_700_defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
nios2                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
arm                           corgi_defconfig
mips                           ip27_defconfig
arm                           u8500_defconfig
mips                        jmr3927_defconfig
powerpc                      acadia_defconfig
mips                  decstation_64_defconfig
powerpc                      pasemi_defconfig
arm                         vf610m4_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
m68k                       m5475evb_defconfig
arm                           sama5_defconfig
nios2                               defconfig
mips                            ar7_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
sh                               allmodconfig
parisc                generic-64bit_defconfig
arm                           tegra_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                    ge_imp3a_defconfig
arm                             mxs_defconfig
arm                            mmp2_defconfig
arm                          lpd270_defconfig
mips                           ci20_defconfig
mips                          rm200_defconfig
m68k                       m5275evb_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
powerpc                      tqm8xx_defconfig
mips                     cu1830-neo_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
mips                           ip32_defconfig
mips                           ip28_defconfig
arc                        vdk_hs38_defconfig
mips                         tb0219_defconfig
arm                        realview_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
