Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020AFF4368D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CyCiRLspnwTn8slYJvjoh/YL4rEmYFipYSmkz9ktEyE=; b=R5fAzsYQNUlV7UR8m2tW+ssmQ+
	QOsZ9w+q2xEidyvUCYB1j2JcpZ43mBwVdK2LN3yKfKwxppm/CMnVUVlH4SQFHemBlFWueLRHnvvmP
	1rX11NdHs1+lkxF6byt542KVA4O7beTeNI/tkIwaaVa38vJ8lUNeExuzfUsL0/pPy0+msKABxu3c8
	2TQobdnL1lvuio+eaODNKrzZ9hzdClY+89P3dP/Na/XalX1EcQ8VgxDkEg3SZl7BkGde850s0sYNG
	oVj8uTQBg5gmr84dcSTjHP5uNb1AxQ30u2+5E/YoqGYLHPwei5g2rT6ybp5m7Pu2qEya+wMZlgugN
	aded2a9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDhZs-00000003zXI-0vwO;
	Fri, 17 Apr 2026 11:41:40 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDhZp-00000003zWz-1nIr
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 11:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776426097; x=1807962097;
  h=date:from:to:cc:subject:message-id;
  bh=0S2IALXfW27WLZDQy83gXqXqgfxCwRTJQ4qI8P1P7GI=;
  b=Rjn90ZtyQdximyiwd2BQm3G12yqvTb3N4/onEuzatMGLGxesqMRsrrRL
   QLIPIFnkcvkmmeSdPaFWqzK9uz7q5Ga1XI9bHXqLQtKBhh4y0gdl5cHzl
   l5NN6Ps5snlKU3sD97WTDpR1ORBxFl6ZgEwR7tAwosnSp9RzRfDlazhxx
   nY6tcbdPx5nFROOnwkQXHLtvKXJjO86s2gLjQicwJir+wJNRiOYJmF/lG
   zfmEYgppo9eyW3i2PYBTpOrkbwTM+GZvwt1v7xWkQ+o7dPd5pwshnQ/oJ
   L9dA/sp5Js+VOLESdNMG6ewhssNGsb1ESkgktZQYzTjpjO5LpW1vftbJK
   w==;
X-CSE-ConnectionGUID: nhyCDpPsS72UMW3EBNeDAQ==
X-CSE-MsgGUID: xDRqyMhMSwWOAhXeXKjM1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="76604504"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="76604504"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 04:41:35 -0700
X-CSE-ConnectionGUID: nEGGPbdeRFWlyIiUw6zhkQ==
X-CSE-MsgGUID: 0guP9cvSSAevmi7WOPO57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="230001922"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Apr 2026 04:41:34 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDhZj-000000000Iz-25iG;
	Fri, 17 Apr 2026 11:41:31 +0000
Date: Fri, 17 Apr 2026 19:41:01 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 cf92d78a4aa2adbc2b1e687776aabe63c5b97f3f
Message-ID: <202604171953.3e1aewHZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_044137_529502_95C08DEE 
X-CRM114-Status: UNSURE (   4.53  )
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
branch HEAD: cf92d78a4aa2adbc2b1e687776aabe63c5b97f3f  nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)

elapsed time: 724m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260417    gcc-8.5.0
arc                   randconfig-002-20260417    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260417    gcc-10.5.0
arm                   randconfig-002-20260417    clang-23
arm                   randconfig-003-20260417    clang-23
arm                   randconfig-004-20260417    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260417    clang-19
arm64                 randconfig-002-20260417    clang-23
arm64                 randconfig-003-20260417    clang-23
arm64                 randconfig-004-20260417    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260417    gcc-13.4.0
csky                  randconfig-002-20260417    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260417    clang-20
i386        buildonly-randconfig-002-20260417    clang-20
i386        buildonly-randconfig-003-20260417    clang-20
i386        buildonly-randconfig-004-20260417    clang-20
i386        buildonly-randconfig-005-20260417    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          eyeq6_defconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260417    gcc-12.5.0
parisc                randconfig-002-20260417    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260417    gcc-8.5.0
powerpc               randconfig-002-20260417    clang-23
powerpc64             randconfig-001-20260417    clang-23
powerpc64             randconfig-002-20260417    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260417    clang-23
riscv                 randconfig-002-20260417    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260417    gcc-14.3.0
s390                  randconfig-002-20260417    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260417    gcc-15.2.0
sh                    randconfig-002-20260417    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260417    gcc-12.5.0
sparc                 randconfig-002-20260417    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260417    clang-20
sparc64               randconfig-002-20260417    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260417    gcc-13
um                    randconfig-002-20260417    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260417    gcc-9.5.0
xtensa                randconfig-002-20260417    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

