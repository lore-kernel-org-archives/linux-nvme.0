Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D16DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jBOBA8qjoo1L2M297RCUNqJ1P1k7uXPG0X3e6Cn/I0s=; b=XC2Uq8WqdBXDjVoT3pR4tI9vIX
	VuqvzOVNAASGmQK23gcVZAMgHQZa0iVNeeV3WUdwdhFou3M42wk6H4rMGoC2b6vaA5VWcMXbTqpIj
	+IA2y1o/r9uFBMt90zIS6RopD6bF7c7LXcIDeCMn/TSxAtmCLm6ajuneRZxQqc77P+RbjJjFKbQUA
	Y8AG1wdXxxtV8w3m7NEQYrNPeYK07GqDGKHXRFJxGk/MtXFwyQDiYQrTkPBwA1KToqZU6EokqZLZ7
	kcJTnStY1fMxyfB3KXInQJOJFmbohEyaW9e6Htv/vAPgk6IWlVAhp5QVIisI3e/Lfx3WR4IxKhO1h
	yJTSbYRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBfZw-005oxE-Ht; Wed, 13 Jul 2022 16:51:12 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBfZt-005ovL-Ka
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 16:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657731069; x=1689267069;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FIt8Io7ZJG0le3dpTLX9HGgK66I0nWq+tUyBHG4hB9Q=;
  b=MZQUjm4Y274rUa0gca6XWurnLRBA1h1qT1JErT6BcmkschyURWNJsy6r
   r5Dt9XxaG+iRgvWF0IpbUxipzXPm1UhpfeLR6XTYUfW4o/8Yuc2WL+EM1
   4BI8jDxxPXznNMxnBazfmp27PwaRuRokNxdXytnyjbQTlLGY+ocmq1fxO
   dNKpkAOJLceGSjPF4X/jfJRFA7D9EBiLCqYNGOQ5AxCc5OHB6nBBnE/st
   jlX2cuSuUYi+ySqsdVroqLRdmmghPeT4Dj2lNJYrrWyOxq4iSByqDjD66
   LNOqzh48dUGhtZ3nO73H0ohFCxz5sPIp1MKCnQZKBnar8CGzatA2BTUNh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="346962827"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="346962827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="663441283"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2022 09:51:05 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1oBfZo-0003ff-Si;
	Wed, 13 Jul 2022 16:51:04 +0000
Date: Thu, 14 Jul 2022 00:50:09 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 7b20ea4f3911c86bee698f1b23ba7f59ec890ceb
Message-ID: <62cef7c1.IzFoCo/zRFtGINnI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_095109_754809_05FCFBC7 
X-CRM114-Status: UNSURE (   7.17  )
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
branch HEAD: 7b20ea4f3911c86bee698f1b23ba7f59ec890ceb  nvme-multipath: refactor nvme_mpath_add_disk

elapsed time: 1444m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                                defconfig
i386                             allyesconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220710
riscv                randconfig-r042-20220710
s390                 randconfig-r044-20220710
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

