Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A7C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 06:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R2olMM7SnRZTG22b9i2y1lQbuDIRKPPr7nSqzgMA0ak=; b=Ept2Qo2VNqinqAeJOCznoMzZT5
	pbKKtUPUeuk+qM8xd5nlHt1Bina9y1diKPKKJ+LbCv43mTebp+dM2Nis1JZlenjuF4tzGHfjauIgQ
	cGZsd4Y3VCLGOu8VLgg7o4XikQ+QJbUBRiO1o5VZm1zjQgXAmKaRFsEPySzUSpF7v8vNCs1EXSB/Q
	aZbpSWndeUj4siJ2a1pTD/QRMku+zM2XgXAIeu3AfE7cB88U+grX3Z7sglHoRzol8soXdWAa/i7U0
	ZMWdzcGUBsRXs65n5Tpeb1vESR/2sIO9K8v7GMImEROyv0qiackTroqnruq7wQSgZm2NL28wNNwZ4
	AUwaVCyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuTg-0000000HRF8-3gJR;
	Thu, 08 May 2025 06:11:28 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuSY-0000000HR7N-2aog
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746684618; x=1778220618;
  h=date:from:to:cc:subject:message-id;
  bh=KG99LYZMVPNCLgCqgNynFcWsIit+4IcyLtCTaako27g=;
  b=T2PV7zCrZWL9f6g+pg6QbYOFfW8eK4CwdTq+NFW8+xOBxzSMD+lcaOC9
   LkT2F/6HQxfDSJ9jjjVwK4mQi0zrdUwdALWVzh3EFRtWJWbUgJ2FRhV8G
   5dq2V61j/bbFw/OpQg6MeQpJaFUf8jk/M4GUDO6wAoZVsebR2ivEZYJMP
   2ejGIVLP1kI8+JwdeL0pTIPChOeOGYQrJeHoPjRY2i13MlrsqmYIiq9z9
   Wr25bbEQX145AgHS12x0iH3aoo9eTIJsYlBR7NB67DvqDxPv0WCRLvkSs
   sRWD30WxglTrL3lUY58rNDyzVa+yf/JL6BxMf1kHTElREIK4Yel254eS6
   w==;
X-CSE-ConnectionGUID: T7QCnjYeRcycff+lZ6HjzA==
X-CSE-MsgGUID: 5iZ2dq1+R5mL0Lrkjk2Pmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47705773"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="47705773"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:10:18 -0700
X-CSE-ConnectionGUID: RH8IBtl/SbGlCPl7QZlipg==
X-CSE-MsgGUID: GIrLZ7d2Qh2TSHMJWBZNhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="167249620"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 May 2025 23:10:17 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCuSV-000AZa-0D;
	Thu, 08 May 2025 06:10:15 +0000
Date: Thu, 08 May 2025 14:09:25 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 8edb86b2ed1d63cc400aecae8eb8c8114837171a
Message-ID: <202505081420.lgOHAm0F-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_231018_667941_0DCFF259 
X-CRM114-Status: UNSURE (   5.82  )
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
branch HEAD: 8edb86b2ed1d63cc400aecae8eb8c8114837171a  nvmet-auth: always free derived key data

elapsed time: 11047m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250430    gcc-14.2.0
arc                   randconfig-002-20250430    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                                 defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20250430    gcc-10.5.0
arm                   randconfig-002-20250430    gcc-7.5.0
arm                   randconfig-003-20250430    clang-21
arm                   randconfig-004-20250430    gcc-7.5.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250430    gcc-5.5.0
arm64                 randconfig-002-20250430    clang-21
arm64                 randconfig-003-20250430    gcc-5.5.0
arm64                 randconfig-004-20250430    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250430    gcc-14.2.0
csky                  randconfig-002-20250430    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250430    clang-21
hexagon               randconfig-002-20250430    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250430    gcc-12
i386        buildonly-randconfig-002-20250430    gcc-12
i386        buildonly-randconfig-003-20250430    gcc-12
i386        buildonly-randconfig-004-20250430    gcc-12
i386        buildonly-randconfig-005-20250430    clang-20
i386        buildonly-randconfig-006-20250430    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250430    gcc-14.2.0
loongarch             randconfig-002-20250430    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250430    gcc-11.5.0
nios2                 randconfig-002-20250430    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250430    gcc-14.2.0
parisc                randconfig-002-20250430    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250430    clang-21
powerpc               randconfig-002-20250430    gcc-9.3.0
powerpc               randconfig-003-20250430    gcc-7.5.0
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250430    gcc-10.5.0
powerpc64             randconfig-002-20250430    gcc-10.5.0
powerpc64             randconfig-003-20250430    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250430    gcc-7.5.0
riscv                 randconfig-002-20250430    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250430    clang-20
s390                  randconfig-002-20250430    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250430    gcc-5.5.0
sh                    randconfig-002-20250430    gcc-5.5.0
sh                           se7343_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250430    gcc-10.3.0
sparc                 randconfig-002-20250430    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250430    gcc-12.4.0
sparc64               randconfig-002-20250430    gcc-12.4.0
um                               alldefconfig    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250430    gcc-12
um                    randconfig-002-20250430    clang-16
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250430    clang-20
x86_64      buildonly-randconfig-002-20250430    clang-20
x86_64      buildonly-randconfig-003-20250430    gcc-12
x86_64      buildonly-randconfig-004-20250430    clang-20
x86_64      buildonly-randconfig-005-20250430    clang-20
x86_64      buildonly-randconfig-006-20250430    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250430    gcc-8.5.0
xtensa                randconfig-002-20250430    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

