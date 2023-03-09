Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20AAC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 22:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MiVeQPtZklkLznLZHyEu4TLEqXLakD2nPTMnYsTvOzM=; b=GlVb0fBMszic4esYJCk+0BZI2c
	vLt2y7/OUYDMODIAcxh5AB95JjTCDdUYkB1Y9pfGRuw5XyWcxP8tOkKXn2cjzQCEsXF+viXFA76VT
	HJ/cA602IYZ+3vJd9F3n6w+TwlxQazUI9UAJ6dXG+rZfvZOZPGq+HHaYI8mimJAoZcQBLqB5WD6Bi
	Ct1iC9KGXmQ+N2v3sdHBoL1G2cuNsc/9AAlXUmWrKxtTxpOupB+QEc9qq0t09RNHojq795oVfN6An
	yw3W71fFfZilpOR0HFZc7GO6JiId/fMw2SGWjBC6NhucGgrXLIUSl4mIXJZndGn+bWaR5Du2SLEAp
	c8YfV2uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paONh-00C6vr-Gj; Thu, 09 Mar 2023 22:05:01 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paONd-00C6v5-UF
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 22:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678399497; x=1709935497;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=O6kkUkDTrArvYxCRaReV9HwPy6nTQ81TQvRraTdyNmk=;
  b=XJA1dh8sIAVwplIGOAlp43DT8H15LcjuPALEu232S7SdMJ8+t0q0XsLa
   8t2NoRNON7b1mctigWi4+btMnp+FfS8TBxlLRrU8/wfY8gPfy4/lfbSnJ
   LOi/3hcZrP2JvtmsBVnP/PwWNgYAyPf0OWIVY6ycd3OreRKUzx++nXloi
   75ynWOTFlBZ13JAOiCCz0MJe/WqZsWVuZ6po8+QKvjSgkCuXTGmM2kIyd
   nl2cifEK6G81V8NtIjs5Q4QKV0q/Oy8ocuyDKPqj0nhGTWkF4EZlkGkf0
   o7jkJHEqSOdez+mYqFLn2WAnQVbJ7b4uMopWXj35H4/OotTHkTwHt9hEv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335281033"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="335281033"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 14:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627563389"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="627563389"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 14:04:41 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1paONN-0003G3-0R;
	Thu, 09 Mar 2023 22:04:41 +0000
Date: Fri, 10 Mar 2023 06:04:04 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 4ec203d5469cceb229e9f4abca2fd831f81f7ce5
Message-ID: <640a57d4.IDx3IPBNvqow5uf3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_140458_014415_417863FF 
X-CRM114-Status: UNSURE (   8.10  )
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
branch HEAD: 4ec203d5469cceb229e9f4abca2fd831f81f7ce5  nvmet: Avoid potential UAF in nvmet_req_complete()

elapsed time: 730m

configs tested: 96
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230308   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230308   gcc  
arc                  randconfig-r021-20230308   gcc  
arc                  randconfig-r022-20230308   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230308   clang
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230308   clang
csky                                defconfig   gcc  
csky                 randconfig-r024-20230308   gcc  
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230308   clang
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
ia64                                defconfig   gcc  
ia64                 randconfig-r026-20230308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230308   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230308   clang
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230308   gcc  
openrisc             randconfig-r011-20230308   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r033-20230308   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230308   clang
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230308   clang
s390                 randconfig-r035-20230308   gcc  
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230308   gcc  
sh                   randconfig-r003-20230308   gcc  
sh                   randconfig-r031-20230308   gcc  
sh                   randconfig-r036-20230308   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230308   gcc  
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
xtensa               randconfig-r006-20230308   gcc  
xtensa               randconfig-r023-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

