Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E3D58E6E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 06:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0p31MFKSng0g7m9o6jOdB4/JvpV9PHTBKYh7jECMMA=; b=DBYqSa7jcfbLoSZT7hKwd3IFLo
	03rvxa2HD3Db+pYmNtdNcmoUyI82WycPIdQJnOcQUUOUd0ji2Mg/sHOit0FtV35rmJNZq6n6YRctV
	Rs/2ECSvYLDFceU4C8EgQYyeO8kV3pTw30XuVhHEfqpCRpUwbA6TT1XW18pmpSpmD6KZtpw6OVis+
	F/9WPUuduoWYZLbHJzorbWj3YZQWc6Om08hKQFffGxYDl6pSPjWeJcphfdk87SqDkObn8wUQcf42N
	oOZ66v09y16NhoGU1xqVY70m2M5VT4qnxIofFOlWNicgs1S6mpBJf5R4tDL8dKby04v2B4hMa0b7k
	AjkLDEHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxCs-0000000CNGz-2Icl;
	Mon, 02 Mar 2026 06:56:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxCl-0000000CNGB-2eOm
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 06:56:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6578F3E7C9;
	Mon,  2 Mar 2026 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772434592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0p31MFKSng0g7m9o6jOdB4/JvpV9PHTBKYh7jECMMA=;
	b=uzMaIBUCwTwOeTkjdkSyi20bIacQc8HjX6j6enp6w73XDC7DKLS4QB1FU1CRdtHGiyqeDV
	EMAqVi8EM7uparAinPEtMH61j5YXUjqX73+G4knn6FAdBhP1YZLcBDgALM9vFwOuOEU6U6
	O/KJfRk2BnP8ch15HTsj0rKFROBUnms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772434592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0p31MFKSng0g7m9o6jOdB4/JvpV9PHTBKYh7jECMMA=;
	b=Z3wtw3VjUHVlhnAowo1kdNFwr0CvokqJHluEaxDwrbb64CWOAVM5g4GgPvClzyAD6wRknm
	xc4hj0rsMN3BaoCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772434592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0p31MFKSng0g7m9o6jOdB4/JvpV9PHTBKYh7jECMMA=;
	b=uzMaIBUCwTwOeTkjdkSyi20bIacQc8HjX6j6enp6w73XDC7DKLS4QB1FU1CRdtHGiyqeDV
	EMAqVi8EM7uparAinPEtMH61j5YXUjqX73+G4knn6FAdBhP1YZLcBDgALM9vFwOuOEU6U6
	O/KJfRk2BnP8ch15HTsj0rKFROBUnms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772434592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0p31MFKSng0g7m9o6jOdB4/JvpV9PHTBKYh7jECMMA=;
	b=Z3wtw3VjUHVlhnAowo1kdNFwr0CvokqJHluEaxDwrbb64CWOAVM5g4GgPvClzyAD6wRknm
	xc4hj0rsMN3BaoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A40BB3EA69;
	Mon,  2 Mar 2026 06:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BYxBJZ80pWmlUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 06:56:31 +0000
Message-ID: <ca0c087a-3afb-4a88-97e6-78fe94130ae7@suse.de>
Date: Mon, 2 Mar 2026 07:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
To: Sungwoo Kim <iam@sung-woo.kim>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Mike Christie <michael.christie@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
 Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260228001927.382810-3-iam@sung-woo.kim>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260228001927.382810-3-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_225635_816834_19FB44A1 
X-CRM114-Status: GOOD (  16.72  )
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

On 2/28/26 01:19, Sungwoo Kim wrote:
> nvme_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for rse via struct_size(). The upper
> limit is PR_KEYS_MAX (64K).
> 
> A malicious or buggy userspace can pass a large num_keys value that
> results in a 4MB allocation attempt at most, causing a warning in
> the page allocator when the order exceeds MAX_PAGE_ORDER.
> 
> To fix this, use kvzalloc() instead of kzalloc().
> 
> This bug has the same reasoning and fix with the patch below:
> https://lore.kernel.org/linux-block/20251212013510.3576091-1-kartikey406@gmail.com/
> 
> Warning log:
> WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216, CPU#1: syz-executor117/272
> Modules linked in:
> CPU: 1 UID: 0 PID: 272 Comm: syz-executor117 Not tainted 6.19.0 #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216
> Code: ff 83 bd a8 fe ff ff 0a 0f 86 69 fb ff ff 0f b6 1d f9 f9 c4 04 80 fb 01 0f 87 3b 76 30 ff 83 e3 01 75 09 c6 05 e4 f9 c4 04 01 <0f> 0b 48 c7 85 70 fe ff ff 00 00 00 00 e9 8f fd ff ff 31 c0 e9 0d
> RSP: 0018:ffffc90000fcf450 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff920001f9ea0
> RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040dc0
> RBP: ffffc90000fcf648 R08: ffff88800b6c3380 R09: 0000000000000001
> R10: ffffc90000fcf840 R11: ffff88807ffad280 R12: 0000000000000000
> R13: 0000000000040dc0 R14: 0000000000000001 R15: ffffc90000fcf620
> FS:  0000555565db33c0(0000) GS:ffff8880be26c000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002000000c CR3: 0000000003b72000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   alloc_pages_mpol+0x236/0x4d0 mm/mempolicy.c:2486
>   alloc_frozen_pages_noprof+0x149/0x180 mm/mempolicy.c:2557
>   ___kmalloc_large_node+0x10c/0x140 mm/slub.c:5598
>   __kmalloc_large_node_noprof+0x25/0xc0 mm/slub.c:5629
>   __do_kmalloc_node mm/slub.c:5645 [inline]
>   __kmalloc_noprof+0x483/0x6f0 mm/slub.c:5669
>   kmalloc_noprof include/linux/slab.h:961 [inline]
>   kzalloc_noprof include/linux/slab.h:1094 [inline]
>   nvme_pr_read_keys+0x8f/0x4c0 drivers/nvme/host/pr.c:245
>   blkdev_pr_read_keys block/ioctl.c:456 [inline]
>   blkdev_common_ioctl+0x1b71/0x29b0 block/ioctl.c:730
>   blkdev_ioctl+0x299/0x700 block/ioctl.c:786
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl fs/ioctl.c:583 [inline]
>   __x64_sys_ioctl+0x1bf/0x220 fs/ioctl.c:583
>   x64_sys_call+0x1280/0x21b0 mnt/fuzznvme_1/fuzznvme/linux-build/v6.19/./arch/x86/include/generated/asm/syscalls_64.h:17
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fb893d3108d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffff61f2f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffff61f3138 RCX: 00007fb893d3108d
> RDX: 0000000020000040 RSI: 00000000c01070ce RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff61f3138
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffff61f3128 R14: 00007fb893dae530 R15: 0000000000000001
>   </TASK>
> 
> Fixes: 5fd96a4e15de (nvme: Add pr_ops read_keys support)
> Acked-by: Chao Shi <cshi008@fiu.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> v2: add missing kvfree
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

