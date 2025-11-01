Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2564CCFA00
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Nov 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KsgJ8QfqGQtE4GqU+DNyGH1nVBMqlm4rUXk6X49kCSs=; b=WqMX6BiGuSxOFsbvnvyUzuQv6F
	HjgHmPCZHrSxBJpDTpadBblXzdd+/0ZWsSlSzqg/vUen0FkoUB97p/KUHw4LtVZ2Q/njNkFfLiuLT
	BOqmGPYKtIabhXp2WbI+wYDrt7onLryN7Q7ILvJ4rZSsMS/mGxzHjiR0JSmcWkoQFuTgcUY203Dwh
	5CUUvmSjTfPPTFvVX1ezGg1A/FNu+tTnDoU4fOOzNBswugy54gS9LoxoWUYxNIjN7yIC7Cubx2w1o
	pQCzGOmD80hzJTmw2QpL+sd7paHlVbcCd5mHCYXoBD9idTpTXxM14bTzYErHUQqc4MAAy1sMH7fbp
	uj6AAI1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFE1f-00000007uWg-0Bbj;
	Sat, 01 Nov 2025 16:00:23 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFE1c-00000007uWK-1cji
	for linux-nvme@lists.infradead.org;
	Sat, 01 Nov 2025 16:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762012820; x=1793548820;
  h=date:from:to:cc:subject:message-id;
  bh=hp3ZonShhc5i4jpv2AkRYgae6+X4Y+r+MOttXY6lKTM=;
  b=dwDWG1o7WMHM7Rjg3gqdYdqFec2zR5umrvc5U5ipxPXUjRKnDBOzdPpu
   MH6BPmZf7zcQRxb3qA5HU95eBM46JyJevD1l6VxFxXLH9xbPnosshKRGG
   ai9HCdmB0zkTpnaKQONU7Zj89eYM4CJvc1hhkUeLoD/59eqMk3zJyVhp1
   Ukad+s03llVSYEpf3XuXxz6j8Svgb7X1mdEMOIuZXasHbPvhcX0cvQySu
   R0HpF0u9/1hQ8n46W9sqDxg2rTZdDc5ghh/rXpmfRiui0y8+YreqREYPd
   EkZ/GUjWHhGWTjgBOG+gTnV33bPKGYSuAWJDNIcpHXuciuxCI/esqM09C
   g==;
X-CSE-ConnectionGUID: csHGMNpkQ0CeVA3GPcX1jg==
X-CSE-MsgGUID: xF11wWYzTvisHKa5g+Odug==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="74756386"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="74756386"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 09:00:20 -0700
X-CSE-ConnectionGUID: +mXmUz90TrGdd9KyYiLpwA==
X-CSE-MsgGUID: RdOcOESyR5KXLd9lETiaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="186170703"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Nov 2025 09:00:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFE1Y-000OQa-2e;
	Sat, 01 Nov 2025 16:00:16 +0000
Date: Sat, 01 Nov 2025 23:59:33 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD REGRESSION
 453ba3089d4570c2be2e230e1e7a287eac4b306b
Message-ID: <202511012325.I2Uc2Y6j-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_090020_471169_70CD45E5 
X-CRM114-Status: UNSURE (   4.13  )
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
branch HEAD: 453ba3089d4570c2be2e230e1e7a287eac4b306b  nvme: fixup nvme auth host/target dependency

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511011103.e6eXLAln-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202511011105.ef5UauN7-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202511012300.eAcEQQP5-lkp@intel.com

    drivers/nvme/common/auth.c:158:13: error: redefinition of 'nvme_auth_extract_key'
    include/linux/nvme-keyring.h:57:4: warning: no previous prototype for 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
    include/linux/nvme-keyring.h:57:4: warning: no previous prototype for function 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-061-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- parisc-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- parisc-randconfig-002-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- powerpc-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- powerpc64-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- s390-randconfig-r064-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- sparc-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- sparc64-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- sparc64-randconfig-002-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- um-randconfig-001-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- um-randconfig-r061-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- um-randconfig-r063-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- x86_64-allmodconfig
