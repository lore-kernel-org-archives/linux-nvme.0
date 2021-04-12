Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE44C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 21:54:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5847461350
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5847461350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G5G9btOHZsu5KHlG74kO2lBvA+WkYvEcaGpnxOMoIDc=; b=e/YLRkrwTz8TLkCrfQADhH7XCB
	eQXl6D5rUXoV18IYXjDZQjwka487/9SltiiyNHGkft6SZTwzUB/p3aOD0azTqtY6rDhO8gYmPzMCF
	46HBxwB7QDzwlBuIxERCduJX/YSLEKedLmzF9qrqXQmK8Bna8Wzgk4cHIwWb5ZXUgy4/hRX7O3+yV
	a5b2fJNhNwb95Dd1dOnUMypiCnckYK9aqUIL08+f21mQCbRzNQuUCvo43wWjTe0u8HvzI7+ZU0NJ0
	xlsN0NOCj6cs8EpDNk/dzR/qVt/GqQ9Wk/enRqhPruGPIQqbAfIwh5j6xepJHNeYpcb4V8fJnEvUl
	Lc07EuSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lW4Vm-007jwp-RM; Mon, 12 Apr 2021 21:54:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW4VO-007jwA-H3
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 21:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=wLtG7z7Jw9k+nsPoZtCsstJMDEmK0xETzcBldifNCi4=; b=puRjH1zPG4jupqGdmyreXmlNaS
 sSbjwpi1m3VMu1eqeG85ztT+ttqGBKf6/5L7j1VcSQRtvnU+5WpnaMj0K74xvZKmQCL13F3GexCV7
 VeblSbPMOUyVxrkUYfrmaBUDkT4ZvNQBPp3ALUmCZ9aHJW3jE80k62BPUR4BgZhwoCJD3D9/jEc4A
 m/a5iPpRlqTPBil9cQlYeFuwdUsTEA19afC8rvZTtwh3G2S4vTkM0RN20dQvYqZqjrQVPKnFfLZxN
 hWG6vsXGqC6Hx0u/zqS6zFR0m2XVNygukSNaRv9Y0c5TlD2pMNC33dMNNgs4UGxkJAyXWs8iITYf/
 GIkScFQw==;
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW4VJ-006Zkd-E5
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 21:54:00 +0000
IronPort-SDR: nP2Q8kSC150pcxRh6rumLlf/KDE9+ToeLOLp6QD7aRb+LBgXtCEiqsh/geG5NiI1GYWRh/uEIO
 2jLL38cu8BuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="174384865"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; d="scan'208";a="174384865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2021 14:53:51 -0700
IronPort-SDR: Pl6BJvQEUMW684KWGut2FMhfmLmgu+ko0BtQs8CU2a6qXGCKv7BGv6Q6zGmxKZPXB+vSOg31sA
 4eL9bugmIhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; d="scan'208";a="381722132"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 12 Apr 2021 14:53:48 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lW4V9-0000f4-I2; Mon, 12 Apr 2021 21:53:47 +0000
Date: Tue, 13 Apr 2021 05:53:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 9bde49676f41f2303f317e87c3d483acc9257dde
Message-ID: <6074c164.kmHaotqXHMS/HPLK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_145357_522606_34D6A258 
X-CRM114-Status: UNSURE (   6.57  )
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
branch HEAD: 9bde49676f41f2303f317e87c3d483acc9257dde  nvme: let namespace probing continue for unsupported features

elapsed time: 722m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                           h3600_defconfig
x86_64                              defconfig
xtensa                              defconfig
um                            kunit_defconfig
arm                       aspeed_g4_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
sh                           se7751_defconfig
powerpc                      cm5200_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
alpha                               defconfig
powerpc                     kmeter1_defconfig
m68k                        m5307c3_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       cns3420vb_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
