Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB7BCCD1AB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 03:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/2d92KsZwSFqoDGEBBKS5yhMOiwk0PgVUQABTE+W+E8=; b=pTZWXQDhaEAk8cFXe1UHbaSbLp
	8ABysdOWdD1+EcRuANH6gI3dLaQJ6BSlNsfd3j0Q0RljTXUUSBkkwtq9vu7u3tSfxf8guO5dYIZmJ
	bufzdsKScAj3K5j8MDybxwsEKVRXpDAHp4YRKzY+bqNUaaWd4KPLnWq8GZgNfu9FQNiQ8Ywxwm833
	BXWEEZwzWE/lE3ubXNU9u4kLck2ff+gqY/yz2Ma2MD0ltwZBc1iMtqJ/6B9qONCXs/uFf2fejDLuG
	RG0TIbBNrDAV2SiwhkgqhmbQX+jlg79pMU63LquA+4N3LvZo6J/1ev4hCPAr/CkQQ3kwQlsxmYfjY
	9GRhguKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8sS-00000008BUh-0GYP;
	Fri, 24 Oct 2025 03:54:08 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8sP-00000008BUE-2aVJ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 03:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761278046; x=1792814046;
  h=date:from:to:cc:subject:message-id;
  bh=JOqAFmXrLjONM9KgE3uvd1ZqQkcr0TIvdMO2uh1YUMU=;
  b=ibZpBx6MnmywG+slVaMFKtQQtp+x9k+bOIhiQakVlZgbyu5plGsmEc8J
   HRwXxzIvNw78yPWP/7Npf6y3ebU3ibRq2+sDWmhtEnFhRVab2TmE4Mhqv
   I3eIrUp334pmwkCH+IJ+CSATeF1XeZj6JUpsmM78EaJ03ixAIwbakT0f3
   f3bRLBPFiIoBVE6CqenRzhiGX2OfVMT+dUqqPXLJSGrVBmqTYI6xsOBQ1
   ZkCgswCtatPqIYrkwN3t3QfDTT0a/tEoGJg50gpoBYUoDEVvnMiR/6xtX
   3yp2/tk2i8ci/m/SMl1z2IMeUh2fgsVMrCAhPZxXVZ4fFeiEUeXOX32xU
   g==;
X-CSE-ConnectionGUID: 7Yvw2Qb1Tx6QgwkeZzwGMw==
X-CSE-MsgGUID: qQaViWfWS3OuyZenfaRDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62487977"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="62487977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 20:54:05 -0700
X-CSE-ConnectionGUID: CLQP1AGMRHGCzfIv6/2rjQ==
X-CSE-MsgGUID: O3KmXy4JRfOEaYPWVx1+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="189455470"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Oct 2025 20:54:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC8sL-000E9x-1H;
	Fri, 24 Oct 2025 03:54:01 +0000
Date: Fri, 24 Oct 2025 11:53:54 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 0194b65ab571430130a11f8500894bb88f7af2c0
Message-ID: <202510241147.V38N56Lu-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_205405_675299_33512481 
X-CRM114-Status: UNSURE (   4.30  )
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
branch HEAD: 0194b65ab571430130a11f8500894bb88f7af2c0  nvme-pci: use blk_map_iter for p2p metadata

elapsed time: 1456m

