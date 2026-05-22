Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72312CD5BAF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOjawKBlM9Ubi9w04Ogh4QZPePUoFq+xZiJg3ZiIZsc=; b=3Arb7hcxgJRPExJ2g6E56pP8zy
	h2+nq65VsmAuXpj+1YWpPJZ7lEp07MpA0cOSym9raq98ZgZyOZivTsIGep+0UW8Kvrj7oS7wwYvgB
	xLdTNPVnSV49vgxYuOHDbiKowovfh67px+gr4oyVDbBqdpSb82SDAGdGGL7Gtkj78LyWbUioqq48Y
	gDeJc8R7D55hpHs/HW+iTs2lR9kzAe9sSnJYhNQJLi7r7oT5IJouaTSE/1WA7WgY1plvQRcW1iR/5
	vP9cfK+cyWDqODJNA8qFp3MnyfMfCLRwiHwkn31xBJ6DmkdZ3Hbdq5IgYWsaTBS5MO7yql6l819Sw
	HRIqmGsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQJTt-00000009zE2-2aKb;
	Fri, 22 May 2026 06:35:37 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQJTq-00000009yzX-1jLs
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 06:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779431734; x=1810967734;
  h=date:from:to:cc:subject:message-id;
  bh=wM6EG3m3PLbGOsFUWHL46NIzLUnLXa6qN5SbqafQUz4=;
  b=AySmkKUVjFMWG5YW2R8nlBE3d7LHI4J/UMG/Pd3oIoHngsWoTqnZ5O3E
   y+jxnm8WJbgyVzGrCSF3cNRXi1sbzEDX3D/ILo6sjxxD9XHyGtpBiTMgd
   W++i5vjIgC4Sjlyr4hntuYr73o0X6/9WwvtbOAxCt2N6C2WzFg9/7gGqH
   idqDPf1VoHK/y2qxPFALHs84c27VpZfQdEspy4hTsoJ/lvZlaU94K7ulZ
   wJ+NvKUZ7bqUTNU6s/RdHMJhrcrH7RtrRA0iFCj9Owqf6u78erl5XcZjN
   SjMGnq6Glsn4YLk0yTkKhjPs73kI0nV4P831zHJW1iFNdp94iLmPyt9Ty
   A==;
X-CSE-ConnectionGUID: /VKkIJDrSUSWiiGej+8cRA==
X-CSE-MsgGUID: o9nwRhOkQ1O1xIyvphyVpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97934131"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="97934131"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:33:31 -0700
X-CSE-ConnectionGUID: S38EKhoXSquzh/55SrFhJw==
X-CSE-MsgGUID: FKELXZZ3SluWNmbCYDHSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="240880417"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 May 2026 23:33:30 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQJRm-000000001tb-4B4A;
	Fri, 22 May 2026 06:33:26 +0000
Date: Fri, 22 May 2026 14:32:48 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 1bf86336e4b6cf40873fda47a7fe191446864937
Message-ID: <202605221440.ec0al5Ai-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_233534_494313_53A9950E 
X-CRM114-Status: UNSURE (   4.99  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.1
branch HEAD: 1bf86336e4b6cf40873fda47a7fe191446864937  nvme-pci: fix dma mapping leak on data setup error

elapsed time: 907m

configs tested: 162
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                   randconfig-001-20260522    clang-23
arc                   randconfig-002-20260522    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                   randconfig-001-20260522    clang-23
arm                   randconfig-002-20260522    clang-23
arm                   randconfig-003-20260522    clang-23
arm                   randconfig-004-20260522    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260522    gcc-14.3.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260522    gcc-14.3.0
arm64                          randconfig-003    gcc-14.3.0
arm64                 randconfig-003-20260522    gcc-14.3.0
arm64                          randconfig-004    gcc-14.3.0
arm64                 randconfig-004-20260522    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                           randconfig-001    gcc-14.3.0
csky                  randconfig-001-20260522    gcc-14.3.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260522    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260522    clang-20
i386        buildonly-randconfig-002-20260522    clang-20
i386        buildonly-randconfig-003-20260522    clang-20
i386        buildonly-randconfig-004-20260522    clang-20
i386        buildonly-randconfig-005-20260522    clang-20
i386        buildonly-randconfig-006-20260522    clang-20
i386                  randconfig-011-20260522    clang-20
i386                  randconfig-012-20260522    clang-20
i386                  randconfig-013-20260522    clang-20
i386                  randconfig-014-20260522    clang-20
i386                  randconfig-015-20260522    clang-20
i386                  randconfig-016-20260522    clang-20
i386                  randconfig-017-20260522    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260522    gcc-12.5.0
parisc                randconfig-002-20260522    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260522    gcc-12.5.0
powerpc               randconfig-002-20260522    gcc-12.5.0
powerpc64             randconfig-001-20260522    gcc-12.5.0
powerpc64             randconfig-002-20260522    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260522    gcc-9.5.0
sparc                 randconfig-002-20260522    gcc-9.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260522    gcc-9.5.0
sparc64               randconfig-002-20260522    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260522    gcc-9.5.0
um                    randconfig-002-20260522    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260522    gcc-14
x86_64      buildonly-randconfig-002-20260522    gcc-14
x86_64      buildonly-randconfig-003-20260522    gcc-14
x86_64      buildonly-randconfig-004-20260522    gcc-14
x86_64      buildonly-randconfig-005-20260522    gcc-14
x86_64      buildonly-randconfig-006-20260522    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260522    gcc-14
x86_64                randconfig-002-20260522    gcc-14
x86_64                randconfig-003-20260522    gcc-14
x86_64                randconfig-004-20260522    gcc-14
x86_64                randconfig-005-20260522    gcc-14
x86_64                randconfig-006-20260522    gcc-14
x86_64                randconfig-011-20260522    gcc-14
x86_64                randconfig-012-20260522    gcc-14
x86_64                randconfig-013-20260522    gcc-14
x86_64                randconfig-014-20260522    gcc-14
x86_64                randconfig-015-20260522    gcc-14
x86_64                randconfig-016-20260522    gcc-14
x86_64                randconfig-071-20260522    clang-20
x86_64                randconfig-072-20260522    clang-20
x86_64                randconfig-073-20260522    clang-20
x86_64                randconfig-074-20260522    clang-20
x86_64                randconfig-075-20260522    clang-20
x86_64                randconfig-076-20260522    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260522    gcc-9.5.0
xtensa                randconfig-002-20260522    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

