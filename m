Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCAFC369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2UzEvYzc5F7miDwgRRe19ElXN/NUu2OT3w9T7zktrBg=; b=bf0XP7C0O//aRJvopKPf4wuA2v
	R/Sumw2yxPUrxLUryHIEFptAIrwgwfF/1LGeFjIRALhoOP7dq6o5aqfjY4ESwsQyJRwR2Vr6EjWoE
	VO9DO9yNo5UKU45koqN6VI5y85Cv+TBW/NCS7XVOYJbVRGSEgLTBbr6L1mWB0QZh+dKeemTtFZW8k
	zVckNYzy3lQ7go50dunZq4O0CwcI3mOGp4xXQ56Uv+5US1yjCZAL1D8IILyZ9cYsd3ZZO0dcTmn7t
	p9lJd3ZTyhnbNJgw1Vh+k7DTzocdzyuDLXQpBlcsoNMXSR4QwdL9deVe3wP6VgyDnmbl9Lz77SEx/
	NhxoQEpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Yqa-0000000AQMe-2okm;
	Wed, 23 Apr 2025 12:05:00 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Xxl-0000000AG9J-49w8
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 11:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745406502; x=1776942502;
  h=date:from:to:cc:subject:message-id;
  bh=5c8MEPWFRN+4L0vyz7CdDBvX/n9bejl2ZWGM7bkNnag=;
  b=G0RKHsRtBKkcKmDq6eheOXdXrlM8gkLJ2yKZlRojTUUdDIVTk1Nex7T2
   gRsMOaEooQBj72sn78L8GnqBKp9Dl36K2+aeKdmivDzBKhOf9ugSAbwh7
   UVRVR1Z1oVmQEC5AqpUEmBlNPDLRuElHasZR1UNvfyvdFpty6n3uZlNDp
   S7ewiFYVEMiqp6b4C0x8/4quG3PfznSsAZ+0e0uTiNIhpSMdkWo4lxZpU
   2iGY/8hFMCgGT846vJw/ghG9yKLGfZlWfQpPsl6cN8IYZV3xkvpbtBCro
   424KpOs8w3QkWywdyOIB4J8xY6K+C6uQPaxThvhEb3gT3o9QKTrgKWbH8
   A==;
X-CSE-ConnectionGUID: TvfM+WGyRB+zP12T//Nm4A==
X-CSE-MsgGUID: kYtPTRu/SY+vXrmtcIBADg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="72376939"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="72376939"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 04:08:20 -0700
X-CSE-ConnectionGUID: Zigr9fplSZi7BNfJnK5bHg==
X-CSE-MsgGUID: L0hvaO9fS8yBS5beVlmx3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137443953"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Apr 2025 04:08:18 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7Xxg-0001ue-0e;
	Wed, 23 Apr 2025 11:08:16 +0000
Date: Wed, 23 Apr 2025 19:07:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.16] BUILD SUCCESS
 464a6f99943ecce4387d83a37e701be4f1864b6f
Message-ID: <202504231936.9cLJFUwt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_040822_068860_6A2D1497 
X-CRM114-Status: UNSURE (   5.01  )
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
branch HEAD: 464a6f99943ecce4387d83a37e701be4f1864b6f  nvmet-tcp: switch to using the crc32c library

elapsed time: 1455m

