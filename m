Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C96CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JwYDV+qo6iPImYv5/LMWzekHdnYHeCMoK0NP/W0pKBk=; b=22LrgZSbOuslY/ymHLPy7I0Rze
	a5zZFEkRZmAx+kQmDVg5nrzjhKala/8ASXVu8wfMosazidxbI8yPOQVlKDnpT3l1Vz2ky43w8xwen
	8o/8II8SHgGa/LlZOlBih0OVLYj92JsJo2IRSKyBrHP6Wxp65BLHGxFtRy1F+PI2RoYOFki2yVJMq
	xLaLYuIxyKvEltj20fudAN/qEn+ZYOKBJz5ceRQlMaDAOFs1/xPXTwdVSoDSLgqRt5JxpdIm6xdW9
	qe8sjh9nKax5/ElVkrBUfoH7JZ/x70xGlTnpFvLCEXhG2oWvQfDG7AHtqL4NlIZjcm0uID/K45ptj
	9myRWFrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Fi0-00000008xML-0bVj;
	Fri, 10 Oct 2025 16:11:08 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Fhu-00000008xLz-3Z9F
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 16:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760112663; x=1791648663;
  h=date:from:to:cc:subject:message-id;
  bh=BKRrXgb5QKnuLnvqK/Nb6nxLrJFIVVWVSd7IMLn1VVY=;
  b=ayvtKub4E/7fNNYC4hZ1SCPZ5tFosjBuy/41U3QX0IHWi/5c4mLdD5oy
   pdrUP1o81ByAoXKd0kvD8VqNGjxT1SRIJxtONHwh1tVfyDpFcPoP5FVfk
   vq1MegmlvMcrP17DeXm3s1P9mxfB2rE3y1PP5WnGSQOtb8HQmmSp5TCWj
   wNRq9CqW3WIn1SMiftgdGMgWEmd5gRoEo1rKT+IAazEWfhcfk6u6aTTPN
   R+8q1eN1t173l7nWSLfSycR91EXKmZiAFWDV7+xjTTUfBj5Mqh6e1NYgw
   0H02ZIkX4nZMYYQebpuV5jJMkxlTDybdqaqJ8KYm0VrydIIugqXy4ljFa
   g==;
X-CSE-ConnectionGUID: 2Dfz+9VOSAOcLxAsDzknSQ==
X-CSE-MsgGUID: cFN9NeoYTyWGz9yMzBGCHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="49896369"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="49896369"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:10:59 -0700
X-CSE-ConnectionGUID: jouU8NmhRSWcQfVdKj60Mw==
X-CSE-MsgGUID: GRoZ7uNfQLWhNCHT5PSmMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180264945"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2025 09:10:57 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Fhn-0002wV-0X;
	Fri, 10 Oct 2025 16:10:55 +0000
Date: Sat, 11 Oct 2025 00:10:23 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD REGRESSION
 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
