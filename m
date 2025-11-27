Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC71D11183
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NUavhCczmByu3XqYVYF8rbIZic6itwH9h6KPYca0pA0=; b=D7qSdZp7qgailgS5jGQi27Q1l/
	+nrLI8qsC3cdxadp9mxxw9b5GYldSRpcTVpfGJlytOmk1dxPQ9F6l8WkRFhIXDZit58UqZ4I9DtFB
	EjUY57Npoy1oOT7z1r1/M3l7vK20im+OKxK+/DUBN24xgfDOgw8KhG3WanSguhBnS4Eo/mBMmLYqZ
	9bCKwqGlLJXYmIVWxNxdI5EMrLaxHP5TdMoVW1P/sR3kx41lWPVuGz80QTwmJqhfS+LY5d350sBz8
	4wN5JKLzRkewmcRpDsp9fFCQxPOssmG/6clJzYwt0KlGVchX9H1Sp5X7eYlR7QCx9BKgimNBn+4dF
	8HE7HZ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOaTI-0000000GU6s-1qJl;
	Thu, 27 Nov 2025 11:47:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOaTF-0000000GU6A-1IKX
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 11:47:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 179065BD14;
	Thu, 27 Nov 2025 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764244050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUavhCczmByu3XqYVYF8rbIZic6itwH9h6KPYca0pA0=;
	b=mko589HOH/+4+wNM51mabTPnqlkiI6ZaV0Zx4D6Qciad2tHSk/2O4JLg4XXmgtsCKgg8Fi
	SZ2/euVj7mpBt+cusdgLB2rinlbG0mwwLr7iYKQfRTxnI7zOvhOF95llhZXXXr1lSs+c4A
	NxXTCJNTTB1KqyLTzSJr1VdxgynBoiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764244050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUavhCczmByu3XqYVYF8rbIZic6itwH9h6KPYca0pA0=;
	b=MzQZSx5kHpzyaUE73LXSFZXsumlGtcqeNpaOi/bI1/ezB6ABZWXwT+oMipWfZfmzY3QKrO
	HtrDV13/t7cvazBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GVsNdvWH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KXqbzHhz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764244049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUavhCczmByu3XqYVYF8rbIZic6itwH9h6KPYca0pA0=;
	b=GVsNdvWHW9t3A44sw+ZJlmHnUb9Tszc5ojEzcAehG5LRVJUl12xfL+nLIsm+hyuj1nxFqt
	cLpewxLzK0QL7nvPWHfFgbzRYD7acnyZ3d6PKA3zw9TzwDxROJK9I8CSlrzAslLSwTGPcA
	YhZ4JYLILZpbzOQ8b5rXQX24oHsV4+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764244049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUavhCczmByu3XqYVYF8rbIZic6itwH9h6KPYca0pA0=;
	b=KXqbzHhzU91LQh5kdr8VOQ5LXo8c1MZfgl8ZjuH0nD1iIeURNrZCKetEd7gP3Uf/E6wzxH
	dLO5TXlbGXiPcTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E99293EA65;
	Thu, 27 Nov 2025 11:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qdt6N1A6KGlRawAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 11:47:28 +0000
Message-ID: <3e20b46c-d0a8-454b-9c1d-6d010c2e2e42@suse.de>
Date: Thu, 27 Nov 2025 12:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
Content-Language: en-US
In-Reply-To: <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 179065BD14
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_034733_636968_E946C0D5 
X-CRM114-Status: GOOD (  36.42  )
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

