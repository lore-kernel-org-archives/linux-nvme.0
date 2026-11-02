Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C50606A329
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UwG/+zbn;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tg47q/4A;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nMt8BHjk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tg47q/4A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=; b=UwG/+zbnq9rcA6
	FZEBoU7KhufNjqrqTdS2i2PFLdmEoFKgiZ8r8LnAA3rQ/IvkSTivIpL38gV1R/tU+HDncRuy1m6u3
	0WWvb5G9tH8x5Ushi+37eTsK5RTyYGio40VendpQWkZFqBz4Bq1peVaCzXUpyilsaN8s5bT/ap5xE
	8CsdvZl8ALXQyjAo9SyirsLYXo1fxG4B3yYPAhQSqFJPXDHreOl+Vt6XpdzflLioLqsB38I66nsWq
	InUr+AwvK/X2C3xAkSwJN25bligH2ZyJgp3J2p+dySoVMwByDJlNfGdw7x9PZ3bxeS4GWurk+v9+M
	9hNjl+mToEwb6VEeHiSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmRb-0000000Fk2P-2wMH;
	Mon, 02 Nov 2026 07:27:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmRY-0000000Fk21-2Veq
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 07:27:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0D541F788;
	Mon,  2 Nov 2026 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=nMt8BHjky/1S3YlOjl184PVLOw65SCzlu4n73GFxSTVyupFfIGsS3VqtuQJWBGZ6gyI0NT
	XVEHCJKEzsW0pz4z1z3NuWBLYtg+8+UQETgXeqwb7OEiJEWe/hPuK9S/zj9F7bYG08G77O
	Q+ysKX66LokrFu0L6P09u4g8D3/wsUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=tg47q/4AJwq592NmqX2E0MwXUjLzXsl+/I0fHmMcZNh0cuTBsSi0NUXMPOEbfufoYhKzRh
	vNp4CMc0n7chf0Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=nMt8BHjky/1S3YlOjl184PVLOw65SCzlu4n73GFxSTVyupFfIGsS3VqtuQJWBGZ6gyI0NT
	XVEHCJKEzsW0pz4z1z3NuWBLYtg+8+UQETgXeqwb7OEiJEWe/hPuK9S/zj9F7bYG08G77O
	Q+ysKX66LokrFu0L6P09u4g8D3/wsUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH0IBD57jKAGJCpKPw6WuC+ywmk1dUAZkICAD3tTpTk=;
	b=tg47q/4AJwq592NmqX2E0MwXUjLzXsl+/I0fHmMcZNh0cuTBsSi0NUXMPOEbfufoYhKzRh
	vNp4CMc0n7chf0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4371E134B3;
	Mon,  2 Nov 2026 07:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBfCAEI76GpfbQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 07:26:58 +0000
Message-ID: <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
Date: Mon, 2 Nov 2026 08:26:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: remove namespaces in parallel
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
 <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,linux.ibm.com,wdc.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_232700_812711_69F73CFB 
X-CRM114-Status: GOOD (  25.96  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 7:14 AM, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
But that isn't changed by calling async_schedule_domain, isn't it?

> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> Remove the namespaces through an async domain the same way, and wait
> for all of them before returning.
> 
> Disconnect time from a target on the same host, over tcp to 127.0.0.1
> and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
> boots per kernel:
> 
>    namespaces  transport  before              after
>             8  tcp         170 /  171 ms        85 /   91 ms
>            32  tcp         628 /  628 ms       294 /  293 ms
>            64  tcp        1201 / 1308 ms       533 /  550 ms
>            64  loop       1988 / 1913 ms      1283 / 1200 ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>   drivers/nvme/host/core.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..18948c2ba218d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4716,6 +4716,11 @@ static void nvme_scan_work(struct work_struct *work)
>   #endif
>   }
>   
> +static void nvme_ns_remove_async(void *data, async_cookie_t cookie)
> +{
> +	nvme_ns_remove(data);
> +}
> +
>   /*
>    * This function iterates the namespace list unlocked to allow recovery from
>    * controller failure. It is up to the caller to ensure the namespace list is
> @@ -4725,6 +4730,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns, *next;
>   	LIST_HEAD(ns_list);
> +	ASYNC_DOMAIN(domain);
>   
>   	/*
>   	 * make sure to requeue I/O to all namespaces as these
> @@ -4759,8 +4765,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	mutex_unlock(&ctrl->namespaces_lock);
>   	synchronize_srcu(&ctrl->srcu);
>   
> +	/*
> +	 * Remove the namespaces in parallel, as each removal waits for several
> +	 * RCU grace periods.
> +	 */
>   	list_for_each_entry_safe(ns, next, &ns_list, list)
> -		nvme_ns_remove(ns);
> +		async_schedule_domain(nvme_ns_remove_async, ns, &domain);
> +	async_synchronize_full_domain(&domain);
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>   
> 
Other than that it looks fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

