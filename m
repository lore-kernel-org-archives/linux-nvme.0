Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14763CDB47C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sdGD/RqZTmPwfHtgPNIMMypaLlAUM5h2rokHFEL/GCs=; b=XAmD12jayZGyGfDDOagrKPTT6Z
	S5QF/iXPgdWFzlnykuXupCSxyHwRfB3RDPR317W0wu4gcESGFuYDtkuM1kj7E6PZcDfPsicKfjYXv
	ijHWyuSrygtKYD3NU2lbexh/oaH8znIjG1TLhGa+WmzDRw2DADSF+zqQZh8jzbWqp+89glpa+bLIb
	YKYrCpr6/K5OzSBCeQfOoefIJV7h0CpSOBSUq+aKU2vI4Bm/Lm+lDdN3EKp4fAM2suCb1nRmDGLFO
	nFo+l1s4RE5wZt5vsO0BO7m8Ol+yTT6kLZ+wnYFq987VUCoMfBBMqJObAF3TOKZ7h3ce6omKEb+c5
	u2xXzSow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqeUU-00GVu6-1i;
	Wed, 11 Oct 2023 19:03:30 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqeUR-00GVtl-39
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 19:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697051007; x=1728587007;
  h=date:from:to:cc:subject:message-id;
  bh=acR47KLQCaL0eyEJsrVkdTAPqN6AbOLeV0iifOfIcIo=;
  b=nUD8V6UqDIy6nXTPKceTHTvo0XECVBYdbW5o++NO/01225uif+Yq6Iua
   Tpx0J0ALG5qjjC/kDSWiMDOpgfEOg11FFH0eZSz2mKsPgPaC128qFlnRB
   pVhpjyMK3Jbs+owkCpoL1drOKJSlH76CErCY1BqkkUEtMSI+HzbKnHZJM
   4isKj0DZ5pYQmB0NAyQTbWf4SmD1IdNisV411NBo7GOl5v9oRT3XrHHIf
   AKKLNETf2dQb9MenGYiSoJjTH5UjBnnlmf3BFwsnIQHf/P5vLzARm2OZh
   +mzbsMsx1q0zz9E8JYkFHGPIunzWZ1W2+QPQ2hhBaDLusYjD8wGuZ+DsZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="387590539"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="387590539"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 12:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="1085357770"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="1085357770"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Oct 2023 12:03:24 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqeUL-0002bV-22;
	Wed, 11 Oct 2023 19:03:21 +0000
Date: Thu, 12 Oct 2023 03:02:46 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.6] BUILD SUCCESS
 4ae55a7dce04989f289d5c5c8c8e5c37adc36c71
Message-ID: <202310120343.FM2OxioB-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_120328_110706_54B5CF1C 
X-CRM114-Status: UNSURE (   5.69  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.6
branch HEAD: 4ae55a7dce04989f289d5c5c8c8e5c37adc36c71  nvme-auth: use chap->s2 to indicate bidirectional authentication

elapsed time: 1613m

configs tested: 140
configs skipped: 2

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
arc                   randconfig-001-20231011   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231011   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231011   gcc  
i386         buildonly-randconfig-002-20231011   gcc  
i386         buildonly-randconfig-003-20231011   gcc  
i386         buildonly-randconfig-004-20231011   gcc  
i386         buildonly-randconfig-005-20231011   gcc  
i386         buildonly-randconfig-006-20231011   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231011   gcc  
i386                  randconfig-002-20231011   gcc  
i386                  randconfig-003-20231011   gcc  
i386                  randconfig-004-20231011   gcc  
i386                  randconfig-005-20231011   gcc  
i386                  randconfig-006-20231011   gcc  
i386                  randconfig-011-20231011   gcc  
i386                  randconfig-012-20231011   gcc  
i386                  randconfig-013-20231011   gcc  
i386                  randconfig-014-20231011   gcc  
i386                  randconfig-015-20231011   gcc  
i386                  randconfig-016-20231011   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231011   gcc  
loongarch             randconfig-001-20231012   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
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
powerpc                          allyesconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231011   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231011   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         microdev_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231011   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231011   gcc  
x86_64       buildonly-randconfig-002-20231011   gcc  
x86_64       buildonly-randconfig-003-20231011   gcc  
x86_64       buildonly-randconfig-004-20231011   gcc  
x86_64       buildonly-randconfig-005-20231011   gcc  
x86_64       buildonly-randconfig-006-20231011   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231011   gcc  
x86_64                randconfig-002-20231011   gcc  
x86_64                randconfig-003-20231011   gcc  
x86_64                randconfig-004-20231011   gcc  
x86_64                randconfig-005-20231011   gcc  
x86_64                randconfig-006-20231011   gcc  
x86_64                randconfig-011-20231011   gcc  
x86_64                randconfig-012-20231011   gcc  
x86_64                randconfig-013-20231011   gcc  
x86_64                randconfig-014-20231011   gcc  
x86_64                randconfig-015-20231011   gcc  
x86_64                randconfig-016-20231011   gcc  
x86_64                randconfig-071-20231011   gcc  
x86_64                randconfig-072-20231011   gcc  
x86_64                randconfig-073-20231011   gcc  
x86_64                randconfig-074-20231011   gcc  
x86_64                randconfig-075-20231011   gcc  
x86_64                randconfig-076-20231011   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

