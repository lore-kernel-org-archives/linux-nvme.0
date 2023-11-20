Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F6C54FB9
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DcaDpP+zqkHwWxLy83dT1Fuar3zMKbAGO21SdMergZE=; b=pTjhqB3uv2mJEEGJr9gRAdBmIM
	ITPXekEkLorlDuPdz4FwpqkGwhlNRynm6c0ClDU9oZoxtYCQBiRpdoQv7EBC01A3pL9zvs66KvHH7
	/u50mPa11YHuK6vxMWbSB+3XS0+pqqk0+d0FnmUg8qief/FfqmKjy2JocCKDiqLxyzVKFDjGMA2hV
	LlyCyONW1i1raqCG7zvNSgpxJg/ZwPfjC4I/cayOloN6D1AbjLloImCd1i9TXNUG42+b+CaeHrKdw
	iuHGi39zHmbAt9WPpqdYdlaA2A9veB8mxdRYDx+amX/8noKTS98iAm3w2f4udMBcUgMfo+mkFF5Ns
	qzz5/dlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r4yPH-00BLBG-1u;
	Mon, 20 Nov 2023 07:09:19 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r4yPE-00BLAc-0T
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 07:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700464156; x=1732000156;
  h=date:from:to:cc:subject:message-id;
  bh=W46RdxMneugBQnEOibRdsXNX0hal1MwBbOsSfdcZTa0=;
  b=RpOhVnHHW8SJSamM7cSzYhgtVOzxE+sJ0z33VlxybjEP4ErGFOU+uYuD
   tqzTPRbtmTc5iTp/sLWPY0u7lWUPEU6b7t1U23KbVCAAc1bmHz7w6fNIx
   9LQCrWCSt29dWV7+7Bnr03kSiK4uSRC3XTFwmmP6CzT35nCwdp5W1Z7va
   oPxYfllzpMWSW5Zg8PbDHREImYPOn4FHfRidDvBNDbZFvzGPRyo0rI951
   x9VI/R/G+riRpGOF/tbIHiyCjzRFOVUj9e0VyBsvWlYiz8agRt+bx0OSG
   oEyeAd8xWWj5RvvLosWtZpCm6YnWx2vi+n1m6FWVGKHW3ajz3lcvbuY4D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458064853"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458064853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856906028"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856906028"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2023 23:09:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r4yP5-00068v-37;
	Mon, 20 Nov 2023 07:09:07 +0000
Date: Mon, 20 Nov 2023 15:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 c844de34c8351bfe7ae1fc1280a3fed1ff13932e
Message-ID: <202311201557.l28ocVcG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231119_230916_271962_1EA1AD6E 
X-CRM114-Status: UNSURE (   6.89  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.7
branch HEAD: c844de34c8351bfe7ae1fc1280a3fed1ff13932e  nvmet: nul-terminate the NQNs passed in the connect command

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-allyesconfig
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-buildonly-randconfig-004-20231118
|   `-- drivers-spi-spi-pic32-sqi.c:warning:pic32_sqi_of_ids-defined-but-not-used
|-- i386-buildonly-randconfig-006-20231118
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-002-20231118
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-004-20231118
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- i386-randconfig-015-20231118
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-016-20231118
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
`-- x86_64-defconfig
    `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size

elapsed time: 3730m

configs tested: 298
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-001-20231119   gcc  
arc                   randconfig-002-20231118   gcc  
arc                   randconfig-002-20231119   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-001-20231119   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-002-20231119   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-003-20231119   gcc  
arm                   randconfig-004-20231118   gcc  
arm                   randconfig-004-20231119   gcc  
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-001-20231119   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-002-20231119   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-003-20231119   gcc  
arm64                 randconfig-004-20231118   gcc  
arm64                 randconfig-004-20231119   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-001-20231119   gcc  
csky                  randconfig-002-20231118   gcc  
csky                  randconfig-002-20231119   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-001-20231119   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-002-20231119   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-003-20231119   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-004-20231119   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-005-20231119   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386         buildonly-randconfig-006-20231119   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-001-20231119   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-002-20231119   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-003-20231119   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-004-20231119   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-005-20231119   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-006-20231119   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-011-20231119   clang
i386                  randconfig-011-20231119   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-012-20231119   clang
i386                  randconfig-012-20231119   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-013-20231119   clang
i386                  randconfig-013-20231119   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-014-20231119   clang
i386                  randconfig-014-20231119   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-015-20231119   clang
i386                  randconfig-015-20231119   gcc  
i386                  randconfig-016-20231118   gcc  
i386                  randconfig-016-20231119   clang
i386                  randconfig-016-20231119   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-001-20231119   gcc  
loongarch             randconfig-002-20231118   gcc  
loongarch             randconfig-002-20231119   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm63xx_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-001-20231119   gcc  
nios2                 randconfig-002-20231118   gcc  
nios2                 randconfig-002-20231119   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-001-20231119   gcc  
parisc                randconfig-002-20231118   gcc  
parisc                randconfig-002-20231119   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-001-20231119   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-002-20231119   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc               randconfig-003-20231119   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-001-20231119   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-002-20231119   gcc  
powerpc64             randconfig-003-20231118   gcc  
powerpc64             randconfig-003-20231119   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-001-20231119   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                 randconfig-002-20231119   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-001-20231119   gcc  
s390                  randconfig-002-20231118   gcc  
s390                  randconfig-002-20231119   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-001-20231119   gcc  
sh                    randconfig-002-20231118   gcc  
sh                    randconfig-002-20231119   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-001-20231119   gcc  
sparc64               randconfig-002-20231118   gcc  
sparc64               randconfig-002-20231119   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-001-20231119   gcc  
um                    randconfig-002-20231118   gcc  
um                    randconfig-002-20231119   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-001-20231119   gcc  
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-002-20231119   gcc  
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-003-20231119   gcc  
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-004-20231119   gcc  
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-005-20231119   gcc  
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64       buildonly-randconfig-006-20231119   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-001-20231119   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-002-20231119   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-003-20231119   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-004-20231119   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-005-20231119   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-006-20231119   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-011-20231119   gcc  
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-012-20231119   gcc  
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-013-20231119   gcc  
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-014-20231119   gcc  
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-015-20231119   gcc  
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-016-20231119   gcc  
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-071-20231119   gcc  
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-072-20231119   gcc  
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-073-20231119   gcc  
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-074-20231119   gcc  
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-075-20231119   gcc  
x86_64                randconfig-076-20231118   gcc  
x86_64                randconfig-076-20231119   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-001-20231119   gcc  
xtensa                randconfig-002-20231118   gcc  
xtensa                randconfig-002-20231119   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

