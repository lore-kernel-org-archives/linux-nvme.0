Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB9C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qozswMTZfbYy3l0r9aGRX2JnqzRvsHKtNOAyo+7/FZw=; b=ManOtaarbKSskmynhl7M2/34WS
	nHRf3RsKl95PmkzmrK2vK1BR8tbPcytTm3THNsaq3zyNYFpz5ci110n+LlLWKFRevxp0ixR6v5jzu
	VCHJtllTnEprnrM2EiLhEVkVYajXEdKEZx4Xo5UU89BBaICFuI7tF8l0XShtOSXs59NDutyhQXYN9
	XiLHDeXBDyw4SVuNJfhP4fb89duNeR9KFwyW53kyTbtdMZ0VWIRDSz30p8pPPUQA+dpMb2UkKQeTb
	W2o2fExt01yXDEvRm3E/XHufpF4p8ok8EROrMdwSqAEJogRCq9f3b+twdmmx/h+mTLcwKP3yk1ClX
	vnpUroKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecWB-00Cdij-2A;
	Tue, 21 Mar 2023 13:59:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecW5-00Cdfz-1y
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:59:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC8E7200D0;
	Tue, 21 Mar 2023 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679407145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qozswMTZfbYy3l0r9aGRX2JnqzRvsHKtNOAyo+7/FZw=;
	b=bIoSw4t8jQHcXVTaZzN152t5tJgpcxj1H2sCgPbr40HMrAEe/DLqVVtCvBwK27tz3efPua
	/usGc4PRtYOZCqN8DN9lReiu788zeuPkjdnF8FObd39Av8GtULxyrMpvXNVKvHeUJsjmCi
	YwEUfkWB38Fvox+UVFnFxcEhSmijQ5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679407145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qozswMTZfbYy3l0r9aGRX2JnqzRvsHKtNOAyo+7/FZw=;
	b=FUIOcZL82wSAdF6pud59Ubs2boPbA4PHIHudq0BwQYhR8pG21B8OqoXxzYL4oaNGZo52lc
	thw47n80V0X/KSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A74D213451;
	Tue, 21 Mar 2023 13:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 19/wJim4GWTaIQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Mar 2023 13:59:05 +0000
Message-ID: <68939be5-4a64-8d02-2aad-4d7b7daf2152@suse.de>
Date: Tue, 21 Mar 2023 14:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-6-hare@suse.de>
 <1fd17fd4-c52a-c29a-d15c-143a316eab9a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/18] nvme-tcp: implement recvmsg rx flow for TLS
In-Reply-To: <1fd17fd4-c52a-c29a-d15c-143a316eab9a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_065909_939159_67540040 
X-CRM114-Status: GOOD (  33.65  )
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

On 3/21/23 14:39, Sagi Grimberg wrote:
> 
> 
> On 3/21/23 14:43, Hannes Reinecke wrote:
>> TLS offload only implements recvmsg(), so implement the receive
>> side with using recvmsg().
> 
> I don't really mind changing this, however this change makes us
> lock the socket for every consumption, instead of taking the lock
> once and consume as much as possible. Which in theory is suboptimal.
> 
> Is there any material reason why tls cannot implement read_sock() ?
> 
Because the 'read_sock()' interface operates on skbs, but for TLS we 
just have a 'stream' (there is this 'stream parser' thingie handling the 
data), and skbs are meaningless as the decrypted payload can extend 
across several skbs.
At least, that's how I understood that.

But really, the prime reason is that I'm _far_ more familiar with the 
NVMe code than the tls networking code, so implementing the recvmsg() 
flow was relatively simple.

