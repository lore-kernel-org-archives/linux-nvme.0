Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF32C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 May 2023 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G1A6RNPMIsyjy/iEPQI+TRPkDa8jGz9XShnsFqZXS8c=; b=nGPNz+DH3iQ3ITHAYnoTEU0rt0
	heYIvUXZ61teb/5hNaD7JQX2jvuoUtv9OgoESRRj0E/8iVzrAw5SX4BvDZiWJDZ1cXtO7NUB0QIr7
	6JhcYhGy9l0GqOKHM1IsAk2+FiCVf8xfsApuhMq5knx30HWlQtAG9QhN6iZan361mba5gedF3hIRt
	HJjoFhK2JK6w4JeUuMgWcXbP/xMoJG+HytPlejz3cnRBxf4dL7xLUG15auJWhkmz/mWM1r+zg4Wcu
	FM1jS04lnBbXD6HDGI10cZ/WcSlTUCkcaAVxxGHkk4wE8buS5XJQ1Bc70HG0DXm+Xgv+GczcfV8rL
	EjOqrchg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrD9-0057BK-0e;
	Tue, 16 May 2023 09:43:15 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyrD7-0057AD-0t
	for linux-nvme@lists.infradead.org;
	Tue, 16 May 2023 09:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684230193; x=1715766193;
  h=date:from:to:cc:subject:message-id;
  bh=1BVcAVX+iMOU4VHc397H9iSEDFlRMCT5D5u5WqK8dv8=;
  b=GX/BJjvDSBtABgYfl8O441vsDDbe4E6OAV8EKc+kUvVTKxKBBCAJklhr
   d2BwjW4oDE6OSMfJhqd8/JuXao6pQ5JReaZ7CI6XtOYY5BESdj8i48FkA
   47kGlGH+WwBH8N15NDJRG75IE7a2sFIVCGHh7BLjPkFKeTaDF6195K37T
   e8119hKePYeNsYcypiR8gI66/MLQ8IVlUmGMxRgDEizL3IW6RrHFk821W
   0AJOHQrFVL3EkWjUHQA4Nd0W+LqXl2lK7zlFd8eaKBQTy1OMoMdAJ6mF1
   9k2Aa6RxSoDsocTifT3z4yoH15bqDGUdG3F89KjkP8Txj3ZBHxVXNv4N9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350269697"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="350269697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 02:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="766311437"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="766311437"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2023 02:43:09 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pyrD2-0007Iw-35;
	Tue, 16 May 2023 09:43:08 +0000
Date: Tue, 16 May 2023 17:42:50 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 851c23be6fc95a48dbdac864f18be63f9a41e8a8
Message-ID: <20230516094250.KcpG6%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_024313_326382_6D95EEC7 
X-CRM114-Status: UNSURE (   5.91  )
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

tree/branch: INFO setup_repo_specs: /db/releases/20230516171133/lkp-src/repo/*/linux-nvme
git://git.infradead.org/nvme.git nvme-6.5
branch HEAD: 851c23be6fc95a48dbdac864f18be63f9a41e8a8  nvme: move sysfs code to a dedicated sysfs.c file

elapsed time: 966m

configs tested: 123
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230515   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230515   gcc  
alpha                randconfig-r034-20230515   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230515   gcc  
arc                  randconfig-r043-20230515   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230515   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230515   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230516   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230516   gcc  
csky                 randconfig-r014-20230515   gcc  
csky                 randconfig-r036-20230515   gcc  
hexagon              randconfig-r041-20230515   clang
hexagon              randconfig-r045-20230515   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                 randconfig-i071-20230515   gcc  
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
i386                 randconfig-r031-20230515   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230515   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230515   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230515   gcc  
loongarch            randconfig-r024-20230515   gcc  
loongarch            randconfig-r035-20230515   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230515   gcc  
microblaze           randconfig-r011-20230515   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230516   clang
mips                 randconfig-r025-20230515   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r005-20230516   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230516   gcc  
parisc               randconfig-r003-20230516   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r032-20230515   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230515   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230515   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230515   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r026-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64               randconfig-x061-20230515   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64               randconfig-x076-20230515   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

