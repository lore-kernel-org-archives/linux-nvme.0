Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA14C433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Oct 2022 04:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6WYj/EeZ0CtnpUUJBXkemdXTNcgS1r3/7G/Bl+0qgM0=; b=F81VNk5oOyu+58j4Tkya2m6F3Y
	QiX0dQctvzCG8fS1c4vep7nArnlOWgZ4CdGLmTjXQ1wiWCh0MZIcQCpZUAB0UuWJsJQt/TJ6AyQvQ
	jmkHgCZVUiGMz9W96tBKX1bbGL+ynooGG1M2qPGiRw6c9S9WuEIxrJBTR/7Vu/S7NmE0Cu4lazeQS
	47ilk0/becR9ZlmN6hX1ZRtWghvbYUEtxLXPdFBqQo6Xjd+hZ6WQGfA0BoktiRzcSW/+UGC2y4ZOq
	psXxSD7NFmCjuHqHV4WfFzTpXXkbc+O+uIb2fENT7vVLJbAxLYRAogJ8TKAHksws/JitExIxwzkD6
	L62vrSzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeU2H-00D4wP-2Q; Sat, 01 Oct 2022 04:23:33 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeU2E-00D4vb-Gd; Sat, 01 Oct 2022 04:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664598210; x=1696134210;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RoWMV6YlQ3RZj1k+vWM5yUhCoz+P5pH/wqRjGcxHHpc=;
  b=WiV5M+Gc1zpXBj5w35W0zTZVaL4TjoLNIBkQd+2rq84sUAFEQ8WlsNf3
   g9he0jXV50yI+SuqaMcSxsiurQ7OgrrO2Ub7eBFp0/1cAQEyVzQkojd1K
   3q4EuGhPDTKJoeDJlMHOKbpw9MQKpng8JE7PyKljxnpBZUrP3etsl17ep
   SXP3eJlByVtHgeVyyS5TBi7jAj3uene6cbM+3wIOUpkHgKGsXdzQLQbcj
   xfhNA4Z2fa+4vy7TRHj47C/ABKKgNYAdLT3fHibQpTmL4JX28x2NUW1HW
   o6es6q/i9vVbR+Peh5Y6ws5yR5q2fU66SmtN+6sHIE8fZkjok/mDxwAUG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328724899"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="328724899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 21:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="656176205"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="656176205"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 21:23:14 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oeU1x-0001ql-2w;
	Sat, 01 Oct 2022 04:23:13 +0000
Date: Sat, 01 Oct 2022 12:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 274d7803837da78dfc911bcda0d593412676fc20
Message-ID: <6337c081.sOjlKX7TNksVmkN4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_212330_601211_679913E4 
X-CRM114-Status: UNSURE (   9.14  )
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
branch HEAD: 274d7803837da78dfc911bcda0d593412676fc20  Add linux-next specific files for 20220930

Error/Warning reports:

https://lore.kernel.org/linux-mm/202209150141.WgbAKqmX-lkp@intel.com
https://lore.kernel.org/linux-mm/202210010718.2kaVANGb-lkp@intel.com
https://lore.kernel.org/llvm/202209220019.Yr2VuXhg-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/clk/xilinx/clk-xlnx-clock-wizard.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
depmod: ERROR: Cycle detected: nf_conntrack -> nf_nat -> nf_conntrack
depmod: ERROR: Found 2 modules in dependency cycles!
drivers/nvme/target/loop.c:623 nvme_loop_create_ctrl() warn: 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535 'ctrl->ctrl.sqsize'
drivers/tty/serial/atmel_serial.c:2127: undefined reference to `__clk_is_enabled'
pahole: .tmp_vmlinux.btf: No such file or directory

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- arm64-randconfig-r003-20220928
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- arm64-randconfig-r035-20220926
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- parisc-randconfig-m031-20220925
|   `-- drivers-nvme-target-loop.c-nvme_loop_create_ctrl()-warn:opts-queue_size-can-t-fit-into-ctrl-ctrl.sqsize
|-- parisc-randconfig-r002-20220925
|   |-- drivers-tty-serial-atmel_serial.c:undefined-reference-to-__clk_is_enabled
|   `-- pahole:.tmp_vmlinux.btf:No-such-file-or-directory
|-- s390-allmodconfig
|   |-- ERROR:devm_ioremap_resource-drivers-dma-fsl-edma.ko-undefined
|   |-- ERROR:devm_ioremap_resource-drivers-dma-idma64.ko-undefined
|   |-- ERROR:devm_ioremap_resource-drivers-dma-qcom-hdma.ko-undefined
|   |-- ERROR:devm_memremap-drivers-misc-open-dice.ko-undefined
|   |-- ERROR:devm_memunmap-drivers-misc-open-dice.ko-undefined
|   |-- ERROR:devm_platform_ioremap_resource-drivers-char-xillybus-xillybus_of.ko-undefined
|   |-- ERROR:devm_platform_ioremap_resource-drivers-clk-xilinx-clk-xlnx-clock-wizard.ko-undefined
|   |-- ERROR:ioremap-drivers-tty-ipwireless-ipwireless.ko-undefined
|   |-- ERROR:iounmap-drivers-net-ethernet-pcnet_cs.ko-undefined
|   `-- ERROR:iounmap-drivers-tty-ipwireless-ipwireless.ko-undefined
`-- x86_64-rhel-8.3-kselftests
    |-- depmod:ERROR:Cycle-detected:nf_conntrack-nf_nat-nf_conntrack
    `-- depmod:ERROR:Found-modules-in-dependency-cycles
