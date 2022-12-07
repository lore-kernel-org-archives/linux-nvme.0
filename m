Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9303C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 06:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kvCxXv2LgFF0lts56CDzl51IzdmnkVJLBFGsXCNnJy4=; b=r1cTJwwHzt2B3htSbHuefXcBcG
	qbuSt06ijdLh+k6810zarttz1TpuPyJAFkJrbJX5tUr9JGKm6O3DEwK0PYLQLlRMmMf67u+wWDDxN
	VcV0mUQ871Q0qau2XaOB0DhZkfTyeyj13N8z+SPiO+nLsH0kUL4s4PfuMKJCbQEaW46sd+6PLkiya
	k/JOsdSdgADYRzWpnBtD3+WmazATCIvi1hV2f8kP+u1xSenVsqkPj3CXUrY01IILi2vtssQp/atin
	pPfbPY061huN4E0Q0M8i7O833RfY7Pv5Ypseel+ofvHbTCtY7DHsUj6WSy7J4Q0ySNf6QNqT1geg5
	xDvAvoyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2nsG-00Cp8q-55; Wed, 07 Dec 2022 06:25:44 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2nsD-00Cowg-GY
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 06:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670394341; x=1701930341;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nIxM6+7Jpayv2wyF6ZbfziH1NDu4FQ0q+TdVp8KaGPg=;
  b=VRPmQibV8g0jELHyOV4Zf7S3WTKT0D0iZBOxVTRVPlhDkOHXr1Ri8YGV
   0Vf9umG4kp/QMJ4yk4t910L/bPP2qOR8P+ixiuqqow4WciWBxlrcuaEDo
   3sx5Yayg4auj1xQhsSp0yDK8dy6xjP2kbHh+qP2C4bp6FidQQpmqr8Eyh
   rQVPF3UILHy27cqmJG1Ldt2oc2EDMzPVSeZ2ZZTGcxl7/DxvRJ/XuTJix
   Z8noXUNUZY39J7xX4d0D0+OfLHTthbO/gyDuwrUWEMSDO/Dcs1RDU0E94
   1f4MwHBpO+fx2ZpVlFF76OEcfgTAq1CSWqJc8IVmWnd5mmR383VFC7Q/+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381108702"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="381108702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 22:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648605281"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="648605281"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2022 22:25:37 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2ns8-0001dn-2i;
	Wed, 07 Dec 2022 06:25:36 +0000
Date: Wed, 07 Dec 2022 14:25:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 faecea7efe65e5ff02d6fad4753f11d4ee34e485
Message-ID: <639031d4.hSlFJi0qNNejD70O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_222541_640798_81CF8043 
X-CRM114-Status: UNSURE (   5.65  )
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
branch HEAD: faecea7efe65e5ff02d6fad4753f11d4ee34e485  nvme-pci: use the tagset alloc/free helpers

elapsed time: 778m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
um                             i386_defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
s390                                defconfig
sh                               allmodconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
i386                                defconfig
ia64                             allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
s390                             allyesconfig
x86_64                              defconfig
arm                                 defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

