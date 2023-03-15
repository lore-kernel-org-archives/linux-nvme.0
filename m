Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11253C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jrLBqtJAGOwxXDTMYCYNbMNIOmH5eZ9T3IcRCSugX3k=; b=FRrRB7AKI10hmL1jlUHtOCzBzw
	Mzm5ozL8UTY0C75XXHnLB9tj0bliKfR/Dy4IvnZGAJZPOWarcCe+1cFhf0cP94AEk9TGKxrIDZqT9
	z3nRfifiVOptqJAkN+ELzNyNGMDoRKCfR7qFw5V0irWD/Wgxe6z89x5wtsginDHZOcL7mtFr1tgFJ
	rYA2VbXlVL3hE8Fd/L0XZatJkfmue6FJyh/MqKnZuN1vWEj/ddUBn0E5rfVOrJSST18ljCXoKMym8
	xLVrwoHYaRZi3kPTXwDHVLdwUDKZ3VOPhDf9Lw4lDw6HIo0ozfuET03+L3Jt7f4gU3slVWqdutSwO
	kMqWD9+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVch-00EDFv-2G;
	Wed, 15 Mar 2023 18:13:15 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcVce-00EDFM-1b
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 18:13:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F36AFB81E9C;
	Wed, 15 Mar 2023 18:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83730C433EF;
	Wed, 15 Mar 2023 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678903988;
	bh=Xqqgf5e1Ijf4gtE0vRlgHTbTkC9tsR0U0k61Oxmh0XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y92PglZMB4Q2RBvWHWybLB28BgWcWzau272B0j43naTgTtzCdzjSpGe/VHJZzvI78
	 K18Yi799oti/CXDIaiIgEWvMRnb1e+bNYabWj0NdKUJq8SID70KytgWRarpNX1bJHr
	 beSzNIFQIu8pcL5vNa3QM0vvzc27OFEqpm9dioezwcdUeseTm1MWfIpZwEa++jU3Xq
	 QREd3WWpFYiAXVxeppMG4Dy7KHZg+CSiCaZiZ2WQhc/zAJMH/0bwFkWjIZ7+QY6PIt
	 5i6dEE1DFV9zZIoa80pyxMjO4aCMuxyuc12uhbeFq7blax5SAQZzSIooOLQLkTj4dQ
	 3+1WBU20DpTWA==
Date: Wed, 15 Mar 2023 12:13:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_111312_847509_53869A47 
X-CRM114-Status: GOOD (  16.65  )
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

On Wed, Mar 15, 2023 at 05:48:14PM +0000, Belanger, Martin wrote:
> I'm running tests where I connect/disconnect to/from a few I/O controllers using the nvme_tcp driver. I use nvmet_tcp with a null_blk device to simulate the target. The kernel module crashes (trace below) while trying to connect over TCP. This happens on Fedora 37 and Ubuntu 22.04. I also recompiled the kernel using the latest nvme-6.4 branch and I'm still seeing the crash.
> 
> I'm not sure how to debug this further. Any suggestions?

Never seen anyone try to use poll queues with nvme tcp before. It doesn't look
like that would work for a connect command since there's no bdev at this point,
and polling needs a bdev.

> Mar 15 13:30:22.954399 fedora37 kernel: nvme nvme1: failed to connect socket: -110
> Mar 16 13:30:22.958393 fedora37 kernel: nvmet: creating nvm controller 2 for subsystem nqn.1988-11.com.dell:PowerSANxxx:01:20210225100113-454f73093ceb4847a7bdfc6e34ae8e28 for NQN nqn.2014-08.org.nvmexpress:uuid:f9ef75fc-1699-418f-ba45-49f9fc766e1b.
> Mar 15 13:30:22.958453 fedora37 kernel: nvme nvme1: creating 12 I/O queues.
> Mar 15 13:30:22.960320 fedora37 kernel: nvme nvme1: mapped 4/4/4 default/read/poll queues.
> Mar 15 13:30:22.960862 fedora37 kernel: BUG: kernel NULL pointer dereference, address: 0000000000000034
> Mar 15 13:30:22.960998 fedora37 kernel: #PF: supervisor read access in kernel mode
> Mar 15 13:30:22.992915 fedora37 kernel: #PF: error_code(0x0000) - not-present page
> Mar 15 13:30:22.994551 fedora37 kernel: PGD 0 P4D 0 
> Mar 15 13:30:22.996135 fedora37 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
> Mar 15 13:30:22.996169 fedora37 kernel: CPU: 0 PID: 3953 Comm: pool Not tainted 6.3.0-rc1-stas+ #1
> Mar 15 13:30:22.996192 fedora37 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Mar 15 13:30:22.996210 fedora37 kernel: RIP: 0010:bio_poll+0xd/0x150
> Mar 15 13:30:22.996227 fedora37 kernel: Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 <8b> 6f 34 48 8b 47 08 48 85 c0 0f 84 a1 00 00 00 4c 8b a8 60 03 00
> Mar 15 13:30:22.996245 fedora37 kernel: RSP: 0018:ffffa561851bfae0 EFLAGS: 00010246
> Mar 15 13:30:22.996266 fedora37 kernel: RAX: 0000000000000000 RBX: ffff8ff38ae60000 RCX: 0000000000000000
> Mar 15 13:30:22.996311 fedora37 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> Mar 15 13:30:22.996369 fedora37 kernel: RBP: ffffa561851bfb10 R08: 0000000000000001 R09: ffff8ff38cc0e860
> Mar 15 13:30:22.996410 fedora37 kernel: R10: ffff8ff3887af388 R11: 0000000000000110 R12: 0000000000000001
> Mar 15 13:30:22.996430 fedora37 kernel: R13: ffff8ff38fbd9c00 R14: 0000000000000400 R15: ffffa561851bfba8
> Mar 15 13:30:22.996450 fedora37 kernel: FS:  00007f9aab2ff6c0(0000) GS:ffff8ff84b400000(0000) knlGS:0000000000000000
> Mar 15 13:30:22.996467 fedora37 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 15 13:30:22.996484 fedora37 kernel: CR2: 0000000000000034 CR3: 000000011439e002 CR4: 00000000000706f0
> Mar 15 13:30:22.996501 fedora37 kernel: Call Trace:
> Mar 16 13:30:22.996518 fedora37 kernel:  <TASK>
> Mar 15 13:30:22.996535 fedora37 kernel:  blk_execute_rq+0xc9/0x190
> Mar 15 13:30:22.996552 fedora37 kernel:  __nvme_submit_sync_cmd+0xa5/0x160 [nvme_core]
> Mar 15 13:30:22.996572 fedora37 kernel:  nvmf_connect_io_queue+0x10b/0x200 [nvme_fabrics]
> Mar 15 13:30:22.996589 fedora37 kernel:  nvme_tcp_start_queue+0x1a/0x90 [nvme_tcp]
> Mar 15 13:30:22.996606 fedora37 kernel:  nvme_tcp_setup_ctrl+0x410/0x7e0 [nvme_tcp]
> Mar 15 13:30:22.996626 fedora37 kernel:  nvme_tcp_create_ctrl+0x34f/0x460 [nvme_tcp]
> Mar 15 13:30:22.996643 fedora37 kernel:  nvmf_dev_write+0x5da/0xec0 [nvme_fabrics]

