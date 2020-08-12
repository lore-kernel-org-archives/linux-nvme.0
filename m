Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23EAC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 09:10:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9523E20774
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WvSYjJ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9523E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/116xBiia1gFwTqHMRtp0qV/0R0OIfEo2CIwv7jDbz8=; b=WvSYjJ3NWxjSXZ4B/tU0Uz8QQE
	SXuTuErPg76XRECZZ+R5ArjvzYEypGoNJAYj7hCRUJAbqh4/a56rqBhqrt4dbCG2LCpfSYUNvNYf5
	F0tWPWaFWNIiFLS+p0BTzFmYaDSOXM0WiKPzdgz3GiIbzvLBOrvOgfbIz0hmDBOLsv4t2T364+pd/
	23ED5aASOu/93H3M+v5cUg52rSCqgVvsr6uI+Wleg6/3jfrS+upOLSNnwj2GdbuLaxqQu7REEKcXU
	EuCEPxbmwwsoekBwJyPvMuQ5JpT4uUrWevqNP2I0vwbzZsEYUUnzv4TFGjKpv050tQjz37i8KkUT2
	d+uijS9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5mmE-0001hF-So; Wed, 12 Aug 2020 09:10:30 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5mmC-0001gS-PG
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 09:10:29 +0000
IronPort-SDR: fJCP5XHJdH/S4yWMtUgJwq5bM/Ky46woL3gommHB7m10lizygs6hxrwxYUKxypVIgG9Ew2Q2Os
 n5Ri1tPwftwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="141533856"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; d="scan'208";a="141533856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 02:10:26 -0700
IronPort-SDR: 4psiCfaXQNaVRrCw8UBuVG4ujMOUZYu5m4Pf6cBJYuSM7mFkv3KxsELmjAtdjTaHnaBSEN6oef
 RaA8aVxcLxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; d="scan'208";a="327139179"
Received: from lkp-server01.sh.intel.com (HELO e03a785590b8) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2020 02:10:25 -0700
Received: from kbuild by e03a785590b8 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k5mm9-0000Do-57; Wed, 12 Aug 2020 09:10:25 +0000
Date: Wed, 12 Aug 2020 17:09:43 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.9-rc] BUILD SUCCESS
 4d3c0eaf0d44a4f8f7d53b7835e670eafc96c450
Message-ID: <5f33b1d7.XB23j5zZoeWTmle5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_051028_966973_9BEE3294 
X-CRM114-Status: GOOD (  12.58  )
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
branch HEAD: 4d3c0eaf0d44a4f8f7d53b7835e670eafc96c450  nvmet: call blk_mq_free_request() directly

elapsed time: 723m

configs tested: 76
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            xcep_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
i386                             alldefconfig
c6x                         dsk6455_defconfig
mips                          malta_defconfig
m68k                       bvme6000_defconfig
arm                          iop32x_defconfig
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
x86_64               randconfig-a006-20200811
x86_64               randconfig-a001-20200811
x86_64               randconfig-a003-20200811
x86_64               randconfig-a005-20200811
x86_64               randconfig-a004-20200811
x86_64               randconfig-a002-20200811
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200811
i386                 randconfig-a011-20200811
i386                 randconfig-a015-20200811
i386                 randconfig-a013-20200811
i386                 randconfig-a012-20200811
i386                 randconfig-a014-20200811
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
