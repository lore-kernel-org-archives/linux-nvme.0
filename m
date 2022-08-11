Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E5EC00140
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 02:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yI6RfP2uTrS0qTM2qDfQo80yqTTm+K/N4smXSxJh39A=; b=WPhL0zaeKbxg3UDby5t1uIoSYv
	ynywUmrYb3ugu9VyemWvlYVDD3W+DxKD6CH0qDkhkcHrpEwthqqKqgnORh72nmkPsJNnmaWvALL4w
	6rgofSrhl5jYzPDoEr8ITc8eVrDyhajig0ZsArdIyoI3hVTsShAcA58GXsPlwSHDrvjA+qG/BEilg
	HKgt11Fn90OjfNHhKWNRw+vr5BeCJ5WtPubyQpOJjZizbgHjgaMUfZ0uK+K+NrPBZLrhXINcG7jHk
	Mw1JrSx4jULr/4Oj715YcUq0pTS0L5/ENgvT4kahksY/cYwF5dWzWs+YpgSGOQ/gNWdED5eMzfaLc
	QrcfawoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyJA-004LQP-Du; Thu, 11 Aug 2022 02:52:28 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyJ7-004LP5-Nh
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 02:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186345; x=1691722345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pCz0NlM+GZ0mzThX8w4P5R4t2AUOEj2mhHt3aEnElZo=;
  b=iIJbxmshExbSXJBrxHthNamLI8+3i+rkYVHXGldoxdplQnHkAtjR3YDu
   V5DOsd8XGF5MvZYJk8cvpuelE8yPTm7Q2ROO6FoBz309pVIo0pkJTkZk6
   TPyi2ATi+ccIuY71KRmLcW8JPT10ZCyiZhztNV24BIpxmFPOnuqu9XJ/1
   T08kpQYStuqhk06K209oFV/100PllYruDgjyHjEaVp5t27CABmg4BWqL1
   Q9xYkQn2GCWqJ2J5yxCQEqN/+n/GZGKtn352da6FuequY82YuOb+A2sgs
   h2I25jxpSsNdPOmpMNijoSo+gH8zxbMim19YpoQvlnKUgGsO32S96NXqw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="355245620"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="355245620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="731713255"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2022 19:52:23 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oLyIy-00010e-1k;
	Thu, 11 Aug 2022 02:52:16 +0000
Date: Thu, 11 Aug 2022 10:51:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.0] BUILD SUCCESS
 2bff487f9a9085c9c877b55579b153691f0e5245
Message-ID: <62f46ea4.5pgwWdvn3lXnJgEc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_195225_844693_7226A8D5 
X-CRM114-Status: UNSURE (   6.26  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.0
branch HEAD: 2bff487f9a9085c9c877b55579b153691f0e5245  nvme-tcp: check if the queue is allocated before stopping it

elapsed time: 718m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
arc                  randconfig-r043-20220810
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20220810
mips                             allyesconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
s390                 randconfig-r044-20220810
x86_64                        randconfig-a004
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220810
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220810
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

