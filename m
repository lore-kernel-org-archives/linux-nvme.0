Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 03:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qktsaFFuSx1pO6QGqDQduBxXmFUkOdff41NrUZ+WH7I=; b=VuNTTFnlH5wApXniYIHw8GC6AT
	JpcBQcYme9OkZ0LoOX5UvpvvIDOCgyOLHXFd3TQ4Dy0sUtSLpf0c2fy0k0vxC58E+GCfWXjz6GkuP
	xSaj3w2Uwn0IwTiwuEys3tSFMMp+paB4YW6ZVdqa0pWzQGVE0NSiH6AUOWfB53QhYiivmL7AWEF2M
	yrw/4MVtq3ZT/inwCN+0uSau9bYEBR1nfTGGU93Hnjh4mZMJwrrySMYZe3bnrhCQQBj6XYctJJ6lH
	gIgynya96wPdQuZj1DUTOqtX4BnUID0wqJIZqwWyLVTmu1Epem1I0sn0gyqGTTaeNb3A3nM72JTFL
	tp4+VJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxKR2-003W9f-30; Tue, 22 Nov 2022 03:59:00 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxKQz-003W86-8M
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 03:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669089537; x=1700625537;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5+HtXyGmJYBNSiyLsX/1M4KHps23PJylZX/jd6ELkao=;
  b=HmFse6mkl9CPE3+DdkYI2MuRQ2As2MeXdAXy4Tb51hUkfQq3GPR+5i9D
   V5ropFKMLJq84jCLLVHUfJnJ6ga4V1Y3BK8V0lwZyzycoPB5pZ18Wzl08
   1HJI7Pf3oN0SOk6gjsGRvrPAhToZPwk3ss7EnF8yjGo1XyS0+rhbYfSpn
   6sBxDMM80P2rZtbrKj/fbpYfJFJivpYXF06kvjOq5LhOeND0L8dEVkcL+
   wkqFN1NFtbJJy0MquCMFVCFy3H00IxAzDX5HFQfiVfeZ/ZbhPSOLE7shB
   r8CeO250vd6Hsm972mXBs3U/AC4zvTO7NZKio2qN9ZTI7BxXLBrkVoJ8E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313750655"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="313750655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="641269030"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="641269030"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 19:58:55 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oxKQw-00012k-2Y;
	Tue, 22 Nov 2022 03:58:54 +0000
Date: Tue, 22 Nov 2022 11:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 68c5444c317208f5a114f671140373f47f0a2cf6
Message-ID: <637c48e8.OiSNqXj65RJpgGt9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_195857_374702_C8BB2AE9 
X-CRM114-Status: UNSURE (   7.93  )
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
branch HEAD: 68c5444c317208f5a114f671140373f47f0a2cf6  nvmet: expose firmware revision to configfs

elapsed time: 1184m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a011-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
arc                  randconfig-r043-20221120
x86_64                           allyesconfig
riscv                randconfig-r042-20221121
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221121
s390                 randconfig-r044-20221121
m68k                             allyesconfig
arm                                 defconfig
i386                                defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a006-20221121
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
x86_64               randconfig-a004-20221121
hexagon              randconfig-r045-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
riscv                randconfig-r042-20221120
x86_64               randconfig-a002-20221121
s390                 randconfig-r044-20221120
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

