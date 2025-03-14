Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A8EC282EC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6e/wyWy57O4V1bq7tEzBusb4j1kc7cJ68LJiM0h6ccM=; b=Ec2mMNfv6ZCqQfz8nX7YBG5+SS
	r0bSrivxNCZ0UMJ0V+Z/RRn2Vz51GwZdKEWS4REHR5T5yY2l68cmUnd3ZEzokUQslgOv8E6YYW4iT
	R3CKLS9FiFEiIcuBKZXWS0QwjG6LWtVYkglCJBgvAYWOqL1ZJZk/HCyl4TwkYaM5/pWb2mTRt9zG/
	xmGBAseLcGKnpG++k9erLiDf38oLGTB/e9G/IbyK+cQRaP9+ga0rBJlV2vJOtJ8ckfnh7Z5JrC+sb
	gPNGADPWWOTv/LurXtIwXBWXTlpsNvSKAcAjx/GiStAtb+mtIG1obK+2e/x+0EXegycO7cBzyBE1M
	c+SXotHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9t7-0000000F2MT-3PnC;
	Fri, 14 Mar 2025 18:36:05 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt9hR-0000000F0wL-2cXv
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 18:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741976641; x=1773512641;
  h=date:from:to:cc:subject:message-id;
  bh=48jDGEAk7kjcFUgWg6PCkDLQC2WpwMxnEfIyZqVTCZg=;
  b=L04KkOKAm4txOwpuQVd3cT1LjwawAh60yClogMweZ6Sl2LwPmLCSvOkj
   HJC1SSV4PP+tIko40musDZRpfZl2ht6toqjyNNyfbI7qVrF/G8GGWkLag
   joZjgy7WKAlksOitwjfs+MITWqaTci/wnQbmhhDhxFTqMzKRpHwYzWq5S
   sAB0NCzxVUj+TOYD4cXwZZH5IanqiSWabUvV+2zT+7AqEOJCYypNq/KIg
   Z2K3lpEIlmGTMIM05nTVDSDw1dlGAnFwQrOqqU8fZBqMcjMgJpYFUdsMH
   h+QirrHdKctVpVMGdPdy488aMTaLNKQNrjj29h/N1SHlgQ4V9gvOL5mdc
   w==;
X-CSE-ConnectionGUID: wAqqAPRlRJicBxEMc+JfBQ==
X-CSE-MsgGUID: hyF2N4zFQvK4gGEUcibZBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54137215"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54137215"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:23:57 -0700
X-CSE-ConnectionGUID: EQN86ZYbTP6tbdpCn5rWrQ==
X-CSE-MsgGUID: UY5hCizsT1iYsX6sgZebjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121390487"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 14 Mar 2025 11:23:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt9hK-000AjU-0y;
	Fri, 14 Mar 2025 18:23:54 +0000
Date: Sat, 15 Mar 2025 02:23:19 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 a34c8d812a0a4b3259614bfca6f3c7e78056d7fc
Message-ID: <202503150208.4hO1sOdP-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_112401_713358_57C5A67E 
X-CRM114-Status: UNSURE (   4.45  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.15
branch HEAD: a34c8d812a0a4b3259614bfca6f3c7e78056d7fc  nvmet: Remove duplicate uuid_copy

elapsed time: 1451m

configs tested: 88
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250314    gcc-13.2.0
arc                   randconfig-002-20250314    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250314    clang-21
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-004-20250314    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-002-20250314    clang-21
arm64                 randconfig-003-20250314    clang-15
arm64                 randconfig-004-20250314    clang-21
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250314    clang-21
hexagon               randconfig-002-20250314    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-006-20250314    gcc-12
i386                                defconfig    clang-19
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250314    clang-21
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-002-20250314    clang-17
powerpc64             randconfig-003-20250314    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250314    clang-19
riscv                 randconfig-002-20250314    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-002-20250314    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250314    gcc-12
um                    randconfig-002-20250314    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250314    clang-19
x86_64      buildonly-randconfig-002-20250314    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-004-20250314    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

