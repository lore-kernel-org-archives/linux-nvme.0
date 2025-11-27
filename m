Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7EBD11183
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ieDsI5VdGij3DTKwCs9SK4yr9sxrPIOPNng5hL3GtVM=; b=etD9Dw8w0sJOAN9so20K9g/llJ
	LqR5xKFrTN/uRAvIeUFQEJEBaT9+TUmjGJPPAg/UeMAbviwbklwlBs804g+Vv+8GP/wXfFVPFs6nL
	nJiksfmXgXapD0Vs8ZHr2+hWwHcmDpyF7IBVBdiIlcXXAEoZecfyU70PJ1VBZ1eNhRbVoO0zCHds8
	uLhcadgRVrRfubHuslE+XYVP4lX8iMj8ziS5k/H90uUN3vXM6SNa5Njdi2wCXgXMNHJ9k1MQgKfvj
	3DUBMd4y4TW+mQwfSqe9ierGzoKhNcTJ7gWrCVmN4R8/WMFiKV0DCuu3YQVzMvq5WfDaKFpgdbDps
	qfNfDM1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWnY-0000000G9yq-3RUs;
	Thu, 27 Nov 2025 07:52:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWnW-0000000G9yE-3bzC
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 07:52:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 145C221235;
	Thu, 27 Nov 2025 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764229933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieDsI5VdGij3DTKwCs9SK4yr9sxrPIOPNng5hL3GtVM=;
	b=FEWaPrWot3skLKQ5SN04362Dae4ZxUNl3ms3eiziL5z1sLGXkftUniWSnlMptFF4TcnhNA
	1q8ffp0gVG1XTgyF5aODdlEUapxj88TE7IRaMMD2JNRv0jQgQ4mPzNZInI0OpkJBDwg6gZ
	BYCMMspXZQ4wZGlJCtKjiYk9xkMvSYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764229933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieDsI5VdGij3DTKwCs9SK4yr9sxrPIOPNng5hL3GtVM=;
	b=bOdavmAXQZeSY0uM6NEwho/LHzeZTRL7sL7pYS18Utnwrunu+oSv9ahNCAlnNqfy81PU1Z
	+twKlfukSoVJztAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O6oGhpr+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PDVSTUCl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764229932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieDsI5VdGij3DTKwCs9SK4yr9sxrPIOPNng5hL3GtVM=;
	b=O6oGhpr+zPBKaV2IXqJKib3QxNooYOGHBo592EZlj1+2960AY8oVDqPOyzCJEt0MwyNcDo
	+YmEYf6FiDZL4K8/h+cPpRcInMc5SbupFdQxw31lZUDRG+nDYNuwcej9yHyE0Nh03060oU
	FWokJhqH6BlCd5kXT9UJaUh5b7XJbSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764229932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieDsI5VdGij3DTKwCs9SK4yr9sxrPIOPNng5hL3GtVM=;
	b=PDVSTUClo9DGT5bmRbW1dqwxNRpeq/j5rK+7d1k/s4+n23xcVPchkIBUyvY/bSss6S6OG6
	hAHcDjqxeab8XkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC1033EA63;
	Thu, 27 Nov 2025 07:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YlgMKisDKGloBgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 07:52:11 +0000
Message-ID: <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
Date: Thu, 27 Nov 2025 08:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 145C221235
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_235215_211194_17CA61F4 
X-CRM114-Status: GOOD (  31.61  )
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

On 11/26/25 08:32, Sagi Grimberg wrote:
> 
> 
> On 20/10/2025 11:58, Hannes Reinecke wrote:
>> The nvme-tcp code is using the ->read_sock() interface to
>> read data from the wire. While this interface gives us access
>> to the skbs themselves (and so might be able to reduce latency)
>> it does not interpret the skbs.
>> Additionally for TLS these skbs have to be re-constructed from
>> the TLS stream data, rendering any advantage questionable.
>> But the main drawback for TLS is that we do not get access to
>> the TLS control messages, so if we receive any of those message
>> the only choice we have is to tear down the connection and restart.
>> This patch switches the receive side over to use recvmsg(), which
>> provides us full access to the TLS control messages and is also
>> more efficient when working with TLS as skbs do not need to be
>> artificially constructed.
> 
> Hannes,
> 
> I generally agree with this approach. I'd like to point out though
> that this is going to give up running RX from directly from softirq 
> context.

