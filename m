Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B23ED7B93
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=71Qs5FO4v1XXu+AuK7YIYsp1K1LEXdLi7wGJZZsb3Wo=; b=tEla/9IyRlhB5s87Et5Gml8rSc
	Er5HjkArKqb/9nC4QaIClWJRZVCJm1YLL8oVMesZhAMsP8hAvNxrnjBJDN1rETlg55ZkkM2AF2NxX
	xiV51TMRHbDarnIC8oDAcQScHfI2XwpvPbdHH24PPu1V5v+B+vqyL7CyPf94pBsFVocdWnm8WvUGf
	O0UgWyRdtx9H+49brUq3kaRUmeu0JNWZDivyLMF0GimmKOWN3ixsHDTFwyAO7J4tXmiBos495vUfo
	3zm/Mvy/5Tu1BDlgI65lyTCaQzywgDq0E2N3ddLpVt/ONXsDu7MBgu5Mzt+VeZ4SMAi3vpQ30YpWg
	B1v2Pvag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCahh-0000000H6wf-0hjO;
	Tue, 14 Apr 2026 10:09:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCahe-0000000H6wI-2rR9
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 10:09:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 006E86A935;
	Tue, 14 Apr 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776161343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71Qs5FO4v1XXu+AuK7YIYsp1K1LEXdLi7wGJZZsb3Wo=;
	b=NiguRo7EryYGwAghjk9z5gD63a0AMtOt4e82a0HT5UyQqlOjX5xAqvHC1JdTeWVnPXTckH
	oxoNFoMYK0y0Cnc268DtqAcG08uXVg7UDWbQ8oS3oCPOVsdcy2MBk8bDJNUiGtFtPFdGtP
	Rq7fdC2AcO9q4ZZlo/dvnpOOTbimmCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776161343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71Qs5FO4v1XXu+AuK7YIYsp1K1LEXdLi7wGJZZsb3Wo=;
	b=9fH6ZziLwDyqMHmj+QAKm8ovbwL45F69m7D9pBpwn3pbrJalvt4ZV1F6SuY/gieSiXAL/o
	WgmZzOYBUtE8r1Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NiguRo7E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9fH6ZziL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776161343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71Qs5FO4v1XXu+AuK7YIYsp1K1LEXdLi7wGJZZsb3Wo=;
	b=NiguRo7EryYGwAghjk9z5gD63a0AMtOt4e82a0HT5UyQqlOjX5xAqvHC1JdTeWVnPXTckH
	oxoNFoMYK0y0Cnc268DtqAcG08uXVg7UDWbQ8oS3oCPOVsdcy2MBk8bDJNUiGtFtPFdGtP
	Rq7fdC2AcO9q4ZZlo/dvnpOOTbimmCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776161343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71Qs5FO4v1XXu+AuK7YIYsp1K1LEXdLi7wGJZZsb3Wo=;
	b=9fH6ZziLwDyqMHmj+QAKm8ovbwL45F69m7D9pBpwn3pbrJalvt4ZV1F6SuY/gieSiXAL/o
	WgmZzOYBUtE8r1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E17874B3B7;
	Tue, 14 Apr 2026 10:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RpxTNj4S3mnIdgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Apr 2026 10:09:02 +0000
Message-ID: <a105337a-b5ae-4892-953d-96540d3ddd29@suse.de>
Date: Tue, 14 Apr 2026 12:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] nvme-tcp: teardown circular lockng fixes
To: Chaitanya Kulkarni <kch@nvidia.com>, kbusch@kernel.org, sagi@grimberg.me
Cc: hch@lst.de, linux-nvme@lists.infradead.org
References: <20260413171628.6204-1-kch@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260413171628.6204-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 006E86A935
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_030907_023485_D6E8C5F4 
X-CRM114-Status: GOOD (  18.03  )
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

