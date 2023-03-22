Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D29AC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6CoRnLHaSyqkgGOg7i6OUA+oiRmqu/Q1ivlnNrZ/9g=; b=th31dR65bb2UEJSCLA46+K2bYA
	W2GZIJDOwuipID7ow+nXxBfwccu9HtgeT5w4t6cBCfaE+LR5M7f9JZqRqBMoZS593rHvqpKRqylyR
	sV5RCo7BDEWCia2SvC0aYK2kGx/jDqfo88lEvgUDGauBaXTZYcIQOzQrzPmyIerAM6tnna2WrxhSy
	iUwsJ0ICyzPpSdzcxihhaZDVyDwTA42rNs19A3nOQ9aAHpvFF5+A5YXorFyGLLLn0Rc6Qvqc0vtvf
	lAxEch0E2dgW07QVW854Vew/nbzkgPC3h/g7RCCicU7w3H0ISO21BuUp9PXDO/DKRgLZkcvZwLTTV
	XPate+Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexjs-00Fxdj-12;
	Wed, 22 Mar 2023 12:38:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexjp-00Fxcy-2H
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:38:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 504AB20D79;
	Wed, 22 Mar 2023 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679488721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6CoRnLHaSyqkgGOg7i6OUA+oiRmqu/Q1ivlnNrZ/9g=;
	b=oDWPzogX/+H/Bmbt9ODPA+TUGmOcTHUVqjJDwZInwa6KvC4YadmXzmKuOZvDPEh9A/jyaQ
	h+I8Fze/ZssQIh4O15oVzjnrPB8SU57/xzEvyMsrCRaHcXmsesvH3BYynnM1Jx7/O7EbjD
	Fpe2mKQApRE1KwDloJVo+qRqdpDylKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679488721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6CoRnLHaSyqkgGOg7i6OUA+oiRmqu/Q1ivlnNrZ/9g=;
	b=VE4L7npFK9Se1egVC4WHqeV/um/6hdnjgA6pOP4pX48DurAQzN6TkBkDlew9QLbGwwTNH2
	9BlmREeKGbmcDVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42493138E9;
	Wed, 22 Mar 2023 12:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4RHyD9H2GmR9YQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 12:38:41 +0000
Message-ID: <8e680863-97c1-8f0b-306c-e4c0f31a5344@suse.de>
Date: Wed, 22 Mar 2023 13:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-19-hare@suse.de>
 <c7d0546b-0844-b1aa-7e35-0b304ebc59e9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c7d0546b-0844-b1aa-7e35-0b304ebc59e9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_053845_889913_3C943636 
X-CRM114-Status: GOOD (  23.62  )
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

On 3/22/23 13:24, Sagi Grimberg wrote:
> 
> 
> On 3/21/23 14:43, Hannes Reinecke wrote:
>> Incoming connection might be either 'normal' NVMe-TCP connections
>> starting with icreq or TLS handshakes. To ensure that 'normal'
>> connections can still be handled we need to peek the first packet
>> and only start TLS handshake if it's not an icreq.
> 
> I think that for nvmet, we will want to strictly enforce tsas.sectype.
> What are we gaining from allowing this?
> 
> And if you insist that we must, then this needs to be an explicit
> setting to a permissive mode.
> 
We can't. Strict sectype mode does not work for servers as it would 
disallow discovery connections.
(Especially here as we don't support unique discovery subsystems.)
(Maybe it's time to revisit that ...)

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/tcp.c | 60 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 58 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index a69647fb2c81..a328a303c2be 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1105,6 +1105,61 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>>       return false;
>>   }
>> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
>> +{
>> +    struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
>> +    int len;
>> +    struct kvec iov = {
>> +        .iov_base = (u8 *)&queue->pdu + queue->offset,
>> +        .iov_len = sizeof(struct nvme_tcp_hdr),
>> +    };
>> +    char cbuf[CMSG_LEN(sizeof(char))] = {};
>> +    unsigned char ctype;
>> +    struct cmsghdr *cmsg;
>> +    struct msghdr msg = {
>> +        .msg_control = cbuf,
>> +        .msg_controllen = sizeof(cbuf),
>> +        .msg_flags = MSG_PEEK,
>> +    };
>> +
>> +    len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>> +            iov.iov_len, msg.msg_flags);
>> +    if (unlikely(len < 0)) {
>> +        pr_debug("queue %d peek error %d\n",
>> +             queue->idx, len);
>> +        return len;
>> +    }
>> +
>> +    cmsg = (struct cmsghdr *)cbuf;
>> +    if (CMSG_OK(&msg, cmsg) &&
>> +        cmsg->cmsg_level == SOL_TLS &&
>> +        cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
>> +        ctype = *((unsigned char *)CMSG_DATA(cmsg));
>> +        if (ctype != TLS_RECORD_TYPE_DATA) {
>> +            pr_err("queue %d unhandled TLS record %d\n",
>> +                queue->idx, ctype);
>> +            return -ENOTCONN;
>> +        }
>> +    }
>> +
>> +    if (len < sizeof(struct nvme_tcp_hdr)) {
>> +        pr_debug("queue %d short read, %d bytes missing\n",
>> +             queue->idx, (int)iov.iov_len - len);
>> +        return -EAGAIN;
>> +    }
>> +    pr_debug("queue %d hdr type %d hlen %d plen %d size %d\n",
>> +         queue->idx, hdr->type, hdr->hlen, hdr->plen,
>> +         (int)sizeof(struct nvme_tcp_icreq_pdu));
>> +    if (hdr->type == nvme_tcp_icreq &&
>> +        hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
>> +        hdr->plen == sizeof(struct nvme_tcp_icreq_pdu)) {
>> +        pr_debug("queue %d icreq detected\n",
>> +             queue->idx);
>> +        return len;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
>> @@ -1879,8 +1934,9 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>>           nvmet_tcp_save_tls_callbacks(queue);
>> -        if (!nvmet_tcp_tls_handshake(queue))
>> -            return;
>> +        if (!nvmet_tcp_try_peek_pdu(queue))
> 
> Who guarantees that a payload already exist? Where is the peek resumes
> when a payload already exist?
> 
We do wait for the first payload to arrive (MSG_DONTWAIT) isn't set, so 
we will be receiving something.
And if we haven't received a payload we're bailing out anyway, no?

Cheers,

Hannes


