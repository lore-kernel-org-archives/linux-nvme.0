Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ABDC36017
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zcoECbmqaF8PyZgrT9mRuheUsIRElvaxFrLSk8Lk+4w=; b=zWy8wMhuwVFk1Gdc7oTwXn86I8
	B+qzg9Qr6JzqEQqeFBOWfO2uz80LDcPPI7LiokMhnuL6yNnzEvxIYPfoDdLNyxWLbdgpzT2OVEXs4
	6E1SdgQv+E7myShI1/K8f6peN3GWpCJ3ZfRYAk9jL8FXNLKs4cgJURDASqVhOA0pjnwrrxle6dshW
	KybfEGgONjFVOYdJINX3ZNbk+Y18uGOYXfH3/j/lOg+R/yc7Gw6n6mvceCsU7ROkNyhZscFl2cI2+
	jGL1L4RYVEuGesL53QgUT+NnJP+O6Thay0wxdLwgMwWh6U0TurO6I8McDlYAb91F+Ef1L/gC6rNjn
	hg7Utzzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzgGU-000000046KC-1s0g;
	Tue, 01 Apr 2025 18:23:10 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzgEh-000000046B4-2u5F
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 18:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743531679; x=1775067679;
  h=date:from:to:cc:subject:message-id;
  bh=57ZJdlq9uKMNY1syyvXmVMjtwXBZDPlGIOlAyg1pF0U=;
  b=dpMi/eG/qvADl6y50IKb4SpvIHBtu+xtJV3GnfxC3Exdj3ANx1xNsPEP
   DNSzfoArxBwk203/bd9KgdsANwa3hihpcAHtmtR2jZRZ2J4t1lPHJ7hx4
   YwIA0WDlrDguh8ECPRsR6L/LaLqkVJ95U4YjZYe/5sdGzgU+QRaR1S3wX
   /oI/H6d9hntCn7x5cq5XbQHWMDisWRuBDdosXFbaIToR6nN29Ubhnwx4W
   76H+gy6/iZdoEFvKNFUizs6rT8hnwlRabff3ubBJ/mdORbK4uqYH5hzr7
   UAbEfcYPqgibGGpDCVB0PPZ1XVUD1BzrwUSR6wMEfX8i50g6spfQGC46m
   Q==;
X-CSE-ConnectionGUID: WUg74NG4Rl++khxdXSnETQ==
X-CSE-MsgGUID: 4YhWKS75RtOaqE37tGTXOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44754138"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="44754138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 11:21:17 -0700
X-CSE-ConnectionGUID: lrJsdQfJSzKkcr3nH2Hh3Q==
X-CSE-MsgGUID: d4NbHOVSTiuTMgaRy9WZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="126221937"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 01 Apr 2025 11:21:16 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzgEb-000A3e-2p;
	Tue, 01 Apr 2025 18:21:13 +0000
Date: Wed, 02 Apr 2025 02:20:16 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:for-next] BUILD SUCCESS
 0514a1379e11c6b8038674f43a478b0857d47a5e
Message-ID: <202504020206.e17o5eoS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_112119_769904_5C96132F 
X-CRM114-Status: UNSURE (   5.24  )
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

tree/branch: git://git.infradead.org/nvme.git for-next
branch HEAD: 0514a1379e11c6b8038674f43a478b0857d47a5e  nvme-pci: skip nvme_write_sq_db on empty rqlist

elapsed time: 1451m

configs tested: 123
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250401    gcc-12.4.0
arc                   randconfig-002-20250401    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250401    gcc-7.5.0
arm                   randconfig-002-20250401    gcc-8.5.0
arm                   randconfig-003-20250401    clang-18
arm                   randconfig-004-20250401    clang-14
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250401    clang-21
arm64                 randconfig-002-20250401    clang-20
arm64                 randconfig-003-20250401    gcc-8.5.0
arm64                 randconfig-004-20250401    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250401    gcc-14.2.0
csky                  randconfig-002-20250401    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250401    clang-21
hexagon               randconfig-002-20250401    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250401    gcc-12
i386        buildonly-randconfig-002-20250401    clang-20
i386        buildonly-randconfig-003-20250401    clang-20
i386        buildonly-randconfig-004-20250401    clang-20
i386        buildonly-randconfig-005-20250401    gcc-12
i386        buildonly-randconfig-006-20250401    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250401    gcc-14.2.0
loongarch             randconfig-002-20250401    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250401    gcc-8.5.0
nios2                 randconfig-002-20250401    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250401    gcc-11.5.0
parisc                randconfig-002-20250401    gcc-5.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   currituck_defconfig    clang-14
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250401    clang-21
powerpc               randconfig-002-20250401    gcc-8.5.0
powerpc               randconfig-003-20250401    clang-20
powerpc64             randconfig-001-20250401    clang-21
powerpc64             randconfig-002-20250401    clang-17
powerpc64             randconfig-003-20250401    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250401    clang-21
riscv                 randconfig-002-20250401    clang-14
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250401    clang-15
s390                  randconfig-002-20250401    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                    randconfig-001-20250401    gcc-12.4.0
sh                    randconfig-002-20250401    gcc-12.4.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250401    gcc-11.5.0
sparc                 randconfig-002-20250401    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250401    gcc-9.3.0
sparc64               randconfig-002-20250401    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250401    gcc-12
um                    randconfig-002-20250401    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250401    clang-20
x86_64      buildonly-randconfig-002-20250401    gcc-12
x86_64      buildonly-randconfig-003-20250401    clang-20
x86_64      buildonly-randconfig-004-20250401    clang-20
x86_64      buildonly-randconfig-005-20250401    gcc-12
x86_64      buildonly-randconfig-006-20250401    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250401    gcc-9.3.0
xtensa                randconfig-002-20250401    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

