Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A08F327A6
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 05:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d8//vWLYYRDiulhIugMR5L8xcPRB2nB1wE0aT6UryF4=; b=2KR7w/XbCZs6vU33tzzHxedcFg
	0fQHjalJYYWLHKexDfE90nPPTj+k7+POC66h+0DJBegXiUqwzAIyLC6Pvy9199fBN8mNLXasqACYH
	PBAG0KK7w1KvLYyx/DWB6wNk4IHI7Cimg4LRzeB+nfnLEXKiHZc+hITJ2czFLxMTthTYYvzxwTFwE
	Ug2XW1gfn+hNkuu1rCAlPIs5Ky81N8644egbnEfiVwcyNidc9vwB2CDqMwWF7oYtF2K08SswWvxGU
	wlhflvnA9YQKRD9gGVKddnHzJuNgHRMXtTfqAthoPoCeHe5B6BKQv9Nfm8qp1NPv29nZ6RmP8zgpA
	xnahn33A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF482-000000083yE-2NNV;
	Tue, 21 Apr 2026 05:58:34 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF480-000000083xk-0hUD
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 05:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776751113; x=1808287113;
  h=date:from:to:cc:subject:message-id;
  bh=+Z0gCcNYMJJFPAY183kZanya737YUXWY+LbfUWSwkXo=;
  b=Vzy4Zy+W9DFHMYUG43kBuAlIbBdFAN78wsiXzc9dMG6Pl9iidj3/1EQN
   FzdPtwod1zXxp58gXp6msi7jV2VGL1IAUygB1vwQaj/JGJedFWvN36bbk
   IpRpqJAVLTgIDvr3/AU+OCZSFPmAaTjfYXrQ6AeJi+LnBUFI4lxp7S0HE
   /NdKaynWIHNjRTdd4CbRqozhyTuL52+p+GxosQpiLKdc87vtuj4Sjk2kL
   4iJzlk9OTu6FucZtvKqREaxp/azPBoRMzz86a6e3g804+tvQPHtDQpfQU
   hRxnaXxUuxEJeNGbCOE37Xinvv5+P+ZIBue4R/44QyNLoT9u4kdg9F1UF
   Q==;
X-CSE-ConnectionGUID: FdSMOX+DSe6elJgxI2zq1g==
X-CSE-MsgGUID: Zz1XGTrGRB+s3Bcq6B0E+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77378265"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77378265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:58:30 -0700
X-CSE-ConnectionGUID: nDfVeEJqRYWETFWs8ll3Mw==
X-CSE-MsgGUID: XyVg+VzbQOOo4lCYw52xTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="227298030"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Apr 2026 22:58:28 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wF47t-000000003Gi-2eeM;
	Tue, 21 Apr 2026 05:58:25 +0000
Date: Tue, 21 Apr 2026 13:57:36 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 8658b605443996b755092e44f7cfb9fa83b7c4ec
Message-ID: <202604211326.TkADdwLb-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_225832_277625_87E52C4D 
X-CRM114-Status: UNSURE (   4.75  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.1
branch HEAD: 8658b605443996b755092e44f7cfb9fa83b7c4ec  nvme-auth: Include SC_C in RVAL controller hash

elapsed time: 760m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260421    gcc-10.5.0
arc                   randconfig-002-20260421    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260421    clang-23
arm                   randconfig-002-20260421    gcc-8.5.0
arm                   randconfig-003-20260421    clang-23
arm                   randconfig-004-20260421    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-002-20260421    gcc-13.4.0
arm64                 randconfig-003-20260421    clang-18
arm64                 randconfig-004-20260421    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260421    gcc-13.4.0
csky                  randconfig-002-20260421    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260421    gcc-14
i386        buildonly-randconfig-002-20260421    gcc-14
i386        buildonly-randconfig-003-20260421    clang-20
i386        buildonly-randconfig-004-20260421    clang-20
i386        buildonly-randconfig-005-20260421    clang-20
i386        buildonly-randconfig-006-20260421    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20260421    gcc-14
i386                  randconfig-012-20260421    gcc-14
i386                  randconfig-013-20260421    gcc-14
i386                  randconfig-014-20260421    clang-20
i386                  randconfig-015-20260421    clang-20
i386                  randconfig-016-20260421    gcc-14
i386                  randconfig-017-20260421    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260421    gcc-15.2.0
parisc                randconfig-002-20260421    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260421    clang-20
powerpc               randconfig-002-20260421    clang-23
powerpc64             randconfig-001-20260421    gcc-13.4.0
powerpc64             randconfig-002-20260421    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260421    clang-23
riscv                 randconfig-002-20260421    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260421    gcc-11.5.0
s390                  randconfig-002-20260421    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260421    gcc-15.2.0
sh                    randconfig-002-20260421    gcc-11.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260421    gcc-15.2.0
sparc                 randconfig-002-20260421    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260421    gcc-9.5.0
sparc64               randconfig-002-20260421    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260421    clang-23
um                    randconfig-002-20260421    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260421    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260421    gcc-15.2.0
xtensa                randconfig-002-20260421    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

