Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D479C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 12:05:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD79610EA
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 12:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CD79610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MmPWimHsjCiJL2MmPm8eCdvO1RwS8/XA4CCdq5R041w=; b=Z0Av53QrZw32YOVQ3H0ycHnEY7
	xynwown8E0X2I+UUSxzZhtJRlm/gIIFceY/zbRknYyxfibwmjiQ1f5aJW8yce/3i575NmgIY201iJ
	0407a/6N04kPEh733Bs46o1gyykraOF5i07inIlL1B5QBUcTALiMeOqsll8MqJt12CPrItg/A87ZU
	WZyKhEziQKTpdnt+mz9zONkTznewxRhM+LSNYGWJ6fUgLrKnOqgNCzfH0hEMEHRsKcRQ9N9a6GRk9
	W03JU6JXPG1BWCeFENymuFgwqBakuEugF833/KZuFa0PqdhyzJl6qlJMDpZ3eRB1CKSuh7uszkEFR
	SMIojuRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgQcw-00AsIc-Fe; Fri, 29 Oct 2021 12:04:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgQct-00AsHY-OT
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 12:04:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBE60212FE;
 Fri, 29 Oct 2021 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635509089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MmPWimHsjCiJL2MmPm8eCdvO1RwS8/XA4CCdq5R041w=;
 b=vJyRb+4pQFAPKA6NhU4/9+Axq5ZHPgs3NIoBIAb+llZ5AzHmCoSaZre0razBeNrMBDQVT9
 MZVeU5nGZMKZqO8ZQIY6m+qLuV3/fKRXHc06Z+n6TTCqyXlPiFcuQltIgsucd+Zsc50d+c
 Td0JdgrF25a0sUuMOzFE+LKNtkQaAyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635509089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MmPWimHsjCiJL2MmPm8eCdvO1RwS8/XA4CCdq5R041w=;
 b=Dn+gw9j2W+LTjGVHEZRcZGf28jXauz7444Npe4SkXwaAoUT2ehon0cF9kS+FaSCDWxR9QX
 earAGyuKhesWphAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D054F13D35;
 Fri, 29 Oct 2021 12:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DAuaMmHje2G4eAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 29 Oct 2021 12:04:49 +0000
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Another wierd deadlock with nvme-tcp
Message-ID: <4e06ce06-118e-2f67-8acc-e08fd58b7cbd@suse.de>
Date: Fri, 29 Oct 2021 14:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211029_050451_978400_C4B9DBF9 
X-CRM114-Status: UNSURE (   9.84  )
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

Hi Sagi,

and I've run into another weird deadlock; this time it's nvme-tcp not
flushing timed out commands when deleting the controller:

[ 1685.982355] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d"
[ 1688.533746] nvme nvme0: queue 2: timeout request 0x72 type 4
[ 1688.533781] nvme nvme0: failed to send request -104
[ 1719.254055] nvme nvme0: queue 2: timeout request 0x73 type 4
[ 1719.254091] nvme nvme0: failed to send request -32
[ 1749.974336] nvme nvme0: queue 2: timeout request 0x74 type 4
[ 1749.974367] nvme nvme0: failed to send request -32

[ .. ]

[ 2087.897536] nvme nvme0: queue 2: timeout request 0x7f type 4
[ 2087.897568] nvme nvme0: failed to send request -32
[ 2118.617840] nvme nvme0: queue 2: timeout request 0x71 type 4
[ 2118.617878] nvme nvme0: failed to send request -32
[ 2149.338133] nvme nvme0: queue 2: timeout request 0x72 type 4
[ 2149.338168] nvme nvme0: failed to send request -32
[ 2180.058428] nvme nvme0: queue 2: timeout request 0x73 type 4
[ 2180.058468] nvme nvme0: failed to send request -32
[ 2210.779140] nvme nvme0: queue 2: timeout request 0x74 type 4
[ 2210.779171] nvme nvme0: failed to send request -32
[ 2241.499022] nvme nvme0: queue 2: timeout request 0x75 type 4
[ 2241.499061] nvme nvme0: failed to send request -32
[ 2272.219324] nvme nvme0: queue 2: timeout request 0x76 type 4
[ 2272.219370] nvme nvme0: failed to send request -32
[ 2302.939635] nvme nvme0: queue 2: timeout request 0x77 type 4
[ 2302.939674] nvme nvme0: failed to send request -32
[ 2333.659936] nvme nvme0: queue 2: timeout request 0x78 type 4
[ 2333.659982] nvme nvme0: failed to send request -32
[ 2364.380226] nvme nvme0: queue 2: timeout request 0x79 type 4
[ 2364.380269] nvme nvme0: failed to send request -32
[ 2395.100476] nvme nvme0: queue 2: timeout request 0x7a type 4
[ 2395.100521] nvme nvme0: failed to send request -32
[ 2425.820806] nvme nvme0: queue 2: timeout request 0x7b type 4
[ 2425.820854] nvme nvme0: failed to send request -32
[ 2446.301004] INFO: task kworker/u4:4:304 blocked for more than 491
seconds.
[ 2446.301012]       Tainted: G        W   E     5.15.0-rc6-54-default+ #867
[ 2446.301015] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2446.301016] task:kworker/u4:4    state:D stack:    0 pid:  304 ppid:
    2 flags:0x00004000
