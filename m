Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A739DCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 05:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bQHcZgwCd0EAkba67DheLUwGJelRRoBQfIol0RtQXQA=; b=FGPmvmgvqwpEAC+e61OaGrvldi
	2AmIvRV0nhrWNkRfFinROBqOvqg8nFJ4B+UzixAnV0EHz/nlajPleuFY39gBGfsZtIhP2SKXD3gyS
	TyjqwjHAhuYLbA0DDPTKzuxvtZKTKL/nG3jk8V661+cVQNR/ALHK4YvNoL1X2Bs1oHWV6Oo1UVxQ3
	tgYFx3Ld5cRLediv8kLyAR3eDHh7d9QVnOElPFqAh4GP/kq+jw7c2TOnr65gUIaxIEAb1LwNH2jqv
	aTUn5z1U5xm3fo1jeaMnOpD1s8FCPl4AUzPDdxH/jBBolTVtpFoQM+c7925G0uKh4I77wsZpf1vXI
	Z4uzbsww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrt9Z-0000000E5Th-32ys;
	Wed, 03 Apr 2024 05:27:17 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrt9X-0000000E5TD-2Ok8
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 05:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712122035; x=1743658035;
  h=date:from:to:cc:subject:message-id;
  bh=s4oI5FdU/nmIbOnN1hoc+If5q10/Av4Sq32jriaWjqE=;
  b=DrUNpH3uScJnk374+u4G3hUCS7aDd7d6yNX5h8MTxdu/3K2Q3D3aBnHj
   9lWUcxC9nB/lI1wwrk0V/xUTg9p1eZW79rQidSgZyp42+enhjHo98IypK
   RIaSMz+85bTBh+O2H0QZf34kw/JsKMWJc7DghcYk0tjUutA3hB2Bh7SNN
   an61VcuiYgknJNlk/URFLdigErr6JQFlL1t6dKFAS8ZrbpcyLWDy6vR2Y
   +HY5mNIHkVDPZP4Qgbl+4+O03dIQFOmdynaJbP/FiL13hergf3ehnF4Uh
   vKQ0IzziB3F7NkjjwG2OsbnJMGOBz3dIzebfN81lSTXsyU7s56ZbsRFfP
   w==;
X-CSE-ConnectionGUID: RxX7xSh7S/6mcgxWGCCUjg==
X-CSE-MsgGUID: yEDFgq0/QWC0GJ4K7pQilw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24828311"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24828311"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 22:27:13 -0700
X-CSE-ConnectionGUID: 2WKNseQnQUedqaA8Jw9EfQ==
X-CSE-MsgGUID: ii5Z8xxCQaazd/yhj6f9tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18276223"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Apr 2024 22:27:12 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrt9S-0001tR-0s;
	Wed, 03 Apr 2024 05:27:10 +0000
Date: Wed, 03 Apr 2024 13:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.9] BUILD SUCCESS
 c85c9ab926a592e2f59f7d9a6ca7d6562843d8fa
Message-ID: <202404031313.Sf0ESbeB-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_222715_654757_1F249BCE 
X-CRM114-Status: UNSURE (   4.86  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.9
branch HEAD: c85c9ab926a592e2f59f7d9a6ca7d6562843d8fa  nvme: split nvme_update_zone_info

elapsed time: 772m

configs tested: 84
configs skipped: 4

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
arm64                            allmodconfig   clang
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
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
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
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

