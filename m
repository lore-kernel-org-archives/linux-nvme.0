Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349EFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jun 2022 02:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cfSO/K0bu3ksmm7qJkxHQfF/pIP+QvmTCWP/Eq9tlmM=; b=30nZrBHgcPb1fQQgR4eLJ1c+tL
	lgpCHdwY68lNvmjRB4Denl9ijhItTiPiTWsDE/bsRXiapc8MM8FWcmKD1vqIxSgRWgNrac89+kDt9
	vP4IwzdagAiTzeAEFsbaHA5uMvXlsR1Pr2sfko2JQX/03ShdpVq+xgc7Mcq1zLnPRp1mHP1NorlGs
	x5udgXxeIIngjW2+3x/vDzfRsiVOqE7uK1l4Gdk99Srvmn7K0GgM/LG0QSssocNPJrzE8Q1J51+Yz
	xUTDTvwfzTcrZhcS2Ly0HiCJeE3RLT/FFYAZPYEpqTbldTdTBjlJ109UkPKb+JNxT/xZSQCANA2aP
	esZ/WctA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4YwX-00HQv3-6j; Fri, 24 Jun 2022 02:21:09 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4YwU-00HQuZ-H4
	for linux-nvme@lists.infradead.org; Fri, 24 Jun 2022 02:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656037266; x=1687573266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y9o9bluW4J+Z3Ja5cCrZ/D6DL/bNevL4jnXlupzFMf4=;
  b=KBCe/Y552axIPYOX6XkpHPbhkAFVX9kGZAKhUbsbfW2oYeFB7hHz5d7a
   FQsbPRT6Na3njikfmk1swhmFC/lE7GbuuBq9/TNhvIHSnjvWFw2YktTG9
   ulyXwK8a6RYXLJTT71PV+Fn2LLwKA6XZF3J6EjzEEwn8inFsTOYECk5GK
   zoWyj2kGs9pVq76wjWZgVURr+gkWMPFo+99B96nTCPUWeR/dC/Swq1g60
   5LYG/eS/MB8xZLCzy9qj55vxPcEW477RT3saquire3JET04a5VEnOGA+e
   clwxhPj3Hs8eJVbFsSR8mjehigkzi2PTeAQ+FGFxQTavqqxJRiOfBbWud
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342587706"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="342587706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="588859859"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2022 19:18:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o4YuO-0003WM-O0;
	Fri, 24 Jun 2022 02:18:56 +0000
Date: Fri, 24 Jun 2022 10:18:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 e6487833182a8a0187f0292aca542fc163ccd03e
Message-ID: <62b51ee1.O5jx9Gz93f1qV3qb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_192106_759175_E9030246 
X-CRM114-Status: UNSURE (   7.41  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: e6487833182a8a0187f0292aca542fc163ccd03e  nvme: move the Samsung X5 quirk entry to the core quirks

elapsed time: 728m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                  sh7785lcr_32bit_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
nios2                         3c120_defconfig
sh                        sh7757lcr_defconfig
arm                          pxa3xx_defconfig
powerpc                   currituck_defconfig
arm                      jornada720_defconfig
arm                             pxa_defconfig
arm                         s3c6400_defconfig
m68k                        m5272c3_defconfig
powerpc                         wii_defconfig
riscv             nommu_k210_sdcard_defconfig
parisc64                         alldefconfig
mips                      maltasmvp_defconfig
openrisc                  or1klitex_defconfig
arc                           tb10x_defconfig
sh                         ap325rxa_defconfig
arm                          lpd270_defconfig
s390                             allmodconfig
arc                          axs103_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
arm                      footbridge_defconfig
sparc                       sparc64_defconfig
sh                          rsk7269_defconfig
openrisc                 simple_smp_defconfig
ia64                             allmodconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220622
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r041-20220623
hexagon              randconfig-r045-20220623

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

