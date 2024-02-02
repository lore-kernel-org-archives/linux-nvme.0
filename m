Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447D5C4828F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wBIlpRsmcz/QrsptrNergrMJ6WN/9jQ0bJToWFg1oMQ=; b=eLzz6n398TJxCTE8cfcnuvJuSl
	JVpcs6kAdyXV1pyiWpBq8DJNNanEkjpVJCqGX+94M1m9gxVqCEH899H/7nxNGjKfgl7FbGjx6olKI
	Kw80yC5AWLd5h8/zL3ClQpnpnIXSPapK1BPlJeEb49VUGAY2W7+YFJpJXc9X1HPAwBEH+m2Q0rYWc
	/jWKpRvBmCjzT+vXdKJdno3BdQTSUcGFiCb1KlKeypt7vsb6yedffDrtDRlbdDTcLZFYfi8IM0CW4
	kwty1dZZ11A5aApXia7rqiY3eSBvcD6ZM0cseILDr9yzo3bZpLVgrYX+1JspTUjUI72kq5p78TlET
	shNQ6uKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVxr4-0000000Ckaf-34OK;
	Fri, 02 Feb 2024 18:01:34 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVxr1-0000000CkZ4-1WNq
	for linux-nvme@lists.infradead.org;
	Fri, 02 Feb 2024 18:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896891; x=1738432891;
  h=date:from:to:cc:subject:message-id;
  bh=qiWFb2r3e2VgFXwwsGu88GcwJvCdXDyjBTdYDkCi/S0=;
  b=jpbdpyjkAMtsrOq/zFKT5Bk97RGPImF9fK8vKuRMPpNIBkbbJNP63cpN
   e/x/3zRp7poy+/yJb0CIGZ/tvBBqI+qgAAWD1T6cNvAwKSjK2+a1navL2
   vz2eJxFMWkN3ntXDd3i38vOjiSzhOszGh9YkxGRrdqqMmUtHzGcy2M+KL
   NmhxUFlFy/gid9Ah1B1fRscnzNYiRYjieTJ/hZVImhr4yNgMfUBAdQmuL
   C1FPcH0LUfeJ+I1vrNA52LELRPP3XqVPmVQph0/RcyAovxy1UeSMq5533
   4Zd/0O/G+fA7xtecPuK7d36pHAQayLRbIDVtL7Xk0DXYRQqlMLbht5S2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="3170869"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="3170869"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4738094"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Feb 2024 10:01:29 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVxqw-00047v-1p;
	Fri, 02 Feb 2024 18:01:26 +0000
Date: Sat, 03 Feb 2024 02:00:26 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 f0377ff97509f5a4921993d5d61da000361bd884
Message-ID: <202402030224.FSPpKZUQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_100131_470252_F4FC7952 
X-CRM114-Status: UNSURE (   6.06  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.8
branch HEAD: f0377ff97509f5a4921993d5d61da000361bd884  nvme-host: fix the updating of the firmware version

elapsed time: 1450m

configs tested: 157
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-002-20240202   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240202   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-004-20240202   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-002-20240202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240202   clang
i386         buildonly-randconfig-004-20240202   clang
i386         buildonly-randconfig-005-20240202   clang
i386                                defconfig   clang
i386                  randconfig-003-20240202   clang
i386                  randconfig-014-20240202   clang
i386                  randconfig-016-20240202   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-002-20240202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-002-20240202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-002-20240202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-002-20240202   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240202   gcc  
riscv                 randconfig-002-20240202   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-002-20240202   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-002-20240202   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-002-20240202   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240202   clang
x86_64       buildonly-randconfig-002-20240202   clang
x86_64       buildonly-randconfig-003-20240202   clang
x86_64       buildonly-randconfig-004-20240202   clang
x86_64       buildonly-randconfig-005-20240202   gcc  
x86_64       buildonly-randconfig-006-20240202   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240202   clang
x86_64                randconfig-002-20240202   clang
x86_64                randconfig-003-20240202   gcc  
x86_64                randconfig-004-20240202   gcc  
x86_64                randconfig-005-20240202   gcc  
x86_64                randconfig-006-20240202   gcc  
x86_64                randconfig-011-20240202   clang
x86_64                randconfig-012-20240202   clang
x86_64                randconfig-013-20240202   gcc  
x86_64                randconfig-014-20240202   clang
x86_64                randconfig-015-20240202   clang
x86_64                randconfig-016-20240202   clang
x86_64                randconfig-071-20240202   gcc  
x86_64                randconfig-072-20240202   clang
x86_64                randconfig-073-20240202   gcc  
x86_64                randconfig-074-20240202   clang
x86_64                randconfig-075-20240202   gcc  
x86_64                randconfig-076-20240202   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-002-20240202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

