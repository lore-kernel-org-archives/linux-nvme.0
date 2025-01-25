Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE13DC0218D
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jan 2025 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Egfbz0PTyaeF0MoM891WjBEFKrp1s8UG5n+zBPRK2sM=; b=D1yqNYOAXbjk0efFJsYvKmhoSG
	pVQ3296e7Cdw/Vp3ulchYkOp53oRPZgR/kLhS83FR0jQz9AawscBfiijrIe2agaTTA4uVjomUFaHv
	VnpUAUJkdkKB9o30WYQyek4flLvU0WKwbgVTwiPjClrF1MHzjHK3xpRDZVo+Q690jC9ICe0ElBndg
	h5zTuR57XaGPpygwoYOfLtM8X3TKVE/sLg7qUhTU//oHB6E/gD791OAMGeLSMLwv/FlP5XrTqDPXw
	ocq9l58DMGpbTBeM9xS9gSPqvqoPFOSyEA4ZYK18Uv0iMwxQvVrnw/IVPvLw0uMUsjKGJ/p2n3iki
	wBawbn+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbdCk-0000000GJHd-2YTF;
	Sat, 25 Jan 2025 10:15:54 +0000
Received: from [192.198.163.15] (helo=mgamail.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbdCi-0000000GJHK-385E
	for linux-nvme@lists.infradead.org;
	Sat, 25 Jan 2025 10:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737800153; x=1769336153;
  h=date:from:to:cc:subject:message-id;
  bh=O+W4oIK1jFrSj9J8NB6hzN5kPOGIvmRycoYk1oOmNwc=;
  b=NJqXHsp/Il288w87QDkiXv059Yyz9w5irVX5b4JZdAalJ6SrsNRv4DD4
   QUFL1czVHPwZvR1lytdzfLBHw62IDcsf8agVJw1yV5CEji3v5pSBIXk+H
   eGKSqgEZUdecMgklT9XkK1rcqDF/UiMwP6CayEJzrletdjdVQTSXatRzb
   appglAqxP9fGyAylF7Jjid6uMl5nt0RNCDImSExX7AR9UNkptURRDrvMw
   Fphu3ljKMAirkD5X6iT6/d1xK36wabrNKc7oI4M80Jc9sA7bmKjDfKaEv
   MgJtSwM96gMUtju552uj4n+rzYGhbglny3XWBldYiLCNpcX1xPeWcuxb4
   g==;
X-CSE-ConnectionGUID: IjiCCyVPSMar9MojXxTjAw==
X-CSE-MsgGUID: 6xrH4CyCRd2Y2G0yKbl9nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38498147"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="38498147"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 02:15:44 -0800
X-CSE-ConnectionGUID: Qmt6C/lBTcibMUzQsy57aA==
X-CSE-MsgGUID: Fw0CtB+dSMSafiTEWnCOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="113002975"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Jan 2025 02:15:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbdCW-000dhb-0w;
	Sat, 25 Jan 2025 10:15:40 +0000
Date: Sat, 25 Jan 2025 18:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.14] BUILD SUCCESS
 dc98628317723d868d4c114f8e9b798ec52fb4c0
Message-ID: <202501251820.ygU6R28i-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250125_021552_846247_4033BCEE 
X-CRM114-Status: UNSURE (   4.12  )
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
branch HEAD: dc98628317723d868d4c114f8e9b798ec52fb4c0  nvmet: add tls_concat and tls_key debugfs entries

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
|-- i386-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-buildonly-randconfig-001-20250125
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
|-- parisc-randconfig-002-20250125
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-randconfig-001-20250125
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-randconfig-003-20250125
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
|-- s390-randconfig-002-20250125
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
`-- x86_64-buildonly-randconfig-002-20250125
    |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
    `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead

elapsed time: 1009m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250125    gcc-13.2.0
arc                   randconfig-002-20250125    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-20
arm                             mxs_defconfig    clang-20
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20250125    gcc-14.2.0
arm                   randconfig-002-20250125    gcc-14.2.0
arm                   randconfig-003-20250125    clang-18
arm                   randconfig-004-20250125    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250125    gcc-14.2.0
arm64                 randconfig-002-20250125    gcc-14.2.0
arm64                 randconfig-003-20250125    gcc-14.2.0
arm64                 randconfig-004-20250125    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250125    gcc-14.2.0
csky                  randconfig-002-20250125    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250125    clang-20
hexagon               randconfig-002-20250125    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250125    gcc-12
i386        buildonly-randconfig-002-20250125    clang-19
i386        buildonly-randconfig-003-20250125    gcc-12
i386        buildonly-randconfig-004-20250125    clang-19
i386        buildonly-randconfig-005-20250125    clang-19
i386        buildonly-randconfig-006-20250125    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250125    clang-19
i386                  randconfig-002-20250125    clang-19
i386                  randconfig-003-20250125    clang-19
i386                  randconfig-004-20250125    clang-19
i386                  randconfig-005-20250125    clang-19
i386                  randconfig-006-20250125    clang-19
i386                  randconfig-007-20250125    clang-19
i386                  randconfig-011-20250125    gcc-12
i386                  randconfig-012-20250125    gcc-12
i386                  randconfig-013-20250125    gcc-12
i386                  randconfig-014-20250125    gcc-12
i386                  randconfig-015-20250125    gcc-12
i386                  randconfig-016-20250125    gcc-12
i386                  randconfig-017-20250125    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250125    gcc-14.2.0
loongarch             randconfig-002-20250125    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250125    gcc-14.2.0
nios2                 randconfig-002-20250125    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250125    gcc-14.2.0
parisc                randconfig-002-20250125    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc               randconfig-001-20250125    clang-18
powerpc               randconfig-002-20250125    gcc-14.2.0
powerpc               randconfig-003-20250125    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250125    gcc-14.2.0
powerpc64             randconfig-002-20250125    clang-20
powerpc64             randconfig-003-20250125    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250125    gcc-14.2.0
riscv                 randconfig-002-20250125    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250125    clang-19
s390                  randconfig-002-20250125    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250125    gcc-14.2.0
sh                    randconfig-002-20250125    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250125    gcc-14.2.0
sparc                 randconfig-002-20250125    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250125    gcc-14.2.0
sparc64               randconfig-002-20250125    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250125    clang-20
um                    randconfig-002-20250125    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250125    clang-19
x86_64      buildonly-randconfig-002-20250125    clang-19
x86_64      buildonly-randconfig-002-20250125    gcc-11
x86_64      buildonly-randconfig-003-20250125    clang-19
x86_64      buildonly-randconfig-004-20250125    clang-19
x86_64      buildonly-randconfig-004-20250125    gcc-12
x86_64      buildonly-randconfig-005-20250125    clang-19
x86_64      buildonly-randconfig-006-20250125    clang-19
x86_64      buildonly-randconfig-006-20250125    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250125    clang-19
x86_64                randconfig-002-20250125    clang-19
x86_64                randconfig-003-20250125    clang-19
x86_64                randconfig-004-20250125    clang-19
x86_64                randconfig-005-20250125    clang-19
x86_64                randconfig-006-20250125    clang-19
x86_64                randconfig-007-20250125    clang-19
x86_64                randconfig-008-20250125    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250125    gcc-14.2.0
xtensa                randconfig-002-20250125    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

