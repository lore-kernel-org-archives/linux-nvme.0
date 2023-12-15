Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9E1C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 01:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/8qazUIu6YJA2y3bggIBD5Y4wLxS94t2IlLhNIzB1/o=; b=Jhiz+qDpOhwqWYZkxryrR+4ufT
	PKnY4l1buEIW3eSGMzcMqOCxud0xaseQ2ITbcVOfJwwv/6HtXqh8Gpgx+bfxOvLfwpxe/YlB2IJyQ
	aYjwk7OqiCMdMgoi3YzV5HOPHK4rwJT+2ZaJ0B9w4I4JJlgc0G3RCBSbg1ELeNjHPwD45zDKqE/l/
	DR8OaILlb59bv+BRj5m8Rf0NCzVFjvPgMEhASQxzzIDeMH8uvhoAS3Re1ciWW3YAVaPvXSM+8JD63
	fthPWHgvKo8Ty9ycAhmEC9qvk/SeoJWRGaiWPtyVkJHANw+klq+aSc+BDDSM09mIe4W9Qb3NBhwhz
	ZM3cf5kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDwwf-001hac-1p;
	Fri, 15 Dec 2023 01:24:53 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDwwb-001hZK-2X
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 01:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702603489; x=1734139489;
  h=date:from:to:cc:subject:message-id;
  bh=7lh9YOFkZvpiug0O+f6KpqO4AeKLbtr4AutoCwWl6R0=;
  b=Zvv7f0DwB2Zn872p4DYh3qVlWp2GMe/vl91PW3NUoQp6sIlloRXTgL0N
   exNrrqEQnu3nmijsjBZasK82OkGNCQ3T/lut2Rnic8hRrvHVDoDDSQMKw
   VuZW/fry++QFikuOSo6Q8ixEaOnxlISiS9Jcw9So+joDYmcA0rQYS7VWT
   LnrR2mVpjr/8YO3WVlruRJNORMcNYDWCsJwXMvEN4cWP4QzQdCOOfpKXB
   XYjNeKHbfI92LVIyyBMERuvXpCQh48HZYz+YkwDiwm3MvoaymUhcmqPNz
   n42tfUH7dc7376dAj76+3U25KqZ/dhv//n53WLj4wNutR5VpEi6D8XR0O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392389754"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="392389754"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:24:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844938041"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="844938041"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2023 17:24:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDwwY-000Mw1-0p;
	Fri, 15 Dec 2023 01:24:46 +0000
Date: Fri, 15 Dec 2023 09:24:11 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 4ba8b3f7d368279d3d3bde788394c7f6b3e0c061
Message-ID: <202312150909.PJf9E8WQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_172449_832546_B93C7186 
X-CRM114-Status: UNSURE (   6.60  )
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
branch HEAD: 4ba8b3f7d368279d3d3bde788394c7f6b3e0c061  nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl

elapsed time: 1579m

configs tested: 104
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231215   gcc  
arm                           h3600_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231215   clang
arm                   randconfig-002-20231215   clang
arm                   randconfig-003-20231215   clang
arm                   randconfig-004-20231215   clang
arm                       versatile_defconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231215   clang
arm64                 randconfig-002-20231215   clang
arm64                 randconfig-003-20231215   clang
arm64                 randconfig-004-20231215   clang
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon               randconfig-001-20231215   clang
hexagon               randconfig-002-20231215   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231214   gcc  
i386         buildonly-randconfig-002-20231214   gcc  
i386         buildonly-randconfig-003-20231214   gcc  
i386         buildonly-randconfig-004-20231214   gcc  
i386         buildonly-randconfig-005-20231214   gcc  
i386         buildonly-randconfig-006-20231214   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231214   gcc  
i386                  randconfig-002-20231214   gcc  
i386                  randconfig-003-20231214   gcc  
i386                  randconfig-004-20231214   gcc  
i386                  randconfig-005-20231214   gcc  
i386                  randconfig-006-20231214   gcc  
i386                  randconfig-011-20231214   clang
i386                  randconfig-012-20231214   clang
i386                  randconfig-013-20231214   clang
i386                  randconfig-014-20231214   clang
i386                  randconfig-015-20231214   clang
i386                  randconfig-016-20231214   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                         allyesconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231215   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc               randconfig-001-20231215   clang
powerpc               randconfig-002-20231215   clang
powerpc               randconfig-003-20231215   clang
powerpc                     tqm5200_defconfig   clang
powerpc64             randconfig-001-20231215   clang
powerpc64             randconfig-002-20231215   clang
powerpc64             randconfig-003-20231215   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231215   clang
riscv                 randconfig-002-20231215   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231215   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231215   clang
um                    randconfig-002-20231215   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231215   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

