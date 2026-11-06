Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC375606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wp+tq+ko;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YmpcpWJu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P0NCKvX3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NQvhHecH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o1GFRjWy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8JaWjpHsA9K5VQoih0qcs1nntTo5fLlT6Is+63w1g+Y=; b=wp+tq+koaFQfXc
	Of3ZhnFlNyfcpWV5kOuY+bXdGXFcl3+4HBXsI2JcDpE98IgCJP7pgZZ2PXsWGcA8bcgCoXkXzxf+z
	mocXH0i6PcvIBqvDHyDZoK2zn575hjBxFdIbw9mrJ0TCT4MWqb5dLZZ/sjsZbvchuxLdKeIioCH+L
	wUVkZLI4eS1nywJ4IlYD3xqBZ+0jOS3vCkaksXIB2Ijo/FrKuWWErXSuStGbr8Jg9vBlWdrSv54Ok
	yckwOIHlYgprJ1M6LeXHzT8YbAN6UAaGqc0sJHuP40YDMvVM2hfJAu010tdG8EMd/dD3IIkJI2PiC
	o1NXuWBg0HBI7MgWdpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEQd-0000000BSXF-2UU6;
	Fri, 06 Nov 2026 07:32:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEQb-0000000BSWG-01F5
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:32:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D853A22200;
	Fri,  6 Nov 2026 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JaWjpHsA9K5VQoih0qcs1nntTo5fLlT6Is+63w1g+Y=;
	b=YmpcpWJuHpZr5PfHqVpmE/ljKKwpYUBkeTG5/n5f+h8y5d9mLocdFKFCDs+OfLn/J6BMnt
	MFRG972gMWVduoEOKiG+wIgA1vkmYafEyVIMBrpTiynhPHCH5T3WqaghRY1aoTFvKFXSrg
	9uHFifY9uQEobZWH4wdAMu1P7w0UFjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JaWjpHsA9K5VQoih0qcs1nntTo5fLlT6Is+63w1g+Y=;
	b=P0NCKvX3R2rWoi0w3sPvlKQ15JlP9cQg6ZLYC7AhjWNxh7fxi2ZW4gyuWjqFqQ1Q+OpSs1
	mb3LFEv1acYqLrDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NQvhHecH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o1GFRjWy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JaWjpHsA9K5VQoih0qcs1nntTo5fLlT6Is+63w1g+Y=;
	b=NQvhHecH53A9OVL7iA4Ti6g9x921L/0nDKD0GiwD+lpfsgw4X9iScj+0LyRS0UdcmUYAeS
	sQ3yjPkjsXjISACoO0gZVYC0tTeSKMFRJi2XMhOrEuk75oI+v/JUKwTOazdab+8LTAAIJB
	7Ag/QWuOI8cMBFQ9tBmM4cht1C2dQ8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JaWjpHsA9K5VQoih0qcs1nntTo5fLlT6Is+63w1g+Y=;
	b=o1GFRjWyRLLEexBiE8OhpxRJ0CbM3/LxeYhqmV1ZIhGVShsCBRZCwwxZulJq48VVhDOUxS
	QSLJ0yuZ4ilF3JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83D20134E9;
	Fri,  6 Nov 2026 07:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LO6JEW2C7WrKPQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:31:57 +0000
Message-ID: <b2d72dd8-c672-4cd1-b0a2-24b4fc621a1f@suse.de>
Date: Fri, 6 Nov 2026 08:31:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nvmet: use GFP_KERNEL for PR allocations
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-7-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-7-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: D853A22200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_233201_217005_6DD0BA66 
X-CRM114-Status: GOOD (  18.65  )
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

On 11/6/26 2:58 AM, Guixin Liu wrote:
> nvmet_pr_update_reg_attr() and nvmet_pr_alloc_and_insert_pc_ref()
> allocate with GFP_ATOMIC, but both run in sleepable context: the PR
> command handlers execute from the transport workqueues and take the
> pr_sem semaphore, and the pc_ref allocation is reached from the
> connect and configfs paths. The latter function even passes
> GFP_KERNEL to the percpu_ref_init() in the same scope, so the
> GFP_ATOMIC only raises the failure rate for no reason.
> 
> Switch both allocations to GFP_KERNEL.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/pr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 14eaa99f98fa..026653ce338f 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -335,7 +335,7 @@ static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
>   		return NVME_SC_SUCCESS;
>   	}
>   
> -	new = kmalloc_obj(*new, GFP_ATOMIC);
> +	new = kmalloc_obj(*new, GFP_KERNEL);
>   	if (!new)
>   		return NVME_SC_INTERNAL;
>   
> @@ -1040,7 +1040,7 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
>   	struct nvmet_pr_per_ctrl_ref *pc_ref;
>   	int ret;
>   
> -	pc_ref = kmalloc_obj(*pc_ref, GFP_ATOMIC);
> +	pc_ref = kmalloc_obj(*pc_ref, GFP_KERNEL);
>   	if (!pc_ref)
>   		return  -ENOMEM;
>   

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

