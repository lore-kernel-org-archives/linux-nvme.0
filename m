Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75247C54798
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3z1oyKzNLQJdiVccxMmGgPx1KH3XipRTNt7oYcX4SmM=; b=lj5p1AhK5D5SBFcNNYJcYf0MDo
	jIZa5SRuGmOykk1s8T2lIs7PhvTapqrGiisyPwKQgU0wNjRdXWfJXqpMMDbFIs6m6tATuW6uPQapw
	lVU96mK/Fw2QHTi4bbodQ1eC6WrXCQolXEgemLDyeX2xcrLPzwcsJGRnSxrSodTe+CJtU1YTRNjFT
	0xK7y2BRFccVK84ObvwrTrLYZQkpEyLNjUbHEWIPSvlGIf9HoIKLOZu3vrmoy9HeuzZhvemMS/Dmw
	VIHxho+5qdJ9blKKn38J/efMhOWJGUov2lBTQlv3Ajt9EJ7LIg2OJ0059KypRqXjfEdXFIN9kt9Ae
	P6ye8ojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1resIS-00000004DCa-1aKC;
	Tue, 27 Feb 2024 07:54:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1resIO-00000004DBS-1SVO
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 07:54:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B0FA1F444;
	Tue, 27 Feb 2024 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709020473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3z1oyKzNLQJdiVccxMmGgPx1KH3XipRTNt7oYcX4SmM=;
	b=H+qc6Fk9hOcSTvednepojv3UGOjrJs0k1qSdQ+JpfyM3FtT8RaRrh8BLsMn/fQxj5YS9K2
	IRgC/Upzz3jlAjRAMFemP+mkvKyEYJaGFIxXDRNemDQ/fMl2QwTdr5rl8HAHlKUlgLPP2k
	aTjyFozhjiYN8rmD/rhoCSKnoOuy/Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709020473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3z1oyKzNLQJdiVccxMmGgPx1KH3XipRTNt7oYcX4SmM=;
	b=W3IaLysDpE2riEcSLNCeXZzPx59Jv0sv6rvXMqtCn3m0zrjkTGvXIsrVqJ4dDemjArSer3
	tuOrEE2YXo8yUcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709020473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3z1oyKzNLQJdiVccxMmGgPx1KH3XipRTNt7oYcX4SmM=;
	b=H+qc6Fk9hOcSTvednepojv3UGOjrJs0k1qSdQ+JpfyM3FtT8RaRrh8BLsMn/fQxj5YS9K2
	IRgC/Upzz3jlAjRAMFemP+mkvKyEYJaGFIxXDRNemDQ/fMl2QwTdr5rl8HAHlKUlgLPP2k
	aTjyFozhjiYN8rmD/rhoCSKnoOuy/Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709020473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3z1oyKzNLQJdiVccxMmGgPx1KH3XipRTNt7oYcX4SmM=;
	b=W3IaLysDpE2riEcSLNCeXZzPx59Jv0sv6rvXMqtCn3m0zrjkTGvXIsrVqJ4dDemjArSer3
	tuOrEE2YXo8yUcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00CF813A65;
	Tue, 27 Feb 2024 07:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7J8DOTiV3WVQWwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Feb 2024 07:54:32 +0000
Message-ID: <c5513762-1759-4cd3-8933-7d77fdf4d2ba@suse.de>
Date: Tue, 27 Feb 2024 08:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226143013.39119-1-hare@kernel.org>
 <qdv47uxmz4n5vvsxyzh56iexjlznnvovilp2tvhwiqfvqcblqw@43x77wt3yxgq>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <qdv47uxmz4n5vvsxyzh56iexjlznnvovilp2tvhwiqfvqcblqw@43x77wt3yxgq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-8.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_235436_566790_D707711E 
X-CRM114-Status: GOOD (  19.72  )
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

