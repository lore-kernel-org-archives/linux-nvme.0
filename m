Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09ACC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z9ULlbmoACn+PBdU87thsv0A+gbPWxdIHW5h2VxhPgE=; b=AEPUg1t/vpjFz/aIg5KTEtXWsC
	Y1IZ9rcebt+zifJL9xYwUq6kCCBiCpzzDYWhuNgAMRer/0BpTwLf1fcpVJRPD0adMyuLkX82JhAR8
	IP6zJh6fWSR033mmXEtqzbxoo1ti1FYTopxP6MVYs1k+IsSdeFBts9hrIUFXbf/uxtdzWPvKt+EoJ
	62utG4euqwdfflfokgO0fKuHRXRcs8U7Cho+KIB3AKswSA4BMy5tUwPwp8KbjejQkKj3Eb7AQC1ns
	I8xij7mBIhPf4KIAhFH1gdOtuL8upFIJhcbVs8YvvNU/AnU4amGdSFpkbHePiOeIeBNwfsCH+KiMN
	KSRnh2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG4iR-0011V5-0B;
	Wed, 20 Dec 2023 22:06:59 +0000
Received: from mgamail.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG4iN-0011UY-1q
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 22:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703110015; x=1734646015;
  h=date:from:to:cc:subject:message-id;
  bh=t/KEj6RqiprK5iqBicQfjSw6IKj8/+aqGmQFiuXjeTU=;
  b=WuIz/ouSEBYkBWuS2bCI2lqrVbBCzMjWsZqmeAxhxaBhVrJ2nD0/AD8j
   R+yjyeQUd4MgYWHdTRvqLXxZnNWHZZ48VcWROrhk/qqeQ985M9HHL0D3H
   81djptoNjcAnrX5p3XRF17Fq+FlXQCIl8DVwoXjauVsBu4ZtHqm6dvK/T
   nMwl6TGk7uyILWpEAPK3TXCpSmmE4b22R9cNOdozRXyuQk3eFnyg7+y5H
   4p/KMwEjq7rEOChDDx16nR+7CAPm1d8Hf1Gc++hO69cX9jExP0m2w7vNs
   OBk1BF1ccWoZ3e0j8L1GQsXo+lz0I32Xu60HSUm5OMuwwgQ21mklUEqyc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375370701"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="375370701"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726216495"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="726216495"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2023 14:06:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG4iG-0007Y7-2h;
	Wed, 20 Dec 2023 22:06:48 +0000
Date: Thu, 21 Dec 2023 06:06:11 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 f6fe0b2d35457c10ec37acc209d19726bdc16dbd
Message-ID: <202312210608.DgfQRwvF-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_140655_680228_E536630E 
X-CRM114-Status: UNSURE (   5.62  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.7
branch HEAD: f6fe0b2d35457c10ec37acc209d19726bdc16dbd  nvme-pci: fix sleeping function called from interrupt context

elapsed time: 1479m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231221   gcc  
arc                   randconfig-002-20231221   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231221   clang
arm                   randconfig-002-20231221   clang
arm                   randconfig-003-20231221   clang
arm                   randconfig-004-20231221   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231221   clang
arm64                 randconfig-002-20231221   clang
arm64                 randconfig-003-20231221   clang
arm64                 randconfig-004-20231221   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231221   gcc  
csky                  randconfig-002-20231221   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231221   clang
hexagon               randconfig-002-20231221   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231220   gcc  
i386         buildonly-randconfig-002-20231220   gcc  
i386         buildonly-randconfig-003-20231220   gcc  
i386         buildonly-randconfig-004-20231220   gcc  
i386         buildonly-randconfig-005-20231220   gcc  
i386         buildonly-randconfig-006-20231220   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231220   gcc  
i386                  randconfig-002-20231220   gcc  
i386                  randconfig-003-20231220   gcc  
i386                  randconfig-004-20231220   gcc  
i386                  randconfig-005-20231220   gcc  
i386                  randconfig-006-20231220   gcc  
i386                  randconfig-011-20231220   clang
i386                  randconfig-012-20231220   clang
i386                  randconfig-013-20231220   clang
i386                  randconfig-014-20231220   clang
i386                  randconfig-015-20231220   clang
i386                  randconfig-016-20231220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231221   gcc  
loongarch             randconfig-002-20231221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231221   gcc  
nios2                 randconfig-002-20231221   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231221   gcc  
parisc                randconfig-002-20231221   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231221   clang
powerpc               randconfig-002-20231221   clang
powerpc               randconfig-003-20231221   clang
powerpc64             randconfig-001-20231221   clang
powerpc64             randconfig-002-20231221   clang
powerpc64             randconfig-003-20231221   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231221   clang
riscv                 randconfig-002-20231221   clang
riscv                          rv32_defconfig   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231221   gcc  
s390                  randconfig-002-20231221   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231221   gcc  
sh                    randconfig-002-20231221   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231221   gcc  
sparc64               randconfig-002-20231221   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231221   clang
um                    randconfig-002-20231221   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231220   gcc  
x86_64       buildonly-randconfig-002-20231220   gcc  
x86_64       buildonly-randconfig-003-20231220   gcc  
x86_64       buildonly-randconfig-004-20231220   gcc  
x86_64       buildonly-randconfig-005-20231220   gcc  
x86_64       buildonly-randconfig-006-20231220   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231220   clang
x86_64                randconfig-002-20231220   clang
x86_64                randconfig-003-20231220   clang
x86_64                randconfig-004-20231220   clang
x86_64                randconfig-005-20231220   clang
x86_64                randconfig-006-20231220   clang
x86_64                randconfig-011-20231220   gcc  
x86_64                randconfig-012-20231220   gcc  
x86_64                randconfig-013-20231220   gcc  
x86_64                randconfig-014-20231220   gcc  
x86_64                randconfig-015-20231220   gcc  
x86_64                randconfig-016-20231220   gcc  
x86_64                randconfig-071-20231220   gcc  
x86_64                randconfig-072-20231220   gcc  
x86_64                randconfig-073-20231220   gcc  
x86_64                randconfig-074-20231220   gcc  
x86_64                randconfig-075-20231220   gcc  
x86_64                randconfig-076-20231220   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231221   gcc  
xtensa                randconfig-002-20231221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

