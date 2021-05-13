Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEFC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 07:25:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D05C611CA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 07:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D05C611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eynZQillTgsw1/rKWqdwYxUJbD4EcuBmwUpyJRmhUF4=; b=VllBE5x5kCR02uDvUihPuGc2aJ
	CiDHMP7tlvuuJRZzrgiSqJK9w6dHoaUpe52TPGNmX4JGHMhIADqe0DImVXJyi/3GcQerHK7KkGCB+
	XbQTc/fP7GlIw46nqeBK7qBiDfoE+AqNHcU4IXOEF0rwcctd4uXk4mdfgNIzsBLYmfP3Rslk6efYC
	mB5TRB9/PMudN2KKmDPimNyys8GNP/LO7FqVVFSAk+ncgyf3B0bJDDSIyJEDqFya5vnEwzlV0B3NL
	IaLU1/NTY5+c+Eb5zPLmM+RXZkFRQZqM8CZZJYH6K1fP+FAqM4qGc7jkcVhnbNV0jmtwNAcWVRB1X
	/dzaxn0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lh5im-004zu1-GO; Thu, 13 May 2021 07:25:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh5ij-004ztd-Ve
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 07:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=XPPccxgo9D/WdpWcmNy9MSHaYhhaKVbTPtm178HOH7Y=; b=1QnVUup3nCw4w2WLQaE1uoNZ7e
 GpkumTNTRPaGsto9B9l/J0EGLtoaYz/wlJwJ97HIJO+Qa8qYPPqB+Gl0+ARCLoVudHQ9j1D7/ZmlR
 FnYM4Zlgu4yieK3pWUMTFzPpDXKqcH+5vxll4cgmLhkrt6+YX8BXf9FZ8HtYftmD5JX0UmT0EURnF
 e22Hs2z9SrSEtqD7TzZTrlMqsjBywGvRJnDoCPJNugDRqZNhyoLr7KK3o5eYd5mZGKiHFz8YLgxKv
 WFpd1g2Apxa1T1a2zCGwVortN2gHlbRVYjBCEUeLOIOjtn7uOtLOAP9CjF1yB+xkd7LlOSgLMnRLC
 uGnl2XIw==;
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh5ig-00B4p0-Vh
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 07:25:20 +0000
IronPort-SDR: gZ03AJsmw5KU7I/dd0ZIIDRk7eyBrVUHLSNP1yiIOv64kwiSZsshOMTUZVpD0wofMZsCZMd1ut
 QP8CJiwEKZDw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="220876446"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="220876446"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 00:25:11 -0700
IronPort-SDR: zSbwO1cGikRbdnmtlnSHRsspcZTFWQHYHMa1rx5AfzMJFGbNPr9tPYX+YMe8tYupaPOYav4ZHE
 XAvLSpVFAaEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="435624370"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 13 May 2021 00:25:10 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lh5iX-00008J-RO; Thu, 13 May 2021 07:25:09 +0000
Date: Thu, 13 May 2021 15:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 85428beac80dbcace5b146b218697c73e367dcf5
Message-ID: <609cd422.xvBkABGpXKWE8eD5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_002519_116924_B293F91F 
X-CRM114-Status: UNSURE (   7.04  )
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
branch HEAD: 85428beac80dbcace5b146b218697c73e367dcf5  nvmet: seset ns->file when open fails

elapsed time: 720m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
sparc64                          alldefconfig
arm                       imx_v6_v7_defconfig
mips                          rm200_defconfig
riscv                             allnoconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
mips                       rbtx49xx_defconfig
xtensa                generic_kc705_defconfig
arc                     haps_hs_smp_defconfig
arm                            lart_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
arm                          simpad_defconfig
nios2                         3c120_defconfig
arc                              allyesconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
mips                  decstation_64_defconfig
riscv                            alldefconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
sh                           sh2007_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
sh                        sh7785lcr_defconfig
mips                           ci20_defconfig
sh                           se7722_defconfig
sh                          polaris_defconfig
alpha                               defconfig
arm                         assabet_defconfig
mips                        bcm47xx_defconfig
arm                       mainstone_defconfig
arm                             mxs_defconfig
arc                         haps_hs_defconfig
sparc                       sparc32_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
sh                          sdk7780_defconfig
mips                           xway_defconfig
arm                         s5pv210_defconfig
powerpc                     mpc83xx_defconfig
ia64                          tiger_defconfig
powerpc                       holly_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
