Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7AEC54E60
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Mar 2024 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Iwuo8W6LKb4abCrE2a2rgf3O81fRVBSLTf5EWhEBWlE=; b=qRr4UhPFKYADjQ/wosUaFk7X2G
	7WEmroJxOw6zRGN7pRT515mK2/xSIcJBEqNTMqwYWvKYPyarRkKK3PT+qKXjuVvadMDtSgiDrg6U/
	F7ZHERA8Ie2MKpRbOZH4sclRHel7q4igVTjdF8txUsok3IxfGs8Y05k9GU0r/6vL3pqhzofkMVM0X
	eut7LXP757Wx+yLQdLN77ZcIUvs6H66lgqxtfdsDYluU6Fqr+Hx5qhEMee7cLXuHXn9Iu7rx6WM4q
	DZapRsIEumluUXz5waMN/aA5BV7EDJ5wEj9NRtO6U9pzye0hXLRv7+VxaUZwQ+OcEoAtjsnhYCN3v
	HB+GbCgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmW6E-0000000C9pB-1w3L;
	Tue, 19 Mar 2024 09:49:38 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmW68-0000000C9ne-2O51
	for linux-nvme@lists.infradead.org;
	Tue, 19 Mar 2024 09:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710841773; x=1742377773;
  h=date:from:to:cc:subject:message-id;
  bh=8wqz6SknjyD6WrmF9DJ9WE280OvE+3VgVizQ9rtdTbo=;
  b=brpJgx97H16QzQLxXWGeoN4sgM58IB6jJQ3m55ZMi1HYwrZqV8gadPYi
   PFd3tZEbzO9tGtDh75qkVBNfBxVfDgCLjsprblHIi/a4MNZpXC173BZjx
   hz/uNHSutypnYjmb/XaZy/sElqdy7x0Y2kyVSw1Qpbpa3luCRTOk8rGkp
   j6QY8BOfeu83iizJ1GkUBjBs6h+hBku8gOJYJIxqZxR7k8YZSXm1KkXDA
   nEaz3Pgr/oK678vgPpxt1EW9wuJgAiUehqLzMdkdLDj4XjOmVCPXMX0xt
   wSFmR7ArgjoSHjXiWttAw2f9DQQH6sDgE3OAOKL2BGC1r0ejowFQ935Yy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="17100690"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="17100690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="14213819"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Mar 2024 02:49:30 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmW63-000HeP-2U;
	Tue, 19 Mar 2024 09:49:27 +0000
Date: Tue, 19 Mar 2024 17:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.9] BUILD SUCCESS
 0c29f9fa46bbe4fdc218134823d80cf9934ef231
Message-ID: <202403191716.0dpweQWk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_024932_672748_4529F8B7 
X-CRM114-Status: UNSURE (   5.47  )
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
branch HEAD: 0c29f9fa46bbe4fdc218134823d80cf9934ef231  nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq

elapsed time: 744m

configs tested: 177
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
arc                   randconfig-001-20240319   gcc  
arc                   randconfig-002-20240319   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240319   clang
arm                   randconfig-002-20240319   gcc  
arm                   randconfig-003-20240319   clang
arm                   randconfig-004-20240319   clang
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240319   gcc  
arm64                 randconfig-002-20240319   clang
arm64                 randconfig-003-20240319   clang
arm64                 randconfig-004-20240319   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240319   gcc  
csky                  randconfig-002-20240319   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240319   clang
hexagon               randconfig-002-20240319   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240319   clang
i386         buildonly-randconfig-002-20240319   clang
i386         buildonly-randconfig-003-20240319   clang
i386         buildonly-randconfig-004-20240319   clang
i386         buildonly-randconfig-005-20240319   gcc  
i386         buildonly-randconfig-006-20240319   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240319   clang
i386                  randconfig-002-20240319   clang
i386                  randconfig-003-20240319   clang
i386                  randconfig-004-20240319   clang
i386                  randconfig-005-20240319   clang
i386                  randconfig-006-20240319   gcc  
i386                  randconfig-011-20240319   gcc  
i386                  randconfig-012-20240319   clang
i386                  randconfig-013-20240319   gcc  
i386                  randconfig-014-20240319   clang
i386                  randconfig-015-20240319   clang
i386                  randconfig-016-20240319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240319   gcc  
loongarch             randconfig-002-20240319   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                  decstation_64_defconfig   gcc  
mips                            gpr_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240319   gcc  
nios2                 randconfig-002-20240319   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240319   gcc  
parisc                randconfig-002-20240319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240319   gcc  
powerpc               randconfig-002-20240319   clang
powerpc               randconfig-003-20240319   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240319   gcc  
powerpc64             randconfig-002-20240319   clang
powerpc64             randconfig-003-20240319   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240319   gcc  
riscv                 randconfig-002-20240319   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240319   gcc  
s390                  randconfig-002-20240319   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240319   gcc  
sh                    randconfig-002-20240319   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240319   gcc  
sparc64               randconfig-002-20240319   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240319   gcc  
um                    randconfig-002-20240319   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240319   clang
x86_64       buildonly-randconfig-002-20240319   clang
x86_64       buildonly-randconfig-003-20240319   clang
x86_64       buildonly-randconfig-004-20240319   clang
x86_64       buildonly-randconfig-005-20240319   clang
x86_64       buildonly-randconfig-006-20240319   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240319   clang
x86_64                randconfig-002-20240319   clang
x86_64                randconfig-003-20240319   clang
x86_64                randconfig-004-20240319   gcc  
x86_64                randconfig-005-20240319   gcc  
x86_64                randconfig-006-20240319   gcc  
x86_64                randconfig-011-20240319   clang
x86_64                randconfig-012-20240319   clang
x86_64                randconfig-013-20240319   gcc  
x86_64                randconfig-014-20240319   gcc  
x86_64                randconfig-015-20240319   clang
x86_64                randconfig-016-20240319   clang
x86_64                randconfig-071-20240319   gcc  
x86_64                randconfig-072-20240319   clang
x86_64                randconfig-073-20240319   gcc  
x86_64                randconfig-074-20240319   clang
x86_64                randconfig-075-20240319   clang
x86_64                randconfig-076-20240319   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240319   gcc  
xtensa                randconfig-002-20240319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

