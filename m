Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68564C2BD09
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Jun 2024 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ph3bLpC7zOYiIKTxgTVFGMmDl7ZKeJw0H9zJqouxgp0=; b=cQbQswXyYU1wIf+21Ua6lvLO0E
	hzunGcdTYpu8FThL/j5iDF7LI5A6J2eKbv8yLxWmRXDkxqeJhN/4t+2szh1cxomOJO4Se5xef3rTv
	n3kI7UOEs1AcVovagPxtBc8YYTcI1/0HyVSPrscLrklVVvh1UHe1PULm5kSvjFIHgKQlYAH/W+cM1
	xXVvmtDXD6psArnm8E15hpZmijLleJYDX1t8oQaP2/DKDaihwW8aP2Cihd+QqMHuhjl2WrVmhHlJX
	/EkBNcLmr60k+bCWJRi7KqJqoNX04OuyY1lIhOQRCDIvbmB9Vm8lQ3nviKKgc9li+KekkOHm7xK0q
	2gO1oNeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNLxv-0000000FQnU-2L1B;
	Sat, 29 Jun 2024 00:29:19 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNLxs-0000000FQmH-11eL
	for linux-nvme@lists.infradead.org;
	Sat, 29 Jun 2024 00:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719620956; x=1751156956;
  h=date:from:to:cc:subject:message-id;
  bh=vYOLWQZlgFYl5lwgcT0Xz0GUrB6djldp3s5VRJ3lPwg=;
  b=bo3gksQOzI/N83FWyeyf6VG31iwepWK17MFPYLHM5n2qRDT0fDNDpl64
   ZdYpr3BftlGe/66s1m2uvBVLMSVW3ZhGIbrahQBL167WIzo0zRHTjdpuP
   RbAuBcBi9UAaDiNXEN2IIKaxnZqU8CNBvR3QWjO4pj5O6eWR8TI4yFoJa
   83Ftpnb4BRCvT6qQYc/0Yv/xSBV9qz1wg8ULpEQfJR8HWjTN45pclDqJu
   Ai9E7enU03W1YTm4rfnLIigOBOCQjsqIbla5B1/QimxatyOxK5QUJWTnn
   mmaigUBuTYu19Rcb1VIPfUIQHZRZ6Gy33TEU3ilNYEwy1UvWcGQjNiJtp
   g==;
X-CSE-ConnectionGUID: MBCZv+dmRF6IIFJWuaqYsA==
X-CSE-MsgGUID: TYI5w4o1SeaBo/qFb8KxgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16642826"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16642826"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 17:29:15 -0700
X-CSE-ConnectionGUID: op2I1xMmTVSVuZGIXLMH2Q==
X-CSE-MsgGUID: LkrMAnW9QN+QHf1RlWz1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="75619881"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 17:29:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNLxo-000Ilb-1i;
	Sat, 29 Jun 2024 00:29:12 +0000
Date: Sat, 29 Jun 2024 08:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 62eaa15c6aeef5011d3d41b69b63e02cf280324c
Message-ID: <202406290850.XzkHDk9p-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_172916_361260_1E5770C1 
X-CRM114-Status: UNSURE (   5.07  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: 62eaa15c6aeef5011d3d41b69b63e02cf280324c  nvme-multipath: implement "queue-depth" iopolicy

elapsed time: 3267m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm                   randconfig-004-20240628   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   clang-19
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   clang-19
um                    randconfig-002-20240628   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   clang-18
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   clang-18
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                randconfig-001-20240628   clang-18
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   clang-18
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-11
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-7
x86_64                randconfig-005-20240628   clang-18
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   clang-18
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   clang-18
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-10
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   clang-18
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   clang-18
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-12
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   clang-18
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   clang-18
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

