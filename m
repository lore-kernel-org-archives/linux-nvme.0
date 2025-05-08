Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB4CC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=62VDe23XPosJ/+AEXD0P7Cn1rpGO9g7rlWHpkZ2gtbg=; b=2X1O9Xe2/UmMgeo71PnSxN0jaf
	DYLk12f2up/UEpeCTmlymc52mKJvUxFKcBvpQAFSl5UMp/J0qKMWul6iOEUvsGCIrc+exLSXlgKw8
	RcKOremBjBp9SBV4c9lckYKBn/ESXj/RrlS9XrYMsNfsm5mGLcZ3A3cVWz+lFcGft65TwGs9Ra9Yz
	b2nYSN0uuGZf1ZtoqZHbsoMffwMXq4BmG8B3Ht1Yti55y8qje/Fcst5qgdKc121G6ZT0JLoE/hRV2
	y70tM2bMRudICbJdDgB4ab9r+N44+nrykYcwv78TABAQ8CqWFkE1JqsU9pgEfNQivWO1ZH5D0+pbx
	qc3857rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD6oT-00000001dnj-1gVf;
	Thu, 08 May 2025 19:21:45 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD6nP-00000001dka-0YLi
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 19:20:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746732039; x=1778268039;
  h=date:from:to:cc:subject:message-id;
  bh=DDo2DhEpeyBOw0D8y85ArgBGaoUwRZMSGitzlX8E8hg=;
  b=NYrnfJQC9uXcjuNHXcChQ1cIUJgnbo6H+ceCrEd1zxDnNR/vTjzXBjgL
   5SQ01kZZmu2RO79VpnC31349ibQcSUGsIvD90Sl8GBc5KdBxsatRabZC3
   CZMsef1Tz+UkNh5tBRg4y9ch7DjBS6gCB3n0urBeC8VVkvHkSh00eA6qo
   6b8JPKpsr0BdSOZGbfxSAip+keNIoZqIXBQDE5hgVTS7eiWe4RpDAO3uq
   BetMrZs3h8ERrcPmajUo67UF9mXysDHuWWvHCjP56Do4hdsUEahvZ7TNQ
   MJyqczxava1o5s/G676tZvtyMpaKcVigH8L3xNLffIqducbLawI+tOANc
   Q==;
X-CSE-ConnectionGUID: n6DN7Rv/RkeYSKzLSYMYqw==
X-CSE-MsgGUID: WX3IW8ANTWqg530LpnHjmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66070859"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="66070859"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:20:38 -0700
X-CSE-ConnectionGUID: aKTfH4XaQD6zgGVQRhfdmw==
X-CSE-MsgGUID: fhJMX/03TqySqsa8WLzesQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136784617"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2025 12:20:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD6nK-000BIf-0Q;
	Thu, 08 May 2025 19:20:34 +0000
Date: Fri, 09 May 2025 03:20:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS
 0ea9b1f7aabb8af08649048d04fa3cee44dac4ab
