Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBF2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 20:19:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B0264F3F
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 20:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0264F3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XWESDk8WZ8pa6/9Kwr231JZLlAjzwzMjJq8qkXfSpfo=; b=J6qs1K+aEw8omATcSJ8yevakNf
	mbWyFfr1r+V6VGKqrfBZo6dv7y1rQghhVqR/Hpb9Ym8je3PkNxzZa/QFF+huqjk/z2e5GbFYQFnsx
	HdkN048vnMulF41+oQ2sonx2QAetW7+Z7t0iZODkvqXTH0PFrB/2CQj7USCKWhgxf5xvljJUvgegX
	HXLrBonVWRWAguIa4mJCfi22yk510j95rS3ruSJPcJ4FlcWFLUD5xF4LPa1ZX+F43hD/JQunslgFg
	dv5SJYmJZYCCrbNhDBQ7UiYMNaE0KeRpeGE+ZxZ6QlCgl0r3lZUprKFPq4QXmtg6vy3D/ol+0oHyQ
	gxTkn4Vg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7l5h-00060l-N3; Thu, 04 Feb 2021 20:19:01 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7l5d-0005zQ-Sk
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 20:18:59 +0000
IronPort-SDR: +NZGCu0yNqU4AdQnvyjOOflyfs4JZdSkI7lgypGRl8OZgpiubN0iitjhtH0zfswth2682XEl6k
 JZVquXz+8yUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="160482687"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="160482687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:18:48 -0800
IronPort-SDR: 9gVJnJ+iLgW49G57HwllM/03N5m2uKEUBwIyRy1ztApYJom8ihBwyriYIYrE2AC4gkpTjMbqBr
 s3tTs7TNxI1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="373012008"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2021 12:18:47 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l7l5T-00019d-87; Thu, 04 Feb 2021 20:18:47 +0000
Date: Fri, 05 Feb 2021 04:18:34 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 aced5580e793b6d0287587bbb36f11510775b627
Message-ID: <601c569a.lIUZfAYZ2EGdyXCI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_151858_113347_25306BA9 
X-CRM114-Status: UNSURE (   7.96  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.12
branch HEAD: aced5580e793b6d0287587bbb36f11510775b627  nvme-rdma: handle nvme_rdma_post_send failures better

elapsed time: 723m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             alldefconfig
sh                          rsk7264_defconfig
arm                           u8500_defconfig
m68k                           sun3_defconfig
mips                        vocore2_defconfig
sh                           se7206_defconfig
arm                        clps711x_defconfig
arm                            hisi_defconfig
sh                           se7343_defconfig
arm                       multi_v4t_defconfig
powerpc                 linkstation_defconfig
powerpc                      cm5200_defconfig
arm                      pxa255-idp_defconfig
openrisc                 simple_smp_defconfig
powerpc                     mpc5200_defconfig
xtensa                         virt_defconfig
powerpc                    gamecube_defconfig
c6x                              alldefconfig
sh                            hp6xx_defconfig
c6x                        evmc6474_defconfig
sh                           se7750_defconfig
arm                        spear6xx_defconfig
arm                            pleb_defconfig
ia64                            zx1_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     redwood_defconfig
s390                             alldefconfig
powerpc                      ppc40x_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
powerpc                         ps3_defconfig
arm                       omap2plus_defconfig
mips                     cu1830-neo_defconfig
arc                        vdk_hs38_defconfig
mips                           ip27_defconfig
powerpc                     rainier_defconfig
parisc                           alldefconfig
x86_64                              defconfig
arm                         cm_x300_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                          rsk7269_defconfig
sh                ecovec24-romimage_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
h8300                    h8300h-sim_defconfig
sh                     sh7710voipgw_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210204
i386                 randconfig-a005-20210204
i386                 randconfig-a003-20210204
i386                 randconfig-a006-20210204
i386                 randconfig-a002-20210204
i386                 randconfig-a004-20210204
x86_64               randconfig-a013-20210204
x86_64               randconfig-a014-20210204
x86_64               randconfig-a015-20210204
x86_64               randconfig-a011-20210204
x86_64               randconfig-a016-20210204
x86_64               randconfig-a012-20210204
i386                 randconfig-a013-20210204
i386                 randconfig-a016-20210204
i386                 randconfig-a014-20210204
i386                 randconfig-a012-20210204
i386                 randconfig-a015-20210204
i386                 randconfig-a011-20210204
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
