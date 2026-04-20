Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC06DEA71B3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9C7DmO//UJqHSkwytYVJVsl2/7FaRMPv+wCZvzbLNAs=; b=BqRO2wbuGAZOxqM4HunNJDzl3L
	3ZKlkbiJQQ3JU2DCKeesCuMiVSYAXl619zCtEmvwxyycpsuaRXCCr3UF8oMkOw1E1E3J0J9tCldvD
	+rOS5ZXpyL3OARf0osnwrnvAYJTKlqVqxV60ahKFC0imrGd+npfKJ2ythdi1sl7Fv5tOGOyaCBlJo
	kKgavMnySeNLzqo5Egjp5KlxYXDTeNrklDKlH08OWL6gI9y78iq07PnrHGhFUlwzrx9SARAy6hWLA
	1GU2UBOf+hNXG8qOs3VwWc3jBSFf6ZrVgkbRHAFVYfZtzVlZZWD0/HCFRJsawl5CbDwuYJ52inG1T
	ZvZqKq6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEdnM-00000006HxI-05Io;
	Mon, 20 Apr 2026 01:51:28 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEdnJ-00000006HwZ-1RFT
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 01:51:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776649885; x=1808185885;
  h=date:from:to:cc:subject:message-id;
  bh=exGyOoK1P1Zw0UNQWhguvKI7mx90hBnjdVLVW1x9STM=;
  b=R1xrMqutR7sH6yU+CVd9MncUxlpZ+Vkziwb4jmLOX67D8/FTU708J6mu
   30GqpVooOh3eeVKjS6I4Tqf01x6LFbd9pmiYyXIdBvkJAwJpKcjzux4vl
   NPHK5kvgSC6FnwOg/phLmvtiEC1kfQmezk1juZAb+EQD7DjVZNq4bREVT
   Skec8BvyTyjJ8QwrAPjDEH5LJmc1T1I2E3WZC9F82YxU90KN78dSmpGUi
   tRauxgmYl6YOHlBrtmzJmdJLe10wy0xtuUEVi7rEvwySTBlLz5gwoAVJt
   5hrE+puQ7WE+mCv3o4h6A2ppFARwpqmlT0PjIttDSHErBxlLq38LSXc1V
   A==;
X-CSE-ConnectionGUID: uaNrOKrQSnyv+ZHYkh3Kuw==
X-CSE-MsgGUID: cJSCYDKHQFuUmVodAVpU3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77438380"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77438380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 18:51:24 -0700
X-CSE-ConnectionGUID: p/5ZtghFRPaUOSqeI/ff9w==
X-CSE-MsgGUID: cpaAc1KkQrqv4Jk0FBBGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231461914"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Apr 2026 18:51:22 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wEdnD-0000000021H-0cFN;
	Mon, 20 Apr 2026 01:51:19 +0000
Date: Mon, 20 Apr 2026 09:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>
Subject: [linux-nvme:for-next 5/19] WARNING: modpost: vmlinux:
 section mismatch in reference: swap_inode_boot_loader+0x36c (section:
 .text.swap_inode_boot_loader) -> start_dirtytime_writeback (section:
 .init.text)
