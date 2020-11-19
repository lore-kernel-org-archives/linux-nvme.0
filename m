Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF6C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 20:06:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E922261
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 20:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1uHgsrYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E922261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ax/jAk8KydBBxXAn79Wf4wh8IQzsxCFpDSjFMoym9Xs=; b=1uHgsrYU8f54ymKVPq2R6uDNv7
	b3ja1ajO7h9Tpts09/7XmAahI1UrODdvllS3wvJMTnX1p5SaAJq6im0DILaO8lgVMaIVdVU59Qd7r
	AgVmGAk27CJ8jkaZmc8/Ut+UrE/HmUI4/2bf8F3JGo2/rb83G+vUAk6Njkqxr6vEj5VAZRumLlWnt
	2eH0dguRUHqm2RIw2+DRGIBDGYB0vQc9RqHX96eIt9zB9N3DE2XwbzGVwZ5TmuoqwzxwfqBJ899aY
	I31WQflJlI3BVB4PYw3anNi78Xzvk4JLfEN7ofuwJ5d3z8c1Fl1a5igonOgnDxJJ24oRd785D+u+U
	+nVq+TUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfqBt-0001cY-4T; Thu, 19 Nov 2020 20:06:01 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfqBq-0001bw-1J
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 20:05:59 +0000
IronPort-SDR: 5ctqBlRnmQm1hWbshY5GxDVMXMu9bC+BRCNNgj6jb5nHAmjccnEhW06kfIcGHa5YEUPjDkFIna
 q2l1eX0EK9VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="159127071"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="159127071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2020 12:05:47 -0800
IronPort-SDR: 5i0AcO1EiWSzIrJ8pUbDM3BrJkr5WG9WcL/3D7A0NzWyI02hHRzktCmOhqdqoCKt13n1X0r40A
 sI5w1EMtKU/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; d="scan'208";a="476949508"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 19 Nov 2020 12:05:45 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kfqBd-0000BW-5N; Thu, 19 Nov 2020 20:05:45 +0000
Date: Fri, 20 Nov 2020 04:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 f9706b8c16a36e031551bc00a89d24bbd4fddd3e
Message-ID: <5fb6d008.JE43N/jaKn3c/isG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_150558_341093_F6A6AD87 
X-CRM114-Status: GOOD (  11.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.11
branch HEAD: f9706b8c16a36e031551bc00a89d24bbd4fddd3e  nvmet: remove unused ctrl->cqs

elapsed time: 724m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
powerpc                     powernv_defconfig
mips                        nlm_xlr_defconfig
parisc                           allyesconfig
microblaze                    nommu_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                       multi_v4t_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                            ar7_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
sh                     magicpanelr2_defconfig
mips                        omega2p_defconfig
mips                       bmips_be_defconfig
h8300                               defconfig
arm                          pxa910_defconfig
arm                          ep93xx_defconfig
riscv                             allnoconfig
arm                  colibri_pxa270_defconfig
mips                           ip22_defconfig
arm                         bcm2835_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
c6x                        evmc6678_defconfig
powerpc                    klondike_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  audio_kc705_defconfig
arm                      jornada720_defconfig
mips                           ip27_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
m68k                        m5407c3_defconfig
powerpc                       eiger_defconfig
um                            kunit_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                         virt_defconfig
arm                          prima2_defconfig
arm                         hackkit_defconfig
mips                          rm200_defconfig
sparc                            alldefconfig
m68k                       m5275evb_defconfig
arm                          badge4_defconfig
xtensa                    smp_lx200_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
sh                            shmin_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
