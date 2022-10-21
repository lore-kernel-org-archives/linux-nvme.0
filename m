Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F5FC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lqmGy7h8ovUdNlANCK3jIPlABjxKWNBmqnw7z9+ahB8=; b=p6F1O1wxLV6pQcGhzvOs2ttyoQ
	lutWMszkKpWvVYqTBo5RFDMlLVllVebiQx4S+Ea2Yn+1ZI+7dCfnjjyErZStkvecsme8dqvd5ji0F
	tC95pclCB9GCwabAWFzpEsJdomfCVzfQxOXHq8NAUqUCAzboiGoVJNzBirnCp055xkzm8cCgOUSSA
	LXp0plTtvtA4q3jZFD0/dtpZYmCNt+Zml2MHZJ7pisEefhsgBhWXQXSSgP+X4ib9KbYAYuoZjC9G9
	giQrJXIgPVrt6kvM+W25eoqyTq+0StIU0/Oj0uWeDNXMAyvBRBLqX0B1ULXol3DKpnHatROErT7b4
	dZKway0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olkIj-005Jid-Sb; Fri, 21 Oct 2022 05:10:33 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olkIe-005JeV-RR
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 05:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329028; x=1697865028;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dDcvk5480PSwtMs9ZemNvDiPD7z/HThvr2ZXbGeZRDw=;
  b=Ohe4g8P7y747AzQXSu4UN6diOC4n+uVtgU0YqwOaSeTemBbeWNDyOvtL
   rAhK5/BZOcpvOTqPMVdFsevHvVH6KxLBB9OC80CRjpcxlWrJYWnSKgGyY
   W+d/n2gsDZ11fK8swpgo0bI1B/RB9pn3UA1UConcs34DwHvyhLXYlvdfV
   8W1A8H4IVK6pDcIrasTras9ZL86cBe3FpZez7hb3JI36GwGx6j5QmuVHg
   hgGnGkmP08c8e7CKcB1MOFM0+Ud2e1HokSMUO68QCy8uHP2jFHQ2yJVi6
   V4rVNjiaeDrREwxZc/kMcMx9tEVik1hF1iv6q1raMeruhfQVvNdFWUmMh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290221210"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="290221210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772822238"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="772822238"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2022 22:10:25 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1olkIa-0002BJ-1N;
	Fri, 21 Oct 2022 05:10:24 +0000
Date: Fri, 21 Oct 2022 13:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 94f5a06884074dcd99606d7b329e133ee65ea6ad
Message-ID: <63522992.ou2SoSvCABhceJQQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_221028_970886_32ADC84B 
X-CRM114-Status: UNSURE (   8.79  )
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
branch HEAD: 94f5a06884074dcd99606d7b329e133ee65ea6ad  nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

elapsed time: 2387m

configs tested: 228
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                      integrator_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
sh                               j2_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
xtensa                  audio_kc705_defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
powerpc                 mpc834x_itx_defconfig
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
openrisc                            defconfig
nios2                            alldefconfig
arm                          pxa3xx_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
loongarch                         allnoconfig
sh                          urquell_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
sh                        sh7763rdp_defconfig
mips                           gcw0_defconfig
arm                        keystone_defconfig
ia64                                defconfig
arm                        clps711x_defconfig
xtensa                           alldefconfig
csky                              allnoconfig
arm                          exynos_defconfig
nios2                               defconfig
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
powerpc                     mpc83xx_defconfig
riscv                    nommu_k210_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
m68k                           virt_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
csky                                defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
xtensa                         virt_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
xtensa                          iss_defconfig
sh                        dreamcast_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
arm                           stm32_defconfig
openrisc                  or1klitex_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221020
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
arc                  randconfig-r043-20221019
mips                 randconfig-c004-20221020
ia64                         bigsur_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
arm                        oxnas_v6_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
powerpc                      chrp32_defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                       bmips_be_defconfig

clang tested configs:
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
powerpc                     tqm8540_defconfig
x86_64                        randconfig-k001
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc               mpc834x_itxgp_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                        magician_defconfig
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

