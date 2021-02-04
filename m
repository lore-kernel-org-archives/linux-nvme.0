Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4ADC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 06:38:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8C464DE9
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 06:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8C464DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=caIEGEDCF9Z+3u6xlN9ExIVkLM8lJahkaEToa7r+/0w=; b=yBCD/XF5AH/UTYoesQhlQeTuJx
	VDbaV73x+MOayWpEUwGIJ6ljROsYlk+wvmOemqKTL55k+KamxBwJZHBbL0eYyXV8NSYpYX/Wmq3u5
	DRuTKCcc4VIdhgdw+6C5zTsJxSiKFlB7FtAxMyJWhwhSltZ5BNJj/CRwRU+HBxQ72M8nc0O+ga9wA
	gVtDNusVgxj2n1+iix+R8WvouDxSBC860cT/+CgAWQiIrqw8uDg/PuGpAs7yb8Usyq0EFjDDSVc1T
	Yv3CclnxwR1y5P6aDF1zqr5Q7Gn1TTXiIMnbppsA1T1XLINjqobkhuzlrQIgrwu5/u6MkKZmdjHVH
	niA+jBkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7YHT-0001JC-Mr; Thu, 04 Feb 2021 06:38:19 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7YHQ-0001Ih-PR
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 06:38:18 +0000
IronPort-SDR: mjTwtuFuBmxlWIGsSAaEOX7O9QaPhPvESYB4WAXq5dmd6icOTzJd6l0rgje8XKGwj2Gwyrvofb
 2esWSOW/oqmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168291398"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="168291398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 22:38:12 -0800
IronPort-SDR: v3MbF9ZW5pIU+gvRkB+bN4H2LtjfrxCTW1GyU/zOcjlfQqVMI2SVONp3235zrAoh1fOfb3JbPT
 vzhCcLsN30qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; d="scan'208";a="393017756"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 03 Feb 2021 22:38:11 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l7YHK-0000ny-N5; Thu, 04 Feb 2021 06:38:10 +0000
Date: Thu, 04 Feb 2021 14:37:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 cb8563f5c735a042ea2dd7df1ad55ae06d63ffeb
Message-ID: <601b9628.0pSiZj4XZgWgYYVU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_013817_061347_C1CD10A5 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.11
branch HEAD: cb8563f5c735a042ea2dd7df1ad55ae06d63ffeb  nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs

elapsed time: 727m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
mips                           ip28_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
mips                           ip27_defconfig
powerpc                     powernv_defconfig
arm                        mvebu_v7_defconfig
ia64                         bigsur_defconfig
mips                            gpr_defconfig
alpha                               defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                        spear6xx_defconfig
sh                ecovec24-romimage_defconfig
c6x                        evmc6472_defconfig
powerpc                       ebony_defconfig
m68k                             allmodconfig
riscv                             allnoconfig
arm                       multi_v4t_defconfig
sh                              ul2_defconfig
powerpc                  mpc866_ads_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
sh                          landisk_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
mips                          ath79_defconfig
arm                           viper_defconfig
arc                      axs103_smp_defconfig
arc                            hsdk_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
h8300                     edosk2674_defconfig
sh                          rsk7201_defconfig
xtensa                  nommu_kc705_defconfig
arm                             pxa_defconfig
arm                          moxart_defconfig
powerpc                      katmai_defconfig
powerpc                         wii_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                          allyesconfig
powerpc                    socrates_defconfig
sh                          sdk7780_defconfig
sh                         microdev_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                         at91_dt_defconfig
powerpc                      pmac32_defconfig
s390                          debug_defconfig
nds32                             allnoconfig
mips                         bigsur_defconfig
c6x                              allyesconfig
arm                          lpd270_defconfig
powerpc                         ps3_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            xcep_defconfig
arm                        multi_v5_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
i386                 randconfig-a013-20210203
i386                 randconfig-a016-20210203
i386                 randconfig-a014-20210203
i386                 randconfig-a012-20210203
i386                 randconfig-a015-20210203
i386                 randconfig-a011-20210203
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210204
x86_64               randconfig-a001-20210204
x86_64               randconfig-a005-20210204
x86_64               randconfig-a002-20210204
x86_64               randconfig-a004-20210204
x86_64               randconfig-a003-20210204
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202
x86_64               randconfig-a013-20210203
x86_64               randconfig-a014-20210203
x86_64               randconfig-a015-20210203
x86_64               randconfig-a016-20210203
x86_64               randconfig-a011-20210203
x86_64               randconfig-a012-20210203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
