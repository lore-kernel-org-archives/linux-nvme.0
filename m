Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704AEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rQDzvQYaBk1FtvBxGQtRiWXBMLFVWVfZhTRMdFyF3ro=; b=WfrRsZDOsk8DpULwMK1/BxMPNP
	/+m+KnI9CYJgQ+tvUtRuSroVrSOpA254Hx5w8rfCuAhAo/0MOBjUs4S4sx5n1+kIhY8zh8i+GODQ+
	3hoI+EWb8B43zpdc9V8i9TpGr5gzMbu0qbjqsdgRf1T0pmcSSB2C754SZQDc8LZMwTCNuO5sPbqPP
	ADP7m6zuy7+sVgkCYHSHEFRxiSF1QOoqMKjFPLCtjscOZ8A+AXKMaifGx4fxSNYTUJwelca47VTKs
	qptZrGZwaLpYxx6+ZUlg50UZcvF/Ii45dTcGgnSQDkIkcHVzr95FhNfv6qNLu4gAqkNmBO72CWQrc
	JlsQNTPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDxH3-00BLMG-1h;
	Tue, 27 Jun 2023 01:13:41 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDxGz-00BLLd-31
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 01:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828417; x=1719364417;
  h=date:from:to:cc:subject:message-id;
  bh=WnLn4D122rj4BDc8LxFOYo3cyQMCR1OjUjRs2F9szDg=;
  b=IsgUY8zdG4xFip268Sbe1W9rYyaiDO0VvN/RiV/2djDxSRju1ZSAszmg
   iQDoWSabbbcG1NiOqfp9xr2QC0P+qquJdPH84Xye1zHwy+VLOp29iUCzG
   vrNBIOP5aauAtbjIPQZ35xsKj20bvNQ8YS0mQw/HBPrcmRyM/IK26GWoL
   gjOJdX7ww23YNyQirHyMCZ8f2E3J5hH0ga4ITg8p+gck5jySSTQbppft5
   BpVnnHUKVAQvfdH3Q17vxEyz7zgnvqAf3mlT4ZWlm5UJXohWKtdSflXvj
   B4MxzBh8E7SwUhQVCnZTSeLy7wXNNn9zdPTX4DKg4ThCzkANT5p3/w+fI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447821283"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="447821283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="693668580"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="693668580"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2023 18:13:36 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qDxGx-000BDY-1a;
	Tue, 27 Jun 2023 01:13:35 +0000
Date: Tue, 27 Jun 2023 09:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 9d16d264775b9a10f3f5b5db768d7f51294b2a63
Message-ID: <202306270915.ZayBivl8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_181338_024447_7DEBCADA 
X-CRM114-Status: UNSURE (   5.42  )
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
branch HEAD: 9d16d264775b9a10f3f5b5db768d7f51294b2a63  nvmet: Reorder fields in 'struct nvmet_ns'

elapsed time: 7669m

configs tested: 119
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230621   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230621   gcc  
arc                  randconfig-r043-20230621   gcc  
arc                  randconfig-r043-20230622   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r035-20230621   clang
arm                  randconfig-r046-20230621   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230621   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230621   gcc  
csky                 randconfig-r023-20230621   gcc  
hexagon              randconfig-r003-20230622   clang
hexagon              randconfig-r041-20230621   clang
hexagon              randconfig-r045-20230621   clang
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230621   gcc  
i386         buildonly-randconfig-r004-20230622   clang
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r005-20230622   clang
i386         buildonly-randconfig-r006-20230621   gcc  
i386         buildonly-randconfig-r006-20230622   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-r026-20230622   gcc  
i386                 randconfig-r032-20230621   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230622   gcc  
loongarch            randconfig-r024-20230622   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230621   gcc  
m68k                 randconfig-r021-20230621   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                           mtx1_defconfig   clang
mips                 randconfig-r004-20230621   clang
mips                 randconfig-r006-20230621   clang
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230621   gcc  
nios2                randconfig-r031-20230621   gcc  
nios2                randconfig-r036-20230621   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230621   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      makalu_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230622   gcc  
riscv                randconfig-r026-20230621   clang
riscv                randconfig-r042-20230621   clang
riscv                randconfig-r042-20230622   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230622   clang
s390                 randconfig-r011-20230622   gcc  
s390                 randconfig-r022-20230621   clang
s390                 randconfig-r044-20230621   clang
s390                 randconfig-r044-20230622   gcc  
sh                               allmodconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230621   gcc  
sparc                randconfig-r012-20230622   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230621   clang
um                   randconfig-r034-20230621   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r001-20230622   clang
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230622   clang
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230622   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230622   gcc  
x86_64               randconfig-r025-20230621   clang
x86_64               randconfig-r025-20230622   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