Message-ID: <202505090308.iXcWWFc3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_122039_189104_ED1EF7E4 
X-CRM114-Status: UNSURE (   5.55  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.16
branch HEAD: 0ea9b1f7aabb8af08649048d04fa3cee44dac4ab  nvmet-auth: authenticate on admin queue only

elapsed time: 726m

configs tested: 216
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    clang-18
arc                        nsimosci_defconfig    clang-18
arc                 nsimosci_hs_smp_defconfig    clang-18
arc                   randconfig-001-20250508    gcc-8.5.0
arc                   randconfig-001-20250509    clang-21
arc                   randconfig-002-20250508    gcc-12.4.0
arc                   randconfig-002-20250509    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250508    clang-17
arm                   randconfig-001-20250509    clang-21
arm                   randconfig-002-20250508    clang-21
arm                   randconfig-002-20250509    clang-21
arm                   randconfig-003-20250508    clang-21
arm                   randconfig-003-20250509    clang-21
arm                   randconfig-004-20250508    gcc-7.5.0
arm                   randconfig-004-20250509    clang-21
arm                         s5pv210_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250508    clang-21
arm64                 randconfig-001-20250509    clang-21
arm64                 randconfig-002-20250508    clang-21
arm64                 randconfig-002-20250509    clang-21
arm64                 randconfig-003-20250508    gcc-8.5.0
arm64                 randconfig-003-20250509    clang-21
arm64                 randconfig-004-20250508    gcc-8.5.0
arm64                 randconfig-004-20250509    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250508    gcc-14.2.0
csky                  randconfig-001-20250509    gcc-13.3.0
csky                  randconfig-002-20250508    gcc-12.4.0
csky                  randconfig-002-20250509    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250508    clang-20
hexagon               randconfig-001-20250509    gcc-13.3.0
hexagon               randconfig-002-20250508    clang-21
hexagon               randconfig-002-20250509    gcc-13.3.0
i386                             alldefconfig    clang-18
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250508    clang-20
i386        buildonly-randconfig-001-20250509    clang-20
i386        buildonly-randconfig-002-20250508    clang-20
i386        buildonly-randconfig-002-20250509    clang-20
i386        buildonly-randconfig-003-20250508    clang-20
i386        buildonly-randconfig-003-20250509    clang-20
i386        buildonly-randconfig-004-20250508    clang-20
i386        buildonly-randconfig-004-20250509    clang-20
i386        buildonly-randconfig-005-20250508    clang-20
i386        buildonly-randconfig-005-20250509    clang-20
i386        buildonly-randconfig-006-20250508    clang-20
i386        buildonly-randconfig-006-20250509    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250509    clang-20
i386                  randconfig-002-20250509    clang-20
i386                  randconfig-003-20250509    clang-20
i386                  randconfig-004-20250509    clang-20
i386                  randconfig-005-20250509    clang-20
i386                  randconfig-006-20250509    clang-20
i386                  randconfig-007-20250509    clang-20
i386                  randconfig-011-20250509    gcc-12
i386                  randconfig-012-20250509    gcc-12
i386                  randconfig-013-20250509    gcc-12
i386                  randconfig-014-20250509    gcc-12
i386                  randconfig-015-20250509    gcc-12
i386                  randconfig-016-20250509    gcc-12
i386                  randconfig-017-20250509    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250508    gcc-14.2.0
loongarch             randconfig-001-20250509    gcc-13.3.0
loongarch             randconfig-002-20250508    gcc-14.2.0
loongarch             randconfig-002-20250509    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250508    gcc-14.2.0
nios2                 randconfig-001-20250509    gcc-13.3.0
nios2                 randconfig-002-20250508    gcc-10.5.0
nios2                 randconfig-002-20250509    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    clang-18
parisc                randconfig-001-20250508    gcc-9.3.0
parisc                randconfig-001-20250509    gcc-13.3.0
parisc                randconfig-002-20250508    gcc-11.5.0
parisc                randconfig-002-20250509    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     ppa8548_defconfig    clang-21
powerpc               randconfig-001-20250508    gcc-6.5.0
powerpc               randconfig-001-20250509    gcc-13.3.0
powerpc               randconfig-002-20250508    clang-21
powerpc               randconfig-002-20250509    gcc-13.3.0
powerpc               randconfig-003-20250508    gcc-6.5.0
powerpc               randconfig-003-20250509    gcc-13.3.0
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250508    clang-21
powerpc64             randconfig-001-20250509    gcc-13.3.0
powerpc64             randconfig-002-20250508    gcc-6.5.0
powerpc64             randconfig-002-20250509    gcc-13.3.0
powerpc64             randconfig-003-20250508    gcc-8.5.0
powerpc64             randconfig-003-20250509    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250508    clang-16
riscv                 randconfig-001-20250509    gcc-12.4.0
riscv                 randconfig-002-20250508    gcc-14.2.0
riscv                 randconfig-002-20250509    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250508    gcc-6.5.0
s390                  randconfig-001-20250509    gcc-12.4.0
s390                  randconfig-002-20250508    gcc-9.3.0
s390                  randconfig-002-20250509    gcc-12.4.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250508    gcc-14.2.0
sh                    randconfig-001-20250509    gcc-12.4.0
sh                    randconfig-002-20250508    gcc-10.5.0
sh                    randconfig-002-20250509    gcc-12.4.0
sh                   sh7770_generic_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250508    gcc-13.3.0
sparc                 randconfig-001-20250509    gcc-12.4.0
sparc                 randconfig-002-20250508    gcc-6.5.0
sparc                 randconfig-002-20250509    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250508    gcc-13.3.0
sparc64               randconfig-001-20250509    gcc-12.4.0
sparc64               randconfig-002-20250508    gcc-5.5.0
sparc64               randconfig-002-20250509    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250508    clang-21
um                    randconfig-001-20250509    gcc-12.4.0
um                    randconfig-002-20250508    clang-21
um                    randconfig-002-20250509    gcc-12.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250509    gcc-11
x86_64      buildonly-randconfig-002-20250509    gcc-11
x86_64      buildonly-randconfig-003-20250509    gcc-11
x86_64      buildonly-randconfig-004-20250509    gcc-11
x86_64      buildonly-randconfig-005-20250509    gcc-11
x86_64      buildonly-randconfig-006-20250509    gcc-11
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250509    clang-20
x86_64                randconfig-002-20250509    clang-20
x86_64                randconfig-003-20250509    clang-20
x86_64                randconfig-004-20250509    clang-20
x86_64                randconfig-005-20250509    clang-20
x86_64                randconfig-006-20250509    clang-20
x86_64                randconfig-007-20250509    clang-20
x86_64                randconfig-008-20250509    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250508    gcc-7.5.0
xtensa                randconfig-001-20250509    gcc-12.4.0
xtensa                randconfig-002-20250508    gcc-13.3.0
xtensa                randconfig-002-20250509    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