Message-ID: <202510110002.OsfGCWgs-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_091102_934926_95822AA6 
X-CRM114-Status: UNSURE (   4.05  )
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
branch HEAD: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b  nvmet: pci-epf: fix DMA channel debug print

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com

    drivers/nvme/host/nvme.h:1207:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/host/nvme.h:1214:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../host/nvme.h:1205:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/../host/nvme.h:1207:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/../host/nvme.h:1207:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../host/nvme.h:1214:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/../host/nvme.h:1214:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../target/nvmet.h:940:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/../target/nvmet.h:940:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/../target/nvmet.h:942:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/nvmet.h:940:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/nvmet.h:940:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration
    drivers/nvme/target/nvmet.h:942:27: error: redefinition of 'nvme_auth_extract_key'
    drivers/nvme/target/nvmet.h:942:27: error: static declaration of 'nvme_auth_extract_key' follows non-static declaration

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-defconfig
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- arm64-randconfig-002-20251010
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-001-20251009
|   `-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-buildonly-randconfig-001-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-006-20251010
|   `-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-007-20251010
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-013-20251009
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-..-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- i386-randconfig-014-20251009
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-062-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-063-20251010
|   |-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- i386-randconfig-r072-20251010
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- loongarch-defconfig
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- loongarch-randconfig-001-20251010
|   `-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- loongarch-randconfig-002-20251010
|   |-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- mips-randconfig-r133-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- nios2-randconfig-002-20251010
|   |-- drivers-nvme-target-..-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- parisc-randconfig-001-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|-- parisc-randconfig-002-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- powerpc64-randconfig-001-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- powerpc64-randconfig-003-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- riscv-randconfig-001-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- riscv-randconfig-r123-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   |-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- s390-randconfig-002-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- sh-randconfig-002-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- sparc-randconfig-002-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- sparc64-randconfig-001-20251010
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- sparc64-randconfig-002-20251009
|   `-- drivers-nvme-target-nvmet.h:error:redefinition-of-nvme_auth_extract_key
|-- sparc64-randconfig-002-20251010
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-buildonly-randconfig-004-20251010
|   `-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-kexec
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key
|-- x86_64-randconfig-006-20251010
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-randconfig-078-20251010
|   `-- drivers-nvme-target-nvmet.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4-bpf
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4-func
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4-kselftests
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4-kunit
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|-- x86_64-rhel-9.4-ltp
|   |-- drivers-nvme-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
|   `-- drivers-nvme-target-..-host-nvme.h:error:static-declaration-of-nvme_auth_extract_key-follows-non-static-declaration
`-- xtensa-randconfig-001-20251010
    `-- drivers-nvme-target-..-host-nvme.h:error:redefinition-of-nvme_auth_extract_key

elapsed time: 1474m

configs tested: 230
configs skipped: 6

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251010    gcc-12.5.0
arc                   randconfig-001-20251010    gcc-8.5.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251010    gcc-13.4.0
arm                   randconfig-002-20251010    gcc-8.5.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251010    gcc-14.3.0
arm64                 randconfig-001-20251010    gcc-8.5.0
arm64                 randconfig-002-20251010    clang-19
arm64                 randconfig-002-20251010    gcc-8.5.0
arm64                 randconfig-003-20251010    clang-17
arm64                 randconfig-003-20251010    gcc-8.5.0
arm64                 randconfig-004-20251010    gcc-15.1.0
arm64                 randconfig-004-20251010    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251010    gcc-14.3.0
csky                  randconfig-001-20251010    gcc-15.1.0
csky                  randconfig-002-20251010    gcc-10.5.0
csky                  randconfig-002-20251010    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251010    clang-22
hexagon               randconfig-001-20251010    gcc-14.3.0
hexagon               randconfig-002-20251010    clang-18
hexagon               randconfig-002-20251010    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    clang-20
i386        buildonly-randconfig-002-20251010    gcc-14
i386        buildonly-randconfig-003-20251010    clang-20
i386        buildonly-randconfig-003-20251010    gcc-14
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251010    gcc-14
i386                  randconfig-012-20251010    gcc-14
i386                  randconfig-013-20251010    gcc-14
i386                  randconfig-014-20251010    gcc-14
i386                  randconfig-015-20251010    gcc-14
i386                  randconfig-016-20251010    gcc-14
i386                  randconfig-017-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251010    clang-22
loongarch             randconfig-001-20251010    gcc-14.3.0
loongarch             randconfig-002-20251010    gcc-14.3.0
loongarch             randconfig-002-20251010    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251010    gcc-11.5.0
nios2                 randconfig-001-20251010    gcc-14.3.0
nios2                 randconfig-002-20251010    gcc-14.3.0
nios2                 randconfig-002-20251010    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251010    gcc-14.3.0
parisc                randconfig-001-20251010    gcc-8.5.0
parisc                randconfig-002-20251010    gcc-12.5.0
parisc                randconfig-002-20251010    gcc-14.3.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251010    clang-22
powerpc               randconfig-001-20251010    gcc-14.3.0
powerpc               randconfig-002-20251010    gcc-14.3.0
powerpc               randconfig-002-20251010    gcc-15.1.0
powerpc               randconfig-003-20251010    clang-22
powerpc               randconfig-003-20251010    gcc-14.3.0
powerpc                     redwood_defconfig    gcc-15.1.0
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251010    clang-22
powerpc64             randconfig-001-20251010    gcc-14.3.0
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251010    gcc-13.4.0
powerpc64             randconfig-003-20251010    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251010    clang-22
riscv                 randconfig-001-20251010    gcc-9.5.0
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251010    gcc-14.3.0
s390                  randconfig-001-20251010    gcc-9.5.0
s390                  randconfig-002-20251010    clang-22
s390                  randconfig-002-20251010    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251010    gcc-15.1.0
sh                    randconfig-001-20251010    gcc-9.5.0
sh                    randconfig-002-20251010    gcc-15.1.0
sh                    randconfig-002-20251010    gcc-9.5.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251010    gcc-11.5.0
sparc                 randconfig-001-20251010    gcc-9.5.0
sparc                 randconfig-002-20251010    gcc-8.5.0
sparc                 randconfig-002-20251010    gcc-9.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251010    clang-20
sparc64               randconfig-001-20251010    gcc-9.5.0
sparc64               randconfig-002-20251010    gcc-10.5.0
sparc64               randconfig-002-20251010    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251010    gcc-14
um                    randconfig-001-20251010    gcc-9.5.0
um                    randconfig-002-20251010    gcc-14
um                    randconfig-002-20251010    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251010    clang-20
x86_64      buildonly-randconfig-001-20251010    gcc-14
x86_64      buildonly-randconfig-002-20251010    clang-20
x86_64      buildonly-randconfig-002-20251010    gcc-14
x86_64      buildonly-randconfig-003-20251010    clang-20
x86_64      buildonly-randconfig-003-20251010    gcc-14
x86_64      buildonly-randconfig-004-20251010    clang-20
x86_64      buildonly-randconfig-004-20251010    gcc-14
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251010    clang-20
x86_64                randconfig-002-20251010    clang-20
x86_64                randconfig-003-20251010    clang-20
x86_64                randconfig-004-20251010    clang-20
x86_64                randconfig-005-20251010    clang-20
x86_64                randconfig-006-20251010    clang-20
x86_64                randconfig-007-20251010    clang-20
x86_64                randconfig-008-20251010    clang-20
x86_64                randconfig-071-20251010    clang-20
x86_64                randconfig-072-20251010    clang-20
x86_64                randconfig-073-20251010    clang-20
x86_64                randconfig-074-20251010    clang-20
x86_64                randconfig-075-20251010    clang-20
x86_64                randconfig-076-20251010    clang-20
x86_64                randconfig-077-20251010    clang-20
x86_64                randconfig-078-20251010    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251010    gcc-8.5.0
xtensa                randconfig-001-20251010    gcc-9.5.0
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

