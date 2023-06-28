Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14ADEB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 03:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9PU/gmb/EjqPUkPS9zL4FhNEclcqZLJ27s8P/SotUGY=; b=P+5QwUWpwd6GNlIhtYgiYCV51w
	aMU1qMYx/T/H49FgTlZNoRlFfMZbZYtY1DNeWigL62bck55COhmZpCa823aHm/BiPArR1cKnCxlLE
	JDZ1WhLUhUYjUqcqI/J9geSJH5CEnk1yKhrfnSBJhUCPwI3qt1huC1JoHe/25ubzc8GLVIumS0gjh
	ZbOOm4wkU2jUYNqELyHwCWE+pvG/3kvLjUpIcsE+pMJiZ83jtaNL3ASwaww7tb4+CCA/Ay+NiA8yc
	EcN0C3/J6Am0QrJOhsJjm15RaHfJAU6cSLJnc7fWpAEafTzj79SjZBBPlD0tt5RG8I9YcBv0o8LwQ
	eafw6isw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qELyE-00Eho3-0R;
	Wed, 28 Jun 2023 03:35:54 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qELyA-00Ehmu-2w
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 03:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687923350; x=1719459350;
  h=date:from:to:cc:subject:message-id;
  bh=QifHdNpx2APUXO+ATcvUDYkznMBJIjY7A6derDhBxY0=;
  b=n8VmK0s8Xt+3pXUwFlZYOOvFi8wQGvEc+UbjfyeNHdk0IhKrMxXgm9Ir
   2Cna5Hj7H82GkrM7VrN30OHgNZlnY7WhGfSyHKwH728X/uajb4HE9e/QS
   /SQ+d75DajdEaJzNcqW9IV0hZTvqqOC3zSHbiPQZsXu5ZtC+qkdrMSw2f
   a5JslZdVMFCwHclOxxKjXtwBpQ233eKCKR3tpfkk1pi0QAXQDcNSy6VSk
   MDiF4n8mrNBb+dNld/T8yabqaMYeeOZssyB35dRwi4MFW3Sa7A19CKEmj
   prrTD29xGfMMbdihzoAJbT5nFDCFCLvAP3cWQvKNW8UH7xEsYFnN5BGZT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="364287460"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="364287460"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 20:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694125737"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="694125737"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 20:35:39 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qELxy-000CeX-2z;
	Wed, 28 Jun 2023 03:35:38 +0000
Date: Wed, 28 Jun 2023 11:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 99160af413b4ff1c3b4741e8a7583f8e7197f201
Message-ID: <202306281144.0n5aXTPc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_203550_994583_8F59B019 
X-CRM114-Status: UNSURE (   6.14  )
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
branch HEAD: 99160af413b4ff1c3b4741e8a7583f8e7197f201  nvme-mpath: fix I/O failure with EAGAIN when failing over I/O

elapsed time: 721m

configs tested: 120
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230627   gcc  
alpha                randconfig-r015-20230627   gcc  
alpha                randconfig-r026-20230627   gcc  
alpha                randconfig-r031-20230627   gcc  
alpha                randconfig-r035-20230627   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230627   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r016-20230627   gcc  
arm                  randconfig-r046-20230627   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230627   gcc  
csky                 randconfig-r023-20230627   gcc  
csky                 randconfig-r024-20230627   gcc  
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230627   gcc  
loongarch            randconfig-r006-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                 randconfig-r033-20230627   clang
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230627   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r025-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc              randconfig-r012-20230627   clang
powerpc                      walnut_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230627   clang
um                   randconfig-r036-20230627   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230627   clang
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230627   gcc  
xtensa               randconfig-r013-20230627   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

