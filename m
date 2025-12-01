Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8605D111A8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sKVt4ISX+Zl4EdllSr/TbbaclGg65HlIml0fafRLkw=; b=hw1NoQZ3fRsrXelua0dkC8bh9U
	FCCedi9DXXomKzBADJIMWqTALaaaykTEPy7XhslWu1atHoNmt2IyiiB2otW9pbYXxN79zTsI8Iyst
	4XeUsAz41JxOUSQx/S5Rw7TY//Ig3Ss1Ni0CnfUzDH4KBBh+ALhNOIQ52fIYCfbHPoxBXGCQUPvpt
	FAKdoBuUvoMfahn6HHbrH4sfupKzbN+kUlR3YxfpobUgRAS6GyvnJWVmAdEmth4lUkNQeq2tjTMxY
	fsKOIU02C0lZ8C9EXDHgS4KCM5J6FE0kGJfRN7HLtoUpD5ZANKqc7tMTWC0pk7r+NfF01hAR8eoPc
	lviO2oJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzni-00000003BC2-0dVb;
	Mon, 01 Dec 2025 09:02:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPznd-00000003BBZ-1tj5
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 09:02:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 661C95BD66;
	Mon,  1 Dec 2025 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sKVt4ISX+Zl4EdllSr/TbbaclGg65HlIml0fafRLkw=;
	b=KT99pp1dX4k6BhDBGjcLQa4C9z1+dAaZKYHFIvyj6tj/vNL6I3xaxe60E21RI4YBM+xgXP
	sPl82fz8rhuHuROhVjFe7y3LoUm9ha/JfP6Z4YZTThSmsIdfNYQDcx3PfU1haQcDTVmaL+
	J46+buIf2eZKA3N2aSOwTp0ZLFGZfeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sKVt4ISX+Zl4EdllSr/TbbaclGg65HlIml0fafRLkw=;
	b=0iFFfM1o89vot48bR6MJPcSkxbn51enauZKL+Jwsh4oLAK0mGAXwLg0Cu+jjSvLcik0Y8m
	OKrfaUNWczQjojDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sKVt4ISX+Zl4EdllSr/TbbaclGg65HlIml0fafRLkw=;
	b=15UzkENp86SsAiUk/8z+IF0P7PuHl2TCGzDvZ2KSqjBYihIL60pKCaQkGxrwU6MvkEKPvY
	x40vXLBLpE7Sy+1r6gN8dVYlMyKTJw4cp/k3BrhCTkpqfzOzs6p5TdUVQTSqHxl+JCuBcJ
	4bo6OAUT7EwAlAN9THmxcZyZJRdJqJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sKVt4ISX+Zl4EdllSr/TbbaclGg65HlIml0fafRLkw=;
	b=SmW8UJklnm8i6oIFom0qQLx6qkq5h/ihGoxxQONtPT/GzTidwPLuSQ2U0A6A+SyBFoaScy
	PS8OfSWKTvGQsaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33C6F3EA63;
	Mon,  1 Dec 2025 09:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id btHQCpVZLWnxPwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 09:02:13 +0000
Message-ID: <5c7468c0-ecbe-4c9f-bbaf-9c14e45c040f@suse.de>
Date: Mon, 1 Dec 2025 10:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
 <3e20b46c-d0a8-454b-9c1d-6d010c2e2e42@suse.de>
 <bc44fabe-fcf4-4f63-86cf-0188f63cb2df@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bc44fabe-fcf4-4f63-86cf-0188f63cb2df@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_EMAILBL_FAIL(0.00)[hare.suse.de:query timed out];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_010225_645974_2065324F 
X-CRM114-Status: GOOD (  36.19  )
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

