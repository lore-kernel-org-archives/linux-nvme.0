Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBECF327BE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xHpbqtQkYxfS8FizjQo/xhan55qxAoHZ9yz8+1YvcH0=; b=IEUoNWk2gBZOzeKcY7zzOxlTaF
	RBnTN39ZhU1rBwVAPLa0jaacergxu2ioNF1B4Ec6bBr2QC5pzwr2432YEqR+tUxFWkEDMkrPohZgg
	2fLcm7bCmLUMyJd+f39e3BsKqsWNhR00LCDfypgR/ne5pgXspnSC7E59dj46vVJ74vdQpnZ43O7zt
	p9BwNV53Z0sjkomlHcNG8nzk6oJMDahHHGGa4BQqdpyu0vYVF8b2V6uZCdLlkf+re/DxyvhaFaQnJ
	aYNfF9DgdtM8b9i2YENZZ0cIQFF4lemkPLjtpR71eanJquBMDh+vze60rbK2fa8PVLlaQCOHix784
	Rbl498CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF64C-00000008Dsn-0TYt;
	Tue, 21 Apr 2026 08:02:44 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF647-00000008Ds8-3CSq
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 08:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776758560; x=1808294560;
  h=date:from:to:cc:subject:message-id;
  bh=H2fVKvwChMnwSfl3b8Td1mAhqEP0aPHR8vEY+iMZRtU=;
  b=QM3DQv7mr/GfBKJzXRfANQ/kicpfQxtm1/N5eR662U5ba6RJtZpFZ6aU
   i/Kke/7pD2ewmBIV+s1/49OToT+s7lELbq6/sEC0+62KrdRwOzPhlZY33
   tXb7HZsn2AtKY2tabfyR3RU0qRlSyk35YEyo02io3n5wz4VgujdLeRa1Q
   QE7UuzfFsQwW6IKzH3OtFGWgpVQq+VjSpi0RvAOJjEop6MOv9TouFQTjI
   eXxdIyj9oVf+C7ZA/Zn8GpsenSsUw+JWyXifMEYob+63rncOaltO9Ytjn
   44Xl/gHfB9yWInoSdsAlmQg5QReZsRdX9USe1KAqXRfTqJNFAGrWKMGcM
   A==;
X-CSE-ConnectionGUID: 8PYxoqbjRUe3SXxScr2gtg==
X-CSE-MsgGUID: shqVWDedRuyCvP9E4hSF0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77561003"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77561003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 01:02:37 -0700
X-CSE-ConnectionGUID: pYGodPw5TEe3dGdr5haU+g==
X-CSE-MsgGUID: 2KakgFYTRy2l5JBPT11+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="231080373"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Apr 2026 01:02:35 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wF63z-000000003KO-3gr1;
	Tue, 21 Apr 2026 08:02:31 +0000
Date: Tue, 21 Apr 2026 16:02:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [linux-nvme:for-next 9/19] WARNING: modpost: vmlinux:
 section mismatch in reference: status_show+0x78 (section: .text.status_show)
 -> __TRACE_SYSTEM_LRU_ACTIVE_FILE (section: .init.data)
Message-ID: <202604211540.7gnA3W4a-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_010239_891103_FD6B4CF2 
X-CRM114-Status: UNSURE (   7.76  )
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

