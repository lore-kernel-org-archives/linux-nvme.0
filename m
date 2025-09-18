Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28151CAC597
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Sep 2025 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lj01HHRq2+L8LavJy/W5pn1YOGzYu5errAlvh3DuESU=; b=ob+tuOG8JUL22y7N4Jo6ADR448
	JHkDylusEDdlidIK28LRymi/9u7oxW/Y33mObGjYGqrj6pnBVMJAUJn7atTXEz7m0/jHc8NvIm8l8
	0ExESubiHPgj8IlcMYzmlUoIvWExco1S6u8MRtLSNa3y0blUIcasu5qR7xjfHniYt7hIBf+17c16a
	SrL8ByyUFMpD+x25l2Meap0BCRPnZqtiR1kwUv0gLEq5h9UrHWCxcXHBx6LfEpjU/PVCOQQjKf1ZO
	NtMHED2k556Bt4Y+FVKrToum/l1ScJv5WwZ0Td9jEl7TYe+h4pd0kJ9a3Izwd/P18VvesAOFLcUNv
	b2m5CdOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzOXA-00000001ThD-3JBb;
	Thu, 18 Sep 2025 23:59:28 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzOX4-00000001Tgj-1EIj
	for linux-nvme@lists.infradead.org;
	Thu, 18 Sep 2025 23:59:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758239962; x=1789775962;
  h=date:from:to:cc:subject:message-id;
  bh=HMoLrOqfSNUlEfF+9bIWpZfMHymgUq1gpRrSWy1RknU=;
  b=LtcowaY61IHmOkTJ2Nks29SQBjzzpusQBXZTXbOVfubwWweabzjhQqck
   QqxykAW8qQ3oYOa4LFfLJ757DdpWQk1lmfFPUnIl8WAwDpuKIVhV4GE5C
   xC3v+oDCaZkJd5yd738oqU+mfi5A6k/a2wZnUXLHLZFSQ/U3gZNgHI0b6
   uepHPhvpjesj5G25kJnPvRhatIHG1hWL2C9D94myQhYUeEmUpyrkGRoGb
   7sFMjTgJMsRGtJBtmQlbXlNg7VKL9LGV7I/HnJAUoXPWTSg5MHgSlsCDm
   Z9hBV5YUu/N1qgPPH3QJKhi6PuaFU2qXUDIp/oxTfxkWsSXRy2r18hLYZ
   Q==;
X-CSE-ConnectionGUID: hXrNeP63Q3Ca19OQSu+x+A==
X-CSE-MsgGUID: FpBLmozSQ7mcmP8wbu82lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60737946"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60737946"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:59:19 -0700
X-CSE-ConnectionGUID: qszy40XhSxWbeVUyEbCblQ==
X-CSE-MsgGUID: zkyZT9uyQzCXsPvqCa7n/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="176130334"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2025 16:59:18 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzOWx-0003pn-1W;
	Thu, 18 Sep 2025 23:59:15 +0000
Date: Fri, 19 Sep 2025 07:58:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 db86827545f9f6d7d25ee07d01336c4588feb0ab
Message-ID: <202509190721.rbUs0iff-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_165922_406892_62B1D641 
X-CRM114-Status: UNSURE (   5.69  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.18
branch HEAD: db86827545f9f6d7d25ee07d01336c4588feb0ab  nvme-core: add method to check for an I/O controller

elapsed time: 1462m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-002-20250918    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250918    clang-22
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-002-20250918    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-002-20250918    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-002-20250918    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-003-20250918    clang-19
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-003-20250918    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                                allnoconfig    clang-22
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