Message-ID: <202604200606.7BHpBMyA-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_185125_547204_05F186CC 
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
commit: 139c3d972ebafdfb27d05ab33cfc3583fb98a7b2 [5/19] ublk: add helper of ublk_need_map_io()
config: mips-randconfig-r071-20260419 (https://download.01.org/0day-ci/archive/20260420/202604200606.7BHpBMyA-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260420/202604200606.7BHpBMyA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604200606.7BHpBMyA-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: 0x16e8 (section: __ex_table) -> .L0  (section: .debug_str)
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
>> WARNING: modpost: vmlinux: section mismatch in reference: swap_inode_boot_loader+0x36c (section: .text.swap_inode_boot_loader) -> start_dirtytime_writeback (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0xa8 (section: .text.test_store) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0xac (section: .text.test_store) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x43c (section: .text.test_store) -> __TRACE_SYSTEM_LRU_INACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x440 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_INACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x660 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x664 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x6a0 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x6a4 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x6dc (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x6e0 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x748 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x74c (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x7b8 (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x7bc (section: .text.test_store) -> __TRACE_SYSTEM_LRU_ACTIVE_ANON (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x9e0 (section: .text.test_store) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_store+0x9e4 (section: .text.test_store) -> __TRACE_SYSTEM_ZONE_NORMAL (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x78 (section: .text.status_show) -> __TRACE_SYSTEM____GFP_NOLOCKDEP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x7c (section: .text.status_show) -> __TRACE_SYSTEM____GFP_NOLOCKDEP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0xbc (section: .text.status_show) -> __TRACE_SYSTEM____GFP_UNUSED_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0xc4 (section: .text.status_show) -> __TRACE_SYSTEM____GFP_UNUSED_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x108 (section: .text.status_show) -> __TRACE_SYSTEM____GFP_LAST_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: status_show+0x10c (section: .text.status_show) -> __TRACE_SYSTEM____GFP_LAST_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: usbpdmuxinfo_show+0xd4 (section: .text.usbpdmuxinfo_show) -> ftrace_test_event_filter (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usbpdmuxinfo_show+0xd8 (section: .text.usbpdmuxinfo_show) -> ftrace_test_event_filter (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_credit_alloc_all+0x22c4 (section: .text.tb_test_credit_alloc_all) -> oom_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tb_test_credit_alloc_all+0x22c8 (section: .text.tb_test_credit_alloc_all) -> oom_init (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x2d0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_FS_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x2d4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_FS_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x7c0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_IO_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x7c4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_IO_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8c0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGHMEM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8c4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGHMEM_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8f4 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DMA_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x8f8 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DMA_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x96c (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RECLAIMABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x970 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_RECLAIMABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x9ec (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DMA32_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0x9f0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_DMA32_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xaec (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGH_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xaf0 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_HIGH_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xb60 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_MOVABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: compare_dirs+0xb64 (section: .text.compare_dirs) -> __TRACE_SYSTEM____GFP_MOVABLE_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x6c (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NOWARN_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x70 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NOWARN_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x10c (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NORETRY_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x110 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_NORETRY_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x184 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_COMP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dma_test_probe+0x188 (section: .text.dma_test_probe) -> __TRACE_SYSTEM____GFP_COMP_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: lanes_fops_open+0x2c (section: .text.lanes_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: lanes_fops_open+0x30 (section: .text.lanes_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: speed_fops_open+0x2c (section: .text.speed_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: speed_fops_open+0x30 (section: .text.speed_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_receive_fops_open+0x2c (section: .text.packets_to_receive_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_receive_fops_open+0x30 (section: .text.packets_to_receive_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_send_fops_open+0x2c (section: .text.packets_to_send_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: packets_to_send_fops_open+0x30 (section: .text.packets_to_send_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_fops_open+0x2c (section: .text.test_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: test_fops_open+0x30 (section: .text.test_fops_open) -> __TRACE_SYSTEM____GFP_NOMEMALLOC_BIT (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: __nvmem_layout_driver_register+0x30 (section: .text.__nvmem_layout_driver_register) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: __nvmem_layout_driver_register+0x34 (section: .text.__nvmem_layout_driver_register) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0x70 (section: .text.nvmem_populate_layout) -> __setup_cmdline_parse_movablecore (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0x74 (section: .text.nvmem_populate_layout) -> __setup_cmdline_parse_movablecore (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0xe4 (section: .text.nvmem_populate_layout) -> __setup_cmdline_parse_kernelcore (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0xe8 (section: .text.nvmem_populate_layout) -> __setup_cmdline_parse_kernelcore (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0xec (section: .text.nvmem_populate_layout) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_populate_layout+0xfc (section: .text.nvmem_populate_layout) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_layout_bus_register+0x1c (section: .text.nvmem_layout_bus_register) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_layout_bus_register+0x24 (section: .text.nvmem_layout_bus_register) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_layout_bus_unregister+0x1c (section: .text.nvmem_layout_bus_unregister) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: nvmem_layout_bus_unregister+0x24 (section: .text.nvmem_layout_bus_unregister) -> __setup_str_cmdline_parse_movablecore (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

