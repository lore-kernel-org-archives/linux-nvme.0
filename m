Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE902C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aGp71ljERwU/Y84a+S6dfd/IB/Rtuf1ame0Dnx4d53k=; b=wJIV4VQlyqOwm23+HdGLyiei8P
	ERzVTriHGZV6ZyhrRmIHlh5CwmiaZcxgBLiq6zHN2jzE0MZL3HsII7zh0RFpeYO2PGBv+YGdCnglc
	DmTxsW96nGG171aCOSbZzHWGZSmEE2HC9U7iST+whouyl7MMII/gBxq82O1DcvS54WjplhHJe30JX
	jE0H+fPAsqZ8KTe2IQL4qBPq7xdc79DXMwQPqaWtLBkrXSSf92RcT383CI/Wy8c1CZNdZStnScN/X
	GjnUTRN2zlBclgL4LVB/wVWP4L9l6G9G2K53MDEygv2rvP8sZZYAFvSjwLsxyFL8Sg0NVdpjXec7s
	Y+bjlJ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQuK-00HKkN-3W; Thu, 22 Sep 2022 18:26:44 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQuG-00HKjC-Lf
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663871200; x=1695407200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ff67gfNT+3AxrKjuuQFctOgGFSLwHz2nxN6iI5M5ezk=;
  b=cvz6FAR3btZEHQ3co2yLcVcOxI3G4NcMBGMlkxVZdAQLbNJ9s8mm7h0A
   IPpXGviSc5UkdQIPYNgzVRVexBi5ao+HdYzY3rNgmbxqeMu7jFV9YYeEt
   d8nEG8Ievrwo0VaNJci51LYEEN3WatOV0umOwT8l6trL1pTARX+Zm8OYI
   PafLizMz+kBJjJAawIuW7tFx8ul9gpuowO0PPrpdML/cCnWpC29LqsGlT
   be96qmfxa0ToJuXyoVxa3wNcwxASmCUM2+06dw4U4CFJfK36eEZTQVE1/
   zjB2pVCt+pvq+fquNuo16bVIu2CVbFqGYn9sgca3C/qF3coprrJd6dYPY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301245187"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301245187"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="795204025"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2022 11:23:35 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1obQrH-0004rq-0l;
	Thu, 22 Sep 2022 18:23:35 +0000
Date: Fri, 23 Sep 2022 02:23:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 ed37c779b715b13fa51f9d6c465744cb2b979998
Message-ID: <632ca81c.HuXZOtnqSa+IzpY2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112640_785611_8654D3C8 
X-CRM114-Status: UNSURE (   7.73  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: ed37c779b715b13fa51f9d6c465744cb2b979998  nvmet: add helpers to set the result field for connect commands

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
x86_64                              defconfig
arc                  randconfig-r043-20220921
s390                             allmodconfig
riscv                randconfig-r042-20220921
s390                 randconfig-r044-20220921
s390                                defconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
sh                               allmodconfig
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allmodconfig
arc                              allyesconfig
arm                                 defconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
hexagon              randconfig-r041-20220921
i386                          randconfig-a013
hexagon              randconfig-r045-20220921
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

