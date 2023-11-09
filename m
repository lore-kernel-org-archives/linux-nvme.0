Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284B2C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7ERY3K1ZhY4BCHx2XQexxh4WolWTWsC8AMDX4Bm775U=; b=09nYnDO/1KotXQrRH/+B7lZupe
	5SBrut6mevLnwykaMtDjoaKwBugkT4vob8GE9CiUqD+ZdjDnk9Spbc06EUzq4T6dn8wNILDVcIJJc
	cCYqTgK+yb1GogJbgf56vkjwpzvpEaam3WhmJk8mT5bCpE19E7QwxNur7lQV/ZNYfLEo/UVpTZ+l4
	t41eNxPqd1e/9SrHOE0X0fpL+HYN6kN6JSbH4gslOb5WS1A4MttKpEI3OcKWbLQjjU3mdgLUFqMhx
	BLORUi3dGHcRhS4jlPoEirmLfyTCM7YGBRfVw7RgzCx7zaeqjdlJg9ntQSiLErKdbvAYMywRT/c7W
	DBgrnuHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r18so-006vek-2t;
	Thu, 09 Nov 2023 17:31:58 +0000
Received: from mgamail.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r18sl-006vd7-0j
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 17:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551115; x=1731087115;
  h=date:from:to:cc:subject:message-id;
  bh=WU8t1Wot+x9QmGvi+FhfciDXoXqYtvpINkMBAq+pfRg=;
  b=bphMV0NMp2aRdi/fE/Bq+vSZU4gLikXowmk8Ic6TTyJl8gh1TPaUyvvX
   +esinnRmb+hXN7vlxOdJ+UcS+Ook5NGzmRFWPEhlePBuEeDh8LTmjH+58
   kYC3TJgqxDm525l+iwjTo64KkklU4syxpV7h3gcERh8iZyfh4qg8FkC7P
   zFZmL0U0QteOtV3C1V2C3rA9Jp2KD6Xe60Oa0VQgD4By16avCU7hutIfz
   tcAXNAVhUVO1+0ByfYRUhIZSn3BpxlSVdFDt5UcEtifxK/Y1w9s1UqLJ+
   Z3of2D3J5ucJiiD/hQQFZaeRiHWhnUsWgI+jqOJJb10ognGKeV6nrTYYl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="392905573"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="392905573"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:31:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11606166"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Nov 2023 09:31:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r18sb-0008z0-2H;
	Thu, 09 Nov 2023 17:31:45 +0000
