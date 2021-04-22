Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BBEC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 06:10:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BDE61452
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 06:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BDE61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=abQrgHMpCyJoJAhFn3wby1WGpo0A5LXm0P1Uo1u0eos=; b=XBi0Z2Gxm4AeQD3jmFghB4wfYB
	qbJadPF+GQmTjiUlrjWzb45605jVMyOEp/7X0st+KIuajoSkKztKch2y/W7fzYPrqHU2ycRT4hx/H
	3bdXYIqVtlO4vLM1DO4jlGZ6PdmEMhPCmzqem3uy4KVH6V4gRvArMe8/cClEVrkF1rzoy562jnLp0
	WTI5OSiAsyenRJLTfTmJXb5+OW1TdZLXIse1FvXfsG+6MObD6T5D/8Z9C8pPxVu64rEy3KtLzjW8V
	1nbxFkpIA/U7kEXpEvK++ktFyS8qMxQ9WmOofUSChiku3Owg9/2k/RYre80BbDkdNGr3YWVybXTLp
	1pWHsQ+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZSXp-00Fxgm-3d; Thu, 22 Apr 2021 06:10:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZSXm-00Fxgh-GF
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 06:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ArCGp1IpIMNqgCWl5BlVcfopVrJobRpNXn9+f/zNk1Y=; b=lxHBwbmJoq94iXGKsovEmxwAEG
 B/kdSqxG+Nq4OM4lptqtHcNf7URyms4p9g9hcW7y4HDtJQpXOo9chfT9dv1Zq+rIYba1VYAI5Kqhe
 CQnFy4xkm3AyPY/Hb2q6j2oZ1o3Kf/thzYKxh6PqEcNmIYOQyMObDCo6sOIDn4awqyKhHCDg5wBdH
 aW+z7pGKzy25aCqweOYsK6IMTWnqKEbndoCpg6YEhbnbzmEbl6uRd0SsUT86ylCujRO5OYuK/VQNU
 JC/ZjfRVwougp8qtlepF93a20Gyf4sUzyudaF8FyMoScCSE39gFKKiXbVF8IPL/foU85TnQLA3M7w
 O6f2+j1g==;
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZSXi-00DOs3-1p
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 06:10:27 +0000
IronPort-SDR: WcnBY5V3/LuLypEuO5tce7/Wu9ugKjIcRJgkTCdka+h21UUIjv/5RhmA8iOwAVeaEWJVCZ21Xi
 lxW4fj2yho7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="281162633"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; d="scan'208";a="281162633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2021 23:10:23 -0700
IronPort-SDR: f68fS5Yf8ZYR5DSOg26ajiKK2g/2GqpuUwIAQRt8Zs1iLXzuNxPl+GgKlF4gBX00ZxAw4btT3P
 hWQe3ZXMfmIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; d="scan'208";a="455650876"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2021 23:10:22 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lZSXd-00040l-9K; Thu, 22 Apr 2021 06:10:21 +0000
Date: Thu, 22 Apr 2021 14:10:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 93ca38f7e9be2a47fdb530aa6a8d091977942a7e
Message-ID: <60811338.Kwbcy+gmtmkgBOV3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_231026_151841_C9F3D425 
X-CRM114-Status: UNSURE (   7.19  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.13
branch HEAD: 93ca38f7e9be2a47fdb530aa6a8d091977942a7e  nvme: introduce generic per-namespace chardev

elapsed time: 725m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
sh                             shx3_defconfig
arm                       netwinder_defconfig
mips                        bcm63xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
mips                           rs90_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      mgcoge_defconfig
ia64                                defconfig
powerpc                         wii_defconfig
arm                  colibri_pxa270_defconfig
openrisc                    or1ksim_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
m68k                          hp300_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
mips                           ci20_defconfig
sparc                               defconfig
arc                                 defconfig
arm                         lpc32xx_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
powerpc                 canyonlands_defconfig
sh                     magicpanelr2_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
sparc                            allyesconfig
s390                          debug_defconfig
x86_64                           alldefconfig
m68k                         amcore_defconfig
mips                       capcella_defconfig
um                            kunit_defconfig
arm                        oxnas_v6_defconfig
arc                        vdk_hs38_defconfig
arc                        nsim_700_defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                     tqm5200_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     loongson1b_defconfig
mips                           jazz_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                       maple_defconfig
sh                           se7206_defconfig
sh                          sdk7786_defconfig
powerpc                     ksi8560_defconfig
arc                          axs103_defconfig
i386                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
m68k                         apollo_defconfig
sh                           sh2007_defconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
powerpc                      acadia_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