tree:   git://git.infradead.org/nvme.git for-next
head:   0514a1379e11c6b8038674f43a478b0857d47a5e
commit: 793faf01d8e0c0fe51c1821cf62c60f5aaa493bd [9/19] ublk: implement ->queue_rqs()
config: mips-randconfig-r071-20260419 (https://download.01.org/0day-ci/archive/20260421/202604211540.7gnA3W4a-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260421/202604211540.7gnA3W4a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604211540.7gnA3W4a-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: __ex_table+0x16e8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16f0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x16f0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x16f8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x16f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1700 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1700 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1708 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1708 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1710 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1710 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1718 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1718 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1720 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1720 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1728 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1728 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1730 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1730 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1738 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1738 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1740 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1740 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1748 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1748 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1750 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1750 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1758 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1758 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1760 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1760 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1768 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1768 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1770 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1770 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1778 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1778 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1780 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1780 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1788 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1788 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1790 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1790 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1798 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1798 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17a0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17a0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17a8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17a8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17b0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17b0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17b8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17b8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17c0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17c0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17c8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17c8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17d0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17d0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17d8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17d8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17e0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17e0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17e8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17e8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17f0 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17f0 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x17f8 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x17f8 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1800 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1800 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1808 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1808 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1810 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1810 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1818 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1818 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1820 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1820 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1828 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1828 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1830 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1830 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1838 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1838 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1840 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1840 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1848 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1848 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1850 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1850 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1858 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1858 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1860 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1860 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1868 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1868 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: 0x1870 (section: __ex_table) -> .L0  (section: .debug_str)
ERROR: modpost: __ex_table+0x1870 references non-executable section '.debug_str'
WARNING: modpost: vmlinux: section mismatch in reference: trace_ext4_load_inode+0x58 (section: .text.trace_ext4_load_inode) -> start_dirtytime_writeback (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x78 (section: .text.status_show) -> __TRACE_SYSTEM_LRU_ACTIVE_FILE (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x7c (section: .text.status_show) -> __TRACE_SYSTEM_LRU_ACTIVE_FILE (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: status_show+0xbc (section: .text.status_show) -> __TRACE_SYSTEM_LRU_UNEVICTABLE (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0xc4 (section: .text.status_show) -> __TRACE_SYSTEM_LRU_UNEVICTABLE (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: qat_fw_counters_seq_show+0xe0 (section: .text.qat_fw_counters_seq_show) -> __setup_str_setup_print_fatal_signals (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qat_fw_counters_seq_show+0xe4 (section: .text.qat_fw_counters_seq_show) -> __setup_str_setup_print_fatal_signals (section: .init.rodata)
>> WARNING: modpost: vmlinux: section mismatch in reference: ti_msgmgr_probe+0x2d4 (section: .text.ti_msgmgr_probe) -> __TRACE_SYSTEM_RPM_SUSPENDING (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: ti_msgmgr_probe+0x334 (section: .text.ti_msgmgr_probe) -> __TRACE_SYSTEM_RPM_SUSPENDING (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: ti_msgmgr_queue_setup+0x110 (section: .text.ti_msgmgr_queue_setup) -> __TRACE_SYSTEM_RPM_SUSPENDING (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: ti_msgmgr_queue_setup+0x20c (section: .text.ti_msgmgr_queue_setup) -> __TRACE_SYSTEM_RPM_SUSPENDING (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_credit_alloc_all+0x1d80 (section: .text.tb_test_credit_alloc_all) -> oom_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_credit_alloc_all+0x1d84 (section: .text.tb_test_credit_alloc_all) -> oom_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x21c (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_DMA32_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x220 (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_DMA32_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x3b4 (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_DMA_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x3b8 (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_DMA_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x428 (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_HIGHMEM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_property_copy+0x42c (section: .text.tb_test_property_copy) -> __TRACE_SYSTEM____GFP_HIGHMEM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xf4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_MOVABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xf8 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_MOVABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x2d0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NORETRY_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x2d4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NORETRY_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x7c0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NOFAIL_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x7c4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NOFAIL_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x814 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_FS_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x818 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_FS_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x840 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_IO_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x844 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_IO_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8c0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DIRECT_RECLAIM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8c4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DIRECT_RECLAIM_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8f4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_ZERO_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8f8 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_ZERO_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x96c (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NOWARN_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x970 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_NOWARN_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x9ec (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_KSWAPD_RECLAIM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x9f0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_KSWAPD_RECLAIM_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xaec (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RETRY_MAYFAIL_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xaf0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RETRY_MAYFAIL_BIT (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xb60 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_WRITE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xb64 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_WRITE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xbdc (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RECLAIMABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xbe0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RECLAIMABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xc68 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGH_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xc6c (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGH_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x6c (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_THISNODE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x70 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_THISNODE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x10c (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NOLOCKDEP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x110 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NOLOCKDEP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x184 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_LAST_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x188 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_LAST_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: lanes_fops_open+0x2c (section: .text.lanes_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: lanes_fops_open+0x30 (section: .text.lanes_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: speed_fops_open+0x2c (section: .text.speed_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: speed_fops_open+0x30 (section: .text.speed_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_receive_fops_open+0x2c (section: .text.packets_to_receive_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_receive_fops_open+0x30 (section: .text.packets_to_receive_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_send_fops_open+0x2c (section: .text.packets_to_send_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_send_fops_open+0x30 (section: .text.packets_to_send_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_fops_open+0x2c (section: .text.test_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_fops_open+0x30 (section: .text.test_fops_open) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0x70 (section: .text.nvmem_populate_layout) -> __setup_str_early_init_on_alloc (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0x74 (section: .text.nvmem_populate_layout) -> __setup_str_early_init_on_alloc (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: u_boot_env_parse+0x138 (section: .text.u_boot_env_parse) -> __setup_early_init_on_free (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: u_boot_env_parse+0x13c (section: .text.u_boot_env_parse) -> __setup_early_init_on_free (section: .init.setup)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

