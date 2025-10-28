Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90823CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+b14kOFjbItQv5DF7i/o1czw+d+Kn9IUPDkYnti8xqA=; b=Kgs+f6NdcAH6xI2X85NI9DTLty
	TjGY2bFPeT1r/h4PbCiFno3W6Qxi2c1OjtNrcPOyuPbTiLNUb32THwK//kMDFEWfh30tQhZ+mDLRN
	KO1LNhvULUrXNOBagSR9IFJ6//vs7xSvieIBDto6Hwl6qw8wcAmrqN9lrgMP1aTKYa7KWlnagAFfH
	m6XhSBL6EXtCiLNHCD/FOVzTQnx8xWs5SYpJ/18DZnKuhfJjvppBt8iJGh/7Y48VGdB3CjWK7JtI8
	XVTUa2T+b5kwgwZgUf2XxI5qKH5kUbAoMOfnmt1ygq0NgtsvmkdxF6MS5Fr2kJ8O4+szL2TGama3e
	RdscRp+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDn0Q-0000000GMPH-29qb;
	Tue, 28 Oct 2025 16:57:10 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDn0N-0000000GMOX-0xSJ
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 16:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761670627; x=1793206627;
  h=date:from:to:cc:subject:message-id;
  bh=bMdUnBAG1UVUN6C8XjofF6ImeLIeq5YLyL1UjzKKcLM=;
  b=ic545CyZ4L5q3Vu595xxIOTUrUSVdd1wPGwHSXE55n33LumLl60FvbXG
   2otBjA0RolXX0tdhs7zvrqxJusEb5Dh61yXFCmq0vnyn14yugJ4MLhlb1
   8075Sa2FyEzah2eIR1E7RpP19/73PFni2C3fJ98EPCz+bI8R0INkQVYly
   WuchhCtbYx80wJRW//GcYsh8/D9djRWlC/BlqMjr1nxonh9GKpHnDjCbf
   ONE9X5l3tQkuwVftMB/dlYvzBjW8y9xDbxVrqWB10BesVM8xnHZlMUgdb
   1ePRx/Ndp+Z/1wQxiIqVPbOy/cdFlw4zNkxfeIJYBjo2tliHYrfKkqnep
   Q==;
X-CSE-ConnectionGUID: S3TAXEK1SgSBz3lwF7ehtg==
X-CSE-MsgGUID: DPCcQcVbQcKEwFSVzYMLsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67642534"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="67642534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:57:05 -0700
X-CSE-ConnectionGUID: 51CsIGhzReSg9DJjR4RcKA==
X-CSE-MsgGUID: oWmGdqIBQ0KW1Xuz5RICiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185868672"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Oct 2025 09:57:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDn0F-000JU3-0H;
	Tue, 28 Oct 2025 16:56:59 +0000
Date: Wed, 29 Oct 2025 00:55:45 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD REGRESSION
 c0e502a7c9ca9ca951876b8bad5717ea9218244b
Message-ID: <202510290031.RWzOLU8q-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_095707_308007_0A0774AC 
X-CRM114-Status: UNSURE (   4.74  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.19
branch HEAD: c0e502a7c9ca9ca951876b8bad5717ea9218244b  nvme-pci: Add debug message on fail to read CSTS

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com

    drivers/nvme/host/nvme.h:1207:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../host/nvme.h:1207:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/../host/nvme.h:1207:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../target/nvmet.h:942:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/nvmet.h:942:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/nvmet.h:942:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-randconfig-001-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- arm-socfpga_defconfig
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- arm64-randconfig-002-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- arm64-randconfig-r133-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- csky-randconfig-002-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   |-- drivers-nvme-target-..-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- hexagon-randconfig-001-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-002-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-003-20251028
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-004-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-006-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-051-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- i386-randconfig-054-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- loongarch-randconfig-002-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- nios2-randconfig-002-20251028
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|-- powerpc64-randconfig-001-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- powerpc64-randconfig-002-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- powerpc64-randconfig-003-20251028
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- riscv-defconfig
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- s390-defconfig
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-buildonly-randconfig-002-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-buildonly-randconfig-003-20251028
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
`-- x86_64-buildonly-randconfig-005-20251028
    `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration

elapsed time: 1449m

configs tested: 142
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                        nsimosci_defconfig    clang-22
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-13.4.0
arc                   randconfig-002-20251028    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                   randconfig-001-20251028    clang-22
arm                   randconfig-001-20251028    gcc-8.5.0
arm                   randconfig-002-20251028    clang-22
arm                   randconfig-002-20251028    gcc-8.5.0
arm                   randconfig-003-20251028    clang-22
arm                   randconfig-003-20251028    gcc-8.5.0
arm                   randconfig-004-20251028    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251028    clang-22
arm64                 randconfig-002-20251028    clang-22
arm64                 randconfig-003-20251028    gcc-11.5.0
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251028    gcc-15.1.0
csky                  randconfig-002-20251028    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251028    clang-22
hexagon               randconfig-002-20251028    clang-17
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251028    gcc-12.5.0
loongarch             randconfig-002-20251028    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    clang-22
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251028    gcc-8.5.0
nios2                 randconfig-002-20251028    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251028    gcc-9.5.0
parisc                randconfig-002-20251028    gcc-8.5.0
powerpc                     akebono_defconfig    clang-22
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251028    gcc-15.1.0
powerpc               randconfig-002-20251028    gcc-11.5.0
powerpc               randconfig-003-20251028    gcc-8.5.0
powerpc                    socrates_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20251028    clang-22
powerpc64             randconfig-002-20251028    clang-22
powerpc64             randconfig-003-20251028    gcc-13.4.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    clang-22
sh                           se7343_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                            alldefconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20251028    clang-20
x86_64      buildonly-randconfig-001-20251028    gcc-14
x86_64      buildonly-randconfig-002-20251028    clang-20
x86_64      buildonly-randconfig-002-20251028    gcc-14
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    clang-20
x86_64                randconfig-003-20251028    clang-20
x86_64                randconfig-004-20251028    clang-20
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-011-20251028    clang-20
x86_64                randconfig-012-20251028    clang-20
x86_64                randconfig-013-20251028    clang-20
x86_64                randconfig-014-20251028    clang-20
x86_64                randconfig-015-20251028    clang-20
x86_64                randconfig-016-20251028    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

