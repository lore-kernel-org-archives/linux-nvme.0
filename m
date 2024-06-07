Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98EC27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kFQPxNyj4zjjMTR05OM6e+7ci4o52mizFiDjJsFd4aU=; b=FlNAkAGCUPuBIQVpxjXGzD8RMv
	X1e6eUDyMb1BOSYnNwstK2fwIAr/bkOaaqOHvHGdS82cZQx6G94n41ERWNkaVK9djyhPdQDgfDz9d
	+4SkzaQ5d9MeH7OHW630y8DGXOjP6NkjGCIDtYD+2V1ACvE9lcK65l2f2qzstcVXb6+mZIt3W9FSJ
	Ldmmd4JjuuMzs26v0dGpnQoSq6X6GOIFiSCRIigNUiBY6gOAN1EXIvfcFMz6hFsh+jQUz8AX9yxD7
	H9zbrjcnzMY6fRaaSU/kwahMIhxZbxmIcqiYZza0dW0hflnNHDrM+XqUzaS4TW7ejoOOtTu/4vSJn
	JVpQNLyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFcDk-0000000ErlJ-2SDc;
	Fri, 07 Jun 2024 16:13:40 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFcDc-0000000Erkx-2aZE
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 16:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717776812; x=1749312812;
  h=date:from:to:cc:subject:message-id;
  bh=WR2IC1RhWyoh0pcXarGkdUenNtBZhNjxxzzyW7veOgY=;
  b=Cfba9oZghN2NdThg89L9dUQGh4WEeujTW2yMwnsQroiHJ5qaxJok3gJ6
   3gR7otRjX2Yskpgvd7erp1yky2Wr/8uwXm2n47mh5Vn00EkPfBTgUd7g1
   2/SgAPdKToXY2HA6+CAu3OLeRwzji1LrrMhVhoPUp9q7iCUpdgwzx4jhD
   cWuCAZMKuKjIHPAoNSJHo7BYCmS5Kkoa9x5p9Ir7zQMH631TPYSNxduUq
   ptlMaCXlGo7KAW+o/OQ8iRq9eVsAcG1RXHPHIApU2sdOkMOt6rP3zd0l1
   UasSwurtCQ2a9ubiy/v9eq8Qj8TTg18rZGhTarLr37B8aHjHUkQA6uC2P
   Q==;
X-CSE-ConnectionGUID: mBvfSunARNmN8TH976buVA==
X-CSE-MsgGUID: 2Varn/ODSjKWMi9oBh0smw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25909162"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25909162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:13:22 -0700
X-CSE-ConnectionGUID: 7GbLVlJ8Qkmie4hq0g2/YA==
X-CSE-MsgGUID: MldrpUamRX+Nq4mCqmo60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38813811"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Jun 2024 09:13:20 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFcDN-00006w-2P;
	Fri, 07 Jun 2024 16:13:17 +0000
Date: Sat, 08 Jun 2024 00:12:44 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 5b81d3487111d2197f169891f7c1b7be2f2d61e7
Message-ID: <202406080042.Zda43BCx-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_091332_714477_7100F891 
X-CRM114-Status: UNSURE (   5.12  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: 5b81d3487111d2197f169891f7c1b7be2f2d61e7  mailmap: add entry for Weiwen Hu

elapsed time: 1475m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240607   gcc  
arc                   randconfig-002-20240607   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240607   gcc  
arm                   randconfig-002-20240607   clang
arm                   randconfig-003-20240607   clang
arm                   randconfig-004-20240607   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240607   gcc  
arm64                 randconfig-002-20240607   clang
arm64                 randconfig-003-20240607   clang
arm64                 randconfig-004-20240607   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240607   gcc  
csky                  randconfig-002-20240607   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240607   clang
hexagon               randconfig-002-20240607   clang
i386         buildonly-randconfig-001-20240607   clang
i386         buildonly-randconfig-002-20240607   clang
i386         buildonly-randconfig-003-20240607   clang
i386         buildonly-randconfig-004-20240607   clang
i386         buildonly-randconfig-005-20240607   clang
i386         buildonly-randconfig-006-20240607   clang
i386                  randconfig-011-20240607   clang
i386                  randconfig-013-20240607   clang
i386                  randconfig-014-20240607   clang
i386                  randconfig-015-20240607   clang
i386                  randconfig-016-20240607   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240607   gcc  
loongarch             randconfig-002-20240607   gcc  
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
nios2                 randconfig-001-20240607   gcc  
nios2                 randconfig-002-20240607   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240607   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
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
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

