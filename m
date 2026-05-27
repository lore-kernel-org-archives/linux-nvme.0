Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674B0CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKwPCRgiwy54zzESk/BYRSv+mmqNoT5xH1lfnhHpLUg=; b=d7CCxconnRfjSBzPArKi80bACg
	FprqlJXjr0Aq1WyHbcT14mSuMAoPwEzYkS1SdE1S6BOAEWF4xn/HUUJYw4zBNs5U9sCZQTpNFEau9
	e7diADbBh++RsKAOxLlXfhmklMBgfs1tW0sfDLpkbbYI+WO85X7YZ/VvKPZLU51gqgF7moMCZT4ro
	U//4rQzyHpQGTNfYoaRlVr3HukGnAooOtMiocOCokKMIJEVwpVTOCkDNJhJuy3a33dPYWF86K3+a4
	03WbuQwJQ7g90sqznjVB7a+BW/yIMWGGkulaO9n+mXbNpdotmt8/T+sLsUzSYmAcUn7oNAou5V1zf
	oQZupl5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEQl-00000004Cwd-38rH;
	Wed, 27 May 2026 13:36:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEQi-00000004CvQ-38Gw
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:36:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAAB467823;
	Wed, 27 May 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779888974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKwPCRgiwy54zzESk/BYRSv+mmqNoT5xH1lfnhHpLUg=;
	b=La8zwylrfZIMWTbV5CPBm+j1cmuJmyMkROxjXIK2HheHm/uwV8ueq+9t/ImQKsGktP3vlb
	CVNQKbqwrT0hTAucUVMMueiIDyeSal8i9SWvhxmMzK3AT/CpcoOwqlZx/0tu8IBtR6vK6p
	RGtKmFfiZLdfZgAEDwEBbPIHyEBiGqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779888974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKwPCRgiwy54zzESk/BYRSv+mmqNoT5xH1lfnhHpLUg=;
	b=TpriWVT/qsrw6SWvs+NBJrQqQnuiH/Hd2VYsfFhtC03P+o1Ejwe2McjEXOPIgUpBYD+PMD
	tWy2CJvaRxCpruAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779888974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKwPCRgiwy54zzESk/BYRSv+mmqNoT5xH1lfnhHpLUg=;
	b=La8zwylrfZIMWTbV5CPBm+j1cmuJmyMkROxjXIK2HheHm/uwV8ueq+9t/ImQKsGktP3vlb
	CVNQKbqwrT0hTAucUVMMueiIDyeSal8i9SWvhxmMzK3AT/CpcoOwqlZx/0tu8IBtR6vK6p
	RGtKmFfiZLdfZgAEDwEBbPIHyEBiGqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779888974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKwPCRgiwy54zzESk/BYRSv+mmqNoT5xH1lfnhHpLUg=;
	b=TpriWVT/qsrw6SWvs+NBJrQqQnuiH/Hd2VYsfFhtC03P+o1Ejwe2McjEXOPIgUpBYD+PMD
	tWy2CJvaRxCpruAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A09485A85E;
	Wed, 27 May 2026 13:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ld3/JU7zFmryLgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 13:36:14 +0000
Message-ID: <76961bc6-d752-4141-a6b3-b30b94195cef@suse.de>
Date: Wed, 27 May 2026 15:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me,
 gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260527062010.4036702-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_063617_083079_2A282BE0 
X-CRM114-Status: GOOD (  22.29  )
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

