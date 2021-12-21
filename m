Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CBFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 21:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7Shb1DmwqrpTxlarcmMqqNKO7hPwoxqHheslilcwvUg=; b=iXq24MFOi2kLUAx+m16+pwgaHH
	pbDmw+NIJtCgE4FFYhWyWgwVdfRzxYc9MtQRKY3S0OIpoSk5WXe7Xdxlkt1jGBE/9hnZLCdFNkuI7
	B7o1wdqY6IZlKfU/8UNekuhkRzY8Lli9hoPm7H9McOtxmyHdl3agqFnxJIuGylyLFfjri1Fs21FM1
	1grKPp1upYovtyq0Nh8H+XdiYGCI5N/QtuWDFMfR3rbRxfugV4D9FrmznB39purZQY5+3l/lidmQK
	tk08UYvQQlFwgywb1O32USnaM/bMZASVrCcjfW01424zBxSTPsSk/Vb/9KxWFwV+DpN7OH1C8zfxL
	8YdZCUiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzmjF-008Y6G-2Q; Tue, 21 Dec 2021 21:31:25 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmjA-008Y4p-V3
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 21:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640122280; x=1671658280;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=q9kcT+Fdv3wGKm2t48SE8p3269+EC5zNFm89CiJ46Cc=;
 b=MLhnlt/TuNkRLJR/HSV9x3GjDLRk9i+slw0h4iAYN+Hh/3PEEsbt8blF
 OrVRW5wzO8L9FecJEWh3OM8syp40RI5MhXJX+YtmvqtSXlZxBUAnbV8JX
 7PS3DcyltqUibE2vlcUpNg+TNx51nzNm+r3ZW0Npw+LtXZ8UD/M4TLC0C
 HHku5pyQCJoSYW0HIKaGdsOqN/J/LnizCDhSqxPqZWIC16X8P9Jny7oU9
 93wfkbgmLCNlIh03Vv8YtNp/YNpujXbeiko7ztFp8DEfnpuGHLIS2NRYL
 GFr5OcViecuM+vx5ZY/sWPMeYI8Vg9EbuTAD+sgQ5k/aenPjiT7lSodai A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="301262833"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; d="scan'208";a="301262833"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2021 13:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; d="scan'208";a="484549835"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 21 Dec 2021 13:31:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mzmj7-0009ZP-RN; Tue, 21 Dec 2021 21:31:17 +0000
Date: Wed, 22 Dec 2021 05:30:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.16] BUILD SUCCESS
 70e932fb05cae15f7ba68c6e1bb1c8d005b6616e
Message-ID: <61c24774.sC0Ir7MnHVr4hdkC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_133121_097475_D961BE14 
X-CRM114-Status: UNSURE (   7.88  )
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
branch HEAD: 70e932fb05cae15f7ba68c6e1bb1c8d005b6616e  nvme-tcp: memset scatterlist before sg_init_marker it

elapsed time: 728m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
mips                        maltaup_defconfig
mips                           ip32_defconfig
um                                  defconfig
mips                       lemote2f_defconfig
arm                        spear3xx_defconfig
sh                      rts7751r2d1_defconfig
arc                     haps_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
powerpc                    amigaone_defconfig
arm                           sama5_defconfig
openrisc                            defconfig
arm                          imote2_defconfig
arm                          moxart_defconfig
mips                        qi_lb60_defconfig
arm                        magician_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
sh                          urquell_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                      bmips_stb_defconfig
um                               alldefconfig
arm                          ixp4xx_defconfig
nds32                             allnoconfig
sh                            shmin_defconfig
arm                     eseries_pxa_defconfig
riscv                    nommu_virt_defconfig
xtensa                          iss_defconfig
arm                         at91_dt_defconfig
mips                            ar7_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
sh                           se7206_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
powerpc                 canyonlands_defconfig
sh                        dreamcast_defconfig
mips                           ci20_defconfig
sh                           se7722_defconfig
arm64                            alldefconfig
arm                            pleb_defconfig
arm                            xcep_defconfig
m68k                            q40_defconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
m68k                          amiga_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
powerpc                    sam440ep_defconfig
m68k                        m5407c3_defconfig
sh                           se7780_defconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      pmac32_defconfig
xtensa                         virt_defconfig
arm                         bcm2835_defconfig
mips                      pic32mzda_defconfig
arm                             ezx_defconfig
xtensa                              defconfig
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
x86_64               randconfig-a013-20211221
x86_64               randconfig-a015-20211221
x86_64               randconfig-a014-20211221
x86_64               randconfig-a011-20211221
x86_64               randconfig-a012-20211221
x86_64               randconfig-a016-20211221
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211220
arc                  randconfig-r043-20211221
riscv                randconfig-r042-20211221
s390                 randconfig-r044-20211221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

