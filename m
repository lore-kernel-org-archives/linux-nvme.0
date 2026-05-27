Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABD0CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jtk3sKcmMSeeAIVtajZSC61yh11YmTJGjbiEho3uXAg=; b=offnd096lW9JE4LubpZzC/SamD
	i7Y/8dIgbQ7eVOLxAGbDiB2tifSLvt2Wqamv440PZANGW+XKkObzcOJRhgvoOqqCH1FSVtSXgNbLB
	QXvlp1MJYn3bEn26a+Epr7ksV94vIarKeLIQX72xXneqRFvPfhJ2Xq8zO0QEqlnFXwAvsiZn2rkxr
	jAtIfHqvDuneKCkzLkycTc/9gC6ZhYlFyX5bY+p6fEI/m/GGNgbUfnJ2sLFDrz16hCuAIdXtHGXt+
	SlR7iTdMCFqipNgdJQ/wlYCrDm1D4pz/V03MmkTSQEqrrW63abeqdIqxdx37RK5p5f1kui4oAPCZt
	H6pq+ISQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS9FS-00000003Veu-1LVl;
	Wed, 27 May 2026 08:04:18 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS9FO-00000003Ve0-1lYS
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 08:04:17 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-83d31ac4017so5729456b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779869053; x=1780473853; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtk3sKcmMSeeAIVtajZSC61yh11YmTJGjbiEho3uXAg=;
        b=HbNQwb3Z0/5gbB4AYouxXDEXE5YQEjjNVS9Wls24JZ8Eku0QysDWw8nbtMGMp0dcfz
         3X6x3afP1UPA7hDdTuDD3IspVxc/fUx09LI3iQ/r3qo7bqwaS9qhxJpKZNlPcVLrufox
         D0Bkopn9WTgiVxmihMeAaPGJ6d0RE9UI02vPFxEu5JTldNYyHoxrfL3cGzHPRwtThTUy
         zrHlZoZf1asCxUGoQ6jEfSKX+SSyFqrWi1lWCzXzFoSqSp+Ey6MIkOEHmdbadR8ClwWI
         2II8YOpIMeCxyGZvKmjKRsISkMGkOb0zd3/4dz2a2wAJ16joCKn+97ahaTY3Iv2Kr/GC
         h2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869053; x=1780473853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtk3sKcmMSeeAIVtajZSC61yh11YmTJGjbiEho3uXAg=;
        b=pUZjimTX5WDcMAeR7hS5HOgKBlXTZIQ53ilNvD53pcxvug2XHrkw76Q5Kv9QVMnmP3
         z6n0ajMK+toOWrrZlLtwGUVobyXIFkFYXbmWhFJVxMAZi5+Hx7qhPZJ6nOzpnFPnYrmS
         HKIkHAYRSgOE2sta7oCo4PsKn6CmzgSRErfoNM8Ddko0uNPMria3oyLO3WaB3p3Eo72Y
         cxUv0bNP2LHwYm4ii9uGqurFdzD6WvTx9DZkHzc2G/34QWlLWSG93bOXBbw4eVZU7CEh
         64/ULraeU5zkmFadAJ3jqsiBz4mIq7h9GLvQWN8IPKhRhJ9AvjBg5hWx/bLJMFjHDpia
         cyBA==
X-Gm-Message-State: AOJu0YyOs9ftyk2mmme4i7UhVPCETfidRLuJVIShZKICuqL825xNKGiI
	kfQsPZNwpC8tmMUSh9nsv1ZRze3l/xHZC+VIMvVXz4jkvQbvlFzbghlP
X-Gm-Gg: Acq92OESwP4ApshtX/c8kCr6Tbk/kctworUPiturM4nVeNtZ9VixS9zdFluTWSTS/iq
	Z8l93CjbM6YdrDHvS5Co6Kdihf8fJ5T054hwR48oaAQH7n/4jguQPVUtWx5VQMJLL+0ZQCjy95A
	YKGehJ3mIUITxnghOnfNRDRF04O8S2jOkfXuN/wy6P9AtsqVtdmbpxK0vgmiispG8iNaW8xA+lF
	doCxNJ4gIycC0bBEFihvOGIcrny57XaiYYE8+d8EzPiaF1nOAv8Yn8z0xE1BpVl2/WSeMDEB52U
	bK1UPmtndnxdNOmqpyWPVktbPn/jFZf3dEWnGJtJq6EFMCWmWffmvQxEQZsj1DQSMnOkvdxVcn4
	X+0JLoDDkA0SlAMkFSnzVLQQqYLf11hObkDm9GE9JIVfv2UzwFYKt7wml4fbFqzISajaNuCcCIj
	Q8jNxM01PRXQ5uklsyaFgHLmYGo/JJTCpnstjhNOgUr2WZuqFaAswkSRbl2DXOhkLZ7PkbqJI=
X-Received: by 2002:a05:6a00:3a0a:b0:841:5701:16d8 with SMTP id d2e1a72fcca58-8415f6aca3dmr21580379b3a.38.1779869052685;
        Wed, 27 May 2026 01:04:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6ead585sm1922739b3a.14.2026.05.27.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:04:11 -0700 (PDT)
Date: Wed, 27 May 2026 13:34:04 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	axboe@fb.com, sagi@grimberg.me, gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
Message-ID: <ahakh0QGDYRwCBmv@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527062010.4036702-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_010414_495725_B860127F 
X-CRM114-Status: GOOD (  25.03  )
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

On Wed, May 27, 2026 at 11:50:00AM +0530, Nilay Shroff wrote:
> struct nvme_ns_head contains a flexible array member, current_path[],
> which is indexed using the NUMA node ID:
> head->current_path[numa_node_id()]
> 
> The structure is currently allocated as:
> size = sizeof(struct nvme_ns_head) +
>        (num_possible_nodes() * sizeof(struct nvme_ns *));
> head = kzalloc(size, GFP_KERNEL);
> 
> This allocation assumes that NUMA node IDs are sequential and densely
> packed from 0 .. num_possible_nodes() - 1. While this assumption holds
> on many systems, it is not always true on some architectures such as
> powerpc.
> 
> On some powerpc systems, NUMA node IDs can be sparse. For example:
> NUMA:
>   NUMA node(s):              6
>   NUMA node0 CPU(s):         80-159
>   NUMA node8 CPU(s):         0-79
>   NUMA node252 CPU(s):
>   NUMA node253 CPU(s):
>   NUMA node254 CPU(s):
>   NUMA node255 CPU(s):
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
>  which belongs to the cache kmalloc-rnd-15-2k of size 2048
> The buggy address is located 16 bytes to the right of
>  allocated 1448-byte region [c00020003bda3000, c00020003bda35a8)
> 
> The buggy address belongs to the physical page:
> 
> Memory state around the buggy address:
>  c00020003bda3480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c00020003bda3500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >c00020003bda3580: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>                                         ^
>  c00020003bda3600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  c00020003bda3680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c3032d6ad6b1..96809227a0e2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3926,7 +3926,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	int ret = -ENOMEM;
>  
>  #ifdef CONFIG_NVME_MULTIPATH
> -	size += num_possible_nodes() * sizeof(struct nvme_ns *);
> +	size += nr_node_ids * sizeof(struct nvme_ns *);
>  #endif
>  
>  	head = kzalloc(size, GFP_KERNEL);
> -- 
> 2.53.0
> 
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

