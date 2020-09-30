Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8371C4727C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:48:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6025820708
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFujQztT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=adm7XGGR30didIRtZVpX7ERx+McrlwzPx+A/Y0EdeoA=; b=RFujQztTr5jdv6jM4tQKDkSFKt
	l6v3hcoiEzTQmpUTXei0YA8ZfxgoZ7ytQ/U7ko9pYkWjCNcE30PzphccibPE0ZqUDMKhHm9c8NITe
	Q4nBrHDOIvBBpbCRa03X63kHKRKMuJh/gK4vTKqnFIE8HESQ/9lMPJSWBUlqqZTodx4OM0ga900xm
	lZq8ODjICz3UpTplYKl2C/4SC2+Z8/qUvQ/La49kLUodf35vHnPjES2TsU9jay5BG0Nym5rp3Cl5G
	IIo1QzSQGsw8jFsGOB+iN+Sq000bEMqMljvPccvHEJ148BKJ2ZwrJ7/65EVSAzYFn2Zp0OVXRNdYz
	M231u9mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNh9b-000667-Ph; Wed, 30 Sep 2020 18:48:39 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNh9Z-00065U-Lc
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 18:48:38 +0000
IronPort-SDR: 1ShTb9WbxiDPFlfVzicOptX+f8YhJ3kthNK/GmHSBzZ9y5L8QHkLuyVuT7oYAXcVxKXQIQAW7q
 331QqcmJJEkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159905613"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="159905613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 11:48:30 -0700
IronPort-SDR: pCuU3teDltcyfNY/jhMs/wahhC3o3Wl4Q9Ncd7j383I5DXx1n4XeBD/J4aktxDmLdQxPP3Cr38
 VZTfj4lCs7EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="325129822"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 30 Sep 2020 11:48:27 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kNh9P-0000L8-4F; Wed, 30 Sep 2020 18:48:27 +0000
Date: Thu, 01 Oct 2020 02:48:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 9e0a7d23d7565098941549509c4ae2fbd73764a1
Message-ID: <5f74d2e1.+lZYmJFjTKt2NBgU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_144837_875017_C14454B9 
X-CRM114-Status: GOOD (  12.72  )
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
branch HEAD: 9e0a7d23d7565098941549509c4ae2fbd73764a1  nvme: remove nvme_identify_ns_list

elapsed time: 722m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
sparc                            alldefconfig
powerpc                      pmac32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
nds32                            alldefconfig
mips                           rs90_defconfig
mips                      pistachio_defconfig
arm                          imote2_defconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         lpc32xx_defconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
sh                           se7712_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                  iss476-smp_defconfig
mips                           gcw0_defconfig
alpha                            alldefconfig
xtensa                    xip_kc705_defconfig
powerpc                     powernv_defconfig
arm                        keystone_defconfig
sh                            migor_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
powerpc                    gamecube_defconfig
arm                       versatile_defconfig
mips                       lemote2f_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
arm                         cm_x300_defconfig
powerpc                 mpc832x_mds_defconfig
arm                             rpc_defconfig
c6x                        evmc6472_defconfig
sh                            hp6xx_defconfig
arm                        mini2440_defconfig
arc                             nps_defconfig
sh                           se7343_defconfig
c6x                              alldefconfig
powerpc                        cell_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
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
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
