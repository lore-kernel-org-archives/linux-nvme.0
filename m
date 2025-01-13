Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D40E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ugUq7qJ4hMzdGRwzlqVAPXdOiVNF6Fjs+6mqLvyetOg=; b=W0M3rISrxzpx42d7nTVn67mYBa
	ZJGGOdoteIYD6hdCrAd8V1+espQlBzDgvmSd+JPbdIMdxDVN/ZMIv6/t12rCtd+YMY/yxjowg8986
	J/7s/FnvEi6dQNaMwtcDeMo1E/jqA/HlvOrfsBZhUEfcETCZD8G4eiT65393PZiwxUvtHbKvGoBEW
	6/xUvTFd+vPZARyGiQG2DVK8kCaQVbAnCiVGV9fGudmX9JJCs+t91kdCQcbwFUJ9g9Txoz7ZNtnJ6
	AUtn1yNhCgpHazwXL0/kE9ZL8YExnDeH36uGBocW9irJOdyaslqs+gpG+xv+ZRNY8EKw+6ur6aYUT
	ot1wKbXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIrf-00000004yLL-2FqI;
	Mon, 13 Jan 2025 11:44:15 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIrb-00000004yKv-48g8
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 11:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736768652; x=1768304652;
  h=date:from:to:cc:subject:message-id;
  bh=WIVEXgrlvI4vxTNxc5zRhA1lm+Lql7Nj1o9eusSVMNA=;
  b=OVLxX5JTZ9HZtFDcemVWmogWc2PkEmbBg9dS7/qnwiBrg9QxPNZOJavm
   RwW5TP6xE6G0weC95IUaOqhJLvcDsKbR7C9VvEmueky2pymd17/uu9zil
   uFNgjC20wk/6NWIJhjNMxRlFonmHGkTNzlrWPOcCuzm3yktS8oQx8xLcj
   eHxyKJZ4uaSlmLQB/H0HtiDHrrZ15WLY4b7kb+ZQANzejj5U9O9gbSPUi
   KORypiGDusNj09PV3KGqY9qtyTAJoiyaJnYfJxVTOuFBgV4cs580U6WfI
   B7dsKTLZ7Mg0eRpO6n5Is/iRusFciE1hvz0icEOkzNRJEhowgK/1bFxoC
   A==;
X-CSE-ConnectionGUID: 1DyFqccrTvie+vHSBin9QA==
X-CSE-MsgGUID: 0WB/UeZXQkedrCkQ+tTqJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40792551"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40792551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 03:44:11 -0800
X-CSE-ConnectionGUID: sjCLrkHYTmGh4hRFK/Rosw==
X-CSE-MsgGUID: BxOPF2U2S4qFKrnNiZ8z7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="135268452"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Jan 2025 03:44:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXIrW-000N5x-32;
	Mon, 13 Jan 2025 11:44:06 +0000
Date: Mon, 13 Jan 2025 19:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.14] BUILD SUCCESS
 4a324970fabad503260973cd588609f3a26baab9
Message-ID: <202501131906.6zOtF3Ct-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_034412_106337_BA0ED432 
X-CRM114-Status: UNSURE (   4.58  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.14
branch HEAD: 4a324970fabad503260973cd588609f3a26baab9  nvme-pci: use correct size to free the hmb buffer

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- alpha-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm64-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- hexagon-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- hexagon-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- hexagon-randconfig-002-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-buildonly-randconfig-005-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- loongarch-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- loongarch-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- m68k-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- m68k-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- microblaze-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- microblaze-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- mips-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- mips-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- openrisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- parisc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- parisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- parisc-randconfig-001-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-randconfig-002-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc64-randconfig-001-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- riscv-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- riscv-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- s390-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- s390-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sh-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sh-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sparc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sparc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- um-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- um-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- x86_64-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- x86_64-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- xtensa-randconfig-001-20250113
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
`-- xtensa-randconfig-002-20250113
    |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
    `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead

elapsed time: 721m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250113    gcc-13.2.0
arc                   randconfig-002-20250113    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-16
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20250113    gcc-14.2.0
arm                   randconfig-002-20250113    gcc-14.2.0
arm                   randconfig-003-20250113    gcc-14.2.0
arm                   randconfig-004-20250113    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250113    gcc-14.2.0
arm64                 randconfig-002-20250113    clang-18
arm64                 randconfig-003-20250113    clang-20
arm64                 randconfig-004-20250113    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250113    gcc-14.2.0
csky                  randconfig-002-20250113    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250113    clang-20
hexagon               randconfig-002-20250113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250113    clang-19
i386        buildonly-randconfig-002-20250113    gcc-12
i386        buildonly-randconfig-003-20250113    clang-19
i386        buildonly-randconfig-004-20250113    clang-19
i386        buildonly-randconfig-005-20250113    clang-19
i386        buildonly-randconfig-006-20250113    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250113    gcc-14.2.0
loongarch             randconfig-002-20250113    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250113    gcc-14.2.0
nios2                 randconfig-002-20250113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250113    gcc-14.2.0
parisc                randconfig-002-20250113    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                      katmai_defconfig    clang-18
powerpc               randconfig-001-20250113    clang-18
powerpc               randconfig-002-20250113    gcc-14.2.0
powerpc               randconfig-003-20250113    clang-20
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250113    clang-20
powerpc64             randconfig-002-20250113    gcc-14.2.0
powerpc64             randconfig-003-20250113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250113    gcc-14.2.0
riscv                 randconfig-002-20250113    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250113    gcc-14.2.0
s390                  randconfig-002-20250113    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250113    gcc-14.2.0
sh                    randconfig-002-20250113    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250113    gcc-14.2.0
sparc                 randconfig-002-20250113    gcc-14.2.0
sparc64               randconfig-001-20250113    gcc-14.2.0
sparc64               randconfig-002-20250113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250113    gcc-12
um                    randconfig-002-20250113    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250113    gcc-12
x86_64      buildonly-randconfig-002-20250113    gcc-12
x86_64      buildonly-randconfig-003-20250113    gcc-12
x86_64      buildonly-randconfig-004-20250113    gcc-12
x86_64      buildonly-randconfig-005-20250113    clang-19
x86_64      buildonly-randconfig-006-20250113    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250113    gcc-14.2.0
xtensa                randconfig-002-20250113    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

