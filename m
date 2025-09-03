Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D311CA1013
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OTIpSxpHQcfEiEapxB2r4rOiS5c2thmsW+MUbW8gXcI=; b=4zF8MoP/QziiCe6SvsJnuTWfhd
	y64EjQ3K1G0PQ9NdmLUQXWeEmgDMUIj60PPPCdKFOgScg+B9k9q3trEDD4nwczndPej5IHRrNpZHa
	iWc1e43mZNB2gqyIEh5TufyAW5aFUlai0PkXeT2M3CiVwOq5d1K/bWaluMrItAtMWlG2EaGtnuOgs
	tZ1ipMpraIfnqnn+ztWWmxJqQA3ntBq3C6zcynTLMc0nXmbAyz4YqiW8w+h0067xgmToq1DA1klHZ
	iF6R94HsvdQT39a5ARnnlI6z1gQxXv15x5bMg4fgUItuyqfpovUVcmMPeOQEiUm+oirKnyfpAmA7S
	jxkG+a8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utvrh-00000007mk0-3gh9;
	Wed, 03 Sep 2025 22:22:05 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utsOT-00000007KFr-19xF
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 18:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756924781; x=1788460781;
  h=date:from:to:cc:subject:message-id;
  bh=K4h687sFC34WvQfER9xsztNAhwPpY1mUaEQ30DFA8xI=;
  b=TvUMVh5/Cc7hC4QbjUsZCQUydOIHkOjihK3b1LRyUYMWMKC5uh/vQavD
   fA7jMXUCsXPELv4y45mFZKm3nycTdPyMB9aLHD3ewHt7eSXAAVdHliZ6Y
   YcOhO+7Eey5EtP3jRoCe0+RX7VmL6xk8DJ9UKaNHi/z9V2nAFH3OZXy6n
   PnNXgz+xPbMu49rVw9pLLtKrZbWz2IdsVmhVCtPbheOtIGgCCFs6m1Ee9
   f32zZ6+0mDyU2ayX+AlxdNSyct670pAzizmmSBeghUUUGRjU+pUcGMA0Z
   QJi0ybNIo9UGZDpKDxnVAKGI9OXNaKa1xHMu2lKm3DCOrIsNizk8sZwxn
   w==;
X-CSE-ConnectionGUID: HavSnkPwT3GtiJ1eTIJSog==
X-CSE-MsgGUID: +34aZyRpQmOydyZwXNVXXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="46823069"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="46823069"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 11:39:37 -0700
X-CSE-ConnectionGUID: 3skzvAURR2q71AkoSd1ECw==
X-CSE-MsgGUID: PeCZE5gxStCTodH0KsZr3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="170959972"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Sep 2025 11:39:36 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utsOL-0004JX-1K;
	Wed, 03 Sep 2025 18:39:33 +0000
Date: Thu, 04 Sep 2025 02:38:19 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.17] BUILD SUCCESS
 7ac3c2889bc060c3f67cf44df0dbb093a835c176
Message-ID: <202509040205.uipxoHQp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_113941_332591_5F764F03 
X-CRM114-Status: UNSURE (   5.37  )
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
branch HEAD: 7ac3c2889bc060c3f67cf44df0dbb093a835c176  nvme: fix PI insert on write

elapsed time: 1325m

configs tested: 232
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-8.5.0
arc                   randconfig-002-20250903    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm                             mxs_defconfig    gcc-15.1.0
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-001-20250903    gcc-8.5.0
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-002-20250903    gcc-8.5.0
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-003-20250903    gcc-8.5.0
arm                   randconfig-004-20250903    clang-22
arm                   randconfig-004-20250903    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-002-20250903    gcc-8.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-003-20250903    gcc-8.5.0
arm64                 randconfig-004-20250903    clang-22
arm64                 randconfig-004-20250903    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250903    gcc-10.5.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-002-20250903    gcc-10.5.0
csky                  randconfig-002-20250903    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-001-20250903    gcc-10.5.0
hexagon               randconfig-002-20250903    clang-18
hexagon               randconfig-002-20250903    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250903    clang-20
i386        buildonly-randconfig-001-20250903    gcc-12
i386        buildonly-randconfig-002-20250903    clang-20
i386        buildonly-randconfig-002-20250903    gcc-12
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250903    gcc-13
i386                  randconfig-001-20250904    gcc-11
i386                  randconfig-002-20250903    gcc-13
i386                  randconfig-002-20250904    gcc-11
i386                  randconfig-003-20250903    gcc-13
i386                  randconfig-003-20250904    gcc-11
i386                  randconfig-004-20250903    gcc-13
i386                  randconfig-004-20250904    gcc-11
i386                  randconfig-005-20250903    gcc-13
i386                  randconfig-005-20250904    gcc-11
i386                  randconfig-006-20250903    gcc-13
i386                  randconfig-006-20250904    gcc-11
i386                  randconfig-007-20250903    gcc-13
i386                  randconfig-007-20250904    gcc-11
i386                  randconfig-011-20250903    gcc-13
i386                  randconfig-012-20250903    gcc-13
i386                  randconfig-013-20250903    gcc-13
i386                  randconfig-014-20250903    gcc-13
i386                  randconfig-015-20250903    gcc-13
i386                  randconfig-016-20250903    gcc-13
i386                  randconfig-017-20250903    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-10.5.0
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
loongarch             randconfig-002-20250903    gcc-10.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-10.5.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-002-20250903    gcc-10.5.0
parisc                randconfig-002-20250903    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250903    gcc-10.5.0
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-002-20250903    gcc-10.5.0
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-003-20250903    gcc-10.5.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-001-20250903    gcc-10.5.0
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-002-20250903    gcc-10.5.0
powerpc64             randconfig-003-20250903    clang-22
powerpc64             randconfig-003-20250903    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250903    gcc-12.5.0
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-12.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250903    gcc-12.5.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-002-20250903    clang-22
s390                  randconfig-002-20250903    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sh                    randconfig-002-20250903    gcc-12.5.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-001-20250903    gcc-12.5.0
sparc                 randconfig-002-20250903    gcc-12.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250903    gcc-12.5.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
sparc64               randconfig-002-20250903    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-13
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250903    gcc-12
um                    randconfig-001-20250903    gcc-12.5.0
um                    randconfig-002-20250903    clang-18
um                    randconfig-002-20250903    gcc-12.5.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-001-20250904    gcc-13
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-002-20250904    gcc-13
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-003-20250904    gcc-13
x86_64      buildonly-randconfig-004-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    gcc-12
x86_64      buildonly-randconfig-004-20250904    gcc-13
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-005-20250904    gcc-13
x86_64      buildonly-randconfig-006-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    gcc-12
x86_64      buildonly-randconfig-006-20250904    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250903    clang-20
x86_64                randconfig-002-20250903    clang-20
x86_64                randconfig-003-20250903    clang-20
x86_64                randconfig-004-20250903    clang-20
x86_64                randconfig-005-20250903    clang-20
x86_64                randconfig-006-20250903    clang-20
x86_64                randconfig-007-20250903    clang-20
x86_64                randconfig-008-20250903    clang-20
x86_64                randconfig-071-20250903    clang-20
x86_64                randconfig-072-20250903    clang-20
x86_64                randconfig-073-20250903    clang-20
x86_64                randconfig-074-20250903    clang-20
x86_64                randconfig-075-20250903    clang-20
x86_64                randconfig-076-20250903    clang-20
x86_64                randconfig-077-20250903    clang-20
x86_64                randconfig-078-20250903    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-001-20250903    gcc-12.5.0
xtensa                randconfig-002-20250903    gcc-12.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

