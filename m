Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0AC4708D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 03:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28iad446yldbVh9+0VN44G8yNrH6zFkr6IYnTQxt4yc=; b=pmQss7+wXOIMqkydH4eXpflsW7
	cLMrEdul6I79NgAqhVvXjITb7TPDjg49gMrAzA8+iFFE3pDZ44zFf2hGXAwaeh1aMUgzrsMzxEmcP
	u3eb87b3Ub0evZiXPieKVfqxd0OXgR09I2NlGucIsB5V/l1WiQ85ahY7MjfKUQiXk2miM7EANV0Qm
	uFQZLQ7Oz3+r5xe6h8ybRyG5A9x9EqJB6u9S+nwbTpQgvrn2oKmJ9g4qBE0cfGKgs431pH4Vl41xc
	MXf30BI/dMyBRlqZn6E96NZ8V+rBxwpYpgGNAcroBa1Sg1qTWmJFDQ9ijv4NgY9hTvo1I+irFbPyI
	MQL+Fwcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p37Qg-000nX6-Ld; Thu, 08 Dec 2022 03:18:34 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p37Qd-000nUW-G7
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 03:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670469511; x=1702005511;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5yf9vUlILHHeyarOblV5SO5xnKGCRuzVcgyClSvvw4U=;
  b=esp453+hczYbBQD5roDswyN7Zo2ZnHx7v5zWnuhY5DILy8Aq04T5iU3c
   wGNTv3xq7u5ZlB4A3KgsP7ka70IPre2GJgFzPOCa4LoQ96k4L3U970b+t
   jpC9RwyH4BoiHEsIQtd0CYqETuBLOB3ztyp6hbrEZBdrjvAKNr1bEliuU
   9LziuAJNpzcOWFels4XQ+WBiIV/7Iz/LP3GGTRFT/n0T4ZoNyPw+zFnDZ
   9W7T9VCbDt1yMiAd98VJ+qqYrggzm/iX9iieSBVHJ9Z2fgOwTlLc16f12
   Er1xY3lLbgN6vTswMQUunEwco3VBNsxD/4IdVI76T+WsEaso0Ez7yJVuW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="304691923"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="304691923"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 19:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="771328554"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="771328554"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2022 19:18:28 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p37QZ-0000ma-1M;
	Thu, 08 Dec 2022 03:18:27 +0000
Date: Thu, 08 Dec 2022 11:18:21 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 19b00e0069a3819eac0e0ea685899aba29e545d6
Message-ID: <6391577d.yS/VHO6TcCjSaPgW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_191831_657806_56E41F31 
X-CRM114-Status: UNSURE (   7.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-6.2
branch HEAD: 19b00e0069a3819eac0e0ea685899aba29e545d6  nvmet: don't open-code NVME_NS_ATTR_RO enumeration

elapsed time: 724m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20221207
alpha                               defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221207
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                        randconfig-a013
s390                 randconfig-r044-20221207
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                        randconfig-a006
s390                                defconfig
x86_64                        randconfig-a015
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
arm                                 defconfig
s390                             allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
m68k                             allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
arm                              allyesconfig
arc                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

