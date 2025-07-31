Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812D6C83F17
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nwIk1RX3Z9pDqIrNsP9WuKWMnAlghmqZ1x9GdYSbOFM=; b=NhT0KqNh7bLA0mD5ETJyUv9rVG
	AlN27f7JTpO0kBRgMCo1y/iI9Ub7Eekbo8LucPfc9yToQOTO0eYsIKdxGL/QYH6XQPFnI2CNkLgMm
	nJMv92NbcySxnBJ4My3tiUwG039oCMYdgijHrynC1bAs4gqHOwx3t8NZkbFcpRUtRSK1meD3Ve9dj
	t/2z5APYNqAg99arb5GYKGpMXmWzjChyDCNngh8R9219aRtlLa1j7Mnz656elCE4xADE1I03VTVhw
	VFWdMxjmZXVooivuZ4R8mriJ17CG7LsPB7Tezg0fEWbWdmY3hzCQOfpJSU1z+yg1XwZxgOFSFk3Pd
	mm7v+GcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhMaL-00000002ymU-42rn;
	Thu, 31 Jul 2025 06:16:13 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhMaI-00000002ymB-2i4t
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 06:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753942570; x=1785478570;
  h=date:from:to:cc:subject:message-id;
  bh=DfYzo6tA0xdORGsuL58THZ+XuN/N9ePyWWI2zpuUJJo=;
  b=CEQourEi+HTd5Z2tOU6RdGUJsZUOPOhfydC5Wv2ED+c/NXPjBrUDKIdD
   iezelwqonR8suGs8i/N3ZcAY+Jwl6TbZ+5QYc/GSPpb2IhoLD9E9xUDbP
   stM5aAnMQPoMLS6hyQWKU5gOmR9JRpMbRyV0OuYBs8XEC9HJAsTWnkiPM
   VKctoTuoPUmt8UmzKHycHT4Rj3O5K1sAMKD2C2vVPNCAVTgfZDwr6hXKr
   XJxy6liijKqSz0WTZsiRqo0/DIPznYmCoHnAr/z3cNcsGhMJ3rhrUdeIZ
   S5sxP4Kx0hOAHzJ1caSruhjx9kKriwOUbkOKpH+BYLUqdFEXCpV5p0AYa
   w==;
X-CSE-ConnectionGUID: 8H+qXXy9TaamS5QHfWMMCw==
X-CSE-MsgGUID: W1JGDmIqTymrfg+lkiT17g==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73712155"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="73712155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 23:16:07 -0700
X-CSE-ConnectionGUID: amF+YkdWR5el1sMaKUM78w==
X-CSE-MsgGUID: QKiuEzOkQX2vmW6kNCUa/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167400672"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Jul 2025 23:16:06 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhMaC-0003TM-0z;
	Thu, 31 Jul 2025 06:16:04 +0000
Date: Thu, 31 Jul 2025 14:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.17] BUILD SUCCESS
 e97c0040215f97fccaec74c3d5493bfeacfb2b86
Message-ID: <202507311425.Z56QgzOA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_231610_723722_9CB5DDD7 
X-CRM114-Status: UNSURE (   6.01  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.17
branch HEAD: e97c0040215f97fccaec74c3d5493bfeacfb2b86  nvme-auth: remove unneeded semicolon

elapsed time: 831m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250731    gcc-13.4.0
arc                   randconfig-002-20250731    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250731    gcc-14.3.0
arm                   randconfig-002-20250731    gcc-8.5.0
arm                   randconfig-003-20250731    gcc-8.5.0
arm                   randconfig-004-20250731    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250731    gcc-8.5.0
arm64                 randconfig-002-20250731    gcc-13.4.0
arm64                 randconfig-003-20250731    gcc-10.5.0
arm64                 randconfig-004-20250731    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250731    gcc-12.5.0
csky                  randconfig-002-20250731    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250731    clang-16
hexagon               randconfig-002-20250731    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250731    gcc-12
i386        buildonly-randconfig-002-20250731    gcc-12
i386        buildonly-randconfig-003-20250731    clang-20
i386        buildonly-randconfig-004-20250731    gcc-12
i386        buildonly-randconfig-005-20250731    gcc-12
i386        buildonly-randconfig-006-20250731    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250731    gcc-13.4.0
loongarch             randconfig-002-20250731    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250731    gcc-11.5.0
nios2                 randconfig-002-20250731    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250731    gcc-8.5.0
parisc                randconfig-002-20250731    gcc-8.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-22
powerpc               randconfig-001-20250731    gcc-13.4.0
powerpc               randconfig-002-20250731    gcc-13.4.0
powerpc               randconfig-003-20250731    gcc-15.1.0
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250731    clang-22
powerpc64             randconfig-002-20250731    gcc-12.5.0
powerpc64             randconfig-003-20250731    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250731    gcc-13.4.0
riscv                 randconfig-002-20250731    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250731    clang-22
s390                  randconfig-002-20250731    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250731    gcc-10.5.0
sh                    randconfig-002-20250731    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250731    gcc-8.5.0
sparc                 randconfig-002-20250731    gcc-11.5.0
sparc64               randconfig-001-20250731    gcc-8.5.0
sparc64               randconfig-002-20250731    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250731    clang-22
um                    randconfig-002-20250731    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250731    gcc-12
x86_64      buildonly-randconfig-002-20250731    clang-20
x86_64      buildonly-randconfig-003-20250731    gcc-12
x86_64      buildonly-randconfig-004-20250731    gcc-12
x86_64      buildonly-randconfig-005-20250731    gcc-12
x86_64      buildonly-randconfig-006-20250731    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250731    gcc-14.3.0
xtensa                randconfig-002-20250731    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

