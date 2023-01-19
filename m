Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6DAC46467
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Y1cla9Pak/0Sgr/upR9lOr5iU9dPonIQ/SGCF7SkJs=; b=USf5znt/Vvte6NT+Y69JMUaK34
	CO0Q1zevunREzca6lhvsAG/ozgPApmEkwgkZZTh1zMnmrCHGeVz6hc5DBK6sTyD1ks9tanJ5bUwti
	3xH/I83D1w5NQgnVioQbxsSPCuugxT4GPvn4vjISoOfhjPCZTaIYz7WLGimjRzEpIvmnobkgYnHHI
	bt1F5n2I97sYjGLwIn7tcdv4Qftyf/eHIcetXpAZQSux8jstsR726765EFZPtk7TTCsem24gd9u3u
	42WBXkU6O1ILFwTH7fQh+LdGKdGLnS9QK08XSHpbZOOMiNg0pHeQOBozl3spPGLYKnPt3YZasfc+z
	WXjUwMSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIceB-007KDT-GU; Thu, 19 Jan 2023 21:40:35 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIce7-007KCv-N9
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 21:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674164431; x=1705700431;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZHp10VdEjeJMJasKufUl42EpH15GgZo/qjm7vcahe0=;
  b=Mtl4axhc6w0U8sDxXB1ZuwRFpKu+tusEi70vbgkaKhhDzy/0uCxDrQVj
   UQ+bQ+CURxclRvfS5JZBnueytErdBrzRwHNQMqgz57JZitVKOD00amFeD
   lABZk/PuwpVI2aU0PjcvOpRuuHcDLSzeNpqtQMr3/Ybgc2Cw68Ts/VHVF
   8roClGpMeOu/IjD9zb6Bmj0tV5w48DutNcpD7JgiwThNc+UcSAPgkM42v
   ikASpvtV+Om50z39lTWQnwkrP28gDYrRUvanMpvFHD5L4ZdH5IuJjUQU0
   fF8TnLQ8aVRayv+jq+AQebgKTurLF0RrXxK6DpNEVSkLvnbB7/y5nGKFK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325472383"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="325472383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653540560"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="653540560"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2023 13:40:24 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pIce0-0001tA-11;
	Thu, 19 Jan 2023 21:40:24 +0000
Date: Fri, 20 Jan 2023 05:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 1c5842085851f786eba24a39ecd02650ad892064
Message-ID: <63c9b8b8.1blRl2dye7QzF5Jz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_134031_826753_C6451EB1 
X-CRM114-Status: UNSURE (   6.90  )
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
branch HEAD: 1c5842085851f786eba24a39ecd02650ad892064  nvme-pci: fix timeout request state check

elapsed time: 762m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
i386                                defconfig
x86_64                        randconfig-a002
i386                          randconfig-a003
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                  randconfig-r046-20230119
x86_64                        randconfig-a015
i386                          randconfig-a005
arc                                 defconfig
arc                  randconfig-r043-20230119
s390                             allmodconfig
alpha                               defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
sparc64                             defconfig
powerpc                      makalu_defconfig
sh                        apsh4ad0a_defconfig
m68k                                defconfig
ia64                            zx1_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
riscv                               defconfig
sh                           se7722_defconfig
powerpc                  storcenter_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
hexagon              randconfig-r041-20230119
i386                          randconfig-a013
s390                 randconfig-r044-20230119
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

