Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54ADC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z3qyfkBe/DRvrukYAK1NjQ+uuhG+VAEZjAIkRKysLu8=; b=YqRaH6QZ6GnHmJzcSw5Wl9En3E
	KYaIhhhtZFIqJBm/USDYnGUFVG2AdLGrjXH7plZqbHGBCDS4xkiZt585s2oBiZ+F65rFzTMf53YWd
	MOL0Wtdjhi3ZqCcDXom+hWf31Ty/f3YCkJwhLklYRe+rViGGau+pML0GwwCda+CcyVodKBpqjhpMV
	+56ONELhODGC5fd72ORRthZSXANkhXI76HtrSzbzYSCMTAoj9sDJJGdJfSbUS8LfRp0vbgkpLbeTe
	LPmxyDcxxQj9Y351YUqrW+jyjriz67yT/Qy+rGUjUKISfpaCYXJmhXwZuWq1x/s2robAsZi57UySW
	98p1QQNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9TW-0000000H5nZ-1uaF;
	Wed, 17 Apr 2024 17:53:38 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9TT-0000000H5kt-00ae
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 17:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713376415; x=1744912415;
  h=date:from:to:cc:subject:message-id;
  bh=usxmrpjijeeygnjkNbO97f7BbmytXDnrC8VidDanGvI=;
  b=ZyP/joyEsBQ+++6khciiij5zjn63rja+sZlUaJNFKU3fWDe1K9ryj0x+
   GZulmP8QCAVL0op5Xx4q1tCaKhfmn7Qc1UroFB7N505WgV3zu4YkLAm5h
   vmG7fgqP3R10zgjAzCbQZfPtSM1s9vwNCD9fnhiuI0/bhfFm/BHyPsokY
   xlZW+056hm8xR51DL/svxXK9T6kXIjq0cIuJ9V/eAF1ufN+nsKBI6k23A
   2vrYs4Y/NMZuzUKOEhKOa9vNKfsfsfnv8HR+wEDgpyJHgvfnT1oztrSai
   XmqZgFQK4MCPb0GS5XqX+R7yku4UUMHDUVEh9/tc3qy5/3nNwftM5elHK
   w==;
X-CSE-ConnectionGUID: ztl2wrAsRCqrTTjRmvf9wQ==
X-CSE-MsgGUID: kyXdxCpaRAOHAVnvjMrLNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34283645"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="34283645"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:53:30 -0700
X-CSE-ConnectionGUID: n2um8+4HTiyMBkV9UrGxXw==
X-CSE-MsgGUID: z9oitMmrTD2H2wZOFjSOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23190600"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Apr 2024 10:53:29 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx9T9-0006ro-1q;
	Wed, 17 Apr 2024 17:53:21 +0000
Date: Thu, 18 Apr 2024 01:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.9] BUILD SUCCESS
 5c8dd1115d3afbb19edad7ac6f62fd502e5df31c
Message-ID: <202404180155.Wt5yU0Zc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_105335_184124_07039C96 
X-CRM114-Status: UNSURE (   4.63  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.9
branch HEAD: 5c8dd1115d3afbb19edad7ac6f62fd502e5df31c  nvmet-auth: replace pr_debug() with pr_err() to report an error.

elapsed time: 1462m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240417   gcc  
arc                   randconfig-002-20240417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240417   clang
arm                   randconfig-002-20240417   clang
arm                   randconfig-003-20240417   clang
arm                   randconfig-004-20240417   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240417   clang
arm64                 randconfig-002-20240417   clang
arm64                 randconfig-003-20240417   gcc  
arm64                 randconfig-004-20240417   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240417   gcc  
csky                  randconfig-002-20240417   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240417   clang
hexagon               randconfig-002-20240417   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240417   gcc  
loongarch             randconfig-002-20240417   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240417   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240417   clang
x86_64       buildonly-randconfig-002-20240417   gcc  
x86_64       buildonly-randconfig-003-20240417   clang
x86_64       buildonly-randconfig-004-20240417   clang
x86_64       buildonly-randconfig-005-20240417   clang
x86_64       buildonly-randconfig-006-20240417   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240417   gcc  
x86_64                randconfig-002-20240417   gcc  
x86_64                randconfig-003-20240417   gcc  
x86_64                randconfig-004-20240417   clang
x86_64                randconfig-005-20240417   clang
x86_64                randconfig-006-20240417   gcc  
x86_64                randconfig-011-20240417   clang
x86_64                randconfig-012-20240417   clang
x86_64                randconfig-013-20240417   clang
x86_64                randconfig-014-20240417   gcc  
x86_64                randconfig-015-20240417   clang
x86_64                randconfig-016-20240417   clang
x86_64                randconfig-071-20240417   gcc  
x86_64                randconfig-072-20240417   clang
x86_64                randconfig-073-20240417   gcc  
x86_64                randconfig-074-20240417   clang
x86_64                randconfig-075-20240417   clang
x86_64                randconfig-076-20240417   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

