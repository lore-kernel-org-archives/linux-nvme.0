Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02963E6C61C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RE8qg/6CiqNQGBrZYKS2shFSaWCE207txzIefVkgpIw=; b=RwLYN1IqGxcghfSpE3cLz66LvZ
	aU2gVOlRDRllQdR0lQsGhhLTFvPTyVKq5ZSHc58nX5Y1PPuzMdZMQM1iy1H6iOvv6udDVBcx7eTnR
	EdA85fT9vHUKihi7Ru9ucJ9Fc0Fd7Qg+7EAFGcXXP9FVjo8nEdIFcOy2IHKnR/ZYdQefW/6yR5Ka/
	K5JrLN6LvEBm2m9Pj5idtsKsARejE3FVY5ldWqX/yJgY/ZaIVExrdL/BgLCdpQQ3+RyNKaKY7xDpM
	tncBARD98EDo8CtZt4SOMBIaHNOmzQGYi6lDlZbSgyIVIAPCXc8GobnVzKcEY727xwSEfeeP3DYow
	XDc9jM6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOQy-00000008io2-1HcP;
	Tue, 03 Dec 2024 08:39:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOQu-00000008ilt-1vvf
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 08:39:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C80B2116E;
	Tue,  3 Dec 2024 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733215138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RE8qg/6CiqNQGBrZYKS2shFSaWCE207txzIefVkgpIw=;
	b=SlqTWjqFV52/zyy0f5es3d88l2dD9Mj6MUJBo8EOwWraMCmWQpZOQH5apeLB+nzUJrbrx8
	b658hvunNkiBz59wVzp2N5ib4q9ysggujcVVdPeApMcCBYfsTl6YCph6Pknrz56ya25851
	Q6Jf5mhBIeutiIYl0AO6zgu1LjkNT2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733215138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RE8qg/6CiqNQGBrZYKS2shFSaWCE207txzIefVkgpIw=;
	b=9dz4iDdhBXwkie5Ocfz9Qrit0NT+NL75uVFMNf1PXSrHZYkwHThVUNAGKh1r201qCGgHjs
	SpXn/3JtNabSvSBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SlqTWjqF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9dz4iDdh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733215138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RE8qg/6CiqNQGBrZYKS2shFSaWCE207txzIefVkgpIw=;
	b=SlqTWjqFV52/zyy0f5es3d88l2dD9Mj6MUJBo8EOwWraMCmWQpZOQH5apeLB+nzUJrbrx8
	b658hvunNkiBz59wVzp2N5ib4q9ysggujcVVdPeApMcCBYfsTl6YCph6Pknrz56ya25851
	Q6Jf5mhBIeutiIYl0AO6zgu1LjkNT2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733215138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RE8qg/6CiqNQGBrZYKS2shFSaWCE207txzIefVkgpIw=;
	b=9dz4iDdhBXwkie5Ocfz9Qrit0NT+NL75uVFMNf1PXSrHZYkwHThVUNAGKh1r201qCGgHjs
	SpXn/3JtNabSvSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B38139C2;
	Tue,  3 Dec 2024 08:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6/3YNqHDTmfTPwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Dec 2024 08:38:57 +0000
Message-ID: <0b306341-6154-455e-99f7-95d075c40cb2@suse.de>
Date: Tue, 3 Dec 2024 09:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-loop: avoid using mutex in IO hotpath
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com
References: <20241129104838.3015665-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241129104838.3015665-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C80B2116E
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_003900_646015_B775FB41 
X-CRM114-Status: GOOD (  19.80  )
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

