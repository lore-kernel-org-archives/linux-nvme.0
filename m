Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05C606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ibv7aj6p;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f/SGcu8n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHgD3jWu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f/SGcu8n;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHgD3jWu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=19S3hFIOgJWNovhmVdj4jkPqvuhRoJw93rSNlsgqY+U=; b=ibv7aj6p53KkkJ
	pVB5WZyJm9TzQze9Sp7mKT+PTB38g9Uj/eAcAY+bpV119ugW1Yxbpp05TYI9I4ZtdojtK6qRCtD7W
	7ztHvj/eq7ptZHvaWfNAVrV36zOQKRVbIxw4jWjwAkdLIAMVkp5wHmLBs95t8QoQVcClWbmW1JWH3
	UCzvVoUhGMsgiAgt+jD2ovMx7A+JXdNNgtMZZR94+dJaMVSgN0nYLEtNmtQ85WXcsdiZoy3G6gILt
	KAfYEXiNZMVdBRRI8tsSxoGR9Lplx6oOkdvP902L0betxEkJLtyzulXFPBIte+t2LUEBYDf/ruqR8
	IjpIP0kuwdilb+w3RppA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8Je-000000094Fo-1PaZ;
	Wed, 25 Nov 2026 08:25:22 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8Ja-000000094EY-1f25
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 08:25:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B8B91F456;
	Wed, 25 Nov 2026 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795595116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19S3hFIOgJWNovhmVdj4jkPqvuhRoJw93rSNlsgqY+U=;
	b=f/SGcu8npW84MqXk460nllOqVQqzuXxUaZVDYw5EP10h/AuVgmiFw/MtWOZA552cNDmJHD
	GJCl+bHw3P+8j8XHJ2kvZTDW2uWa5MeSpJFmRWbjnsq4OcBasiP/84vxS+MsHCqpQSZQNZ
	MV5F8qsZLFApLhdppK3ZJFyOXpK6poQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795595116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19S3hFIOgJWNovhmVdj4jkPqvuhRoJw93rSNlsgqY+U=;
	b=uHgD3jWu/jtWYLMnnctR1q2WmreP126230vHoake+TkKozoijkK00GX8mnw9ae/O3gjxhq
	kudGZVKlBPJb/GCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795595116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19S3hFIOgJWNovhmVdj4jkPqvuhRoJw93rSNlsgqY+U=;
	b=f/SGcu8npW84MqXk460nllOqVQqzuXxUaZVDYw5EP10h/AuVgmiFw/MtWOZA552cNDmJHD
	GJCl+bHw3P+8j8XHJ2kvZTDW2uWa5MeSpJFmRWbjnsq4OcBasiP/84vxS+MsHCqpQSZQNZ
	MV5F8qsZLFApLhdppK3ZJFyOXpK6poQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795595116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19S3hFIOgJWNovhmVdj4jkPqvuhRoJw93rSNlsgqY+U=;
	b=uHgD3jWu/jtWYLMnnctR1q2WmreP126230vHoake+TkKozoijkK00GX8mnw9ae/O3gjxhq
	kudGZVKlBPJb/GCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0314134E8;
	Wed, 25 Nov 2026 08:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TDynMmubBmuhZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 08:25:15 +0000
Message-ID: <1940bb1e-0d77-4314-b052-59a0f92b4cc1@suse.de>
Date: Wed, 25 Nov 2026 09:25:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: delete the ANATT timer after draining
 ana_work
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261124121349.1861269-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261124121349.1861269-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alibaba.com:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_002518_587079_98B53917 
X-CRM114-Status: GOOD (  18.82  )
X-Spam-Score: -4.4 (----)
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

On 11/24/26 1:13 PM, Guixin Liu wrote:
> nvme_mpath_stop() deletes the ANATT timer before cancelling ana_work.
> An ana_work that is already past its controller state check can still
> read the ANA log and arm the timer after the timer was deleted. The
> controller is then freed with the timer armed, and nvme_anatt_timeout()
> dereferences the freed controller when it fires.
> 
> Cancel ana_work before deleting the timer so it cannot be armed again.
> Also delete the timer in nvme_mpath_uninit() after draining ana_work:
> commit 9b657c565984 ("nvme: stop asynchronous event work before ANA
> teardown") added the work drain there because ana_work has multiple
> producers and nvme_mpath_stop() is skipped once ana_log_buf is NULL.
> The timer needs the same treatment before the ANA resources are freed.
> 
> Fixes: 0d0b660f214d ("nvme: add ANA support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Found by code inspection; reproduced in a KASAN guest with nvmet-tcp
> loopback, two paths and an ANA group in change state. With a test-only
> delay widening the ana_work window, deleting the controller while
> ana_work is in flight arms the timer after nvme_mpath_stop() deleted
> it, and twenty seconds after the controller is freed:
> 
>    BUG: KASAN: slab-use-after-free in __run_timers+0x887/0x990
>    Write of size 8 at addr ffff8884ec888e00 by task swapper/24/0
> 
> With the fix the same recipe completes with no splat and both
> controllers are removed cleanly. ANA change/optimized transitions and
> multipath I/O were verified unaffected.
> 
>   drivers/nvme/host/multipath.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

