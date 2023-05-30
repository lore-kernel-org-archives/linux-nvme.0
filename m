Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09E4C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uLGTpsHSLR8WPogQuRRQBBMIYp9gan719SX2zWhNXYY=; b=k/IQ6BGx2XDx3WH0QPtMO7wDHd
	za2FmLeJK7/XgXajasrDrhMr6hq13KqVE7M74KgtxPCU0Ahiqk3fjjMxcNC+Vuvj9cwQ3SYZ+pJfA
	MZULKDf7E9KmX7Mr/ZXVwsjvp4ue47+kZWKIuSwBaol4XtC3f89s0ISeRlU3vlfESm78y0tEq/Ze+
	CiXFhlWpOsFFWw3g18djXFi2eM4p6TCCQBWvT4t3VNkFaup4tjsU00ofOjaEH1EW77dgxlVR5BrBt
	9AwPGlNO9F8X4NZKjW8o/Q7jPVtOc5+dRKeCYQ94y44mjiaK9qNZD0/WUXYRcGAO0LY2J9HRIf4bf
	TtvevfLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3xmy-00DhQn-2t;
	Tue, 30 May 2023 11:45:20 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3xmw-00DhPf-0I
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 11:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447116; x=1716983116;
  h=date:from:to:cc:subject:message-id;
  bh=a9ZX2CDAqw4PshCaHoEpxpKvIZPRNrphwjj3casIiII=;
  b=kQFrMAqLhGbJznpmk2IRu1xxOoc76+j8cSNhH0CIr1MN+icJoLVN4eP0
   Snel/59HTvx7QOOelAr7khUU8VRi0Ziw8ys68EgthsiY6VLZgwlvMrdIX
   9F9CFqICN5U8PSA8EleXLwTZVE2BP80RFgakLZWFa5XwWcCg0jY9yo0dm
   SjNO8UKVFj4vWvTvNpZUB9wWoKWFxGBp7XgJSZm4JWnxA6y7KZxoN7r8Y
   sTSuqPmuHqjTDLVFZGMwals/9QDgJBRdGIyLJpVZB4dnqjdNXWz3v1P36
   rnfBigG0SDhDgrv8tmnDfvqdKSMvYneQz1pyAk4f4QhVQlWfOLpLTOw2q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420649840"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="420649840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="776299107"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="776299107"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 04:44:53 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q3xmX-0000AA-06;
	Tue, 30 May 2023 11:44:53 +0000
Date: Tue, 30 May 2023 19:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.5] BUILD SUCCESS
 01cff945c026f1e245ba6401f7df2336ddbae11d
Message-ID: <20230530114448.Ewepn%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_044518_249695_A35B5130 
X-CRM114-Status: UNSURE (   7.00  )
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
branch HEAD: 01cff945c026f1e245ba6401f7df2336ddbae11d  nvme-fcloop: no need to return from void function

elapsed time: 6806m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r035-20230525   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230525   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-r026-20230525   gcc  
i386                 randconfig-r033-20230525   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230525   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r031-20230525   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230525   gcc  
parisc               randconfig-r025-20230525   gcc  
parisc               randconfig-r034-20230525   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r036-20230525   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r032-20230525   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