configs tested: 255
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250422    gcc-8.5.0
arc                   randconfig-001-20250423    gcc-14.2.0
arc                   randconfig-002-20250422    gcc-14.2.0
arc                   randconfig-002-20250423    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250422    gcc-8.5.0
arm                   randconfig-001-20250423    gcc-14.2.0
arm                   randconfig-002-20250422    gcc-8.5.0
arm                   randconfig-002-20250423    gcc-14.2.0
arm                   randconfig-003-20250422    gcc-7.5.0
arm                   randconfig-003-20250423    gcc-14.2.0
arm                   randconfig-004-20250422    gcc-7.5.0
arm                   randconfig-004-20250423    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250422    gcc-6.5.0
arm64                 randconfig-001-20250423    gcc-14.2.0
arm64                 randconfig-002-20250422    clang-21
arm64                 randconfig-002-20250423    gcc-14.2.0
arm64                 randconfig-003-20250422    clang-18
arm64                 randconfig-003-20250423    gcc-14.2.0
arm64                 randconfig-004-20250422    gcc-8.5.0
arm64                 randconfig-004-20250423    gcc-14.2.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250422    gcc-10.5.0
csky                  randconfig-001-20250423    gcc-7.5.0
csky                  randconfig-002-20250422    gcc-14.2.0
csky                  randconfig-002-20250423    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250422    clang-21
hexagon               randconfig-001-20250423    gcc-7.5.0
hexagon               randconfig-002-20250422    clang-21
hexagon               randconfig-002-20250423    gcc-7.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250422    clang-20
i386        buildonly-randconfig-001-20250423    gcc-12
i386        buildonly-randconfig-002-20250422    clang-20
i386        buildonly-randconfig-002-20250423    gcc-12
i386        buildonly-randconfig-003-20250422    gcc-12
i386        buildonly-randconfig-003-20250423    gcc-12
i386        buildonly-randconfig-004-20250422    gcc-12
i386        buildonly-randconfig-004-20250423    gcc-12
i386        buildonly-randconfig-005-20250422    clang-20
i386        buildonly-randconfig-005-20250423    gcc-12
i386        buildonly-randconfig-006-20250422    clang-20
i386        buildonly-randconfig-006-20250423    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250423    gcc-12
i386                  randconfig-002-20250423    gcc-12
i386                  randconfig-003-20250423    gcc-12
i386                  randconfig-004-20250423    gcc-12
i386                  randconfig-005-20250423    gcc-12
i386                  randconfig-006-20250423    gcc-12
i386                  randconfig-007-20250423    gcc-12
i386                  randconfig-011-20250423    clang-20
i386                  randconfig-012-20250423    clang-20
i386                  randconfig-013-20250423    clang-20
i386                  randconfig-014-20250423    clang-20
i386                  randconfig-015-20250423    clang-20
i386                  randconfig-016-20250423    clang-20
i386                  randconfig-017-20250423    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250422    gcc-14.2.0
loongarch             randconfig-001-20250423    gcc-7.5.0
loongarch             randconfig-002-20250422    gcc-14.2.0
loongarch             randconfig-002-20250423    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250422    gcc-10.5.0
nios2                 randconfig-001-20250423    gcc-7.5.0
nios2                 randconfig-002-20250422    gcc-14.2.0
nios2                 randconfig-002-20250423    gcc-7.5.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250422    gcc-7.5.0
parisc                randconfig-001-20250423    gcc-7.5.0
parisc                randconfig-002-20250422    gcc-11.5.0
parisc                randconfig-002-20250423    gcc-7.5.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250422    clang-21
powerpc               randconfig-001-20250423    gcc-7.5.0
powerpc               randconfig-002-20250422    gcc-6.5.0
powerpc               randconfig-002-20250423    gcc-7.5.0
powerpc               randconfig-003-20250422    clang-16
powerpc               randconfig-003-20250423    gcc-7.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20250422    clang-21
powerpc64             randconfig-001-20250423    gcc-7.5.0
powerpc64             randconfig-002-20250422    gcc-6.5.0
powerpc64             randconfig-002-20250423    gcc-7.5.0
powerpc64             randconfig-003-20250422    gcc-6.5.0
powerpc64             randconfig-003-20250423    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250422    clang-21
riscv                 randconfig-001-20250423    gcc-12
riscv                 randconfig-002-20250422    gcc-14.2.0
riscv                 randconfig-002-20250423    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250422    gcc-7.5.0
s390                  randconfig-001-20250423    gcc-12
s390                  randconfig-002-20250422    clang-21
s390                  randconfig-002-20250423    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.1.0
sh                    randconfig-001-20250422    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-12
sh                    randconfig-002-20250422    gcc-6.5.0
sh                    randconfig-002-20250423    gcc-12
sh                          rsk7201_defconfig    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250422    gcc-10.3.0
sparc                 randconfig-001-20250423    gcc-12
sparc                 randconfig-002-20250422    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-12
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250422    gcc-7.5.0
sparc64               randconfig-001-20250423    gcc-12
sparc64               randconfig-002-20250422    gcc-13.3.0
sparc64               randconfig-002-20250423    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250422    gcc-12
um                    randconfig-001-20250423    gcc-12
um                    randconfig-002-20250422    gcc-12
um                    randconfig-002-20250423    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250422    gcc-12
x86_64      buildonly-randconfig-001-20250423    gcc-12
x86_64      buildonly-randconfig-002-20250422    clang-20
x86_64      buildonly-randconfig-002-20250423    gcc-12
x86_64      buildonly-randconfig-003-20250422    gcc-12
x86_64      buildonly-randconfig-003-20250423    gcc-12
x86_64      buildonly-randconfig-004-20250422    gcc-12
x86_64      buildonly-randconfig-004-20250423    gcc-12
x86_64      buildonly-randconfig-005-20250422    clang-20
x86_64      buildonly-randconfig-005-20250423    gcc-12
x86_64      buildonly-randconfig-006-20250422    clang-20
x86_64      buildonly-randconfig-006-20250423    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250423    clang-20
x86_64                randconfig-002-20250423    clang-20
x86_64                randconfig-003-20250423    clang-20
x86_64                randconfig-004-20250423    clang-20
x86_64                randconfig-005-20250423    clang-20
x86_64                randconfig-006-20250423    clang-20
x86_64                randconfig-007-20250423    clang-20
x86_64                randconfig-008-20250423    clang-20
x86_64                randconfig-071-20250423    gcc-12
x86_64                randconfig-072-20250423    gcc-12
x86_64                randconfig-073-20250423    gcc-12
x86_64                randconfig-074-20250423    gcc-12
x86_64                randconfig-075-20250423    gcc-12
x86_64                randconfig-076-20250423    gcc-12
x86_64                randconfig-077-20250423    gcc-12
x86_64                randconfig-078-20250423    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20250422    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-12
xtensa                randconfig-002-20250422    gcc-9.3.0
xtensa                randconfig-002-20250423    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

