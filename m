Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B446C001DE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bCf+9jBWEGRKDsSE+i1qhHh4eAz0UMYWinGg2xukE9U=; b=v8zIoRQ5uI6DlOLtufUSfJ65mo
	OCN4rBaZdlHrODVJl1OIzBdyOf/8tpl984WIJggBO4Qx5SxTsO+eDsuJWYWsxSiGt62KqE8PSBYTj
	Ru36Y25BGrH5VdVom0ZwotKFj2X3yIWslE0VEnMNQRy2buE3x06juUq5BOjNchFHjaXXCxY2O4WVD
	yvlZC5axo6eSjd5eU+WcPqRbsbP9R6ocGrpgBZVWBOKhK9ek8LIxH/HfSnR4clr0SRSzv23+axEV/
	+cq0kfikuRm0E3+gNqs/ol7KhfnI91YhVXLrrnaRxuGF7WKK4+ozdxOiY128Qw03YsJnJ6VMvoB89
	Arg1iGrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR7z1-004Sru-2J;
	Wed, 02 Aug 2023 09:17:31 +0000
Received: from [192.55.52.120] (helo=mgamail.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR7yv-004Sqw-1z
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 09:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690967845; x=1722503845;
  h=date:from:to:cc:subject:message-id;
  bh=FZPGNrBKpATstDKCUwLY7c5iGm8n9XDM+WLOQAIPqGs=;
  b=FtTEXr6pnUzxbuWWcE+PclZH0LwjrAgEtNV84hWW+nCPjdez2GghbJNF
   wr7vO7QFLlrz00dMh8R8jV3thlU35DDfJKCsTYZ4Tf+HrdnLZPMljH6A+
   ZnzKXck55RIzH4st/IkjkMiYsr1UG8CsNCiM644A/HVSyMVm7tcdu3heY
   ALLpFlQLDsEvK/IF5jH6r3bfGuxvNa0cPii7AWSjYFzoRaWk3ESZLPrAq
   vUfJkLb+QQkcDlSDq/XI4L7WMns6QSll104qvPbYcNXClGFAj0BFanNud
   2FF8AQTwbi4SSO3UrxIEHVwLtG7115Cni2D8jgKePwWwbK6pMUoncWUsq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368431437"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368431437"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 02:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902914172"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="902914172"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2023 02:17:21 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qR7yr-00014J-0V;
	Wed, 02 Aug 2023 09:17:21 +0000
Date: Wed, 02 Aug 2023 17:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 688b419c57c13637d95d7879e165fff3dec581eb
Message-ID: <202308021712.EFvyrU7X-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_021725_664772_2A41244B 
X-CRM114-Status: UNSURE (   5.52  )
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
branch HEAD: 688b419c57c13637d95d7879e165fff3dec581eb  nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

elapsed time: 722m

configs tested: 155
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                  randconfig-r004-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm                          sp7021_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230731   gcc  
arm64                randconfig-r014-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230801   gcc  
csky                 randconfig-r034-20230801   gcc  
hexagon              randconfig-r012-20230731   clang
hexagon              randconfig-r015-20230731   clang
hexagon              randconfig-r026-20230731   clang
hexagon              randconfig-r034-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r041-20230801   clang
hexagon              randconfig-r045-20230731   clang
hexagon              randconfig-r045-20230801   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230802   clang
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230802   clang
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230802   clang
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230802   clang
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230802   clang
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230802   clang
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230801   clang
i386                 randconfig-r014-20230731   clang
i386                 randconfig-r024-20230731   clang
i386                 randconfig-r033-20230801   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230801   gcc  
microblaze           randconfig-r022-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230731   gcc  
nios2                randconfig-r005-20230731   gcc  
nios2                randconfig-r006-20230731   gcc  
nios2                randconfig-r011-20230731   gcc  
openrisc             randconfig-r003-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc              randconfig-r003-20230801   gcc  
powerpc              randconfig-r036-20230801   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230731   clang
riscv                randconfig-r025-20230731   clang
riscv                randconfig-r031-20230731   gcc  
riscv                randconfig-r042-20230731   clang
riscv                randconfig-r042-20230801   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230731   clang
s390                 randconfig-r021-20230731   clang
s390                 randconfig-r035-20230801   gcc  
s390                 randconfig-r044-20230731   clang
s390                 randconfig-r044-20230801   clang
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r005-20230731   gcc  
sh                   randconfig-r031-20230801   gcc  
sh                   randconfig-r035-20230731   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230801   gcc  
sparc64              randconfig-r003-20230731   gcc  
sparc64              randconfig-r013-20230731   gcc  
sparc64              randconfig-r016-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230731   clang
um                   randconfig-r032-20230731   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x011-20230802   clang
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x012-20230802   clang
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x013-20230802   clang
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x014-20230802   clang
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x015-20230802   clang
x86_64               randconfig-x016-20230731   gcc  
x86_64               randconfig-x016-20230802   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r024-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

