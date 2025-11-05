Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BB9CCFA04
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0CLAdsD17qsHz35woo/w5VxXW3IslnC8sJctuTclKM=; b=gLVY1VUZLd0Zraaf7GgUv+VqZs
	hSDMA37mMaKC+4FjmX2pBn2iTXlCvnAMRtd0ZD5SAvy4TsbCNR466Gxml6cLqeFMdgn3lcD5cYnku
	PLlesyS+tqK5jtXINgW55lPHQXEkxmAiVm/zXLrAhdC+eev8tLYpxN1IrwAA1UjREJAd+VP1MihlT
	xE0Q6TbcF6BwZNCu7rdNo8PIR9n52B04pOWpnxwr4S0ODMI2/HUeOhmL9SfA63KzXjIQ2j8fZqcBF
	58yIm4nF42nmHUTQIrvE8ciIDygK6iy2e4Uxjqtqz8zcA4AA/XCIv+cNFVmgHKZHsFaOM4b+dc4GC
	tChybT1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY5r-0000000DDMl-1uOj;
	Wed, 05 Nov 2025 07:38:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY5o-0000000DDMM-1RTF
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:38:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A26A1F394;
	Wed,  5 Nov 2025 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0CLAdsD17qsHz35woo/w5VxXW3IslnC8sJctuTclKM=;
	b=v4RM9w1bc4blxniGGBMnWjjLG6xI6V5E4W3oxgeZJINlHjo/2UjTU9aIS2Z3bXs0VJCbPv
	aT1694HwnbxFRbL/AT1XfrGu4KN9ZyyzS8hedWFMBJzIRKDOx1Mdgpq7QQv5R9m0cG4cS7
	OY22xxb+a9FITps0Q6hI7I3szEt1Xtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0CLAdsD17qsHz35woo/w5VxXW3IslnC8sJctuTclKM=;
	b=0bZS5apvfFJQFZJlFElIRQxlM40fX/hP4BEGgoABnmhZHpe1Ra8FlB7AndxQNwPVXpv+KB
	By9j1Q7ZablalGCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v4RM9w1b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0bZS5apv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0CLAdsD17qsHz35woo/w5VxXW3IslnC8sJctuTclKM=;
	b=v4RM9w1bc4blxniGGBMnWjjLG6xI6V5E4W3oxgeZJINlHjo/2UjTU9aIS2Z3bXs0VJCbPv
	aT1694HwnbxFRbL/AT1XfrGu4KN9ZyyzS8hedWFMBJzIRKDOx1Mdgpq7QQv5R9m0cG4cS7
	OY22xxb+a9FITps0Q6hI7I3szEt1Xtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0CLAdsD17qsHz35woo/w5VxXW3IslnC8sJctuTclKM=;
	b=0bZS5apvfFJQFZJlFElIRQxlM40fX/hP4BEGgoABnmhZHpe1Ra8FlB7AndxQNwPVXpv+KB
	By9j1Q7ZablalGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2430132DD;
	Wed,  5 Nov 2025 07:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id et/TKt3+Cmm3LgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:38:05 +0000
Message-ID: <8ee962ed-3fa8-41c8-9c29-6237fc1da5dd@suse.de>
Date: Wed, 5 Nov 2025 08:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, ming.lei@redhat.com, chaitanyak@nvidia.com,
 Keith Busch <kbusch@kernel.org>, Casey Chen <cachen@purestorage.com>
References: <20251104225939.3641605-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A26A1F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_233808_538717_F1E44F5E 
X-CRM114-Status: GOOD (  20.02  )
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

On 11/4/25 23:59, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The namespaces can access the controller's admin request_queue, and
> stale references on the namespaces may exist. Ensure the request_queue
> is active by moving the controller's 'put' after all references on the
> controller have been released to ensure no one is trying to access the
> request_queue. This fixes a reported use-after-free bug:
> 
>    BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
>    Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
>    CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.2-ga1582f1a031e #15
>    Tainted: [E]=UNSIGNED_MODULE
>    Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x4f/0x60
>     print_report+0xc4/0x620
>     ? _raw_spin_lock_irqsave+0x70/0xb0
>     ? _raw_read_unlock_irqrestore+0x30/0x30
>     ? blk_queue_enter+0x41c/0x4a0
>     kasan_report+0xab/0xe0
>     ? blk_queue_enter+0x41c/0x4a0
>     blk_queue_enter+0x41c/0x4a0
>     ? __irq_work_queue_local+0x75/0x1d0
>     ? blk_queue_start_drain+0x70/0x70
>     ? irq_work_queue+0x18/0x20
>     ? vprintk_emit.part.0+0x1cc/0x350
>     ? wake_up_klogd_work_func+0x60/0x60
>     blk_mq_alloc_request+0x2b7/0x6b0
>     ? __blk_mq_alloc_requests+0x1060/0x1060
>     ? __switch_to+0x5b7/0x1060
>     nvme_submit_user_cmd+0xa9/0x330
>     nvme_user_cmd.isra.0+0x240/0x3f0
>     ? force_sigsegv+0xe0/0xe0
>     ? nvme_user_cmd64+0x400/0x400
>     ? vfs_fileattr_set+0x9b0/0x9b0
>     ? cgroup_update_frozen_flag+0x24/0x1c0
>     ? cgroup_leave_frozen+0x204/0x330
>     ? nvme_ioctl+0x7c/0x2c0
>     blkdev_ioctl+0x1a8/0x4d0
>     ? blkdev_common_ioctl+0x1930/0x1930
>     ? fdget+0x54/0x380
>     __x64_sys_ioctl+0x129/0x190
>     do_syscall_64+0x5b/0x160
>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    RIP: 0033:0x7f765f703b0b
>    Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
>    RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
>    RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
>    RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
>    R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
>    R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
>     </TASK>
> 
> Reported-by: Casey Chen <cachen@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa4181d7de736..0b83d82f67e75 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_stop_keep_alive(ctrl);
>   	blk_mq_destroy_queue(ctrl->admin_q);
> -	blk_put_queue(ctrl->admin_q);
>   	if (ctrl->ops->flags & NVME_F_FABRICS) {
>   		blk_mq_destroy_queue(ctrl->fabrics_q);
>   		blk_put_queue(ctrl->fabrics_q);
> @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
>   		container_of(dev, struct nvme_ctrl, ctrl_device);
>   	struct nvme_subsystem *subsys = ctrl->subsys;
>   
> +	blk_put_queue(ctrl->admin_q);
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
>   	nvme_free_cels(ctrl);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

