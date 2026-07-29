Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F018C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FtVm4X/TYDSJz/Bb/PJry78odlOrhyEAOJx+XJD43mM=; b=d3VAlZ1tgvbEHt+idK3xxF/jqK
	b5q8lk7IFcZKgIEfigfue0X7KGgeuvnx220hOgNySOZyt/lD2I/48J536MDvXJsgZZQJZINRCMqRm
	bCnra9L8/gjG88P66qtioQ99Xx3AzDkzzh7i8NSnYR99DPi5fEHEj9Ro/kLxEc+EI2MTqkYEq+lYh
	YVwAPRxCmwOfMEZF3/TspKfBE9jW/UBsd/6+tneIBuI7oVUFd6nF5Pr1A3WGHU8s4/oNn9rhYsiDS
	QkNPOw6AJcyMYQ4IkxBbRKeI+g7P9GS/ONt8YrZNRYPnFCcKY1HhiUm1ggkiw9FJZIfjA43mUr+KT
	sNVe5nUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpAYx-00000008w9T-1s3C;
	Wed, 29 Jul 2026 20:07:35 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpAYu-00000008w97-0bJw
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 20:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785355653; x=1816891653;
  h=date:from:to:cc:subject:message-id;
  bh=9COr62h0taYvfsGHPt5rby516Bjqvp75pxi7jnKmnhw=;
  b=gYqhzQZ5WNTmtjnS871syt8GVEZUUsURnDK0/NJMfN0hCLlWKbTX1aw6
   RXhC7IGSdks0mGMC48dGWz5ukSNtlI3bFYzcvrSAjJTQQbbfpCYFxS2V9
   NCjL3eWZW91IxAAJzkhMOQFV9CDIQeX4CLYyGFZX7qE431/SyTVLniZx9
   6FZJ9y7TaglNl/5mKobDpXo/piwyQ+A04Vj+miacHpsUd/fb/kV+nr1aE
   3GjmdtudqBd2vf0mM4q2WPP3W3ZbeP03pFTrOsHezFxGwtyfo1DWnwiQl
   MH5kMutrNxTgHJWBJfNZamK6UypbOhiErUXQFjQ31oFIfd9qN95SNYKIf
   A==;
X-CSE-ConnectionGUID: mzR7WG47R3OqtEhtvJLY9A==
X-CSE-MsgGUID: EaukyPYqT/6nTU0JTtprgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73508073"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="73508073"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:07:31 -0700
X-CSE-ConnectionGUID: ljJWR2DbQRyzSmRQNDJpHA==
X-CSE-MsgGUID: YnLDH0tITIuRyLJnNzaMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="283445104"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2026 13:07:29 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpAX1-00000000fdy-22QI;
	Wed, 29 Jul 2026 20:05:57 +0000
Date: Thu, 30 Jul 2026 03:58:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS WITH UNVERIFIED WARNING
 b53d495c7f0db46b6748b5ade48371a10dd5d3bc
Message-ID: <202607300359.XmhjCxw5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_130732_194917_890541BD 
X-CRM114-Status: UNSURE (   4.31  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: b53d495c7f0db46b6748b5ade48371a10dd5d3bc  nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com

    drivers/nvme/host/multipath.c:249:38: warning: reading variable 'current_path' requires holding __ctx_lock_RCU 'RCU' [-Wthread-safety-analysis]

Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-defconfig
    `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU

elapsed time: 813m

configs tested: 182
configs skipped: 4

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-14.3.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-14.3.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260729    gcc-14.3.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-14.3.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-14.3.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260729    clang-21
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260729    clang-17
hexagon              randconfig-002-20260729    gcc-9.5.0
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    clang-19
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260729    gcc-13.4.0
loongarch            randconfig-002-20260729    gcc-9.5.0
loongarch            randconfig-002-20260730    clang-24
mips                       bcm63xx_defconfig    clang-24
mips                       maltaup_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260729    gcc-9.5.0
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260729    gcc-10.5.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260729    gcc-16.1.0
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc              randconfig-001-20260729    clang-21
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260729    gcc-8.5.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260729    gcc-10.5.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-9.5.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260729    clang-24
s390                 randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-001-20260729    gcc-8.5.0
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-16.1.0
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-12.5.0
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260729    clang-21
sparc64              randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-14
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-14
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-12
x86_64     buildonly-randconfig-006-20260729    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-071-20260729    clang-22
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    clang-22
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-14
x86_64               randconfig-076-20260729    gcc-12
x86_64               randconfig-076-20260729    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-001-20260729    gcc-12.5.0
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260729    gcc-10.5.0
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