On 2/27/24 08:32, Daniel Wagner wrote:
> On Mon, Feb 26, 2024 at 03:30:13PM +0100, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Any authentication errors which are generated internally are always
>> non-retryable, so set the DNR bit to ensure they are not retried.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> This replaces my hacky version 'nvme-fc: do not retry when auth fails or
> connection is refused'
> 
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 
> But with this patch at least two UAF are uncovered. I've already
> identified the first one (see comments on the v2 of this patch). The
> second one is gets triggered by loop on nvme/045
> 
> [47923.100856] [10844] nvmet: nvmet_execute_auth_send: ctrl 1 qid 0 type 0 id 0 step 4                                08:04:39 [63/9375]
> [47923.102798] [10844] nvmet: nvmet_execute_auth_send: ctrl 1 qid 0 reset negotiation
> [47923.104447] [10844] nvmet: check nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [47923.106278] [10844] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 1
> [47923.107896] [10844] nvmet: nvmet_setup_dhgroup: ctrl 1 reuse existing DH group 1
> [47923.109624] [10844] nvmet: Re-use existing hash ID 1
> [47923.115167] ==================================================================
> [47923.117175] BUG: KASAN: slab-use-after-free in base64_decode+0x10e/0x170
> [47923.117280] Read of size 1 at addr ffff88810a1d360a by task kworker/2:14/10844
> 
> [47923.119954] CPU: 2 PID: 10844 Comm: kworker/2:14 Tainted: G        W    L     6.8.0-rc3+ #39 3d0b6128d1ea3c6026a2c1de70ba6c7dc10623c3
> [47923.119954] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> [47923.123853] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
> [47923.123853] Call Trace:
> [47923.123853]  <TASK>
> [47923.123853]  dump_stack_lvl+0x5b/0x80
> [47923.127843]  print_report+0x163/0x800
> [47923.127843]  ? __virt_addr_valid+0x2f3/0x340
> [47923.127843]  ? base64_decode+0x10e/0x170
> [47923.131370]  kasan_report+0xd0/0x110
> [47923.131370]  ? base64_decode+0x10e/0x170
> [47923.131370]  base64_decode+0x10e/0x170
> [47923.131370]  nvme_auth_extract_key+0xbd/0x290 [nvme_auth c9862b6e632ff3757fc5af136ad323c2fd7ec3cc]
> [47923.131370]  nvmet_setup_auth+0x3e6/0x980 [nvmet 5699c49016b7caa62e59f3ad4cb1d5fc35e0accf]
> [47923.135839]  nvmet_execute_auth_send+0x5f6/0x1890 [nvmet 5699c49016b7caa62e59f3ad4cb1d5fc35e0accf]
> [47923.135839]  ? process_scheduled_works+0x6d4/0xf80
> [47923.138829]  process_scheduled_works+0x774/0xf80
> [47923.140513]  worker_thread+0x8c4/0xfc0
> [47923.140513]  ? __kthread_parkme+0x84/0x120
> [47923.145904]  kthread+0x25d/0x2e0
> [47923.145904]  ? __cfi_worker_thread+0x10/0x10
> [47923.145904]  ? __cfi_kthread+0x10/0x10
> [47923.145904]  ret_from_fork+0x41/0x70
> [47923.145904]  ? __cfi_kthread+0x10/0x10
> [47923.145904]  ret_from_fork_asm+0x1b/0x30
> [47923.151823]  </TASK>
> 
> [47923.153891] Allocated by task 14645 on cpu 2 at 47922.532579s:
> [47923.153891]  kasan_save_track+0x2c/0x90
> [47923.153891]  __kasan_kmalloc+0x89/0xa0
> [47923.153891]  __kmalloc_node_track_caller+0x23d/0x4e0
> [47923.153891]  kstrdup+0x34/0x60
> [47923.153891]  nvmet_auth_set_key+0xa7/0x2a0 [nvmet]
> [47923.159060]  nvmet_host_dhchap_key_store+0x10/0x20 [nvmet]
> [47923.159848]  configfs_write_iter+0x2ea/0x3c0
> [47923.159848]  vfs_write+0x80c/0xb60
> [47923.159848]  ksys_write+0xd7/0x1a0
> [47923.162639]  do_syscall_64+0xb1/0x180
> [47923.162639]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> [47923.164392] Freed by task 14645 on cpu 1 at 47923.114374s:
> [47923.164392]  kasan_save_track+0x2c/0x90
> [47923.164392]  kasan_save_free_info+0x4a/0x60
> [47923.164392]  poison_slab_object+0x108/0x180
> [47923.164392]  __kasan_slab_free+0x33/0x80
> [47923.164392]  kfree+0x119/0x310
> [47923.164392]  nvmet_auth_set_key+0x175/0x2a0 [nvmet]
> [47923.164392]  nvmet_host_dhchap_key_store+0x10/0x20 [nvmet]
> [47923.164392]  configfs_write_iter+0x2ea/0x3c0
> [47923.164392]  vfs_write+0x80c/0xb60
> [47923.164392]  ksys_write+0xd7/0x1a0
> [47923.164392]  do_syscall_64+0xb1/0x180
> [47923.164392]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> [47923.176385] The buggy address belongs to the object at ffff88810a1d3600
>                  which belongs to the cache kmalloc-64 of size 64
> [47923.178122] The buggy address is located 10 bytes inside of
>                  freed 64-byte region [ffff88810a1d3600, ffff88810a1d3640)
> 
> [47923.178122] The buggy address belongs to the physical page:
> [47923.178122] page:00000000651bcfd3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10a1d3
> [47923.178122] ksm flags: 0x17ffffc0000800(slab|node=0|zone=2|lastcpupid=0x1fffff)
> [47923.184115] page_type: 0xffffffff()
> [47923.184115] raw: 0017ffffc0000800 ffff888100042780 ffffea00044e7dc0 dead000000000003
> [47923.184115] raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
> [47923.187818] page dumped because: kasan: bad access detected
> 
> [47923.187818] Memory state around the buggy address:
> [47923.187818]  ffff88810a1d3500: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> [47923.187818]  ffff88810a1d3580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [47923.192381] >ffff88810a1d3600: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [47923.192381]                       ^
> [47923.192381]  ffff88810a1d3680: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> [47923.192381]  ffff88810a1d3700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [47923.192381] ==================================================================

Ouch.

Does this help?

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..9afc28f1ffac 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -44,6 +44,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const 
char *secret,
         dhchap_secret = kstrdup(secret, GFP_KERNEL);
         if (!dhchap_secret)
                 return -ENOMEM;
+       down_write(&nvmet_config_sem);
         if (set_ctrl) {
                 kfree(host->dhchap_ctrl_secret);
                 host->dhchap_ctrl_secret = strim(dhchap_secret);
@@ -53,6 +54,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const 
char *secret,
                 host->dhchap_secret = strim(dhchap_secret);
                 host->dhchap_key_hash = key_hash;
         }
+       up_write(&nvmet_config_sem);
         return 0;
  }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


