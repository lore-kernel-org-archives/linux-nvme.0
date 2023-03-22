Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145B3C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8rP0HEOS+ydJr5rcsvjAHnVZhWWxFCV6VPdTnEDjyk=; b=u/UUhh27pon50lv9ro8rMctUHd
	SauEct9oly/+R0WzKDWC87QSm23G4Nzw/kdwnwPeuRabd1QatSti+KsxUlVGX0lFo31/xA0vOQqb1
	veT3ZqoWUjZ1I0BMGsmhIJRGBb+jqn6mKjmWYB02IluNUcE9n1uAEb4/lT44vihykEQVzVGRbUQZ4
	QOfkSGtCrlwtVrPxe3EakayDvwgVATLJDeVr/FySdBk2H1/JV7jXOmT7jC8Ac9IClkpDql5Nepr17
	ttzPtoaqKPnG0welG9FI7jomtrjwku0hflOShbvmC8YtJGCFkgDNl9ZTQpddnWevCYGzrY2k9PyD/
	ZKf6/XnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pevOk-00FaTz-14;
	Wed, 22 Mar 2023 10:08:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pevOg-00FaTJ-2y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 10:08:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4F020C3D;
	Wed, 22 Mar 2023 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679479725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8rP0HEOS+ydJr5rcsvjAHnVZhWWxFCV6VPdTnEDjyk=;
	b=1lHk0A+4VuJLmxQRmkDf8Y3oiYfa2cuUOYrPCUYOqDt/RdzsSpobih/DG4ii54c/4VCr4G
	UO6KfNZGROAorD9qSL6Y1BzrRgigqDj22BQMZA3ckmfXUz80ml4jXXBdmYzAODp3mpnpPC
	Y+mMowwHUr1M3loGGYLuPKvcrIFyAck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679479725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8rP0HEOS+ydJr5rcsvjAHnVZhWWxFCV6VPdTnEDjyk=;
	b=IpPDfV1qLkzkLj+PM9R8E7sY5wD682f4T/UMXMrDRsfDshiaaFXWR/cEWLdaUsGl6wN6wQ
	PAYvJONpGEQOZiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 490DF138E9;
	Wed, 22 Mar 2023 10:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id X7iREa3TGmSeBwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 10:08:45 +0000
Message-ID: <3b0f2af5-5dfa-ed76-a6a6-2715d9e05e70@suse.de>
Date: Wed, 22 Mar 2023 11:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-11-hare@suse.de>
 <e189b779-8621-bfa6-4c7a-1eb38bd1c29d@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e189b779-8621-bfa6-4c7a-1eb38bd1c29d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_030847_107646_009F513E 
X-CRM114-Status: GOOD (  31.27  )
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

On 3/22/23 10:31, Sagi Grimberg wrote:
> 
> 
> On 3/21/23 14:43, Hannes Reinecke wrote:
>> kTLS does not support MSG_EOR flag for sendmsg(), and the ->sendpage()
>> call really doesn't bring any benefit as data has to be copied
>> anyway.
>> So use sock_no_sendpage() or sendmsg() instead, and ensure that the
>> MSG_EOR flag is blanked out for kTLS.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 33 +++++++++++++++++++++------------
>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index bbff1f52a167..007d457cacf9 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1034,13 +1034,19 @@ static int nvme_tcp_try_send_data(struct 
>> nvme_tcp_request *req)
>>           bool last = nvme_tcp_pdu_last_send(req, len);
>>           int req_data_sent = req->data_sent;
>>           int ret, flags = MSG_DONTWAIT;
>> +        bool do_sendpage = sendpage_ok(page);
>> -        if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
>> +        if (!last || queue->data_digest || nvme_tcp_queue_more(queue))
>> +            flags |= MSG_MORE;
>> +        else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
>>               flags |= MSG_EOR;
>> -        else
>> -            flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> 
> I think its time to move the flags setting to a helper.
> 
>> -        if (sendpage_ok(page)) {
>> +        if (test_bit(NVME_TCP_Q_TLS, &queue->flags))
>> +            do_sendpage = false;
>> +
>> +        if (do_sendpage) {
> 
> The do_sendpage looks redundant to me.
> 
>> +            if (flags & MSG_MORE)
>> +                flags |= MSG_SENDPAGE_NOTLAST;
>>               ret = kernel_sendpage(queue->sock, page, offset, len,
>>                       flags);
> 
> I think that the SENDPAGE_NOLAST should be set together with MSG_MORE
> regardless.
> 
>>           } else {
>> @@ -1088,19 +1094,22 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
>> nvme_tcp_request *req)
>>       bool inline_data = nvme_tcp_has_inline_data(req);
>>       u8 hdgst = nvme_tcp_hdgst_len(queue);
>>       int len = sizeof(*pdu) + hdgst - req->offset;
>> -    int flags = MSG_DONTWAIT;
>> +    struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>> +    struct kvec iov = {
>> +        .iov_base = (u8 *)req->pdu + req->offset,
>> +        .iov_len = len,
>> +    };
>>       int ret;
>>       if (inline_data || nvme_tcp_queue_more(queue))
>> -        flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
>> -    else
>> -        flags |= MSG_EOR;
>> +        msg.msg_flags |= MSG_MORE;
>> +    else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
>> +        msg.msg_flags |= MSG_EOR;
>>       if (queue->hdr_digest && !req->offset)
>>           nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>> -    ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>> -            offset_in_page(pdu) + req->offset, len,  flags);
>> +    ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
> 
> I'd prefer to do kernel_sednpage/sock_no_sendpage similar to how we do
> it for data and data pdu.
> 
>>       if (unlikely(ret <= 0))
>>           return ret;
>> @@ -1131,7 +1140,7 @@ static int nvme_tcp_try_send_data_pdu(struct 
>> nvme_tcp_request *req)
>>       if (queue->hdr_digest && !req->offset)
>>           nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>> -    if (!req->h2cdata_left)
>> +    if (!test_bit(NVME_TCP_Q_TLS, &queue->flags) && !req->h2cdata_left)
>>           ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>>                   offset_in_page(pdu) + req->offset, len,
>>                   MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> 
> Something is unclear to me. Is kernel_sendpage unsupported with tls? (I
> think it is). I understand the motivation to add more checks in the code
> for kernel_sendpage vs. sock_no_sendpage given that it should be
> perfectly fine to use either.
> 
> Did you see any regressions with using kernel_sendpage? If so, isn't
> that a bug in the tls code?

The actual issue with the tls code is the 'MSG_EOR' handling.
Problem is that tls is using MSG_EOR internally, and bails out on 
unknown MSG_ settings:

int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
{
[ .. ]
         if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
                                MSG_CMSG_COMPAT))
                 return -EOPNOTSUPP;

I would _vastly_ prefer to blank out unsupported flags (like MSG_EOR) 
from the TLS code, because to all intents and purposes MSG_EOR is just 
the opposite of MSG_MORE.
Or drop MSG_EOR usage from the nvme tcp code.
But then I'm not _that_ into the networking code to make a judgement here.
And as we're using sendmsg() already I had been switching to use it for 
ktls, too (as I know that the sendmsg() flow worked).
But in the end I guess we could use sendpage going forward.

I'll check.

Cheers,

Hannes


