Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA369C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Dec 2023 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vvXwbfqMa4JS2rQDPJbQOhoqfmL4gf1mtd6RFC7Rva0=; b=g3UAWAl1zCezQVoTqOysvdXh7m
	/RfQFY5hZXLe3yAWJpchA0r6mPZg4BEYnpAs3BFj7yks0Z7mx22EU/trAT9r5k2B9G64Lz9QNlJpY
	96mxCeV7lQ7O65yiFYDkJHVsB0VS4MhjZM2WwUamNmUPo2cZ63v4jJ3Iuz61mNiJzkHYIFdk/45Fb
	jO1yQjRq4w0QgsMTw1BztOBCdUaDwOMxuICxC4Bw//0ydK30Nwvgb9YKbYbXtKl1PfWbwh0/KyZ/y
	J7WBgd/jaUjEyBrxHKudP2Ur4uonY+P32xB8WuNueKDBNaFowgfYR/jJL83o2XqDR7hsal7wf0/p4
	SCkCODwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH4Dc-0087hR-15;
	Sat, 23 Dec 2023 15:47:16 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH4DV-0087h8-0Z
	for linux-nvme@lists.infradead.org;
	Sat, 23 Dec 2023 15:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703346429; x=1734882429;
  h=date:from:to:cc:subject:message-id;
  bh=GhZYt5lIBhtkmVuS/Ny43uJXW1SPnk0efu8+04WsA4s=;
  b=KjT2ZfmKtj/bfxLG3bANUuq+eanLNOSz6Nzqkh0dYTcp4LUPKGq4e7BA
   iZDEbmBaUVJtNMX7r2daeNf92o2koT1q+QDYhrzx7GhY3ih6aGHnjDCLV
   qgVtzmjnb0LEZ0ykZdPVCBjFyat6S5R9b9orFTAEuGoClfHbDpkbHzt1s
   yHNhD1TCOrdcrblS6hAWUwVo++wHA6m1sIPBqEuIPYjVI7q47CN6N1cek
   dnerS1cLS3BogK9BAplQDNB2hxGYm19LqQ5cVBFa7wgzo7wVigc0QELcS
   IgCdhb009FXtdVjBlp6LprugaD36+pCIzW5l6feL8sKAsrsfDUgyldlpF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="400028102"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="400028102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 07:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="920967490"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="920967490"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2023 07:46:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH4DH-000BAF-0G;
	Sat, 23 Dec 2023 15:46:56 +0000
Date: Sat, 23 Dec 2023 23:46:20 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.8] BUILD SUCCESS
 5d51dc8db10190661232741c93a141bdfc05f5ee
Message-ID: <202312232317.iJ5OkjS4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_074709_293360_ACB868C3 
X-CRM114-Status: UNSURE (   5.54  )
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
branch HEAD: 5d51dc8db10190661232741c93a141bdfc05f5ee  nvme-fc: set numa_node after nvme_init_ctrl

elapsed time: 2762m

configs tested: 93
configs skipped: 0

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
arc                   randconfig-001-20231223   gcc  
arc                   randconfig-002-20231223   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231223   clang
arm                   randconfig-002-20231223   clang
arm                   randconfig-003-20231223   clang
arm                   randconfig-004-20231223   clang
arm64                             allnoconfig   gcc  
arm64                 randconfig-001-20231223   clang
arm64                 randconfig-002-20231223   clang
arm64                 randconfig-003-20231223   clang
arm64                 randconfig-004-20231223   clang
csky                              allnoconfig   gcc  
csky                  randconfig-001-20231223   gcc  
csky                  randconfig-002-20231223   gcc  
hexagon               randconfig-001-20231223   clang
hexagon               randconfig-002-20231223   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231223   clang
i386         buildonly-randconfig-002-20231223   clang
i386         buildonly-randconfig-003-20231223   clang
i386         buildonly-randconfig-004-20231223   clang
i386         buildonly-randconfig-005-20231223   clang
i386         buildonly-randconfig-006-20231223   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231223   clang
i386                  randconfig-002-20231223   clang
i386                  randconfig-003-20231223   clang
i386                  randconfig-004-20231223   clang
i386                  randconfig-005-20231223   clang
i386                  randconfig-006-20231223   clang
i386                  randconfig-011-20231223   gcc  
i386                  randconfig-012-20231223   gcc  
i386                  randconfig-013-20231223   gcc  
i386                  randconfig-014-20231223   gcc  
i386                  randconfig-015-20231223   gcc  
i386                  randconfig-016-20231223   gcc  
loongarch             randconfig-001-20231223   gcc  
loongarch             randconfig-002-20231223   gcc  
m68k                             allmodconfig   gcc  
nios2                 randconfig-001-20231223   gcc  
nios2                 randconfig-002-20231223   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231223   gcc  
parisc                randconfig-002-20231223   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231223   clang
powerpc               randconfig-002-20231223   clang
powerpc               randconfig-003-20231223   clang
powerpc64             randconfig-001-20231223   clang
powerpc64             randconfig-002-20231223   clang
powerpc64             randconfig-003-20231223   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231223   clang
riscv                 randconfig-002-20231223   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231223   gcc  
s390                  randconfig-002-20231223   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231223   gcc  
sh                    randconfig-002-20231223   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231223   gcc  
sparc64               randconfig-002-20231223   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231223   clang
um                    randconfig-002-20231223   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231223   gcc  
xtensa                randconfig-002-20231223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

