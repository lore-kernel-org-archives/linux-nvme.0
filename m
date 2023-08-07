Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3477EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dx0/Ux/aBdAY0A1gs78EhBVnVY05V2b1IUaEZFpZ6Kg=; b=MCp/GAJ9ZCO2GMeEdh8tfw3xEG
	2RrH4qC8oFTnxDKAnAGYYsLDnn2owlTlxeS0QnlQaRUxbJvAKU+mP+rwv8Iagv6c9MraZx6h2WJBL
	hCZN7pyA31Odds8acF7C6K78/59iE9Q6DOEHgG1Bc2eEWvDybX+Sov10PFmXkVT99cQZpRUO4J3Dm
	Lj5Up+JhkGfSrs9vClqNzdPK+yNz2vwUFwjWNpEQoLtpTRbU0ciKZxqHZr3arUAsdAugHRgKn6oni
	GuSaSPTwjNb1kJK8E7TAxwMgkn+hzmlFHt6Wb6oMU+xI4ynJDTX89Uk3QSpicM6yD7PJdErsxWOVZ
	CWhTsiiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSyjb-00H7wy-1D;
	Mon, 07 Aug 2023 11:49:15 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSyjX-00H7wJ-2i
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 11:49:13 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so1276402a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 04:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408948; x=1692013748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dx0/Ux/aBdAY0A1gs78EhBVnVY05V2b1IUaEZFpZ6Kg=;
        b=QiC0mRpuTDHnUZEt5zPIic9TNiIBArCyuFc3yC6kM3CwVjXQlZ92p1Fnf5RGynQlVM
         Arjfys64+B0oVh8LTqpS2y1rGVVBC/bgV8MZNkm1OXQZdCK1T13jEDrfJcTXjvlq93fS
         WcDWYPJCtlnyBkU6GcYKwd3UNStLF0vmnNQSzllmiStKK+c8E3+W/kU55RogAFUwKsye
         CvVFc+fN2gz3eXMJy8SPsdMw5h+3Hx4aRkrHAOWq0OABYTNJ6aHx9l7gYLDePXIGfSn8
         VVYa4zWQ3aKTEUKloHyeY2F0hu59oOPnqzcrennhy4snrTG4ET0n7C0MXpJxuL9VMKsr
         qtCA==
X-Gm-Message-State: ABy/qLaPX1RVq6NxUB5pQOEBcaO41euni0blKG2J1fqeGaSsGFSxgxXP
	A7hEE37hrBtEQCEZO9OotNI=
X-Google-Smtp-Source: APBJJlEeMWBdQBPfmN9cQpbZGBb06EGdbY0SGlMoHT+zdItnwCmnkOZwvGUjIWEOEQFJYUAgo/FGGg==
X-Received: by 2002:a05:6402:520e:b0:522:580f:8304 with SMTP id s14-20020a056402520e00b00522580f8304mr25520920edd.1.1691408948036;
        Mon, 07 Aug 2023 04:49:08 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7cd03000000b0052229d203a4sm5107161edw.36.2023.08.07.04.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:49:07 -0700 (PDT)
Message-ID: <5d114710-6786-d82a-d3c2-4b281a7ab3cd@grimberg.me>
Date: Mon, 7 Aug 2023 14:49:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/14] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-14-hare@suse.de>
 <7260f07a-2d2a-1f84-722c-8385eda7475a@grimberg.me>
 <fb4a9ec5-15b0-c93c-ae54-c7215d155c3d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fb4a9ec5-15b0-c93c-ae54-c7215d155c3d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_044911_880398_ED33E16B 
X-CRM114-Status: GOOD (  22.00  )
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


>>> @@ -389,6 +427,16 @@ static ssize_t nvmet_addr_tsas_store(struct 
>>> config_item *item,
>>>   found:
>>>       nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
>>> +    if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
>>> +        if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
>>> +            treq |= NVMF_TREQ_REQUIRED;
>>> +        else
>>> +            treq |= nvmet_port_treq(port);
>>> +    } else {
>>> +        /* Set to 'not specified' if TLS is not enabled */
>>> +        treq |= NVMF_TREQ_NOT_SPECIFIED;
>>> +    }
>>> +    port->disc_addr.treq = treq;
>>>       return count;
>>>   }
>>
>> Can the treq/tsas be split from the actual nvmet-tcp upcall addition?
>>
> I guess it can; it's just that it doesn't make any sense if we don't 
> have the TLS upcall implemented.

Still its mixing two parts together and makes the patch unnecessarily
complicated.

>>> @@ -1285,12 +1302,12 @@ static int nvmet_tcp_try_recv(struct 
>>> nvmet_tcp_queue *queue,
>>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>>> *queue)
>>>   {
>>> -    spin_lock(&queue->state_lock);
>>> +    spin_lock_irq(&queue->state_lock);
>>
>> Where is this lock taken in irq context that needs disabling irq?
>>
> Let me check; might be that it got solved with the workqueue fixes which 
> went in lately.

Can you explain what was the original issue for this change?

>>> +{
>>> +    struct nvmet_tcp_queue *queue = data;
>>> +
>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>> +         queue->idx, peerid, status);
>>> +    if (!status) {
>>> +        spin_lock_irq(&queue->state_lock);
>>> +        queue->tls_pskid = peerid;
>>> +        spin_unlock_irq(&queue->state_lock);
>>> +    }
>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>
>> Hmm, the cancel_delayed_work_sync is scary.
>>
>> What happens if it ran and already scheduled a release (which
>> already ran and completed)?
>>
> Well, we need to stop the timeout at some point; granted, for a failure 
> we can just flush the workqueue, but in the success case we need 
> terminate the workqueue.
> And nvmet_tcp_schedule_release_queue() already checks for the queue 
> state, so we should be (reasonably) safe.

Still it looks error prone (although granted, I didn't spot a particular
race where this breaks).

I wish the handshake code could have given us a timeout functionality
so we don't need to deal with it...

In any event, preferably the synchronization does not require to
synchronize an active work element on the workqueue.

>>> +    pr_debug("queue %d: TLS ServerHello\n", queue->idx);
>>> +    memset(&args, 0, sizeof(args));
>>> +    args.ta_sock = queue->sock;
>>> +    args.ta_done = nvmet_tcp_tls_handshake_done;
>>> +    args.ta_data = queue;
>>> +    args.ta_keyring = key_serial(queue->port->nport->keyring);
>>> +    args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;
>>
>> * 2 * 1024 ? I didn't know we have 2048 ms in a second...
>>
> The '_ms' bit is just an indicator of the unit, not the value.
> We don't have an 'args.ta_timeout_sec' ...

I expected to see tls_handshake_timeout * 1000, i.e. a trivial
conversion from sec to ms.

