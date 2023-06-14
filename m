Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A9EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 05:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ibpqK4S8Ett5JkbJJMe+zgKOpfNU3mt0AXyQtJtMs5E=; b=kQbjnLnB80w99Jq1G9KwO8YBJJ
	KLOQmZxuWLSmJ13qbdOcr4gYl37tJwekr5e1KAooJaWrci/7HQoxTzmbRiucKdM/t3mWYa4Cfk+u7
	FvmatAENWAcqxyX0tR/fHzNRPc4RKKM+ZSnEW0NyaaI7TKvWtOBUk/kYxU3Ojgxv3MInvKh8tm4vk
	DMjqojvom+tUlcMgAo2MJEQuKEsyXQw4lWgkaXtppstJzlYsN7XhDPXKhnl0wJyNtdSVFMNvEDbET
	Rq9gk/dUd3XxDYtCrTJjBJmP8m46jSv9TeKnnubTPduh4JnRTXWbkDmAGMJ5e8plHX2qj2MFNC+IP
	PvCLE6Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9JKA-00AGze-1C;
	Wed, 14 Jun 2023 05:45:42 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9JK6-00AGxE-00
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 05:45:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686721537; x=1718257537;
  h=date:from:to:cc:subject:message-id;
  bh=rC3u/m24U4Ia2iCSLrGgFjYwmurdBqQ0bFWrbK8j/r0=;
  b=Y5urdgWt0U41PJKntaLHTNMT832HBU/Oaqvp0W3Iy5U+Jucy6f3D8QA0
   Kv1ghOAlc/oZtYv1jwAY/YsXlnx66UrlzF/sn44oE24XfQtT+FcBZ5Ykh
   1z4U3tqW7m+jDIsOUuItiIwmmlSLNwy1iIB4uONwF7oAy4I0QUk3rQiAG
   T8eoldRYu5RRL+BW73Teui2gevwAmGmIlzxGgAcjddRDhskzzTdQjEQyp
   Bkyn7MYtYCF62zOjsikOOPOGACe1RKMby4+h66ibU106jv+OEE+flByVH
   yJQco4fGTk8LXStFHS+sWTo8DrQ7qN1p7/EIN8dTY2KQ0fVJYdvAAb+Nv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338881160"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338881160"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 22:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1042061106"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="1042061106"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 22:45:30 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q9JJx-0000EV-18;
	Wed, 14 Jun 2023 05:45:29 +0000
Date: Wed, 14 Jun 2023 13:45:21 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5-resolved] BUILD SUCCESS
 a94e75e6ce18e11b8895577e1ea50ba2715cacd8
Message-ID: <202306141319.eVHlmiAA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_224538_055436_C1C3229A 
X-CRM114-Status: UNSURE (   5.31  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.5-resolved
branch HEAD: a94e75e6ce18e11b8895577e1ea50ba2715cacd8  Merge branch 'nvme-6.5' into nvme-6.5-resolved

elapsed time: 720m

configs tested: 98
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230612   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r001-20230612   clang
hexagon              randconfig-r032-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230612   gcc  
loongarch            randconfig-r031-20230612   gcc  
loongarch            randconfig-r035-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230612   gcc  
mips                 randconfig-r001-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230612   gcc  
nios2                randconfig-r034-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230612   gcc  
parisc               randconfig-r024-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r002-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230612   clang
riscv                randconfig-r023-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230612   gcc  
sh                   randconfig-r036-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r005-20230612   clang
x86_64               randconfig-r022-20230612   gcc  
x86_64               randconfig-r033-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

