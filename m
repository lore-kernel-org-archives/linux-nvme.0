Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CE9C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 01:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lXm0pK13oDt869uF2DzxOk8lrMjegmJN/YqK1eWQdnE=; b=SRq4AfV2sg+XNQm+evcQEtifyP
	AcjhHyq0sD2Fgrsef7RAoU1T+5k6PfcSpNbtEvkolPQYJJ1gUpRYUyqrZBzsAvU40cJo/CYryILjd
	0Y7skynmIAmXHFAxQNRlRnIhG4C6stLIp/yyTGGOZIN7HigG1Rrho9h5IcNvqvJZf9kRPr/ig40jt
	GBNq94ozqtENZltn+7zC7IVBYCVXkm56caxoAx7r3FigFndBopAjqJG/3W0uurvHrJRzwpvr1oy1q
	z9G+PnLDg89iFePtg7X8RdruDr20gE5noprWokEP2bf3BURuRrht/bEQ8IVCwHCgaVrzFVPibQkq6
	X8l71jfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovTa6-009JQV-7d; Thu, 17 Nov 2022 01:20:42 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovTa3-009JPa-AS
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 01:20:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668648039; x=1700184039;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nE8o/JshxVbViOapv9D5cOv6JZaPrjLpc6S2C/JO4fY=;
  b=SUAjLhiUSWUSwsHVuz6a59BiSPCXVWhhHrReZQAvogHuVZuaY6INLbRn
   HY2ppyoCOZxCb7dj3FJ/RC6PH35zCH1fYoKLXHMZ3SMUtux1MT28naKda
   yKFkwYV2eaCIODdkjYcx83f31Fpt3Yy5VARN9h46zGipezyH7WgHTCilh
   CBcNnzrcjqN614Yw1iZIWDETat7PAfheKvY1VwATNsWWqRnBvP8YUiP4g
   1kQtjItUpZlrz5kgq00uxSg2yzoFub4CguXf63lyILeL6+XvklPetWmgw
   hyMltEqEqUiZ9edbKHJfeu9E1r3QhF/zc8FouRXlJNFJCXysclg3WxLU7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293114707"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="293114707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="745303520"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="745303520"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2022 17:20:27 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ovTZq-0002v5-2X;
	Thu, 17 Nov 2022 01:20:26 +0000
Date: Thu, 17 Nov 2022 09:19:43 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 891961df73e4dc8b2c69a5f790d5233f93d7c239
Message-ID: <63758c2f.R2IcV/7/n26G0Z+Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_172039_440556_C5DB5148 
X-CRM114-Status: UNSURE (   7.67  )
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
branch HEAD: 891961df73e4dc8b2c69a5f790d5233f93d7c239  nvme: rename the queue quiescing helpers

elapsed time: 724m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
ia64                             allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
powerpc                          allmodconfig
m68k                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
sh                          r7785rp_defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arm                             ezx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

