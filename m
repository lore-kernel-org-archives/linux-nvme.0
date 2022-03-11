Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB12C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DXltL7m3CzUXbNkp4ozS1ToTqgFaW//Xl0aGwQ8uDMc=; b=Fas5PVgJFtK8xjIxAsAnGFQgGG
	svrVRJ8V9ZD0ZLkUXFqcNv8THTEF8+9QsEQC5qecxpQuwRJ+M2/4vKHlfDSH9t8r/FnrIqd8+fCll
	t4PMNCieXiEZ3Q2AsynT0FFpKcwuLw6pyhcsCbidHsDFEq7TsL8AtV239pDBwOfetLLZrZjrksRxy
	9TerSnC8boptC77odljP85ca8Ywl3ZFKGw7lTpZm0qKFohdqpKgnE1Opz8JHlHO5XcioOX97q8Aww
	yEci8TYyrsxkWaW6t5d/9R26OZ6W+QVlhd4BYzzdmd3+SMEyLFGnp/q1ejb5G9lQakcRK5tjEE77T
	P3a8LUKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSThn-00ESxe-7z; Fri, 11 Mar 2022 01:04:31 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSThk-00ESwf-63
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 01:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646960668; x=1678496668;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=sWzsD6j5xGbMtnk+hpGhoVVQJzOaYa6yFSSNk3EGspI=;
 b=A9Q0d61ilps8G9mkSZHV5q/G54gpxXGG8EDYFN1GOpZP6sta1WXi+mG2
 e1Zjhyh7F5327LqhqQ6iWKlGtCZc0LXWQUdYWXI7kCQkx0+rki7nS9KzK
 jFvWDfVhIO88PJ7J2ZCQbeC9QTvVdPLUUyKTDQ2QWzfNkC0fuXheBGfQi
 Opl8nnUtTp2wegE6MNcOoZYBVOC4mCTW8B5TaITM8xeLpIl8nf/K0NZsr
 be2PUBIrxvc329Qd0l5aNBvmlsPIFTLhxDkAewqON66VVxT0LiVh1V7kq
 S8cXjKMXjLvwck1FPBIscJs4/3GdkHXjKSEbIHQtd7Z4q9T3AVlrCIVJH A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235411135"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; d="scan'208";a="235411135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 17:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; d="scan'208";a="688908539"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2022 17:02:10 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nSTfV-0005as-VG; Fri, 11 Mar 2022 01:02:09 +0000
Date: Fri, 11 Mar 2022 09:01:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 4669f60512aea5b91d412586db03564359d4757a
Message-ID: <622a9f79.74eAP2EBP/G55Q7n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_170428_286941_D11E8FFB 
X-CRM114-Status: UNSURE (   7.37  )
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
branch HEAD: 4669f60512aea5b91d412586db03564359d4757a  nvmet-rdma: fix kernel-doc warning for nvmet_rdma_device_removal

elapsed time: 720m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                           se7343_defconfig
h8300                       h8s-sim_defconfig
mips                            gpr_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                       common_defconfig
arm                        realview_defconfig
nios2                            alldefconfig
parisc                generic-64bit_defconfig
powerpc                       eiger_defconfig
mips                         db1xxx_defconfig
sh                               allmodconfig
arm                         s3c6400_defconfig
ia64                                defconfig
arm                        keystone_defconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                    vt8500_v6_v7_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
arm                       mainstone_defconfig
arm                      pxa255-idp_defconfig
mips                           rs90_defconfig
x86_64                           allyesconfig
hexagon                          alldefconfig
riscv                    nommu_virt_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

