Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3736DC4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Dec 2023 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dSVz+sbsbtqEekWSrVUyGxSX8wuPK8LA6/TvFAZCZ/c=; b=S1NccmlzGHGkCeNpWaiL/j8vPi
	plPE6KBq+Zs/tkV5iLoOuRhQ9XgCrjy+ZOMIjl62Brsc/qr75Oo7oD2m2ECNDr1GXkNsX2p6XLGPl
	PT7ZW2mosXgubCOIaQTBeyvpI4kx2hrYksEOsAMWyIgQziq2QK9hFZPL4aU1fh8zXcmOJ6mvmmVCJ
	OWnefiy5t2MhoJGrja18CVsHSO6P8PxU/xCbSozI5fVJq3KoWIafN1uoGmwZlt2MXpPBKjvecEp3i
	wfIftj8/zqdF1Zr+nDCXsi9KvCO7/xEb22bVlfN9G2Kx39OXmIgIAMVZmHtOjUb4tmge4XoOne+Bd
	XbrE2r0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r971M-00EI2O-2Y;
	Fri, 01 Dec 2023 17:09:44 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r971I-00EI1r-01
	for linux-nvme@lists.infradead.org;
	Fri, 01 Dec 2023 17:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701450581; x=1732986581;
  h=date:from:to:cc:subject:message-id;
  bh=zC/Ke2ELh4iiFtPgx3mU7O0t2nL1RjD3R5h93JQhkD0=;
  b=hIwOelMzi21mWAXdNgBVN7Auj484jqz74TazijR20pcac+zkrtVC10DX
   nbSczem1lUZwxmJd2BG9dvgbEIamd84rsAO11krI1uLOlh4WvHmoYDp8J
   8R5yWiVu1XzFvsPF08zrdAWuPmYPQg+dj8PPq3SPyg1S3hLLScVRXJ0Lg
   uCrT1r1847M7MTn86TQvEjM7h55HiZz5PJDslBzL9vwKsE7Md51K8/wJ+
   07jImNx+BCQrrMzAOSuzveuxZJAwIw1yG0frtr09j5ELHkQwiZtyn+lk7
   k30RiVe74xu9K79gOJ/NUiTJSArkqsAsgevo3SPuuyruYDA3aaZqtNLWc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="406390"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="406390"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017093101"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1017093101"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2023 09:08:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r96zo-00040S-20;
	Fri, 01 Dec 2023 17:08:08 +0000
Date: Sat, 02 Dec 2023 01:08:03 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 ec4c93c9af28fa10d70a694da5e8fc1312169051
Message-ID: <202312020100.ytrpVxqh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_090940_803643_CCADAACB 
X-CRM114-Status: UNSURE (   4.97  )
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
branch HEAD: ec4c93c9af28fa10d70a694da5e8fc1312169051  nvme-core: check for too small lba shift

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm-randconfig-002-20231201
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm64-randconfig-002-20231201
|   |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
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
|-- arm64-randconfig-003-20231201
|   |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
|   |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
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
|-- csky-randconfig-001-20231201
|   |-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- i386-buildonly-randconfig-003-20231201
|   `-- drivers-platform-x86-think-lmi.c:warning:s-directive-argument-is-null
|-- i386-randconfig-003-20231201
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-005-20231201
|   `-- drivers-platform-x86-think-lmi.c:warning:s-directive-argument-is-null
|-- i386-randconfig-006-20231201
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- loongarch-randconfig-002-20231201
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- nios2-randconfig-002-20231201
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- parisc-randconfig-001-20231201
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-randconfig-002-20231201
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- powerpc-randconfig-002-20231201
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- powerpc64-randconfig-001-20231201
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- powerpc64-randconfig-002-20231201
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- s390-allmodconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- sh-randconfig-001-20231201
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- sparc-allmodconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc64-allmodconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc64-allyesconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- x86_64-defconfig
|   `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
`-- x86_64-randconfig-161-20231201
    `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack

elapsed time: 1465m

configs tested: 204
configs skipped: 2

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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231201   gcc  
arc                   randconfig-002-20231201   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                        neponset_defconfig   clang
arm                   randconfig-001-20231201   gcc  
arm                   randconfig-002-20231201   gcc  
arm                   randconfig-003-20231201   gcc  
arm                   randconfig-004-20231201   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231201   gcc  
arm64                 randconfig-002-20231201   gcc  
arm64                 randconfig-003-20231201   gcc  
arm64                 randconfig-004-20231201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231201   gcc  
csky                  randconfig-002-20231201   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231201   clang
hexagon               randconfig-002-20231201   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231201   gcc  
i386         buildonly-randconfig-002-20231201   gcc  
i386         buildonly-randconfig-003-20231201   gcc  
i386         buildonly-randconfig-004-20231201   gcc  
i386         buildonly-randconfig-005-20231201   gcc  
i386         buildonly-randconfig-006-20231201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231201   gcc  
i386                  randconfig-002-20231201   gcc  
i386                  randconfig-003-20231201   gcc  
i386                  randconfig-004-20231201   gcc  
i386                  randconfig-005-20231201   gcc  
i386                  randconfig-006-20231201   gcc  
i386                  randconfig-011-20231201   clang
i386                  randconfig-012-20231201   clang
i386                  randconfig-013-20231201   clang
i386                  randconfig-014-20231201   clang
i386                  randconfig-015-20231201   clang
i386                  randconfig-016-20231201   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231201   gcc  
loongarch             randconfig-002-20231201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231201   gcc  
nios2                 randconfig-002-20231201   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231201   gcc  
parisc                randconfig-002-20231201   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20231201   gcc  
powerpc               randconfig-002-20231201   gcc  
powerpc               randconfig-003-20231201   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231201   gcc  
powerpc64             randconfig-002-20231201   gcc  
powerpc64             randconfig-003-20231201   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231201   gcc  
riscv                 randconfig-002-20231201   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231201   clang
s390                  randconfig-002-20231201   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231201   gcc  
sh                    randconfig-002-20231201   gcc  
sh                          rsk7201_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231201   gcc  
sparc64               randconfig-002-20231201   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231201   gcc  
um                    randconfig-002-20231201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231201   gcc  
x86_64       buildonly-randconfig-002-20231201   gcc  
x86_64       buildonly-randconfig-003-20231201   gcc  
x86_64       buildonly-randconfig-004-20231201   gcc  
x86_64       buildonly-randconfig-005-20231201   gcc  
x86_64       buildonly-randconfig-006-20231201   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231201   gcc  
x86_64                randconfig-012-20231201   gcc  
x86_64                randconfig-013-20231201   gcc  
x86_64                randconfig-014-20231201   gcc  
x86_64                randconfig-015-20231201   gcc  
x86_64                randconfig-016-20231201   gcc  
x86_64                randconfig-071-20231201   gcc  
x86_64                randconfig-072-20231201   gcc  
x86_64                randconfig-073-20231201   gcc  
x86_64                randconfig-074-20231201   gcc  
x86_64                randconfig-075-20231201   gcc  
x86_64                randconfig-076-20231201   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231201   gcc  
xtensa                randconfig-002-20231201   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

