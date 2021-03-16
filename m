Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 19:30:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E16F64F07
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 19:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E16F64F07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qGe8IHzEFiqAgamqguYnJfxCXRhepB9C3Py9hwSynFg=; b=fdJcm4fGLaX75DZ+WUMsuYVLZu
	GPEuA0Ia4Rqa4hxqipPNoZSRI13p7Y3/Hnnqb2vlAn4s0BCDQ+X13K1Fzqsl/NeO2/d9nBPLBTxKu
	FwiUFcmumTkwphelcYqG1qJfO/p02B1HkRZLHm07pEOu0ArfdwZbSjNkcJeT6MgDcDOi+To1iHm6b
	cNmVG/zGbIE6XruNnJcweRbrSBQcmfn60Qquri5PzoB03pPpwxiZ9mt7TCtRQc8znvbVmfT8rPg8Q
	PsbmC21jTlK21oAjDJ4nP71YiQPLFYxtalbw7qafP+gJlOMT4996RDRs2ylia4mnF1rHe6eUIB3n2
	9S58hrWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMFOA-001ioy-N6; Tue, 16 Mar 2021 19:29:58 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMFO5-001ioN-ID
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 19:29:56 +0000
IronPort-SDR: e6jVxRRVZX7TNZQrIKTJkJRGYjnRjivF90UTw2tCq96BpUbIVo0f+GnJXbdToM8eFW2G3mbbK0
 SMxig4/wCyzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="253338356"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="253338356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2021 12:29:47 -0700
IronPort-SDR: fJQaGyY20soGBY4s/85GdzM5/rhRfUrPn9sE5bbFo8svP3b7rZJwyjeTVTA8AUDKpbifuvQKBo
 l4dm38JXqVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; d="scan'208";a="373891268"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 16 Mar 2021 12:29:46 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lMFNx-0000H1-Cg; Tue, 16 Mar 2021 19:29:45 +0000
Date: Wed, 17 Mar 2021 03:29:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 b09953580352fcb01ee8d47c68d2d3750ef92286
Message-ID: <60510722.uB5KC7F6JYoLFmFO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_192954_636035_5E64E59F 
X-CRM114-Status: UNSURE (   5.43  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.12
branch HEAD: b09953580352fcb01ee8d47c68d2d3750ef92286  nvme: fix Write Zeroes limitations

elapsed time: 722m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip27_defconfig
powerpc                      arches_defconfig
sh                           se7343_defconfig
powerpc                     tqm8541_defconfig
arm                     eseries_pxa_defconfig
m68k                            q40_defconfig
m68k                        m5407c3_defconfig
mips                             allmodconfig
arm                           sama5_defconfig
s390                             alldefconfig
powerpc                     skiroot_defconfig
arm                         mv78xx0_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
powerpc                     tqm8540_defconfig
arm                         hackkit_defconfig
powerpc                     tqm5200_defconfig
powerpc                         wii_defconfig
arm                        trizeps4_defconfig
sh                          rsk7264_defconfig
arm                        shmobile_defconfig
powerpc64                           defconfig
ia64                        generic_defconfig
arm                            lart_defconfig
arm                         nhk8815_defconfig
mips                        workpad_defconfig
powerpc                      pasemi_defconfig
mips                      malta_kvm_defconfig
powerpc                     kilauea_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
xtensa                  audio_kc705_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
