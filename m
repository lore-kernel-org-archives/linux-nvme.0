Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B085AC4725D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Wy2XtWwQ0x99+ziY1b6T3UKhjW8TTVJUKu86nA7Cvw=; b=cJxg+e8qaTG4bJTNbf2AffHsOz
	tkVDMmcjoDCqhZ4BkQLYXm7i1G+UTUlEK6nC50/BI7p1GgiPKYQQ3U+Z7mBrfMjy7xMjMvRLjKpBJ
	qTWtnZHR2ZSF4SCNIPHJ6wXnG5lqS4JOVLCNheT6JnZCNQDm/hFM6Fn7Bs8/OhoJWoq1BLJUU2kuK
	gvVLvsEhvvr7mtlWmi4ww0Tvq++VUQWRf6Zny8D9U99wdlXySN6J2H/2Wyi4Ti+gqAzysgonwem1a
	uIpEqeGpIpfrKkoC//1+wwQHMszFEJ6C7l0hOaxP+s/XbIWRjPXBQpVSJSzXtHe0NzZDjDc4Qx+eb
	8qDWXj9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqNH-00BERN-1R;
	Mon, 22 Jan 2024 09:13:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqNG-00BEQD-0H
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 09:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=+Wy2XtWwQ0x99+ziY1b6T3UKhjW8TTVJUKu86nA7Cvw=; b=PuYn4nY3sS4Fbo7jRH3DyJXC7s
	AU5b8c/losoqihsgR5iVQBbzgURv5xsXN0xRhESMeDO7SD99LKJBE7Hcz+aQlQGpndbZ9fxVI5Efi
	864bO7KSG/0diHB0VDrdczzM6E53QC+p4Bn5IbGB8MFYecC9b7ARzVTWsoGXQ20Ks64ktsuh+NYXi
	oqBvMP0jXdNdbkzZqWYxlfqbHekS/7Sl+T73JK2NGnslm+OLZeyYU/YXD9HIKt9AAeP8emXtr7k2S
	tjWzuQaO4PB/ufGb5/717nMEulBDbw7DOm9anpn/TXbNNusfR9iivvPvkSnaUyvcYS9VnJUscWzwd
	aGq3cA2A==;
Received: from bzq-219-42-90.isdn.bezeqint.net ([62.219.42.90] helo=[192.168.64.172])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRqN8-00000003CrT-39uy;
	Mon, 22 Jan 2024 09:13:41 +0000
Message-ID: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
Date: Mon, 22 Jan 2024 11:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/18/24 23:03, Stuart Hayes wrote:
> Use async function calls to make namespace scanning happen in parallel.
> 
> Without the patch, NVME namespaces are scanned serially, so it can take a
> long time for all of a controller's namespaces to become available,
> especially with a slower (TCP) interface with large number of namespaces.
> 
> The time it took for all namespaces to show up after connecting (via TCP)
> to a controller with 1002 namespaces was measured:
> 
> network latency   without patch   with patch
>       0                 6s            1s
>      50ms             210s           10s
>     100ms             417s           18s
> 

Impressive speedup. Not a very common use-case though...

> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> --
> V2: remove module param to enable/disable async scanning
>      add scan time measurements to commit message
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0af612387083..069350f85b83 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2011-2014, Intel Corporation.
>    */
>   
> +#include <linux/async.h>
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> @@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		nvme_ns_remove(ns);
>   }
>   
> -static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> +/*
> + * struct nvme_scan_state - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @count:	Next NSID to scan (for sequential scan), or
> + *		Index of next NSID to scan in ns_list (for list scan)
> + * @ns_list:	pointer to list of NSIDs to scan (NULL if sequential scan)
> + */
> +struct nvme_scan_state {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t count;
> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns(void *data, async_cookie_t cookie)

I think its better to call it nvme_scan_ns_async to indicate what
it is.

>   {
> -	struct nvme_ns_info info = { .nsid = nsid };
> +	struct nvme_ns_info info = {};
> +	struct nvme_scan_state *scan_state;
> +	struct nvme_ctrl *ctrl;
> +	u32 nsid;
>   	struct nvme_ns *ns;
>   	int ret;
>   
> +	scan_state = data;
> +	ctrl = scan_state->ctrl;

I think these assignments can be done on the declaration.

> +	nsid = (u32)atomic_fetch_add(1, &scan_state->count);
> +	/*
> +	 * get NSID from list (if scanning from a list, not sequentially)
> +	 */
> +	if (scan_state->ns_list)
> +		nsid = le32_to_cpu(scan_state->ns_list[nsid]);
> +

This is awkward. ns_list passed in optionally.
How about we limit this change to only operate on nvme_scan_ns_list?
If the controller is old or quirked to support only a sequential scan
it does not benefit from a parallel scan. I doubt that these controllers
are likely to expose a large number of namespaces anyways.

> +	info.nsid = nsid;
>   	if (nvme_identify_ns_descs(ctrl, &info))
>   		return;
>   
> @@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   	__le32 *ns_list;
>   	u32 prev = 0;
>   	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
> +	struct nvme_scan_state scan_state;
>   
>   	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>   	if (!ns_list)
>   		return -ENOMEM;
>   
> +	scan_state.ctrl = ctrl;
> +	scan_state.ns_list = ns_list;

Is there a need to have a local ns_list variable here?

>   	for (;;) {
>   		struct nvme_command cmd = {
>   			.identify.opcode	= nvme_admin_identify,
> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   			goto free;
>   		}
>   
> +		/*
> +		 * scan list starting at list offset 0
> +		 */
> +		atomic_set(&scan_state.count, 0);
>   		for (i = 0; i < nr_entries; i++) {
>   			u32 nsid = le32_to_cpu(ns_list[i]);
>   
>   			if (!nsid)	/* end of the list? */
>   				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>   			while (++prev < nsid)
>   				nvme_ns_remove_by_nsid(ctrl, prev);
>   		}
> +		async_synchronize_full_domain(&domain);
>   	}
>    out:
>   	nvme_remove_invalid_namespaces(ctrl, prev);

Is it a good idea to remove the invalid namespaces before synchronizing
the async scans?

>    free:
> +	async_synchronize_full_domain(&domain);
>   	kfree(ns_list);
>   	return ret;
>   }
> @@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_id_ctrl *id;
>   	u32 nn, i;
> +	ASYNC_DOMAIN(domain);
> +	struct nvme_scan_state scan_state;
>   
>   	if (nvme_identify_ctrl(ctrl, &id))
>   		return;
>   	nn = le32_to_cpu(id->nn);
>   	kfree(id);
>   
> +	scan_state.ctrl = ctrl;
> +	/*
> +	 * scan sequentially starting at NSID 1
> +	 */
> +	atomic_set(&scan_state.count, 1);
> +	scan_state.ns_list = NULL;
>   	for (i = 1; i <= nn; i++)
> -		nvme_scan_ns(ctrl, i);
> +		async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
> +	async_synchronize_full_domain(&domain);
>   
>   	nvme_remove_invalid_namespaces(ctrl, nn);
>   }

I think we need a blktest for this. ns scanning has been notorious when
running simultaneously with controller reset/reconnect/remove
sequences... Ideally a test with a larger number of namespaces to
exercise the code.

Also, make sure that blktest suite does not complain about anything
else.

