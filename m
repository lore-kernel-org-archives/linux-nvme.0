Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D79FC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n/uqUO8T7p5gtY+Ig8FImn/Mp+G2wf7k9JvJXs8jN0c=; b=I3P8O/a/pwszmWKbGE4I7Tb4+M
	E9F1Zc5iVmechdEh+m0DKXnTMcqEP5Cn5JDoJ0VwR2yBkr0h+3XYIp/R1CmUEZK8men+F2H1HP0Uh
	7DPD6UmrQL/zT68MZR+QEgzqmjNwMvVUGS5g7jcKWf14F80bOpKDmhbWJqOZXdydgaXRvffZsXwA/
	rzWZKsfYaTv8gS6MzSCdHLqNfuLuPVeAwf2Pb6hNJOq9r0xv67jW/gc+LIZ4QN/+mfD37rRN0+z5r
	dRiSur0oW53e7wL6r8aiBVdVFsn6lhmQPTtATRJDqc8NNruCnnnw4DazrAzaPhr7D5+VOJexW7oVN
	0s0s9ZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opyVm-0075UM-Cr; Tue, 01 Nov 2022 21:09:30 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opyVj-0075Si-H7
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 21:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667336967; x=1698872967;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6ica9wOL6heA2ChtTtrL7bdrt7WhfXfLVHDDGclQtGg=;
  b=Q1xgoLqFl5N49pU/UeEkJYg4CDnNEQwe1hx1QLiz1u5Kov+YW4Xwq2SX
   yRog9DEFYjopb14VvlgmZi/Fo33JyWAjphWj56/r9ll8rv9g5FXYVIn8T
   Wb0ZG4Pyw+NXnc9811UGVd/6J0MHSBNsABmqUCy0oJEuU/rIgN/Xb7kj4
   7Pd7x+8PwKUSgWMvAcI7r/UoWpt7VQLLk6WjhW9M8PSb2+EKYypmHjR3V
   ogj/DckVd4o0TE+B/t1gY3+iuFeOhD7o7dim8Q248qPN7eM2n4M6RLSJR
   ZHQHnYxagqhcyrU90LizxtVd6C9DyiCWwCkYSZm1UoMO/Keh9xsv2juBa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395554182"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395554182"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 14:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723296076"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="723296076"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2022 14:09:24 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1opyVg-000E2V-0o;
	Tue, 01 Nov 2022 21:09:24 +0000
Date: Wed, 02 Nov 2022 05:09:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 48fe7dddb972e83e909f553e0ab7aa34c9598502
Message-ID: <63618afc.oJrdFiCk9QcACoKc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_140927_646794_479DF45A 
X-CRM114-Status: UNSURE (   7.87  )
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
branch HEAD: 48fe7dddb972e83e909f553e0ab7aa34c9598502  nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

elapsed time: 724m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                                 defconfig
ia64                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
i386                             allyesconfig
i386                                defconfig
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                       virt_defconfig
powerpc                 canyonlands_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64               randconfig-k001-20221031
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
i386                          randconfig-c001
x86_64               randconfig-a016-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a015-20221031
sh                          rsk7203_defconfig
m68k                       bvme6000_defconfig
arm                           viper_defconfig
arm                        mini2440_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       bmips_be_defconfig
mips                         db1xxx_defconfig
arm                          pxa910_defconfig
xtensa                generic_kc705_defconfig
m68k                            mac_defconfig
mips                            gpr_defconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
arm                            mps2_defconfig
i386                 randconfig-c001-20221031
mips                 randconfig-c004-20221031
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
um                                  defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                            qcom_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
s390                 randconfig-r044-20221031
riscv                randconfig-r042-20221031
arc                  randconfig-r043-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
openrisc                            defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                        bcm63xx_defconfig
powerpc                          allyesconfig
arm                    vt8500_v6_v7_defconfig
arm                     am200epdkit_defconfig
arm                       spear13xx_defconfig
x86_64               randconfig-a005-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a002-20221031
powerpc                   bluestone_defconfig
arm                        magician_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
mips                        qi_lb60_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

