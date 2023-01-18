Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD13BC32793
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gRrH5EBAXYskyC/YoPa2XyoC1FuHCkPZ+Y79x3IhwIo=; b=ClNCNkObHeEC2MJL5vtooHSgH5
	+3oWuDmKoSbSwscn+3pKhDGdBEPam1ZsnN9wZvl6qyUB8yr6aYWqW55VOLXrE6v7hclBqf7Zkpb/9
	aZR0oUx1wgOzlxfy/KBBwSkQWKuUyH15Wmlqswjb/bgkLVZnheyilWZsmj3a8B6uZEMibqmFtNHtw
	DRKxp4RBSdOjWrNr9mQs/bCzAKxq93JJ1k5onPx2MQIg/lCmmzrtM22IAI6KKAFs2Omzt1xQvdt3C
	R8qaraj5kEjNyt09SBFwWoW1AEhoNnufbIREWNyw47t+yo7hbjIxyPcKUB9iALOG1YVUeRSAikeKk
	7c1BZkrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIElK-002aW4-2r; Wed, 18 Jan 2023 20:10:22 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIElG-002aVb-PT
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 20:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674072618; x=1705608618;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/ubkFEY2P+5H4YkSxw5JPMEgGiTksv3wUO5A81ZK2sk=;
  b=mjw4XU6/MbSgrJI5deldPOjhqQPXWWdxeCsYyimlwy30kz3VLu3p23c2
   qBTKCdn6V8Wc/3lFLbPQCq0ozFiyhhTdW26ee3FjfkXB5h1/cpn0B2oD1
   MoD09hIfnUHwqj+U0ifZbOoWc/HdrGjWrdNTW8UKFuGgJaZs4oe+PaO75
   CkE5JJnXqA9GkpcLRHZ37cAgupJ6biEaXi6CGQkzAj1MeZ4hOBt+u/vDd
   bCaAzKvCyutLiPaR1PPr/Q1PMYA9uAVmVmGKggpA3F2a5KtZfKxjSh8i0
   6Ex1T1UPVqsUZhc857wlHZbMW3igWJ0d+t4Fd00FF1Pu1mehRhBcjvnqs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="326352604"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="326352604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692144508"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="692144508"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2023 12:10:13 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pIElA-0000g0-07;
	Wed, 18 Jan 2023 20:10:12 +0000
Date: Thu, 19 Jan 2023 04:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 b05ca78ac5843630cab41acd85809d3b63179d5a
Message-ID: <63c85203.GSBlUinCo2gs0t8X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_121018_944077_904AB10A 
X-CRM114-Status: UNSURE (   9.10  )
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
branch HEAD: b05ca78ac5843630cab41acd85809d3b63179d5a  nvme-apple: only reset the controller when RTKit is running

elapsed time: 730m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a011-20230116
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
i386                          randconfig-c001
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                            q40_defconfig
powerpc                     taishan_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      maltasmvp_defconfig
powerpc                       eiger_defconfig
arc                     nsimosci_hs_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
mips                       bmips_be_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                        mvebu_v5_defconfig
mips                      malta_kvm_defconfig
arm                      tct_hammer_defconfig
arm                       spear13xx_defconfig
mips                     loongson2k_defconfig
mips                  cavium_octeon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                          ath25_defconfig
powerpc                     ppa8548_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                          rm200_defconfig
powerpc                     skiroot_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

