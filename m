Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF695CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x6liWphVW1uy/vmnkCw63INVsbSvVDoeUkyU0+5CTUg=; b=A0mE5zcRdJ3qAIMCaRD8ECqAhj
	BNWZrz00HhbzHZF/KNKjWZtx/Vs4Z3T8Ro6XV0+TDb5lcOt8Qc/51ykJ74GnUD2L3ExT+1lKUvcen
	TOJlxy/EcJ3XwtR9NIMWHDksAlu4J/jzIaPNU3ygUSmT5Gbvj0FMClDibbij5iMvQL82yTcJbCi+M
	FmaOMYYllKpuvF90Xd0kNPdGIm410QwdK3rDRx74gzXWEWUIcoQKgriCin8QL970CrFq9frMJGLdy
	xi1hIta/adPt2WJMMJoZszwXznrkG97Q0wgejgnLaOxBEHz0IFyyVlxrmJu2mlCy2OGhIPpr4J+hj
	uV7OMjRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3wMU-00000007wvE-3EXk;
	Wed, 01 Oct 2025 12:55:14 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3wMO-00000007wuq-1KPC
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 12:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759323309; x=1790859309;
  h=date:from:to:cc:subject:message-id;
  bh=yEna6zfS2xWu4hYLjKLSbBsgFk8+i3YQPYtHZN+d0dg=;
  b=bwlN934CZDv1FZGEIVx4kmt3JmpVnVedgq1d10XIGaeVg2iuBIPm2r5J
   cRwH4iP38Ku2I9mIy+J2A2RALncf0XaDeREz/7KAJMnHIC1Y+JpPTSqJc
   OrJm53+pdQISO/L0Y2Hp5NsaN+RMXivafojAlumIAMO5WAtefHuqwmiY1
   kOJNGU2wEhm0lcw/cVwwjcEP98aIWkQMoh15N/PiuQDfWhShiPdoA/QaQ
   356koYNGowRAVUimSUyGhAwPc5Ii1DIw+1McPiCCEei6aYHuVY86sBoUv
   PHLdQPVUA71TWXdz58GD4Dca8UtHS8R8DY62kcKMhbW3rW7vy0BOmpoSq
   g==;
X-CSE-ConnectionGUID: hbxQOFgZR8CvpsYMReKQPg==
X-CSE-MsgGUID: pcOMdUBbQwOldFDAGBi7PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65232017"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="65232017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 05:55:03 -0700
X-CSE-ConnectionGUID: Vdpt4GcZRNaXYBaREv9htA==
X-CSE-MsgGUID: 2A9K9xzQTBa/dpv743STYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178384717"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Oct 2025 05:55:01 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3wME-000319-1C;
	Wed, 01 Oct 2025 12:54:58 +0000
Date: Wed, 01 Oct 2025 20:54:56 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD REGRESSION
 876f5e3e3b1e3e78aec9b7e53bec4b949a13ce09
