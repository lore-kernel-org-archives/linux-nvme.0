Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 07:23:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775DD64EAE
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 07:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DD64EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PWdYnABrmE81XepmWix+pbXKEMqoppy5qSbV/uR7CQc=; b=ak20ha6vFKaK/gscAE7yLKZ/ks
	eZ+/Zj+oGS0QYvja9wxubKaYxwBgLKRMu3A/3erKKfA1g/f/9sQQhJiD7z4r8W1Aid6wOTGbZFJFm
	deab2EzTJ4eBJtii7qyspb0YtMfmkRjp4NKs4wqaAoBmc6EyO2Q7TfkuVkigdOavXBdOLK53LxxSI
	bLbFjCHFJTmuqosTCDxW19ygV1DL1OsdyCWX1Ow4sSsMVwAr47l2OpDyxfcT/xyuwGFSGm5M4T6jI
	BzExlhr+xMgdMmVo0XgwSWchvchYNvl8y/rmckRsamrPGJUMupOMaq5M3nBuDV+P1tMjGXYITR4ix
	eG938QjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI4o0-00DgBn-RU; Fri, 05 Mar 2021 07:23:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI4nv-00DgB3-UZ
 for linux-nvme@desiato.infradead.org; Fri, 05 Mar 2021 07:23:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=8q0oS5aRHnBn8cceIOPNx8UItcon5iDz6zemUhKSuRw=; b=JQpV6XX2zKiDU7OReK2W5jH655
 TXTbTvuVhcdrtn3zRbg6VsAaSqwvIB3yE+4LHGkNedDwgais107KhjbIqEcA2V9k6LklH3/C0DFUz
 SCerrzhMk2+3pEz814G9dZ3HEFdU5XH+M23MUUgtJ+Natwe85S/8OC1lp4hR0WU0bLmVBdrV7uQ2/
 OLTi11BTiQ8wILE5tOrR2pfGrSvkPNFwOj60/N7Z7a38hH08C6rNEL3skIYycqOKumGh97W24DvrJ
 cRo3kqb5+2fZVVUTSeXLXv5klIlQs8/7733gXmUaVsM1kmj35iLr9bBEdZ2/E5si9VKmK2+gacXHm
 4omEbYqg==;
Received: from mga02.intel.com ([134.134.136.20])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI4nl-00AcNa-E1
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 07:23:16 +0000
IronPort-SDR: tyYcAU61YZxDX9eM5VrVIFTp/jw0KkagyOY0LgDM3nvXBAnZyKF7Q1Muy3B6rD7HX2Dj9vypoh
 Wg5bEYnblkXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="174709862"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="174709862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 23:22:03 -0800
IronPort-SDR: qk5Vx0qqv0EsdMZKVbfdv9lZKAF4apyFvxzBCqFlGg/lMXLlIh526jFYYX33jDxIZBA+SbOjwP
 mrWbKYo690kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="408186765"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 04 Mar 2021 23:22:02 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lI4mf-0002fq-Pv; Fri, 05 Mar 2021 07:22:01 +0000
Date: Fri, 05 Mar 2021 15:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 fc45c3b2b8e3cb11b2c89449760b8d82321df29e
Message-ID: <6041dbe5.yNtKl7MByb7Zc514%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_072312_962777_897FC281 
X-CRM114-Status: UNSURE (   8.30  )
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
branch HEAD: fc45c3b2b8e3cb11b2c89449760b8d82321df29e  nvmet: model_number must be immutable once set

elapsed time: 721m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                          pxa3xx_defconfig
arm                           u8500_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
m68k                        m5307c3_defconfig
sh                ecovec24-romimage_defconfig
sparc64                          alldefconfig
arm                            dove_defconfig
arm                       multi_v4t_defconfig
mips                  cavium_octeon_defconfig
mips                           ip27_defconfig
mips                        qi_lb60_defconfig
sh                           se7619_defconfig
powerpc                       maple_defconfig
mips                     cu1830-neo_defconfig
powerpc                 linkstation_defconfig
x86_64                              defconfig
arm                  colibri_pxa270_defconfig
xtensa                           alldefconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        m5407c3_defconfig
arc                         haps_hs_defconfig
arc                        nsim_700_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
mips                           jazz_defconfig
csky                                defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
arm                        cerfcube_defconfig
sh                            shmin_defconfig
ia64                        generic_defconfig
riscv             nommu_k210_sdcard_defconfig
h8300                               defconfig
mips                      maltasmvp_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
arm                            mps2_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
i386                 randconfig-a016-20210305
i386                 randconfig-a012-20210305
i386                 randconfig-a013-20210305
i386                 randconfig-a014-20210305
i386                 randconfig-a011-20210305
i386                 randconfig-a015-20210305
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
