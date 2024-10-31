Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56EE6896A
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SXQx6JKtkG8Wp3uY9H1ibYeYA6V6gMkj20znT5Gbgzs=; b=LpjKYYebdTMgCZ8TUYkyrgV39L
	FE3bBACGLUYB+IDx9dnaYGfWEBjrQju72+lSiLTXt3A8p+qC4prA5ia5xvNorfI4hrfX8gIClvatN
	f53J04HMwJVA0nJ7gFTEdBnUjcdu9FKp/6Es5/O1QnXV+keW+pGXHKanzg8ANLfCxzKSPTBxY3h1r
	Do3P1AXRlLvBssi2ONFcJ1jJYxYESQmZIL892rZ7E3tYrjGsFeY6jplnXSv8WsZ2mfX12XQ+YLTzm
	qW4W1YYIBhpDrbpDa3en0JZajUeaxVruJWTnUG20/wB/Luofg0exG8D12wirp514thxtqc4nWIE2C
	CezxixMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Rkq-0000000380c-1xGf;
	Thu, 31 Oct 2024 09:46:12 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Rkn-00000003801-2Z3p
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 09:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730367970; x=1761903970;
  h=date:from:to:cc:subject:message-id;
  bh=yyNgknRarYf5aeva6tJfb2gRkbM6DWcialeu2Q+PgHw=;
  b=JDEvpJY9fwkvRESCgXdGvo/BRxAkhsFVnwnOlEC6uwfGE4yYLbC+6DIM
   g5x0E5lJAJhYjzGKaw2IIHt5rQDYYBcBOlU9EmQsycuFFQdrnCwuVBY9g
   xZMyhetHakcaTkGaIBzof0g43QRJwIaUW2ECC2mtgOxwS+3CxARaIBj9z
   CcaenPgU+PH5eDO1KIrpRgL/7c3Mn68G6VhAgXHHgQwwGcHLkR/wGZf9Y
   4+l8+cEOdXP70eyL9rBziu9TdIpXS772QJivVARJkQTIbrsKHT8Xs59NP
   pFjp5JgC2ynjbl1UIAdlknb3LUq+mJVEVxhsDAn70ivWajj+H+dl7chL6
   g==;
X-CSE-ConnectionGUID: vyVGN/11QFSEdNvVGUGKXg==
X-CSE-MsgGUID: sDphOwKdRy6r9xmiQVFFsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52652368"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52652368"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:46:08 -0700
X-CSE-ConnectionGUID: zcFOsXavTJSI3dRideGglw==
X-CSE-MsgGUID: D1mmnJBnS/KY00RLvPaqHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82119629"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Oct 2024 02:46:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Rki-000fvo-2u;
	Thu, 31 Oct 2024 09:46:04 +0000
Date: Thu, 31 Oct 2024 17:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 5eed4fb274cd6579f2fb4190b11c4c86c553cd06
Message-ID: <202410311726.ujTVK4Y8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_024609_727802_70F233B1 
X-CRM114-Status: UNSURE (   4.88  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 5eed4fb274cd6579f2fb4190b11c4c86c553cd06  nvme: re-fix error-handling for io_uring nvme-passthrough

elapsed time: 923m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                 nsimosci_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.1.0
arm                        mvebu_v7_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                            qcom_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    clang-19
x86_64      buildonly-randconfig-005-20241031    clang-19
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241031    clang-19
x86_64                randconfig-002-20241031    clang-19
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    clang-19
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    clang-19
x86_64                randconfig-015-20241031    clang-19
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    clang-19
x86_64                randconfig-072-20241031    clang-19
x86_64                randconfig-073-20241031    clang-19
x86_64                randconfig-074-20241031    clang-19
x86_64                randconfig-075-20241031    clang-19
x86_64                randconfig-076-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

