Return-Path: <SRS0=Tdqk=DE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3DC4346E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 19:46:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000C921D95
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qV8PDaiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000C921D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SLOyuC4zgYJVfEMSNqET0DbHn27GA4jdHzK6cH3Jfzw=; b=qV8PDaiO0VQv9KH4z69N62bby8
	0f+m63eCatRVFu2a/Q59Y4UvrCLEwcF8tkaPohNl2F8rLeE9oKrmy/YD1c/2gbot43qjqnxErrrEm
	Sj8MMwyKqfjZBislPzoyEV/a9ow0zEs3EbGhTmJiZNnKZ3OWfbb6wOkAREG3ovOPtkh4io//Fr6lh
	hvEfGwYTZlXwD9dXYiLnR2GdpGI25XfvytCBw+tN1oeE1Mh+a37Zd1SgjBh/3jTTXZab7hHAQuF87
	cTrOc6dt+gC8FePGuaxBphoTvHh5Ihl+amJvnbSXlQyMHAf4FTILFkk/geP2I80+A3GmVFh54zCTX
	FH1OFfIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMcdI-0003KE-H9; Sun, 27 Sep 2020 19:46:52 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMcdE-0003JX-G9
 for linux-nvme@lists.infradead.org; Sun, 27 Sep 2020 19:46:49 +0000
IronPort-SDR: yv1x9vjyB4X9+4OOjTzuWkR8lb2U3dgfTcPvzJxl2l6q5diR7yPp/uBgfHegdckwD3wNgiCA8p
 IkQPpyMEaqWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161134310"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; d="scan'208";a="161134310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 12:46:45 -0700
IronPort-SDR: I9CAxYcxTDXmx3RcXCrtPHxjRfdnitnYJ7AghDM79+DWr0k4wbs6Tc9EpM3JueUCdCQrxdpcFq
 e/HTM9owMv0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; d="scan'208";a="311526434"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 12:46:43 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kMcd9-000048-6e; Sun, 27 Sep 2020 19:46:43 +0000
Date: Mon, 28 Sep 2020 03:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 21cc2f3f799fa228f812f7ab971fa8d43c893392
Message-ID: <5f70ec13.897z4GqVRd/U5S21%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200927_154648_675042_86CD76C5 
X-CRM114-Status: GOOD (  11.91  )
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
branch HEAD: 21cc2f3f799fa228f812f7ab971fa8d43c893392  nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue

elapsed time: 722m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                        fsp2_defconfig
powerpc                     sequoia_defconfig
arm                            hisi_defconfig
xtensa                       common_defconfig
arm                        trizeps4_defconfig
ia64                                defconfig
mips                           rs90_defconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
sh                        sh7757lcr_defconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
mips                malta_kvm_guest_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
powerpc                     redwood_defconfig
x86_64                           allyesconfig
arm                         s3c2410_defconfig
arm                          pxa3xx_defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
c6x                        evmc6678_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      chrp32_defconfig
mips                             allyesconfig
arm                         lubbock_defconfig
arm                            u300_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
arc                          axs101_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                         db1xxx_defconfig
powerpc                     ksi8560_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
sh                          urquell_defconfig
powerpc                      ppc6xx_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
