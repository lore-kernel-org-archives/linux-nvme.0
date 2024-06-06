Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A7EC27C52
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bpTzvQNuwaGCmAqjJwWEbr5ETmCgujsyykFd0C+v6wU=; b=sNdRB48RHThrWyTVvfXZNBR6kj
	Plp3xlrntXIBXZ8r9pY8qWrbiEb1uBT14MBLaE06IFnL3vgr52EzH53yZVEjbd5G0CfPGKLQDCEDP
	3aLM5HCODDl+nCod5YQC5JNl7PNwcIEN8ZfiEG9P/MZd9wKea8lsdf1csADeGHi3pVUI4zNoEG0uk
	4FvqfOtmHE4PAF35UGmXgX0nWgFh5PWit9D8XS3AqtWRTM5N1vM5SKSpLyqpUBDQadD/IOeBr+cC2
	e+KFBP+vy+fNkS3yV5yGLsd+HFzCfbE4S2FnAz4l6HvjfM7oYVohxTSy/WOsHT51TvAbsGYz5JVIY
	5lLCbJnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFKAh-0000000BK1p-2xms;
	Thu, 06 Jun 2024 20:57:19 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFKAZ-0000000BK0l-3VZR
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 20:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707432; x=1749243432;
  h=date:from:to:cc:subject:message-id;
  bh=Z2rY/yxmSayKZqBx4O0z5ya8q1ZrgwwfwMDM/loNK9I=;
  b=hoW9s6QGfXlRVJMt03gtRyuFW4lPDZBiNQ+GgvdwtLzHXTtyaY9HSXo3
   nCShXGw7qSOWiTn17k9eWTBhXyyUMO5CJIEr61LCI+c/B/vPgpgPLgpmp
   MWums31BSCvmlWAPEEh4GfOQrEa3qSCw/w2hr+YmbSucB5T3BNLF048bW
   u+/497rfi5ygmoaAQS3u4kyI3XTZUoaS8ZFSuoxJ/tKknTRaIBJAvCIpR
   +1I3g9fUnaYpD0hAxzU2eybCicjU/EGES14a9xq2p7qeYYnoggtEWYQM0
   yIhA70lp6CkSLKudZEbUoklXoVCMlZeSxMqur7ufTzW321N8keJD8hhu2
   A==;
X-CSE-ConnectionGUID: oHBQIJwQRkq+3NfZ9shFiw==
X-CSE-MsgGUID: QjjbhCLBT0KLswQI/SwBbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25509342"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25509342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:57:10 -0700
X-CSE-ConnectionGUID: GxE+FGgbQ6OI9+jeZrEE6A==
X-CSE-MsgGUID: QE10Kl+5ShmWFcxEYZJwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38182098"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 06 Jun 2024 13:57:08 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFKAU-0003hY-0O;
	Thu, 06 Jun 2024 20:57:06 +0000
Date: Fri, 07 Jun 2024 04:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-mpath-qdepth] BUILD SUCCESS
 067a96b9aee5f4d11e8e002e73366af8750cb4e1
Message-ID: <202406070423.ByO4m3Gs-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_135711_956330_5D410AE8 
X-CRM114-Status: UNSURE (   5.02  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-mpath-qdepth
branch HEAD: 067a96b9aee5f4d11e8e002e73366af8750cb4e1  nvme-multipath: implement "queue-depth" iopolic

elapsed time: 1480m

configs tested: 128
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240606   clang
i386         buildonly-randconfig-002-20240606   clang
i386         buildonly-randconfig-003-20240606   clang
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-005-20240606   clang
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240606   clang
i386                  randconfig-002-20240606   clang
i386                  randconfig-003-20240606   clang
i386                  randconfig-004-20240606   clang
i386                  randconfig-005-20240606   clang
i386                  randconfig-006-20240606   clang
i386                  randconfig-011-20240606   clang
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
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
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240606   clang
x86_64                randconfig-011-20240606   clang
x86_64                randconfig-013-20240606   clang
x86_64                randconfig-014-20240606   clang
x86_64                randconfig-015-20240606   clang
x86_64                randconfig-016-20240606   clang
x86_64                randconfig-071-20240606   clang
x86_64                randconfig-073-20240606   clang
x86_64                randconfig-074-20240606   clang
x86_64                randconfig-076-20240606   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

