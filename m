Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF486E77188
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Dec 2024 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZInl9lISxqUAI60gXGfJhJtHw/0bjp0O3NEPSU7crHg=; b=xNW6pepCv8WsOc5Lqj0Muqn2KQ
	Wh8rOR2zH6+mZAdaBkHQ5xJS1Db00i6qgtvDSpPi4Lk7bDR217VOcWZCqQD3PfZ6AIHcYqqV5BUF8
	p3Grtu6/i1ixeixfHXtiATMRNbMUgxcwqvckzPjDxElRGp57HzV9wZqYi0ZfuUHgwn90XEhZKMjAO
	Ix5sW57SCcB4T7vIs1x6mMjJOjUc2LeFxtfAxekayTFx75GHasuA5aeSzlf8Ido8R23XECz9oCCvO
	MVyYPZ5jx9C6h/N3GLlNIwsSkcqpSsZ2fW/MaXQi6mbi0sr0L9JinZwNqTE7DnZT6HT5AhmXipX0X
	ecqJjNdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRX2v-00000001w6T-11v5;
	Sat, 28 Dec 2024 13:40:01 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRX2s-00000001w5f-1w2v
	for linux-nvme@lists.infradead.org;
	Sat, 28 Dec 2024 13:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735393198; x=1766929198;
  h=date:from:to:cc:subject:message-id;
  bh=iM/SKW2PWfolK/Q9VPkEM+QTHF3U4PN5fRCNh6drkUM=;
  b=SSDePAe6cJHQOC4yKbNlDMEgEu6HYzGTMhjuBpo3vO2mPC4SIkh6G6eU
   2D/lUYTMZdrCQo5LE2jrSFEj1J/LP/vmdLWUp+SvfVcluL56oB9RpgW6V
   jyTUWVf1tOJ/GVgJ/8pPMsVvWbdH64dJCmU3uzLfdFMIkZDiENhjPi3lc
   z0oLtWTsvleG/WfVP6DE2CNZ/R/1MW5TjV8VBXKpfzaGs2XwgNc3pYKUA
   TszTPaBBe7thISap3xzkNyrF6gVtXSoUJXEkaazDE2kyvSrlBPxzol2e7
   AVAv9j66xruCKnPhyPh/yr7eunTwluxmcjXQuapS9Omq40s7vQaCkk/FV
   Q==;
X-CSE-ConnectionGUID: D4/50OKvQOeF7Up1/floiw==
X-CSE-MsgGUID: 8XAYRpO2T16XHt07gKcFSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35915443"
X-IronPort-AV: E=Sophos;i="6.12,272,1728975600"; 
   d="scan'208";a="35915443"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 05:39:50 -0800
X-CSE-ConnectionGUID: PeEnnRf0Rw2Xre7VX8/TAQ==
X-CSE-MsgGUID: f2+5/ypmQuyA+ytaLq0Jhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104983312"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Dec 2024 05:39:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRX2h-00045Y-1u;
	Sat, 28 Dec 2024 13:39:47 +0000
Date: Sat, 28 Dec 2024 21:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 36e3b1f9abe359b2bc25e81bc47b64354e42c9b1
Message-ID: <202412282127.10KgkzJo-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_053958_527416_A71207A2 
X-CRM114-Status: UNSURE (   3.86  )
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
branch HEAD: 36e3b1f9abe359b2bc25e81bc47b64354e42c9b1  nvme-tcp: remove nvme_tcp_destroy_io_queues()

elapsed time: 840m

configs tested: 206
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20241228    gcc-13.2.0
arc                   randconfig-002-20241228    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-16
arm                         lpc32xx_defconfig    clang-20
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20241228    clang-15
arm                   randconfig-002-20241228    gcc-14.2.0
arm                   randconfig-003-20241228    clang-20
arm                   randconfig-004-20241228    clang-20
arm                           sama5_defconfig    clang-17
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241228    gcc-14.2.0
arm64                 randconfig-002-20241228    clang-15
arm64                 randconfig-003-20241228    gcc-14.2.0
arm64                 randconfig-004-20241228    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241228    gcc-14.2.0
csky                  randconfig-002-20241228    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241228    clang-18
hexagon               randconfig-002-20241228    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241228    gcc-12
i386        buildonly-randconfig-002-20241228    clang-19
i386        buildonly-randconfig-003-20241228    gcc-12
i386        buildonly-randconfig-004-20241228    gcc-12
i386        buildonly-randconfig-005-20241228    clang-19
i386        buildonly-randconfig-006-20241228    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241228    clang-19
i386                  randconfig-002-20241228    clang-19
i386                  randconfig-003-20241228    clang-19
i386                  randconfig-004-20241228    clang-19
i386                  randconfig-005-20241228    clang-19
i386                  randconfig-006-20241228    clang-19
i386                  randconfig-007-20241228    clang-19
i386                  randconfig-011-20241228    clang-19
i386                  randconfig-012-20241228    clang-19
i386                  randconfig-013-20241228    clang-19
i386                  randconfig-014-20241228    clang-19
i386                  randconfig-015-20241228    clang-19
i386                  randconfig-016-20241228    clang-19
i386                  randconfig-017-20241228    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241228    gcc-14.2.0
loongarch             randconfig-002-20241228    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-17
mips                          rb532_defconfig    clang-17
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241228    gcc-14.2.0
nios2                 randconfig-002-20241228    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241228    gcc-14.2.0
parisc                randconfig-002-20241228    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc               randconfig-001-20241228    gcc-14.2.0
powerpc               randconfig-002-20241228    clang-20
powerpc               randconfig-003-20241228    clang-20
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    clang-17
powerpc64             randconfig-001-20241228    clang-20
powerpc64             randconfig-002-20241228    gcc-14.2.0
powerpc64             randconfig-003-20241228    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241228    gcc-14.2.0
riscv                 randconfig-002-20241228    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241228    gcc-14.2.0
s390                  randconfig-002-20241228    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          landisk_defconfig    clang-17
sh                    randconfig-001-20241228    gcc-14.2.0
sh                    randconfig-002-20241228    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7780_defconfig    clang-17
sh                        sh7763rdp_defconfig    clang-17
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20241228    gcc-14.2.0
sparc                 randconfig-002-20241228    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241228    gcc-14.2.0
sparc64               randconfig-002-20241228    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241228    clang-20
um                    randconfig-002-20241228    clang-15
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241228    clang-19
x86_64      buildonly-randconfig-002-20241228    clang-19
x86_64      buildonly-randconfig-003-20241228    gcc-12
x86_64      buildonly-randconfig-004-20241228    clang-19
x86_64      buildonly-randconfig-005-20241228    clang-19
x86_64      buildonly-randconfig-006-20241228    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241228    clang-19
x86_64                randconfig-002-20241228    clang-19
x86_64                randconfig-003-20241228    clang-19
x86_64                randconfig-004-20241228    clang-19
x86_64                randconfig-005-20241228    clang-19
x86_64                randconfig-006-20241228    clang-19
x86_64                randconfig-007-20241228    clang-19
x86_64                randconfig-008-20241228    clang-19
x86_64                randconfig-071-20241228    gcc-11
x86_64                randconfig-072-20241228    gcc-11
x86_64                randconfig-073-20241228    gcc-11
x86_64                randconfig-074-20241228    gcc-11
x86_64                randconfig-075-20241228    gcc-11
x86_64                randconfig-076-20241228    gcc-11
x86_64                randconfig-077-20241228    gcc-11
x86_64                randconfig-078-20241228    gcc-11
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241228    gcc-14.2.0
xtensa                randconfig-002-20241228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

