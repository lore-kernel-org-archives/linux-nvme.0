Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF2DC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=se8jQHywyY8EmBNcFf2I80O1hCkIpg4UP5g+8G7SnhE=; b=C84biEW+SWIyGZj1aKqlPN/s9r
	FvxYDpULzt4WArIg4zaS0iXUfsVqlQe+yTdQXV+rExZKp78QpagpRReBRsK9TOJDRza4NM2gxk9Uv
	fzRqHxhDXy8hACI+qp/LrVd4SFVI9AyG4lYZqbrzIYDE5tANgXIJNuGdDNDHlIKaVFx2fvZDh+SD3
	f0UAC3/zyqnFAeJBYJztW9fuAaqQSLWwuJQOTTOaz6zjUvqw3OndAZqaqxWMxclXJ1zXgp6Iiv4NM
	oW+KriBYdiFn8Tz9z5LpttlcUrgk13F2hahRynC6BzgSXz6dEAb4zv2vA1OySp0BmCPC45YNnjs+E
	CV5/9GBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT4Mu-00000001J95-2SEB;
	Thu, 25 Jan 2024 18:22:28 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT4Mm-00000001J5S-20M9
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 18:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706206940; x=1737742940;
  h=date:from:to:cc:subject:message-id;
  bh=HehBFmvpX45DeuKqy4UazfquBQ44XwY+CiFeXph+pDk=;
  b=gl+rq1oJ+sHK5lX6VTC2QbI3GG0eDkrlpdOB+cC6w59Kf5cfrEr4/AYw
   Uz8wujMlcRAnRmGeWnzI4QydNnTO4v8Wvu2Q3Jp4Ox5x3X2MwbspzFIdM
   XP2XPo00QoETSLHccZvZVTY2dwN6+VAOSuhY8bw055BIwW0cVIAIm9TtZ
   0gJQ52+OnWSpNK6X+PW82d3DX/VBOinzdnkcBMjAo8LpN8TC4moTnBilg
   dZPdSWYJpNM4Fn3C9mgo4QcNBG7XEKEvYAN26CZiGp1BqFIuhfar925eA
   j4uq3HS89W5CS3rnS0lK9Xw/KA1FU16syZn7/7ai6nBWPVHZmeT21uIVf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15616281"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15616281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 10:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35182755"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Jan 2024 10:22:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT4Mg-0000Js-31;
	Thu, 25 Jan 2024 18:22:14 +0000
Date: Fri, 26 Jan 2024 02:21:35 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 15ade5bfa5abf0e02249239db91d5438fa796d18
Message-ID: <202401260233.RuP9BmiZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_102220_677648_400F53DD 
X-CRM114-Status: UNSURE (   5.87  )
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
branch HEAD: 15ade5bfa5abf0e02249239db91d5438fa796d18  nvme-rdma: Fix transfer length when write_generate/read_verify are 0

elapsed time: 1578m

configs tested: 77
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                   randconfig-001-20240125   gcc  
arc                   randconfig-002-20240125   gcc  
arm                   randconfig-001-20240125   gcc  
arm                   randconfig-002-20240125   gcc  
arm                   randconfig-003-20240125   gcc  
arm                   randconfig-004-20240125   gcc  
arm64                 randconfig-001-20240125   gcc  
arm64                 randconfig-002-20240125   gcc  
arm64                 randconfig-003-20240125   gcc  
arm64                 randconfig-004-20240125   gcc  
csky                  randconfig-001-20240125   gcc  
csky                  randconfig-002-20240125   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240125   gcc  
i386         buildonly-randconfig-002-20240125   gcc  
i386         buildonly-randconfig-003-20240125   gcc  
i386         buildonly-randconfig-004-20240125   gcc  
i386         buildonly-randconfig-005-20240125   gcc  
i386         buildonly-randconfig-006-20240125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240125   gcc  
i386                  randconfig-002-20240125   gcc  
i386                  randconfig-003-20240125   gcc  
i386                  randconfig-004-20240125   gcc  
i386                  randconfig-005-20240125   gcc  
i386                  randconfig-006-20240125   gcc  
i386                  randconfig-011-20240125   clang
i386                  randconfig-012-20240125   clang
i386                  randconfig-013-20240125   clang
i386                  randconfig-014-20240125   clang
i386                  randconfig-015-20240125   clang
i386                  randconfig-016-20240125   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20240125   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
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
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

