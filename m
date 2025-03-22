Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE99FC35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TPGhuE7aKh5i/Ana9i1w9pi2bOtQayg44zxpmUC8QhY=; b=nddk7CWlinMz6I8gc91/s4zxGm
	0MoQ0Mh/g1JKfgX9iXGQJZ32pGKPKFcLCHRhDUZ5JL6jhq552PbEzDGpOXPDezDq7FNmpAOeZIYix
	1WbxEO6B19f2NQDSnyVt7b1QILQFp3zE5Skq6Ob2HWL1jRyVc/ZafaRfzdIx1+LdZ07oapo5Fz98t
	w+5WhYthagRqjoFUQQkTykvZwZv6NFmhV+LVaieuU80zJIq5Q1rRMf/YtvGnXnbG1HxYPeBGejxXn
	4avc5/mz5R8jWoFrkB1S6hEICiGnPXNHI4+JCUMVfWQXq+gJS3m7EaGAgFRFHndPAxZt1/R+2HbjT
	I90UyfQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvps5-0000000Gn0d-2ZBj;
	Sat, 22 Mar 2025 03:50:05 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvps2-0000000Gmzz-1xr8
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 03:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742615402; x=1774151402;
  h=date:from:to:cc:subject:message-id;
  bh=csz808J+SG4z923qAXcHUsNl8J+0z9sKo/UGfPVw88s=;
  b=Oc5Mx8q3UgVQMFW9tc6HjqlQZ3s0S+2bfZ/avctffHHfipUYos6ZOxYs
   cYdBRdP3MkChSisv15iWo0Le9ck7XfAYgDgZ/7u9DTLX3/0wBO6VOffdu
   1Ft/JQDAduH1XD/Q8E6qMSZFAby4jO0PjvklSy15GdRuJnmBSmnFceXjg
   7nsu7WbZvXWkMr/ziX8BFgoVnPFwjhwhA8guupRwUZHb17klBLiJEBDsR
   1OUP9MEUk0f06eGAojhH7wFJbQNJyrRiXMyrwLOoOCZbqJnyh32f4EGsh
   5ixAVL35rYdh50zccHZ6eMthZ85z5rEvlbYcNFqvlj7w1PtTWP4zjhj09
   w==;
X-CSE-ConnectionGUID: 4O+1KaoXShWON1lcvqsBEA==
X-CSE-MsgGUID: FwIxzo4WQ0e2C4yhAKKuoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54554147"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="54554147"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 20:49:57 -0700
X-CSE-ConnectionGUID: Em3bo24jSjGxfRl+SF99iA==
X-CSE-MsgGUID: 1Ugf/3DvRsuVGdBRyEqQig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128624028"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 21 Mar 2025 20:49:55 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvprs-0001ud-27;
	Sat, 22 Mar 2025 03:49:52 +0000
Date: Sat, 22 Mar 2025 11:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 64ea88e3afa8c5b6c3f9c477da304b7a56149612
Message-ID: <202503221155.BlwFGEuM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_205002_522397_F2085BA9 
X-CRM114-Status: UNSURE (   4.83  )
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
branch HEAD: 64ea88e3afa8c5b6c3f9c477da304b7a56149612  nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)

elapsed time: 1444m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-14.2.0
arc                             allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250321    gcc-13.3.0
arc                  randconfig-002-20250321    gcc-11.5.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250321    clang-19
arm                  randconfig-002-20250321    gcc-9.3.0
arm                  randconfig-003-20250321    gcc-5.5.0
arm                  randconfig-004-20250321    clang-21
arm64                           allmodconfig    clang-19
arm64                randconfig-001-20250321    gcc-5.5.0
arm64                randconfig-002-20250321    gcc-5.5.0
arm64                randconfig-003-20250321    clang-20
arm64                randconfig-004-20250321    clang-21
csky                 randconfig-001-20250321    gcc-13.3.0
csky                 randconfig-002-20250321    gcc-13.3.0
hexagon                         allmodconfig    clang-17
hexagon                         allyesconfig    clang-21
hexagon              randconfig-001-20250321    clang-21
hexagon              randconfig-002-20250321    clang-16
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250321    clang-20
i386       buildonly-randconfig-002-20250321    clang-20
i386       buildonly-randconfig-003-20250321    clang-20
i386       buildonly-randconfig-004-20250321    clang-20
i386       buildonly-randconfig-005-20250321    clang-20
i386       buildonly-randconfig-006-20250321    clang-20
i386                               defconfig    clang-20
loongarch                       allmodconfig    gcc-14.2.0
loongarch            randconfig-001-20250321    gcc-14.2.0
loongarch            randconfig-002-20250321    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20250321    gcc-13.3.0
nios2                randconfig-002-20250321    gcc-7.5.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250321    gcc-8.5.0
parisc               randconfig-002-20250321    gcc-6.5.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-21
powerpc              randconfig-001-20250321    clang-21
powerpc              randconfig-002-20250321    gcc-7.5.0
powerpc              randconfig-003-20250321    gcc-7.5.0
powerpc64            randconfig-001-20250321    gcc-5.5.0
powerpc64            randconfig-002-20250321    clang-16
powerpc64            randconfig-003-20250321    gcc-7.5.0
riscv                           allmodconfig    clang-21
riscv                            allnoconfig    gcc-14.2.0
riscv                           allyesconfig    clang-16
riscv                randconfig-001-20250321    clang-21
riscv                randconfig-002-20250321    clang-21
s390                            allmodconfig    clang-18
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250321    clang-16
s390                 randconfig-002-20250321    gcc-8.5.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250321    gcc-7.5.0
sh                   randconfig-002-20250321    gcc-7.5.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250321    gcc-12.4.0
sparc                randconfig-002-20250321    gcc-6.5.0
sparc64              randconfig-001-20250321    gcc-10.5.0
sparc64              randconfig-002-20250321    gcc-6.5.0
um                              allmodconfig    clang-19
um                               allnoconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250321    gcc-12
um                   randconfig-002-20250321    gcc-12
x86_64                           allnoconfig    clang-20
x86_64                          allyesconfig    clang-20
x86_64     buildonly-randconfig-001-20250321    clang-20
x86_64     buildonly-randconfig-002-20250321    clang-20
x86_64     buildonly-randconfig-003-20250321    gcc-12
x86_64     buildonly-randconfig-004-20250321    clang-20
x86_64     buildonly-randconfig-005-20250321    clang-20
x86_64     buildonly-randconfig-006-20250321    clang-20
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250321    gcc-6.5.0
xtensa               randconfig-002-20250321    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

