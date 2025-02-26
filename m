Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C8C021B2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/xlyLydDidRjp/wTyEputnBKwgunW9uMWsay4+APC2o=; b=TyTKAJPh70j65jd/mndzdMltc4
	ePjAUte7bNReQzyF2nF/VA6cNWlHTc+Er0rZeTk5baLliugjrNAxUD/hBVkDtcTgMSZ480mREBvc9
	2CokwjY2HEsRMWti3MbPtMeFatGrE+uspZ5V36avE3+PhFjRfSzq7lBlY3EbKU5hbKd6M0aropyCy
	SvOn3gKlT7TKmoEhHxlp/mTngNnUWoMHUdpEql0JORe6YWO3LyWiFyKwRgtTCR8WwdPKE0qkZCJ7K
	Ooq4nuBsl/t8LaBbEeA2iI6RKSg52HF7/ZVotlp2QcvWve2UrYTWjuTWf+49U73e0XI0i2PO8X4wR
	m8Bfr/2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6Zy-000000022yN-2rPs;
	Wed, 26 Feb 2025 01:51:18 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn6Zw-000000022xx-2Eib
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 01:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740534676; x=1772070676;
  h=date:from:to:cc:subject:message-id;
  bh=afBBgHivSEMgcP2UEQqYncWAtmPQfpGVCJJn8BKSF2E=;
  b=EoMiysdreR+o14G9XcYYN/tPuPAEn5TgUaYXh9F9NWfND5W3l/iNFG7K
   qLHPfql1OpPg/K54p06w6L66I10yH0oyce0wpOfShH33Zzp1Y/Uyy1PUp
   zW0IM3jCgz6qO/wctkGE9HesufeYUY1qnIs9nTY1Jh2LWmXPdYxJGwjXW
   dtN2QJkdzs0esCeqJJmZW3ZqOulSh4cQCKyg+0ljxsTQsD0FDRibJnYg2
   jaUA3SNAv+tpbbQnMXauswfkFenZnL39d+TPvEtwbt1bmSe/XkYFKWCsw
   BryCLnjby8x1NntjE2RRE4lIaOMdHe+qhBITqjNSYv5mzHelnnzTjTTSJ
   w==;
X-CSE-ConnectionGUID: jc/moaDPRNqlmRJA+Nv4UQ==
X-CSE-MsgGUID: yhIGM4LdSdWxtu8QmmTEPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52004551"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52004551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:51:15 -0800
X-CSE-ConnectionGUID: Yq1nDvFTTyyvJapkeh5uFw==
X-CSE-MsgGUID: nmrAYeQXTO6Cg6FbF5WShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116366932"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 17:51:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tn6Zn-000Azz-2K;
	Wed, 26 Feb 2025 01:51:09 +0000
Date: Wed, 26 Feb 2025 09:50:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 f4774e92aab85d9bb5c76463f220ad7ba535bb1c
Message-ID: <202502260951.vY8jt1Qh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_175116_580642_C0B648E1 
X-CRM114-Status: UNSURE (   5.62  )
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
branch HEAD: f4774e92aab85d9bb5c76463f220ad7ba535bb1c  loop: take the file system minimum dio alignment into account

elapsed time: 1532m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250225    gcc-13.2.0
arc                   randconfig-002-20250225    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250225    gcc-14.2.0
arm                   randconfig-002-20250225    gcc-14.2.0
arm                   randconfig-003-20250225    gcc-14.2.0
arm                   randconfig-004-20250225    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250225    clang-19
arm64                 randconfig-002-20250225    clang-17
arm64                 randconfig-003-20250225    clang-15
arm64                 randconfig-004-20250225    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250225    gcc-14.2.0
csky                  randconfig-002-20250225    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250225    clang-21
hexagon               randconfig-002-20250225    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250225    clang-19
i386        buildonly-randconfig-002-20250225    gcc-11
i386        buildonly-randconfig-003-20250225    clang-19
i386        buildonly-randconfig-004-20250225    clang-19
i386        buildonly-randconfig-005-20250225    gcc-12
i386        buildonly-randconfig-006-20250225    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250225    gcc-14.2.0
loongarch             randconfig-002-20250225    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250225    gcc-14.2.0
nios2                 randconfig-002-20250225    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250225    gcc-14.2.0
parisc                randconfig-002-20250225    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250225    gcc-14.2.0
powerpc               randconfig-002-20250225    clang-19
powerpc               randconfig-003-20250225    clang-21
powerpc64             randconfig-001-20250225    gcc-14.2.0
powerpc64             randconfig-002-20250225    gcc-14.2.0
powerpc64             randconfig-003-20250225    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250225    clang-15
riscv                 randconfig-002-20250225    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250225    clang-15
s390                  randconfig-002-20250225    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250225    gcc-14.2.0
sh                    randconfig-002-20250225    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250225    gcc-14.2.0
sparc                 randconfig-002-20250225    gcc-14.2.0
sparc64               randconfig-001-20250225    gcc-14.2.0
sparc64               randconfig-002-20250225    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250225    clang-21
um                    randconfig-002-20250225    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250225    gcc-12
x86_64      buildonly-randconfig-002-20250225    clang-19
x86_64      buildonly-randconfig-003-20250225    clang-19
x86_64      buildonly-randconfig-004-20250225    gcc-11
x86_64      buildonly-randconfig-005-20250225    gcc-12
x86_64      buildonly-randconfig-006-20250225    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250225    gcc-14.2.0
xtensa                randconfig-002-20250225    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