On 11/29/24 11:48, Nilay Shroff wrote:
> Using mutex lock in IO hot path causes the kernel BUG sleeping while
> atomic. Shinichiro[1], first encountered this issue while running blktest
> nvme/052 shown below:
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 996, name: (udev-worker)
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 2 locks held by (udev-worker)/996:
>   #0: ffff8881004570c8 (mapping.invalidate_lock){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x155/0x5c0
>   #1: ffffffff8607eaa0 (rcu_read_lock){....}-{1:2}, at: blk_mq_flush_plug_list+0xa75/0x1950
> CPU: 2 UID: 0 PID: 996 Comm: (udev-worker) Not tainted 6.12.0-rc3+ #339
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x6a/0x90
>   __might_resched.cold+0x1f7/0x23d
>   ? __pfx___might_resched+0x10/0x10
>   ? vsnprintf+0xdeb/0x18f0
>   __mutex_lock+0xf4/0x1220
>   ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>   ? __pfx_vsnprintf+0x10/0x10
>   ? __pfx___mutex_lock+0x10/0x10
>   ? snprintf+0xa5/0xe0
>   ? xas_load+0x1ce/0x3f0
>   ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>   nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>   ? __pfx_nvmet_subsys_nsid_exists+0x10/0x10 [nvmet]
>   nvmet_req_find_ns+0x24e/0x300 [nvmet]
>   nvmet_req_init+0x694/0xd40 [nvmet]
>   ? blk_mq_start_request+0x11c/0x750
>   ? nvme_setup_cmd+0x369/0x990 [nvme_core]
>   nvme_loop_queue_rq+0x2a7/0x7a0 [nvme_loop]
>   ? __pfx___lock_acquire+0x10/0x10
>   ? __pfx_nvme_loop_queue_rq+0x10/0x10 [nvme_loop]
>   __blk_mq_issue_directly+0xe2/0x1d0
>   ? __pfx___blk_mq_issue_directly+0x10/0x10
>   ? blk_mq_request_issue_directly+0xc2/0x140
>   blk_mq_plug_issue_direct+0x13f/0x630
>   ? lock_acquire+0x2d/0xc0
>   ? blk_mq_flush_plug_list+0xa75/0x1950
>   blk_mq_flush_plug_list+0xa9d/0x1950
>   ? __pfx_blk_mq_flush_plug_list+0x10/0x10
>   ? __pfx_mpage_readahead+0x10/0x10
>   __blk_flush_plug+0x278/0x4d0
>   ? __pfx___blk_flush_plug+0x10/0x10
>   ? lock_release+0x460/0x7a0
>   blk_finish_plug+0x4e/0x90
>   read_pages+0x51b/0xbc0
>   ? __pfx_read_pages+0x10/0x10
>   ? lock_release+0x460/0x7a0
>   page_cache_ra_unbounded+0x326/0x5c0
>   force_page_cache_ra+0x1ea/0x2f0
>   filemap_get_pages+0x59e/0x17b0
>   ? __pfx_filemap_get_pages+0x10/0x10
>   ? lock_is_held_type+0xd5/0x130
>   ? __pfx___might_resched+0x10/0x10
>   ? find_held_lock+0x2d/0x110
>   filemap_read+0x317/0xb70
>   ? up_write+0x1ba/0x510
>   ? __pfx_filemap_read+0x10/0x10
>   ? inode_security+0x54/0xf0
>   ? selinux_file_permission+0x36d/0x420
>   blkdev_read_iter+0x143/0x3b0
>   vfs_read+0x6ac/0xa20
>   ? __pfx_vfs_read+0x10/0x10
>   ? __pfx_vm_mmap_pgoff+0x10/0x10
>   ? __pfx___seccomp_filter+0x10/0x10
>   ksys_read+0xf7/0x1d0
>   ? __pfx_ksys_read+0x10/0x10
>   do_syscall_64+0x93/0x180
>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>   ? do_syscall_64+0x9f/0x180
>   ? lockdep_hardirqs_on+0x78/0x100
>   ? do_syscall_64+0x9f/0x180
>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f565bd1ce11
> Code: 00 48 8b 15 09 90 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 d0 ad 01 00 f3 0f 1e fa 80 3d 35 12 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
> RSP: 002b:00007ffd6e7a20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f565bd1ce11
> RDX: 0000000000001000 RSI: 00007f565babb000 RDI: 0000000000000014
> RBP: 00007ffd6e7a2130 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000556000bfa610 R11: 0000000000000246 R12: 000000003ffff000
> R13: 0000556000bfa5b0 R14: 0000000000000e00 R15: 0000556000c07328
>   </TASK>
> 
> Apparently, the above issue is caused due to using mutex lock while
> we're in IO hot path. It's a regression caused with commit 505363957fad
> ("nvmet: fix nvme status code when namespace is disabled"). The mutex
> ->su_mutex is used to find whether a disabled nsid exists in the config
> group or not. This is to differentiate between a nsid that is disabled
> vs non-existent.
> 
> To mitigate the above issue, we've worked upon a fix[2] where we now
> insert nsid in subsys Xarray as soon as it's created under config group
> and later when that nsid is enabled, we add an Xarray mark on it and set
> ns->enabled to true. The Xarray mark is useful while we need to loop
> through all enabled namepsaces under a subsystem using xa_for_each_marked()
> API. If later a nsid is disabled then we clear Xarray mark from it and also
> set ns->enabled to false. It's only when nsid is deleted from the config
> group we delete it from the Xarray.
> 
> So with this change, now we could easily differentiate a nsid is disabled
> (i.e. Xarray entry for ns exists but ns->enabled is set to false) vs non-
> existent (i.e.Xarray entry for ns doesn't exist).
> 
> Link: https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/ [2]
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/ [1]
> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
> Fix-suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  13 ++--
>   drivers/nvme/target/core.c      | 108 +++++++++++++++++++-------------
>   drivers/nvme/target/nvmet.h     |   1 +
>   drivers/nvme/target/pr.c        |  10 +--
>   4 files changed, 79 insertions(+), 53 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

