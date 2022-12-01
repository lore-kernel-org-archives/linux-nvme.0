Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03707C4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2ePguQlYIWJJFFYRgAW9grlrZdJ+isXe4BshrCCNvtU=; b=ddv1uzjLKAXVtRgmplhtNB+cTI
	0Cm9MnqsJhu6BedEA9Oyy9j6D4RXtmCmPSEYCMG4oKlJbda5tSE8nTTBMPbxEeYtcpfzuB6gyitOP
	QNgcTtqYnABU4fZ9jZMWXF++h9DVXgN99j78gCN/LSK8dcfx/ZFPGuPwFzO00m1i+SVYg6Z+ma7L3
	MkwrQ3DJSHTXWjDpn9B11e2lsFh8qvYrdLkIGet90EIGSzC9LzHcS9qAOTKtQC/q/w6a2OGExx6MA
	5w/b0qWFvtUJgbn+2Au+F7Z2IIol9SxzptSLLTiNFKQxr5tvE0Ztl8MbUNkvPfoSxkG5mM/EAWQYO
	4n9wR+8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ZOq-003wnk-6q; Thu, 01 Dec 2022 02:34:08 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ZOn-003wkM-PW
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 02:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669862045; x=1701398045;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aoKjDqsJtPgleGB6jIXVauPl1ONqmoRLsjr6ZpcXjGY=;
  b=ScI0N65cW1nE91wUQW3/H4aA9WCNmGnzGqSaIRa6ghx8wEpZHb63JUTo
   yNvf7dcNka5hXN4WsamlCxlqGHAjVSOXlLOFhBVkYndLlNDYXoDphHc60
   +HDu7S25xOzAwFvMcOQyJfADdsb5YIppI/pRXrQNPyBoStIbq4Awxzpw/
   blZtAYHxNDmZnllc6BudkTKi61j7FOww99Phlbsdh92CNL4I9bT6P8JTa
   +2HbhicmPMtezK8qbz6oSNMUqDE6VWtdXi8OalX4279pEhcBV+mKemWqz
   DN5hqYASa5nHB+aQ+ovgXARIy9qxBNdbZYALM/ZfqY+lD6Fn4iiuvOaBi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313195168"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313195168"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 18:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="646571478"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="646571478"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2022 18:34:00 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p0ZOh-000C4Y-2y;
	Thu, 01 Dec 2022 02:33:59 +0000
Date: Thu, 01 Dec 2022 10:33:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 899d2a05dc14733cfba6224083c6b0dd5a738590
Message-ID: <63881282.ofDUvOGLDx/DyKVI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_183405_931619_F16972FD 
X-CRM114-Status: UNSURE (   7.65  )
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
branch HEAD: 899d2a05dc14733cfba6224083c6b0dd5a738590  nvme: fix SRCU protection of nvme_ns_head list

elapsed time: 724m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
um                           x86_64_defconfig
s390                                defconfig
um                             i386_defconfig
powerpc                           allnoconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221128
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
ia64                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                           u8500_defconfig
sh                           se7780_defconfig
openrisc                       virt_defconfig
arm                     eseries_pxa_defconfig
arm                           sunxi_defconfig
powerpc                         ps3_defconfig
mips                    maltaup_xpa_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-k001-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221130
hexagon              randconfig-r045-20221130
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