Message-ID: <202510012042.CJUVM16o-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_055508_444257_885B55E3 
X-CRM114-Status: UNSURE (   5.66  )
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
branch HEAD: 876f5e3e3b1e3e78aec9b7e53bec4b949a13ce09  nvmet: add configfs attribute 'dhchap_keyring'

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509302151.WHyjRfcE-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202509302359.TL1868ni-lkp@intel.com

    csky-linux-ld: drivers/nvme/host/fabrics.c:1112:(.text+0x16e2): undefined reference to `nvme_auth_extract_key'
    drivers/nvme/host/fabrics.c:1097:(.text+0x166c): undefined reference to `nvme_auth_extract_key'
    include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    include/linux/nvme-keyring.h:52:27: warning: 'nvme_dhchap_psk_lookup' declared 'static' but never defined [-Wunused-function]
    include/linux/nvme-keyring.h:54:1: error: expected identifier or '('
    include/linux/nvme-keyring.h:54:1: error: expected identifier or '(' before '{' token
    include/linux/nvme-keyring.h:57:4: warning: no previous prototype for 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
    include/linux/nvme-keyring.h:57:4: warning: no previous prototype for function 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-randconfig-001-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- arm-randconfig-001-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(-before-token
|   |-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|   `-- include-linux-nvme-keyring.h:warning:nvme_dhchap_psk_lookup-declared-static-but-never-defined
|-- csky-randconfig-002-20250930
|   |-- csky-linux-ld:drivers-nvme-host-fabrics.c:(.text):undefined-reference-to-nvme_auth_extract_key
|   |-- drivers-nvme-host-fabrics.c:(.text):undefined-reference-to-nvme_auth_extract_key
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-buildonly-randconfig-002-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- loongarch-randconfig-002-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- nios2-randconfig-001-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(-before-token
|   |-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|   `-- include-linux-nvme-keyring.h:warning:nvme_dhchap_psk_lookup-declared-static-but-never-defined
|-- parisc-randconfig-001-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- powerpc-randconfig-003-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- riscv-defconfig
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- riscv-randconfig-002-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- s390-defconfig
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- sh-randconfig-001-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- sh-randconfig-002-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- sparc-randconfig-001-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(-before-token
|   |-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|   `-- include-linux-nvme-keyring.h:warning:nvme_dhchap_psk_lookup-declared-static-but-never-defined
|-- sparc-randconfig-002-20250930
|   `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int
|-- um-randconfig-002-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(-before-token
|   |-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|   `-- include-linux-nvme-keyring.h:warning:nvme_dhchap_psk_lookup-declared-static-but-never-defined
|-- x86_64-buildonly-randconfig-005-20250930
|   |-- include-linux-nvme-keyring.h:error:expected-identifier-or-(-before-token
|   |-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|   `-- include-linux-nvme-keyring.h:warning:nvme_dhchap_psk_lookup-declared-static-but-never-defined
`-- xtensa-randconfig-002-20250930
    `-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-size_t-aka-unsigned-int

elapsed time: 1442m

configs tested: 128
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250930    gcc-9.5.0
arc                   randconfig-002-20250930    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         assabet_defconfig    clang-18
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250930    gcc-13.4.0
arm                   randconfig-002-20250930    gcc-8.5.0
arm                   randconfig-003-20250930    gcc-8.5.0
arm                   randconfig-004-20250930    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250930    clang-18
arm64                 randconfig-002-20250930    clang-22
arm64                 randconfig-003-20250930    clang-18
arm64                 randconfig-004-20250930    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250930    gcc-13.4.0
csky                  randconfig-002-20250930    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250930    clang-22
hexagon               randconfig-002-20250930    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250930    gcc-12
i386        buildonly-randconfig-002-20250930    gcc-14
i386        buildonly-randconfig-003-20250930    clang-20
i386        buildonly-randconfig-004-20250930    gcc-14
i386        buildonly-randconfig-005-20250930    clang-20
i386        buildonly-randconfig-006-20250930    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250930    clang-22
loongarch             randconfig-002-20250930    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250930    gcc-8.5.0
nios2                 randconfig-002-20250930    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250930    gcc-12.5.0
parisc                randconfig-002-20250930    gcc-9.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc               randconfig-001-20250930    gcc-8.5.0
powerpc               randconfig-002-20250930    gcc-14.3.0
powerpc               randconfig-003-20250930    gcc-15.1.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250930    gcc-14.3.0
powerpc64             randconfig-002-20250930    gcc-12.5.0
powerpc64             randconfig-003-20250930    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250930    gcc-10.5.0
riscv                 randconfig-002-20250930    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250930    gcc-12.5.0
s390                  randconfig-002-20250930    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250930    gcc-15.1.0
sh                    randconfig-002-20250930    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250930    gcc-11.5.0
sparc                 randconfig-002-20250930    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250930    clang-22
sparc64               randconfig-002-20250930    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250930    gcc-14
um                    randconfig-002-20250930    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250930    clang-20
x86_64      buildonly-randconfig-002-20250930    gcc-14
x86_64      buildonly-randconfig-003-20250930    gcc-14
x86_64      buildonly-randconfig-004-20250930    clang-20
x86_64      buildonly-randconfig-005-20250930    gcc-14
x86_64      buildonly-randconfig-006-20250930    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250930    gcc-12.5.0
xtensa                randconfig-002-20250930    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

