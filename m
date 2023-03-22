Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4CBC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Ds84AiQOt8EqqPqk9nbscaOXfKoyWjUh505Jk/JQLc=; b=k/s6eWyD5TZyPostP5WqxEV6u5
	qgsxBSmG7rCE7HGTz7pIOe5y3hHFsMVWKhgbGVa+/KbY7uq25+xO+yONr7OTztzBq5k+K4FF7rOzm
	ZbND/zw9bAzu9LsYkTPiIXR1PrhbqX6wCapkcZIhLDfXtKi+y+HIcr2fFe7/CFlz0pSC9yZtEFDP4
	mftcdXMzD8tgO6YPTEYntTmOKsLS8wJhJ0my0xkspztz24jUjNQ0Z6MQmoR4N5fybcyHJPJmTkh/x
	X2Ewwn8MWnnci4Yl67Ywbzb32vhH6lGbMNLuqdXNltgO1E5ydpH59eoHzOv+zFgw7ELighZDasHG7
	eMDC1qQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5z9-00HT5w-0Y;
	Wed, 22 Mar 2023 21:27:07 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5z6-00HT3Z-0v
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 21:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679520424; x=1711056424;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D8JlAx9fAjSL6K3fOSPmttTXIlPh0KaouQUo3UAgoKw=;
  b=f3Pv/NGwbN1uuYfQUGT25i7/95AGtDMsZlsQsaKpKkofVpJfEJ0ZgH+q
   bOZCx0/Nd5+tdAZXcOncYQVdz9OyfagQOsSshuy8Zi2+AsWL13JNrbUOs
   oGbH3P5Go1wK2DO/bQVxmQS395HvbUUq8s08ybOmqcnHCcPcWaZy5caZf
   XeV8fShm3Zs23xM4KSvIAJXToe/A/fqqJ0UQaEz0KeZg2OOE7Ody6myb7
   MyN4lLyvfh76g0zb3R1hkIg4fwCw0d6PaaUUPpqE1KfYS0C/hfygsjKHr
   h4fuVTOLgkgE1hwvBZDdmln8PhbA8ulBgtCJHZZ9U5yenRcsUkYVAjWZ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318987866"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318987866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 14:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856252595"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856252595"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 14:26:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pf5yx-000Dfk-08;
	Wed, 22 Mar 2023 21:26:55 +0000
Date: Thu, 23 Mar 2023 05:25:55 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 aa01c67de5926fdb276793180564f172c55fb0d7
Message-ID: <641b7263.fAaHfpZL6zetEC8L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_142704_345463_619642D9 
X-CRM114-Status: UNSURE (   6.71  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.3
branch HEAD: aa01c67de5926fdb276793180564f172c55fb0d7  nvme-tcp: fix nvme_tcp_term_pdu to match spec

elapsed time: 747m

configs tested: 118
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r043-20230322   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r034-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r001-20230322   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230322   gcc  
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230322   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230322   gcc  
ia64                 randconfig-r005-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r001-20230322   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230322   gcc  
microblaze   buildonly-randconfig-r006-20230322   gcc  
microblaze           randconfig-r014-20230322   gcc  
microblaze           randconfig-r024-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r031-20230322   gcc  
nios2        buildonly-randconfig-r005-20230322   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r006-20230322   gcc  
openrisc             randconfig-r013-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc      buildonly-randconfig-r004-20230322   gcc  
powerpc                     pseries_defconfig   clang
powerpc              randconfig-r011-20230322   gcc  
powerpc              randconfig-r012-20230322   gcc  
powerpc              randconfig-r033-20230322   clang
powerpc              randconfig-r035-20230322   clang
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230322   clang
riscv                randconfig-r015-20230322   gcc  
riscv                randconfig-r036-20230322   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230322   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r023-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r035-20230322   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230322   gcc  
sparc64              randconfig-r002-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

