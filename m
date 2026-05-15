Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60100CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g61GaNSP3gZj85RnCi7v05XHQfsDCHctgYFb9KugK2U=; b=elFcYcoO6B18qNFRVMZih/lPo6
	iyOML7voFO23oO3GBcFn0mvX9SHpdoCThMQ0wL7MBbCgPveJaMh8JxDXFw5StmiNe+t0rxtStSZLX
	QRYZqsYtEFEhGQM1mYrJC92qFgpn5bW+DKIl3w8HVNsoxWN6za+u93LOGZK9vcRJqmnDqV944u727
	H8fPBVuVHKmyCEwWvbNZDH8+vgzJyMl4mGI2Srqb1LyvALIGdxfLN++pZFKhePEGjbhzbHAYERzEf
	Q7xX50YGzJChx9McL0dr6vBmm/XK8rEs7JDub32YNUrc3ggs3ROVZUjzbg9BDPJf+9VCpHcmITMeu
	iHo4lTog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNisD-00000007Bkz-2rXo;
	Fri, 15 May 2026 03:06:01 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNisA-00000007Bke-2pem
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 03:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778814358; x=1810350358;
  h=date:from:to:cc:subject:message-id;
  bh=xXkaBQ3qkamHGXdvu0qnABK0A75eEeQNnDr30NulD6Y=;
  b=DjVVrUrKH+hTC3BNUcQBdI+ndQRI7cQy4scb/rGiA6M5kMR8bYieEHUk
   /cvtxQHerkeReAgmpKhsoqkFnJhsaNXk5zhC18PUcAmRNUjOWlGX3fNpz
   US2jTwcboNh2K+JrJO5snjRC5fqnvZz/oaA2Nl+ZU4FV52Sp/FiJ1PkOX
   /6JJz4r7Yw8iyt/EI1c/3ODZE8AbUyS/4l9fY96gAa1t1hXZruSQrdJOc
   vwjZafVCR0Yl8l6bXGHkHpt3kE57QIL7b1KE0lbELcp7OE6HWNtemq/9C
   Ek2sY/l2Eoi3iKwmS+yLbQ7x9ixOmVyyVRc5rU7G2bMrcrfYUK64dpZHq
   A==;
X-CSE-ConnectionGUID: LgYdw8PVTyOc+LQMuip+aQ==
X-CSE-MsgGUID: 2qDCtOY3R0yO6dJVAcLThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="82334236"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="82334236"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 20:05:58 -0700
X-CSE-ConnectionGUID: omBrXNAjQR6c92KsFdkxnQ==
X-CSE-MsgGUID: J5nQGdORTri886cpfvHWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="268915364"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2026 20:05:47 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNirA-000000000gx-1nAe;
	Fri, 15 May 2026 03:05:11 +0000
Date: Fri, 15 May 2026 10:59:51 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 a6ab75639e23169a741b0b2e12191fd8acb32c73
Message-ID: <202605151039.UKQPLGrS-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_200558_733675_78B0C5B5 
X-CRM114-Status: UNSURE (   4.63  )
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
branch HEAD: a6ab75639e23169a741b0b2e12191fd8acb32c73  nvme-apple: Reset q->sq_tail during queue init

elapsed time: 727m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260515    clang-23
arc                   randconfig-002-20260515    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260515    clang-23
arm                   randconfig-002-20260515    clang-23
arm                   randconfig-003-20260515    clang-23
arm                   randconfig-004-20260515    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260515    gcc-8.5.0
hexagon               randconfig-002-20260515    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386        buildonly-randconfig-002-20260515    gcc-14
i386        buildonly-randconfig-003-20260515    gcc-14
i386        buildonly-randconfig-004-20260515    gcc-14
i386        buildonly-randconfig-005-20260515    gcc-14
i386        buildonly-randconfig-006-20260515    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260515    clang-20
i386                  randconfig-002-20260515    clang-20
i386                  randconfig-003-20260515    clang-20
i386                  randconfig-004-20260515    clang-20
i386                  randconfig-005-20260515    clang-20
i386                  randconfig-006-20260515    clang-20
i386                  randconfig-007-20260515    clang-20
i386                  randconfig-011-20260515    gcc-14
i386                  randconfig-012-20260515    gcc-14
i386                  randconfig-013-20260515    gcc-14
i386                  randconfig-014-20260515    gcc-14
i386                  randconfig-015-20260515    gcc-14
i386                  randconfig-016-20260515    gcc-14
i386                  randconfig-017-20260515    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260515    gcc-8.5.0
loongarch             randconfig-002-20260515    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260515    gcc-8.5.0
nios2                 randconfig-002-20260515    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260515    gcc-8.5.0
parisc                randconfig-002-20260515    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    clang-23
powerpc               randconfig-001-20260515    gcc-8.5.0
powerpc               randconfig-002-20260515    gcc-8.5.0
powerpc64             randconfig-001-20260515    gcc-8.5.0
powerpc64             randconfig-002-20260515    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260515    gcc-15.2.0
riscv                 randconfig-002-20260515    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260515    gcc-15.2.0
s390                  randconfig-002-20260515    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260515    gcc-15.2.0
sh                    randconfig-002-20260515    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260515    gcc-8.5.0
sparc64               randconfig-002-20260515    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-8.5.0
um                    randconfig-002-20260515    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260515    gcc-14
x86_64      buildonly-randconfig-002-20260515    gcc-14
x86_64      buildonly-randconfig-003-20260515    gcc-14
x86_64      buildonly-randconfig-004-20260515    gcc-14
x86_64      buildonly-randconfig-005-20260515    gcc-14
x86_64      buildonly-randconfig-006-20260515    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260515    clang-20
x86_64                randconfig-002-20260515    clang-20
x86_64                randconfig-003-20260515    clang-20
x86_64                randconfig-004-20260515    clang-20
x86_64                randconfig-005-20260515    clang-20
x86_64                randconfig-006-20260515    clang-20
x86_64                randconfig-011-20260515    clang-20
x86_64                randconfig-012-20260515    clang-20
x86_64                randconfig-013-20260515    clang-20
x86_64                randconfig-014-20260515    clang-20
x86_64                randconfig-015-20260515    clang-20
x86_64                randconfig-016-20260515    clang-20
x86_64                randconfig-071-20260515    gcc-12
x86_64                randconfig-072-20260515    gcc-12
x86_64                randconfig-073-20260515    gcc-12
x86_64                randconfig-074-20260515    gcc-12
x86_64                randconfig-075-20260515    gcc-12
x86_64                randconfig-076-20260515    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260515    gcc-8.5.0
xtensa                randconfig-002-20260515    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

