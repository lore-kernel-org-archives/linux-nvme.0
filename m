Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B3C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 03:10:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB414611C9
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 03:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB414611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=odrC9KunwXnzJpRatcEtJMP7wGk+rqEfUCIRmxh++to=; b=hl9mwtFVRV+1acXgyfofcu1ujl
	Wk0QAQb7JncrI5yRpKpPZ78pO7HbYbJLZEFDcWczJfc/lm27OGDnuoYEoHCa5Ydq3y1EA5O+a8JX8
	ltE9rT0q6i8snHR0DnkRZioLx7HEw4XSFK57faUCoEqzVhcz05CNHfGUIIdyOlQKt2RWMWq4ebO4V
	+44YAwyD9CuGGwPxZJNOo5qXr66dTbDclt1I2TMCNs0ygfQrZPlhSL7Mj8a6jBHZzinBUPRzRlNpJ
	8n4wo+wnCF/fFzWkshNW75jzZ5ZcoturUVQp0qHJLcqAITeJE0rFFTD+YkOdEXe32AcJ/twbw6oOM
	q0mc09BA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhOD3-00723b-H2; Fri, 14 May 2021 03:09:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhOD0-00723C-3n
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 03:09:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=0rLwEydB4vNF0Ely42u1n8T6U8wD3t61ju3fHowAMH8=; b=zc6ALFGURg/bjG5ix2joLG5Thb
 bg1PEVThsvJfzwpmAebqryFVToyGnbelDc5iyXWvkG/EJIwR6GTZGMznQ5up/v4mrUlVegXYY6jWO
 4RjvnZrFQ6q5CUUaEmKPjOryehagj5IyuADu0remA9WC9hMKZNWKZzJ6enqtgc6btaCo1ME4pKlHg
 ehH0PHuQgR4pSaDJqoKI2JiwHSYYT++47M9cS6XjmZauEB+kCBY+W4uEgm8TtXqvu9B+dDUBsXUo3
 EGYjRG9sJrAkT1va+TmLtJEJpkGIzf7FDI7y8s9qqF4a3i9l6hH1RSFroq/uVXutuov7GGF5/r2w0
 I8B6ezJQ==;
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhOCt-00Bg9K-HN
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 03:09:46 +0000
IronPort-SDR: LGzmDDprJFHE7NlH98YK6H6THM+fGQ10oJCni3ikzVV8jzkJUdehV8u4MTUS5UiVNv32dNh9SD
 wTSgzxWD+K/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200155720"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; d="scan'208";a="200155720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 20:09:37 -0700
IronPort-SDR: SkA2MrU0a7VE5zY7nchEpSOwVChTaybeFDMDwG0EynTlzaPdYBiW2da3+TLfruc4LubDhYqWAU
 hKAgQyBBs4dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; d="scan'208";a="409853536"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 13 May 2021 20:09:36 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lhOCl-0000Xl-NW; Fri, 14 May 2021 03:09:35 +0000
Date: Fri, 14 May 2021 11:08:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS WITH WARNING
 e181811bd04d874fe48bbfa1165a82068b58144d
Message-ID: <609de9c3.vLLIooV9KyW0G08z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_200945_243212_EF3840E4 
X-CRM114-Status: UNSURE (   7.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.13
branch HEAD: e181811bd04d874fe48bbfa1165a82068b58144d  nvmet: use new ana_log_size instead the old one

possible Warning in current branch:

drivers/nvme/host/multipath.c:815 nvme_mpath_init_identify() warn: missing error code 'error'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20210513
    `-- drivers-nvme-host-multipath.c-nvme_mpath_init_identify()-warn:missing-error-code-error

elapsed time: 722m

configs tested: 128
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
powerpc                 linkstation_defconfig
mips                malta_qemu_32r6_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc836x_mds_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
arm                       mainstone_defconfig
arc                              allyesconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
riscv                    nommu_k210_defconfig
powerpc                   lite5200b_defconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
sh                          landisk_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
sh                           sh2007_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
arc                                 defconfig
m68k                           sun3_defconfig
arc                          axs101_defconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
xtensa                  nommu_kc705_defconfig
h8300                       h8s-sim_defconfig
riscv                            alldefconfig
powerpc                     ksi8560_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
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
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a006-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
