Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349EDC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SNoGltP/jNsKDUeOjHfeBIFOam7VVBMihrwbysGb7dw=; b=NdiNJBQwtgKsApSPnVjIdkUqav
	s3+qpgIIs4crD0I0haMD16tF/y6CO3YtPATfc7h9feCmVdtPRDXI4Cgeez/nSsEokFB/EgDIV73cc
	Ghjna6x2HFNQTrICT/H151I+EJTxBGj643m7hMFg6J3QU2mM8eS7sTlGw8ivgtlvtSAAXKzXwcaWq
	UFHRgGSG3WhM4KRKqrFIguU1AuhyK3AqJNphcudcR2tDpBwpCXxlHb2B/DJz3ROkpLUagbWTstCUv
	c3PaDLUrrC5CN120CkRc4ywP7kHiNLqingg/ViAymZV0g3wVi7gqQSoXEjdZY8fFsZQAggGPyFHmP
	7k7v5pvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onY33-007yos-Iz; Wed, 26 Oct 2022 04:29:49 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onY2w-007yo9-PY
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 04:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666758582; x=1698294582;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vIqAR6L2zfHsqITx2mkHjIPljnnc0erqMBYU5IxfywU=;
  b=dyBLp7bvonJei4KoeBeEYRUKIgKEOUTtBb03ZitDPsX/ig1LuOOJarm0
   U+torkNPRHtT/G3mZz7P4qaTWFt6Am32QR3i+lKTxAAx+Qc81AHlh3eml
   3V2RVxygVGBEyNQwQd0ElhqI3V4sBS3uXDdRWIcwmXwB71bmUeiurI1Uj
   ajKRgkQN96kbc93rv/uRkANxtiaIx6w3ULOpVOIlAQO92PAwDoRh1Hy6y
   YnS6TpqUa+sDnq7jiNUytgIX8P8Feg9WIAJpy/17r365Hk/Ci/Lvv8ALs
   Njo0yG5rq9CPY4ZVO7DvfXR8W6obmsoLLVzVO9e6jtkJPA7AXTIcny7dR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334469979"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="334469979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 21:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="583025022"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="583025022"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 21:29:37 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1onY2r-000702-0D;
	Wed, 26 Oct 2022 04:29:37 +0000
Date: Wed, 26 Oct 2022 12:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 fe8714b04fb137aa62e9a69424c48b5301b721b9
Message-ID: <6358b781.A4vL8Q5LGYwHSIXy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_212942_902021_FB5693DA 
X-CRM114-Status: UNSURE (   9.10  )
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
branch HEAD: fe8714b04fb137aa62e9a69424c48b5301b721b9  nvme-multipath: set queue dma alignment to 3

elapsed time: 729m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
arc                  randconfig-r043-20221024
riscv                randconfig-r042-20221024
s390                 randconfig-r044-20221024
i386                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a013-20221024
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
arm                           viper_defconfig
i386                             allyesconfig
sh                   sh7724_generic_defconfig
i386                 randconfig-a011-20221024
x86_64               randconfig-a012-20221024
mips                     decstation_defconfig
i386                 randconfig-a013-20221024
ia64                             allmodconfig
arm                         axm55xx_defconfig
x86_64               randconfig-a011-20221024
arm                          gemini_defconfig
m68k                             allmodconfig
powerpc                       holly_defconfig
i386                 randconfig-a012-20221024
sh                          polaris_defconfig
arc                              allyesconfig
powerpc                 mpc837x_rdb_defconfig
x86_64               randconfig-a014-20221024
i386                 randconfig-a016-20221024
xtensa                    smp_lx200_defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
i386                 randconfig-a015-20221024
x86_64               randconfig-a016-20221024
m68k                             allyesconfig
mips                             allyesconfig
i386                 randconfig-a014-20221024
powerpc                           allnoconfig
x86_64               randconfig-a015-20221024
arm64                            allyesconfig
powerpc                          allmodconfig
mips                         cobalt_defconfig
x86_64                           allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
m68k                        mvme147_defconfig
sh                               allmodconfig
powerpc                   motionpro_defconfig
x86_64                         rhel-8.3-kunit
mips                    maltaup_xpa_defconfig
x86_64                           rhel-8.3-syz
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
s390                       zfcpdump_defconfig
sparc                            alldefconfig
m68k                        stmark2_defconfig
arc                  randconfig-r043-20221025

clang tested configs:
hexagon              randconfig-r041-20221024
hexagon              randconfig-r045-20221024
arm                      tct_hammer_defconfig
mips                          rm200_defconfig
i386                 randconfig-a001-20221024
riscv                          rv32_defconfig
i386                 randconfig-a002-20221024
i386                 randconfig-a005-20221024
mips                      maltaaprp_defconfig
x86_64               randconfig-a001-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a004-20221024
x86_64               randconfig-a005-20221024
powerpc               mpc834x_itxgp_defconfig
x86_64               randconfig-a003-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a006-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
powerpc                     pseries_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
arm                          pxa168_defconfig
arm                         lpc32xx_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