Maybe we can ask Boris Pismenny to implement read_sock() for tls ...

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 156 ++++++++++++++++++++--------------------
>>   1 file changed, 77 insertions(+), 79 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 42c0598c31f2..0e14b1b90855 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -529,7 +529,7 @@ static void nvme_tcp_init_recv_ctx(struct 
>> nvme_tcp_queue *queue)
>>       queue->pdu_remaining = sizeof(struct nvme_tcp_rsp_pdu) +
>>                   nvme_tcp_hdgst_len(queue);
>>       queue->pdu_offset = 0;
>> -    queue->data_remaining = -1;
>> +    queue->data_remaining = 0;
>>       queue->ddgst_remaining = 0;
>>   }
>> @@ -707,25 +707,32 @@ static int nvme_tcp_handle_r2t(struct 
>> nvme_tcp_queue *queue,
>>       return 0;
>>   }
>> -static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct 
>> sk_buff *skb,
>> -        unsigned int *offset, size_t *len)
>> +static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, bool pending)
>>   {
>>       struct nvme_tcp_hdr *hdr;
>> -    char *pdu = queue->pdu;
>> -    size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>> +    size_t rcv_len = queue->pdu_remaining;
>> +    struct msghdr msg = {
>> +        .msg_flags = pending ? 0 : MSG_DONTWAIT,
> 
> Umm, why?
> What is the reason to block in this recv?
> 
To avoid frequent -EAGAIN returns; that looked really ugly in the
debug logs :-)
Can try to do away with that; if we do also the 'pending' argument
can be removed, so might be an idea.

>> +    };
>> +    struct kvec iov = {
>> +        .iov_base = (u8 *)queue->pdu + queue->pdu_offset,
>> +        .iov_len = rcv_len,
>> +    };
>>       int ret;
>> -    ret = skb_copy_bits(skb, *offset,
>> -        &pdu[queue->pdu_offset], rcv_len);
>> -    if (unlikely(ret))
>> +    if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_PDU)
>> +        return 0;
> 
> Why is this check needed? looks like a left-over.
> 
Yeah.

