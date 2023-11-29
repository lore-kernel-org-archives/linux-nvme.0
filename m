Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B693C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 23:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7A9Ufa1K6Uc96j09IFrwChj7lp26Ox1VBqgUFuEcvgc=; b=dfKy4/f/2fsa0escwIstb3KuNO
	/SPW4vUCBoNz/ezk0g/6dalcubvzHhanrpv6am9D3sAe+7Rx+3X80muMTkL7TfyIAy8UeB5wymnoD
	l5FQ3l3G3C8sOYMH3vYAehWpENf3nWcdOwxdVZPwDUAwYOcXClH15gpXVCAerlawdqUUzTizn8aFZ
	3TBKLcg8Z6Nq4wDMNspxlBQoCMZsc7evXl9MmCJkg3JnN3gzS6q4HMMnDWMjTa97XXCwWGL9Kxm00
	hmNhuOzyzb4BOlhRYdBfEhTP1psKWH1rMbHrvpiSn0jF864y+WtSQxUWkr1YObA9+Atw74Ay3SRbD
	Z9uD0H4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8UQO-009XaB-1b;
	Wed, 29 Nov 2023 23:57:00 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8UQJ-009XZu-2y
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 23:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701302216; x=1732838216;
  h=date:from:to:cc:subject:message-id;
  bh=IetPFZBiPwVp7nH24449K66cPk2ok6X0knIgVw6cgKQ=;
  b=V+mVhhdMKlhLSxWaiB9vjSGpx9Halm5UT1JXceQryqKMzT63MZFepnTS
   2ZYA+unCBJG76R9Udb/mnrZtLmU8tlLy3CeOFo9l3aMV0BPapwG6W0A7e
   DYjkD6BNO4JkMCIHx09m6CktjctMcM9DFNKzvU64qpNeUt+HHYyKwvvoJ
   tGV1mU6VotGQAQro+pTvCyxW3yAaQ5VkrFsHIUX9EMwHY4XZbXV0OFPhc
   qbnGdGZON/vlxXYJyprYKCpVJbeqEyQj1fA3zMQ6+AAeGDVAqLOTQ1F5+
   qJ85QfBmCwey6CSrRq8GAabsNyuHazonPS+LsOFSRPWcLhyq+56DPunnG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="143445"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="143445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835186473"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835186473"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2023 15:56:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8UQF-00016s-03;
	Wed, 29 Nov 2023 23:56:51 +0000
Date: Thu, 30 Nov 2023 07:56:06 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.7] BUILD REGRESSION
 b6cbe703db447a22f70caa0ee9cf616ac26cdc37
