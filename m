Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385FC43463
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 20:47:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EC20838
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1KdhEZXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x8XtIpAPOJRY6n3deNezp0gu+4uLSLTOs+ZLBXQo69Y=; b=1KdhEZXIb4PTDTjGeGn7HM99uD
	Ryx+yfPUXZVS+BQNNGDnVowd16TbR5ZnIqNZilejDXkwezLhuFep6JKCG4/vvNL0UGbt7U5Q38Byp
	hGtcoHZ5jmTJOrACVgd3zG9MqGpPJH5h5qdPVT5T8Hhk+B6hnjV03pZXh0X/SregItAK/1m9MLdQL
	ep9u1PpQVJLIVjJ5AvdRG9WBvNM4uYAQFglCWouX94YhLTjlrgPYwPHLTssNU9EOklPZ7WdOzTYk7
	gqADHed09wYASHJmziLHKKBPuQhLVgSc6fjzzNTdVWvRYHsTL13VUhN90aMd53vRnUpgQuGmgJ8zj
	BIRLzU2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ0o1-0005dD-0v; Thu, 17 Sep 2020 20:47:01 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ0nw-0005bq-PD
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 20:46:58 +0000
IronPort-SDR: Pr+Rk8tYiMDj3R31GbmK5PIvkiZGEaMKVuzKOLzF9UpjD/fkU1+JF4cUVVKZbj+ABb0DtFwYAP
 zh00s7JM2SIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="177886026"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="177886026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 13:46:53 -0700
IronPort-SDR: TbkF5HovwD0ykLAJhQmbHLKTk3m1WSCtkSlByWSbEcIBBjTrWYEvJODmpLgRrQ29lFTNv9E+5R
 95uNkpJdrb1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="332300397"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2020 13:46:51 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kJ0nr-00008d-B1; Thu, 17 Sep 2020 20:46:51 +0000
Date: Fri, 18 Sep 2020 04:46:17 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 3a6b076168e20a50289d71f601f1dd02be0f8e88
Message-ID: <5f63cb19.9APszDzXAfweEiZN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_164657_009147_F2D7745D 
X-CRM114-Status: GOOD (  13.75  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: 3a6b076168e20a50289d71f601f1dd02be0f8e88  nvmet: get transport reference for passthru ctrl

elapsed time: 721m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
parisc                           allyesconfig
m68k                          hp300_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            u300_defconfig
m68k                             allyesconfig
powerpc                     akebono_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
powerpc                     kilauea_defconfig
arm                        mvebu_v7_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
powerpc                       maple_defconfig
m68k                          amiga_defconfig
riscv                            alldefconfig
mips                     loongson1c_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
xtensa                           allyesconfig
powerpc                  mpc866_ads_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        cell_defconfig
mips                        nlm_xlp_defconfig
arm                       imx_v4_v5_defconfig
m68k                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
mips                          malta_defconfig
m68k                          sun3x_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
mips                      loongson3_defconfig
mips                         cobalt_defconfig
powerpc                      ep88xc_defconfig
sparc                            alldefconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
arc                            hsdk_defconfig
arm                       omap2plus_defconfig
sh                           se7712_defconfig
powerpc                      katmai_defconfig
arm                         lpc18xx_defconfig
mips                           rs90_defconfig
arm                        vexpress_defconfig
sh                          rsk7269_defconfig
sh                          sdk7780_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         rt305x_defconfig
mips                           ip28_defconfig
sh                          urquell_defconfig
arm                         s3c6400_defconfig
mips                      maltasmvp_defconfig
parisc                generic-32bit_defconfig
riscv                             allnoconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
um                           x86_64_defconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
arm                       imx_v6_v7_defconfig
arm                             ezx_defconfig
arm                        multi_v5_defconfig
arm                       spear13xx_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
m68k                        m5272c3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
