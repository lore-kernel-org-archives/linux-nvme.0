Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780AACAC5A5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wC7jC/Oo/J02WDzn0gAyjfBoV8Z825yvETnKL9AVEvU=; b=GGNSGNEVwFL9mVnyxUiEx1yBmL
	m+NfQduz3zLepYuUlNVXaiSEhPCkH7XqlvXuAqD4RQuS7SX2rYFlFhPPTPZPlKIF0y7/dpsnYx/dx
	HE29w4I4CEEXOMK4JkDrwR5JzDBymA+hII2as3PYfsSvShtBjsfUoVmfwXiDCKHCRIgMwd0VjELfH
	6vxGOXwa5GsAVJ7Ddejs1kXww4NZcgVdCi6VxdHDDxLHTnoAjrpCUi+X9wSyyBiz9K+9ApzRtZ/lB
	2Z7hJvfjY4mG0UTuG8lvmta/Lxh6ZG0f3e7e5YCSXJj2wBxuYrdekB+JNi+9AMBIHOFYSu1iIdCzZ
	NYIHrJhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17oh-0000000EY82-2qst;
	Tue, 23 Sep 2025 18:32:43 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17of-0000000EY7E-3cF4
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 18:32:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758652362; x=1790188362;
  h=date:from:to:cc:subject:message-id;
  bh=NvVCU4azhky/hCPwBOujJdB50srUmzWReq6wFe1A2vA=;
  b=LtOFxqz/iLeqXMz98JjKcE83/mV9y83ApKhgwCAYautMdywIyXd+v5Ua
   qe4DeU+1plZDXWfXDOZ/7ilmYAwm+p0o7iFzVfPg7S9aJngYFSXJoY3bZ
   7rz9Sf7uEo8w9aSOjipZuBtg9fZLZfxx8E+HDX53vzm/iNYKZeEBWlcuw
   KiWpZpwfDrkRbH7K8tWZTxLjIi2bKbCnwX6XeaJ+jqYRZTZMfcBqG/tdh
   QpFcGwD/TwLmPLUxOXToeznvQSqlLYRwRSFrv4O7JRJDDffLWldvphR3u
   zYnxJU0zZ3aD6CzjH1ZWNfc05RnizRF16blaGacjeJyb+/rEbAVwVNnwo
   A==;
X-CSE-ConnectionGUID: C10dq4YfTRWUxPs1vmdq3A==
X-CSE-MsgGUID: Q0dDseVlSSqsbQVwVvv1JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60882348"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60882348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:32:39 -0700
X-CSE-ConnectionGUID: 7qkCBF7ySKuNWjkrdHwfRA==
X-CSE-MsgGUID: bb28CTLVR/y6RmD+W4gJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="175956737"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Sep 2025 11:32:38 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v17oY-0003Qn-35;
	Tue, 23 Sep 2025 18:32:34 +0000
Date: Wed, 24 Sep 2025 02:31:59 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 364617188b9a112689f9392f011832e9db8a2972
Message-ID: <202509240245.EoPyaKfC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_113241_975861_2FC71591 
X-CRM114-Status: UNSURE (   5.12  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.18
branch HEAD: 364617188b9a112689f9392f011832e9db8a2972  nvme: Use non zero KATO for persistent discovery connections

elapsed time: 1258m

configs tested: 126
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          exynos_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-004-20250923    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-002-20250923    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-002-20250923    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-006-20250923    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-002-20250923    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-002-20250923    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-002-20250923    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-002-20250923    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-002-20250923    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-002-20250923    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-002-20250923    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

