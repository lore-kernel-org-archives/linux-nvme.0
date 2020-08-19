Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ECC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C977120738
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y35GPgrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C977120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rw4Qqy+htQZiGCTjICN7Pp2Ml1afO7NpDohsz+To51A=; b=Y35GPgrrbXVwuNz8+FNhRIRkZb
	a/sVGnhbpllD8iYUG0H95r9nwetkIkuaf2cJoLlf7PRRvYEIgoN3KQYZqq6Fen1TnA3mbQdJh88+M
	T1ZaTI6y/Y26ZwEIJTiet1xR3fh0PtKnQ8DhWKBrkK96wlJ1io1Z07IZ34v1DN/Xi4idxOn/okJ/A
	5UuNYIz/5RM9eqLsyt6Lkxz4AEoyKb6uyf1dL7Jnd6oOMPfHGuqfq6AZe2fu8A2WG+buzSnzlxOFX
	T70BTBSW6os9n0SWsRfG32JaH50MTgunLTvH/XW7zYRZUaFELffkVyd13SMpcGsTtS8sYDTxeZhkj
	+f4svMxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8IiO-0003Kc-51; Wed, 19 Aug 2020 07:40:56 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8IiL-0003Jg-RH
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 07:40:55 +0000
IronPort-SDR: RGnSIjlBVmTIeVANX5uMvK8qr+pJBoStJz+aG3jw1KV158faJAZAuG9LephIgAeZj7wjtM8zIm
 7CPFPHsONUrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="134582803"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; d="scan'208";a="134582803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 00:40:51 -0700
IronPort-SDR: 6rMeJpUC27vA84mPpsVllzPX1O+DTXmS8xLjdfChKbSpqoCnotb8NFRqjMiuf2jTboWN4kTQBD
 ZgNtdpqedJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; d="scan'208";a="497149516"
Received: from lkp-server01.sh.intel.com (HELO 4cedd236b688) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2020 00:40:50 -0700
Received: from kbuild by 4cedd236b688 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k8IiI-0000Cn-37; Wed, 19 Aug 2020 07:40:50 +0000
Date: Wed, 19 Aug 2020 15:40:10 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.9-rc] BUILD SUCCESS
 d324c3a859f9f2a904623a51a3cc95116210bc92
Message-ID: <5f3cd75a.Kv6JxexCn3kIzmf6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_034054_061748_2BFCC285 
X-CRM114-Status: GOOD (  11.13  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9-rc
branch HEAD: d324c3a859f9f2a904623a51a3cc95116210bc92  nvme: redirect commands on dying queue

elapsed time: 723m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
