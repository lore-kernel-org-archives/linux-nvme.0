Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56444CCD194
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iX20txq2dcyrhqiYBeswCuLE5LODcThdf98ufACNw6M=; b=V8jtev45ojLNPMI4ekdz7arimo
	yHXelmkavZMDm5NZBnwzahb/lZ8MgXiXLj80XSA89+eIaR/7UC4T4IK4o7aiDXEH2XGFUUeKNVSl1
	bfzSZgLQ5o+jiXwKukdQKxB0uDqHgcIidNPUQ8njTNWrfx5ngi0+wFDu0CGueeUHQr+jzAnHLVU7y
	BupJCQjExsVYHq3Zlp4QDBYzS70tSblI+XXmOGOH8eUb0laWAtpuuvIVoGBbbjdcgKddSch5JdfUD
	Bq7lHdaXuP6+mbceH1SD5acMu2QqXf1Cu+RRejSzDi8F04AXV5ojOeJVs9gHiRYrJTLIvb4DVlh3w
	4RgVTLIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v947l-00000002G1o-24Dh;
	Wed, 15 Oct 2025 16:13:13 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v947e-00000002G1Q-1cxI
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 16:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760544786; x=1792080786;
  h=date:from:to:cc:subject:message-id;
  bh=hS9LaAfeqLxEx6p0ilb9sQvnM/eIiwTlEnvBJ9r6EkY=;
  b=d8eNIEukHsvg2VO5Oez+eXXnDkrb7Ks9wdghhh3GgYKxepq7QAoefLwV
   ryIHUyN+yrJm/eNHbykP0a/CVrK0iPt+e7EuwfN98y8weGJPWTca7HHMK
   GaLPFCf2NgPFASX4oiuGnq1dUZnpBf956JmnmqZNMkDfXBXwC1SfzCwgH
   kXLyhTCD9DWfAN7MxKyJjmHNBU8ZRuZxN+PDkD954geOULY0yo8aIuF7R
   uv1trlUdWY3qfBIPWdEtdJNpTr3Wv8lZCeiI1rzMIG6JRkiM/ffjznECs
   OAunjBAvVT1Pzq3nJspNs0PlnEjCOtN7vlkcfDyu8+rjzsNwYCpFhniay
   Q==;
X-CSE-ConnectionGUID: wsNYzHm3TlWUPJKHD72AVw==
X-CSE-MsgGUID: 6QMCagNITUed9TbpTuGD6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62875653"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62875653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:13:04 -0700
X-CSE-ConnectionGUID: aFTEQGiUQuO7LZDDyjK54A==
X-CSE-MsgGUID: xDIStWYvTDmLvglYCNrq5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="182617847"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2025 09:13:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v946u-00040U-1a;
	Wed, 15 Oct 2025 16:12:44 +0000
Date: Thu, 16 Oct 2025 00:08:47 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 7e091add9c433bab6912228799bf508e2414acc3
Message-ID: <202510160041.ZDTnWXsL-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251015_091306_504132_F56569AC 
X-CRM114-Status: UNSURE (   4.75  )
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
branch HEAD: 7e091add9c433bab6912228799bf508e2414acc3  nvme-auth: update sc_c in host response

elapsed time: 1446m

