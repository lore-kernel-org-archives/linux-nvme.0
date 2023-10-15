Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F75CDB465
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Oct 2023 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rw4+KznN+PAAP6Ev3betJ8PJ3/VsXVI3pNtagnUcXv8=; b=YJRF6/zx6lCw2bq429c9xHy/Mr
	rz+xvHvChgYQMjASHh4xBw/qJOsZWuxCMBlCAYLMbaZriSfkhZCmoncdALrnF4riPpIsqDPr3ZObg
	ao9+n00oE74p8jxnKnhHN4TgkI0HaorXKUfSiJ9FZshRO+Kw3P5kyh+kKrNMHHtDzbz+JDFbyjN2W
	wFVCcJciOPyMPXgiHhGbql9FR1nkSJvQLAhnwCKhA56nrOsTv6UEG72TdJaoX4iM/0dHcV21b1RDN
	s9rjlGybRx/o1ds4ogO+Svvq0OfI2Fyrd0NhiQ0IiNZMbK/DzFBQ/xd/uTfmWHikcc9/dkb4dRq7f
	6BgPw6QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrqk4-0064aO-1p;
	Sun, 15 Oct 2023 02:20:32 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrqjz-0064Yp-1u
	for linux-nvme@lists.infradead.org;
	Sun, 15 Oct 2023 02:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697336427; x=1728872427;
  h=date:from:to:cc:subject:message-id;
  bh=T2/fDnwNMk1QzVfLQMH7+l2eSwMcLUBPsCUTdob7+Ig=;
  b=JJZIBe/tqk4Yb0FP6gsUWS8x246Ce4V59RpPtdISJajvdHqKpO3qequ2
   g8Ly5c9b3CwZZ2w2fpJ2EyaERPZLwvuyoVEKit/IGRTRax7hPh0RCAbke
   4Z4BiBxq3DTl2P/HqHzQzap9I/wLivQWirL6l1JOPNCPiZqspqElhgVeX
   jwxmcosDASX/kdjJar+ukCi7rjpAd/ChVWDMD0tl3ToasJg1vm8O5+0o8
   SoGsPJIWTR+WAMAFL7OzuU+JpXQjF+zcYtoT6H3KZpd9qANcfRJFXdSpY
   qLkwDUv2hd98oQm3HOWFUgB90jaygSziSu/2gmJEHa2GtngMMy4w55ZB7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="388217180"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="388217180"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 19:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="748830559"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="748830559"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2023 19:20:14 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qrqjk-0006vn-09;
	Sun, 15 Oct 2023 02:20:12 +0000
Date: Sun, 15 Oct 2023 10:19:44 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 4e77be20de0bde1bd17c7c5b06263575dad4f83f
Message-ID: <202310151041.JlpRYF9c-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_192027_742940_8D1FD184 
X-CRM114-Status: UNSURE (   5.18  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.7
branch HEAD: 4e77be20de0bde1bd17c7c5b06263575dad4f83f  nvmet-tcp: use 'spin_lock_bh' for state_lock()

elapsed time: 2151m

configs tested: 130
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231013   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231014   gcc  
arm                   randconfig-001-20231015   gcc  
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
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231014   gcc  
i386                  randconfig-001-20231015   gcc  
i386                  randconfig-002-20231014   gcc  
i386                  randconfig-002-20231015   gcc  
i386                  randconfig-003-20231014   gcc  
i386                  randconfig-003-20231015   gcc  
i386                  randconfig-004-20231014   gcc  
i386                  randconfig-004-20231015   gcc  
i386                  randconfig-005-20231014   gcc  
i386                  randconfig-005-20231015   gcc  
i386                  randconfig-006-20231014   gcc  
i386                  randconfig-006-20231015   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231013   gcc  
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
mips                  decstation_64_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
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
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231014   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231014   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231014   gcc  
sparc                 randconfig-001-20231015   gcc  
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
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231014   gcc  
x86_64                randconfig-001-20231015   gcc  
x86_64                randconfig-002-20231014   gcc  
x86_64                randconfig-002-20231015   gcc  
x86_64                randconfig-003-20231014   gcc  
x86_64                randconfig-003-20231015   gcc  
x86_64                randconfig-004-20231014   gcc  
x86_64                randconfig-004-20231015   gcc  
x86_64                randconfig-005-20231014   gcc  
x86_64                randconfig-005-20231015   gcc  
x86_64                randconfig-006-20231014   gcc  
x86_64                randconfig-006-20231015   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

