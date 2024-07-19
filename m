Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C723C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FgrvgGdWPgPcQmMHH09No70d8kwuArf70/tPaoDXm0Y=; b=NCkhFlXcPco4+rPbdIkvC8QTwS
	kSQ28a0/7hEsshl3Cz2vgN+VlEmi23qD3i+YP+RdCgLbp9uRgq258WqLv1Xh5Ux/8NxOvNj3Rgg4l
	YXBvBuTix8bBx52xz/jNmOOThMJX5Pwyyh7YrMtAXz4N2/3VX9U07DQWOB7Y+4+14rvk0t+jExSmk
	smlMNgvZK5AOdmHCq5dCBSkkE9OJZWtvK+mKUq1vILsRdkm2BYHdEs41tABO4yneNaevRREZz94v5
	aAnlStjhgtF8cx9FenCOTsYK6M3mPqR7QKtdv4JB7mvYCe0FeBVX+a0DBm9nNMUO/JCH9zKgycKBz
	1d6/Jfaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUoTB-00000002v74-36Qh;
	Fri, 19 Jul 2024 14:20:25 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUoT9-00000002v6a-05wY
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 14:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721398823; x=1752934823;
  h=date:from:to:cc:subject:message-id;
  bh=tZ/ZK9iQhgOr4RgK9wwawCYHCt2ZM7hfz7zjdEiY90k=;
  b=FDudyB2z3fQkyBz+D6R1eJWhhhKcj3qqNR9fBq75/W3rM2QipB/GPErG
   wCx9rBrEKOPqCSySADKPJyZVKPfuvCgEY1tA4RZozu9w4EvR4f/F3zzzf
   ASh2cZl1tF0O+rGFdFBYGmoXIMrU/yEd7eAGWzqc60xSpPer3uJrtLNNu
   gUH6nRf1//OzCOS9r9AFERnnnXLoX1VG+uq8i/uYOG3QtBJwBYPlWE8l2
   fjiST0d8yW57bOK5RPd2+evTIYaQV7RDa+swc28p3ziwJdIE15K1hhbfF
   4O41QYyRI1Npu29z7Wwy7I8hoBZtOFPldDpR1H42Zdmlt8wyxBarL/7gH
   Q==;
X-CSE-ConnectionGUID: WaFxh1nqQ5uzSfVEUeTRMQ==
X-CSE-MsgGUID: uq0qXaiOTnilavKto1aZOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="19158072"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="19158072"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 07:20:22 -0700
X-CSE-ConnectionGUID: GTWjHOoTTm2P2GnJPfeXhg==
X-CSE-MsgGUID: Dw3qDrsCQDOiE2GdG8P3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="74349776"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jul 2024 07:20:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUoT5-000iF0-0i;
	Fri, 19 Jul 2024 14:20:19 +0000
Date: Fri, 19 Jul 2024 22:19:29 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 5cdaf261598c0974ed2d7597d8bca699dd332a09
Message-ID: <202407192226.WExFCA0Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_072023_100722_0C20886E 
X-CRM114-Status: UNSURE (   5.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: 5cdaf261598c0974ed2d7597d8bca699dd332a09  nvme_core: scan namespaces asynchronously

elapsed time: 1075m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240719   gcc-13.2.0
arc                   randconfig-002-20240719   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240719   gcc-13.2.0
arm                   randconfig-002-20240719   gcc-13.2.0
arm                   randconfig-003-20240719   gcc-13.2.0
arm                   randconfig-004-20240719   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240719   gcc-13.2.0
arm64                 randconfig-002-20240719   gcc-13.2.0
arm64                 randconfig-003-20240719   gcc-13.2.0
arm64                 randconfig-004-20240719   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240719   gcc-13.2.0
csky                  randconfig-002-20240719   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240719   clang-18
i386         buildonly-randconfig-002-20240719   clang-18
i386         buildonly-randconfig-003-20240719   clang-18
i386         buildonly-randconfig-003-20240719   gcc-10
i386         buildonly-randconfig-004-20240719   clang-18
i386         buildonly-randconfig-005-20240719   clang-18
i386         buildonly-randconfig-005-20240719   gcc-10
i386         buildonly-randconfig-006-20240719   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240719   clang-18
i386                  randconfig-002-20240719   clang-18
i386                  randconfig-003-20240719   clang-18
i386                  randconfig-004-20240719   clang-18
i386                  randconfig-004-20240719   gcc-13
i386                  randconfig-005-20240719   clang-18
i386                  randconfig-006-20240719   clang-18
i386                  randconfig-011-20240719   clang-18
i386                  randconfig-012-20240719   clang-18
i386                  randconfig-013-20240719   clang-18
i386                  randconfig-014-20240719   clang-18
i386                  randconfig-015-20240719   clang-18
i386                  randconfig-015-20240719   gcc-13
i386                  randconfig-016-20240719   clang-18
i386                  randconfig-016-20240719   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240719   gcc-13.2.0
loongarch             randconfig-002-20240719   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240719   gcc-13.2.0
nios2                 randconfig-002-20240719   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240719   gcc-13.2.0
parisc                randconfig-002-20240719   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240719   gcc-13.2.0
powerpc               randconfig-002-20240719   gcc-13.2.0
powerpc               randconfig-003-20240719   gcc-13.2.0
powerpc64             randconfig-002-20240719   gcc-13.2.0
powerpc64             randconfig-003-20240719   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240719   gcc-13.2.0
riscv                 randconfig-002-20240719   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240719   gcc-13.2.0
s390                  randconfig-002-20240719   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          r7785rp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240719   gcc-13.2.0
sh                    randconfig-002-20240719   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240719   gcc-13.2.0
sparc64               randconfig-002-20240719   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240719   gcc-13.2.0
um                    randconfig-002-20240719   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240719   gcc-13
x86_64       buildonly-randconfig-002-20240719   gcc-13
x86_64       buildonly-randconfig-003-20240719   gcc-13
x86_64       buildonly-randconfig-004-20240719   gcc-13
x86_64       buildonly-randconfig-005-20240719   gcc-13
x86_64       buildonly-randconfig-006-20240719   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240719   gcc-13
x86_64                randconfig-002-20240719   gcc-13
x86_64                randconfig-003-20240719   gcc-13
x86_64                randconfig-004-20240719   gcc-13
x86_64                randconfig-005-20240719   gcc-13
x86_64                randconfig-006-20240719   gcc-13
x86_64                randconfig-011-20240719   gcc-13
x86_64                randconfig-012-20240719   gcc-13
x86_64                randconfig-013-20240719   gcc-13
x86_64                randconfig-014-20240719   gcc-13
x86_64                randconfig-015-20240719   gcc-13
x86_64                randconfig-016-20240719   gcc-13
x86_64                randconfig-071-20240719   gcc-13
x86_64                randconfig-072-20240719   gcc-13
x86_64                randconfig-073-20240719   gcc-13
x86_64                randconfig-074-20240719   gcc-13
x86_64                randconfig-075-20240719   gcc-13
x86_64                randconfig-076-20240719   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240719   gcc-13.2.0
xtensa                randconfig-002-20240719   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

