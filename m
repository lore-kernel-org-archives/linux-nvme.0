Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABCC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JfSiXFnWTz1oMtTrl8V2WeQPcNcVlJ8IIaIzuXky0ww=; b=lAWBl+HYBlR9mHGMMFc1g3QuGo
	wlrfl/oeP9gDxl/EaNixpRP1KxDAvRhkov+4dM+tmqDIQkML9H1OnxNmUowXbBTwascBalLmj768P
	NAYdaFBTxzDljm/2ltm3V16LnQ3RcvmAqfzytVA+3RsJQ6wjjAlegH0CH37fUyNNBR39674PHC2d+
	m+lIODUvlKN6F28ghdLqLNOX0DR+1scUu8SK1lRSTxTtq6o88pYXO+Iy1VX7L1IgAxJUNX/3Wc/O/
	ozWsKkSKJarQPLawXYJrX9ihOKvB0LYd7TviDmfuIMKd3o2BSNoP8VTHk9vg9GxG1hOWRJ2NW6w8h
	yYPiGvSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNYlY-00FoCk-1k; Thu, 02 Feb 2023 12:32:36 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNYlU-00FoBw-Pl
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 12:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675341152; x=1706877152;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/SpRfQZo5vimgQiUvjBIVUn06P2hYvlttVqjkkkMXeM=;
  b=akNI32rHkmm0AfHO82X+BkkJX92ugaYI29LZvbyShs4hpgV/NO8ZViNp
   0fBVUUEYcS9MxHD7xW5ji4BAlSrkd103K4iVMnL6hUqAbKzet7SGTd4ir
   cidfU7kSipfj5aUc9pAOi0NyjchvTPdE0QbEWIAnbTZ0gjGRXO93OqP3H
   0ltHpgzJfeUc1oD4ydRuwjevxE9yfEd6zbHkDy9BGqQXZ3sdwx5GVYD0R
   +SGXfSIey317QONr7R4lZluNdIMObmK0ZqWOG5uU5n3iRfhyYSrk884Ke
   T1O92n7Yq+ttAauJQnwlpuGk5yuDHeOhgXOsgEB4IzBtaDZ2RWAC/edQo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326129089"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="326129089"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 04:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665266651"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="665266651"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 04:32:30 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pNYlR-0006V4-1x;
	Thu, 02 Feb 2023 12:32:29 +0000
Date: Thu, 02 Feb 2023 20:31:53 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd
Message-ID: <63dbad39.8VcRndHxv7ORt4+C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_043232_878555_C43996FD 
X-CRM114-Status: UNSURE (   9.42  )
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
branch HEAD: bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd  nvme-auth: use workqueue dedicated to authentication

Unverified Warning (likely false positive, please contact us if interested):

drivers/nvme/host/auth.c:48:25: sparse: sparse: symbol 'nvme_auth_wq' was not declared. Should it be static?

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-s032-20230129
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- arm64-randconfig-s051-20230129
|   |-- drivers-nvme-host-auth.c:sparse:sparse:symbol-nvme_auth_wq-was-not-declared.-Should-it-be-static
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- arm64-randconfig-s053-20230129
|   `-- drivers-nvme-host-auth.c:sparse:sparse:symbol-nvme_auth_wq-was-not-declared.-Should-it-be-static
|-- i386-randconfig-s002
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- m68k-randconfig-s033-20230129
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- m68k-randconfig-s052-20230129
|   `-- drivers-nvme-host-auth.c:sparse:sparse:symbol-nvme_auth_wq-was-not-declared.-Should-it-be-static
|-- nios2-randconfig-s032-20230129
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- parisc-randconfig-s033-20230129
|   `-- drivers-nvme-host-auth.c:sparse:sparse:symbol-nvme_auth_wq-was-not-declared.-Should-it-be-static
|-- s390-randconfig-s051-20230129
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- sparc-randconfig-s043-20230129
|   |-- drivers-nvme-host-auth.c:sparse:sparse:symbol-nvme_auth_wq-was-not-declared.-Should-it-be-static
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
|-- x86_64-randconfig-s021
|   |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
|   |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
|   `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:
`-- x86_64-randconfig-s023
    |-- drivers-nvme-host-core.c:sparse:left-side-has-type-restricted-__le32
    |-- drivers-nvme-host-core.c:sparse:right-side-has-type-int
    `-- drivers-nvme-host-core.c:sparse:sparse:invalid-assignment:

elapsed time: 1240m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                 randconfig-a001-20230130
arc                              allyesconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
alpha                            allyesconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a006-20230130
s390                             allyesconfig
i386                 randconfig-a005-20230130
ia64                             allmodconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a005-20230130
x86_64               randconfig-a006-20230130
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                                defconfig
i386                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
arm                              allmodconfig
x86_64               randconfig-c001-20230130
arm                  randconfig-c002-20230129
i386                 randconfig-c001-20230130
arm                  randconfig-c002-20230130
arc                          axs101_defconfig
m68k                       m5475evb_defconfig
arm64                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
i386                 randconfig-a014-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a011-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
hexagon              randconfig-r045-20230130
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230129
hexagon              randconfig-r041-20230130
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230129
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                    gamecube_defconfig
powerpc                     akebono_defconfig
i386                             allyesconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

