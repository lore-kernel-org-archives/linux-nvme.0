Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D08FCEE8E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rbky4ye+YRmU795/aMGryQwd2QUhsEnRkfSJD/HBqKU=; b=qX69xHfE1CMguRF4MeEEMQE78m
	4ulP9JjVLb+oUc089Ru3tEXg9XumT1LGezdOK/CZEHQxlMn8a/+0IH85165SCTtSs25NqD3v/uuMP
	Hay1eAeth9A8tFSGqHvHZbMvHPO0Abf3D0jtuNheEzNvK0/ylZ5gEigzu2iI1iAqzAa+5DBzPYQbQ
	5px6QXbLEnC+eJXF75IqyNwDw/0+fpVKfLXfdDGRWVeRTfCHTZ5t21qE1v55RqUruHmVsI4vS+gFR
	5CN8U1rJXxFLyvtc4fo+1gAwBY+Z4j8LoK4x8pSqCUxCCW7UA9z41dEgkNVRgk7bxccniUMmjmD8O
	L/9u02vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvDGf-00000003vpS-1fWy;
	Wed, 25 Feb 2026 11:41:25 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvDGc-00000003voW-2Bmb
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 11:41:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B9F64019C;
	Wed, 25 Feb 2026 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772019680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbky4ye+YRmU795/aMGryQwd2QUhsEnRkfSJD/HBqKU=;
	b=p7FS/ETwvwqbfMppOV8uMGlCDNyEf/a6zepLaR9i3c8N5/mDA+9p7Rsfic3SWoyMXPI1Os
	QpmYae+5G7z+DFqgntWM5CPYQE+YHjp7/NgweHzkCCq47iNuswhvdZWByBYriFtznX3XlA
	gnyqJgkKboVcB/+JXVQ24tdAvnTxTZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772019680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbky4ye+YRmU795/aMGryQwd2QUhsEnRkfSJD/HBqKU=;
	b=QPPG9dKvmJnMfbOT6PtaXHHb+XKkNHyOM8omwBpWvqUIi0ye2qZPxV+7PDO+2d6Gm+/9/b
	anx1G3Jz9eF6vvCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772019680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbky4ye+YRmU795/aMGryQwd2QUhsEnRkfSJD/HBqKU=;
	b=p7FS/ETwvwqbfMppOV8uMGlCDNyEf/a6zepLaR9i3c8N5/mDA+9p7Rsfic3SWoyMXPI1Os
	QpmYae+5G7z+DFqgntWM5CPYQE+YHjp7/NgweHzkCCq47iNuswhvdZWByBYriFtznX3XlA
	gnyqJgkKboVcB/+JXVQ24tdAvnTxTZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772019680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbky4ye+YRmU795/aMGryQwd2QUhsEnRkfSJD/HBqKU=;
	b=QPPG9dKvmJnMfbOT6PtaXHHb+XKkNHyOM8omwBpWvqUIi0ye2qZPxV+7PDO+2d6Gm+/9/b
	anx1G3Jz9eF6vvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE8B3EA65;
	Wed, 25 Feb 2026 11:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B5LEHeDfnmmBJgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Feb 2026 11:41:20 +0000
Message-ID: <b778bc2f-5911-431c-9b65-1fbaea68fd4d@suse.de>
Date: Wed, 25 Feb 2026 12:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
To: Alistair Francis <Alistair.Francis@wdc.com>, hch <hch@lst.de>,
 "hare@kernel.org" <hare@kernel.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250912115829.58669-1-hare@kernel.org>
 <99c9b1f7d8bbeca3681bb2f8502fe6af1374df8d.camel@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <99c9b1f7d8bbeca3681bb2f8502fe6af1374df8d.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_034122_880038_4FCA335B 
X-CRM114-Status: GOOD (  37.51  )
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

