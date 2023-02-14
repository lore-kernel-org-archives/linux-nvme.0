Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C04FC61DA4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q1odARL+dgyDOKTqML8l+Pg9ZMRX4cIZHoJH3fXcgVk=; b=Pj4mHha5nOEHeQYbl59cI9v3jq
	uEGWQO+rX1r9gJCH2Ff+K9xdMVcK2370/RrCGyTuORRISG24OYlu/a2vzfO8V3BriVrlK9LmPZbG/
	o7scqz3gvfdvXtitGMd3RWe4XRCpOrvuUmCeKNM7TQ8hZe03FrFKlW48tK08wuVAqTNIphSLmnzeR
	6DLmmPXCrJC8RJqCWGLubbQNHA7v/QuUF58QE0dUGKZtDZ6tjiv5qDVhmMR3VzKl6pusGpIwZ7fWJ
	HoXx3//1VbmRQ2LLRenukVFuKYsJ5ORBILSpNf1JgjNjqM+YvNOXhDc2rbi/pS2PvUWXG+WO4iCBx
	i6hTplhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRzyb-003AKM-Id; Tue, 14 Feb 2023 18:24:25 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRzyY-003AJo-Bc
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 18:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676399062; x=1707935062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F82BFxgaClYTsxXTWP4QDGcp1k13E5O99SKWc9xlb6w=;
  b=S3g43sApAk2S8ZTs9RmdDbW77Wg3mbFDyxLXmrIpwqoXizA25sH9HaAQ
   zRSOw+5HfKIUJrhkv7htaQSLQJeNMQcdEsLfXGNlMbMelJbqjnUjDKjUP
   Kp3m/fWSCt1Lklkjr/5oC0PnsMTRqYCb5Bc+F19DxhDyiITqmfcdo9Rjn
   X8A2eO12A4Zp6q9SYctQWaC2PmL2lzI9ThXOKYkcrLg/2pSJWhnyycBjG
   2qifDLE44kQTnJVm3JNzkiH23RkMG8LpEl5RA2hGKoZTtWeuc8KwajaHz
   sXQNAIp6OxBMIzVfruhCOEUG0gLj4xZgMzUB5taPbXqKax9HvLEWPgxtg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393633240"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="393633240"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 10:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701717456"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="701717456"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2023 10:24:19 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pRzyU-0008iJ-2O;
	Tue, 14 Feb 2023 18:24:18 +0000
Date: Wed, 15 Feb 2023 02:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 b6c0c237bea191fb99b6c2de093262402b0159a6
Message-ID: <63ebd1aa.d9ROmdIZl+xON3nh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_102422_506950_36C51567 
X-CRM114-Status: UNSURE (   7.33  )
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
branch HEAD: b6c0c237bea191fb99b6c2de093262402b0159a6  nvme-pci: remove iod use_sgls

elapsed time: 738m

configs tested: 86
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                            hisi_defconfig
arm                  randconfig-r046-20230212
arm                        shmobile_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sh                           se7206_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a011
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64                        randconfig-a013
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230213
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
powerpc                     akebono_defconfig
riscv                randconfig-r042-20230212
s390                 randconfig-r044-20230212
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-a012
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

