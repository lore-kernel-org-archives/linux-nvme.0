Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB69BC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RrRVduE4zbevj6GTOhBRtZPaGCQv1wiLe3pbJqtnHQ=; b=BlkWsvqLtRn3Q/8bqJftY5vjdW
	LN3AFQa9a/H5FrMf3gpQ2Rbz8WQzxskoCwd12r9v3vWfBtaAYMqRC3vAIjy0PEfT7B4EvaZY88QN3
	+EdXuk/wziWp9eQrxGUn7hzWl0dgrTbk7cHsXqXtzX+MYn+Sd1VO8fdbSYd5WEBl6mT+4YSCZe13q
	ml0exqiKFc1a6fXr2OI7n4E3VpwkGdhiIfsB+qrfm3q5u1x7ybtjF2lg2cN7MG4bQe/KJNZCyvNGf
	KZcylwKCFwCqZQuKO7AX5ZHylOTRpI3PJlVBmQlYo9/5wgTieY79L4U8UQDtUZS9zLp//aXkagxHp
	TcRK7JmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTG1Q-001oAq-0J;
	Tue, 08 Aug 2023 06:16:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTG1N-001oA4-0v
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 06:16:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1A7F22471;
	Tue,  8 Aug 2023 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691475403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RrRVduE4zbevj6GTOhBRtZPaGCQv1wiLe3pbJqtnHQ=;
	b=dwoY7uJqNxDc/aGM4JqNmV8lfFVFhW5z72J6AmwUFzNn4XoSKYwANNqD9qEvblRf/WaemO
	jZOx5OJNT5bi+bF9NPyvIX9ITit2woW4Misi0K5CdKbJvP9wXl5YSwfoYdhMClNhSZciGd
	Ns6BjWoiz8xYpAEAhvF9njXNvnjG09g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691475403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RrRVduE4zbevj6GTOhBRtZPaGCQv1wiLe3pbJqtnHQ=;
	b=Xh39rTEbtvsHEPUjU7ZB0qZJCduwCjdeqqEA6xbHYcNgUGKzbZX/PB9vJxak9Dpkpuv+yY
	9I9wXRrLUpWIkqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C807D139D1;
	Tue,  8 Aug 2023 06:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id c8PRL8vd0WSDQAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 08 Aug 2023 06:16:43 +0000
Message-ID: <c4ce9d99-a68a-df75-f156-1f22e9d7e2a4@suse.de>
Date: Tue, 8 Aug 2023 08:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 13/14] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-14-hare@suse.de>
 <7260f07a-2d2a-1f84-722c-8385eda7475a@grimberg.me>
 <fb4a9ec5-15b0-c93c-ae54-c7215d155c3d@suse.de>
 <5d114710-6786-d82a-d3c2-4b281a7ab3cd@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5d114710-6786-d82a-d3c2-4b281a7ab3cd@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_231645_465691_720A4433 
X-CRM114-Status: GOOD (  27.61  )
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

On 8/7/23 13:49, Sagi Grimberg wrote:
> 
>>>> @@ -389,6 +427,16 @@ static ssize_t nvmet_addr_tsas_store(struct 
>>>> config_item *item,
>>>>   found:
>>>>       nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
>>>> +    if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
>>>> +        if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
>>>> +            treq |= NVMF_TREQ_REQUIRED;
>>>> +        else
>>>> +            treq |= nvmet_port_treq(port);
>>>> +    } else {
>>>> +        /* Set to 'not specified' if TLS is not enabled */
>>>> +        treq |= NVMF_TREQ_NOT_SPECIFIED;
>>>> +    }
>>>> +    port->disc_addr.treq = treq;
>>>>       return count;
>>>>   }
>>>
>>> Can the treq/tsas be split from the actual nvmet-tcp upcall addition?
>>>
>> I guess it can; it's just that it doesn't make any sense if we don't 
>> have the TLS upcall implemented.
> 
> Still its mixing two parts together and makes the patch unnecessarily
> complicated.
> 
>>>> @@ -1285,12 +1302,12 @@ static int nvmet_tcp_try_recv(struct 
>>>> nvmet_tcp_queue *queue,
>>>>   static void nvmet_tcp_schedule_release_queue(struct 
>>>> nvmet_tcp_queue *queue)
>>>>   {
>>>> -    spin_lock(&queue->state_lock);
>>>> +    spin_lock_irq(&queue->state_lock);
>>>
>>> Where is this lock taken in irq context that needs disabling irq?
>>>
>> Let me check; might be that it got solved with the workqueue fixes 
>> which went in lately.
> 
> Can you explain what was the original issue for this change?
> 
The original issue was a lockdep warning when tearing down the target;
this got addressed by the patch 'nvmet-tcp: add new workqueue to 
suppress lockdep warning' from Guoqing Jiang.

>>>> +{
>>>> +    struct nvmet_tcp_queue *queue = data;
>>>> +
>>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>>> +         queue->idx, peerid, status);
>>>> +    if (!status) {
>>>> +        spin_lock_irq(&queue->state_lock);
>>>> +        queue->tls_pskid = peerid;
>>>> +        spin_unlock_irq(&queue->state_lock);
>>>> +    }
>>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>>
>>> Hmm, the cancel_delayed_work_sync is scary.
>>>
>>> What happens if it ran and already scheduled a release (which
>>> already ran and completed)?
>>>
>> Well, we need to stop the timeout at some point; granted, for a 
>> failure we can just flush the workqueue, but in the success case we 
>> need terminate the workqueue.
>> And nvmet_tcp_schedule_release_queue() already checks for the queue 
>> state, so we should be (reasonably) safe.
> 
> Still it looks error prone (although granted, I didn't spot a particular
> race where this breaks).
> 
> I wish the handshake code could have given us a timeout functionality
> so we don't need to deal with it...
> 
> In any event, preferably the synchronization does not require to
> synchronize an active work element on the workqueue.
> 
With the timeout code we always will have two threads; the handshake 
itself and the timeout. So when handshake completes the timeout will
be running, and we will have to terminate it somehow. I really can't
see how we could avoid that.
But I do get your point; will be adding an atomic variable to 
synchronize between these two threads.

>>>> +    pr_debug("queue %d: TLS ServerHello\n", queue->idx);
>>>> +    memset(&args, 0, sizeof(args));
>>>> +    args.ta_sock = queue->sock;
>>>> +    args.ta_done = nvmet_tcp_tls_handshake_done;
>>>> +    args.ta_data = queue;
>>>> +    args.ta_keyring = key_serial(queue->port->nport->keyring);
>>>> +    args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;
>>>
>>> * 2 * 1024 ? I didn't know we have 2048 ms in a second...
>>>
>> The '_ms' bit is just an indicator of the unit, not the value.
>> We don't have an 'args.ta_timeout_sec' ...
> 
> I expected to see tls_handshake_timeout * 1000, i.e. a trivial
> conversion from sec to ms.

Okay, will do that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