On 2/25/26 11:56, Alistair Francis wrote:
> On Fri, 2025-09-12 at 13:58 +0200, Hannes Reinecke wrote:
>> Switch to use recvmsg() so that we get access to TLS control
>> messages eg for handling TLS KeyUpdate.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 204 ++++++++++++++++++++++----------------
>> --
>>   1 file changed, 111 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index c0fe8cfb7229..9ef1d4aea838 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -17,6 +17,7 @@
>>   #include <net/tls_prot.h>
>>   #include <net/handshake.h>
>>   #include <linux/blk-mq.h>
>> +#include <linux/iov_iter.h>
>>   #include <net/busy_poll.h>
>>   #include <trace/events/sock.h>
>>   
>> @@ -476,6 +477,28 @@ static inline void nvme_tcp_ddgst_update(u32
>> *crcp,
>>   	}
>>   }
>>   
>> +static size_t nvme_tcp_ddgst_step(void *iter_base, size_t progress,
>> size_t len,
>> +				  void *priv, void *priv2)
>> +{
>> +	u32 *crcp = priv;
>> +
>> +	*crcp = crc32c(*crcp, iter_base, len);
>> +        return 0;
>> +}
>> +
>> +static int nvme_tcp_ddgst_calc(struct nvme_tcp_request *req, u32
>> *crcp,
>> +			       size_t maxsize)
>> +{
>> +	struct iov_iter tmp = req->iter;
>> +	int err = 0;
>> +
>> +	tmp.count = maxsize;
>> +	if (iterate_and_advance_kernel(&tmp, maxsize, crcp, &err,
>> +				       nvme_tcp_ddgst_step) !=
>> maxsize)
>> +		return err;
>> +	return 0;
>> +}
>> +
>>   static inline __le32 nvme_tcp_ddgst_final(u32 crc)
>>   {
>>   	return cpu_to_le32(~crc);
>> @@ -827,23 +850,26 @@ static void nvme_tcp_handle_c2h_term(struct
>> nvme_tcp_queue *queue,
>>   		"Received C2HTermReq (FES = %s)\n", msg);
>>   }
>>   
>> -static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct
>> sk_buff *skb,
>> -		unsigned int *offset, size_t *len)
>> +static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>>   {
>> -	struct nvme_tcp_hdr *hdr;
>>   	char *pdu = queue->pdu;
>> -	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>> +	struct msghdr msg = {
>> +		.msg_flags = MSG_DONTWAIT,
>> +	};
>> +	struct kvec iov = {
>> +		.iov_base = pdu + queue->pdu_offset,
>> +		.iov_len = queue->pdu_remaining,
>> +	};
>> +	struct nvme_tcp_hdr *hdr;
>>   	int ret;
>>   
>> -	ret = skb_copy_bits(skb, *offset,
>> -		&pdu[queue->pdu_offset], rcv_len);
>> -	if (unlikely(ret))
>> +	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>> +			     iov.iov_len, msg.msg_flags);
>> +	if (ret <= 0)
>>   		return ret;
>>   
>> -	queue->pdu_remaining -= rcv_len;
>> -	queue->pdu_offset += rcv_len;
>> -	*offset += rcv_len;
>> -	*len -= rcv_len;
>> +	queue->pdu_remaining -= ret;
>> +	queue->pdu_offset += ret;
>>   	if (queue->pdu_remaining)
>>   		return 0;
>>   
>> @@ -907,20 +933,19 @@ static inline void nvme_tcp_end_request(struct
>> request *rq, u16 status)
>>   		nvme_complete_rq(rq);
>>   }
>>   
>> -static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct
>> sk_buff *skb,
>> -			      unsigned int *offset, size_t *len)
>> +static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>>   {
>>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>>   	struct request *rq =
>>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu-
>>> command_id);
>>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>>   
>> -	while (true) {
>> -		int recv_len, ret;
>> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>> +		return 0;
>>   
>> -		recv_len = min_t(size_t, *len, queue-
>>> data_remaining);
>> -		if (!recv_len)
>> -			break;
>> +	while (queue->data_remaining) {
>> +		struct msghdr msg;
>> +		int ret;
>>   
>>   		if (!iov_iter_count(&req->iter)) {
>>   			req->curr_bio = req->curr_bio->bi_next;
>> @@ -940,25 +965,22 @@ static int nvme_tcp_recv_data(struct
>> nvme_tcp_queue *queue, struct sk_buff *skb,
>>   		}
>>   
>>   		/* we can read only from what is left in this bio */
>> -		recv_len = min_t(size_t, recv_len,
>> -				iov_iter_count(&req->iter));
>> +		memset(&msg, 0, sizeof(msg));
>> +		msg.msg_iter = req->iter;
>> +		msg.msg_flags = MSG_DONTWAIT;
>>   
>> -		if (queue->data_digest)
>> -			ret = skb_copy_and_crc32c_datagram_iter(skb,
>> *offset,
>> -				&req->iter, recv_len, &queue-
>>> rcv_crc);
>> -		else
>> -			ret = skb_copy_datagram_iter(skb, *offset,
>> -					&req->iter, recv_len);
>> -		if (ret) {
>> +		ret = sock_recvmsg(queue->sock, &msg,
>> msg.msg_flags);
> 
> This doesn't work unfortunately.
> 
> The problem is what happens if queue->data_remaining is smaller then
> iov_iter_count(&req->iter)?
> 
> queue->data_remaining is set by the data length in the c2h, while the
> length of the request iov_iter_count(&req->iter) is set when the
> request is submitted.
> 
> If queue->data_remaining ends up being smaller then
> iov_iter_count(&req->iter) then we need to read less data then the
> actual count of req->iter.
> 
> So we need a iov_iter_truncate(), but then we end up overwriting the
> data on the next iteration as we have no way to keep...
> 
Question is, though: what _is_ in the remaining iov?
The most reasonable explanation would be that it's the start of the
next PDU (which we haven't accounted for, and hence haven't set
up pointers correctly).
I can see this happening for TLS when the sender doesn't space
the records correctly (ie if the PDU end is not falling on a
TLS record boundary).

But yeah, I can see the issue. While we can (and do)
advance the iterator to complete the request, we still
have the remaining data in the iterator.

What we can do, though, is to copy the remaining data over
to 'queue->pdu' (as we assume it's the start of the next PDU),
set up pointers, and let it rip.

Sounds okay-ish.

And it would certainly do away with the restriction of PDUs
having to be spaced on TLS record boundaries...


>> +		if (ret < 0) {
>>   			dev_err(queue->ctrl->ctrl.device,
>> -				"queue %d failed to copy request %#x
>> data",
>> +				"queue %d failed to receive request
>> %#x data",
>>   				nvme_tcp_queue_id(queue), rq->tag);
>>   			return ret;
>>   		}
>> -
>> -		*len -= recv_len;
>> -		*offset += recv_len;
> 
> ...this offset.
> 
Yikes. The is wrong, indeed.

> PDU and ddgst in this patch continue using an offset as they use
> kernel_recvmsg() instead of sock_recvmsg() directly.
> 
Argl. Rather not. I don't want to repackage iterators ...

> So I think either:
> 
>   1. I'm missing something and there is a nice way to do this, please
> let me know if that's the case.
See above. We could copy the remaining iter data onto 'queue->pdu',
and restart parsing.
(It _must_ be the start of a PDU anyway, otherwise queue->remaining 
would've covered it).

>   2. We need to convert this sock_recvmsg() to kernel_recvmsg(), with
> the overhead of an extra iov_iter (I don't know if that is high or not)

Rather not.

>   3. We use Chuck's read_sock with cmsg approach [1]

Another possibility.
Especially as now Chuck has worked on improving the TLS record spacing,
so this might be a possible avenue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

