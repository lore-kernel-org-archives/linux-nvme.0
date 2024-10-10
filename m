Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E7CD24459
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 22:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1/+BTE7HBxgpKugJem3LPlejP2pSpmtyFeM4hHCyYVY=; b=hQaBAGphRybNcMqOIkPqs46vjO
	wAAitaPVrrC3ZvPptzEEXAapnUkCMbtRI3XliS9UdN5BJADk/JAatb8gkhBetgqI2/fKFRSNC7tS+
	MQcVutixPVsSGybOVGr4Ciaf/85pBCZlGcWR4BNDETMJGqRAnlaDYaNWyAbEEbj8Y1hEN5drgIbqD
	BGZbTZk9QIoDhQT1/jIboMtMzreKtiOX1MYnme3ZScuKgHNbwq3Us78QNCj05nDk5NzeuSzl3fnjg
	aJ5tQUcm2+uNPASHjMmtOm3F9Vbxn7cB4M+SSU0qICDPNFL7duaWtx7as8pONyIhLjbWoNgsQ1keP
	1yTrK8bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz1X3-0000000EWx1-19bw;
	Thu, 10 Oct 2024 22:21:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz1Sh-0000000EW81-0iCP
	for linux-nvme@bombadil.infradead.org;
	Thu, 10 Oct 2024 22:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1/+BTE7HBxgpKugJem3LPlejP2pSpmtyFeM4hHCyYVY=; b=TvEcz5c8n1AV2yQ1fx0qH+FH/+
	R8rf46YRu9cmlry79WmJpZLhfYalD+sTr4xTwg0sW+u3ha9aNlWUDm3ydI191SexNEpH9WpYSDzNo
	9m/JOZbTubRSsDQhBBxiHHR8Oftb7iJ+SF6frR2vbymlSRysyqFjm5X476OaQey1JxjZdNJLbFq+d
	78cmouVdnU/Kt15ZxIwJk0cBAoyl+J8FOU8nr4HJWIRzNG79SwJqzxY5Rh7UOkrBH9FdV/4PJc4WP
	UIcGTe5aLlvkmJuKDdX7YVKkPoOlmZXy3XqLYMrltfwDOf1gj6QnBiertD5ghJk5IfZqL+nPR7ivg
	uNf+3x5Q==;
Received: from mgamail.intel.com ([192.198.163.19])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz1Sc-00000005hCu-2arn
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 22:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728598603; x=1760134603;
  h=date:from:to:cc:subject:message-id;
  bh=z7szvxJEGvFK2BAYUPagS9hKa2EiNWovxHsI8kwGxys=;
  b=Rkkb+bvmHKe+GXbCABnvjYQTFlperlan/i8Vmy4WE83jfjsB7+YQZgI/
   yy62m35jFjvE/lUkVG5TYPtbZp1UGwjyngUTKibBbYUr8MQDKKOXAzKnP
   W5fD1t0622eqUw8thmhhYsnrK4/2hPgX34yN6/iSC9vIWZfT5Z3LSOC8D
   K9blfhEOWn8RgYses5948IjCgH1i9/YxzazV5qBBXadW9oFscRjPHC+of
   cZ9+sMY1pvWEqCwfLTre1konEW2BksxhQP/mKvuNHMnSjw11iAtqzvCyg
   /lb/G5fH8Syuz15d5kKHnHlFHdopGLj5ZCo2VUpXPzBVMnBwjfljlT7ox
   A==;
X-CSE-ConnectionGUID: gGs0RL1eSR+gX5cqKTlwaA==
X-CSE-MsgGUID: 9EP0Sg1qReqR6+vJGeL7IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27453011"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="27453011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 15:16:38 -0700
X-CSE-ConnectionGUID: pEZm1ppmQNqm7PbZzsPpZg==
X-CSE-MsgGUID: GsPxQeI6RnqrGoa1s0ZwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76932544"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 15:16:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz1SU-000BLH-19;
	Thu, 10 Oct 2024 22:16:34 +0000
Date: Fri, 11 Oct 2024 06:16:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 0ce96a6708f34280a536263ee5c67e20c433dcce
Message-ID: <202410110621.mqeIVPWZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_231643_597972_C2040705 
X-CRM114-Status: UNSURE (   4.71  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 0ce96a6708f34280a536263ee5c67e20c433dcce  nvme: disable CC.CRIME (NVME_CC_CRIME)

elapsed time: 1423m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386                                defconfig    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241011    gcc-12
x86_64      buildonly-randconfig-002-20241011    gcc-12
x86_64      buildonly-randconfig-003-20241011    gcc-12
x86_64      buildonly-randconfig-004-20241011    gcc-12
x86_64      buildonly-randconfig-005-20241011    gcc-12
x86_64      buildonly-randconfig-006-20241011    gcc-12
x86_64                              defconfig    clang-18
x86_64                randconfig-001-20241011    gcc-12
x86_64                randconfig-002-20241011    gcc-12
x86_64                randconfig-003-20241011    gcc-12
x86_64                randconfig-004-20241011    gcc-12
x86_64                randconfig-005-20241011    gcc-12
x86_64                randconfig-006-20241011    gcc-12
x86_64                randconfig-011-20241011    gcc-12
x86_64                randconfig-012-20241011    gcc-12
x86_64                randconfig-013-20241011    gcc-12
x86_64                randconfig-014-20241011    gcc-12
x86_64                randconfig-015-20241011    gcc-12
x86_64                randconfig-016-20241011    gcc-12
x86_64                randconfig-071-20241011    gcc-12
x86_64                randconfig-072-20241011    gcc-12
x86_64                randconfig-073-20241011    gcc-12
x86_64                randconfig-074-20241011    gcc-12
x86_64                randconfig-075-20241011    gcc-12
x86_64                randconfig-076-20241011    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

