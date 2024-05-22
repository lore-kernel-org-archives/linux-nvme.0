Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121B1C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X/8x6QKe9a9wxVF+To7EkAcvcRHKpACZKWuqP83h6y4=; b=kLsBEuao431Z8ZVdb/z/ookrRR
	bs5/7Z9/EGy7rrxnXvOqM6wzIHpUYL26m4+UkqOqqCJBovZg+Iiy720PhDhQaL15+9vXHSQ0QUC2E
	PrmNKa0UhMppbxSTk0ukDmEBcY20rKbIw3mHt2YUJdCG0uoq80FWNDdq8MdwY6KKy7xYYqKWRWohc
	0PxyUj9MzVyB5ixnwGIp+sWfXTrLUf1PXJMv4Za5kjhxU4bKlHyLFCTTJMs3Tdv4bramar0u6NEoG
	iLhF8iU2862WcpBroK+Qtx2L051YBBoawUz4ynDJlx0VFpImI/q79MeEkbXhPlmRmL3XvszFXW2P9
	iGLRnjPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9t6z-000000046Un-0VaY;
	Wed, 22 May 2024 21:03:01 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9t6v-000000046UI-2MtH
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 21:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716411777; x=1747947777;
  h=date:from:to:cc:subject:message-id;
  bh=PveWOKblK58gNnvZ3a0KTarSY+AntncB2x1mAe/6KBA=;
  b=EFy4PMBp6/LdTUtA7DHoPHaOUUiiJw+8Q0XA96xEFgWYoKdDXDNk91KH
   jLelrqdIwQUZ1aVwIZk3LHP2lBjqZCTlxW3HpiolL28fVi5bDdyh1Mu6R
   xaAvQNrojmME541vyeg/K9aa9IkNPJsaw2e6fVvcIAkkXKhWubTZ4TGbz
   y23/vKKJ3P9suYo22/4sISYtp5oas1363BpxYVqJzLzoRGSmfRNgag/0G
   xJns+DM4rxB8yqgmTcYDGngLDMXL6yKJNtk5RV8N5j7S175L/Ze7MhiVc
   lV4DCoAwJPjuLtTXFmNaiWbZAWFW+glNgX6qzS+sL3zCek7ijC2hrTmpj
   Q==;
X-CSE-ConnectionGUID: /jLaNxDDTxmEAD82j3zqhA==
X-CSE-MsgGUID: 0wcUzPd2Sj+pB+xV7oUHhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16534821"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16534821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 14:02:54 -0700
X-CSE-ConnectionGUID: ZbJT7jN+T5udbmhzTaVrgQ==
X-CSE-MsgGUID: xKOL+p4dS0edmzAvD9m0RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38266073"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2024 14:02:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9t6o-000211-2f;
	Wed, 22 May 2024 21:02:50 +0000
Date: Thu, 23 May 2024 05:02:37 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.10] BUILD SUCCESS
 e87f84691166091a9b8c38dcfb77a9cd3fa48a43
Message-ID: <202405230535.ogAd5Qq7-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_140257_640722_2C74A048 
X-CRM114-Status: UNSURE (   4.99  )
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
branch HEAD: e87f84691166091a9b8c38dcfb77a9cd3fa48a43  nvme-multipath: fix io accounting on failover

elapsed time: 1459m

configs tested: 153
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
arc                   randconfig-001-20240522   gcc  
arc                   randconfig-002-20240522   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240522   clang
arm                   randconfig-002-20240522   gcc  
arm                   randconfig-003-20240522   clang
arm                   randconfig-004-20240522   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240522   clang
arm64                 randconfig-002-20240522   clang
arm64                 randconfig-003-20240522   gcc  
arm64                 randconfig-004-20240522   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240522   gcc  
csky                  randconfig-002-20240522   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240522   clang
hexagon               randconfig-002-20240522   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240522   gcc  
loongarch             randconfig-002-20240522   gcc  
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
nios2                 randconfig-001-20240522   gcc  
nios2                 randconfig-002-20240522   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240522   gcc  
parisc                randconfig-002-20240522   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240522   gcc  
powerpc               randconfig-002-20240522   gcc  
powerpc               randconfig-003-20240522   clang
powerpc64             randconfig-001-20240522   clang
powerpc64             randconfig-002-20240522   clang
powerpc64             randconfig-003-20240522   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240522   gcc  
riscv                 randconfig-002-20240522   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240522   clang
s390                  randconfig-002-20240522   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240522   gcc  
sh                    randconfig-002-20240522   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240522   gcc  
sparc64               randconfig-002-20240522   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240522   gcc  
um                    randconfig-002-20240522   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240523   gcc  
x86_64       buildonly-randconfig-002-20240523   gcc  
x86_64       buildonly-randconfig-003-20240523   gcc  
x86_64       buildonly-randconfig-004-20240523   clang
x86_64       buildonly-randconfig-005-20240523   clang
x86_64       buildonly-randconfig-006-20240523   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240523   gcc  
x86_64                randconfig-002-20240523   clang
x86_64                randconfig-003-20240523   clang
x86_64                randconfig-004-20240523   clang
x86_64                randconfig-005-20240523   clang
x86_64                randconfig-006-20240523   clang
x86_64                randconfig-011-20240523   clang
x86_64                randconfig-012-20240523   gcc  
x86_64                randconfig-013-20240523   clang
x86_64                randconfig-014-20240523   clang
x86_64                randconfig-015-20240523   gcc  
x86_64                randconfig-016-20240523   clang
x86_64                randconfig-071-20240523   gcc  
x86_64                randconfig-072-20240523   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240522   gcc  
xtensa                randconfig-002-20240522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

