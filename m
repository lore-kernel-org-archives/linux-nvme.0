Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFCDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cymHoXotUgDEhiYryXr5KPFsdz4cJqT/FPWPOLRnhnQ=; b=yDjVI8+FErU3WY7oIo66yXjeWD
	PC/gpuCbzYR7cdWNqj7NNlybT3sGkHq74MJnzs0Tj1By7lRX9RuQXSLMH3ifdCUd1zpFZbWfImaWY
	fxubSilkWwjhGhHNzMvB3/l5Jc9lSiRy9pwGb/4JzF1L2cZmWCmQ9sgZhPZ+JB6Mr0MMZQhUPMnex
	kWEpQeMysr60sM1VmzxbrJYE3oqf54k+46dbXOZVEjkzM98qhptLubpKMlbJsGq40SiYLSmjZo0z4
	057sr2bwEHhdshl5h8m6hydhZmQnxVGz6DvhFtuIzWOdPpik8l7MKP+ShbHoSRh1oHs0IOEjDKKA4
	rUzfNt1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrGu3-001Mu2-VF; Wed, 18 May 2022 10:27:39 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrGu0-001MtY-E5
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 10:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652869656; x=1684405656;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=IJoYm/f4GeM7jlS2p+KjVctJ8wPN2OIuOJ/57YzFrOk=;
 b=m/8oYVgIKhkTw0qtBhQRL6mT0Ee+LIXjF9fQ0P4WUGecE+TExcA6EPaB
 0pOAymjcF7R8u+irD7ckPsyYMJEBd7MXMzD1eoVAe9HpKoOAirQB/gvN9
 uncG0zNJidLsEJjprOZKS3s612QiVFOPcHKPoN9cPMVUUKFDH57LGCkhl
 sx9x8EbBYKPZPWB6ftiCt9TvLTNanf9m1WcN6rCH2fPbX9ycc1N7ik8Fx
 x17T3efqNQAvgeIa/UlJeWmwdG6qZ6VEThGY/MW0spAB/ZwKzQyL1qPYu
 YM0/mHSLNO1shv4R2lAaHAkzYgtSQ8w2IJrrd9M0dDtuO+6LFKWAC4dB7 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271548613"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="271548613"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 03:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="545384902"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 18 May 2022 03:27:29 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nrGtt-00023Z-7L;
 Wed, 18 May 2022 10:27:29 +0000
Date: Wed, 18 May 2022 18:26:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 e626f37e657adbab2a7abe51480925891662a5f3
Message-ID: <6284c9f1.ADjyO+cm8C/Pjvr4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_032736_601525_DA9E5A0D 
X-CRM114-Status: UNSURE (   6.85  )
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
branch HEAD: e626f37e657adbab2a7abe51480925891662a5f3  nvme: split the enum used for various register constants

elapsed time: 1664m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220516
arm                         lpc18xx_defconfig
arc                     nsimosci_hs_defconfig
arm                       imx_v6_v7_defconfig
sh                     magicpanelr2_defconfig
arc                          axs103_defconfig
um                               alldefconfig
mips                       capcella_defconfig
mips                           gcw0_defconfig
openrisc                 simple_smp_defconfig
m68k                           sun3_defconfig
sh                        dreamcast_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a016-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
s390                 randconfig-r044-20220516
riscv                randconfig-r042-20220516
arc                  randconfig-r043-20220516
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc                    mvme5100_defconfig
mips                        qi_lb60_defconfig
arm                         s3c2410_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64               randconfig-a001-20220516
x86_64               randconfig-a006-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a005-20220516
x86_64               randconfig-a002-20220516
x86_64               randconfig-a004-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a005-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a002-20220516
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

