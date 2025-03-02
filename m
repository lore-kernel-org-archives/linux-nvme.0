Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC54C021B8
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Mar 2025 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jSJ5axX4TXf3tghrSR4xs1tAKqk6R5CvRY5TeXwPnKU=; b=huZ7oNg7rdVDHH2DNjo32FoPU2
	3dIXG7TPPyw3eT1oP/H8ukS5S1f762L4I5FkpkoeMV65WDdz2qLYyfP5be3W/7iVxtggmcYhXQqQG
	Q5ZVvOX811VwI1dMh1tgWafArSAzce7WRCTgDNABnKlNSL1zcmevDNLqf7heJ79BhWx+6OD93F1Uz
	b9gCHGZeTPpXgpvLTxxogSnX2rJOCi84hQ9w2d4Mm43zSEK2RCUH1oOEqSqRHY5qdcIU8wQNB+WZB
	zz7UGYWKlIRLvK7OF2/qjoOREEPbwNNeGYvmepMNi2e91AhnXOoZJg2KbUeQH+lEe+q0fDAtZDY0y
	MUW0qQaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1toXCC-0000000F9H9-3Ze0;
	Sun, 02 Mar 2025 00:28:40 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1toXCA-0000000F9GQ-1DdD
	for linux-nvme@lists.infradead.org;
	Sun, 02 Mar 2025 00:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740875318; x=1772411318;
  h=date:from:to:cc:subject:message-id;
  bh=MkJKMJN5bjDLdMVUj8TmEOPbD7eizb8dtyUPBfJUyOo=;
  b=EgPJXsf8iDF4P1G0Tn2Ifq8fdXRzKgKaeawPGrPSakyaj5/BwYLQkR5R
   XngT7uuZx3XjuE6zsQVECGVoeqCsCjf7kZJxMkoUfkZADcjByjvyo5FyI
   KE6TIwxZO5SP5odUSDZUj6ASiBwKzw0LPWbxUVI0pv2lBECP9ocxwIGPy
   H8TWJTuxMAh9uiFhIrtPWP1/Qi/Yo4h7PbWxX/ZPKSOgUiW/tSO0bfEKi
   bXHdI/qQ+QxuZPzjCyi1gKokzjkjmaup+Hbly7I8JKZmolzzkrBep1Yk8
   7vRqdILJn9Ed3KKw95WjgA0MSbwUf/bM0vA1MLn9PskzXUUjSxzamtLHN
   Q==;
X-CSE-ConnectionGUID: wwCGOUwzQ0+mD3n2ytddZg==
X-CSE-MsgGUID: 5rB6hlb6QzCZK1YLnWlUgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="29361454"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="29361454"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 16:28:38 -0800
X-CSE-ConnectionGUID: 9TGXWl5wTMKU081F4EjTcQ==
X-CSE-MsgGUID: Gz31OF4hQ2W8KqxhHKGokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="140888795"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Mar 2025 16:28:36 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toXC6-000Gt8-29;
	Sun, 02 Mar 2025 00:28:34 +0000
Date: Sun, 02 Mar 2025 08:28:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 4621b83f8eacad875ba5a234f628c2c2dc4f6822
Message-ID: <202503020821.aJoXYlcG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250301_162838_343942_7A6C64CB 
X-CRM114-Status: UNSURE (   5.25  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.15
branch HEAD: 4621b83f8eacad875ba5a234f628c2c2dc4f6822  nvme-multipath: Add visibility for queue-depth io-policy

elapsed time: 1447m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-004-20250301    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-004-20250301    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-002-20250301    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                            gpr_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-21
powerpc                       ebony_defconfig    clang-18
powerpc                    gamecube_defconfig    clang-16
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-003-20250301    clang-21
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-002-20250301    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250301    gcc-12
um                    randconfig-002-20250301    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

