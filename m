Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7304C636C8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 14:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74978611AB
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 14:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74978611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eK6BtRrihfEPxCWuDkg42Jey9PYlsEULTU4okGDtiCE=; b=NZOJMHCw3wwiFN
	7NvU79occ9xWwfZnzb7UTChdtHvB1WXNXuTlkhGxn+WxeOWntwFP8jlMBTI6X80wBE/Le2RRemzzH
	Esag8TtND2ZXQv+HK7YksYvY+3x9fg5rAy9igSlZppypZJqXFLrgyPafoX1oIctCL4UC5OY4wmeCE
	3iHa23hcMtodWEU6/o85DMKpuUJV3sV5znbob/ehRDRtQ/StAcwD+xpYSWdSSMYFTz5PbQsckg6QZ
	SEkkimzVtLUSbxHxuBNR2k41bpUJQr3Z0gdxFqnI9byPtgHDFeVFqQkihiw5w0fCkp7hfDtNQY+Yi
	rvAql/7hMvH7D8PonRgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m57kn-007nIe-Pk; Sun, 18 Jul 2021 14:26:49 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m57kk-007nHK-MV
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 14:26:48 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="296510778"
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; d="scan'208";a="296510778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2021 07:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; d="scan'208";a="467750388"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2021 07:26:45 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m57ki-0000LB-FB; Sun, 18 Jul 2021 14:26:44 +0000
Date: Sun, 18 Jul 2021 22:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 60f8313a9d9274b5f6429bd2a8b9641b1595fd03
Message-ID: <60f43a09.1qvo5ziFRqNaao0r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_072646_812602_7842FFC0 
X-CRM114-Status: UNSURE (   6.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.15
branch HEAD: 60f8313a9d9274b5f6429bd2a8b9641b1595fd03  nvme: fix refcounting imbalance when all paths are down

elapsed time: 737m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
sh                               allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                       ebony_defconfig
arm                         s3c6400_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                       versatile_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
h8300                     edosk2674_defconfig
mips                     cu1830-neo_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         at91_dt_defconfig
mips                           rs90_defconfig
powerpc                   bluestone_defconfig
powerpc                    amigaone_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
um                                  defconfig
sh                          urquell_defconfig
powerpc                 mpc8313_rdb_defconfig
xtensa                  audio_kc705_defconfig
m68k                        m5272c3_defconfig
arm                          collie_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                        dreamcast_defconfig
m68k                           sun3_defconfig
microblaze                          defconfig
powerpc                      chrp32_defconfig
sh                           se7206_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
sh                      rts7751r2d1_defconfig
arc                    vdk_hs38_smp_defconfig
mips                            gpr_defconfig
ia64                            zx1_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
arm                     davinci_all_defconfig
sh                           se7751_defconfig
arm                           h5000_defconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
mips                          rb532_defconfig
powerpc                     tqm8560_defconfig
x86_64                            allnoconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210718
x86_64               randconfig-a004-20210718
x86_64               randconfig-a002-20210718
x86_64               randconfig-a003-20210718
x86_64               randconfig-a006-20210718
x86_64               randconfig-a001-20210718
i386                 randconfig-a005-20210718
i386                 randconfig-a004-20210718
i386                 randconfig-a006-20210718
i386                 randconfig-a001-20210718
i386                 randconfig-a003-20210718
i386                 randconfig-a002-20210718
i386                 randconfig-a014-20210718
i386                 randconfig-a015-20210718
i386                 randconfig-a011-20210718
i386                 randconfig-a013-20210718
i386                 randconfig-a016-20210718
i386                 randconfig-a012-20210718
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210718
x86_64               randconfig-a013-20210718
x86_64               randconfig-a015-20210718
x86_64               randconfig-a012-20210718
x86_64               randconfig-a014-20210718
x86_64               randconfig-a011-20210718
x86_64               randconfig-a016-20210718

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
