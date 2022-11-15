Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EBAC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JMWYGL2CEXIwSlMOk5kKxdK6Ka2ZU89u6TZA0pX4H0o=; b=osD44li7PtZRX2iRWIfPe+HvJ3
	qvXloZAFwWZ9wYCSFjaEGS6A4jgFZFMQqzoJZuscdIWayZMNhEnQceaWckxfshfhH/jb2FL+H7CT/
	w8cti/4dxJ2SN069omewSf56JCWXYQ/IzsQIodBBuxTgw6V+oxJNNo73Dm2uV6Z5aWDyxCAQ29zUI
	oS5TvKplUkE37i1oeub8Ww4IQlkMZOarAGOFMSxTazb1TPRzKmPnIbvocGH7ca5GLcVHS2b+tdn1+
	lf/uayIgk63Is6j9EuFmDu1S4gsYn4U60FHvn3YWFPaQ25ZSrKGgEHuHKWi1s4c2z/cyAsxSbbgYY
	i7hc1Wag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov4Xb-00FPjm-Tt; Tue, 15 Nov 2022 22:36:27 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov4XY-00FPjI-Go
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 22:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668551784; x=1700087784;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NTyEQpXM2F1jE189wz5L2t9nHR+0h7q6++9ngJoRnT0=;
  b=R302F872qqCbHlaHpz1RUbqdklYr9LjiLDaQNIKl/+yYOrRZwelbJjBT
   zOzIMfc/KokkX54NjezcIvLUKq9OIDx7fKY+i8jpPfhJrS6izKEjnI9HB
   Lsx6dySC0AXReL6aZlS/4Q/hpjp4FGUxbbpicGwmSYmORO3DTtVbuXOhw
   i4UH+pK5cd1fNj95/391h7jMHqM9+0qD4IksJ+qb5mQOWQOrVP0+90PdF
   B9BYmHdGEDxUEeH/1lCgMRWgi8GIRG8OJCDl/7bAZiUwOdtopWIxNMDRq
   DuP8EG1d+wNWBnv7O1mWXmT4rTJWjzZHSJnEOT1j2sGGoSdV5LkGCASFl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314199753"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314199753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702615654"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702615654"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 14:36:20 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ov4XT-0001iB-3B;
	Tue, 15 Nov 2022 22:36:19 +0000
Date: Wed, 16 Nov 2022 06:35:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 91db3634767099903602e58a3b0928f346f5dfa4
Message-ID: <63741434.enkTc7QVCsbKtERe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_143624_631127_99BD97BE 
X-CRM114-Status: UNSURE (   6.93  )
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
branch HEAD: 91db3634767099903602e58a3b0928f346f5dfa4  nvmet: fix a memory leak in nvmet_auth_set_key

elapsed time: 721m

configs tested: 96
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
i386                                defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
mips                             allyesconfig
arc                              allyesconfig
x86_64               randconfig-a002-20221114
sh                               allmodconfig
x86_64               randconfig-a001-20221114
x86_64                              defconfig
m68k                             allyesconfig
x86_64               randconfig-a004-20221114
x86_64               randconfig-a005-20221114
i386                 randconfig-a001-20221114
i386                 randconfig-a004-20221114
x86_64               randconfig-a003-20221114
i386                 randconfig-a002-20221114
x86_64               randconfig-a006-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a003-20221114
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                            allnoconfig
ia64                             allmodconfig
i386                          randconfig-a014
sh                          kfr2r09_defconfig
xtensa                  nommu_kc705_defconfig
sh                     magicpanelr2_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
arm                       multi_v4t_defconfig
i386                          randconfig-a012
s390                             allyesconfig
powerpc                      ppc40x_defconfig
powerpc                     taishan_defconfig
arc                          axs101_defconfig
i386                          randconfig-a016
arm                      integrator_defconfig
mips                           ci20_defconfig
powerpc                      ppc6xx_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                          debug_defconfig
riscv                    nommu_k210_defconfig
mips                        vocore2_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
openrisc                 simple_smp_defconfig
arm                            hisi_defconfig
powerpc                   motionpro_defconfig
mips                      maltasmvp_defconfig
mips                      loongson3_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
parisc                              defconfig
powerpc                       maple_defconfig

clang tested configs:
x86_64               randconfig-a014-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
i386                          randconfig-a011
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