configs tested: 218
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-001-20251024    clang-22
arc                   randconfig-002-20251023    gcc-8.5.0
arc                   randconfig-002-20251024    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                        multi_v7_defconfig    clang-22
arm                   randconfig-001-20251023    clang-22
arm                   randconfig-001-20251024    clang-22
arm                   randconfig-002-20251023    clang-19
arm                   randconfig-002-20251024    clang-22
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-003-20251024    clang-22
arm                   randconfig-004-20251023    gcc-8.5.0
arm                   randconfig-004-20251024    clang-22
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20251023    clang-22
arm64                 randconfig-001-20251024    clang-22
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-002-20251024    clang-22
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-003-20251024    clang-22
arm64                 randconfig-004-20251023    clang-17
arm64                 randconfig-004-20251024    clang-22
csky                              allnoconfig    clang-22
csky                  randconfig-001-20251023    gcc-11.5.0
csky                  randconfig-001-20251024    gcc-8.5.0
csky                  randconfig-002-20251023    gcc-13.4.0
csky                  randconfig-002-20251024    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251023    clang-22
hexagon               randconfig-001-20251024    gcc-8.5.0
hexagon               randconfig-002-20251023    clang-22
hexagon               randconfig-002-20251024    gcc-8.5.0
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-001-20251024    gcc-14
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-002-20251024    gcc-14
i386        buildonly-randconfig-003-20251023    gcc-14
i386        buildonly-randconfig-003-20251024    gcc-14
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-004-20251024    gcc-14
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-005-20251024    gcc-14
i386        buildonly-randconfig-006-20251023    clang-20
i386        buildonly-randconfig-006-20251024    gcc-14
i386                  randconfig-001-20251024    clang-20
i386                  randconfig-002-20251024    clang-20
i386                  randconfig-003-20251024    clang-20
i386                  randconfig-004-20251024    clang-20
i386                  randconfig-005-20251024    clang-20
i386                  randconfig-006-20251024    clang-20
i386                  randconfig-007-20251024    clang-20
i386                  randconfig-011-20251024    clang-20
i386                  randconfig-012-20251024    clang-20
i386                  randconfig-013-20251024    clang-20
i386                  randconfig-014-20251024    clang-20
i386                  randconfig-015-20251024    clang-20
i386                  randconfig-016-20251024    clang-20
i386                  randconfig-017-20251024    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251023    clang-22
loongarch             randconfig-001-20251024    gcc-8.5.0
loongarch             randconfig-002-20251023    clang-18
loongarch             randconfig-002-20251024    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    clang-22
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251023    gcc-8.5.0
nios2                 randconfig-001-20251024    gcc-8.5.0
nios2                 randconfig-002-20251023    gcc-8.5.0
nios2                 randconfig-002-20251024    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                 simple_smp_defconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251023    gcc-9.5.0
parisc                randconfig-001-20251024    gcc-8.5.0
parisc                randconfig-002-20251023    gcc-8.5.0
parisc                randconfig-002-20251024    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251023    gcc-12.5.0
powerpc               randconfig-001-20251024    gcc-8.5.0
powerpc               randconfig-002-20251023    clang-22
powerpc               randconfig-002-20251024    gcc-8.5.0
powerpc               randconfig-003-20251023    clang-22
powerpc               randconfig-003-20251024    gcc-8.5.0
powerpc                  storcenter_defconfig    clang-22
powerpc                     stx_gp3_defconfig    clang-22
powerpc64             randconfig-001-20251023    clang-22
powerpc64             randconfig-001-20251024    gcc-8.5.0
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-002-20251024    gcc-8.5.0
powerpc64             randconfig-003-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251024    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-001-20251024    clang-22
riscv                 randconfig-002-20251023    gcc-14.3.0
riscv                 randconfig-002-20251024    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251023    clang-19
s390                  randconfig-001-20251024    clang-22
s390                  randconfig-002-20251023    gcc-8.5.0
s390                  randconfig-002-20251024    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251023    gcc-15.1.0
sh                    randconfig-001-20251024    clang-22
sh                    randconfig-002-20251023    gcc-15.1.0
sh                    randconfig-002-20251024    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-12.5.0
sparc                 randconfig-001-20251024    clang-22
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc                 randconfig-002-20251024    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251023    clang-22
sparc64               randconfig-001-20251024    clang-22
sparc64               randconfig-002-20251023    gcc-8.5.0
sparc64               randconfig-002-20251024    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-13
um                    randconfig-001-20251024    clang-22
um                    randconfig-002-20251023    gcc-14
um                    randconfig-002-20251024    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251023    clang-20
x86_64      buildonly-randconfig-002-20251023    gcc-13
x86_64      buildonly-randconfig-003-20251023    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251023    clang-20
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251024    gcc-14
x86_64                randconfig-002-20251024    gcc-14
x86_64                randconfig-003-20251024    gcc-14
x86_64                randconfig-004-20251024    gcc-14
x86_64                randconfig-005-20251024    gcc-14
x86_64                randconfig-006-20251024    gcc-14
x86_64                randconfig-007-20251024    gcc-14
x86_64                randconfig-008-20251024    gcc-14
x86_64                randconfig-071-20251024    clang-20
x86_64                randconfig-072-20251024    clang-20
x86_64                randconfig-073-20251024    clang-20
x86_64                randconfig-074-20251024    clang-20
x86_64                randconfig-075-20251024    clang-20
x86_64                randconfig-076-20251024    clang-20
x86_64                randconfig-077-20251024    clang-20
x86_64                randconfig-078-20251024    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-001-20251024    clang-22
xtensa                randconfig-002-20251023    gcc-13.4.0
xtensa                randconfig-002-20251024    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