|   `-- drivers-nvme-common-auth.c:error:redefinition-of-nvme_auth_extract_key
|-- x86_64-randconfig-102-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- x86_64-randconfig-103-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
|-- x86_64-randconfig-104-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash
|-- x86_64-randconfig-121-20251101
|   `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-function-nvme_dhchap_psk_hash
`-- xtensa-randconfig-002-20251101
    `-- include-linux-nvme-keyring.h:warning:no-previous-prototype-for-nvme_dhchap_psk_hash

elapsed time: 1455m

configs tested: 67
configs skipped: 3

tested configs:
alpha                    allnoconfig    gcc-15.1.0
arc                      allnoconfig    gcc-15.1.0
arc          randconfig-001-20251101    gcc-8.5.0
arc          randconfig-002-20251101    gcc-8.5.0
arm                      allnoconfig    clang-22
arm          randconfig-001-20251101    gcc-13.4.0
arm          randconfig-002-20251101    clang-22
arm          randconfig-003-20251101    clang-18
arm          randconfig-004-20251101    clang-22
arm                 sp7021_defconfig    gcc-15.1.0
arm64                    allnoconfig    gcc-15.1.0
csky                     allnoconfig    gcc-15.1.0
hexagon                  allnoconfig    clang-22
hexagon      randconfig-001-20251101    clang-22
hexagon      randconfig-002-20251101    clang-22
i386                    alldefconfig    gcc-14
i386                     allnoconfig    gcc-14
loongarch                allnoconfig    clang-22
loongarch    randconfig-001-20251101    clang-18
loongarch    randconfig-002-20251101    clang-19
m68k                     allnoconfig    gcc-15.1.0
m68k              m5249evb_defconfig    gcc-15.1.0
microblaze               allnoconfig    gcc-15.1.0
mips                     allnoconfig    gcc-15.1.0
mips               bcm63xx_defconfig    clang-22
nios2                    allnoconfig    gcc-11.5.0
nios2                      defconfig    gcc-11.5.0
nios2        randconfig-001-20251101    gcc-9.5.0
nios2        randconfig-002-20251101    gcc-8.5.0
openrisc                 allnoconfig    gcc-15.1.0
openrisc                   defconfig    gcc-15.1.0
parisc                   allnoconfig    gcc-15.1.0
parisc       randconfig-001-20251101    gcc-11.5.0
parisc       randconfig-002-20251101    gcc-8.5.0
powerpc                  allnoconfig    gcc-15.1.0
powerpc        linkstation_defconfig    clang-20
powerpc      randconfig-001-20251101    gcc-11.5.0
powerpc      randconfig-002-20251101    clang-22
powerpc64    randconfig-001-20251101    gcc-11.5.0
powerpc64    randconfig-002-20251101    clang-20
riscv                    allnoconfig    gcc-15.1.0
riscv        randconfig-001-20251101    gcc-8.5.0
riscv        randconfig-002-20251101    gcc-8.5.0
s390                     allnoconfig    clang-22
s390         randconfig-001-20251101    clang-17
s390         randconfig-002-20251101    clang-22
sh                       allnoconfig    gcc-15.1.0
sh                         defconfig    gcc-15.1.0
sh           randconfig-001-20251101    gcc-15.1.0
sh           randconfig-002-20251101    gcc-15.1.0
sh          secureedge5410_defconfig    gcc-15.1.0
sparc                    allnoconfig    gcc-15.1.0
sparc        randconfig-001-20251101    gcc-15.1.0
sparc        randconfig-002-20251101    gcc-14.3.0
sparc64                    defconfig    clang-20
sparc64      randconfig-001-20251101    gcc-15.1.0
sparc64      randconfig-002-20251101    clang-22
um                       allnoconfig    clang-22
um                         defconfig    clang-22
um           randconfig-001-20251101    clang-16
um           randconfig-002-20251101    gcc-14
x86_64                   allnoconfig    clang-20
x86_64                     defconfig    gcc-14
xtensa                   allnoconfig    gcc-15.1.0
xtensa         cadence_csp_defconfig    gcc-15.1.0
xtensa       randconfig-001-20251101    gcc-13.4.0
xtensa       randconfig-002-20251101    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

