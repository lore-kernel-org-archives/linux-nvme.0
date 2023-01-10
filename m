Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9F7C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IQgJeYZCbN3EsqJB/a+PNZHkO/c1/tsPX3Y5E/0AsqM=; b=C93WYA78ehJP1jo4WbwHednZmu
	ht8RQcLGJT05Q/BKBRyl0e1NgnBiKDxBdIpaVPUhRFulGcturINpF3THuXa7yCzqDFKdhTJLWtYTk
	ruYbCaNHhWuywrnBvZ8Kvv5s/fLYnlpRj6mkOqaCWcm2DBPzIMfVY5+VWEboh6wRVlAmeEioY7peE
	aMd8QeMPlocnCUuXL3fhyoC2GZboIN4aqDxeCwmsSfAbGAV9tvHEHbNMXwmcKgnMQFNiafdkWDCeD
	fcm8Udmhc13tBX+UEuW9SxJ/RcQuu7BpIvuYxsBI51Ui2kD81PSXP117MxBEEb4BTtkMQawyjvPDA
	/8aLrJIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFKiT-008O4Q-2R; Tue, 10 Jan 2023 19:55:25 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFKiP-008O10-91
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 19:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673380521; x=1704916521;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nPTFg5TjPYZqB9Y6DIxCdAQ3EVLD7RXEzQ0oGnnyCm8=;
  b=H5c1hb4bvUwYIIxcZkLjqQqUiRZrV+xatVEJB/mu3254bcBiQBahEVe3
   u+bp5BSyYE5PsmT7WwF80l4gM+9Wah9cMIVfPRkvA01clBXHU1nKQ89WN
   gd9iEOgyzcDRmv1pZYKBq957MvwQNd3kiUoYTl6hqa8EQV2Fj79M+OJmB
   Nb/8u8tL+9elWuNoHdWSLDnuQSa6oKQ4lzUve7c2sl2z+zfHDmOTGseLk
   vZfPfXR857kCtUe/mnRuyLMPjvkJGrSjuslqQ2CulX1HRbuK/QnDh/ySq
   oHmwlFMojn8mkULjNkxjQXaN95SFfpNZ7vltDY+UPjhXW++RxC8aDOzzg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303611772"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303611772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 11:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799559850"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799559850"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2023 11:55:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pFKiK-0008Jq-14;
	Tue, 10 Jan 2023 19:55:16 +0000
Date: Wed, 11 Jan 2023 03:54:33 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 c7c0644ead24c59cc5e0f2ff0ade89b21783614a
Message-ID: <63bdc279.YEhJvXn4b4pKabcH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_115521_365784_DE1CB357 
X-CRM114-Status: UNSURE (   7.98  )
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
branch HEAD: c7c0644ead24c59cc5e0f2ff0ade89b21783614a  MAINTAINERS: stop nvme matching for nvmem files

elapsed time: 723m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
i386                 randconfig-a011-20230109
um                             i386_defconfig
i386                 randconfig-a013-20230109
i386                          randconfig-a001
i386                 randconfig-a012-20230109
i386                          randconfig-a003
x86_64                              defconfig
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
x86_64                               rhel-8.3
i386                 randconfig-a015-20230109
i386                          randconfig-a005
arc                                 defconfig
i386                                defconfig
s390                             allmodconfig
x86_64                           allyesconfig
alpha                               defconfig
s390                                defconfig
x86_64               randconfig-a011-20230109
alpha                            allyesconfig
m68k                             allyesconfig
x86_64               randconfig-a013-20230109
m68k                             allmodconfig
s390                             allyesconfig
x86_64               randconfig-a012-20230109
arc                              allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64               randconfig-a014-20230109
x86_64                        randconfig-a002
x86_64               randconfig-a016-20230109
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64               randconfig-a015-20230109
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230108
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
arm64                            allyesconfig
arc                  randconfig-r043-20230108
sh                               allmodconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             alldefconfig
sh                             shx3_defconfig
arc                         haps_hs_defconfig
mips                      maltasmvp_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230108
hexagon              randconfig-r041-20230108
riscv                randconfig-r042-20230108
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001
x86_64               randconfig-a001-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a006-20230109
x86_64               randconfig-a005-20230109
x86_64                          rhel-8.3-rust
riscv                          rv32_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc44x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

