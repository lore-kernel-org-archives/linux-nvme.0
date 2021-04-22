Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51006C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:25:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972F861425
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972F861425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lykz0RDcdPzLVr/p6lzH60exe3MAM9EPzkOPOhgJNx0=; b=TKajOjLIO2dae9ncVhpUPp3mA7
	/OukpZaNna68ouD0PWTV6znqZMrhyxlfhCRvsHkHwSwA96CwD7vUlvJFHT61SZ0LG3rk7iRKslY9W
	0ftiBZPyGB0I+66ncDA/XN5X7q1XuZTUOqBA026ZBClIJISvUg0sgDPJPGeKypzoyehItT+3wxvFR
	Gaa1k9UyaSs3ijD7jOyD/lCv0I7yBnJdQHWfN6PThSw6Ar+3NeakqAThjEH50bxtWRvNjZHHzRnRe
	ELNdUNGW085o0cFbsbzjHcWlaDJQeb9cHKZ5JPE6C3h8DuxRaK2KHoeN/KEyRmtFwVQcRygA+e67S
	WZxWIpew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZe0F-00HEiN-5j; Thu, 22 Apr 2021 18:24:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZe0B-00HEhd-L8
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 18:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Gw/UPdTDhQn/wg10qzLaHplYkdcJ+oZLBTP/VN1Lnoc=; b=T/fugsRfpVXafpxlWGf1n7vMa4
 KaGrV8P00SjUYvHkK0myzrfxKzUWnOFh2X1cNZd+uNMDED7IbRTeaXooA9pxdRpXphuh/vhgNVFxd
 1oB23DPWl0lJpOpO7QZCFploVp1bDaApZWKjc5/RCeIrHXtvp7KCplZBN2+cAQb11MCLD9Ee9vtsr
 +qePfwtI7eBEJnfjnSP6lF+LuKRvKZVuyqQ9DO13WPv9AfGodkG4cMJ7HevyDjOswZcTwh6/kwfV+
 K85rkNZdgUQaLxgcmMFM3yvt11RtNCZxhRZYzsp2o3j24A2bMkhIGRbKRqnXS4LemRNh25tbqVH1A
 yfF9PLZQ==;
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZe08-00Duuh-7r
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 18:24:33 +0000
IronPort-SDR: 77sziUzUOu1zSo8haixaRsrVKHoXBzGMe7PINw/H5tLp2oy2NFjz5clBUSPE+oNSNmiW4HV8k0
 tyPQHGV1biPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192758184"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; d="scan'208";a="192758184"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2021 11:24:16 -0700
IronPort-SDR: kJtgRhrJAZek8tlGwpRiAJvQYdAk+RA80pokErG5Xirf8H4QwEGu9QIOjYzBzbti0s0HvcTeN6
 Epp3/xNp3SkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; d="scan'208";a="453346021"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2021 11:24:15 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lZdzq-0004I9-HL; Thu, 22 Apr 2021 18:24:14 +0000
Date: Fri, 23 Apr 2021 02:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 2637baed78010eeaae274feb5b99ce90933fadfb
Message-ID: <6081bf1f.KbODeQcO/H0Sn6Pl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_112432_395536_787A324E 
X-CRM114-Status: UNSURE (   7.96  )
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
branch HEAD: 2637baed78010eeaae274feb5b99ce90933fadfb  nvme: introduce generic per-namespace chardev

elapsed time: 723m

configs tested: 163
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
i386                             allyesconfig
riscv                            allyesconfig
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
sh                             shx3_defconfig
um                                  defconfig
powerpc                      ppc44x_defconfig
mips                        workpad_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      footbridge_defconfig
alpha                               defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                      ep88xc_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                         s5pv210_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
m68k                         apollo_defconfig
sh                   sh7770_generic_defconfig
um                               allyesconfig
mips                            e55_defconfig
sh                        sh7757lcr_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
mips                           ci20_defconfig
sparc                               defconfig
powerpc                  mpc885_ads_defconfig
mips                          rm200_defconfig
arc                           tb10x_defconfig
arm                         lpc18xx_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v7_defconfig
powerpc                          allmodconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
sh                                  defconfig
powerpc                       eiger_defconfig
arm                           h5000_defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
arc                        vdk_hs38_defconfig
powerpc                     tqm5200_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     loongson1b_defconfig
mips                malta_kvm_guest_defconfig
arm                        magician_defconfig
powerpc                       maple_defconfig
sh                           se7751_defconfig
sh                        sh7763rdp_defconfig
m68k                             allmodconfig
m68k                            mac_defconfig
mips                   sb1250_swarm_defconfig
mips                             allyesconfig
powerpc                     skiroot_defconfig
mips                      maltaaprp_defconfig
arm                        vexpress_defconfig
arm                         s3c2410_defconfig
powerpc                         ps3_defconfig
mips                            ar7_defconfig
arm                           stm32_defconfig
s390                             alldefconfig
ia64                         bigsur_defconfig
i386                             alldefconfig
sh                           sh2007_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
m68k                        mvme16x_defconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
powerpc                      acadia_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
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
x86_64               randconfig-a002-20210422
x86_64               randconfig-a004-20210422
x86_64               randconfig-a001-20210422
x86_64               randconfig-a005-20210422
x86_64               randconfig-a006-20210422
x86_64               randconfig-a003-20210422

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