[ 2446.301025] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 2446.301049] Call Trace:
[ 2446.301053]  __schedule+0x302/0x13a0
[ 2446.301091]  ? block_read_full_page+0x21e/0x3b0
[ 2446.301098]  ? blkdev_write_begin+0x20/0x20
[ 2446.301104]  schedule+0x3a/0xa0
[ 2446.301108]  io_schedule+0x3b/0x60
[ 2446.301111]  do_read_cache_page+0x49b/0x790
[ 2446.301119]  ? filemap_invalidate_unlock_two+0x40/0x40
[ 2446.301123]  ? sun_partition+0x370/0x370
[ 2446.301126]  read_part_sector+0x32/0xe0
[ 2446.301132]  ultrix_partition+0x2f/0x1c0
[ 2446.301136]  bdev_disk_changed+0x1e4/0x530
[ 2446.301141]  blkdev_get_whole+0x81/0x90
[ 2446.301145]  blkdev_get_by_dev+0x128/0x2d0
[ 2446.301150]  device_add_disk+0x370/0x3b0
[ 2446.301155]  nvme_mpath_set_live+0x4e/0x190 [nvme_core]
[ 2446.301168]  nvme_mpath_add_disk+0x150/0x160 [nvme_core]
[ 2446.301180]  ? device_add_disk+0x280/0x3b0
[ 2446.301184]  nvme_alloc_ns+0x417/0x940 [nvme_core]
[ 2446.301197]  nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
[ 2446.301207]  ? __nvme_submit_sync_cmd+0x195/0x200 [nvme_core]
[ 2446.301219]  nvme_scan_work+0x168/0x310 [nvme_core]
[ 2446.301231]  process_one_work+0x231/0x420
[ 2446.301238]  worker_thread+0x2d/0x3f0
[ 2446.301242]  ? process_one_work+0x420/0x420
[ 2446.301245]  kthread+0x11a/0x140
[ 2446.301249]  ? set_kthread_struct+0x40/0x40
[ 2446.301252]  ret_from_fork+0x22/0x30
[ 2446.301285] INFO: task nvme:3254 blocked for more than 491 seconds.
[ 2446.301288]       Tainted: G        W   E     5.15.0-rc6-54-default+ #867
[ 2446.301290] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2446.301291] task:nvme            state:D stack:    0 pid: 3254 ppid:
 2010 flags:0x00000000
[ 2446.301296] Call Trace:
[ 2446.301299]  __schedule+0x302/0x13a0
[ 2446.301303]  ? enqueue_entity+0xf2/0x580
[ 2446.301308]  schedule+0x3a/0xa0
[ 2446.301311]  schedule_timeout+0x115/0x280
[ 2446.301317]  ? check_preempt_curr+0x29/0x60
[ 2446.301321]  ? ttwu_do_wakeup+0x17/0x170
[ 2446.301324]  wait_for_completion+0x99/0x100
[ 2446.301329]  __flush_work+0x159/0x1e0
[ 2446.301333]  ? worker_detach_from_pool+0xb0/0xb0
[ 2446.301338]  nvme_remove_namespaces+0x3d/0xf0 [nvme_core]
[ 2446.301350]  nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
[ 2446.301360]  nvme_sysfs_delete+0x42/0x60 [nvme_core]
[ 2446.301370]  kernfs_fop_write_iter+0x12f/0x1a0
[ 2446.301376]  new_sync_write+0x122/0x1b0
[ 2446.301382]  vfs_write+0x1eb/0x250
[ 2446.301387]  ksys_write+0xa1/0xe0
[ 2446.301391]  do_syscall_64+0x3a/0x80
[ 2446.301396]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2446.301400] RIP: 0033:0x7f8a61ad7c03
[ 2446.301403] RSP: 002b:00007ffec55ad268 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 2446.301407] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f8a61ad7c03
[ 2446.301409] RDX: 0000000000000001 RSI: 000055cccc861b97 RDI:
0000000000000003
[ 2446.301411] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[ 2446.301413] R10: 00007f8a619ee468 R11: 0000000000000246 R12:
000055cccd1b8200
[ 2446.301415] R13: 0000000000000003 R14: 0000000000000000 R15:
000055cccca8d420
[ 2456.541092] nvme nvme0: queue 2: timeout request 0x7c type 4
[ 2456.541135] nvme nvme0: failed to send request -32
[ 2487.261382] nvme nvme0: queue 2: timeout request 0x7d type 4
[ 2487.261423] nvme nvme0: failed to send request -32
[ 2517.981690] nvme nvme0: queue 2: timeout request 0x7e type 4
[ 2517.981730] nvme nvme0: failed to send request -32
[ 2548.701970] nvme nvme0: queue 2: timeout request 0x7f type 4
[ 2548.702011] nvme nvme0: failed to send request -32
[ 2579.422284] nvme nvme0: queue 2: timeout request 0x71 type 4
[ 2579.422354] nvme nvme0: failed to send request -32
[ 2610.142592] nvme nvme0: queue 2: timeout request 0x72 type 4
[ 2610.142633] nvme nvme0: failed to send request -32
[ 2640.862920] nvme nvme0: queue 2: timeout request 0x73 type 4
[ 2640.862961] nvme nvme0: failed to send request -32
[ 2671.583244] nvme nvme0: queue 2: timeout request 0x74 type 4
[ 2671.583285] nvme nvme0: failed to send request -32
[ 2702.303535] nvme nvme0: queue 2: timeout request 0x75 type 4
[ 2702.303578] nvme nvme0: failed to send request -32

Odd, though; looks as if we don't failover to multipath, but rather try
to resend the command directly.

Inquiries are continuing ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