On 11/27/25 08:52, Hannes Reinecke wrote:
> On 11/26/25 08:32, Sagi Grimberg wrote:
>>
>>
>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>> The nvme-tcp code is using the ->read_sock() interface to
>>> read data from the wire. While this interface gives us access
>>> to the skbs themselves (and so might be able to reduce latency)
>>> it does not interpret the skbs.
>>> Additionally for TLS these skbs have to be re-constructed from
>>> the TLS stream data, rendering any advantage questionable.
>>> But the main drawback for TLS is that we do not get access to
>>> the TLS control messages, so if we receive any of those message
>>> the only choice we have is to tear down the connection and restart.
>>> This patch switches the receive side over to use recvmsg(), which
>>> provides us full access to the TLS control messages and is also
>>> more efficient when working with TLS as skbs do not need to be
>>> artificially constructed.
>>
>> Hannes,
>>
>> I generally agree with this approach. I'd like to point out though
>> that this is going to give up running RX from directly from softirq 
>> context.
> 
> Yes.
> 
>> I've gone back and forth on weather nvme-tcp should do that, but never
>> got to do a thorough comparison between the two. This probably shuts
>> the door on that option.
>>
> The thing with running from softirq context is that it would only
> make sense if we could _ensure_ that the softirq context is running
> on the cpu where the blk-mq hardware context is expecting it to.
> Not only would that require fiddling with RFS contexts, but we also
> found that NVMe-over-fabrics should _not_ try to align with hardware
> interrupts but rather rely on the driver to abstract things away.
> 
>> Having said that, I am fine with this approach. recvmsg is a saner 
>> interface.
>>
> Thanks!
> 
> 
> [ .. ]>> @@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct
>>> nvme_tcp_queue *queue,
>>>       return 0;
>>>   }
>>> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff 
>>> *skb,
>>> -                 unsigned int offset, size_t len)
>>> +static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
>>>   {
>>> -    struct nvme_tcp_queue *queue = desc->arg.data;
>>> -    size_t consumed = len;
>>> -    int result;
>>> +    char *ddgst = (char *)&queue->recv_ddgst;
>>> +    off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
>>> +    struct msghdr msg = {
>>> +        .msg_flags = MSG_WAITALL,
>>> +    };
>>
>> I don't think we want to use MSG_WAITALL ever. Why are you opting to 
>> do that?
>>
> Hmm. You are right, it's not needed.
> 
> [ .. ]>> @@ -1356,20 +1355,38 @@ static int nvme_tcp_try_send(struct
>>> nvme_tcp_queue *queue)
>>>       return ret;
>>>   }
>>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>>> +static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>>>   {
>>> -    struct socket *sock = queue->sock;
>>> -    struct sock *sk = sock->sk;
>>> -    read_descriptor_t rd_desc;
>>> -    int consumed;
>>> +    int result;
>>> +    int nr_cqe = queue->nr_cqe;
>>> +
>>> +    if (unlikely(!queue->rd_enabled))
>>> +        return -EFAULT;
>>> +
>>> +    do {
>>> +        switch (nvme_tcp_recv_state(queue)) {
>>> +        case NVME_TCP_RECV_PDU:
>>> +            result = nvme_tcp_recvmsg_pdu(queue);
>>> +            break;
>>> +        case NVME_TCP_RECV_DATA:
>>> +            result = nvme_tcp_recvmsg_data(queue);
>>> +            break;
>>> +        case NVME_TCP_RECV_DDGST:
>>> +            result = nvme_tcp_recvmsg_ddgst(queue);
>>> +            break;
>>> +        default:
>>> +            result = -EFAULT;
>>> +        }
>>> +    } while (result >= 0);
>>> +
>>> +    if (result < 0 && result != -EAGAIN) {
>>> +        dev_err(queue->ctrl->ctrl.device,
>>> +            "receive failed:  %d\n", result);
>>> +        queue->rd_enabled = false;
>>> +        nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>> +    }
>>> -    rd_desc.arg.data = queue;
>>> -    rd_desc.count = 1;
>>> -    lock_sock(sk);
>>> -    queue->nr_cqe = 0;
>>> -    consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>> -    release_sock(sk);
>>> -    return consumed == -EAGAIN ? 0 : consumed;
>>> +    return result < 0 ? result : (queue->nr_cqe = nr_cqe);
>>
>> This is changing the semantics of the retcode - can you please 
>> document in the commit msg
>> the change?
>>
> That was done to be compatible with the polling interface.
> I'll check if it's needed after all.
> 
Actually, I don't think I'm changing the interface.
The original interface would return either a negative number on error,
'0' if no PDUs have been processed, or the number of processed PDUs.
And the new recvmsg interface does the same (I think).
The only change which I did was to _not_ map out -EAGAIN, as this will
be handled by the 'data_ready' callback.
(Reasoning: -EAGAIN is returned when there is no (or not enough) data
to be read, and the network layer will call ->data_ready once the
situation improves. If we continue with the loop we will race/compete
with the networking layer, causing us to do duplicated work as the
io_work thread will be picking up the new data _and_ the data_ready
callback will be scheduling the io_work callback to pick up the new
data. So we can safely stop on -EAGAIN knowing that we'll be woken
up once we can continue to read data.).
(And arguably this was an issue with the original code, too.).

So where is the change in semantics?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

