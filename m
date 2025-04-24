Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5AC369D9
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=; b=CntX12JaPJTTyVbk6YJYWO/+Qp
	qdau443b3ZCi4c3RjVh3bTE1Hkztg5u3w3pgp8PIMx2Fi/v4hODA6T8rB0lS4BAiNseIdA9di6+i8
	J+cM+LUiKNIBHZO0BKTTSEqZaCmi22o9u8s/yvM584ovCaMM1T6HL+/gDx93mduhKNdkuj5C4G4sX
	/bgQnBBeAyytIQBifsr2r8RLQ27AC3aurOIv3XpRvKIGNTtz4P1nXLEc4Q/TK5qbgv8vbeHFNcAoY
	Vhp7o3PXj8NL+zlifNcNerJweLSpoqC8P4YCj/QFSyds9VIS/wb4UzdRaUBC3Q5XBFpSzz6lamjZm
	BmropC4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wlp-0000000ECRI-12vf;
	Thu, 24 Apr 2025 13:37:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uix-0000000Dqui-14yv
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 11:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=; b=J/2Za50R7OL9Akwb613VVyOPHs
	tVVAQUIugrzbio1MYaObssMjffY8+j6mbq+CKo4jQPnREWH7hIeLnTlmtTIcxy/sfBZWprLeWMyKE
	wg623FUWauIc8LMO9dE8+mXA/OR6u07Af5eZSNOHAY0WOEsoEsWhPGwzgQab+Qly0yCeSze3LXXr6
	jeTjl8ksOIS9xkHlu93XVIZLe51hVwGb/BOvlS7DGGcOTUrK2YADC4+a6xRzICt+L6RFJQJdN4GgC
	mDR/43QbQWCzB7W7XfgV5qOflmDwRf7cgnFixG9/pa1vtLKraxbOdFQD0xgu1XWq6rDRLmqQQmAjA
	CmDef2Fg==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7uit-0000000Blku-0TVd
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 11:26:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A605F21171;
	Thu, 24 Apr 2025 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=;
	b=aP1LjktxTemsh0Rk7he9tZje04TFLfDl7LQYz2zkT/1lzleflY+Cq6WwLRtngFAr1ancJB
	36e+kdg+oZfIg8X4748NGJl/J/W8BuPwkgS3tdnPIa5xjkXtB81TfId6vIZNSFK+yHJgUi
	V5720KwAmQVvDHAFFrWurUeHcvtpEjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=;
	b=dZGr54P3gZJu8q9aKez9M0PC3j2vdeYJVXLDGIkN8WC5F0HEbQp1rqSZ21Xa5XKDngQixd
	hpeQbeLuqwBraVDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aP1Ljktx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dZGr54P3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=;
	b=aP1LjktxTemsh0Rk7he9tZje04TFLfDl7LQYz2zkT/1lzleflY+Cq6WwLRtngFAr1ancJB
	36e+kdg+oZfIg8X4748NGJl/J/W8BuPwkgS3tdnPIa5xjkXtB81TfId6vIZNSFK+yHJgUi
	V5720KwAmQVvDHAFFrWurUeHcvtpEjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gM4kXolfAce+flpFo/05zhQBE7knJqS4hEKecdLq2o=;
	b=dZGr54P3gZJu8q9aKez9M0PC3j2vdeYJVXLDGIkN8WC5F0HEbQp1rqSZ21Xa5XKDngQixd
	hpeQbeLuqwBraVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 927AE1393C;
	Thu, 24 Apr 2025 11:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Kc0I+IfCmijOwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 11:26:26 +0000
Message-ID: <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
Date: Thu, 24 Apr 2025 13:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A605F21171
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_122631_344448_35B4D636 
X-CRM114-Status: GOOD (  44.48  )
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