clang_recent_errors
|-- hexagon-randconfig-r041-20220925
|   `-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|-- hexagon-randconfig-r041-20220926
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt2701.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(uns
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(uns
|   `-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|-- hexagon-randconfig-r045-20220926
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   `-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8183.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|-- powerpc-mpc832x_rdb_defconfig
|   |-- arch-powerpc-math-emu-fcmpu.c:error:variable-A_c-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- arch-powerpc-math-emu-fcmpu.c:error:variable-B_c-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- arch-powerpc-math-emu-fcmpu.c:error:variable-_fex-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- arch-powerpc-math-emu-fctiw.c:error:variable-_fex-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- arch-powerpc-math-emu-fctiwz.c:error:variable-_fex-set-but-not-used-Werror-Wunused-but-set-variable
|   `-- arch-powerpc-math-emu-fsel.c:error:variable-_fex-set-but-not-used-Werror-Wunused-but-set-variable
|-- s390-randconfig-r023-20220926
|   |-- manage.c:(.text):undefined-reference-to-__tsan_memcpy
|   |-- s39-linux-ld:affinity.c:(.text):undefined-reference-to-__tsan_memcpy
|   |-- s39-linux-ld:topology.c:(.text):undefined-reference-to-__tsan_memcpy
|   `-- workqueue.c:(.init.text):undefined-reference-to-__tsan_memcpy
|-- s390-randconfig-r044-20220926
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-virtual-virtual_link_hwss.c:warning:no-previous-prototype-for-function-virtual_disable_link_output
`-- x86_64-rhel-8.3-rust
    |-- ld.lld:error:undefined-symbol:__rust_alloc
    |-- ld.lld:error:undefined-symbol:__rust_dealloc
    |-- ld.lld:error:undefined-symbol:__rust_realloc
    |-- ld.lld:error:undefined-symbol:bool-as-core::fmt::Display::fmt
    |-- ld.lld:error:undefined-symbol:core::fmt::Formatter::debug_list
    |-- ld.lld:error:undefined-symbol:core::fmt::Formatter::debug_lower_hex
    |-- ld.lld:error:undefined-symbol:core::fmt::Formatter::debug_upper_hex
    |-- ld.lld:error:undefined-symbol:core::fmt::builders::DebugList::entry
    |-- ld.lld:error:undefined-symbol:core::fmt::builders::DebugList::finish
    |-- ld.lld:error:undefined-symbol:core::panicking::panic
    |-- ld.lld:error:undefined-symbol:i32-as-core::fmt::Display::fmt
    |-- ld.lld:error:undefined-symbol:i32-as-core::fmt::LowerHex::fmt
    |-- ld.lld:error:undefined-symbol:i32-as-core::fmt::UpperHex::fmt
    |-- ld.lld:error:undefined-symbol:kernel::error::Error-as-core::convert::From-alloc::collections::TryReserveError::from
    |-- ld.lld:error:undefined-symbol:kernel::error::Error::to_kernel_errno
    |-- ld.lld:error:undefined-symbol:kernel::print::call_printk
    |-- ld.lld:error:undefined-symbol:kernel::print::format_strings::INFO
    `-- ld.lld:error:undefined-symbol:rust_fmt_argument

elapsed time: 732m

configs tested: 64
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
i386                                defconfig
s390                                defconfig
i386                 randconfig-a001-20220926
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64               randconfig-a002-20220926
powerpc                          allmodconfig
i386                 randconfig-a004-20220926
arm                                 defconfig
sh                               allmodconfig
i386                 randconfig-a006-20220926
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a005-20220926
x86_64               randconfig-a004-20220926
mips                             allyesconfig
i386                 randconfig-a002-20220926
arc                  randconfig-r043-20220925
i386                 randconfig-a003-20220926
x86_64               randconfig-a006-20220926
i386                 randconfig-a005-20220926
powerpc                           allnoconfig
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64                           allyesconfig
riscv                randconfig-r042-20220925
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
i386                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
x86_64               randconfig-a012-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a012-20220926
x86_64               randconfig-a013-20220926
hexagon              randconfig-r045-20220925
i386                 randconfig-a015-20220926
x86_64               randconfig-a011-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r041-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a016-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

