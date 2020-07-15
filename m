Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF0C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 03:08:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380B920663
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 03:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K90EAksE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380B920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z5AOpvFO0CM07Dek8JgYuxviLUjIt3+SS4hNCPL+rPU=; b=K90EAksEb26sWCEN2gXPZRuVJT
	6cfImanFYcaNWW2Rjswom0QwqkTDNM9bplYivIf3fzwggxJfhqRWAnT6ZDoKnfOaqgq+Lygkr3BeT
	+41u61TeBo3WDh1Ku88dooa5HkAUNZEFvJm5etyCefy+ZSE1w5HBMRsC/RLBnj2/tphNcF2kw1f2S
	4Hy3og0vi5fnLuf+NYZTfpA2wzmFu9Jl7EqdDVon4ST6bK4KTKq20P5wv0WVfxYEzE5SxWF2AVtan
	baKR55Grq3cZg9CbO565t5LNt5uOp3mBcbxv2hxRciY9URzSO9Z0liio4osbKV7D/5daY/Bs6o9KP
	j3plwZkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvXma-00056H-PI; Wed, 15 Jul 2020 03:08:32 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvXmX-00054s-2r
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 03:08:30 +0000
IronPort-SDR: UwoTZZ1Ws1Yv9GKfGTPxeV0mjq3XHbcQza162/Ws0P/xRnlpmP5PowgMb2i/SyvzI1ZCyNyOOV
 /03S08LMIDoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="136528086"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="136528086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 20:08:24 -0700
IronPort-SDR: yrrc5w+tRNHajFGmBOAQ7uz5MssGLmvviJ+Hf2Ti40WO+QspqeQpT3NB/njr9rK/XtsOiLFUlN
 OfZyFswTnanw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="281948289"
Received: from lkp-server01.sh.intel.com (HELO e1edd1aee32c) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 14 Jul 2020 20:08:23 -0700
Received: from kbuild by e1edd1aee32c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jvXmQ-00001o-PA; Wed, 15 Jul 2020 03:08:22 +0000
Date: Wed, 15 Jul 2020 11:08:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 375a227e31c04360750cc0f2968975472a03c731
Message-ID: <5f0e7320.A21aQ7V3yD09MRu3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_230829_272601_9CF2FC55 
X-CRM114-Status: UNSURE (   8.92  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: 375a227e31c04360750cc0f2968975472a03c731  nvmet-rdma: use new shared CQ mechanism

elapsed time: 947m

configs tested: 114
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arm                          tango4_defconfig
sh                            migor_defconfig
arm                         s3c6400_defconfig
m68k                         amcore_defconfig
c6x                               allnoconfig
i386                             allyesconfig
xtensa                generic_kc705_defconfig
mips                           ip27_defconfig
mips                  mips_paravirt_defconfig
c6x                        evmc6474_defconfig
powerpc                      pasemi_defconfig
sh                        dreamcast_defconfig
arm                          moxart_defconfig
sparc                               defconfig
mips                        maltaup_defconfig
mips                          rb532_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
arm                             pxa_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200714
i386                 randconfig-a005-20200714
i386                 randconfig-a002-20200714
i386                 randconfig-a006-20200714
i386                 randconfig-a003-20200714
i386                 randconfig-a004-20200714
i386                 randconfig-a016-20200714
i386                 randconfig-a011-20200714
i386                 randconfig-a015-20200714
i386                 randconfig-a012-20200714
i386                 randconfig-a013-20200714
i386                 randconfig-a014-20200714
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