configs tested: 233
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    clang-22
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-002-20251015    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                   randconfig-001-20251015    clang-22
arm                   randconfig-001-20251015    gcc-8.5.0
arm                   randconfig-002-20251015    clang-22
arm                   randconfig-002-20251015    gcc-8.5.0
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-004-20251015    clang-22
arm                   randconfig-004-20251015    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251015    clang-22
arm64                 randconfig-001-20251015    gcc-8.5.0
arm64                 randconfig-002-20251015    gcc-13.4.0
arm64                 randconfig-002-20251015    gcc-8.5.0
arm64                 randconfig-003-20251015    clang-22
arm64                 randconfig-003-20251015    gcc-8.5.0
arm64                 randconfig-004-20251015    clang-22
arm64                 randconfig-004-20251015    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251015    clang-22
csky                  randconfig-001-20251015    gcc-15.1.0
csky                  randconfig-002-20251015    clang-22
csky                  randconfig-002-20251015    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-002-20251015    clang-19
hexagon               randconfig-002-20251015    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251015    clang-20
i386        buildonly-randconfig-001-20251015    gcc-13
i386        buildonly-randconfig-002-20251015    clang-20
i386        buildonly-randconfig-002-20251015    gcc-14
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251015    clang-20
i386                  randconfig-002-20251015    clang-20
i386                  randconfig-003-20251015    clang-20
i386                  randconfig-004-20251015    clang-20
i386                  randconfig-005-20251015    clang-20
i386                  randconfig-006-20251015    clang-20
i386                  randconfig-007-20251015    clang-20
i386                  randconfig-011-20251015    clang-20
i386                  randconfig-012-20251015    clang-20
i386                  randconfig-013-20251015    clang-20
i386                  randconfig-014-20251015    clang-20
i386                  randconfig-015-20251015    clang-20
i386                  randconfig-016-20251015    clang-20
i386                  randconfig-017-20251015    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251015    clang-22
loongarch             randconfig-001-20251015    gcc-15.1.0
loongarch             randconfig-002-20251015    clang-22
loongarch             randconfig-002-20251015    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251015    clang-22
nios2                 randconfig-001-20251015    gcc-8.5.0
nios2                 randconfig-002-20251015    clang-22
nios2                 randconfig-002-20251015    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    clang-22
parisc                randconfig-001-20251015    gcc-9.5.0
parisc                randconfig-002-20251015    clang-22
parisc                randconfig-002-20251015    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251015    clang-22
powerpc               randconfig-001-20251015    gcc-15.1.0
powerpc               randconfig-002-20251015    clang-22
powerpc               randconfig-002-20251015    gcc-12.5.0
powerpc               randconfig-003-20251015    clang-22
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251015    clang-22
powerpc64             randconfig-003-20251015    gcc-13.4.0
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251015    clang-22
riscv                 randconfig-001-20251015    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251015    clang-22
s390                  randconfig-001-20251015    gcc-12.5.0
s390                  randconfig-002-20251015    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                    randconfig-001-20251015    clang-22
sh                    randconfig-001-20251015    gcc-11.5.0
sh                    randconfig-002-20251015    clang-22
sh                    randconfig-002-20251015    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    clang-22
sparc                 randconfig-001-20251015    gcc-8.5.0
sparc                 randconfig-002-20251015    clang-22
sparc                 randconfig-002-20251015    gcc-13.4.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-002-20251015    clang-22
sparc64               randconfig-002-20251015    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-002-20251015    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-001-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-003-20251015    gcc-13
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-004-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-14
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251015    clang-20
x86_64                randconfig-002-20251015    clang-20
x86_64                randconfig-003-20251015    clang-20
x86_64                randconfig-004-20251015    clang-20
x86_64                randconfig-005-20251015    clang-20
x86_64                randconfig-006-20251015    clang-20
x86_64                randconfig-007-20251015    clang-20
x86_64                randconfig-008-20251015    clang-20
x86_64                randconfig-071-20251015    gcc-14
x86_64                randconfig-072-20251015    gcc-14
x86_64                randconfig-073-20251015    gcc-14
x86_64                randconfig-074-20251015    gcc-14
x86_64                randconfig-075-20251015    gcc-14
x86_64                randconfig-076-20251015    gcc-14
x86_64                randconfig-077-20251015    gcc-14
x86_64                randconfig-078-20251015    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251015    clang-22
xtensa                randconfig-001-20251015    gcc-9.5.0
xtensa                randconfig-002-20251015    clang-22
xtensa                randconfig-002-20251015    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

