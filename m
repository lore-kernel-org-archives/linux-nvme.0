Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91722C433E6
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 12:08:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA9B207DA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 12:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+1NjeOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA9B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6ULr0vxXDqICmveasZOJn4ZL3WYH5ogiLerpuqlsDxo=; b=R+1NjeOafq8lgkO473fmu4Nao4
	le+5FtpiFu3HnhxYNL06/nH1qt2Az2JE+TwUv8eWiVE7fjJPkOaf9eht4WE8NX8TvmxtrT2xHujo7
	zGt2tY9Y9QevLJvq9/Py34wQ9UFyu7Z1aj/vczcgSdleaUbdFhRrLm0VaTPEzV9NrJUH2DB4KYLUt
	lelKsbEa9Um9MTITB70L8wY07qmAB88tkiPMYaSw2lbZv6cx9mxXDverVmWUKYT8z1bBIy3fsNPwS
	HjUbf9frXnYOIeZcKseMV9HnnBFKGrQUEAcfNvXYLObFLCem3nQzvuCB8nYrSCsyAQ3vTFVV2ZDyx
	FeDUjHXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBzed-0004ff-Qz; Sat, 29 Aug 2020 12:08:19 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBzeY-0004fD-O3
 for linux-nvme@lists.infradead.org; Sat, 29 Aug 2020 12:08:16 +0000
IronPort-SDR: aetd174lJLoeVK9ZfOX9f1O70vxWYKLVKypxp1BgxRF6NL80B3wyXpE3VB3BOi4XpTc1MAgt+9
 wEPokoVewH9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="156799665"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; d="scan'208";a="156799665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2020 05:08:11 -0700
IronPort-SDR: hxzbGW8JtJSR3Axte8rHBuougK2pveLk649IFX+wUdnest/QPdCurB9yyVlp1gFPLsexg91dkD
 zb0f5lSjt5vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; d="scan'208";a="282638708"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2020 05:08:10 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kBzeT-0000TF-Q0; Sat, 29 Aug 2020 12:08:09 +0000
Date: Sat, 29 Aug 2020 20:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.9-rc] BUILD SUCCESS
 7ad92f656bddff4cf8f641e0e3b1acd4eb9644cb
Message-ID: <5f4a4511.xu31i+vdBphH5rL+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200829_080814_940404_1F418FB4 
X-CRM114-Status: GOOD (  11.06  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9-rc
branch HEAD: 7ad92f656bddff4cf8f641e0e3b1acd4eb9644cb  nvme-pci: cancel nvme device request before disabling

elapsed time: 723m

configs tested: 103
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                         cm_x300_defconfig
arc                        nsim_700_defconfig
m68k                             alldefconfig
mips                      malta_kvm_defconfig
sh                   secureedge5410_defconfig
microblaze                    nommu_defconfig
m68k                                defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
arm                          imote2_defconfig
sh                        edosk7760_defconfig
arm                        realview_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
arm                           viper_defconfig
arm                         hackkit_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
sh                              ul2_defconfig
arm                      jornada720_defconfig
powerpc                    adder875_defconfig
arm                        vexpress_defconfig
powerpc                     mpc83xx_defconfig
riscv                               defconfig
sh                           se7750_defconfig
mips                         bigsur_defconfig
arm                          badge4_defconfig
arm                        spear3xx_defconfig
arm                             pxa_defconfig
mips                 pnx8335_stb225_defconfig
sh                          sdk7780_defconfig
arm                          ixp4xx_defconfig
sh                   rts7751r2dplus_defconfig
arm                           sunxi_defconfig
arm                       mainstone_defconfig
mips                     decstation_defconfig
m68k                        stmark2_defconfig
sh                ecovec24-romimage_defconfig
m68k                          sun3x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
powerpc                             defconfig
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
x86_64               randconfig-a015-20200828
x86_64               randconfig-a012-20200828
x86_64               randconfig-a016-20200828
x86_64               randconfig-a014-20200828
x86_64               randconfig-a011-20200828
x86_64               randconfig-a013-20200828
i386                 randconfig-a013-20200828
i386                 randconfig-a012-20200828
i386                 randconfig-a011-20200828
i386                 randconfig-a016-20200828
i386                 randconfig-a014-20200828
i386                 randconfig-a015-20200828
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
