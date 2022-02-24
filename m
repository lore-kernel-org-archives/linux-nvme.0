Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54708C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lZDpzWIYu3WO9YHDJJ90nfoeRKY364uHZqf9zyKe+Jc=; b=YR7nIMNXwSmES3USmQYsEHNZoC
	2S0KA9VWHjBU4tsNcqi0AEY4Dswmh1lkSSOI9Ghx6FtJvkeAqJM0knwdp6lloPaDlQ1UsHIE7oB/L
	YKvwEy0RM/o5YL7HvVTFJwOh7HSAyY71vyspS1ois3/ZwqMCKbOOQs1mkMQT0KU96qA9qx31rKeA9
	VM+M7fLvf7emzMrwQb6zAomWddOunxIZU1lycMIDz9yiPCwgzD+nWQFghMa7CghUHU7PlOkAxXX6t
	n9f3gM2kruafPRc/jHD/UrbUdN/4BoQGmPlTxR9UD1lkeioqtlfxJYDzyOuLcKN0DdZ8faxw9gVw8
	eJABuGFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nN4zl-00GfWr-Fj; Thu, 24 Feb 2022 03:40:45 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN4yB-00Gf8V-2e
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 03:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645673947; x=1677209947;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=193d6LBI7tTz7uenfNVGITyIuKUDtkYJf+x+ZrrUwwk=;
 b=fBIDt3JdzYsXDLMe2F6sobFcW2LM4n9QmY7xECPKJs5g36dNXhrYWXS1
 u9CB4TOqxN5Pvr5/CgSN6wPfSj/mr8Wt2lWkhEmoTDfRV6/UgXc0SzIsw
 4BLAAaNsgJhGynzhfZ1Ceq+lgXpzffz/QM17idkHEcJgGxwQ4HGO6qn2/
 LKaaeKIcPZ4IfA9jLK09NTH/vBn0HbJr9UXJeGaDY6yffHr5Lo9DvGQ+1
 CikNalKFBy9RuSfd/4XSMgDZNpN8Gl3xSbvqCSOv0QckmaKKkFJb6ct5B
 fX/QA0Jm3WdMwzh9caB5il+98HKyy4Gv1l9LHavOxi5pbGH0LCZ6wxHAc Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250970084"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; d="scan'208";a="250970084"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 19:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; d="scan'208";a="508707968"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 19:39:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nN4y4-0002CA-HD; Thu, 24 Feb 2022 03:39:00 +0000
Date: Thu, 24 Feb 2022 11:38:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 c2700d2886a87f83f31e0a301de1d2350b52c79b
Message-ID: <6216fd98.mDmu9YoR3IWLG+9d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220223_193907_329014_CEB3417E 
X-CRM114-Status: UNSURE (   6.71  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: c2700d2886a87f83f31e0a301de1d2350b52c79b  nvme-tcp: send H2CData PDUs based on MAXH2CDATA

elapsed time: 722m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
arm                            pleb_defconfig
sh                             sh03_defconfig
sh                            migor_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
arm                         assabet_defconfig
sh                           se7724_defconfig
sh                     magicpanelr2_defconfig
powerpc                      pasemi_defconfig
powerpc                     redwood_defconfig
arm                  randconfig-c002-20220223
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                       lemote2f_defconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa300_defconfig
mips                      bmips_stb_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           mtx1_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220223
hexagon              randconfig-r045-20220223
s390                 randconfig-r044-20220223
riscv                randconfig-r042-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

