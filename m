Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D5C48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCBD613CB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCBD613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GbJQTf1ywNBRj9KlNkshcj3YjiLW0vrTzIIJZTPE2Lk=; b=S6R2qqZ0MRjz79
	5PWy1lNi8jBvfRvORMUJPShXhAEtCXLIk3kFK79pvW9yHafmjG55SIds/Kmf4SRurYswhf+dEkYD9
	h8H4DfVl5WaIHYviNQ3tkrBoztJyqjy1fW1uaZ+AAROp8hoerACqvSGKrFL12jlNa+PWVK/+7SfY8
	ww5MS5W7qxgnZgIfGHSraNC232B36wllqIbG5VWAGNGGNaet2YNR2tKrWpc0fxEhDSVMxg9LIYtVh
	MJCHY0PIKWPJ06TDllRvx0Lg9yk/oeyn//nxIOVmfvwW9rhB0yGhCkE8oGAoGbZZZka0Adv4Lsjad
	PXoUcMsI/pXJeqcOnFPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9Fg-00GF8V-1t; Thu, 10 Jun 2021 01:12:56 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9Fd-00GF7x-AG
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:12:54 +0000
IronPort-SDR: XOdyOokP5BFrJIBvy9nX9X3BfnxG1p0mRF8U2CCh6F+L/XvCFVMDZa6w1t8LpK6QlUBA9e+TJb
 wsAEBwWQzuMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="203352915"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="203352915"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:12:51 -0700
IronPort-SDR: +jWZ28UTLW5NOIlGFptMIDG8fFrArC0rG2l+zPs1FjPYc/iLuxm7MsFl2mKuu7/JI5GmqEdk/e
 ESlHnFhr42kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="635596999"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2021 18:12:50 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lr9FZ-0009n1-Nx; Thu, 10 Jun 2021 01:12:49 +0000
Date: Thu, 10 Jun 2021 09:12:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.14] BUILD SUCCESS
 b2350195c4b764679e78f262e67378f148676002
Message-ID: <60c16710.0LWKqd3cqeX8v4nW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_181253_406127_C2A52F9E 
X-CRM114-Status: UNSURE (   6.28  )
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
branch HEAD: b2350195c4b764679e78f262e67378f148676002  nvme-pci: remove trailing lines for helpers

elapsed time: 725m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
sh                         microdev_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                        workpad_defconfig
powerpc                      mgcoge_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
microblaze                          defconfig
powerpc                     mpc5200_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
sh                        edosk7760_defconfig
s390                             allyesconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
powerpc                      pmac32_defconfig
x86_64                            allnoconfig
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
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
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
um                           x86_64_defconfig
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
