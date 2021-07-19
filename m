Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3CC636CA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 02:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA20610A5
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 02:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA20610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AEViducCYQoUBohe5mbEZMC+bU8BoAlqyXk6Si6P85E=; b=kg0fsBeaOV4Bun
	e9YOo5tf7mmVj6GYqgJg1qjGHd23sMupBBjXXl6H0xgLl1kWBwBpcIxU7QtsD99AQyGHOyRIQDy3K
	SVlUTtYcAofOQSWiONUVnrXcxplEjihE40AvCfkBaNKjkVD8SfpUmNlcxBvf99/53+czmxYgy7GjL
	lhWAEGYdel+k8yaG8dSskncGRjPa19v+HqTSHqmda2colr5fOwy6SoaoyhkpJTADG9p37d8Nq3Fsv
	GLJ5lxDiI4coX61jYiERNETYR7wgvVJO4bzMfnya1wcgycxHdgHD8hhFZnI0apQLp9obKfO1BF0Wq
	z5CcuENfK15kn1/W0sHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5JN2-008ITK-1Q; Mon, 19 Jul 2021 02:51:04 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5JMz-008IT2-3H
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 02:51:02 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="209081502"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; d="scan'208";a="209081502"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2021 19:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; d="scan'208";a="659616162"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2021 19:50:56 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m5JMt-0000XW-Kj; Mon, 19 Jul 2021 02:50:55 +0000
Date: Mon, 19 Jul 2021 10:50:43 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 838a0cf36e08ea3ff4064d7188d5bb8a4fe14de8
Message-ID: <60f4e883.3SGoWP2RGmgKU+u2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_195101_215990_73BE6A6E 
X-CRM114-Status: UNSURE (   7.12  )
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
branch HEAD: 838a0cf36e08ea3ff4064d7188d5bb8a4fe14de8  nvme: fix refcounting imbalance when all paths are down

elapsed time: 722m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlr_defconfig
h8300                            allyesconfig
powerpc                     tqm8541_defconfig
powerpc                      bamboo_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
ia64                                defconfig
powerpc                     rainier_defconfig
x86_64                              defconfig
mips                        bcm63xx_defconfig
arm                        shmobile_defconfig
sh                        dreamcast_defconfig
arm                        neponset_defconfig
sh                     sh7710voipgw_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
sh                ecovec24-romimage_defconfig
mips                        omega2p_defconfig
sparc64                             defconfig
arm                         lubbock_defconfig
parisc                generic-32bit_defconfig
nios2                         3c120_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
xtensa                  audio_kc705_defconfig
m68k                        m5272c3_defconfig
xtensa                         virt_defconfig
powerpc                    klondike_defconfig
arm                            mmp2_defconfig
arc                              alldefconfig
riscv                               defconfig
powerpc                      ppc44x_defconfig
riscv                    nommu_virt_defconfig
arm                   milbeaut_m10v_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                      chrp32_defconfig
sh                           se7206_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         at91_dt_defconfig
m68k                             allyesconfig
mips                         bigsur_defconfig
sh                          sdk7780_defconfig
arm                          pcm027_defconfig
sh                         ecovec24_defconfig
sh                     magicpanelr2_defconfig
arm                       mainstone_defconfig
sh                          r7780mp_defconfig
arm                           u8500_defconfig
mips                   sb1250_swarm_defconfig
arm                            pleb_defconfig
sh                           se7712_defconfig
arm                      integrator_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
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
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210718
x86_64               randconfig-b001-20210719
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
