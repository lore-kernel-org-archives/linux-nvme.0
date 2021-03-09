Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6708DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 22:31:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF6650BE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 22:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF6650BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P/Ma09Upmf4Lz0XKoAs1mo0IE87+kiISzDWKT/WC1XA=; b=iGbyfPNMGonyfmSN4hG2hqxeRd
	iQd66Iqjt4OWB/+w23YK8bFV88d3Adis9F/IahvbI3mueQFYqeLFD6OT3jCE0YtG/8aLEOVyxkD8Q
	5Q9GyJUUrt9RhPS9S4YEOVrz+XGlCeqElW/uoZ6lfiHlYNs3CAtFUVGcbzHO2ARzGWoainud9xz9a
	fEF4WOqdgIgTslOms5RHXIv5/D8XbOnl+w3zg3tw1oWgqEN7jz6AzdunOKpL4vUFdEMzpFJ/Kw7oS
	pZRwvtGdTZNzBl91RXFK+kCZJjvGTCxsxT1goIq3PSIWlucWcpPXSzAO+19PEsjeBPe5MjeborNjx
	ShNwngUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJkse-005ZuG-S5; Tue, 09 Mar 2021 22:31:11 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJksP-005ZtL-5X
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 22:30:58 +0000
IronPort-SDR: 6R0geTiD8bAfdxu+iWht09YVvXn1JNKpriSLf6Isqd8d25aw+l+X+MeqzH8pUYhrObqoLMJj0q
 ZY2h5Xq8gsuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185952703"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; d="scan'208";a="185952703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2021 14:30:47 -0800
IronPort-SDR: fZ06VoB7H/qcS+gksDKbhVs7hMEMYmS35Z9a5UntWbJGgwztLMv8wEUhZoBapahj2/E/nOFP6V
 2UoYDItBb/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; d="scan'208";a="369938485"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 09 Mar 2021 14:30:45 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lJksH-0001rB-7U; Tue, 09 Mar 2021 22:30:45 +0000
Date: Wed, 10 Mar 2021 06:30:42 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 01b6702d0f03e59cad651fd45651ddc56c87d32f
Message-ID: <6047f712.6pkubbr5UJgsPSA4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_223053_809658_E062773D 
X-CRM114-Status: UNSURE (   7.46  )
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
branch HEAD: 01b6702d0f03e59cad651fd45651ddc56c87d32f  nvmet-fc: update function documentation

elapsed time: 724m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
nds32                               defconfig
sh                           se7724_defconfig
mips                         bigsur_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
arm                            lart_defconfig
sh                        edosk7705_defconfig
arm                          pxa3xx_defconfig
m68k                             alldefconfig
arm                          moxart_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
mips                       lemote2f_defconfig
powerpc                    amigaone_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
sh                              ul2_defconfig
arm                           spitz_defconfig
mips                      maltaaprp_defconfig
arm                            hisi_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
powerpc                     kmeter1_defconfig
sh                   rts7751r2dplus_defconfig
arm                             mxs_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                        sh7785lcr_defconfig
mips                     cu1830-neo_defconfig
sh                           se7722_defconfig
nios2                         3c120_defconfig
powerpc                 linkstation_defconfig
m68k                          amiga_defconfig
arc                           tb10x_defconfig
alpha                            allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
riscv                    nommu_k210_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
