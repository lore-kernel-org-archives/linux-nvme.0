Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2714AC05027
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8xT2q3L78C5BMR0n7Xdz89fGW4s/LMYfOId29CO10C0=; b=iaaTqhCC4p6ETFcS10BXkAlVSy
	iho3bKAW5h2HSaVhOLtjjn3gVoRltxH/kxE/rSOn/ZY7BpMzWSlo58ORPW+Z6cfNfZ6SV9XwZcqka
	bs5jQblhvNtuMCOKGa/r5TwH8YdVzvT12xkWwK7V/Kan/APUn8NCo56myyXpwH8nesRnOoEsZHlyu
	s+mo3qlziOIfOXxOrdyTwic4VtkUTcMlge1iSprRfrBwrHysZiOOrNOLaFgN6LzEOhg2Wjqafx1z6
	jZEIsInC2P/veNaOYgqINF/yozwop2J8atlGLyDnHHLytUkqweuuZ4COjhi5xFMzht9xFAX+R6aNV
	NC7kQM7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNaCh-00G5dP-BA; Thu, 02 Feb 2023 14:04:43 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNaCe-00G5cj-C9
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 14:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675346680; x=1706882680;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aLu9sPjyjhLiMcJAJ5Ynfz89D904oE1iVYZdWIg+Dq8=;
  b=NVp814NatTI4EK9uUW22GFQR/P3iN2oCKtwvh6RjKNSbhGR+aokmy7cn
   63k2jcIk17jYPtLyFk/LDLcPeGYel2nDIp4X6WHE5dhWN9ShcU0hCR+Qt
   RET6xjgx5MvDSAnlye5AkjD9GtMp9yIFGFMbcpOco9tRqxfMHxE7fiS9K
   sVAd/mCf/8RQLRP1hqYoP8Rdlzr5refujw47QFK7jlCzv0O/q5xCHY5LF
   m72BJyRrnlc56SqvJE1PYKUKtsZAjJLctkx2Dpjd+oML7Nv8UhWpn6SQB
   Xs5+wU/vfZs+w46VqA2o+NRi/2gihojpDc16gLZyA5Nrty4x7AwhCLBY0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308101025"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308101025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 06:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695788589"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="695788589"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2023 06:04:34 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pNaCX-0006ZQ-1W;
	Thu, 02 Feb 2023 14:04:33 +0000
Date: Thu, 02 Feb 2023 22:04:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 baff6491448b487e920faaa117e432989cbafa89
Message-ID: <63dbc2e2.3N3j8AYoq0RG0iXn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_060440_470357_BDF7EED5 
X-CRM114-Status: UNSURE (   6.63  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.3
branch HEAD: baff6491448b487e920faaa117e432989cbafa89  nvme: mask CSE effects for security receive

elapsed time: 1332m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                             allyesconfig
i386                 randconfig-a002-20230130
x86_64               randconfig-a001-20230130
i386                 randconfig-a001-20230130
x86_64               randconfig-a003-20230130
i386                 randconfig-a004-20230130
x86_64               randconfig-a004-20230130
i386                 randconfig-a003-20230130
x86_64               randconfig-a002-20230130
i386                 randconfig-a005-20230130
x86_64               randconfig-a006-20230130
i386                 randconfig-a006-20230130
x86_64               randconfig-a005-20230130
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230129
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-c001
parisc                generic-32bit_defconfig
arc                      axs103_smp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                                 defconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
arm                              allmodconfig
arm64                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
x86_64                        randconfig-k001
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

