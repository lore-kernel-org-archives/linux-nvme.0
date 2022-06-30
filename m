Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB75AC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 05:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ogpch49VVyi+0ler0WK9gQw3QQDYVg/lAQnL1mn+XOE=; b=NB1Gf0/uFIXSlbJVme0hiKIdbf
	ljFj4oWxlE95PdHrCxMCqgHzHENqZxO15EhSKcVrUomQuHIioVHSEHvTJcUdN3MnmW/AUdgDjoK4z
	RULNAxaQWkBSNyNIDDQ/dNLN+7e6kc3rJ++iGzoV4O67yjJjDkbMar53tw5p/IJd6MBi1rf0p89d5
	+70qFV/kNLsCBebMcbitE7SvVNsF+2yoqRXTYVmCHZTaQGM6+WuB3uaEdGri5t2wbwcQjllh4eR0k
	JAGa1Zm2BY2eYmQBHQuAB3ElCKI0j+DOcNvTpqX6qUPns3gdsbPo5ifDrdyP3/VutR2geQ5DxFTue
	9dYqus4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nDG-00FPCb-Ku; Thu, 30 Jun 2022 05:59:38 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6nDD-00FPBX-U7
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 05:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656568775; x=1688104775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BZt19EjiC89cEFx3Fd4TyePANKdTGf9Qfr0hFVn+1IY=;
  b=d3R/q9+RTPiWbZFf8tNdrZsFeZs0ElY66iUSUFM85e5fAuSkVVDYchl0
   l4sdvuZsIKlb7GAbIju+gL8JZRLZC+r/6tjci/B1RTOOUt9eah0L5H8AZ
   rJrvHgecIQlkZJNVPx1h1fudv+50GegsaGTyP9qIT0IGfQLy2/te6QyQI
   0b0RXcYFsL1QlNlZJmRcuh4tvbVkVamSFCpmzyReCA0IruOcLif5aGr0w
   fh1rQK7HQuwzVMapVjpyIi6bZbyMLvCYgGAjP/NHAeSmPepdWFXZk2rx9
   gnDPfLyMcNL3NA/IlGF54+9C9CXqO3z1v7L3Xdc/As/hCZdtnP4Rqig/s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282286903"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="282286903"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 22:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="837463394"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2022 22:59:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o6nD9-000CJ2-8d;
	Thu, 30 Jun 2022 05:59:31 +0000
Date: Thu, 30 Jun 2022 13:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS WITH WARNING
 4db675888cdb7b24812e289d7f90e7928dd400a3
Message-ID: <62bd3b92.UluA72FI79OFZKgS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_225936_034797_91A609C0 
X-CRM114-Status: UNSURE (   6.09  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 4db675888cdb7b24812e289d7f90e7928dd400a3  nvmet: add a clear_ids attribute for passthru targets

Warning: (recently discovered and may have been fixed)

drivers/nvme/target/passthru.c:54:16: warning: variable 'csi_seen' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
drivers/nvme/target/passthru.c:57:7: warning: variable 'csi_seen' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r015-20220629
|   |-- drivers-nvme-target-passthru.c:warning:variable-csi_seen-is-used-uninitialized-whenever-for-loop-exits-because-its-condition-is-false
|   `-- drivers-nvme-target-passthru.c:warning:variable-csi_seen-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-randconfig-a014
    |-- drivers-nvme-target-passthru.c:warning:variable-csi_seen-is-used-uninitialized-whenever-for-loop-exits-because-its-condition-is-false
    `-- drivers-nvme-target-passthru.c:warning:variable-csi_seen-is-used-uninitialized-whenever-if-condition-is-true

elapsed time: 723m

configs tested: 52
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220629
hexagon              randconfig-r045-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