>> +
>> +    ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>> +                 iov.iov_len, msg.msg_flags);
>> +    if (ret <= 0)
>>           return ret;
>> +    rcv_len = ret;
>>       queue->pdu_remaining -= rcv_len;
>>       queue->pdu_offset += rcv_len;
>> -    *offset += rcv_len;
>> -    *len -= rcv_len;
>>       if (queue->pdu_remaining)
>> -        return 0;
>> +        return queue->pdu_remaining;
>>       hdr = queue->pdu;
>>       if (queue->hdr_digest) {
>> @@ -734,7 +741,6 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue 
>> *queue, struct sk_buff *skb,
>>               return ret;
>>       }
>> -
>>       if (queue->data_digest) {
>>           ret = nvme_tcp_check_ddgst(queue, queue->pdu);
>>           if (unlikely(ret))
>> @@ -765,19 +771,21 @@ static inline void nvme_tcp_end_request(struct 
>> request *rq, u16 status)
>>           nvme_complete_rq(rq);
>>   }
>> -static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct 
>> sk_buff *skb,
>> -                  unsigned int *offset, size_t *len)
>> +static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>>       struct request *rq =
>>           nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>>       struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +    if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>> +        return 0;
>> +
>>       while (true) {
>> -        int recv_len, ret;
>> +        struct msghdr msg;
>> +        int ret;
>> -        recv_len = min_t(size_t, *len, queue->data_remaining);
>> -        if (!recv_len)
>> +        if (!queue->data_remaining)
>>               break;
>>           if (!iov_iter_count(&req->iter)) {
>> @@ -798,25 +806,20 @@ static int nvme_tcp_recv_data(struct 
>> nvme_tcp_queue *queue, struct sk_buff *skb,
>>           }
>>           /* we can read only from what is left in this bio */
>> -        recv_len = min_t(size_t, recv_len,
>> -                iov_iter_count(&req->iter));
>> +        memset(&msg, 0, sizeof(msg));
>> +        msg.msg_iter = req->iter;
>> -        if (queue->data_digest)
>> -            ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>> -                &req->iter, recv_len, queue->rcv_hash);
>> -        else
>> -            ret = skb_copy_datagram_iter(skb, *offset,
>> -                    &req->iter, recv_len);
>> -        if (ret) {
>> +        ret = sock_recvmsg(queue->sock, &msg, 0);
> 
> Who updates the rcv_hash for data digest validation?
> 
Weelll ... currently, no-one.
One of the things which I haven't tested.

>> +        if (ret <= 0) {
>>               dev_err(queue->ctrl->ctrl.device,
>> -                "queue %d failed to copy request %#x data",
>> +                "queue %d failed to receive request %#x data",
>>                   nvme_tcp_queue_id(queue), rq->tag);
>>               return ret;
>>           }
>> -        *len -= recv_len;
>> -        *offset += recv_len;
>> -        queue->data_remaining -= recv_len;
>> +        queue->data_remaining -= ret;
>> +        if (queue->data_remaining)
>> +            nvme_tcp_advance_req(req, ret);
>>       }
>>       if (!queue->data_remaining) {
>> @@ -833,27 +836,36 @@ static int nvme_tcp_recv_data(struct 
>> nvme_tcp_queue *queue, struct sk_buff *skb,
>>           }
>>       }
>> -    return 0;
>> +    return queue->data_remaining;
>>   }
>> -static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>> -        struct sk_buff *skb, unsigned int *offset, size_t *len)
>> +static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>>       char *ddgst = (char *)&queue->recv_ddgst;
>> -    size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>> +    size_t recv_len = queue->ddgst_remaining;
>>       off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
>> +    struct msghdr msg = {
>> +        .msg_flags = 0,
>> +    };
>> +    struct kvec iov = {
>> +        .iov_base = (u8 *)ddgst + off,
>> +        .iov_len = recv_len,
>> +    };
>>       int ret;
>> -    ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>> -    if (unlikely(ret))
>> +    if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DDGST)
>> +        return 0;
>> +
>> +    ret = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
>> +                 msg.msg_flags);
>> +    if (ret <= 0)
>>           return ret;
>> +    recv_len = ret;
>>       queue->ddgst_remaining -= recv_len;
>> -    *offset += recv_len;
>> -    *len -= recv_len;
>>       if (queue->ddgst_remaining)
>> -        return 0;
>> +        return queue->ddgst_remaining;
>>       if (queue->recv_ddgst != queue->exp_ddgst) {
>>           struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
>> @@ -881,37 +893,41 @@ static int nvme_tcp_recv_ddgst(struct 
>> nvme_tcp_queue *queue,
>>       return 0;
>>   }
>> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff 
>> *skb,
>> -                 unsigned int offset, size_t len)
>> +static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, bool pending)
>>   {
>> -    struct nvme_tcp_queue *queue = desc->arg.data;
>> -    size_t consumed = len;
>>       int result;
>> +    int nr_cqe = queue->nr_cqe;
>> -    while (len) {
>> +    do {
>>           switch (nvme_tcp_recv_state(queue)) {
>>           case NVME_TCP_RECV_PDU:
>> -            result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
>> -            break;
>> +            result = nvme_tcp_recv_pdu(queue, pending);
>> +            if (result)
>> +                break;
>> +            fallthrough;
>>           case NVME_TCP_RECV_DATA:
>> -            result = nvme_tcp_recv_data(queue, skb, &offset, &len);
>> -            break;
>> +            result = nvme_tcp_recv_data(queue);
>> +            if (result)
>> +                break;
>> +            fallthrough;
>>           case NVME_TCP_RECV_DDGST:
>> -            result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
>> +            result = nvme_tcp_recv_ddgst(queue);
>>               break;
>>           default:
>>               result = -EFAULT;
>>           }
>> -        if (result) {
>> -            dev_err(queue->ctrl->ctrl.device,
>> -                "receive failed:  %d\n", result);
>> -            queue->rd_enabled = false;
>> -            nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>> -            return result;
>> -        }
>> +        if (nr_cqe != queue->nr_cqe)
>> +            break;
>> +    } while (result >= 0);
>> +    if (result < 0 && result != -EAGAIN) {
>> +        dev_err(queue->ctrl->ctrl.device,
>> +            "receive failed: %d state %d %s\n",
>> +            result, nvme_tcp_recv_state(queue),
>> +            pending ? "pending" : "");
> 
> I'm unclear why pending would be an input to try_recv. Semantically
> it is an output, signalling the io_work that data is pending to be
> reaped from the socket.
> 
See above. 'pending' is really there to clear the 'NOWAIT' flag for 
recvmsg(), and to avoid frequent -EAGAIN returns.
If we're fine handling them it can be removed.

>> +        queue->rd_enabled = false;
>> +        nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>       }
>> -
>> -    return consumed;
>> +    return result < 0 ? result : (queue->nr_cqe - nr_cqe);
> 
> Isn't it possible that we consumed data but no completion in this
> round? I'm assuming that

See above, that't the -EAGAIN issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


