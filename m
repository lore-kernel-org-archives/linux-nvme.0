Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A1C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 16:52:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F406760E96
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 16:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F406760E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LvLMDNDXYo7E/DyaCan6NVbWHwyYMrUgb3jCyQHbcaI=; b=ET3LS72OyylFJJZpOOlIO3rsLq
	HXttjyiQ+U6CuttGKhJmevoXqA3JDBQcu+syfEMAVS1KQ4HzxS5VrSdEIhE77H8dOKCMjdMpggqdI
	xb118REtSaWu0cGn2CqgWdsUlgvObZtCgo4BRQYJFSpr6lasAcaOSPCHimerixgz8GRyTROjV1VA4
	TUFcvAS2CXZt/IbSf/hiv0SEMFd9Sb8UdJXFZSAYg34051j0myM5y+C8EeMSwZUntf6J4BkebcMVA
	qQOEb0PHcOJatRcncxe74ArSG8PQg6o2Py5tZa5VwHgcEU9655y6BqBsebRqei1FfAuyFClPgSSle
	Rjuzt9Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbmuv-00AzPo-RZ; Sat, 16 Oct 2021 16:52:17 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbmuo-00AzPS-TI
 for linux-nvme@lists.infradead.org; Sat, 16 Oct 2021 16:52:12 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214995343"
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; d="scan'208";a="214995343"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2021 09:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; d="scan'208";a="593269306"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 16 Oct 2021 09:52:06 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mbmuj-0009UV-BK; Sat, 16 Oct 2021 16:52:05 +0000
Date: Sun, 17 Oct 2021 00:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.16] BUILD SUCCESS
 1e4d14b5752641d774124e239c1101ff7860a0a1
Message-ID: <616b030d.1kPafNXBILpRPXO7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211016_095211_048966_38F72318 
X-CRM114-Status: UNSURE (   7.59  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.16
branch HEAD: 1e4d14b5752641d774124e239c1101ff7860a0a1  nvme-multipath: add error handling support for add_disk()

elapsed time: 727m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211016
sh                           se7722_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            pleb_defconfig
powerpc                        fsp2_defconfig
arm                        realview_defconfig
powerpc                        warp_defconfig
powerpc                     mpc5200_defconfig
h8300                       h8s-sim_defconfig
powerpc                     powernv_defconfig
sh                             sh03_defconfig
arm                         s3c2410_defconfig
powerpc                      chrp32_defconfig
sparc                            allyesconfig
m68k                       m5249evb_defconfig
sparc64                             defconfig
arm                          iop32x_defconfig
sh                 kfr2r09-romimage_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
m68k                        stmark2_defconfig
ia64                             allyesconfig
ia64                        generic_defconfig
powerpc                      acadia_defconfig
powerpc                     ksi8560_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
sh                        edosk7705_defconfig
arc                     haps_hs_smp_defconfig
sh                          kfr2r09_defconfig
sh                         apsh4a3a_defconfig
arm                       versatile_defconfig
arm                         cm_x300_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc837x_mds_defconfig
mips                   sb1250_swarm_defconfig
arm                            xcep_defconfig
mips                       capcella_defconfig
arm                        vexpress_defconfig
arm                         mv78xx0_defconfig
powerpc                     skiroot_defconfig
mips                         cobalt_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
powerpc                      walnut_defconfig
arm                        keystone_defconfig
powerpc                   microwatt_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211016
x86_64               randconfig-c001-20211016
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
i386                 randconfig-a003-20211016
i386                 randconfig-a001-20211016
i386                 randconfig-a005-20211016
i386                 randconfig-a004-20211016
i386                 randconfig-a002-20211016
i386                 randconfig-a006-20211016
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211016
arm                  randconfig-c002-20211016
i386                 randconfig-c001-20211016
s390                 randconfig-c005-20211016
x86_64               randconfig-c007-20211016
powerpc              randconfig-c003-20211016
riscv                randconfig-c006-20211016
x86_64               randconfig-a012-20211016
x86_64               randconfig-a015-20211016
x86_64               randconfig-a016-20211016
x86_64               randconfig-a014-20211016
x86_64               randconfig-a011-20211016
x86_64               randconfig-a013-20211016
i386                 randconfig-a016-20211016
i386                 randconfig-a014-20211016
i386                 randconfig-a011-20211016
i386                 randconfig-a015-20211016
i386                 randconfig-a012-20211016
i386                 randconfig-a013-20211016
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

