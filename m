Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27209C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 06:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w0yWfPiSJEe3/Li68+H/V5/YQTIYaZihnIrFcdCxiFo=; b=FnxtiexFa2xKUdRJnvuZ1ViQwv
	t/Q2VFxEAsDGwNXcP8lDIr+nYmwRLB3kfKnluz64CuOhSB4pMAyRulJDyaT0YCPWL3PKqp2eN8GhG
	FFYiArbP0k6eiJl6/0OfFpktOkeBuVTDo4aIpkuhOYeDqiERFkZhODyHZKnIhwK+TMIhsiisMx+Gm
	Az5gXQUaEyySiZrhh7pwYCVDiYzIirITovE5183iWxr6CwZ/+M2utBI0fJiWBhQUjOX1xJlnzEzV7
	S615GvmETLTCKWqlAxkLWff6agwgRRAWk15rMIrZKjJwk1C8+wWcEYvG3vHRd+j0u4cJXGYZQ08YS
	4azw9PLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o10ST-007Pp4-Vo; Tue, 14 Jun 2022 06:55:25 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o10SQ-007Pmm-Q3
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 06:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189722; x=1686725722;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dZeLFK4dkJCouK4Un0bUn0lorGP+YBpc4xzMFt5GxVE=;
  b=EBmLK0ph3i3DOxtXVjd6tpqz+HZY1QzRG7r8NsHLCjyMes6dO4gAUhdg
   qlmTIpB5k05ljvnhdRz7OZ1amaAfOHmJRZpKhGKG2/UjitAjGHaBjFlEd
   7L0I//zIWj6JxKNt09UBImnw7zOt2hatseT5Bu1pG/n01DTWMJQBMDtBK
   GOWExBeopdoaKD+w6uYe5KdXMbz1FbpHIZTJZcy6lofDXZmTP47g45JPE
   8vSQHAiQHQIOQfcOlvTdzws3cg3p8tesO6Vzwl/AfmNVeyDRtXULTKYpy
   epWoMYiblYZ7xU9LjkL8Zzz37hw9Pm790GR2pwuTvoUwbH2N5BF9v+ght
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276064824"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="276064824"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="686504306"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2022 23:55:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o10SM-000Lam-1D;
	Tue, 14 Jun 2022 06:55:18 +0000
Date: Tue, 14 Jun 2022 14:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 43047e082b90ead395c44b0e8497bc853bd13845
Message-ID: <62a830d3.P4ov+0SEVFtGW4b/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_235522_941512_CF7F7296 
X-CRM114-Status: UNSURE (   9.23  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 43047e082b90ead395c44b0e8497bc853bd13845  nvme-pci: disable write zeros support on UMIC and Samsung SSDs

elapsed time: 727m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
parisc64                            defconfig
s390                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a013-20220613
x86_64               randconfig-a014-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a015-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a014-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
arc                  randconfig-r043-20220613
riscv                randconfig-r042-20220613
s390                 randconfig-r044-20220613
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a003-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a006-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a005-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a006-20220613
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