On 11/30/25 22:38, Sagi Grimberg wrote:
> 
> 
> On 27/11/2025 13:47, Hannes Reinecke wrote:
>> On 11/27/25 08:52, Hannes Reinecke wrote:
>>> On 11/26/25 08:32, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>>>> The nvme-tcp code is using the ->read_sock() interface to
>>>>> read data from the wire. While this interface gives us access
>>>>> to the skbs themselves (and so might be able to reduce latency)
>>>>> it does not interpret the skbs.
>>>>> Additionally for TLS these skbs have to be re-constructed from
>>>>> the TLS stream data, rendering any advantage questionable.
>>>>> But the main drawback for TLS is that we do not get access to
>>>>> the TLS control messages, so if we receive any of those message
>>>>> the only choice we have is to tear down the connection and restart.
>>>>> This patch switches the receive side over to use recvmsg(), which
>>>>> provides us full access to the TLS control messages and is also
>>>>> more efficient when working with TLS as skbs do not need to be
>>>>> artificially constructed.
>>>>
>>>> Hannes,
>>>>
>>>> I generally agree with this approach. I'd like to point out though
>>>> that this is going to give up running RX from directly from softirq 
>>>> context.
>>>
>>> Yes.
>>>
>>>> I've gone back and forth on weather nvme-tcp should do that, but never
>>>> got to do a thorough comparison between the two. This probably shuts
>>>> the door on that option.
>>>>
>>> The thing with running from softirq context is that it would only
>>> make sense if we could _ensure_ that the softirq context is running
>>> on the cpu where the blk-mq hardware context is expecting it to.
>>> Not only would that require fiddling with RFS contexts, but we also
>>> found that NVMe-over-fabrics should _not_ try to align with hardware
>>> interrupts but rather rely on the driver to abstract things away.
>>>
>>>> Having said that, I am fine with this approach. recvmsg is a saner 
>>>> interface.
>>>>
>>> Thanks!
>>>
>>>
>>> [ .. ]>> @@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct
>>>>> nvme_tcp_queue *queue,
>>>>>       return 0;
>>>>>   }
>>>>> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct 
>>>>> sk_buff *skb,
>>>>> -                 unsigned int offset, size_t len)
>>>>> +static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
>>>>>   {
>>>>> -    struct nvme_tcp_queue *queue = desc->arg.data;
>>>>> -    size_t consumed = len;
>>>>> -    int result;
>>>>> +    char *ddgst = (char *)&queue->recv_ddgst;
>>>>> +    off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
>>>>> +    struct msghdr msg = {
>>>>> +        .msg_flags = MSG_WAITALL,
>>>>> +    };
>>>>
>>>> I don't think we want to use MSG_WAITALL ever. Why are you opting to 
>>>> do that?
>>>>
>>> Hmm. You are right, it's not needed.
>>>
>>> [ .. ]>> @@ -1356,20 +1355,38 @@ static int nvme_tcp_try_send(struct
>>>>> nvme_tcp_queue *queue)
>>>>>       return ret;
>>>>>   }
>>>>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>>>>> +static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>>>>>   {
>>>>> -    struct socket *sock = queue->sock;
>>>>> -    struct sock *sk = sock->sk;
>>>>> -    read_descriptor_t rd_desc;
>>>>> -    int consumed;
>>>>> +    int result;
>>>>> +    int nr_cqe = queue->nr_cqe;
>>>>> +
>>>>> +    if (unlikely(!queue->rd_enabled))
>>>>> +        return -EFAULT;
>>>>> +
>>>>> +    do {
>>>>> +        switch (nvme_tcp_recv_state(queue)) {
>>>>> +        case NVME_TCP_RECV_PDU:
>>>>> +            result = nvme_tcp_recvmsg_pdu(queue);
>>>>> +            break;
>>>>> +        case NVME_TCP_RECV_DATA:
>>>>> +            result = nvme_tcp_recvmsg_data(queue);
>>>>> +            break;
>>>>> +        case NVME_TCP_RECV_DDGST:
>>>>> +            result = nvme_tcp_recvmsg_ddgst(queue);
>>>>> +            break;
>>>>> +        default:
>>>>> +            result = -EFAULT;
>>>>> +        }
>>>>> +    } while (result >= 0);
>>>>> +
>>>>> +    if (result < 0 && result != -EAGAIN) {
>>>>> +        dev_err(queue->ctrl->ctrl.device,
>>>>> +            "receive failed:  %d\n", result);
>>>>> +        queue->rd_enabled = false;
>>>>> + nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>>>> +    }
>>>>> -    rd_desc.arg.data = queue;
>>>>> -    rd_desc.count = 1;
>>>>> -    lock_sock(sk);
>>>>> -    queue->nr_cqe = 0;
>>>>> -    consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>>>> -    release_sock(sk);
>>>>> -    return consumed == -EAGAIN ? 0 : consumed;
>>>>> +    return result < 0 ? result : (queue->nr_cqe = nr_cqe);
>>>>
>>>> This is changing the semantics of the retcode - can you please 
>>>> document in the commit msg
>>>> the change?
>>>>
>>> That was done to be compatible with the polling interface.
>>> I'll check if it's needed after all.
>>>
>> Actually, I don't think I'm changing the interface.
>> The original interface would return either a negative number on error,
>> '0' if no PDUs have been processed, or the number of processed PDUs.
>> And the new recvmsg interface does the same (I think).
>> The only change which I did was to _not_ map out -EAGAIN, as this will
>> be handled by the 'data_ready' callback.
> 
> Which is a change that needs to be documented.
> 
Okay, will do.

>> (Reasoning: -EAGAIN is returned when there is no (or not enough) data
>> to be read, and the network layer will call ->data_ready once the
>> situation improves. If we continue with the loop we will race/compete
>> with the networking layer, causing us to do duplicated work as the
>> io_work thread will be picking up the new data _and_ the data_ready
>> callback will be scheduling the io_work callback to pick up the new
>> data. So we can safely stop on -EAGAIN knowing that we'll be woken
>> up once we can continue to read data.).
> 
> There is TX work that may be pending as well, IIRC there is an 
> assumption that io_work will NOT return if there is any TX work
 > pending (we've seen stalls in the past due to issues like that).>
Hmm.
But I've seen the opposite; the current io_work prioritizes TX
over RX, so a 'data_ready' callback will trigger TX first, letting
the RX data to stew for a bit before the TX data has been sent.
Maybe we should be looking into splitting TX and RX paths after all...

>> (And arguably this was an issue with the original code, too.).
>>
>> So where is the change in semantics?
> 
> Exactly where you described it.

Okay, will be doing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

