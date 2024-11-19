Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0001D4415F
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BXABVf5XgW3JKbp4CMcEzub0OYizs7ZgvlHTZjYNmUQ=; b=ffxsKKhr+ddo/Ryem29t5wxEuR
	NHjgwyN/vDxyVWy5IdcpHvwtPkvVvUpFgFRZGGNS7M70H9jBCuYFoe6pgzrZoAW3AhWZkkmw4iD76
	bAA8q5VOVxJFEuLyO0d1BjG2zUStap64OA72Fe1hL+Z1s5POD1I1tXzaDhzcH4Rh+7gLzOW/QcN9F
	GIVga7w2zNlIG1mmsX5YA5nXSeuU6AygpPySK2V0KkMPu8CfiQMWgwlalpJTt80BmwZJx43fCirt1
	9dCoHp7jDyPgozIPSSGEK0CHiCzpYAAa4QdDnyf+MvgvdDkQ08VjBU9Otw4AI42MJVpLG4x5hXB8t
	Q+OnsCNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDORG-0000000CXZb-1Vvz;
	Tue, 19 Nov 2024 13:38:42 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDOQX-0000000CXMJ-0oeO
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 13:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732023477; x=1763559477;
  h=date:from:to:cc:subject:message-id;
  bh=V0OeZYWOhj9ekLH5zDYr4SvwTkEe2w1HtFVBknWnzoM=;
  b=efUw6zgL4aO81/64KhTwjoH7ax7OUlO9c8/ziS8mab5862eU2m/chPtQ
   KmOo1OoJnJmRYRiysYx9Kz0xQROS2FhqSSKi4tWNHh/UR6J6X7WBVUl1b
   s2wEk2miyrF/phCaAIopoQr9tiBPR3I63A6hIxzxYQvyxDV7ukvXw5A+L
   kXALDwT9Q/sXiFDVCRTtF5oKVkcvcaFJKmtrbcCYhIMCpapVcYojHoEZk
   K6/XSSh0HoYDjkfLD/ZDeg1fxq5RlkoKtM/Uo3dIdS3oBkGRPUzLKw0/f
   NyZyf2P0LJQD6aVEZexJpl4JSPJNQXfEAKCZOrBmO40B9w4SJ/4aLvtat
   Q==;
X-CSE-ConnectionGUID: sh4Hm7EtQXuT8cv4rvlxMQ==
X-CSE-MsgGUID: S6bIv3LsTEKasO9xEWqu7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43424370"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43424370"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:37:54 -0800
X-CSE-ConnectionGUID: ArRBscY1RH2eyLlQwt+szw==
X-CSE-MsgGUID: SxY4bBiaReGB65ALmKANtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94010163"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Nov 2024 05:37:52 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDOQQ-00007m-2a;
	Tue, 19 Nov 2024 13:37:50 +0000
Date: Tue, 19 Nov 2024 20:32:08 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 6fad84a4d624c300d03ebba457cc641765050c43
Message-ID: <202411192058.f8Qz9kIk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_053757_252487_FD804096 
X-CRM114-Status: UNSURE (   5.74  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: 6fad84a4d624c300d03ebba457cc641765050c43  nvme-pci: use sgls for all user requests if possible

elapsed time: 1076m

configs tested: 193
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241119    gcc-14.2.0
arc                   randconfig-002-20241119    gcc-14.2.0
arc                        vdk_hs38_defconfig    clang-20
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                        keystone_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                          pxa910_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241119    gcc-14.2.0
arm                   randconfig-002-20241119    gcc-14.2.0
arm                   randconfig-003-20241119    gcc-14.2.0
arm                   randconfig-004-20241119    gcc-14.2.0
arm                             rpc_defconfig    clang-20
arm                       spear13xx_defconfig    clang-20
arm                        spear6xx_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241119    gcc-14.2.0
arm64                 randconfig-002-20241119    gcc-14.2.0
arm64                 randconfig-003-20241119    gcc-14.2.0
arm64                 randconfig-004-20241119    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241119    gcc-14.2.0
csky                  randconfig-002-20241119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241119    gcc-14.2.0
hexagon               randconfig-002-20241119    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241119    clang-19
i386        buildonly-randconfig-002-20241119    clang-19
i386        buildonly-randconfig-003-20241119    clang-19
i386        buildonly-randconfig-004-20241119    clang-19
i386        buildonly-randconfig-005-20241119    clang-19
i386        buildonly-randconfig-006-20241119    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241119    clang-19
i386                  randconfig-002-20241119    clang-19
i386                  randconfig-003-20241119    clang-19
i386                  randconfig-004-20241119    clang-19
i386                  randconfig-005-20241119    clang-19
i386                  randconfig-006-20241119    clang-19
i386                  randconfig-011-20241119    clang-19
i386                  randconfig-012-20241119    clang-19
i386                  randconfig-013-20241119    clang-19
i386                  randconfig-014-20241119    clang-19
i386                  randconfig-015-20241119    clang-19
i386                  randconfig-016-20241119    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241119    gcc-14.2.0
loongarch             randconfig-002-20241119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    clang-20
m68k                       m5249evb_defconfig    clang-20
m68k                        m5307c3_defconfig    clang-20
m68k                            mac_defconfig    clang-20
m68k                            q40_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                       rbtx49xx_defconfig    clang-20
mips                           xway_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241119    gcc-14.2.0
nios2                 randconfig-002-20241119    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241119    gcc-14.2.0
parisc                randconfig-002-20241119    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20241119    gcc-14.2.0
powerpc               randconfig-002-20241119    gcc-14.2.0
powerpc               randconfig-003-20241119    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241119    gcc-14.2.0
powerpc64             randconfig-002-20241119    gcc-14.2.0
powerpc64             randconfig-003-20241119    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                 randconfig-001-20241119    gcc-14.2.0
riscv                 randconfig-002-20241119    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241119    gcc-14.2.0
s390                  randconfig-002-20241119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    clang-20
sh                    randconfig-001-20241119    gcc-14.2.0
sh                    randconfig-002-20241119    gcc-14.2.0
sh                           se7722_defconfig    clang-20
sh                        sh7763rdp_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241119    gcc-14.2.0
sparc64               randconfig-002-20241119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241119    gcc-14.2.0
um                    randconfig-002-20241119    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241119    gcc-12
x86_64      buildonly-randconfig-002-20241119    gcc-12
x86_64      buildonly-randconfig-003-20241119    gcc-12
x86_64      buildonly-randconfig-004-20241119    gcc-12
x86_64      buildonly-randconfig-005-20241119    gcc-12
x86_64      buildonly-randconfig-006-20241119    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241119    gcc-12
x86_64                randconfig-002-20241119    gcc-12
x86_64                randconfig-003-20241119    gcc-12
x86_64                randconfig-004-20241119    gcc-12
x86_64                randconfig-005-20241119    gcc-12
x86_64                randconfig-006-20241119    gcc-12
x86_64                randconfig-011-20241119    gcc-12
x86_64                randconfig-012-20241119    gcc-12
x86_64                randconfig-013-20241119    gcc-12
x86_64                randconfig-014-20241119    gcc-12
x86_64                randconfig-015-20241119    gcc-12
x86_64                randconfig-016-20241119    gcc-12
x86_64                randconfig-071-20241119    gcc-12
x86_64                randconfig-072-20241119    gcc-12
x86_64                randconfig-073-20241119    gcc-12
x86_64                randconfig-074-20241119    gcc-12
x86_64                randconfig-075-20241119    gcc-12
x86_64                randconfig-076-20241119    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241119    gcc-14.2.0
xtensa                randconfig-002-20241119    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

