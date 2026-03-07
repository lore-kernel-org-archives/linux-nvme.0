Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2A4FC9EF8
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2026 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u7ynZmP91wvExyFli3V5soLbcXcNBZwtflYA53y/pbc=; b=UCoigm9jFzmTjGDd5EATsPpEI9
	wSMO40T6aH4gGOJME5U1kJF0qU2LKXh/MvhPdUqmvduwYcvIGeRaSnIkuKUbCL8iQn69LZkpqM3Vo
	zM3cYbT79Zxg/hSOFI7mGfUB9vwsAShG2TnB2qRGk+2yPZruY8G1IMvG30D3nUJp3qoAV2K3w//su
	IwntvfHAlDf0yW27PcYbHsRc+an31OjaJ0jVMRystD8UUJA6FtMIV1n0tQNutUQ0qmBlueGbTpzQF
	2eQdQk37hByeWLI9wpNXE6aGYR0D7d+yD7LkDHZ9yOUaB+D0zOsoRApN1y/Jya3pwVCHYMWRFUd9E
	f8OYcviA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyqVB-00000005BCx-0Q01;
	Sat, 07 Mar 2026 12:11:25 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyqV4-00000005BCJ-1GoJ
	for linux-nvme@lists.infradead.org;
	Sat, 07 Mar 2026 12:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772885478; x=1804421478;
  h=date:from:to:cc:subject:message-id;
  bh=UXeR3rnlDhW4djZsaWOo+g9BEKXyS9uosslJW/Q3os0=;
  b=FFcYqQtRcQUqxyIDH+t1rGRW6KpiMRIcBOiUqMGNatuSJqtpg/5LFypP
   Jl411K1dSZosYCZSHlRxC7seUAN9lmfogBAb9TXTqjY03tBB2QyDXLf9N
   f230i40orDLuvUqyLxDEWwxPDONLKWzFRLReGlHLRRZywNhCoAo3OGfme
   E9xsGdVh8G0qZs1DltV3Voo4DpCO55LGbqHjN4WcB7C4uB0RD6d1Sfg7O
   w2BQA3BX//UdbvMnC57z+E0Hph+xSS8m+mjuDtBePceWWQfnY0+kiWeIQ
   NjcnLpuYWBRX8c2m2zML1q0kxLH0TmKj2A9YKQkx2tkO7P2BR2FEMeoT0
   g==;
X-CSE-ConnectionGUID: 2uVljv4ASA+u/+G3gJt20w==
X-CSE-MsgGUID: 8yK19u1wREqp9TZ0TGyiKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73174746"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="73174746"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 04:11:13 -0800
X-CSE-ConnectionGUID: 1l394RIVTUGJXjdZhdCj1Q==
X-CSE-MsgGUID: a9tw0/42QGqcs5QPjYd5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="223961265"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2026 04:11:11 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyqUv-000000001y1-1AO4;
	Sat, 07 Mar 2026 12:11:09 +0000
Date: Sat, 07 Mar 2026 20:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 8e8a28876df6a80a05c935832d34b240647c2f3c
Message-ID: <202603072014.GsXz5C0W-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260307_041118_361575_2386A9BC 
X-CRM114-Status: UNSURE (   4.96  )
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
branch HEAD: 8e8a28876df6a80a05c935832d34b240647c2f3c  nvmet: report NPDGL and NPDAL

elapsed time: 1224m

configs tested: 123
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260307    gcc-14.3.0
arc                   randconfig-002-20260307    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260307    clang-23
arm                   randconfig-002-20260307    gcc-15.2.0
arm                   randconfig-003-20260307    gcc-13.4.0
arm                   randconfig-004-20260307    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260307    gcc-8.5.0
arm64                 randconfig-002-20260307    gcc-11.5.0
arm64                 randconfig-003-20260307    gcc-15.2.0
arm64                 randconfig-004-20260307    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260307    gcc-15.2.0
csky                  randconfig-002-20260307    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260307    clang-23
hexagon               randconfig-002-20260307    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260307    gcc-14
i386        buildonly-randconfig-002-20260307    gcc-14
i386        buildonly-randconfig-003-20260307    gcc-12
i386        buildonly-randconfig-004-20260307    clang-20
i386        buildonly-randconfig-005-20260307    gcc-14
i386        buildonly-randconfig-006-20260307    clang-20
i386                  randconfig-011-20260307    clang-20
i386                  randconfig-012-20260307    clang-20
i386                  randconfig-013-20260307    clang-20
i386                  randconfig-014-20260307    clang-20
i386                  randconfig-015-20260307    gcc-14
i386                  randconfig-016-20260307    gcc-14
i386                  randconfig-017-20260307    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260307    gcc-15.2.0
loongarch             randconfig-002-20260307    gcc-15.2.0
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
nios2                 randconfig-001-20260307    gcc-10.5.0
nios2                 randconfig-002-20260307    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260307    gcc-12.5.0
parisc                randconfig-002-20260307    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260307    gcc-8.5.0
powerpc               randconfig-002-20260307    gcc-11.5.0
powerpc64             randconfig-001-20260307    gcc-8.5.0
powerpc64             randconfig-002-20260307    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260307    clang-17
riscv                 randconfig-002-20260307    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260307    clang-23
s390                  randconfig-002-20260307    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260307    gcc-15.2.0
sh                    randconfig-002-20260307    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260307    gcc-15.2.0
sparc                 randconfig-002-20260307    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260307    clang-23
sparc64               randconfig-002-20260307    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260307    gcc-14
um                    randconfig-002-20260307    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260307    gcc-14
x86_64      buildonly-randconfig-002-20260307    gcc-14
x86_64      buildonly-randconfig-003-20260307    gcc-14
x86_64      buildonly-randconfig-004-20260307    clang-20
x86_64      buildonly-randconfig-005-20260307    clang-20
x86_64      buildonly-randconfig-006-20260307    gcc-14
x86_64                randconfig-011-20260307    gcc-14
x86_64                randconfig-012-20260307    clang-20
x86_64                randconfig-013-20260307    gcc-14
x86_64                randconfig-014-20260307    gcc-14
x86_64                randconfig-015-20260307    gcc-14
x86_64                randconfig-016-20260307    gcc-14
x86_64                randconfig-071-20260307    gcc-14
x86_64                randconfig-072-20260307    clang-20
x86_64                randconfig-073-20260307    gcc-14
x86_64                randconfig-074-20260307    gcc-14
x86_64                randconfig-075-20260307    gcc-14
x86_64                randconfig-076-20260307    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260307    gcc-8.5.0
xtensa                randconfig-002-20260307    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

