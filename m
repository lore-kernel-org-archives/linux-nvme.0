Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDEAC3ABDD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rs13plu5uds5PW9YhGraD1d9WU9du7mWzABj7rmkcvc=; b=iVZTpvQ1p1TfBiICLlZcpKg5kV
	Z8LaZpaePxajKuw8VsBwT3ZEf/Q2AGrcK93DxtRgnD7TdqqwmnwaMqjIP4UZqoMWZqYMa8fZPkFDF
	lTrM6c3J4wDtl4Ro1BgW2U55aCdSqZV+URvqcOPeAyvcE6L8tH0jaNCHXZiUF1LY3zMBerKeKQ3Sr
	Mrj/8zNJtHgg3iMp8ibpiE2RbAKEETvhZVstIK4rqzavmjOeBuw+xW4JY7xqGMNSi2yv/4gZYJYlo
	ljXPO55Jtq7zosfseZBqDdNikI7BBS5KbiGeBD8xslZVS/nBeq0ox1AxizBsIHuWEWtiTi93ShTJf
	dQWofVZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH72q-0000000AOMj-1mGn;
	Mon, 19 May 2025 20:25:08 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH72n-0000000AOMI-3Ppg
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 20:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747686306; x=1779222306;
  h=date:from:to:cc:subject:message-id;
  bh=G+4yP8l8nX/p8T7fRnRCI3ov4Hvd6oAkmDRqjCU5Hjw=;
  b=F2FRg9Iuzhzf66/j54sGeCr4/OGy38vr+8x1DpFskV4im2Tuf0zPrUOv
   z4rB5H/p/s7Y/GZksGWQdoHioBdAEgsHV04UuhcOy8GGRL7yrydT2fXn/
   fV9+pnmhCaB4XL8na19coUxRXZqMfAaCFjq/55HB7X5ht8wkg0kSRz3J8
   +wWmRSJsDgBGG5zfkvFiHajqzKiJvU3qTZ6evN5oosCBKIjhFazqwIheH
   NJAY3Rejf7jK3lJMreSQNUfubxbnODyAq+E3SX8DszqNrw+mxbuI5QbgO
   u4XVJPm0wtUlQneL3ufQZ2iT4RoBrpw2kBUhlnHt926bSE1CwvzM30nS9
   Q==;
X-CSE-ConnectionGUID: DU0C0o8vSkiyv8riJ5Nyhw==
X-CSE-MsgGUID: AMn4jeibSF2Ybei+0IkQxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49532499"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49532499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 13:25:05 -0700
X-CSE-ConnectionGUID: 11w+HEQLS7WdQrRBNuSPVw==
X-CSE-MsgGUID: qa3+kVmUTuim4Uf3Lb0yRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="143474423"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2025 13:25:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH72j-000Loa-2k;
	Mon, 19 May 2025 20:25:01 +0000
Date: Tue, 20 May 2025 04:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS
 fc9c5b746e651c57ea8b8d702659db8f2e9847b2
Message-ID: <202505200455.upPdPCbt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_132505_868608_3AB0B318 
X-CRM114-Status: UNSURE (   6.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.16
branch HEAD: fc9c5b746e651c57ea8b8d702659db8f2e9847b2  nvme-pci: derive and better document max segments limits

elapsed time: 739m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250519    gcc-12.4.0
arc                   randconfig-002-20250519    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                        multi_v5_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250519    clang-18
arm                   randconfig-002-20250519    clang-21
arm                   randconfig-003-20250519    clang-20
arm                   randconfig-004-20250519    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250519    clang-17
arm64                 randconfig-002-20250519    gcc-8.5.0
arm64                 randconfig-003-20250519    clang-19
arm64                 randconfig-004-20250519    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250519    gcc-10.5.0
csky                  randconfig-002-20250519    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250519    clang-21
hexagon               randconfig-002-20250519    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250519    clang-20
i386        buildonly-randconfig-002-20250519    clang-20
i386        buildonly-randconfig-003-20250519    gcc-12
i386        buildonly-randconfig-004-20250519    gcc-12
i386        buildonly-randconfig-005-20250519    gcc-12
i386        buildonly-randconfig-006-20250519    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250519    gcc-14.2.0
loongarch             randconfig-002-20250519    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-21
mips                          eyeq5_defconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-21
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250519    gcc-14.2.0
nios2                 randconfig-002-20250519    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250519    gcc-7.5.0
parisc                randconfig-002-20250519    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250519    gcc-8.5.0
powerpc               randconfig-002-20250519    gcc-6.5.0
powerpc               randconfig-003-20250519    gcc-8.5.0
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20250519    clang-20
powerpc64             randconfig-002-20250519    gcc-6.5.0
powerpc64             randconfig-003-20250519    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250519    gcc-14.2.0
riscv                 randconfig-002-20250519    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250519    gcc-7.5.0
s390                  randconfig-002-20250519    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250519    gcc-12.4.0
sh                    randconfig-002-20250519    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250519    gcc-11.5.0
sparc                 randconfig-002-20250519    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250519    gcc-7.5.0
sparc64               randconfig-002-20250519    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250519    gcc-12
um                    randconfig-002-20250519    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250519    clang-20
x86_64      buildonly-randconfig-002-20250519    gcc-12
x86_64      buildonly-randconfig-003-20250519    clang-20
x86_64      buildonly-randconfig-004-20250519    clang-20
x86_64      buildonly-randconfig-005-20250519    gcc-12
x86_64      buildonly-randconfig-006-20250519    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250519    gcc-7.5.0
xtensa                randconfig-002-20250519    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

