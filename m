Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79054C63704
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 20:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AzyLDvxcdqrUEvwuWl2EmfZ1MRD+N/xfy5/oHj0leA8=; b=07Md1yr6KinY1XDr+5f51pfQ5z
	VTG4uXBW60vl5GB6+gN6I8SiI5VafRMJZS1hmHVl/zEZ7kgCWfpMjKBSZBFyzWfj7Th9h+GgfHc26
	c7Q6ur/sbD4pVlweJkVLSgjKGYLiXR5n8Q5qRNBEB/itTAtUWoxafmIx65PGYh75vG2CNjxo1kpA1
	EzmDp5ZtZfm8RZ+zjUuMUferNAtONFuPlTy2EYwILX3ngMNN3BXJEdCuATU4PBGgMHB+a2oM3ShCA
	TJIXygQW1PeftB8laqNtE9Eq8znTLAFgZz+O1Mu0XC96NkwvNWBUV0pUvlkb4qlgCUbv44u3Yy2d3
	rtl+GC1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2euV-002Kjv-88; Tue, 06 Dec 2022 20:51:27 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2euT-002Khk-07
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 20:51:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670359884; x=1701895884;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ST4j2qHmsk/+z6wK/qPsm2J18p4LC9q+DhHbPQFMq2E=;
  b=gX0MA7y+Aewdht8vNf3c+CrXFLXxO1mQZ0FsU4wG9cmdSpv++tXUapNF
   Kb9YC2CkI1vtJFKct+AfFLnVDU8YwgJtRpOL9Fj/6UgmRMH2T8Abj4Zkd
   rGIJdVnvNAQeJgQS28Lc6hpccTpmUWDe1VGVXVty9UFbI2N5c/KsirsW7
   0BSPt/tSvzwqWxZinNgnIYDbQXuumbP+CwAuUEHpIWnp4sCKXkRF3fp/E
   12SvU/x7xMKA8NrnhIitDFyzKoQEVHdvwuT9QYpEFjFt4sjl2Q449DO9p
   RwFtyEIJ7dptwKqaInx7U23ul8XUNw0nIPOZELTw4cEbPmMVb+1YXUaOe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381021229"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="381021229"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 12:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648470306"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="648470306"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2022 12:51:19 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2euM-0001ET-1N;
	Tue, 06 Dec 2022 20:51:18 +0000
Date: Wed, 07 Dec 2022 04:50:22 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224
Message-ID: <638fab0e.Uhf+kiOC3ol8PtLx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_125125_149833_ECD9D587 
X-CRM114-Status: UNSURE (   5.36  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224  nvme initialize core quirks before calling nvme_init_subsystem

elapsed time: 728m

configs tested: 69
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a014-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
m68k                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
arm                                 defconfig
i386                 randconfig-a014-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a016-20221205
i386                 randconfig-a015-20221205
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                          rhel-8.3-rust
m68k                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a006-20221205
hexagon              randconfig-r045-20221206
x86_64               randconfig-a005-20221205
hexagon              randconfig-r041-20221206
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