Yes.

> I've gone back and forth on weather nvme-tcp should do that, but never
> got to do a thorough comparison between the two. This probably shuts
> the door on that option.
> 
The thing with running from softirq context is that it would only
make sense if we could _ensure_ that the softirq context is running
on the cpu where the blk-mq hardware context is expecting it to.
Not only would that require fiddling with RFS contexts, but we also
found that NVMe-over-fabrics should _not_ try to align with hardware
interrupts but rather rely on the driver to abstract things away.

> Having said that, I am fine with this approach. recvmsg is a saner 
> interface.
> 
Thanks!


[ .. ]>> @@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct
>> nvme_tcp_queue *queue,
>>       return 0;
>>   }
>> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff 
>> *skb,
>> -                 unsigned int offset, size_t len)
>> +static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
>>   {
>> -    struct nvme_tcp_queue *queue = desc->arg.data;
>> -    size_t consumed = len;
>> -    int result;
>> +    char *ddgst = (char *)&queue->recv_ddgst;
>> +    off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
>> +    struct msghdr msg = {
>> +        .msg_flags = MSG_WAITALL,
>> +    };
> 
> I don't think we want to use MSG_WAITALL ever. Why are you opting to do 
> that?
> 
Hmm. You are right, it's not needed.

[ .. ]>> @@ -1356,20 +1355,38 @@ static int nvme_tcp_try_send(struct
>> nvme_tcp_queue *queue)
>>       return ret;
>>   }
>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>> +static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>>   {
>> -    struct socket *sock = queue->sock;
>> -    struct sock *sk = sock->sk;
>> -    read_descriptor_t rd_desc;
>> -    int consumed;
>> +    int result;
>> +    int nr_cqe = queue->nr_cqe;
>> +
>> +    if (unlikely(!queue->rd_enabled))
>> +        return -EFAULT;
>> +
>> +    do {
>> +        switch (nvme_tcp_recv_state(queue)) {
>> +        case NVME_TCP_RECV_PDU:
>> +            result = nvme_tcp_recvmsg_pdu(queue);
>> +            break;
>> +        case NVME_TCP_RECV_DATA:
>> +            result = nvme_tcp_recvmsg_data(queue);
>> +            break;
>> +        case NVME_TCP_RECV_DDGST:
>> +            result = nvme_tcp_recvmsg_ddgst(queue);
>> +            break;
>> +        default:
>> +            result = -EFAULT;
>> +        }
>> +    } while (result >= 0);
>> +
>> +    if (result < 0 && result != -EAGAIN) {
>> +        dev_err(queue->ctrl->ctrl.device,
>> +            "receive failed:  %d\n", result);
>> +        queue->rd_enabled = false;
>> +        nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>> +    }
>> -    rd_desc.arg.data = queue;
>> -    rd_desc.count = 1;
>> -    lock_sock(sk);
>> -    queue->nr_cqe = 0;
>> -    consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>> -    release_sock(sk);
>> -    return consumed == -EAGAIN ? 0 : consumed;
>> +    return result < 0 ? result : (queue->nr_cqe = nr_cqe);
> 
> This is changing the semantics of the retcode - can you please document 
> in the commit msg
> the change?
> 
That was done to be compatible with the polling interface.
I'll check if it's needed after all.

>>   }
>>   static void nvme_tcp_io_work(struct work_struct *w)
>> @@ -1391,7 +1408,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>                   break;
>>           }
>> -        result = nvme_tcp_try_recv(queue);
>> +        result = nvme_tcp_try_recvmsg(queue);
>>           if (result > 0)
>>               pending = true;
>>           else if (unlikely(result < 0))
>> @@ -2800,7 +2817,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>> *hctx, struct io_comp_batch *iob)
>>       set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>       if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk- 
>> >sk_receive_queue))
>>           sk_busy_loop(sk, true);
>> -    ret = nvme_tcp_try_recv(queue);
>> +    ret = nvme_tcp_try_recvmsg(queue);
>>       clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>       return ret < 0 ? ret : queue->nr_cqe;
>>   
Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

