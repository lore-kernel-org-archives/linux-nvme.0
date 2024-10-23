Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8CD2E031
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z3jxcE+8EoXRNDRnGFY+QCcdP5qX1oe96ndUC61Y6dc=; b=MEQ9mc3Js07wd4pGITFVHXqRCU
	8u0cSarRuNj+fZpPfEEtCBdsBRkrGe/yJT8Do9fHegaQqztToC3GfdJtcX2JHaEX9IETySyQfHj+2
	2Ga+JEzKtQOFxBpFoA9s3k0n2KSysSdVYTL9tMzuYjP4s65TYdX6YITTqOtrT66jevvlkUQVnEIBb
	QpMP+/CWUXLxB+ZhljaaZ1IEkQec+Z/jafp6Wd46bK+TQu8shy51CNzWl6ima2SWxVt+Um1H4fXm6
	M16Ohc8cJdnM+Ocg9nbqQfMc3iZyyPX5TFfB5+H4sVnf5DGco9NJE1CiJdpmhYtVIJp3yAY59thco
	6x+Lz4Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xgz-0000000Dnr0-0vZe;
	Wed, 23 Oct 2024 09:30:13 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3XMC-0000000Diex-2WQ9
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729674525; x=1761210525;
  h=date:from:to:cc:subject:message-id;
  bh=cP1nxKIl47D5bi9CJCo7cy7oLpuLXuLSIj4TpEIMCZ4=;
  b=PKgdt4HFv3AdHsxqnUeA8Xb55ZKffjTH7iU7GDC/zqIH5+mPR1yvmykD
   ORnXLjjFq2arasZUrxZoKmd4U6iCjGw7DLH7zdg0ujZxyJHJEPt/RD8U8
   7hyxZLSBgAUkWSpRyABe6IsG5Xc5nvKWyqsUleSGL0Eyc1imWy91Mwu+P
   YdUYlMGX6HyHIzUdzbhTYNoKMUL9ImAl6zgcDUwin96RUp7S/fADBHfgZ
   1piH59+63pOzB2+ei0lS5dLYCFgcY5AX8+Jx1udmUpNRhTHy8/Pkeup/6
   Qcidn28slt04+Sv3PXdbvBIixMDpJhLjvWMsgsNiHleLwFaJTh/m2okxr
   A==;
X-CSE-ConnectionGUID: CZKR7mXOTwSFva6xZ4gaKQ==
X-CSE-MsgGUID: GC2H6DrWSe29ZzD+7PHUjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46717780"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46717780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:08:42 -0700
X-CSE-ConnectionGUID: sGP2cBq7QRm+FSHlxXwifQ==
X-CSE-MsgGUID: IyQPewq0S6uzb3GORmM61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84714027"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Oct 2024 02:08:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3XM7-000UiM-0G;
	Wed, 23 Oct 2024 09:08:39 +0000
Date: Wed, 23 Oct 2024 17:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 5e52f71f858eaff252a47530a5ad5e79309bd415
Message-ID: <202410231737.v4leJpcM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_020844_776610_F4F433EF 
X-CRM114-Status: UNSURE (   4.57  )
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
branch HEAD: 5e52f71f858eaff252a47530a5ad5e79309bd415  nvme: use helpers to access io_uring cmd space

elapsed time: 905m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                      footbridge_defconfig    clang-20
arm                       imx_v4_v5_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                         mv78xx0_defconfig    clang-20
arm                        shmobile_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241023    clang-18
i386        buildonly-randconfig-002-20241023    clang-18
i386        buildonly-randconfig-003-20241023    clang-18
i386        buildonly-randconfig-004-20241023    clang-18
i386        buildonly-randconfig-005-20241023    clang-18
i386        buildonly-randconfig-006-20241023    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241023    clang-18
i386                  randconfig-002-20241023    clang-18
i386                  randconfig-003-20241023    clang-18
i386                  randconfig-004-20241023    clang-18
i386                  randconfig-005-20241023    clang-18
i386                  randconfig-006-20241023    clang-18
i386                  randconfig-011-20241023    clang-18
i386                  randconfig-012-20241023    clang-18
i386                  randconfig-013-20241023    clang-18
i386                  randconfig-014-20241023    clang-18
i386                  randconfig-015-20241023    clang-18
i386                  randconfig-016-20241023    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-20
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                           ip28_defconfig    clang-20
mips                           ip30_defconfig    clang-20
mips                           jazz_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-20
powerpc                     redwood_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                          kfr2r09_defconfig    clang-20
sh                           se7722_defconfig    clang-20
sh                           se7724_defconfig    clang-20
sh                        sh7785lcr_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241023    gcc-12
x86_64      buildonly-randconfig-002-20241023    gcc-12
x86_64      buildonly-randconfig-003-20241023    gcc-12
x86_64      buildonly-randconfig-004-20241023    gcc-12
x86_64      buildonly-randconfig-005-20241023    gcc-12
x86_64      buildonly-randconfig-006-20241023    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241023    gcc-12
x86_64                randconfig-002-20241023    gcc-12
x86_64                randconfig-003-20241023    gcc-12
x86_64                randconfig-004-20241023    gcc-12
x86_64                randconfig-005-20241023    gcc-12
x86_64                randconfig-006-20241023    gcc-12
x86_64                randconfig-011-20241023    gcc-12
x86_64                randconfig-012-20241023    gcc-12
x86_64                randconfig-013-20241023    gcc-12
x86_64                randconfig-014-20241023    gcc-12
x86_64                randconfig-015-20241023    gcc-12
x86_64                randconfig-016-20241023    gcc-12
x86_64                randconfig-071-20241023    gcc-12
x86_64                randconfig-072-20241023    gcc-12
x86_64                randconfig-073-20241023    gcc-12
x86_64                randconfig-074-20241023    gcc-12
x86_64                randconfig-075-20241023    gcc-12
x86_64                randconfig-076-20241023    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

