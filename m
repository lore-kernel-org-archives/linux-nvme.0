Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A312C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Feb 2022 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EXv2IAtR8s4rczhgKNbQTcev4yAW4qmK3uuSaOlfrZE=; b=4oovir4quS+c/yWBPICZ+kYqsa
	wrrwdRnwEqoeX5BU7XRVkyp52IHWqPQdtwNCTWaRA5K08IypK6nwG1g26f9P7j5XVJxdA3wfVo9bm
	hb0DldyIELzgg5seDINXPyvl0GKfReQn8vSzzjyJrDxB8R8g32ro5um5kSr3wtx16U0+dY4tIXS/T
	G8TxCuZWjqMYAS6JJ/aANtR7P+tBOdIrImw1gkkqA8a/KyeGDfXcWEaCVNusS054RkLYK2xP8jld6
	qwh+1TOheDPLma71wlQV0Qug2niH5OCXFO6jfS3ZgHuYiu+ynUCAVG7kSg/ScI/eXpqrmh9q9xhaW
	8FGtudew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNrHI-007bDn-4M; Sat, 26 Feb 2022 07:14:04 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNrH0-007bDA-FM
 for linux-nvme@lists.infradead.org; Sat, 26 Feb 2022 07:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645859626; x=1677395626;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ryYI8DAPzZhoFbYhbykaC7PAmHuqjUMJUEZsyzwPTHo=;
 b=R6V+uMEC82sJ+QiL1pUx6g1pR1yQUXDGkjQpf/pvBIR7J2ak65SGPVh1
 Ok0++o1N014pWY5R4/8mxbEVKPqyVLhrX9r98F4iD3CLC286TN/g/s/f8
 /aManclYNHdgwhkFfOblj2vSFoYuSYoofKnbZUod1bo69+QSAkdAS2ejd
 Uz5QPAbj9hp3Lm+czpEocp0bsLIzmRaffl/H0/VG5ZdRF6pZocB9bGSNi
 Qw+J3Q2oKzYMDOFTn2C8aWnyrm7A+AcMihn4s5JppibQ51VPhPO1KTWRI
 tp5lcnSKSLpQ9GLon1crTvUz7O0rec89K+La21OwxR7x3vSoKyHH3xXd6 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="250220436"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; d="scan'208";a="250220436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 23:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; d="scan'208";a="533843795"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 25 Feb 2022 23:13:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nNrGw-0005Cm-29; Sat, 26 Feb 2022 07:13:42 +0000
Date: Sat, 26 Feb 2022 15:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 5182d772527f36098d1ff210ae9dda368bd58187
Message-ID: <6219d31f.m92+jd60Q9jUXFOi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_231346_575695_F0A1F164 
X-CRM114-Status: UNSURE (   7.78  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 5182d772527f36098d1ff210ae9dda368bd58187  nvme: check that EUI/GUID/UUID are globally unique

elapsed time: 731m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
mips                 randconfig-c004-20220225
i386                          randconfig-c001
powerpc              randconfig-c003-20220225
sh                          sdk7780_defconfig
powerpc                     asp8347_defconfig
arm                          exynos_defconfig
sh                   sh7724_generic_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
powerpc                     tqm8548_defconfig
i386                             alldefconfig
powerpc                         wii_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
sh                          lboxre2_defconfig
arm                           tegra_defconfig
arm                          simpad_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
mips                      bmips_stb_defconfig
powerpc                   microwatt_defconfig
mips                        omega2p_defconfig
powerpc                     ppa8548_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220226
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

