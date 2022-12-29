Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98BCC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vlr5/s2ILpRKrCXisT3tzDNFaN3Ha18oz6phmQ5RyUU=; b=QXD/Fuo4DlRMdcfBw3xUVMlY6L
	RQxYDSC0qzXe3yzbuoo20yeaW351c33cFkBvTD8rxC6MvG4gQrH2Yp3TX4XVdVsWiyV5s5xqooJz7
	mrxBl8zzbxqmGNvm4v6n70pSEE20WxIulkHnpYLZAtCwRQWKe646jRZn5JkehhkZqnaw2XHNAxz1b
	cr4AdBQaNgM1dV9kTHVZZd3XeWuqChHygA8Cg9qTj8ZFlrRosklLvCL3yrypI8mYv9sO3AEb03sLs
	XgNs3iu/EL+lZn3NlnydBZeHoH/5ddDRxIpM1p8GDuTlSHvlqjQ2TirJuNH5pCde1VvD8q6pmqPlB
	VO3joZQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAmip-00Cwh4-Fw; Thu, 29 Dec 2022 06:48:59 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAmil-00Cwef-No
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 06:48:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672296535; x=1703832535;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=s3YsDuz5sPay8iWrRjQCsiXQo7MvK84ILHaRqDTQQxI=;
  b=Y7elvmSuoAOq55W6o00yw+KlsErNai8IdM83fwlUQ5X0mILPBVP7usK9
   Rw4AR+kOFXzARNl430Y/iXVV81WnFobu/bKDBNi4VXkp4fyVtko4jRsm1
   BLSUkHBC42L41zMLGmdxVlUpOpGbNYkJtbtwui/BU/aUem5e4VBJoBH5g
   H6i2xU8G44r0OoRsCKGA40aiXyGj6R5qolpwyFpFH/AF4XefjSalWQ22S
   pgNF3+/ISK9KZzCy1LVtraIhCYhHV3J0/7YX6cQ0SJXWxK28C+NDkyqa0
   nJdKSa5FKi2DclLpunYTgVK8lQuKwFeRXghvjj7wcYknitW1av+rSnDHz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="301358399"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="301358399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 22:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="827605102"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="827605102"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2022 22:48:50 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pAmig-000GMt-0B;
	Thu, 29 Dec 2022 06:48:50 +0000
Date: Thu, 29 Dec 2022 14:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 76807fcd73b818eb9f245ef1035aed34ecdd9813
Message-ID: <63ad3849.HWyhEgHU0CxxSEsr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_224855_884181_835A54E7 
X-CRM114-Status: UNSURE (   5.55  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-6.2
branch HEAD: 76807fcd73b818eb9f245ef1035aed34ecdd9813  nvme-auth: fix smatch warning complaints

elapsed time: 722m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
x86_64               randconfig-a012-20221226
s390                             allmodconfig
x86_64               randconfig-a014-20221226
alpha                               defconfig
x86_64                              defconfig
um                           x86_64_defconfig
x86_64               randconfig-a013-20221226
um                             i386_defconfig
x86_64               randconfig-a011-20221226
x86_64               randconfig-a016-20221226
x86_64                               rhel-8.3
x86_64               randconfig-a015-20221226
s390                                defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
i386                                defconfig
arm                                 defconfig
s390                             allyesconfig
i386                          randconfig-a003
mips                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           allyesconfig
i386                          randconfig-a005
i386                          randconfig-a016
powerpc                          allmodconfig
i386                          randconfig-a001
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig

clang tested configs:
x86_64               randconfig-a002-20221226
i386                          randconfig-a013
x86_64               randconfig-a003-20221226
i386                          randconfig-a002
x86_64               randconfig-a001-20221226
i386                          randconfig-a011
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015
x86_64               randconfig-a006-20221226
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
hexagon              randconfig-r045-20221226
hexagon              randconfig-r045-20221227
riscv                randconfig-r042-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

