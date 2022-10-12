Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A28FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f6FyfIS9oLUH3TPPFFq4XgmugVaI7MI2OKryKxpU/eo=; b=sF9t6yoUOhSOl6/uAlA3sKaJ1D
	aDjwPRMxYsjauQpex+w/j2f0AoiW0GQQeAAjbcfG5IWvYdZJ103VKOvVwGHCWj/qJMEkr61L4Mg9V
	DFeOk48eUKc91BYdQAlgpQyH4f770Ek94WRUU4/t6tp1y7YGDF91GcqHB3Yi92v/aaIqFey7dQE72
	y2xwaq5ZogeqvunyCRtd8UtUGF3tOY9TPus1NBcWj1rGI7ltoMBFKcOIjYruos9IAbZRw3uL9QPjr
	LoUg5uAlSWQcCiH0bZbRfyZhh/EEnfzYC1VM/auL+PFjPhTQp5JzrdxrcoaVHu5Zr2ZK9k6BDvBvU
	uG3aJ+Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oijvV-009Vuj-KI; Wed, 12 Oct 2022 22:10:09 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oijvS-009Vsa-36
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 22:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665612606; x=1697148606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RR/Ot0LkExGNw0F2kgJPfR4ncyG2g97SMtB0uDT7AnI=;
  b=V8ao3OFaHrLDMOOS8thBw5awBcfr+kvcLFW8Gm0Bv4PJ+849CNTCKSF/
   8WRBOOybS0k1IlsRyH4XSvWda0wojTjU8oTkU5SGT9IZnYg1EV0Q2JBL5
   ix7q4rBvrUJIeG8FLG1CDa6zsSLYfbePUR5Ul5AbcBzOULyAgv+Ez3tEW
   eAuuxJnUkhwvSlf3IUXL9+YcBRSnCL5YnttiBCQyNSK4OorcqKNYXLuqp
   k3YTTJSGmqAHDgsrSvTVdrqDGjxdzVCUsfbO2Uv5wML8+y+95QZT+00pj
   RBeuC3DLHBDYrxxkYB6N66mF3XdAr7mXRm6WVOKlpB8EK/1GDrTpS7O82
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="303658540"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="303658540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 15:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="657934871"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="657934871"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2022 15:09:59 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oijvK-0004ER-17;
	Wed, 12 Oct 2022 22:09:58 +0000
Date: Thu, 13 Oct 2022 06:09:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 72e3b8883a36e80ebfa41015c7b6926ce31ace05
Message-ID: <63473b18.uJKwyFN/YP8U/2Wb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_151006_239139_1FD6B7DF 
X-CRM114-Status: UNSURE (   6.53  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: 72e3b8883a36e80ebfa41015c7b6926ce31ace05  nvme-multipath: fix possible hang in live ns resize with ANA access

elapsed time: 724m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20221012
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20221012
x86_64                              defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
s390                             allmodconfig
s390                 randconfig-r044-20221012
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                          randconfig-a001
x86_64                        randconfig-a015
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
xtensa                           allyesconfig
sh                           se7750_defconfig
powerpc                     rainier_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
sh                         ecovec24_defconfig
mips                         bigsur_defconfig
sh                           se7780_defconfig
arm                             ezx_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        mini2440_defconfig
powerpc                     stx_gp3_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                 linkstation_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_mds_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
sparc                               defconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig
powerpc                      ppc40x_defconfig
sh                            shmin_defconfig
sh                        apsh4ad0a_defconfig
powerpc                       maple_defconfig
ia64                             allmodconfig
sh                ecovec24-romimage_defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
arm                        multi_v7_defconfig
arc                     haps_hs_smp_defconfig
sh                          kfr2r09_defconfig
nios2                               defconfig
loongarch                 loongson3_defconfig

clang tested configs:
hexagon              randconfig-r045-20221012
hexagon              randconfig-r041-20221012
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
powerpc                 mpc8560_ads_defconfig
powerpc                      obs600_defconfig
i386                          randconfig-a015
mips                           mtx1_defconfig
powerpc                      katmai_defconfig
mips                     cu1830-neo_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
powerpc                        icon_defconfig
powerpc                   bluestone_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm5200_defconfig
arm                           omap1_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