On 4/17/25 00:09, Sagi Grimberg wrote:
> 
> 
> On 16/04/2025 10:56, Hannes Reinecke wrote:
>> On 4/15/25 23:35, Sagi Grimberg wrote:
>>>
>>>
>>> On 15/04/2025 10:07, Hannes Reinecke wrote:
>>>> On 4/3/25 08:55, Hannes Reinecke wrote:
>>>>> When the socket is busy processing nvme_tcp_try_recv() might
>>>>> return -EAGAIN, but this doesn't automatically imply that
>>>>> the sending side is blocked, too.
>>>>> So check if there are pending requests once nvme_tcp_try_recv()
>>>>> returns -EAGAIN and continue with the sending loop to avoid
>>>>> I/O stalls.
>>>>>
>>>>> Acked-by: Chris Leech <cleech@redhat.com>
>>>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>>>> ---
>>>>>   drivers/nvme/host/tcp.c | 5 ++++-
>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index 1a319cb86453..87f1d7a4ea06 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>>>>> work_struct *w)
>>>>>           result = nvme_tcp_try_recv(queue);
>>>>>           if (result > 0)
>>>>>               pending = true;
>>>>> -        else if (unlikely(result < 0))
>>>>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>>>>               return;
>>>>>   +        if (nvme_tcp_queue_has_pending(queue))
>>>>> +            pending = true;
>>>>> +
>>>>>           if (!pending || !queue->rd_enabled)
>>>>>               return;
>>>>
>>>> The various 'try_send' function will return -EAGAIN for a partial send.
>>>> But it doesn't indicate a blocked Tx, rather we should retry directly.
>>>> Hence this check.
>>>>
>>>> Unless you tell me differently and even a partial send will cause
>>>> ->write_space() to be invoked, then we wouldn't _need_ it.
>>>
>>> Umm, that is my understanding. If you tried to send X and were able to
>>> send Y where Y < X, you shouldn't have to keep trying in a busy loop, 
>>> the stack should tell you when you can send again.
>>>
>> Okay, I could try that.
>>
>>>> It would
>>>> still be an optimisation as we're saving the round-trip via socket
>>>> callbacks.
>>>
>>> But you are doing a busy loop on a socket that cannot accept new 
>>> data, there are other sockets that the kthread can be working on.
>>>
>> But we might be _sending_ data, right?
> 
> I'd say that odds are you're not in the next attempt...
> 
>>
>>>>
>>>> We could aim for a different error here, to differentiate between a
>>>> 'real' EAGAIN and a partial send.
>>>> Whatever you prefer.
>>>
>>> I still don't understand why a partial send warrants a busy loop call 
>>> to sock_sendmsg...
>>>
>> This is, it's not just sendmsg. It's the combination of send and recv.
> 
> I agree with you that the recv fix is correct.
> 
>> In my tests I have seen sendmsg return with a partial/incomplete status,
>> consequently recvmsg has nothing to receive, and io_work stops.
>> And that is what the patch fixes.
> 
> The question is if the recv fix is sufficient?
> 
>>
>> I haven't checked the ->write_space() callback (which should've been 
>> triggered), but my feeling is that the ->write_space() callback
>> hit when we were still busy processing, so the queue_work() went
>> nowhere.
> 
> That makes sense.
> 
>>
>> Maybe we can fix it with setting a flag when ->write_space()
>> triggers ('hey, more data to process'), to be evaluated during
>> the io_work() loop. But that would be pretty close to the
>> check 'nvme_tcp_queue_has_pending', so I'm not sure if we
>> gain anything.
> 
> How about checking sk_stream_is_writeable() instead?
> I think we also need to flag the queue for the write_space during IO 
> work...
> 
>>
>> And I really haven't seen any detrimental performance effects
>> with this patch; in the contrary, performance was on par,
>> and if anything standard deviation went down.
> 
> Still you agree that busy looping a socket that may not have space is 
> less efficient?
> When there are other queues waiting to execute io_work?
> 
> I agree there is a problem here, but I am trying to figure out what we 
> want to do here.
> 
> How about these two (untested) patches:
> [1 based on your recv-side fix]:
> --diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 72d260201d8c..4eb9a2dec07e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue 
> *queue)
>          queue->nr_cqe = 0;
>          consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>          release_sock(sk);
> -       return consumed;
> +       return consumed == -EAGAIN ? 0 : consumed;
>   }
> 
>   static void nvme_tcp_io_work(struct work_struct *w)
> -- 
> 
> [2 based on your partial write fix]:
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4eb9a2dec07e..daf59e75cf15 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {
>          NVME_TCP_Q_LIVE         = 1,
>          NVME_TCP_Q_POLLING      = 2,
>          NVME_TCP_Q_IO_CPU_SET   = 3,
> +       NVME_TCP_Q_WAKE_SENDER  = 4,
>   };
> 
>   enum nvme_tcp_recv_state {
> @@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>          queue = sk->sk_user_data;
>          if (likely(queue && sk_stream_is_writeable(sk))) {
>                  clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue- 
>  >io_work);
>          }
>          read_unlock_bh(&sk->sk_callback_lock);
> @@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                  container_of(w, struct nvme_tcp_queue, io_work);
>          unsigned long deadline = jiffies + msecs_to_jiffies(1);
> 
> +       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>          do {
>                  bool pending = false;
>                  int result;
> @@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                  else if (unlikely(result < 0))
>                          return;
> 
> -               if (!pending || !queue->rd_enabled)
> +               /* did we get some space after spending time in recv ? */
> +               if (nvme_tcp_queue_has_pending(queue) &&
> +                   sk_stream_is_writeable(queue->sock->sk))
> +                       pending = true;
> +
> +               if (!queue->rd_enabled)
> +                       return;
> +
> +               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER, 
> &queue->flags))
>                          return;
> 
>          } while (!time_after(jiffies, deadline)); /* quota is exhausted */
> -- 
> 
While trying to sift through the patches trying to come up with
a next version:
Why do you check for Q_WAKE_SENDER after checking for
sk_stream_is_writable?
Surely sk_stream_is_writable() is a necessary condition for 
nvme_tcp_try_send(), no?

Maybe it's a better idea to check sk_stream_is_writable() just
before nvme_tcp_try_send()...

Let me see how things pan out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

