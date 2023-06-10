Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F9C77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Jun 2023 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3VVGN9//ECHY/dQFzqDVgcq8FvcdKz+2sTu/Z66v76I=; b=XD6En1eKRS6uZz4dgLpMGfNPUg
	X9MUSMFzr1h+jib7gsV2GqkCy6bsmzX1z+hmc7zecN9v3v1BQKIipxf0kZyC2cm0VY7gnx0p9RSEm
	Ibi1dzfqJKRFfUrAHEiGQ72vMlUEp+WZNxGLWiTKHGA9njA6yOE8+1p5UtjeHFGZPS/5IHfS8tD49
	tgPLPJzrxocTPMoIzvKYUcaUSarwgO+3CjV/E+Eir/eJMG5ho2xr7D5Dn+azNsHZrkLNHTLMnh9P+
	GY8vLNbRxS3TVSigHvn0sZRUIaf/VgXKBr+5nbOQMt9bEcPW/yBfhf4SNOPOWdyGPZkLExa5qCUp2
	C2pwqbBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7r2U-00FGma-1e;
	Sat, 10 Jun 2023 05:21:26 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7r2P-00FGlj-1c
	for linux-nvme@lists.infradead.org;
	Sat, 10 Jun 2023 05:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686374481; x=1717910481;
  h=date:from:to:cc:subject:message-id;
  bh=RtrGLz6DomwZ4wWVRnjjzQOpuST/a7NQLBs3L7mukys=;
  b=gEn/ipL4n34kd7cH46ltEqFWHXQBHF3E2Ec1OOaqA//CCi3mO807lbwR
   u8N5Oa4oc4EVr1wyTWgMyvfYjFjsDb0yaTDUjpfZEcBWziIhYzlNs8kSC
   J8V1rD0MN65wMO4D83o4zajk1pKpfckCr2Fbu4usc5U3vh/E4V+epvgbM
   A1yhCGyFElMDcOUaBCGrjajqE/Jta+DPyjsyu9Uxy6xEKXnHFXATEaD2a
   9o5hWKOnJCSh5DdUWPSiJ77IpTdUhX9bU+PQqRoiJnEfzBZU4LeC5I74u
   vhxYm2K83QOYdLwHN6JhTgMPdrhhN0KchcBIvw2ACw+YVgv74n2dUpMko
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338094273"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="338094273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 22:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854960643"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="854960643"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 22:21:16 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q7r2J-0009ly-2X;
	Sat, 10 Jun 2023 05:21:15 +0000
Date: Sat, 10 Jun 2023 13:20:50 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 e340e0fa4b4f888a07cebbd6c267ba321146566c
Message-ID: <202306101348.7hCMTcHD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_222121_592004_4B22F9FC 
X-CRM114-Status: UNSURE (   6.38  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.5
branch HEAD: e340e0fa4b4f888a07cebbd6c267ba321146566c  nvmet-fcloop: Do not wait on completion when unregister fails

elapsed time: 752m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230608   gcc  
alpha                randconfig-r023-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230608   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230609   gcc  
csky                 randconfig-r036-20230609   gcc  
hexagon      buildonly-randconfig-r001-20230608   clang
hexagon              randconfig-r025-20230608   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-r022-20230608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r016-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r033-20230609   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r011-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r006-20230608   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230608   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230608   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230608   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230609   gcc  
sparc                randconfig-r032-20230609   gcc  
sparc64      buildonly-randconfig-r005-20230608   gcc  
sparc64              randconfig-r021-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r034-20230609   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

