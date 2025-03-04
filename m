Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1265FC021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOaqqactVj37NSqXHTJMYshtCr89JvWKgbuqKPkI1K0=; b=iEIALc98Yzy4ggIYhJKCjlxVTt
	EPYsXLfrUBTIUKdmYC+YYnyRgosr2k6xlH4uK0Ew9M/csvVMUDT2/rRQERMyK0G6m+hOBMLpMQnsj
	0GW1X+1c6+dNA2T46mxvogAcyV4mQb/rTPpux42fpjIj/n3p3TNR6Fox4vuOUnFvQmyA6trlDbkjc
	T8f6xyNcMn8WLWC2fQ42/lnDnm6PIKOF6PJeIdZS7DNWucft4WsV1gwd2MRX7fe/7Ui5A5utTmPtr
	xYV49tooGw+tmhF4bB3UUtFKYFy2Wh/cqVm8SkLkpZjfxKfHsRwE2Ub8CPertgC8Y4Jn2DEZRTMbD
	ETQFHTxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYUw-00000006932-3AUE;
	Tue, 04 Mar 2025 20:04:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYOr-000000067tO-3su9
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 19:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YOaqqactVj37NSqXHTJMYshtCr89JvWKgbuqKPkI1K0=; b=WIfLNDjaVeQLMHNlPOGAU2k/gh
	1g1GU22jWvt7DpPNpEh8JC2mnmrmOcipot2Bn1wwotuyRB/08laCwOkxIaYOX7GfeuG1SAgRKHHsr
	YJVYF+MIInLS7uk2b7mv4sxauyV/fzHb97DxEhyXuSwpojm03Tzhk5FHg+ya5syzHuw9Dy4rHm06S
	uL0SQqxNu5wUzuNpTjfpdJfcchWBy1iqix2qr26xejV1FWr6XIbQ7mUYGaFrjTASXJn0hFdMfcHif
	q0yBI7ulYp7N9I9hlst+wt9fnOg2y2dlPqIEkDveeKzx2Z+38eR3D524+fUY52hVfgW/K3G5bqwGY
	N6f9jTKg==;
Received: from mgamail.intel.com ([198.175.65.17])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYOo-00000000CW2-0QQA
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 19:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741118274; x=1772654274;
  h=date:from:to:cc:subject:message-id;
  bh=cUs4LDTyspSJ8EeN4eS9Sh/FfMlCWL8TQD57gaM5oSs=;
  b=FBXia/oexLcWZnh6n7ElWujhIRfCfNCMk1TK6OaMERO68ceYFwksfW3m
   fZzPXrdmmNFSLleZikaaodP7rf91yAZC/Xn5maQHwCyrEbG8FKPdeLVUx
   xDn88oVzLfPaDIgw1HJ1Kwvt3mJTs7LWvVR5zfBEl+N1byMjC0fKV/7vX
   zpxjnMF0hr1OSl/4XySE0PdoqL3f3SKNl7LaLnk5Sk19z5WofRFI8DCx5
   7ITL7j4PRNN9Nu0wDvfZs4Jxu00veGf/SbDteyxacNk5/C6VsodvWZMDo
   q4EpnGQYqx9Z4WIWGbKi8kkq6jjCI8AfQgrUDjY5jmi7WykPKQZ0dz2TO
   Q==;
X-CSE-ConnectionGUID: BjNIqtDPQoq5rQ0mLdVYGA==
X-CSE-MsgGUID: yQh8QNrAR0GKwGOP4e/xSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42084117"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42084117"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:56:44 -0800
X-CSE-ConnectionGUID: QxC+kJWQS5ucV5xtJhxZ9w==
X-CSE-MsgGUID: 27gqoZj2SIGV2aQ0urX7ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123671736"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2025 11:56:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpYNc-000KDq-2T;
	Tue, 04 Mar 2025 19:56:40 +0000
Date: Wed, 05 Mar 2025 03:56:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.15] BUILD SUCCESS
 13f8f3946085f178a2b2218fe700bbcd8320e08c
Message-ID: <202503050323.g5OEior2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_195754_633627_9ADEBB3D 
X-CRM114-Status: UNSURE (   5.30  )
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
branch HEAD: 13f8f3946085f178a2b2218fe700bbcd8320e08c  nvme-fc: Utilise min3() to simplify queue count calculation

elapsed time: 1452m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250304    gcc-13.2.0
arc                   randconfig-002-20250304    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250304    clang-21
arm                   randconfig-002-20250304    gcc-14.2.0
arm                   randconfig-003-20250304    clang-21
arm                   randconfig-004-20250304    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250304    clang-21
arm64                 randconfig-002-20250304    gcc-14.2.0
arm64                 randconfig-003-20250304    gcc-14.2.0
arm64                 randconfig-004-20250304    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250304    clang-19
i386        buildonly-randconfig-002-20250304    clang-19
i386        buildonly-randconfig-003-20250304    gcc-12
i386        buildonly-randconfig-004-20250304    gcc-11
i386        buildonly-randconfig-005-20250304    gcc-11
i386        buildonly-randconfig-006-20250304    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250304    gcc-14.2.0
riscv                 randconfig-002-20250304    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250304    clang-15
s390                  randconfig-002-20250304    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250304    gcc-14.2.0
sh                    randconfig-002-20250304    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250304    gcc-14.2.0
sparc                 randconfig-002-20250304    gcc-14.2.0
sparc64               randconfig-001-20250304    gcc-14.2.0
sparc64               randconfig-002-20250304    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250304    gcc-12
um                    randconfig-002-20250304    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250304    clang-19
x86_64      buildonly-randconfig-002-20250304    gcc-12
x86_64      buildonly-randconfig-003-20250304    gcc-12
x86_64      buildonly-randconfig-004-20250304    gcc-12
x86_64      buildonly-randconfig-005-20250304    gcc-12
x86_64      buildonly-randconfig-006-20250304    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250304    gcc-14.2.0
xtensa                randconfig-002-20250304    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

