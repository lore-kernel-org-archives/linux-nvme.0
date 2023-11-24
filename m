Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C95C61DF4
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Nov 2023 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GJbtKBfTKB4hFt9ZR21n3O7fy2MsYYkj3X/qob5fBY4=; b=PFBpwey70p5xzVALnQ9nzhpoiA
	NA8lNnhSm+SF9OkukRn8mndUxWwFrpx9zS9vP4ejU8POcYIaunVf3e+nh691WP5VV1KodKBMjhXaK
	XtKhZjQsLOKgcyqCSlSIPlpqejFZE9fsRNgGOlwnmYXWeDTGpTZBpSFK3YeB14O8zmJPu8/+CkPzs
	KPi8szQ892saXBJlm5rGXJeSaWxSrWySc6KUh+eS28K7EoWnNWKfKf9pj3fBnDgkejKRn33LWRZEc
	P8luj21jpE72PIZGcdtn4n1RAyuFVkrfFalSOMxnBc2VNtnNUynRDSfoysbEPgbcfagwNXuDup1mq
	HtdY77DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Tvj-006vo1-0w;
	Fri, 24 Nov 2023 11:01:03 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Tvf-006vm1-2D
	for linux-nvme@lists.infradead.org;
	Fri, 24 Nov 2023 11:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700823659; x=1732359659;
  h=date:from:to:cc:subject:message-id;
  bh=lQjxn/iJKVHoAOA2sqdWR/22bfOlPUDOdVlQDsLbzU4=;
  b=iHPiL1qRzMvJIOy1eJrNf7V1eXnQI+27qhmKbRxVFWvEpvKsyUaj+DXl
   mo6QrALH+xwcm/ufzYTi8qTLSuZxlJpjZpzh59WgPSz337zA4swHrzoPy
   TbE537LvkD7L1+JlQnrCIcPXaeDzANxdI3XZUQAAho9bgiTtzk17NGXpO
   2sfDkHlHwHkQaBEsATrMC5KwowmOc91JNL4+DwVB+fr887o58Qzh2uThJ
   EB533lmoPt8swy9TtCYDZY6VdO+NVdT0JwUVz8KvAW9c4gsAh3jEppnGE
   Z+7XZGRO5txyc2rLPMS7M+hv/voWpEEtLmW2IiU07Lr9mObACAIzj/guD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="392171814"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="392171814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="8935845"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2023 03:00:47 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6TvR-0002Zu-11;
	Fri, 24 Nov 2023 11:00:45 +0000
Date: Fri, 24 Nov 2023 18:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD SUCCESS
 3af755a46881c32fecaecfdeaf3a8f0a869deca5
Message-ID: <202311241854.ncafoKaS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_030059_745752_F7340C5A 
X-CRM114-Status: UNSURE (   5.60  )
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
branch HEAD: 3af755a46881c32fecaecfdeaf3a8f0a869deca5  nvme: move nvme_stop_keep_alive() back to original position

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- csky-randconfig-001-20231124
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- csky-randconfig-002-20231124
|   |-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- i386-buildonly-randconfig-002-20231123
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-buildonly-randconfig-004-20231123
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- i386-buildonly-randconfig-005-20231123
|   `-- drivers-spi-spi-pic32-sqi.c:warning:pic32_sqi_of_ids-defined-but-not-used
|-- microblaze-allmodconfig
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- microblaze-allyesconfig
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
|-- parisc-randconfig-001-20231124
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- riscv-allmodconfig
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- s390-randconfig-002-20231124
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sh-randconfig-002-20231124
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- x86_64-buildonly-randconfig-002-20231123
|   |-- drivers-platform-x86-think-lmi.c:warning:s-directive-argument-is-null
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-buildonly-randconfig-004-20231123
|   |-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   |-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-buildonly-randconfig-005-20231123
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-defconfig
|   `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-011-20231123
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-014-20231123
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-015-20231123
|   |-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-072-20231123
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
`-- x86_64-randconfig-074-20231123
    `-- drivers-platform-x86-think-lmi.c:warning:s-directive-argument-is-null
clang_recent_errors
|-- arm-randconfig-002-20231124
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- arm64-randconfig-004-20231124
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
|-- hexagon-randconfig-001-20231124
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
`-- powerpc-randconfig-003-20231124
    |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
    `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used

elapsed time: 2532m

configs tested: 113
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-002-20231124   gcc  
arm                   randconfig-001-20231124   clang
arm                   randconfig-002-20231124   clang
arm                   randconfig-003-20231124   clang
arm                   randconfig-004-20231124   clang
arm64                 randconfig-001-20231124   clang
arm64                 randconfig-002-20231124   clang
arm64                 randconfig-003-20231124   clang
arm64                 randconfig-004-20231124   clang
csky                  randconfig-001-20231124   gcc  
csky                  randconfig-002-20231124   gcc  
hexagon               randconfig-001-20231124   clang
hexagon               randconfig-002-20231124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231123   gcc  
i386         buildonly-randconfig-002-20231123   gcc  
i386         buildonly-randconfig-003-20231123   gcc  
i386         buildonly-randconfig-004-20231123   gcc  
i386         buildonly-randconfig-005-20231123   gcc  
i386         buildonly-randconfig-006-20231123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231123   gcc  
i386                  randconfig-002-20231123   gcc  
i386                  randconfig-003-20231123   gcc  
i386                  randconfig-004-20231123   gcc  
i386                  randconfig-005-20231123   gcc  
i386                  randconfig-006-20231123   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231124   gcc  
loongarch             randconfig-002-20231124   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231124   gcc  
nios2                 randconfig-002-20231124   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231124   gcc  
parisc                randconfig-002-20231124   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231124   clang
powerpc               randconfig-002-20231124   clang
powerpc               randconfig-003-20231124   clang
powerpc64             randconfig-001-20231124   clang
powerpc64             randconfig-002-20231124   clang
powerpc64             randconfig-003-20231124   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231124   clang
riscv                 randconfig-002-20231124   clang
riscv                          rv32_defconfig   clang
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-002-20231124   gcc  
sparc64               randconfig-001-20231124   gcc  
sparc64               randconfig-002-20231124   gcc  
um                    randconfig-001-20231124   clang
um                    randconfig-002-20231124   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231123   clang
x86_64                randconfig-002-20231123   clang
x86_64                randconfig-003-20231123   clang
x86_64                randconfig-004-20231123   clang
x86_64                randconfig-005-20231123   clang
x86_64                randconfig-006-20231123   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231123   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231124   gcc  
xtensa                randconfig-002-20231124   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

