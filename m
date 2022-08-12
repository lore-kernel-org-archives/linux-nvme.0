Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE50C25B06
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HZ0MU0jEdgMmtqRpfq0TgWCFY7xWKJviEAr0XjReNco=; b=cSoZHjc2n5i4fpAf9k40jAEzrF
	aiShTmxzONDstOnFI9W8cmFp3QAPTqZdGno1l0z4VFOiBL1qnXtzED/waHg/CwuYvRuQWR8Kl2Kkw
	ycw5J6QJzbK4XyUA2WaLcAsgo0NC3GmE7i+S185LRG8YZBkOODxY9Ta+gU7f8Jvi75QnW5k75NDYZ
	Nn6/bP7JpjHY2lUuYSsQD/807ZwK4tIl4b4On4YulhOygP8Xol6MGaAQFU8Mv4TVvoz124GgzZ/26
	WPdVROw2XJKijDpBscGNA1fPTzoX1yoqb7iWADX5Kx69Yue9JcCnx5351M6CbLq3dBDXhymTOcYti
	mgUt+8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMIMc-0075FF-Et; Fri, 12 Aug 2022 00:17:22 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMIMZ-0075Ds-NQ
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 00:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660263439; x=1691799439;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/dx5eJzAQct0E478GQb2CN6IivhWcjYkp8yrU6UwDoA=;
  b=eR5IpGfJkp/bxIxsH+nhyvBR/iGLsEk/9Ek79IEaBfEabbNgVaBxtsKv
   4gK+utWflEUoNXYGZmSWjK+8N3jy+m8LpW4iJAruu7yhdVNhFmMhErY7l
   28bxcs3YH+SNXNbYpyCP5qWJQJZ3NNWVdnFT8Ul/a6VMaPYtbdzux6psL
   9LR4E79AOVlXEPQ0MubDmkturLm1s0crlfp5snwDbcAHGh/PgfBe0wWiI
   HLiteKLPTJ0D7+wQG2ejHS7shyt1iGRfUmuV60ojdClZgrkSNrCF2G6mH
   m0E8kIoU7VUq7qzKOH1everIaibQMFTJgg7gifZUYiayNU3XwVErl6EgQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="317457116"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="317457116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="581885322"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2022 17:17:15 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oMIMU-0000r9-26;
	Fri, 12 Aug 2022 00:17:14 +0000
Date: Fri, 12 Aug 2022 08:16:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.0] BUILD SUCCESS
 f37527a09dac324c74bb341c841096395a2f2566
Message-ID: <62f59bde.+gMTJB6W8EDF/ABJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_171719_808576_ED6A7F09 
X-CRM114-Status: UNSURE (   7.93  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.0
branch HEAD: f37527a09dac324c74bb341c841096395a2f2566  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70

elapsed time: 717m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220811
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                              defconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220811
riscv                randconfig-r042-20220811
hexagon              randconfig-r041-20220811
s390                 randconfig-r044-20220811
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

