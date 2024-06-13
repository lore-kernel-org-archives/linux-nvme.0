Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0217C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j3WYa3JXVq38gC8hxVziOUkZLM3hXylfo76EAQwhwas=; b=Buo6mdiXQA9Axqi0mI5do0fLc8
	fL5NrqbiQat5lbss/FsKOi5irL+QwzL7tFHiKhicV+eemW0loHpBFj+IxSL9vaMUGsblW0LY4bZAj
	JIRA/W43Ono0I+tsuCog1As6DKIvyIpt7BwiRVFAu155Oa+oByMkc+g114ZjP1EAK1tyELqvIrUti
	zrkoqy4gWsHFF7zHsNe6egzxyg+CtkYRGrkM41KqL1BA9k/C9R4EqRw7POjNtgg4nvOBrQyEJSxVK
	btPiOBdbAN46dLUsD6flJYeaGdvTjCPlb42kemEzWVDhkbt1xXWnpGy6nF9EgkFwdL70alJECOerN
	5n3MvR5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHpzb-00000000FaN-3ndK;
	Thu, 13 Jun 2024 19:20:15 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHpzY-00000000FYr-34gM
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 19:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718306413; x=1749842413;
  h=date:from:to:cc:subject:message-id;
  bh=gpAycNZqTAuE9gk6kIWrytn12VtoTJqBhABWtierpbI=;
  b=PKuAtYcTNuRLNRNeZLzjX0tV+/ApK0/b/7T8/66cCSiHrc5hvFiuL+rk
   3GmTkHuCGaiTPB2oxw0JkoH8ezYzBx2NhzWW4DjVW64rOHa01fEA4fNPz
   MfUUceA4egx0UrhkHlzpt4SU79T4tmErLIKwS6o2QGma7wfC1rGwo8cOG
   yq3E9gdqHoMtKmS7HVcdxtJmjWVhsPLbt6sC7nc/aMqBBz2zT0/eC2vK1
   LoIOeE+WQUfYBoKeguUVdDO9wHjLuwdMBUvq/U36dNLak2VE6Pzdakpyj
   +PY15cDKbV8mUzt3IZrEnT3TPsXSOjWBEPbdQwLWMlh670nNtFV6RbqEQ
   Q==;
X-CSE-ConnectionGUID: xJRtnULKQWq7mF+7nK6qGQ==
X-CSE-MsgGUID: 95wJKO6vRQmVERmsoB/IkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25739944"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25739944"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:20:12 -0700
X-CSE-ConnectionGUID: WyRVMWG5SIilE6rRxEmB8w==
X-CSE-MsgGUID: SFS8Pm16QtuegzUo/E0TJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44772480"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Jun 2024 12:20:11 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHpzU-0000K0-2i;
	Thu, 13 Jun 2024 19:20:08 +0000
Date: Fri, 14 Jun 2024 03:19:59 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.10] BUILD SUCCESS
 cd0c1b8e045a8d2785342b385cb2684d9b48e426
Message-ID: <202406140357.KfPvaJLY-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_122012_843679_E7CED8AA 
X-CRM114-Status: UNSURE (   4.66  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.10
branch HEAD: cd0c1b8e045a8d2785342b385cb2684d9b48e426  nvmet: always initialize cqe.result

elapsed time: 1491m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240613   gcc-13.2.0
arc                   randconfig-002-20240613   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240613   gcc-13.2.0
arm                   randconfig-002-20240613   clang-17
arm                   randconfig-003-20240613   clang-19
arm                   randconfig-004-20240613   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240613   gcc-13.2.0
arm64                 randconfig-002-20240613   clang-19
arm64                 randconfig-003-20240613   clang-19
arm64                 randconfig-004-20240613   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240613   gcc-13.2.0
csky                  randconfig-002-20240613   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240613   clang-19
hexagon               randconfig-002-20240613   clang-15
i386         buildonly-randconfig-001-20240613   gcc-9
i386         buildonly-randconfig-002-20240613   clang-18
i386         buildonly-randconfig-003-20240613   clang-18
i386         buildonly-randconfig-004-20240613   clang-18
i386         buildonly-randconfig-005-20240613   gcc-7
i386         buildonly-randconfig-006-20240613   clang-18
i386                  randconfig-001-20240613   gcc-7
i386                  randconfig-002-20240613   gcc-11
i386                  randconfig-003-20240613   gcc-13
i386                  randconfig-004-20240613   clang-18
i386                  randconfig-005-20240613   gcc-13
i386                  randconfig-006-20240613   gcc-13
i386                  randconfig-011-20240613   gcc-13
i386                  randconfig-012-20240613   clang-18
i386                  randconfig-013-20240613   clang-18
i386                  randconfig-014-20240613   gcc-12
i386                  randconfig-015-20240613   gcc-8
i386                  randconfig-016-20240613   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240613   gcc-13.2.0
loongarch             randconfig-002-20240613   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240613   gcc-13.2.0
nios2                 randconfig-002-20240613   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240613   gcc-13.2.0
parisc                randconfig-002-20240613   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240613   clang-19
powerpc               randconfig-002-20240613   clang-19
powerpc               randconfig-003-20240613   clang-19
powerpc64             randconfig-001-20240613   clang-19
powerpc64             randconfig-002-20240613   clang-19
powerpc64             randconfig-003-20240613   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240613   clang-19
riscv                 randconfig-002-20240613   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240613   gcc-13.2.0
s390                  randconfig-002-20240613   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240613   gcc-13.2.0
sh                    randconfig-002-20240613   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240613   gcc-13.2.0
sparc64               randconfig-002-20240613   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240613   gcc-9
um                    randconfig-002-20240613   gcc-9
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240613   gcc-13.2.0
xtensa                randconfig-002-20240613   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

