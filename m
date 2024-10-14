Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C79D16268
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mATt5kWfwc6mUUsnzB+tw8KmdCpTKTdc9CwtoDNzAcE=; b=jSXoJVzvAH2u95H70hVlYQthzW
	IE3jSiShHCs5pHGrmwR0GF5IH9fGLzBN4Xr1TRzNVuWwCUR1dj1BqEzGPZlqS6TUW+sDdoc10ZoZH
	CgvHTL6ZesHcXdOjjsqYEntYlc0bz8/o8/+kWAH+ns4KINYjmJddBOojsjVe0Mvb6zEupU1Ub6bP7
	dCQe1KTL66WdQda5vrnzK+JNZJo8wON8mD3ZQ6/Ujq6fnYsiiB9dOMekXHFS8/eFHDcMFoCqsobom
	ibAvY1/7p22N3Pxuf05dlaPaD4OevuWPzP1067q0E00Z8ZdYkuLawV50dBo4Y3ojON/zRaRJekzDU
	3PU+HSGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0LbA-00000005OU5-2Bhq;
	Mon, 14 Oct 2024 13:59:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0KoJ-00000005CP2-3vJf
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 13:08:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DF511FE57;
	Mon, 14 Oct 2024 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mATt5kWfwc6mUUsnzB+tw8KmdCpTKTdc9CwtoDNzAcE=;
	b=qTUjmhJpwf+No+C2Rxkodhj4VJtB9x0cKHmXnu+3SmV8Z6zPi8bzkeXjaTxqg478wr0lBm
	kkfC5iYiIo3zC6Ox9DoK1yVtN7vEqYDqbNGazxF1QHHy3PpI3ydDtcOPF174tLWoFxg5/1
	6lGlyhn7z3JScBBcXJ/PmTijXXYT37M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mATt5kWfwc6mUUsnzB+tw8KmdCpTKTdc9CwtoDNzAcE=;
	b=SJG+1O+DsqJSAwaNpigg1/MTKGAjW36j5CkHsVz3QMfilNJEry8bZO++70pc724EsRXxxo
	2R5+d+Q9o5O1WFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mATt5kWfwc6mUUsnzB+tw8KmdCpTKTdc9CwtoDNzAcE=;
	b=qTUjmhJpwf+No+C2Rxkodhj4VJtB9x0cKHmXnu+3SmV8Z6zPi8bzkeXjaTxqg478wr0lBm
	kkfC5iYiIo3zC6Ox9DoK1yVtN7vEqYDqbNGazxF1QHHy3PpI3ydDtcOPF174tLWoFxg5/1
	6lGlyhn7z3JScBBcXJ/PmTijXXYT37M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mATt5kWfwc6mUUsnzB+tw8KmdCpTKTdc9CwtoDNzAcE=;
	b=SJG+1O+DsqJSAwaNpigg1/MTKGAjW36j5CkHsVz3QMfilNJEry8bZO++70pc724EsRXxxo
	2R5+d+Q9o5O1WFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538F113A42;
	Mon, 14 Oct 2024 13:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9tkpEs4XDWd0TwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 13:08:30 +0000
Date: Mon, 14 Oct 2024 15:08:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp uaf when tls setup fails
Message-ID: <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_060832_168597_FAB8DA25 
X-CRM114-Status: GOOD (  17.36  )
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