Message-ID: <202311300702.jdhmRZE2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_155656_039921_284B753F 
X-CRM114-Status: UNSURE (   5.45  )
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
branch HEAD: b6cbe703db447a22f70caa0ee9cf616ac26cdc37  nvme-core: check for too small lba shift

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202311290724.uhn9SbbS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/nvme/host/rdma.c:987:47: error: passing argument 1 of 'nvme_ctrl_state' from incompatible pointer type [-Werror=incompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- arc-allyesconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- arm-allmodconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- arm-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- arm-randconfig-001-20231129
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- arm-randconfig-003-20231129
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm-randconfig-004-20231129
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- arm64-randconfig-001-20231129
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- arm64-randconfig-002-20231129
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- arm64-randconfig-003-20231129
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
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- arm64-randconfig-004-20231129
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- csky-allmodconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- csky-allyesconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- csky-randconfig-001-20231129
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- csky-randconfig-002-20231129
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- i386-buildonly-randconfig-001-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-buildonly-randconfig-002-20231129
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- i386-buildonly-randconfig-003-20231129
|   `-- drivers-platform-x86-think-lmi.c:warning:s-directive-argument-is-null
|-- i386-buildonly-randconfig-004-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-buildonly-randconfig-005-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-001-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- i386-randconfig-003-20231129
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- i386-randconfig-005-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- loongarch-allmodconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- loongarch-defconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- loongarch-randconfig-002-20231129
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- m68k-allmodconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- m68k-allyesconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- microblaze-allmodconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- microblaze-allyesconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- mips-allyesconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- nios2-allmodconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- nios2-allyesconfig
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- openrisc-allyesconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-allmodconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- parisc-randconfig-002-20231129
|   |-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- riscv-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- riscv-randconfig-002-20231129
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- s390-allmodconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- s390-allyesconfig
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- sparc-allmodconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc64-allmodconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc64-allyesconfig
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- sparc64-randconfig-001-20231129
|   `-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|-- x86_64-buildonly-randconfig-001-20231129
|   `-- drivers-nvme-target-trace.h:warning:strncpy-specified-bound-depends-on-the-length-of-the-source-argument
|-- x86_64-buildonly-randconfig-003-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-buildonly-randconfig-005-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-defconfig
|   `-- drivers-iommu-intel-dmar.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-012-20231129
|   |-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-013-20231129
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-014-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-015-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-016-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-071-20231129
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   |-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-072-20231129
|   `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-074-20231129
|   |-- drivers-nvme-host-rdma.c:error:passing-argument-of-nvme_ctrl_state-from-incompatible-pointer-type
|   |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
|   |-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
|-- x86_64-randconfig-075-20231129
|   `-- kernel-stackleak.c:warning:no-previous-prototype-for-stackleak_track_stack
`-- x86_64-randconfig-076-20231129
    `-- drivers-clk-clk-cdce925.c:warning:d-directive-writing-between-and-bytes-into-a-region-of-size
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
|   `-- arch-arm64-kvm-vgic-vgic-its.c:warning:expecting-prototype-for-entry_fn_t().-Prototype-was-for-int()-instead
`-- hexagon-randconfig-001-20231129
    |-- kernel-rcu-rcutorture.c:warning:variable-completed-set-but-not-used
    `-- kernel-rcu-rcutorture.c:warning:variable-started-set-but-not-used

elapsed time: 1539m

configs tested: 167
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231129   gcc  
arc                   randconfig-002-20231129   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231129   gcc  
arm                   randconfig-002-20231129   gcc  
arm                   randconfig-003-20231129   gcc  
arm                   randconfig-004-20231129   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231129   gcc  
arm64                 randconfig-002-20231129   gcc  
arm64                 randconfig-003-20231129   gcc  
arm64                 randconfig-004-20231129   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231129   gcc  
csky                  randconfig-002-20231129   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231129   clang
hexagon               randconfig-002-20231129   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231129   gcc  
i386         buildonly-randconfig-002-20231129   gcc  
i386         buildonly-randconfig-003-20231129   gcc  
i386         buildonly-randconfig-004-20231129   gcc  
i386         buildonly-randconfig-005-20231129   gcc  
i386         buildonly-randconfig-006-20231129   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231129   gcc  
i386                  randconfig-002-20231129   gcc  
i386                  randconfig-003-20231129   gcc  
i386                  randconfig-004-20231129   gcc  
i386                  randconfig-005-20231129   gcc  
i386                  randconfig-006-20231129   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-012-20231129   clang
i386                  randconfig-013-20231129   clang
i386                  randconfig-014-20231129   clang
i386                  randconfig-015-20231129   clang
i386                  randconfig-016-20231129   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231129   gcc  
loongarch             randconfig-002-20231129   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231129   gcc  
nios2                 randconfig-002-20231129   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231129   gcc  
parisc                randconfig-002-20231129   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20231129   gcc  
powerpc               randconfig-002-20231129   gcc  
powerpc               randconfig-003-20231129   gcc  
powerpc64             randconfig-001-20231129   gcc  
powerpc64             randconfig-002-20231129   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231129   gcc  
x86_64       buildonly-randconfig-002-20231129   gcc  
x86_64       buildonly-randconfig-003-20231129   gcc  
x86_64       buildonly-randconfig-004-20231129   gcc  
x86_64       buildonly-randconfig-005-20231129   gcc  
x86_64       buildonly-randconfig-006-20231129   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231129   clang
x86_64                randconfig-002-20231129   clang
x86_64                randconfig-003-20231129   clang
x86_64                randconfig-004-20231129   clang
x86_64                randconfig-005-20231129   clang
x86_64                randconfig-006-20231129   clang
x86_64                randconfig-011-20231129   gcc  
x86_64                randconfig-012-20231129   gcc  
x86_64                randconfig-013-20231129   gcc  
x86_64                randconfig-014-20231129   gcc  
x86_64                randconfig-015-20231129   gcc  
x86_64                randconfig-016-20231129   gcc  
x86_64                randconfig-071-20231129   gcc  
x86_64                randconfig-072-20231129   gcc  
x86_64                randconfig-073-20231129   gcc  
x86_64                randconfig-074-20231129   gcc  
x86_64                randconfig-075-20231129   gcc  
x86_64                randconfig-076-20231129   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

