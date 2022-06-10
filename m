Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C6AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=22RHSSRQaTCmv5hZteJhWUG4zX5WVcwu1MZmuQ3cfpw=; b=3iEtcaTRAmhW/6p8vSz/h+9YsT
	P4KgvhsmCZHnR7nLKPngRGBD1QiTpd6rITebrbywjAmWQghz4Taga0HtjOvcVLBnnHdO3Tc+9LN1H
	x8KdTiga1Mp8LlateEefkLcr25zR62qEk6H2R1Q891JOGuo3RfaFIWTneEyES2isWDIvYxBXxSfWV
	5Hpw90MmZWRChzJEzKxeLjDqh+mtb95HPoi+leKqGDO9HXo2+/Dra2XOczs59+LKJrkF5/05rYsGF
	LMnTFKMYtD8pytqlk2oBInKOK9TAniQ8X5oQxr48tOETRbq8Rfwhiu2427vforN9PJVulm2F4NgU2
	zyppD1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nziKX-0098Xm-DH; Fri, 10 Jun 2022 17:21:53 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nziKV-0098XA-4P
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 17:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654881711; x=1686417711;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pPPM6I43ejXvp7L/23xgTB1tN04Ns7/Fh7W9HZ1ijdE=;
  b=NtlGJVYmpOUot3MYVqS9ZMaIye5Y0qC1bYnWkiz+aHVcB/q0T3SMVYfG
   sRp16NB0PMnlZenVZKznB1UgkPnAXeO3eyfocpjSV7KM/l/V0SgKm7Bip
   jtLZFlxhrNOW6RBEhHFnsEHHD+xPP5j9TV1ZdlnJK9Eryrdg3bblUFcxF
   n5kEBOMBZvgbaxYIlnpGHScz5zkDBjMxCUGHxsllRBIDR7oMjwjVqbzS/
   WKaLHkKVbg7Q8Fe32dO+mSzoA1msZ4Oza7wo9RMXvfdystEzihbA94v4+
   ZAnzzW9uzeeElvHnueqegbC0KcQG1b6ZTnExiA3KdPhfbycHcgxlFLptQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="257520246"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="257520246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 10:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="566927874"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2022 10:21:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nziKQ-000I8z-1G;
	Fri, 10 Jun 2022 17:21:46 +0000
Date: Sat, 11 Jun 2022 01:21:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 91e85faffdfbe1612bf25bfdf37e7118a4a84998
Message-ID: <62a37d86.+KqFBpqBSfNxsyXU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_102151_274981_AFB15402 
X-CRM114-Status: UNSURE (   7.22  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 91e85faffdfbe1612bf25bfdf37e7118a4a84998  nvme-pci: add trouble shooting steps for timeouts

elapsed time: 4724m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220609
s390                 randconfig-r044-20220609
riscv                randconfig-r042-20220609
hexagon              randconfig-r041-20220609

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

