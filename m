Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7296C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=opdfz7OgtfYdqgV95ApVG9YP/a1F3FKE/aQteziQEYI=; b=ggCRqW1uBLxS7R4BrZz00SM813
	XFWuksSDknnEkmAH8wK3OQtQG5C2YKTclT5yZxPqjQUUv07x9P5oFLab+k4QKRKfTenStbiHlXoZa
	NqpRK1sJ1+Xt46kIqTE5NnTepSXPUMzKd0quE1NnsfN2ERkt1wMw3/NbJyLZ4Wqvd0GWpXmKZeKZm
	4Ug4bTSAs2UYqW3vzvupSNTs3gnCxvPhQZHk45/Vn5rH6REVECAgCamRcrNdMCSuZQgjbnotDAt9a
	R8HDETj2BSujsjosBAYKnrR6/MDSDUg02hBqynvZoOzBMjm6mbpnG1QxHwfS5XExvSbZaXX6ESgvR
	a2NtVWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDUIT-00H3VG-Ap; Mon, 18 Jul 2022 17:12:41 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDUIN-00H3SK-8z
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 17:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658164355; x=1689700355;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0iJpF+/ymwjQd5nqM1kJexk1fxi0PsEm2EvvU3Vvgow=;
  b=cHdL8/NMqGbNUJUdSayJCAhwBv5FaRqBrlUUg5O3PRg8GgtD1mRBbUJY
   TD66BApZfnjbdYaInl7dQfEmwgLxKoO4DEUU0yvA36KKIn6lLfUp9W51j
   aGwOrDGerBffP1t6XTu0UX9lkiaegJCTNmehTKek4uYQhDI1ZiRRQydUq
   kYHzpdkWcsXdF1c+YNUKnV4hI83kHxOi7w2KEXn+VY21xSiVMpgttVUAu
   uUFEFoopiw61IWQGnThTt0E0d0EsS0YstzBIR0XNxalnk0OXNxFYOcuMs
   fWCYHbAU8TCUm57a3LOGSDhNgnRgjQqcKChizmjfPn8VAMeX9Bupmae/P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350234038"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="350234038"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 10:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="924423496"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2022 10:12:32 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1oDUIJ-0004bG-LE;
	Mon, 18 Jul 2022 17:12:31 +0000
Date: Tue, 19 Jul 2022 01:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 0f45a464e976086235981d8752b59385deab2e45
Message-ID: <62d59453.QrVPp/mF17DbGTGX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_101235_401787_FAAFDC97 
X-CRM114-Status: UNSURE (   6.61  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.20
branch HEAD: 0f45a464e976086235981d8752b59385deab2e45  nvmet-auth: fix a couple of spelling mistakes

elapsed time: 724m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
arm                           h5000_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5307c3_defconfig
arc                                 defconfig
arm                        spear6xx_defconfig
parisc                generic-32bit_defconfig
sh                   sh7770_generic_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
arm                         lubbock_defconfig
sh                           sh2007_defconfig
m68k                            mac_defconfig
arc                        nsimosci_defconfig
arm                            xcep_defconfig
arc                         haps_hs_defconfig
arm                             pxa_defconfig
sh                   secureedge5410_defconfig
xtensa                  audio_kc705_defconfig
arm                       omap2plus_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc834x_itx_defconfig
um                             i386_defconfig
arc                     nsimosci_hs_defconfig
arm                          simpad_defconfig
sparc                       sparc32_defconfig
riscv                               defconfig
mips                           ci20_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      bamboo_defconfig
arm                         cm_x300_defconfig
arm                           tegra_defconfig
nios2                               defconfig
sh                           se7619_defconfig
loongarch                           defconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-k001-20220718
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
arc                  randconfig-r043-20220717
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                     tqm5200_defconfig
powerpc                     kilauea_defconfig
mips                        qi_lb60_defconfig
arm                         bcm2835_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       aspeed_g4_defconfig
mips                     loongson1c_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
riscv                randconfig-r042-20220717
hexagon              randconfig-r041-20220717
hexagon              randconfig-r045-20220717
s390                 randconfig-r044-20220717

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

