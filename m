Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E57C00140
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Aug 2022 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C53wBFnGB9euk9kY7Z41EfDFvvc58UbNxnUoLAzq1r4=; b=GqghnKmf+Y6m6hZ6ksCAUWDM7b
	C/iUgASNmfpBGVqmWSitirTAg+3Dtn2AMctVv8jAToBoEXtIGbi0rW3l4gQtLtcIjIYHUkC16lVBP
	CVN6pmGH1NUHG+PEOCctZZSnASiH83av5H28zJcbbhf4qj3waM0OJfR0DbQn2qBTLhju/gJoiVSg9
	UxWeHdUxRHI+J1GZ6xGZGTCIQPHmf1+mAJoqsDzEb/owzcglP/xxavA3b1Veji5DqZzeYUsZU6FnT
	c6wLTQSBIHGG4JAgNlIfjSvch73mOFdnHIZupaFwy1rb+6D3OleEJzTpB8GoDvqFE4yAX56zdp/co
	ZOvEw1PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL8VW-00FgHU-1z; Mon, 08 Aug 2022 19:33:46 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL8VT-00FgGP-ME
	for linux-nvme@lists.infradead.org; Mon, 08 Aug 2022 19:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659987223; x=1691523223;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pRGRK6t6ek8ILfaf30aIB/jLuixmj8ro7OhVEmNubLs=;
  b=FdlX4mGiLAbm90cDZljXB2DW+5lU7vPncnJtGGpb7HTXK5c3sC7KRXUB
   6StkwQzla+AeXWN0Suyf0OYKYbztcPJzpcGT0tJMxLtV7hZaxZwKaohRi
   Uf5EFIeZ+ksYIW2akgTaivr4h7kjeMpRX/bfg0wJ1vXwxV3C62aE/qbof
   xF+qh8ODI7S0VXxat1nd5BqptcFjSMmUuFH3uDfaDNvi4+UWE3Wuni9G6
   ncF9M8fVL2TZnf6aprHotTQt10e15AIGqXha1LDd4xAIZwKAPZW2tJRNF
   kgUt3Q6c8llLK74NUyLVcJi0aIRpcyEvyaraFMNKGKmuY9yJjXGAY910K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270452627"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270452627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 12:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="580488781"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2022 12:33:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oL8VH-000MUP-2M;
	Mon, 08 Aug 2022 19:33:31 +0000
Date: Tue, 09 Aug 2022 03:32:54 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 ed169e9a1f2281da3a20ce221663665b71c84bbc
Message-ID: <62f164e6.3eEabJwegBDsI7TT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_123343_774805_8604208E 
X-CRM114-Status: UNSURE (   5.54  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.20
branch HEAD: ed169e9a1f2281da3a20ce221663665b71c84bbc  nvme-fabrics: parse nvme connect Linux error codes

elapsed time: 713m

configs tested: 69
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
i386                                defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
mips                             allyesconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20220808
sh                               allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a001-20220808
i386                             allyesconfig
arc                  randconfig-r043-20220807
arm                              allyesconfig
i386                          randconfig-a012
x86_64               randconfig-a002-20220808
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64               randconfig-a006-20220808
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a004-20220808
x86_64               randconfig-a005-20220808
arc                              allyesconfig
riscv                randconfig-r042-20220807
s390                 randconfig-r044-20220807
arc                  randconfig-r043-20220808
m68k                             allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                       m5208evb_defconfig
arm                          lpd270_defconfig
sh                           se7712_defconfig
ia64                             alldefconfig
sh                             espt_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
mips                  maltasmvp_eva_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20220808
i386                          randconfig-a006
i386                          randconfig-a011
x86_64               randconfig-a013-20220808
riscv                randconfig-r042-20220808
i386                          randconfig-a015
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
hexagon              randconfig-r041-20220807
hexagon              randconfig-r041-20220808
x86_64               randconfig-a014-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a016-20220808
s390                 randconfig-r044-20220808
hexagon              randconfig-r045-20220807

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

