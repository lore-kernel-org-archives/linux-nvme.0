Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59117E77173
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Dec 2024 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=etQLaNV9CVNIHxK301jp46I9ktvQ0SyOsCWOuD5RnqU=; b=aaP00Hr5g7toJxH1/KmVLIA0oA
	kql4CxeMOlGDseHc49AHx4Uz+3x2QX5+ZIc3Y94KuC+yjxAOa+f3AVFijUe8X7xW8fCalvAESd5oA
	LYxCbVd/m+8kEhfMONtHLvwHPJVl85e6CetvditbCdnAZKlkjZ3W2qOnm3MznG+EKSzUgopUaiu8o
	IFtuhE/AHcjSrmawZ9+madLeHU7cG6Zbd1FxKemxjWlASoqri/K4w9JpBND3PVGcXwzAVEBEK4K4R
	3N/DC2/SnPIsbZls7by6MB8rGBfMitiUN7Kt8z0UyxAZT9uQ4x6PZzF5HSiSmAzCRIp3387czBaoJ
	vurbnnHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKJLH-00000005TrS-38Fl;
	Sun, 08 Dec 2024 15:37:07 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKJLF-00000005Tqk-1GIB
	for linux-nvme@lists.infradead.org;
	Sun, 08 Dec 2024 15:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733672225; x=1765208225;
  h=date:from:to:cc:subject:message-id;
  bh=DwGZKLo+BCz8hfPcetRCp2zS6WWeATivY30Xyw6IkVc=;
  b=WvwtTgENKIwYu8FHk3GvoXGfncGNigpyR4K9iyagHob/ST66CkeIaCy7
   truQ5veqljzOeuxHIVX04ywmy4iyFCwExJ+jWImyYINJD/4rWbu3msj3w
   ljCaBX/b+JNFyCsNDWdDkBRg1HYuBXu9EkTTt/zTmqwW//reQxtYUOmbJ
   VhNX9kR40Ch6tHcyMM2amQVo700UKI72CTXP3EcOJEXGHwJlfaKlzwxyW
   95o/yiGpS5MNl4kQPvW1miYZOMYQvL7Dw75Gl/mlAPXcOWlZZDbJtE3R/
   PP9hFz13ojsApI/n2Q3aS0aAVQ7nA5UMyr65Fb/V/6fts4PHo9oqd5c9I
   A==;
X-CSE-ConnectionGUID: huGIoIG0TYOZ7PUS/826Xw==
X-CSE-MsgGUID: piMph5rjTmGJcYgBjPRrcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="21568021"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="21568021"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 07:37:02 -0800
X-CSE-ConnectionGUID: BycJDg37SvGKkWUZBQ2Yfw==
X-CSE-MsgGUID: pKHiBrqqT5G5s0rvRuecuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="118100888"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Dec 2024 07:37:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKJL9-0003On-0T;
	Sun, 08 Dec 2024 15:36:59 +0000
Date: Sun, 08 Dec 2024 23:33:19 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 b4e12f5728ff963ca5590c48b85a20d076bf517d
Message-ID: <202412082309.6r9kj0eK-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_073705_354542_70D3C39A 
X-CRM114-Status: UNSURE (   3.82  )
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
branch HEAD: b4e12f5728ff963ca5590c48b85a20d076bf517d  nvme-tcp: simplify nvme_tcp_teardown_io_queues()

elapsed time: 822m

configs tested: 261
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241208    gcc-13.2.0
arc                   randconfig-002-20241208    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                      footbridge_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                            mps2_defconfig    clang-15
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-18
arm                        multi_v5_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    clang-19
arm                       netwinder_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241208    gcc-14.2.0
arm                   randconfig-002-20241208    clang-20
arm                   randconfig-003-20241208    gcc-14.2.0
arm                   randconfig-004-20241208    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    gcc-14.2.0
arm                       versatile_defconfig    clang-18
arm                    vt8500_v6_v7_defconfig    gcc-13.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-20
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241208    gcc-14.2.0
arm64                 randconfig-002-20241208    gcc-14.2.0
arm64                 randconfig-003-20241208    gcc-14.2.0
arm64                 randconfig-004-20241208    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241208    gcc-14.2.0
csky                  randconfig-002-20241208    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-002-20241208    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241208    gcc-12
i386        buildonly-randconfig-002-20241208    clang-19
i386        buildonly-randconfig-003-20241208    gcc-11
i386        buildonly-randconfig-004-20241208    gcc-12
i386        buildonly-randconfig-005-20241208    clang-19
i386        buildonly-randconfig-006-20241208    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241208    gcc-12
i386                  randconfig-002-20241208    gcc-12
i386                  randconfig-003-20241208    gcc-12
i386                  randconfig-004-20241208    gcc-12
i386                  randconfig-005-20241208    gcc-12
i386                  randconfig-006-20241208    gcc-12
i386                  randconfig-007-20241208    gcc-12
i386                  randconfig-011-20241208    clang-19
i386                  randconfig-012-20241208    clang-19
i386                  randconfig-013-20241208    clang-19
i386                  randconfig-014-20241208    clang-19
i386                  randconfig-015-20241208    clang-19
i386                  randconfig-016-20241208    clang-19
i386                  randconfig-017-20241208    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241208    gcc-14.2.0
loongarch             randconfig-002-20241208    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-13.2.0
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip22_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                           jazz_defconfig    gcc-13.2.0
mips                        maltaup_defconfig    clang-20
mips                         rt305x_defconfig    clang-19
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241208    gcc-14.2.0
nios2                 randconfig-002-20241208    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241208    gcc-14.2.0
parisc                randconfig-002-20241208    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc                 canyonlands_defconfig    clang-18
powerpc                 canyonlands_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc               randconfig-001-20241208    clang-20
powerpc               randconfig-002-20241208    gcc-14.2.0
powerpc               randconfig-003-20241208    clang-20
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8541_defconfig    clang-15
powerpc                     tqm8555_defconfig    clang-15
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241208    gcc-14.2.0
powerpc64             randconfig-002-20241208    clang-18
powerpc64             randconfig-003-20241208    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    clang-20
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    clang-20
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    clang-15
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    clang-17
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-18
sh                             espt_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-13.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-15
sh                          r7780mp_defconfig    clang-19
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                          sdk7780_defconfig    clang-18
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7712_defconfig    clang-20
sh                           se7724_defconfig    clang-19
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    clang-16
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-12
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241208    gcc-12
x86_64      buildonly-randconfig-002-20241208    clang-19
x86_64      buildonly-randconfig-003-20241208    gcc-12
x86_64      buildonly-randconfig-004-20241208    clang-19
x86_64      buildonly-randconfig-005-20241208    clang-19
x86_64      buildonly-randconfig-006-20241208    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241208    gcc-12
x86_64                randconfig-002-20241208    gcc-12
x86_64                randconfig-003-20241208    gcc-12
x86_64                randconfig-004-20241208    gcc-12
x86_64                randconfig-005-20241208    gcc-12
x86_64                randconfig-006-20241208    gcc-12
x86_64                randconfig-007-20241208    gcc-12
x86_64                randconfig-008-20241208    gcc-12
x86_64                randconfig-071-20241208    gcc-12
x86_64                randconfig-072-20241208    gcc-12
x86_64                randconfig-073-20241208    gcc-12
x86_64                randconfig-074-20241208    gcc-12
x86_64                randconfig-075-20241208    gcc-12
x86_64                randconfig-076-20241208    gcc-12
x86_64                randconfig-077-20241208    gcc-12
x86_64                randconfig-078-20241208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                       common_defconfig    clang-20
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-18
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

