Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C4C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 14:37:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0276601FE
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 14:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0276601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LyCR1crFt2R6/9RZVMSWXCPab6wZaS7NLyZbq8r2qCw=; b=XgOhgOl5i9YLyhHmx6cas3gqc1
	N4siSI2PSaSdmH+98xDvOBLuThyy3AMAwN/BknFcWCnJwBvCEZrL4vufgMVH6SJMaPeOJjMwCiRvH
	h6dAbvZdkX7QP8F9JkvTdE6II9AcjIdOCMkrkqmSl3bz/hK4rxKzGGk4QvHD8kdeeagW/Bb/l119a
	BrsWFpAcRFwO/ndNBvHX3JeBLgp6UP6ZNKDTpanb5TXkeh5w774lKXWlFSlEzrkcxQwoxQ71OmeNX
	6yWtc54uBh1aEDsSKw9mnTpg5vfzJS821auy298eqzey+uwneXfjnBrvuSovkElv2igMu0h8rJqg9
	+INbP+sA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIuWs-00ATFf-4u; Sun, 07 Mar 2021 14:37:10 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIuWk-00AT9l-Cp
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 14:37:07 +0000
IronPort-SDR: ciZYR+P/PW8Xv9fteC9VqxEyMQjQxWv/PyWtMJUQosdOGI3pOqvuxl9J7Epz6FOT6TY2Syd40k
 88j1kuEQAMKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="187263468"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; d="scan'208";a="187263468"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2021 06:36:54 -0800
IronPort-SDR: xX4MWG0J2Mm9+yQ5ZGOt9pFLZASXeyDZ6EB/Db9UH4IRELtwW6EPFRuUe6O4o1cDMQD6ifrCnO
 19ybup4JjEcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; d="scan'208";a="508651319"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2021 06:36:51 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lIuWY-0000Ri-Jd; Sun, 07 Mar 2021 14:36:50 +0000
Date: Sun, 07 Mar 2021 22:36:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 d9f273b7585c380d7a10d4b3187ddc2d37f2740b
Message-ID: <6044e4ed.dbxr97/Ep53Ie1XJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_143703_392861_B9818694 
X-CRM114-Status: UNSURE (   7.49  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.12
branch HEAD: d9f273b7585c380d7a10d4b3187ddc2d37f2740b  nvmet: model_number must be immutable once set

elapsed time: 729m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pasemi_defconfig
sh                        sh7763rdp_defconfig
xtensa                    smp_lx200_defconfig
arm                         orion5x_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
arc                              allyesconfig
powerpc                    klondike_defconfig
sh                            titan_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
arm                         lubbock_defconfig
mips                            e55_defconfig
powerpc                      ppc44x_defconfig
sh                          rsk7264_defconfig
arm                         bcm2835_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          pcm027_defconfig
arm                          lpd270_defconfig
riscv                    nommu_k210_defconfig
sparc                            allyesconfig
mips                        maltaup_defconfig
sh                        sh7785lcr_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     ep8248e_defconfig
powerpc                      arches_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8555_defconfig
parisc                generic-32bit_defconfig
sh                          r7780mp_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      bamboo_defconfig
parisc                generic-64bit_defconfig
arc                           tb10x_defconfig
ia64                                defconfig
sparc                       sparc64_defconfig
mips                           ci20_defconfig
s390                       zfcpdump_defconfig
mips                     cu1000-neo_defconfig
arm                        keystone_defconfig
sh                           se7705_defconfig
nios2                            alldefconfig
sh                   sh7724_generic_defconfig
xtensa                    xip_kc705_defconfig
m68k                            q40_defconfig
mips                           rs90_defconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
mips                       rbtx49xx_defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210307
i386                 randconfig-a002-20210307
i386                 randconfig-a004-20210307
i386                 randconfig-a006-20210307
i386                 randconfig-a005-20210307
i386                 randconfig-a001-20210307
x86_64               randconfig-a013-20210307
x86_64               randconfig-a016-20210307
x86_64               randconfig-a015-20210307
x86_64               randconfig-a014-20210307
x86_64               randconfig-a012-20210307
x86_64               randconfig-a011-20210307
i386                 randconfig-a016-20210307
i386                 randconfig-a012-20210307
i386                 randconfig-a013-20210307
i386                 randconfig-a011-20210307
i386                 randconfig-a015-20210307
i386                 randconfig-a014-20210307
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210307
x86_64               randconfig-a001-20210307
x86_64               randconfig-a004-20210307
x86_64               randconfig-a005-20210307
x86_64               randconfig-a002-20210307
x86_64               randconfig-a003-20210307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