On Mon, Oct 14, 2024 at 01:54:42PM GMT, Daniel Wagner wrote:
> FYI, I am working on extending nvme-cli to use the newly added
> tls_configured_key and tls_keyring sysfs. While playing around, KASAN
> reported an error on the current 6.12-rc3:
> 
>  nvme nvme1: creating 8 I/O queues.
>  nvme nvme1: mapped 8/0/0 default/read/poll queues.
>  nvme nvme1: Connect command failed, errno: -18
>  nvme nvme1: failed to connect queue: 3 ret=-18
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in blk_mq_queue_tag_busy_iter+0x3ec/0x430
>  Read of size 4 at addr ffff8880156a8194 by task kworker/1:1H/169
> 
>  CPU: 1 UID: 0 PID: 169 Comm: kworker/1:1H Not tainted 6.12.0-rc3-1-default #247 45def3a9beaa5cc1f0fb63a7039570d73ee4a307
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
>  Workqueue: kblockd blk_mq_timeout_work
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x73/0xa0
>   print_report+0x165/0x720
>   ? __virt_addr_valid+0x165/0x340
>   ? __virt_addr_valid+0x2fb/0x340
>   ? blk_mq_queue_tag_busy_iter+0x3ec/0x430
>   kasan_report+0xce/0x110
>   ? blk_mq_queue_tag_busy_iter+0x3ec/0x430
>   blk_mq_queue_tag_busy_iter+0x3ec/0x430
>   ? __pfx_blk_mq_check_expired+0x10/0x10
>   blk_mq_timeout_work+0x94/0x280
>   ? process_scheduled_works+0x841/0x1220
>   process_scheduled_works+0x8c4/0x1220
>   worker_thread+0x8f5/0xd50
>   ? __kthread_parkme+0x7e/0x190
>   ? __kthread_parkme+0x7e/0x190
>   ? __kthread_parkme+0x7e/0x190
>   kthread+0x270/0x2f0
>   ? __pfx_worker_thread+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x33/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
>  Allocated by task 1751:
>   kasan_save_track+0x2b/0x70
>   __kasan_kmalloc+0x89/0xa0
>   __kmalloc_cache_noprof+0x1d9/0x3c0
>   nvme_tcp_create_ctrl+0x57/0xac0 [nvme_tcp]
>   nvmf_dev_write+0x1bd1/0x22c0 [nvme_fabrics]
>   vfs_write+0x1cc/0x9f0
>   ksys_write+0xac/0x150
>   do_syscall_64+0x96/0x160
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  Freed by task 1751:
>   kasan_save_track+0x2b/0x70
>   kasan_save_free_info+0x3c/0x50
>   __kasan_slab_free+0x59/0x70
>   kfree+0x171/0x400
>   nvme_free_ctrl+0x38f/0x470 [nvme_core]
>   device_release+0x8d/0x180
>   kobject_put+0x1e8/0x3b0
>   nvme_tcp_create_ctrl+0x85a/0xac0 [nvme_tcp]
>   nvmf_dev_write+0x1bd1/0x22c0 [nvme_fabrics]
>   vfs_write+0x1cc/0x9f0
>   ksys_write+0xac/0x150
>   do_syscall_64+0x96/0x160
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  The buggy address belongs to the object at ffff8880156a8000
>   which belongs to the cache kmalloc-8k of size 8192
>  The buggy address is located 404 bytes inside of
>   freed 8192-byte region [ffff8880156a8000, ffff8880156aa000)
> 
>  The buggy address belongs to the physical page:
>  page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x156a8
>  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
>  page_type: f5(slab)
>  raw: 000fffffc0000040 ffff888008443180 dead000000000100 dead000000000122
>  raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
>  head: 000fffffc0000040 ffff888008443180 dead000000000100 dead000000000122
>  head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
>  head: 000fffffc0000003 ffffea000055aa01 ffffffffffffffff 0000000000000000
>  head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
> 
>  Memory state around the buggy address:
>   ffff8880156a8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8880156a8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >ffff8880156a8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                           ^
>   ffff8880156a8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8880156a8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ==================================================================
> 
> 
> ./nvme connect -t tcp -a 192.168.154.148 -s 4420 -q nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36 --hostnqn nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36 --hostid befdec4c-2234-11b2-a85c-ca77c773af36 -n nqn.io-1 --tls -vv
> Error opening /usr/local/etc/nvme/config.json, No such file or directory
> scan controller nvme0
> warning: using auto generated hostid and hostnqn
> lookup subsystem /sys/class/nvme-subsystem/nvme-subsys0/nvme0
> skipping namespace scan for ctrl nvme0
> skipping path scan for ctrl nvme0
> scan subsystem nvme-subsys0
> skipping namespace scan for subsys nqn.2019-08.org.qemu:nvme-0
> kernel supports: instance cntlid transport traddr trsvcid nqn queue_size nr_io_queues reconnect_delay ctrl_loss_tmo keep_alive_tmo hostnqn host_traddr host_iface hostid duplicate_connect disable_sqflow hdr_digest data_digest nr_write_queues nr_poll_queues tos keyring tls_key fast_io_fail_tmo discovery dhchap_secret dhchap_ctrl_secret tls
> option "concat" ignored
> connect ctrl, 'nqn=nqn.io-1,transport=tcp,traddr=192.168.154.148,trsvcid=4420,hostnqn=nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36,hostid=befdec4c-2234-11b2-a85c-ca77c773af36,ctrl_loss_tmo=600,tls'
> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> could not add new controller: failed to write to nvme-fabrics device

The logs say that the connect to queue 3 fails, but it seems this
command never got send out (ftrace):

    kworker/4:0H-759     [004] .....  8771.165686: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=1, sqsize=127, cattr=0, kato=0)
          <idle>-0       [004] ..s1.  8771.172062: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
    kworker/5:0H-796     [005] .....  8771.172422: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=2, sqsize=127, cattr=0, kato=0)
          <idle>-0       [005] ..s1.  8771.178292: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0

And it is very reliable to reproduce it.

