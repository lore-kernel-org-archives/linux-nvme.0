Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B36C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rLnNKKrbNl08APWJu8S4cxoAdhTs79S3Z0Ug+kQND/Q=; b=riblfOZJlyi2Em/Kkt1cExsLSo
	0AWzSz7/a31GBiJmLLEBCs0bxWCHK57MDXaYF9DykbENrQOHREkC+D0qJtd5z6xKawt3PJASRi46z
	wEecy0CdfAkfnCUrElO9lK7IxWTPTwmhMF6XektfumCu+e/PNqxcEnsOdpA4qIPvaxZZJnoooanVx
	ZwVoSA+rOzPxW4q4aeKxqzTAGV24RlL4a/U5Gas37YBQars+tHtJivygjE019jjTSRGT/Mp3AcsOV
	V5sHq0wC6BW7N/BLnDncmfEkWGvtqih2FmbDAqgYQyaYfYkpddAW7PzsfiDkCKGaooYjQA1G2R+ZD
	ElCWU9vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uba6a-00000004Lcf-11Hp;
	Tue, 15 Jul 2025 07:29:36 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uba4b-00000004LC2-2UFQ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 07:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564454; x=1784100454;
  h=date:from:to:cc:subject:message-id;
  bh=8IviEvc71r10zIjAXEnnfuA4MREyXjt+juyQ1oqREUA=;
  b=a6oKzPxVlfMW2+qGldZClQXNnGUv5TeENGDEzzJYGrbXeGZ5I12ZxG1N
   4oy/qsqbx8Nc6VuBiKOaNvIwwRbZET2irSNYzXSCHCZUexBy4gXlpJIPt
   RI04vwcqC/v1d91d41wcVBKWbopC3JU3TBYo1V140ZxkVrptRb0iR/STN
   DnjI5vMk2wYI7ISB6eJRboAOGVqrQSTPrcJC1i+Gw//W4dzOf0mgQbw3N
   jvpqreWhGYB2R40HQL4KT0+d9ebMoRojXp6lKilFgMkXwTIlCJeWFJVB3
   1glQ46nsU7w2MxZTgcl1UVGPa22eOfS+mUuOwhKbbBlCkt8wTiLhv6Lsl
   w==;
X-CSE-ConnectionGUID: g+NuSbRWRqyRRYcIQ1syBA==
X-CSE-MsgGUID: Wg3uxoEkS4esXewQmto0aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54926658"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54926658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:27:32 -0700
X-CSE-ConnectionGUID: iKjX0iZyRTeqxXX0AdRELQ==
X-CSE-MsgGUID: J5YNcwgnREuINpVB1eN1eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156796060"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jul 2025 00:27:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uba4V-0009n9-0Y;
	Tue, 15 Jul 2025 07:27:27 +0000
Date: Tue, 15 Jul 2025 15:26:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS
 9bf02e045def1bdc30aada980a5eabfe9c785fa8
Message-ID: <202507151528.IWuzDB1H-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_002733_682693_DC9C50BB 
X-CRM114-Status: UNSURE (   5.64  )
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
branch HEAD: 9bf02e045def1bdc30aada980a5eabfe9c785fa8  nvmet-tcp: fix callback lock for TLS handshake

elapsed time: 1029m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20250714    gcc-15.1.0
arc                   randconfig-002-20250714    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    clang-21
arm                          collie_defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250714    clang-21
arm                   randconfig-002-20250714    gcc-6.5.0
arm                   randconfig-003-20250714    clang-21
arm                   randconfig-004-20250714    gcc-6.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250714    gcc-13.4.0
arm64                 randconfig-002-20250714    gcc-5.5.0
arm64                 randconfig-003-20250714    gcc-5.5.0
arm64                 randconfig-004-20250714    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-002-20250715    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250714    gcc-12
i386        buildonly-randconfig-002-20250714    clang-20
i386        buildonly-randconfig-003-20250714    gcc-12
i386        buildonly-randconfig-004-20250714    gcc-12
i386        buildonly-randconfig-005-20250714    gcc-12
i386        buildonly-randconfig-006-20250714    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-002-20250715    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-002-20250715    gcc-7.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-003-20250715    gcc-5.5.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-002-20250715    gcc-6.5.0
powerpc64             randconfig-003-20250715    clang-17
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250714    gcc-15.1.0
riscv                 randconfig-002-20250714    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250714    clang-21
s390                  randconfig-002-20250714    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250714    gcc-12.4.0
sh                    randconfig-002-20250714    gcc-11.5.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250714    gcc-8.5.0
sparc                 randconfig-002-20250714    gcc-6.5.0
sparc64               randconfig-001-20250714    clang-21
sparc64               randconfig-002-20250714    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250714    gcc-12
um                    randconfig-002-20250714    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250714    gcc-7.5.0
xtensa                randconfig-002-20250714    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