On 4/13/26 19:16, Chaitanya Kulkarni wrote:
> When a controller reset is triggered via sysfs (by writing to
> /sys/class/nvme/<nvmedev>/reset_controller), the reset work tears down
> and re-establishes all queues. The socket release using fput() defers
> the actual cleanup to task_work delayed_fput workqueue. This deferred
> cleanup can race with the subsequent queue re-allocation during reset,
> potentially leading to use-after-free or resource conflicts.
> 
> Replace fput() with __fput_sync() to ensure synchronous socket release,
> guaranteeing that all socket resources are fully cleaned up before the
> function returns. This prevents races during controller reset where
> new queue setup may begin before the old socket is fully released.
> 
> * Call chain during reset:
>    nvme_reset_ctrl_work()
>      -> nvme_tcp_teardown_ctrl()
>        -> nvme_tcp_teardown_io_queues()
>          -> nvme_tcp_free_io_queues()
>            -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>        -> nvme_tcp_teardown_admin_queue()
>          -> nvme_tcp_free_admin_queue()
>            -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>      -> nvme_tcp_setup_ctrl()             <-- race with deferred fput
> 
> memalloc_noreclaim_save() sets PF_MEMALLOC which is intended for tasks
> performing memory reclaim work that need reserve access. While PF_MEMALLOC
> prevents the task from entering direct reclaim (causing __need_reclaim() to
> return false), it does not strip __GFP_IO from gfp flags. The allocator can
> therefore still trigger writeback I/O when __GFP_IO remains set, which is
> unsafe when the caller holds block layer locks.
> 
> Switch to memalloc_noio_save() which sets PF_MEMALLOC_NOIO. This causes
> current_gfp_context() to strip __GFP_IO|__GFP_FS from every allocation in
> the scope, making it safe to allocate memory while holding elevator_lock and
> set->srcu.
> 
> * The issue can be reproduced using blktests:
> 
>    nvme_trtype=tcp ./check nvme/005
> blktests (master) # nvme_trtype=tcp ./check nvme/005
> nvme/005 (tr=tcp) (reset local loopback target)              [failed]
>      runtime  0.725s  ...  0.798s
>      something found in dmesg:
>      [  108.473940] run blktests nvme/005 at 2025-11-22 16:12:20
> 
>      [...]
>      ...
>      (See '/root/blktests/results/nodev_tr_tcp/nvme/005.dmesg' for the entire message)
> blktests (master) # cat /root/blktests/results/nodev_tr_tcp/nvme/005.dmesg
> [  108.473940] run blktests nvme/005 at 2025-11-22 16:12:20
> [  108.526983] loop0: detected capacity change from 0 to 2097152
> [  108.555606] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  108.572531] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  108.613061] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  108.616832] nvme nvme0: creating 48 I/O queues.
> [  108.630791] nvme nvme0: mapped 48/0/0 default/read/poll queues.
> [  108.661892] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  108.746639] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  108.748466] nvme nvme0: creating 48 I/O queues.
> [  108.802984] nvme nvme0: mapped 48/0/0 default/read/poll queues.
> [  108.829983] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [  108.854288] block nvme0n1: no available path - failing I/O
> [  108.854344] block nvme0n1: no available path - failing I/O
> [  108.854373] Buffer I/O error on dev nvme0n1, logical block 1, async page read
> 
> [  108.891693] ======================================================
> [  108.895912] WARNING: possible circular locking dependency detected
> [  108.900184] 6.17.0nvme+ #3 Tainted: G                 N
> [  108.903913] ------------------------------------------------------
> [  108.908171] nvme/2734 is trying to acquire lock:
> [  108.911957] ffff88810210e610 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x17/0x170
> [  108.917587]
>                 but task is already holding lock:
> [  108.921570] ffff88813abea198 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0xa8/0x1c0
> [  108.927361]
>                 which lock already depends on the new lock.
> 
> [  108.933018]
>                 the existing dependency chain (in reverse order) is:
> [  108.938223]
>                 -> #4 (&q->elevator_lock){+.+.}-{4:4}:
> [  108.942988]        __mutex_lock+0xa2/0x1150
> [  108.945873]        elevator_change+0xa8/0x1c0
> [  108.948925]        elv_iosched_store+0xdf/0x140
> [  108.952043]        kernfs_fop_write_iter+0x16a/0x220
> [  108.955367]        vfs_write+0x378/0x520
> [  108.957598]        ksys_write+0x67/0xe0
> [  108.959721]        do_syscall_64+0x76/0xbb0
> [  108.962052]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  108.965145]
>                 -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
> [  108.968923]        blk_alloc_queue+0x30e/0x350
> [  108.972117]        blk_mq_alloc_queue+0x61/0xd0
> [  108.974677]        scsi_alloc_sdev+0x2a0/0x3e0
> [  108.977092]        scsi_probe_and_add_lun+0x1bd/0x430
> [  108.979921]        __scsi_add_device+0x109/0x120
> [  108.982504]        ata_scsi_scan_host+0x97/0x1c0
> [  108.984365]        async_run_entry_fn+0x2d/0x130
> [  108.986109]        process_one_work+0x20e/0x630
> [  108.987830]        worker_thread+0x184/0x330
> [  108.989473]        kthread+0x10a/0x250
> [  108.990852]        ret_from_fork+0x297/0x300
> [  108.992491]        ret_from_fork_asm+0x1a/0x30
> [  108.994159]
>                 -> #2 (fs_reclaim){+.+.}-{0:0}:
> [  108.996320]        fs_reclaim_acquire+0x99/0xd0
> [  108.998058]        kmem_cache_alloc_node_noprof+0x4e/0x3c0
> [  109.000123]        __alloc_skb+0x15f/0x190
> [  109.002195]        tcp_send_active_reset+0x3f/0x1e0
> [  109.004038]        tcp_disconnect+0x50b/0x720
> [  109.005695]        __tcp_close+0x2b8/0x4b0
> [  109.007227]        tcp_close+0x20/0x80
> [  109.008663]        inet_release+0x31/0x60
> [  109.010175]        __sock_release+0x3a/0xc0
> [  109.011778]        sock_close+0x14/0x20
> [  109.013263]        __fput+0xee/0x2c0
> [  109.014673]        delayed_fput+0x31/0x50
> [  109.016183]        process_one_work+0x20e/0x630
> [  109.017897]        worker_thread+0x184/0x330
> [  109.019543]        kthread+0x10a/0x250
> [  109.020929]        ret_from_fork+0x297/0x300
> [  109.022565]        ret_from_fork_asm+0x1a/0x30
> [  109.024194]
>                 -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
> [  109.026634]        lock_sock_nested+0x2e/0x70
> [  109.028251]        tcp_sendmsg+0x1a/0x40
> [  109.029783]        sock_sendmsg+0xed/0x110
> [  109.031321]        nvme_tcp_try_send_cmd_pdu+0x13e/0x260 [nvme_tcp]
> [  109.034263]        nvme_tcp_try_send+0xb3/0x330 [nvme_tcp]
> [  109.036375]        nvme_tcp_queue_rq+0x342/0x3d0 [nvme_tcp]
> [  109.038528]        blk_mq_dispatch_rq_list+0x297/0x800
> [  109.040448]        __blk_mq_sched_dispatch_requests+0x3db/0x5f0
> [  109.042677]        blk_mq_sched_dispatch_requests+0x29/0x70
> [  109.044787]        blk_mq_run_work_fn+0x76/0x1b0
> [  109.046535]        process_one_work+0x20e/0x630
> [  109.048245]        worker_thread+0x184/0x330
> [  109.049890]        kthread+0x10a/0x250
> [  109.051331]        ret_from_fork+0x297/0x300
> [  109.053024]        ret_from_fork_asm+0x1a/0x30
> [  109.054740]
>                 -> #0 (set->srcu){.+.+}-{0:0}:
> [  109.056850]        __lock_acquire+0x1468/0x2210
> [  109.058614]        lock_sync+0xa5/0x110
> [  109.060048]        __synchronize_srcu+0x49/0x170
> [  109.061802]        elevator_switch+0xc9/0x330
> [  109.063950]        elevator_change+0x128/0x1c0
> [  109.065675]        elevator_set_none+0x4c/0x90
> [  109.067316]        blk_unregister_queue+0xa8/0x110
> [  109.069165]        __del_gendisk+0x14e/0x3c0
> [  109.070824]        del_gendisk+0x75/0xa0
> [  109.072328]        nvme_ns_remove+0xf2/0x230 [nvme_core]
> [  109.074365]        nvme_remove_namespaces+0xf2/0x150 [nvme_core]
> [  109.076652]        nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
> [  109.078775]        nvme_delete_ctrl_sync+0x3b/0x50 [nvme_core]
> [  109.081009]        nvme_sysfs_delete+0x34/0x40 [nvme_core]
> [  109.083082]        kernfs_fop_write_iter+0x16a/0x220
> [  109.085009]        vfs_write+0x378/0x520
> [  109.086539]        ksys_write+0x67/0xe0
> [  109.087982]        do_syscall_64+0x76/0xbb0
> [  109.089577]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  109.091665]
>                 other info that might help us debug this:
> 
> [  109.095478] Chain exists of:
>                   set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock
> 
> [  109.099544]  Possible unsafe locking scenario:
> 
> [  109.101708]        CPU0                    CPU1
> [  109.103402]        ----                    ----
> [  109.105103]   lock(&q->elevator_lock);
> [  109.106530]                                lock(&q->q_usage_counter(io));
> [  109.109022]                                lock(&q->elevator_lock);
> [  109.111391]   sync(set->srcu);
> [  109.112586]
>                  *** DEADLOCK ***
> 
> [  109.114772] 5 locks held by nvme/2734:
> [  109.116189]  #0: ffff888101925410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x67/0xe0
> [  109.119143]  #1: ffff88817a914e88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x10f/0x220
> [  109.123141]  #2: ffff8881046313f8 (kn->active#185){++++}-{0:0}, at: sysfs_remove_file_self+0x26/0x50
> [  109.126543]  #3: ffff88810470e1d0 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x6d/0xa0
> [  109.129891]  #4: ffff88813abea198 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0xa8/0x1c0
> [  109.133149]
>                 stack backtrace:
> [  109.134817] CPU: 6 UID: 0 PID: 2734 Comm: nvme Tainted: G                 N  6.17.0nvme+ #3 PREEMPT(voluntary)
> [  109.134819] Tainted: [N]=TEST
> [  109.134820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [  109.134821] Call Trace:
> [  109.134823]  <TASK>
> [  109.134824]  dump_stack_lvl+0x75/0xb0
> [  109.134828]  print_circular_bug+0x26a/0x330
> [  109.134831]  check_noncircular+0x12f/0x150
> [  109.134834]  __lock_acquire+0x1468/0x2210
> [  109.134837]  ? __synchronize_srcu+0x17/0x170
> [  109.134838]  lock_sync+0xa5/0x110
> [  109.134840]  ? __synchronize_srcu+0x17/0x170
> [  109.134842]  __synchronize_srcu+0x49/0x170
> [  109.134843]  ? mark_held_locks+0x49/0x80
> [  109.134845]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
> [  109.134847]  ? kvm_clock_get_cycles+0x14/0x30
> [  109.134853]  ? ktime_get_mono_fast_ns+0x36/0xb0
> [  109.134858]  elevator_switch+0xc9/0x330
> [  109.134860]  elevator_change+0x128/0x1c0
> [  109.134862]  ? kernfs_put.part.0+0x86/0x290
> [  109.134864]  elevator_set_none+0x4c/0x90
> [  109.134866]  blk_unregister_queue+0xa8/0x110
> [  109.134868]  __del_gendisk+0x14e/0x3c0
> [  109.134870]  del_gendisk+0x75/0xa0
> [  109.134872]  nvme_ns_remove+0xf2/0x230 [nvme_core]
> [  109.134879]  nvme_remove_namespaces+0xf2/0x150 [nvme_core]
> [  109.134887]  nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
> [  109.134893]  nvme_delete_ctrl_sync+0x3b/0x50 [nvme_core]
> [  109.134899]  nvme_sysfs_delete+0x34/0x40 [nvme_core]
> [  109.134905]  kernfs_fop_write_iter+0x16a/0x220
> [  109.134908]  vfs_write+0x378/0x520
> [  109.134911]  ksys_write+0x67/0xe0
> [  109.134913]  do_syscall_64+0x76/0xbb0
> [  109.134915]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  109.134916] RIP: 0033:0x7fd68a737317
> [  109.134917] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  109.134919] RSP: 002b:00007ffded1546d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  109.134920] RAX: ffffffffffffffda RBX: 000000000054f7e0 RCX: 00007fd68a737317
> [  109.134921] RDX: 0000000000000001 RSI: 00007fd68a855719 RDI: 0000000000000003
> [  109.134921] RBP: 0000000000000003 R08: 0000000030407850 R09: 00007fd68a7cd4e0
> [  109.134922] R10: 00007fd68a65b130 R11: 0000000000000246 R12: 00007fd68a855719
> [  109.134923] R13: 00000000304074c0 R14: 00000000304074c0 R15: 0000000030408660
> [  109.134926]  </TASK>
> [  109.962756] Key type psk unregistered
> 
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

