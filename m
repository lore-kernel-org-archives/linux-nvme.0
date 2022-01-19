Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50656C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jF52pYol0qAZdWQZoTiL4TjZos6XMQuq5ERMQ5x1utk=; b=q6+9p9ZEPPRjTlbjAltbJPL3Yn
	GAdx4Ahe0ZlSnci/rkbsOvbkbZzhng1LL4PZOIaR7TI8AP6CE0vc/HK7JFMfoDGtRI1/gApjkfHJz
	9woKwU748944b6YjFYo/DCxpLe8dLbkRkwX3ZT793Dninje53TIIfPxP94HsJQi6P93Zd/4LgkX1g
	gdPM057fpBY0hl5PKzK+jLG/gkWQ5t8E8Oe9AGXoZCdLvvtrUeyqaU8zmeQW4JpZiRqqIaS9Cx5z2
	DEIeWEP+xYFugf6Q/boO9t2JuRM1uHNKMe+KyjTiPJWlWshfpFKJOOQc1JYK9jQRWYN7wmh3wUl//
	ULXvDaQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA6o2-004QJy-CK; Wed, 19 Jan 2022 08:59:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA6nz-004QHp-Gg
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 08:59:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDFEB212C5;
 Wed, 19 Jan 2022 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642582735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jF52pYol0qAZdWQZoTiL4TjZos6XMQuq5ERMQ5x1utk=;
 b=JjN8XM0wGu5mpo4fKhP1FtVuvMKA8FYME4A7zyzUFjDCHRMghptmuTdYGDAKpGT67gX6Ab
 WjAXPlZfEp/xaZXVuGrwWwixiOGd67TaPOxWE/bcnq5kX7TJr0YEXJokmHDxsFTajvuZug
 DYMdbqX4RcGyCF0bCt1cGyM1zbJ0B6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642582735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jF52pYol0qAZdWQZoTiL4TjZos6XMQuq5ERMQ5x1utk=;
 b=Z0og6kZHg2ncH0ZmI+tkIFOL4xZ6jSAJvYJESA4+KS02BH+l310kOPDBNSprmYjGPsjsd7
 Cydki7NJBdhaMJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D602613B28;
 Wed, 19 Jan 2022 08:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i4YoM8/S52HZFQAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 19 Jan 2022 08:58:55 +0000
Date: Wed, 19 Jan 2022 09:58:55 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet: add support reading with offset from ANA log
Message-ID: <20220119085855.d534ecll44x5bvoa@carbon.lan>
References: <20220110140539.25521-1-dwagner@suse.de>
 <a6d52d42-1036-e036-e2b0-8f6aebe8ca2e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d52d42-1036-e036-e2b0-8f6aebe8ca2e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220119_005859_740282_0CD2D3A1 
X-CRM114-Status: GOOD (  15.44  )
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

Hi Chaitanya,

On Wed, Jan 19, 2022 at 07:43:07AM +0000, Chaitanya Kulkarni wrote:
> I'm not against having this code but do you really have
> a client side usecase for this one that you can please
> explain ?
>
> Existing code should work fine to read the log pages and I've
> not received any complaints so far ..

All started with this call trace:

nvme nvme17: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 100.102.252.12:8009
nvme: page allocation failure: order:7, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0-1
CPU: 1 PID: 96790 Comm: nvme Kdump: loaded Tainted: G           OE  X    5.3.18-59.27-default #1 SLE15-SP3
Call Trace:
 dump_stack+0x66/0x8b
 warn_alloc+0x10b/0x190
 ? __alloc_pages_direct_compact+0x15e/0x170
 __alloc_pages_slowpath+0xcea/0xd20
 __alloc_pages_nodemask+0x2cb/0x320
 kmalloc_order+0x18/0x70
 kmalloc_order_trace+0x1d/0xa0
 __kmalloc+0x257/0x2b0
 nvme_mpath_init_identify+0xe5/0x190 [nvme_core]
 ? blk_queue_write_cache+0x30/0x60
 nvme_init_ctrl_finish+0x340/0xde0 [nvme_core]
 ? blk_mq_run_hw_queue+0x77/0x100
 nvme_tcp_setup_ctrl+0x396/0x680 [nvme_tcp]
 nvme_tcp_create_ctrl+0x31e/0x3c7 [nvme_tcp]
 nvmf_dev_write+0xb04/0xd70 [nvme_fabrics]
 ? common_file_perm+0x64/0x190
 ? vfs_write+0xad/0x1b0
 vfs_write+0xad/0x1b0
 ksys_write+0xa1/0xe0
 do_syscall_64+0x5b/0x1e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb44848bc30

The target says it support 49 ANA Group Descriptors and 65536
namespaces. The current code in Linux is allocating an ANA buffer large
enough to read the complete ANA log in one operation.

With the above numbers the buffer is

  16 + 16 * 49 + 65365 * 4 = 262260 bytes

large, ca 64.028 4k pages. This means when allocating the buffer, the
smallest bucket to allocated from is the 128kB (2^7).

So my idea was to limit the ana log buffer and read the it in chunks if
needed.

Anyway, I started with replicating the situation and found out that the
target code does not support reads with offsets hence this patch.

Daniel

