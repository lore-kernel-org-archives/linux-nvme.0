Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B2DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6ZRSIIXLIhCq9RwJxcz35n/8+VZvd6vJFxICl6X3tY=; b=rfDCfCHKbdD5zvcWpg7lLVe1jU
	7wi0abH457WxlIoXnhSDeM8eNKCVBRIJYkFsC3DFF/2UxcFken4JnqvIu+giUWxbJMRotQYpWdN7l
	L3BMM5lxT1I0wbudp/i+08lCDyGGOk1NGm621n0WmR1WCUfUzo3qu9KU81t6ielUpsV/vJHz+JqDe
	USXkI8T8m86TQx59dudea0+TschHLSI33XyWgO0ByOWi5oZtHpkqoXunqMIhj0dsfS2oY6GVkob5E
	DVXJwgl9h+NPhEKg7RzsI7Tyg8Q4yDjUNYqO0YuIjkP5chz+NRL1eOknog6sd/QZ4v4sBujs6+GcS
	GqZ4PTNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petno-00FAcP-1x;
	Wed, 22 Mar 2023 08:26:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petnl-00FAbc-0e
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:26:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C12E720B45;
	Wed, 22 Mar 2023 08:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679473591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6ZRSIIXLIhCq9RwJxcz35n/8+VZvd6vJFxICl6X3tY=;
	b=h18/N23bpuBbmEInsYd0VxmXfXX1nk+2uweERvTWxorpKoQfnFIqqFOP4tiU/SGeM1F5Ew
	6dj1/DjfUGeUAJRkX/0yl7jrpoQ09bcBllz+CjoozXttQndEv5pO2YxLBTJB+tMg9fhXBn
	w6HdG3eU8WUd56mbTNLbdgRnG+l7RqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679473591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6ZRSIIXLIhCq9RwJxcz35n/8+VZvd6vJFxICl6X3tY=;
	b=CiECKYy5C/L53sR8Lm/2edf3fZ2AGw9RVvQF2SPdqFbCAETQvOA6zmDq1HIR33NLwnUHOe
	V8XbNW6w98jiQ2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FB44138E9;
	Wed, 22 Mar 2023 08:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ch0hILe7GmRfPQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 08:26:31 +0000
Message-ID: <3b6796e4-93ea-c493-4e03-27712257f69b@suse.de>
Date: Wed, 22 Mar 2023 09:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
 <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de>
 <60d3a645-719a-40aa-959d-f461b0c3eed9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <60d3a645-719a-40aa-959d-f461b0c3eed9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012633_381964_8287E8A6 
X-CRM114-Status: GOOD (  27.87  )
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

On 3/22/23 09:08, Sagi Grimberg wrote:
> 
> 
> On 3/21/23 16:09, Hannes Reinecke wrote:
>> On 3/21/23 14:44, Sagi Grimberg wrote:
>>>
>>>> Call the original data_ready() callback in nvme_tcp_data_ready()
>>>> to avoid a receive stall.
>>>
>>> Can you please improve the description to include what is the stall?
>>> For example, does the stall exist today? If it is, I would like to
>>> separate such patches from this set and include them asap.
>>>
>> That is actually particular to the TLS implementation, as it uses the 
>> 'data_ready' callback to produce the data which can be read by eg 
>> recvmsg().
>>
>> Without this call there's no data to peruse for recvmsg().
>>
>> But I'm not _that_ deep into networking details to know whether this 
>> is TLS specific or an issue with any data_ready callback.
>> I assume the latter, but then again, who knows.
> 
> Seems that this is only relevant when nvme_tcp runs on top of a ulp,
> so a code comment would probably make sense here.
> 
>>
>> Hence the slightly vague description.
>>
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/tcp.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 0e14b1b90855..0512eb289dcf 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -936,12 +936,14 @@ static void nvme_tcp_data_ready(struct sock *sk)
>>>>       trace_sk_data_ready(sk);
>>>> -    read_lock_bh(&sk->sk_callback_lock);
>>>> -    queue = sk->sk_user_data;
>>>> +    rcu_read_lock_bh();
>>>
>>> Now I understand your comment from a previous patch.
>>> Can you explain why is this convention needed?
>>>
>>> I would prefer to have it as a separate patch with an
>>> explanation to why it is needed.
>>>
>> This is the slightly odd socket callback handling.
>> Any driver is free to set the socket callbacks, but it has to be aware 
>> that it might not be the only one in the stack doing so.
>> So one has to be prepared that the callbacks are set already, so we 
>> should be calling them prior to our callback.
> 
> I meant the change from read_lock_bh to rcu_read_lock_bh and the
> same for rcu_dereference_sk_user_data. It needs to be in a
> separate patch with explanation to why it is needed.
> 
That is primarily for sanity checking.

Both us _and_ the tls code are setting the sk_user_data pointer,
so I wanted to make sure that we do get things correct.
But seems to work now, so I guess I can drop the rcu_dereference
modifications.

Let's see.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


