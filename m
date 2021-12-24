Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7032C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Dec 2021 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HnRKAoM1mMgcjxuySvooQQscYWHIcMm6sNIntsaw/Qw=; b=1QJ1DSE4InL2mRrCCuGjvFIUUi
	Y9KMaxN3ME+zwc/PW1/UBhzPSfUA1ixp1ZsLcQMT5peRCxB449hDxqJ2BXnABhWQixYvvvTFcCB2e
	IEs8sg0TLJ8WUsvhORpIMpxpqQBNJXT3bZesBtkFuDI4A+EFwWoX6rZm4SBQnieHu0kBRG3oPuEzQ
	KU9Nx4hbdla+DXEX8lASavoNJwNz/NB1dUAR0FFwybooma3Yykin67pQ48wMeWSMPkY9ff02KuxSQ
	nqE/AzExnO1PQGhmh+3vK5AMDNuIBtK/7UKtaDxhzMx/CaDQFJ0ZdkLdspGJAOo0d0WcJ1BgiQMuW
	gpD4T8pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0ZOm-00DcDu-OH; Fri, 24 Dec 2021 01:29:32 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0ZOj-00DcDX-Jf
 for linux-nvme@lists.infradead.org; Fri, 24 Dec 2021 01:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640309369; x=1671845369;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=5NclMlhjVaXZ0fV85yY6A8qFWux01HqDHMB4mt/WvIg=;
 b=jJE5BNouBDG/QGFfuHsTf35UzgrsoCf752MhT6Kx8WKmpTsI5hLOCyV+
 mn+hWoDkc/bDYu2XqfPV1WzW5dG9wQGOJP5lVZA5sipt17uZDEKlAArob
 kY8Zx/YfE+IeOT4h4PKJpahPkAAUOSkrHj+fsevZljuGi3TDVwfJDV+O1
 827fln2Pt2N9a2bmhB4hWEFrY9kZureueol0e+rIDlTWsnP+FuxLpWOx6
 qkMcMFF65w1Txvu26igU7CpJn4MTjwUGiUpL9evJjO1exdGE1OsrDIi+U
 6oVryqzzhqY/t3TrJBUA9WaepIzBtx9nbfmJck3AKVPwz+4MMUlyWY+Bk w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240711061"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="240711061"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="571122197"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 23 Dec 2021 17:29:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n0ZOf-0002TV-5d; Fri, 24 Dec 2021 01:29:25 +0000
Date: Fri, 24 Dec 2021 09:28:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 e3d347943919f35ccdeed8d2cc62e8c6c12b36cd
Message-ID: <61c5223e.qoFfgVtiANaYm0Ih%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211223_172929_746906_633C31DA 
X-CRM114-Status: UNSURE (   6.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: e3d347943919f35ccdeed8d2cc62e8c6c12b36cd  nvme: add 'iopolicy' module parameter

elapsed time: 889m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
csky                             alldefconfig
m68k                        m5307c3_defconfig
sh                              ul2_defconfig
xtensa                         virt_defconfig
arm                         lpc18xx_defconfig
powerpc                    mvme5100_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        apsh4ad0a_defconfig
mips                           ci20_defconfig
arm                            qcom_defconfig
arm                          iop32x_defconfig
arc                          axs103_defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                       spear13xx_defconfig
arm                      integrator_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
arm                           sunxi_defconfig
m68k                          hp300_defconfig
openrisc                         alldefconfig
mips                      bmips_stb_defconfig
um                                  defconfig
arm                           corgi_defconfig
powerpc                     redwood_defconfig
arm                         lubbock_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
mips                     cu1000-neo_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
arm                     eseries_pxa_defconfig
powerpc64                           defconfig
arm                        neponset_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
arm                          exynos_defconfig
sh                          lboxre2_defconfig
arm                  randconfig-c002-20211223
arm                  randconfig-c002-20211224
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r041-20211223
hexagon              randconfig-r045-20211223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