On 5/27/26 08:20, Nilay Shroff wrote:
> struct nvme_ns_head contains a flexible array member, current_path[],
> which is indexed using the NUMA node ID:
> head->current_path[numa_node_id()]
> 
> The structure is currently allocated as:
> size = sizeof(struct nvme_ns_head) +
>         (num_possible_nodes() * sizeof(struct nvme_ns *));
> head = kzalloc(size, GFP_KERNEL);
> 
> This allocation assumes that NUMA node IDs are sequential and densely
> packed from 0 .. num_possible_nodes() - 1. While this assumption holds
> on many systems, it is not always true on some architectures such as
> powerpc.
> 
> On some powerpc systems, NUMA node IDs can be sparse. For example:
> NUMA:
>    NUMA node(s):              6
>    NUMA node0 CPU(s):         80-159
>    NUMA node8 CPU(s):         0-79
>    NUMA node252 CPU(s):
>    NUMA node253 CPU(s):
>    NUMA node254 CPU(s):
>    NUMA node255 CPU(s):
> 
> That is, the possible/online NUMA node IDs are: 0, 8, 252, 253, 254, 255
> In this case: num_possible_nodes() = 6
> 
> So memory is allocated for only 6 entries in current_path[]. However,
> the array is later indexed using the actual NUMA node ID. As a result,
> accesses such as:
> head->current_path[8] or
> head->current_path[252]
> goes out of bounds, leading to the following KASAN splat:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in nvme_mpath_revalidate_paths+0x22c/0x290 [nvme_core]
> Write of size 8 at addr c00020003bda35b8 by task kworker/u641:2/1997
> 
> CPU: 1 UID: 0 PID: 1997 Comm: kworker/u641:2 Not tainted 7.1.0-rc5-dirty #14 PREEMPT(lazy)
> Hardware name: 8335-GTH POWER9 0x4e1202 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
> Workqueue: async async_run_entry_fn
> Call Trace:
> [c000200037fa7510] [c0000000021c23d4] dump_stack_lvl+0x88/0xdc (unreliable)
> [c000200037fa7540] [c0000000009fda90] print_report+0x22c/0x67c
> [c000200037fa7630] [c0000000009fd508] kasan_report+0x108/0x220
> [c000200037fa7740] [c0000000009fff48] __asan_store8+0xe8/0x120
> [c000200037fa7760] [c008000018e76474] nvme_mpath_revalidate_paths+0x22c/0x290 [nvme_core]
> [c000200037fa7800] [c008000018e6556c] nvme_update_ns_info+0x4a4/0x5e0 [nvme_core]
> [c000200037fa7a50] [c008000018e66270] nvme_alloc_ns+0x6d8/0x1a70 [nvme_core]
> [c000200037fa7c20] [c008000018e679fc] nvme_scan_ns+0x3f4/0x630 [nvme_core]
> [c000200037fa7d10] [c00000000031f22c] async_run_entry_fn+0x9c/0x3a0
> [c000200037fa7db0] [c0000000002fa544] process_one_work+0x414/0xa10
> [c000200037fa7ec0] [c0000000002fbf00] worker_thread+0x320/0x640
> [c000200037fa7f80] [c00000000030d0f8] kthread+0x278/0x290
> [c000200037fa7fe0] [c00000000000ded8] start_kernel_thread+0x14/0x18
> 
> Allocated by task 1997 on cpu 1 at 35.928317s:
> 
> The buggy address belongs to the object at c00020003bda3000
>   which belongs to the cache kmalloc-rnd-15-2k of size 2048
> The buggy address is located 16 bytes to the right of
>   allocated 1448-byte region [c00020003bda3000, c00020003bda35a8)
> 
> The buggy address belongs to the physical page:
> 
> Memory state around the buggy address:
>   c00020003bda3480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   c00020003bda3500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c00020003bda3580: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>                                          ^
>   c00020003bda3600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   c00020003bda3680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> Fix this by allocating the flexible array using nr_node_ids instead
> of num_possible_nodes(). Since nr_node_ids represents the maximum
> possible NUMA node IDs, indexing current_path[] using numa_node_id()
> becomes safe even on systems with sparse node IDs.
> 
> Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c3032d6ad6b1..96809227a0e2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3926,7 +3926,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	int ret = -ENOMEM;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
> -	size += num_possible_nodes() * sizeof(struct nvme_ns *);
> +	size += nr_node_ids * sizeof(struct nvme_ns *);
>   #endif
>   
>   	head = kzalloc(size, GFP_KERNEL);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

