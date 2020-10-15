Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB9C43467
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 20:38:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9950A206C1
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPLyMX7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9950A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bxch/0tNCxr5+Psh73AoPONj2XddRi33YRjt+LORsbs=; b=fPLyMX7uTPnLB9zjfRmOza6HK3
	eC5emOlzrhiXW1hvjTbzx7FwhTLhj6iFFVLrdqOrE1GHoGRqiGa2PisDmTYtSAV8Wr6swVI48026a
	qrYuoI4FuMT4B8IwxfDPEruspR6eh89WQ9pehDgbEnySjRIDJWfrHqKwAxS9hZyBF6t2ieRBsCBKl
	DWU8pqXwH+3COzUDUZHEj2SlBBjKE0Wp/wS46mmtt07ok1o8RhPW0eOtnpp+mCRRo9Xu3ELSZKEs6
	y0eW7foYQpEpaB2WCUxF8KkrhrKFz0pBOpEsH7bX3t9ToVMiy7WOicIUQVPGLHZjvlrwKCsoxP8pB
	2ckVIybg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTA10-0000St-7f; Thu, 15 Oct 2020 20:38:22 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTA0w-0000RJ-Ey
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 20:38:20 +0000
IronPort-SDR: vhr9nc37RZ+OiPoExOutJ1cLTnnhTQ9bPuE2nLovcynrnCQpgV0dBx42OIjDxTWQmcrjyft5M/
 Q+xeGYQcx90Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="251139265"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; d="scan'208";a="251139265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 13:38:14 -0700
IronPort-SDR: em+abWsNZW6y4DFVXu0BBsXE2lvgH9Z4A5s1kSD2KcTutP+3tI5q8NJJ1DVkrHFSVSuCusKNky
 ZhGY92y0Fv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; d="scan'208";a="314648341"
Received: from lkp-server01.sh.intel.com (HELO 5003fa193bf3) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 15 Oct 2020 13:38:12 -0700
Received: from kbuild by 5003fa193bf3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kTA0p-00006A-Io; Thu, 15 Oct 2020 20:38:11 +0000
Date: Fri, 16 Oct 2020 04:37:50 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 f2ac6321ceaa4d8ea39aa4d5279e7f52c9f8a53b
Message-ID: <5f88b31e.USOIUpyFF/NQMOrJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_163818_786948_E285769B 
X-CRM114-Status: GOOD (  11.45  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: f2ac6321ceaa4d8ea39aa4d5279e7f52c9f8a53b  nvme-rdma: fix crash due to incorrect cqe

elapsed time: 721m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
arm                              zx_defconfig
sh                           se7343_defconfig
arm                           viper_defconfig
arm                          pxa168_defconfig
nios2                            alldefconfig
powerpc                      bamboo_defconfig
powerpc                   currituck_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
arm                           sama5_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      pcm030_defconfig
m68k                         apollo_defconfig
ia64                             alldefconfig
mips                        bcm63xx_defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
arm                       netwinder_defconfig
xtensa                              defconfig
mips                            e55_defconfig
arm                         cm_x300_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8555_defconfig
arm                              alldefconfig
mips                        jmr3927_defconfig
arm                  colibri_pxa300_defconfig
arm                            xcep_defconfig
alpha                               defconfig
powerpc                       eiger_defconfig
mips                           ip32_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
riscv                    nommu_k210_defconfig
mips                           ip28_defconfig
i386                             alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      pmac32_defconfig
powerpc                     sbc8548_defconfig
sh                              ul2_defconfig
mips                   sb1250_swarm_defconfig
arc                                 defconfig
powerpc                 linkstation_defconfig
ia64                          tiger_defconfig
mips                    maltaup_xpa_defconfig
arm                        multi_v7_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
arm                        mini2440_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      mgcoge_defconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8540_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
arm                         bcm2835_defconfig
m68k                         amcore_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
nios2                            allyesconfig
ia64                         bigsur_defconfig
powerpc                      ppc44x_defconfig
sparc                            allyesconfig
sparc                       sparc64_defconfig
arm                      pxa255-idp_defconfig
s390                       zfcpdump_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
arm                        spear3xx_defconfig
powerpc                     mpc5200_defconfig
arm                       imx_v4_v5_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
arm                       omap2plus_defconfig
m68k                            q40_defconfig
powerpc                      cm5200_defconfig
arm                             rpc_defconfig
arm                           tegra_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201015
x86_64               randconfig-a002-20201015
x86_64               randconfig-a006-20201015
x86_64               randconfig-a001-20201015
x86_64               randconfig-a005-20201015
x86_64               randconfig-a003-20201015
i386                 randconfig-a005-20201015
i386                 randconfig-a006-20201015
i386                 randconfig-a001-20201015
i386                 randconfig-a003-20201015
i386                 randconfig-a004-20201015
i386                 randconfig-a002-20201015
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201015
i386                 randconfig-a013-20201015
i386                 randconfig-a015-20201015
i386                 randconfig-a011-20201015
i386                 randconfig-a012-20201015
i386                 randconfig-a014-20201015
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
