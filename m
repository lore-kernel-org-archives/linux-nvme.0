Return-Path: <SRS0=Mr4l=DY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CD1C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2020 02:18:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27422072D
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2020 02:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iOKs/oVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27422072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VECEiWi1xzx2d+FbxrXJwkXNzvtJyfYYUDPLwdw41E4=; b=iOKs/oVWxWu1WsNog/bErxM6HQ
	i1htJfJ0ZZnl4iLMYr7BmldVXRq7yxiLeIA93yDqxzfAqf0dDq+MT3mR5TGeMhr1/lLjGtPOxvz8z
	uIuFANV1iIUJ4Qu6rCoRTmvs51e28m3x5Dzwcl2Ln397qAHMoMxetPQfEplDgZISptdYGdxqA2sxo
	WpHc9axUECx3LUJoW2SJh492c8EUwXN5PyszqpkeHoDwHhbZFKjb1kRHSrburVOiRmyEhu/MlM4Uw
	g0zDpuMPFSHiudDu1jriYSiZk4b5xzTfE2MDDQE3FrM8gR2649UM8dN7ThzAYmrQ/fhVmRBhjj5Bb
	SwJA9R/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTbnI-00013X-1k; Sat, 17 Oct 2020 02:18:04 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTbnE-00012y-6E
 for linux-nvme@lists.infradead.org; Sat, 17 Oct 2020 02:18:01 +0000
IronPort-SDR: 6ZAaShzVmZSl5g0qEF3crP9YBj4OEOBsMdlUuRupzfnZTY4QuxU18ZyR/x/E943C4KJW4WZ0B5
 1YBM7JrGN72A==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="165960222"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; d="scan'208";a="165960222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2020 19:17:57 -0700
IronPort-SDR: dgz1zSu4wOB/cJH6efhRE/XH2VU0GbktwHJzLY7KA4wXrKMf/MXEfs0q2cSrqoUoIk4Queo4ae
 FwlrK2vNk7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; d="scan'208";a="346768162"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2020 19:17:56 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kTbn9-0000Du-Hq; Sat, 17 Oct 2020 02:17:55 +0000
Date: Sat, 17 Oct 2020 10:16:59 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 d987eab65bf7f917472996aeda2754bac0f5fd33
Message-ID: <5f8a541b.Bc1VJP+Rzts4j13G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_221800_369761_2AE48401 
X-CRM114-Status: GOOD (  13.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: d987eab65bf7f917472996aeda2754bac0f5fd33  nvme-pci: disable Write Zeroes on Sandisk Skyhawk

elapsed time: 723m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7712_defconfig
arm                          pcm027_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
arm                       aspeed_g4_defconfig
sh                           se7206_defconfig
arm                          prima2_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc837x_mds_defconfig
mips                        vocore2_defconfig
arm                        clps711x_defconfig
mips                           ip27_defconfig
arm                           sama5_defconfig
openrisc                            defconfig
powerpc                    gamecube_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7722_defconfig
mips                           jazz_defconfig
arm                        mvebu_v5_defconfig
arm                        mini2440_defconfig
h8300                            alldefconfig
arm                          lpd270_defconfig
arc                                 defconfig
arm                          iop32x_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201016
x86_64               randconfig-a012-20201016
x86_64               randconfig-a015-20201016
x86_64               randconfig-a013-20201016
x86_64               randconfig-a014-20201016
x86_64               randconfig-a011-20201016
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