Date: Fri, 10 Nov 2023 01:27:41 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 706add13676da7ad213b65e92b94af5efc8c4131
Message-ID: <202311100139.ZFmEvPY8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_093155_325648_B8444D1B 
X-CRM114-Status: UNSURE (   6.11  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.7
branch HEAD: 706add13676da7ad213b65e92b94af5efc8c4131  nvme: keyring: fix conditional compilation

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allmodconfig
|   |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
|   |-- arch-arm64-kvm-pmu-emul.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-params-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-vgic-vgic-init.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-e-not-described-in-vgic_irqfd_set_irq
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-irq_source_id-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-kvm-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-line_status-not-described-in-kvm_set_msi
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-ite_esz-not-described-in-vgic_its_save_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_device_tables
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_save_collection_table
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-opaque-not-described-in-scan_its_table
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm64-allyesconfig
|   |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
|   |-- arch-arm64-kvm-pmu-emul.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-params-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-vgic-vgic-init.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-e-not-described-in-vgic_irqfd_set_irq
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-irq_source_id-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-kvm-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-line_status-not-described-in-kvm_set_msi
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-ite_esz-not-described-in-vgic_its_save_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_device_tables
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_save_collection_table
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-opaque-not-described-in-scan_its_table
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm64-defconfig
|   |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
|   |-- arch-arm64-kvm-pmu-emul.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_64
|   |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-params-not-described-in-kvm_handle_cp_32
|   |-- arch-arm64-kvm-vgic-vgic-init.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-e-not-described-in-vgic_irqfd_set_irq
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-irq_source_id-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-kvm-not-described-in-kvm_arch_set_irq_inatomic
|   |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-line_status-not-described-in-kvm_set_msi
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-ite_esz-not-described-in-vgic_its_save_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_device_tables
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_ite
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_save_collection_table
|   |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-opaque-not-described-in-scan_its_table
|   `-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead
|-- csky-allmodconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- csky-allyesconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc-allyesconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
`-- x86_64-defconfig
    `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size

elapsed time: 1484m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231109   gcc  
arc                   randconfig-002-20231109   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231109   gcc  
arm                   randconfig-002-20231109   gcc  
arm                   randconfig-003-20231109   gcc  
arm                   randconfig-004-20231109   gcc  
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231109   gcc  
arm64                 randconfig-002-20231109   gcc  
arm64                 randconfig-003-20231109   gcc  
arm64                 randconfig-004-20231109   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231109   gcc  
csky                  randconfig-002-20231109   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231109   gcc  
i386         buildonly-randconfig-002-20231109   gcc  
i386         buildonly-randconfig-003-20231109   gcc  
i386         buildonly-randconfig-004-20231109   gcc  
i386         buildonly-randconfig-005-20231109   gcc  
i386         buildonly-randconfig-006-20231109   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231109   gcc  
i386                  randconfig-002-20231109   gcc  
i386                  randconfig-003-20231109   gcc  
i386                  randconfig-004-20231109   gcc  
i386                  randconfig-005-20231109   gcc  
i386                  randconfig-006-20231109   gcc  
i386                  randconfig-011-20231109   gcc  
i386                  randconfig-012-20231109   gcc  
i386                  randconfig-013-20231109   gcc  
i386                  randconfig-014-20231109   gcc  
i386                  randconfig-015-20231109   gcc  
i386                  randconfig-016-20231109   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231109   gcc  
loongarch             randconfig-002-20231109   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231109   gcc  
nios2                 randconfig-002-20231109   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231109   gcc  
parisc                randconfig-002-20231109   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc               randconfig-001-20231109   gcc  
powerpc               randconfig-002-20231109   gcc  
powerpc               randconfig-003-20231109   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64             randconfig-001-20231109   gcc  
powerpc64             randconfig-002-20231109   gcc  
powerpc64             randconfig-003-20231109   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231109   gcc  
riscv                 randconfig-002-20231109   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231109   gcc  
s390                  randconfig-002-20231109   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20231109   gcc  
sh                    randconfig-002-20231109   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231109   gcc  
sparc                 randconfig-002-20231109   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231109   gcc  
sparc64               randconfig-002-20231109   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231109   gcc  
um                    randconfig-002-20231109   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231109   gcc  
x86_64       buildonly-randconfig-002-20231109   gcc  
x86_64       buildonly-randconfig-003-20231109   gcc  
x86_64       buildonly-randconfig-004-20231109   gcc  
x86_64       buildonly-randconfig-005-20231109   gcc  
x86_64       buildonly-randconfig-006-20231109   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231109   gcc  
x86_64                randconfig-002-20231109   gcc  
x86_64                randconfig-003-20231109   gcc  
x86_64                randconfig-004-20231109   gcc  
x86_64                randconfig-005-20231109   gcc  
x86_64                randconfig-006-20231109   gcc  
x86_64                randconfig-011-20231109   gcc  
x86_64                randconfig-012-20231109   gcc  
x86_64                randconfig-013-20231109   gcc  
x86_64                randconfig-014-20231109   gcc  
x86_64                randconfig-015-20231109   gcc  
x86_64                randconfig-016-20231109   gcc  
x86_64                randconfig-071-20231109   gcc  
x86_64                randconfig-072-20231109   gcc  
x86_64                randconfig-073-20231109   gcc  
x86_64                randconfig-074-20231109   gcc  
x86_64                randconfig-075-20231109   gcc  
x86_64                randconfig-076-20231109   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231109   gcc  
xtensa                randconfig-002-20231109   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

