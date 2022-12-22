Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE0EC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VRbZuqsoatRbk0E/qrF+kqfo5kcX6juI+ploVDeL+MA=; b=N1vy38VF3aaCQg2v0WN0PzEM1R
	RsMfZhnQRXQHXuBdODcWhvqGdrrvbgf4KserQhM5lmww1mliOYLZdxZjnjZlD0OFAkHEY04xlZS23
	pWXqBUvH7cWRbWHJGJSjiO6dKOHxG3zJ32qC8DrDefCi8NRdsq8dDIksDO+cGkHCeWoCns+rOPUWE
	Oo8ah9rP7uY1a9JPfTFy4XpNVmvVk1gRBiQzww7lrdKuHTgI7p2Yk0uSKbfbjWbaGIvxBxmD82ErK
	VIv1A/bqxcmpdgPe8wpHkhTnojON1JG5ORNerUOFn8r+LRl70X0keintXvUqpybX8Lt9FqsSLGY/i
	YJKlP7ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8Tbg-00HWM3-Km; Thu, 22 Dec 2022 22:00:04 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8TbS-00HWEv-Mp
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 21:59:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671746390; x=1703282390;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ymLQQN3KI7d2wcMHx/6SFGSgZXF8mYjNiIb7DRrHc9o=;
  b=elfIDr8b3LKLxWpEQeYTfRFmSwA2La1YXnUP1K8lES6uJL3iADjrlKXG
   Y0O1Nm+jA5oD5z/wzhc/gXOCrLL3/DIhd7FhYeXgpKH11O3OM5kWVCIhW
   5QPCjwB0hBZtMSDxub6O4VBHOIqq4oRDgCsFLTgYbXJAANh1alL3S9FoF
   AUO/gqVZ7wZEon7EKYzYcj/emQz6SQSFkgJIU7xBXIAiZAXLEYEBAA9Tz
   PsRWqwqKaMKTtPNM74XntHXUmQ23x3RlbFO+1/2/QMUs+BGPMG/Bh5dhU
   bpqYjdNaXW8K0BkItqO+IGrSq5RHZOzdeCxaJAPfKRgW3WeuxC3w1nJtc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="299897567"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="299897567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 13:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="980750648"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="980750648"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Dec 2022 13:59:46 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p8TbN-000CBK-2Q;
	Thu, 22 Dec 2022 21:59:45 +0000
Date: Fri, 23 Dec 2022 05:59:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 3659fb5ac29a5e6102bebe494ac789fd47fb78f4
Message-ID: <63a4d337.L8eZGvj5pPvR+5Yh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_135954_412272_A35B4C81 
X-CRM114-Status: UNSURE (   6.08  )
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
branch HEAD: 3659fb5ac29a5e6102bebe494ac789fd47fb78f4  nvme: fix multipath crash caused by flush request when blktrace is enabled

elapsed time: 721m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
s390                                defconfig
s390                             allmodconfig
x86_64               randconfig-a002-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
i386                 randconfig-a004-20221219
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a001-20221219
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                 randconfig-a003-20221219
x86_64                           rhel-8.3-bpf
m68k                             allyesconfig
x86_64               randconfig-a005-20221219
i386                 randconfig-a002-20221219
m68k                             allmodconfig
i386                 randconfig-a006-20221219
x86_64               randconfig-a006-20221219
arc                              allyesconfig
i386                 randconfig-a005-20221219
s390                             allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
arm                                 defconfig
sh                               allmodconfig
arc                  randconfig-r043-20221222
s390                 randconfig-r044-20221222
riscv                randconfig-r042-20221222
powerpc                          allmodconfig
mips                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a011-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
arm                  randconfig-r046-20221222
i386                 randconfig-a016-20221219
hexagon              randconfig-r041-20221222
hexagon              randconfig-r045-20221222
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

