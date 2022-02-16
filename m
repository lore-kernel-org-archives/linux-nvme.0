Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C94C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eB91wGbhG7QIo+YlRGHoX6maBG7Z88yttqGDg7CifuI=; b=nw5+MYfsaY2FbGupDabRV42LB6
	2HP1lKkroxETq7beuCb5AsJtFwciNj30XkiiSnF8DWK0CViCh/VMLujzn22yHDy/Qxl5flHaEFVqX
	88Jo3TFQOWSBd/oTO6tTP6H9HhKtlONu6PzVPM5zdzSzVhGxvUn33Tymr49KW6YvQVNCzOrANcYxG
	PAzPZx9n886/7lkFIIKyDM3K0Fht8bZzSnOJ0LCY9XvCzRBKQd3chB0VrL9abiFNvvbgrSvrDecik
	DGtmYvWf/ZDkZA6tePmc5LsEhB/Bez5rtrv5QDKCl1KnNv7X5QIykRujbzR0xxQbALTq0NMC2pDYN
	bF0Np6lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKR7g-008LQJ-Fd; Wed, 16 Feb 2022 20:42:00 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKR7c-008LPs-AF
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 20:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645044116; x=1676580116;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=4gdr3KZVIF63APSAzbWJ/hZnWZ9DFXTVXp8Q6kWvb+c=;
 b=HI1akg7b0cmwrNt1iilDllS0BE6kG64W6WPvVBBLNbqH1WJiDpLidZ4U
 cY2Ox3/UCzLuM9TH1GVcvU6hBSIEKxwImpCY0o/ZIVBVu5kLMiEXjXhUP
 tjbZdEOoV7W/8lFBPE9lpj+a20u1cub8kaWWvodg+1wi0rj+ivd2IJ2CN
 Gh7Ljr11p1MiBcQilidsWOZQ5KdquEVNxyMwACcNezyOHok+q78LeZK95
 6KojQn8gmQeDWRCnVv/VIGqzhU/5uHEFUJEsxrcKW4HxDYZ1JuF3FCK1O
 VkdVc6dzp+ZcUgirzpv2Atbftc0bsk5UnUd5/K9aj/2IK4gtmPQE6nZiM A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249553250"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="249553250"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 12:41:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; d="scan'208";a="604545807"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 16 Feb 2022 12:41:49 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nKR7U-000B6o-Qj; Wed, 16 Feb 2022 20:41:48 +0000
Date: Thu, 17 Feb 2022 04:41:44 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 120221b54a2aefba5eac99a61136fa99d0d64c98
Message-ID: <620d6188.gYIIL7Az+LK/wZ4o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_124156_440796_21255CEF 
X-CRM114-Status: UNSURE (   8.14  )
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
branch HEAD: 120221b54a2aefba5eac99a61136fa99d0d64c98  nvme: remove nssa from struct nvme_ctrl

elapsed time: 730m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc32_defconfig
mips                            gpr_defconfig
powerpc                      chrp32_defconfig
arm                            qcom_defconfig
sh                         microdev_defconfig
sh                      rts7751r2d1_defconfig
sh                           sh2007_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
sh                          kfr2r09_defconfig
mips                           jazz_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
xtensa                  nommu_kc705_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
arm                  randconfig-c002-20220216
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220216
arc                  randconfig-r043-20220216
s390                 randconfig-r044-20220216
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
riscv                randconfig-c006-20220216
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220216
arm                  randconfig-c002-20220216
i386                          randconfig-c001
mips                 randconfig-c004-20220216
arm                           sama7_defconfig
powerpc                     tqm8560_defconfig
mips                         tb0287_defconfig
powerpc                      walnut_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220216
hexagon              randconfig-r045-20220216
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

