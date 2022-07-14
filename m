Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60800C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 02:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a3jMGOsFUAvwxHh2Ye2u1362IV5klHlO8ASsZKgxpIs=; b=DoT91vFnbiQm/gogEuWtRBRvdK
	B36qxjTMGrARKn94zxqwYoDDTErb9ulb1zwaFqTtad+os4Spm8zUjd9uUXN7EgircPh9HkzvUa9Y3
	DpjUq96kRKKKNeB9Ii4FSdaAdfOenvC3p6XEaC9QYW6dwvrvh2r9Y5UYRXgaVWZxt4usnAe5t7hHG
	0Ky4MGyFsR19CLhQl6P5CLDVe7M3wQ6uzQtKUmelA8l9gqDglDWKjBMwDOjVuEPpHJWUpOwfL1wcK
	Ay6PjTl3jTA6rNSI7RIEb/wXnqQ3c/pkEd/DxpUpexkqKDFSMdRGdUQoPgwq8Z8MdL0cBjP/O1ZPU
	qbzyi9XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBorW-00A6Pp-Ow; Thu, 14 Jul 2022 02:45:58 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBorU-00A6Oh-BT
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 02:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657766756; x=1689302756;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OIrM3wF2xvR5OX1szMnGkaf1qCcgLo5wQ2hv+q4C4Qg=;
  b=bCtN3Vc/+BCdlV7TpdMZO/3Wj2oijAGwsJ4dIQzY/GNUyI42mOHhWk2K
   JP8RDy5XYRyUdVO81XRmuBy1dmrmHCzcjc51qVKkiu3U4aQ5jEmNPSVKu
   SyZGsgQjPzwA8E58zsTUcvtYOPIa2lb6XxkPaFPYkZXtpLiwJ56xeSFKE
   mmxRUKughNjw+pYo06eat+oBTEjil1dBtXHuUNYb3FeZAMRISb/Dps7ox
   QPb4WvP200goMeHfh8M36vWKj/4Kkrkq4k7GfqFzPloO4ET4gC5KCGvam
   wqK5BrWgCFPhOAAMCmKMEUCguHM09tmtUIQAU+zcYyp628isQXGnD9O1l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265809639"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265809639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="628542736"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2022 19:45:54 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1oBorS-000058-2G;
	Thu, 14 Jul 2022 02:45:54 +0000
Date: Thu, 14 Jul 2022 10:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 043893b21183cf14c3b5afde52eeef215b043a33
Message-ID: <62cf8332.Fos07PCtNyWGRtuG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_194556_439409_633144B8 
X-CRM114-Status: UNSURE (   7.39  )
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
branch HEAD: 043893b21183cf14c3b5afde52eeef215b043a33  nvme-pci: fix freeze accounting for error handling

elapsed time: 864m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm64                            alldefconfig
powerpc                     sequoia_defconfig
sh                        edosk7760_defconfig
sh                          lboxre2_defconfig
sh                               j2_defconfig
um                             i386_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  storcenter_defconfig
arm                        shmobile_defconfig
sh                           sh2007_defconfig
sh                  sh7785lcr_32bit_defconfig
csky                                defconfig
sparc                               defconfig
x86_64                                  kexec
alpha                               defconfig
arc                                 defconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
i386                              debian-10.3
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220713
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
arm                       cns3420vb_defconfig
arm                          pxa168_defconfig
arm                         socfpga_defconfig
riscv                          rv32_defconfig
powerpc                      pmac32_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220713
hexagon              randconfig-r045-20220713
riscv                randconfig-r042-20220713
s390                 randconfig-r044-20220713

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

