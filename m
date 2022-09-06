Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA5ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dk2KbT8n9H3RQbxP5R4j3A94az20gx2d0HRTNdEprSw=; b=ZqUAY1sDza3fTUToWs3F/4Ky67
	lMxDbhEZxQ4bVFyR6sdBdrbPemu2yBLc9mVvtpTpWzXBHTgm55lWseKqmtm6Sq5Y/xryBRLzK1TN+
	HS/0eWborjDgQkhX3Yak1mW8rXGJoGzksWVE1kYNGxa3PLUXD+0x9xsf7AHelHtHirUMvbJufjWvf
	gAR5Lr+fNbgHMJfrsYy37KR92HCpFxJEh5QpJaXXxNt61TUuuz/Hd3yIIwnfZ4v5L1u+qAnXmJ3EM
	te3+TUiPe/3UviXFvWgXetkQlLI6ROewhq6U6VERzJPQRKaGT5pXWpSHRFtEp80W2vPYAx4+SRebs
	YP9/1X0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVNcO-001QMC-5D; Tue, 06 Sep 2022 01:43:12 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVNcL-001QIi-43
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 01:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662428589; x=1693964589;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hOOHyRlZmVh7e1SK8oHdEI7VtRRanV+8hx3uzoKsGII=;
  b=CaMWLX8plTT4RmmCGFAiqreh1cJAsE5pvJKnYHqNW12UdHKnm7N7pMKo
   JjVOyBwKFRNnr6tjTFYZDR2MM3Ugy4sQZkwQnZowrDNIUoWdccnUh6i/r
   X6HngCLOzqhebIxrSA2s+wtr7Y9av4+Mdg8kymR9HPYZ31VNkEWZHhYZH
   q3m7MWgATe5AllhKYuz+nQDPP3pxIJWClbBDxkKzwnpaZ80GRZOuMzMSM
   LL/3yDhBOBTX/gUiBwIqexjWGe0l6p+2teXBp6OG7wNNU2ejnRRqzbQl6
   4Q8hPkDdxRt81dNM5G0wLsynZuzlABW3qFds282gBUPdSLY2zzGmxB58t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297788641"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="297788641"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="647055089"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2022 18:43:05 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oVNcH-0004ip-19;
	Tue, 06 Sep 2022 01:43:05 +0000
Date: Tue, 06 Sep 2022 09:42:20 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 9951e3d984c9bf324bb7d486f42ec82727e3d777
Message-ID: <6316a57c.F56dywNtIA8I6xl3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_184309_273372_7B0C71FD 
X-CRM114-Status: UNSURE (   7.54  )
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
branch HEAD: 9951e3d984c9bf324bb7d486f42ec82727e3d777  nvme: consider also host_iface when checking ip options

elapsed time: 726m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                      loongson3_defconfig
arm                           h3600_defconfig
sh                        sh7757lcr_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
i386                 randconfig-a003-20220905
i386                 randconfig-a005-20220905
i386                 randconfig-a006-20220905
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
i386                 randconfig-a004-20220905
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                            hisi_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
openrisc                 simple_smp_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a001-20220905
x86_64               randconfig-a006-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a005-20220905
sh                             sh03_defconfig
powerpc                      pcm030_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
riscv                               defconfig
powerpc                     tqm8541_defconfig
arm                           corgi_defconfig
arm                      integrator_defconfig
sh                         ap325rxa_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                         microdev_defconfig
arm                            lart_defconfig
sh                           se7721_defconfig
mips                  decstation_64_defconfig
arc                            hsdk_defconfig
s390                          debug_defconfig
arm                         vf610m4_defconfig
i386                 randconfig-c001-20220905
arm64                               defconfig
sh                            titan_defconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
powerpc                     sequoia_defconfig
mips                            ar7_defconfig
xtensa                          iss_defconfig
arm                             pxa_defconfig
loongarch                        alldefconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_itx_defconfig
sparc                            allyesconfig
sh                             shx3_defconfig
mips                           ip32_defconfig
sh                          sdk7780_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
um                               alldefconfig
parisc                generic-32bit_defconfig
loongarch                 loongson3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                  randconfig-c002-20220905
x86_64               randconfig-c001-20220905
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
x86_64               randconfig-a014-20220905
x86_64               randconfig-a011-20220905
x86_64               randconfig-a016-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a015-20220905
x86_64               randconfig-a013-20220905
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905
hexagon              randconfig-r045-20220905
s390                 randconfig-r044-20220905
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
mips                          ath25_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
arm                         palmz72_defconfig
arm                        spear3xx_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

