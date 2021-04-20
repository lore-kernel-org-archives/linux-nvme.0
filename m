Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CDAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:42:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B16B613C0
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B16B613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ibIEuzuJQQ3re3ZZb/BPD6TikaJ1k2K3rKUUyS7G7BU=; b=fpXTitWCyUTnoRGv0KBFCXaTub
	Bk+CckhRAc0HBuhW1SalwF+v8eIjSkLqaVlaqnLPqLHfo4Ul2+xgGXb8bfzIE0gqt2KIBC/XxPPOV
	dDDnsobLziA+Nv40Zx+kEzpBtNt/rBaTK2Op7tXWKTZD8BcBwADv6Q4UVdD3M+lCAIT1KKxkKFrFG
	GQ2NgwuMAkyTYqsq56G7tCq0eLmZmVkV3M5wxoTwwbX6CTR47B3Ed2tW9UBOaNTnRqWXWT6XRcKlM
	ckwUWYSVlBjl8Zn2FX0tJGXKHevvL0YPKH+pmQwx8//neC3S5jStBSdRLFPDbTXX47FtTv2w7R2UH
	zwOYWmmw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYxCS-00D1mr-Vs; Tue, 20 Apr 2021 20:42:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYxCO-00D1ly-7Z
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 20:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=TuJ1X5WBCmcWMxON2EdBfwi1v8w/q69DPtWiuGBGIyk=; b=G0TeKVl2pByO5DXbz+OxrmW/Ca
 Dv+h/AoytX5FhkDyrulTWg/uyt9VZCOjnHYjMiJR1m6lMuPhJPeGhQ1FGeQuNb/n5SaWuUDsf6mK7
 qnbBzg/VqUCO2eAkcU8s1BgfsHS0wI902KpATHHFmi67GsiPPxd+gZ6EcPnCf8f3nhqblpX4lxSdI
 /wYRFttW2Mj7eSWPNju3So9YAv0NTTaIpaZaU/JkIL03YsN1zEBPK3fSbFGzPPMNDuaydjqD8a+4t
 XBHe1P89tnDR84OuaiVD/4jDz9EJfC+EqwRY5GkTcmLJu6zEDagaRTT6gklkRhRtNw6TWvNAyogCz
 wZKFzChg==;
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYxCJ-00CPfF-Cg
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 20:42:18 +0000
IronPort-SDR: PNAxZAtO2ab9UYl1UQXmiPwsHc+exbT/7SNyTtDoP2+aCLQcgOPkmXV9sfFNPfkTDNRlNEt2AW
 pNd41CI8QfpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="183079425"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; d="scan'208";a="183079425"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 13:42:09 -0700
IronPort-SDR: O+Hd6K7L0CamWPbSRHmtlxHjMBnjprYL+2MvZDdeLXgJcmRivxNzB0jpUKj7rM9Z2ETqvHY38U
 6l8mHP/yDaZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; d="scan'208";a="463306920"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 20 Apr 2021 13:42:08 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lYxCB-0002wN-Sx; Tue, 20 Apr 2021 20:42:07 +0000
Date: Wed, 21 Apr 2021 04:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 62d73c50ff8733e5ef98adae834b6f3e92ad6650
Message-ID: <607f3c8a.y70/hQWq9yHGgHXX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_134215_506668_DF48C37A 
X-CRM114-Status: UNSURE (   8.41  )
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
branch HEAD: 62d73c50ff8733e5ef98adae834b6f3e92ad6650  nvme: cleanup nvme_configure_apst

elapsed time: 728m

configs tested: 105
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
arc                      axs103_smp_defconfig
i386                                defconfig
sh                        sh7785lcr_defconfig
sh                           se7780_defconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm47xx_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
arm                            mps2_defconfig
nios2                            alldefconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
h8300                               defconfig
mips                malta_qemu_32r6_defconfig
openrisc                            defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig
h8300                    h8300h-sim_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
powerpc                         wii_defconfig
ia64                      gensparse_defconfig
powerpc                      makalu_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a013-20210420
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
