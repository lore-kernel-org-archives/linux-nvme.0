Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E46C61D99
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPzQmGSGUwH3i0bz3aB2kj8/nUeoL091+S0W4ImfvV4=; b=06cDNmGu7bhIHEJS4CqFHVIanq
	pzLhTgWoVan+aD/h0b+zOTHD7ypCjqk0Ttc1X88TGJ97uY0iWNb7KSmhN/YoohsFa9U++li+rOXW6
	cgYcBxHGPZImKRteGLdVgahPNn24dE+KlRtgPN8kYafGMyjj8fok2peL9K5A0oDjZenqcU+rsM4z/
	SoZgGFVJJInidkANGDZEBy1Npa+upbWGYfANYjyuDY/RQJt0yLoq8liBmFp2yFKzXe4AW1J/9DJy9
	5taFxMUEupLKzk6Nsezi88tOEQBZeljoVBmvlzsJj5j2qNeR+EVQm9O+k2Hp6UiANDHUDFCH+kCq3
	fazOnyqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5psn-002PLN-3B;
	Wed, 22 Nov 2023 16:15:22 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5psj-002PK0-2k
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 16:15:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700669717; x=1732205717;
  h=date:from:to:cc:subject:message-id;
  bh=bjwCSJUuYMf1uI/x0rtJ0RfXr4vw4EEClBebBaHcl/k=;
  b=k45mAnUzK3Am02kFIPccKzIoi5IZS4fsm5KoN2HBM8xZvdCb1jWxxusb
   jy95B5KGywI65FT5zofCemYNzbYjwlGESFmfyr/cyWF5/sd0pNrLz4HfK
   11zK0rvTEzLcnZVBALk8NMeQnhr3dA8f4b7PeQ9cTK6J7iDdgdB/WrPpd
   n+ioHRcNRYOBo/+p4zPkrPQ2S5VZZ/RwlSdK/EgUVJrezzWuJYNFAIQpe
   j2UVXxh1+lvkJdN0tYILyys7Opbodad3SlxJTjOF4j1YmyjSXBmNvRqiX
   zZ2yIKDCtHs/TlUPx9TT/Wb2aAXt2afCXQR3oQdn7hd9Id+jp/NV20zYh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458582902"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="458582902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 08:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="910869027"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="910869027"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 08:14:41 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5ps6-0000fY-31;
	Wed, 22 Nov 2023 16:14:38 +0000
Date: Thu, 23 Nov 2023 00:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 11b9d0b4999705105d1fb7f0e8ac969e0f41b1b8
Message-ID: <202311230053.NjwjTpbA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_081518_118397_AED4981F 
X-CRM114-Status: UNSURE (   6.54  )
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
branch HEAD: 11b9d0b4999705105d1fb7f0e8ac969e0f41b1b8  nvmet-tcp: always initialize tls_handshake_tmo_work

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allyesconfig
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
|-- openrisc-allmodconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- openrisc-allyesconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-allmodconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- riscv-allmodconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- riscv-allyesconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
`-- x86_64-defconfig
    `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
