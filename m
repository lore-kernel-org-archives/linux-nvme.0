Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15DDFA373D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LjjPi7cJ9F5nKm/R2773oovFGMSEo4C2+8ScBtsMdKI=; b=nOUziBwqX1cFx0BWdG3yhuvMN/
	f6/OIO775IfxxPrOJlkHp1rCgb4bP4tEivSgNhT6x2IZmUQ6wL/o3JwpMBwW03d0f4vvGHzd8IaXz
	Rd3YuSl27Q4bo81sIZFFsIy3Wr/P9GV4D0JkM1/PEU//pC16RPEVIFGU4i17Vc2WFtyFECcezNGU/
	+Y6VJR46+ZCvLbDsUSgZ227ema/6adW4FhR3m4fPyQdKJ7jWA815XR3Bg/5Qdhp9jgWV6TXblVdU1
	IDQ4UUxsxAASXPQeRcyslx0KxH9yXXg0xbz15bpjvOqhwr+fKLh2uENjpFMRFOGupxyll4Y71EVhJ
	3UglJSBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olvpE-009Boj-Lp; Fri, 21 Oct 2022 17:28:52 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olvpB-009Bn3-H9; Fri, 21 Oct 2022 17:28:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666373329; x=1697909329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T59+PZTDZVjX23bCRMZbnZTbnIa553TW4Fq8YgsjUbw=;
  b=SviI9KbevYvKPZY40XB3ZIcwkxAFYuQIvcqoRwifi7r0NLe+TFw/crJ7
   i0O6ti6IUfNPsRGWt9Ya0cot+PR5TnZFmoH49h+C899s343XZIFCfv9vk
   E99zV1w5FIpkybEcvR0Iax6EEhVwaMxpxaxyzADUkvnMsw6wD2JiKXefS
   xJ02v6tBo67gVHIsf3AIpEBZFsBJldsaMkI/B2JIoq2fvkExOuNTJB/wJ
   m5aS8RScZk8DOjTC/dljUTmNbbAUcsGyjya7cAdhhW4CrLSsHZ+TGgAc5
   +AAvHFtfmLXaQC5h7axeOrOrexeN425FmUamyAh1xIgB29aLgcafUb5/s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287461741"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="287461741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="630582750"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="630582750"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 10:28:44 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1olvp6-0002om-0R;
	Fri, 21 Oct 2022 17:28:44 +0000
Date: Sat, 22 Oct 2022 01:28:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ntfs3@lists.linux.dev, linux-wireless@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 4d48f589d294ddc5e01d3b0dc7cecc55324c05ca
Message-ID: <6352d6b9.grpYcP/v5reTKJou%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_102849_627806_7DF1B6EE 
X-CRM114-Status: UNSURE (   6.51  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4d48f589d294ddc5e01d3b0dc7cecc55324c05ca  Add linux-next specific files for 20221021

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210090954.pTR6m6rj-lkp@intel.com
https://lore.kernel.org/linux-mm/202210110857.9s0tXVNn-lkp@intel.com
https://lore.kernel.org/llvm/202210211531.zEaM6hBM-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/nvme/target/loop.c:578 nvme_loop_create_ctrl() warn: 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535 'ctrl->ctrl.sqsize'
fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]
fs/ntfs3/namei.c:487 ntfs_d_compare() error: uninitialized symbol 'uni1'.
vcpu.c:(.text+0xa3c): undefined reference to `riscv_cbom_block_size'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a003
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a005
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a012
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a014
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a016
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- riscv-randconfig-m031-20221019
|   |-- drivers-nvme-target-loop.c-nvme_loop_create_ctrl()-warn:opts-queue_size-can-t-fit-into-ctrl-ctrl.sqsize
|   |-- fs-ntfs3-namei.c-ntfs_d_compare()-error:uninitialized-symbol-uni1-.
|   `-- vcpu.c:(.text):undefined-reference-to-riscv_cbom_block_size
|-- x86_64-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a002
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a006
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a011
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a015
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-m001
|   `-- arch-x86-kernel-apic-apic.c-generic_processor_info()-warn:always-true-condition-(num_processors-()-)-(-u32max-)
|-- x86_64-rhel-8.3
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kunit
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kvm
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
`-- x86_64-rhel-8.3-syz
    `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
clang_recent_errors
|-- arm-colibri_pxa300_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- hexagon-randconfig-r041-20221019
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-randconfig-r045-20221019
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt2701.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(uns
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(uns
|   `-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|-- i386-allyesconfig
|   `-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_8188f.c:warning:variable-hw_ctrl_s1-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-a002
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a004
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a011
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a013
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- i386-randconfig-a015
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- s390-buildonly-randconfig-r006-20221019
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- s390-randconfig-r044-20221019
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- x86_64-randconfig-a005
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a012
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a014
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-rhel-8.3-rust
    `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg

elapsed time: 727m

configs tested: 63
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                              defconfig
i386                                defconfig
mips                             allyesconfig
sh                               allmodconfig
arc                                 defconfig
arc                  randconfig-r043-20221019
x86_64                               rhel-8.3
x86_64                        randconfig-a013
alpha                               defconfig
x86_64                        randconfig-a011
i386                          randconfig-a001
s390                             allmodconfig
i386                          randconfig-a003
alpha                            allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
m68k                             allmodconfig
arm                                 defconfig
s390                                defconfig
i386                          randconfig-a005
i386                             allyesconfig
s390                             allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
ia64                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-a016
i386                          randconfig-a002
s390                 randconfig-r044-20221019
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