clang_recent_errors
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
|   `-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead
`-- arm64-allyesconfig
    |-- arch-arm64-kvm-debug.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
    |-- arch-arm64-kvm-guest.c:warning:Excess-function-parameter-kvm_guest_debug-description-in-kvm_arch_vcpu_ioctl_set_guest_debug
    |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-dbg-not-described-in-kvm_arch_vcpu_ioctl_set_guest_debug
    |-- arch-arm64-kvm-guest.c:warning:Function-parameter-or-member-vcpu-not-described-in-kvm_arm_num_regs
    |-- arch-arm64-kvm-pmu-emul.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_32
    |-- arch-arm64-kvm-sys_regs.c:warning:Excess-function-parameter-run-description-in-kvm_handle_cp_64
    |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_32
    |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-global-not-described-in-kvm_handle_cp_64
    |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_32
    |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-nr_global-not-described-in-kvm_handle_cp_64
    |-- arch-arm64-kvm-sys_regs.c:warning:Function-parameter-or-member-params-not-described-in-kvm_handle_cp_32
    |-- arch-arm64-kvm-vgic-vgic-init.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-e-not-described-in-vgic_irqfd_set_irq
    |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-irq_source_id-not-described-in-kvm_arch_set_irq_inatomic
    |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-kvm-not-described-in-kvm_arch_set_irq_inatomic
    |-- arch-arm64-kvm-vgic-vgic-irqfd.c:warning:Function-parameter-or-member-line_status-not-described-in-kvm_set_msi
    |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-ite_esz-not-described-in-vgic_its_save_ite
    |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_device_tables
    |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_restore_ite
    |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-its-not-described-in-vgic_its_save_collection_table
    |-- arch-arm64-kvm-vgic-vgic-its.c:warning:Function-parameter-or-member-opaque-not-described-in-scan_its_table
    `-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead

elapsed time: 2745m

configs tested: 223
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231121   gcc  
arc                   randconfig-001-20231122   gcc  
arc                   randconfig-002-20231121   gcc  
arc                   randconfig-002-20231122   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231121   gcc  
arm                   randconfig-002-20231121   gcc  
arm                   randconfig-003-20231121   gcc  
arm                   randconfig-004-20231121   gcc  
arm                             rpc_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231121   gcc  
arm64                 randconfig-002-20231121   gcc  
arm64                 randconfig-003-20231121   gcc  
arm64                 randconfig-004-20231121   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231121   gcc  
csky                  randconfig-001-20231122   gcc  
csky                  randconfig-002-20231121   gcc  
csky                  randconfig-002-20231122   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20231121   clang
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-012-20231121   clang
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-013-20231121   clang
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-014-20231121   clang
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-015-20231121   clang
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-016-20231121   clang
i386                  randconfig-016-20231122   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231121   gcc  
loongarch             randconfig-001-20231122   gcc  
loongarch             randconfig-002-20231121   gcc  
loongarch             randconfig-002-20231122   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231121   gcc  
nios2                 randconfig-001-20231122   gcc  
nios2                 randconfig-002-20231121   gcc  
nios2                 randconfig-002-20231122   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231121   gcc  
parisc                randconfig-001-20231122   gcc  
parisc                randconfig-002-20231121   gcc  
parisc                randconfig-002-20231122   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231121   gcc  
powerpc               randconfig-002-20231121   gcc  
powerpc               randconfig-003-20231121   gcc  
powerpc64                           defconfig   gcc  
powerpc64             randconfig-001-20231121   gcc  
powerpc64             randconfig-002-20231121   gcc  
powerpc64             randconfig-003-20231121   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231121   gcc  
riscv                 randconfig-002-20231121   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231122   gcc  
s390                  randconfig-002-20231122   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231121   gcc  
sh                    randconfig-001-20231122   gcc  
sh                    randconfig-002-20231121   gcc  
sh                    randconfig-002-20231122   gcc  
sh                           se7724_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231121   gcc  
sparc64               randconfig-001-20231122   gcc  
sparc64               randconfig-002-20231121   gcc  
sparc64               randconfig-002-20231122   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231121   gcc  
um                    randconfig-002-20231121   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231121   gcc  
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-002-20231121   gcc  
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-003-20231121   gcc  
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-004-20231121   gcc  
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-005-20231121   gcc  
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-006-20231121   gcc  
x86_64       buildonly-randconfig-006-20231122   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231121   gcc  
x86_64                randconfig-011-20231122   clang
x86_64                randconfig-012-20231121   gcc  
x86_64                randconfig-012-20231122   clang
x86_64                randconfig-013-20231121   gcc  
x86_64                randconfig-013-20231122   clang
x86_64                randconfig-014-20231121   gcc  
x86_64                randconfig-014-20231122   clang
x86_64                randconfig-015-20231121   gcc  
x86_64                randconfig-015-20231122   clang
x86_64                randconfig-016-20231121   gcc  
x86_64                randconfig-016-20231122   clang
x86_64                randconfig-071-20231121   gcc  
x86_64                randconfig-071-20231122   clang
x86_64                randconfig-072-20231121   gcc  
x86_64                randconfig-072-20231122   clang
x86_64                randconfig-073-20231121   gcc  
x86_64                randconfig-073-20231122   clang
x86_64                randconfig-074-20231121   gcc  
x86_64                randconfig-074-20231122   clang
x86_64                randconfig-075-20231121   gcc  
x86_64                randconfig-075-20231122   clang
x86_64                randconfig-076-20231121   gcc  
x86_64                randconfig-076-20231122   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231121   gcc  
xtensa                randconfig-001-20231122   gcc  
xtensa                randconfig-002-20231121   gcc  
xtensa                randconfig-002-20231122   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

