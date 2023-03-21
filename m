Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FEFC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3+wXiYbGLMm4/5YluTpEyzXUAm0yqdviLcOVyN7+SI=; b=4E6ZFFXyFFd2GrtVewzt1fSLXv
	JVLwDkcACMw5bAJmxFn4typwbDX8vL6TJfH5Vky7Jz89mWWMpVEq3gZmi24iDg9nVX7pp3VILi2GQ
	8T5BzOyYnYE3nVh5tBTNJGEBFH2D/2adsxgnbt0Z4TK7G5OUctw6vadpB8eYYBAHthn5/mHFjLeHQ
	lMFh1Vjlf9mfseoKlxvn0ZF4WcaocEG25JDtKjabMmv8EPsuocNbU3Nm1hnXQFd4SvloW9dYSilaI
	Rzxacpff235i96WWKDflixgdym7WWzmmk7IG5er9dBrTBtUqJLiSS/N8RcjSaq4xa758hgIS5m32U
	T6/grFVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecfz-00Cf11-26;
	Tue, 21 Mar 2023 14:09:23 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecfr-00Ceyd-1c
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 14:09:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 140F421F4B;
	Tue, 21 Mar 2023 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679407747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3+wXiYbGLMm4/5YluTpEyzXUAm0yqdviLcOVyN7+SI=;
	b=KPmsZ9fln7YTkWql9m8emc/FAEsiITKnpSPnkybVd3qjia4tsx2l6CrFVitF06a9YcXIPf
	3mlB8fvoaLZOxxJ7fpJWEwYqwRTCb/CQI+e8NXnrK0wJIShLsSuWM2jsz1623ChQmcgL4h
	hg+myGEJVoqfIrxMgrPNQbANSTfw/TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679407747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3+wXiYbGLMm4/5YluTpEyzXUAm0yqdviLcOVyN7+SI=;
	b=OTOYGGS0du6jXlCagQEfEvas1hnv8N+Df1TY57cvNqAt/4VsTkMhXlJDlXqbXidbrSfhFs
	tygc1+XO2G+RgYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6CD613451;
	Tue, 21 Mar 2023 14:09:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9aFVN4K6GWQIKAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Mar 2023 14:09:06 +0000
Message-ID: <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de>
Date: Tue, 21 Mar 2023 15:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
In-Reply-To: <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_070920_765760_9E4D2589 
X-CRM114-Status: GOOD (  25.80  )
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

On 3/21/23 14:44, Sagi Grimberg wrote:
> 
>> Call the original data_ready() callback in nvme_tcp_data_ready()
>> to avoid a receive stall.
> 
> Can you please improve the description to include what is the stall?
> For example, does the stall exist today? If it is, I would like to
> separate such patches from this set and include them asap.
> 
That is actually particular to the TLS implementation, as it uses the 
'data_ready' callback to produce the data which can be read by eg recvmsg().

Without this call there's no data to peruse for recvmsg().

But I'm not _that_ deep into networking details to know whether this is 
TLS specific or an issue with any data_ready callback.
I assume the latter, but then again, who knows.

Hence the slightly vague description.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0e14b1b90855..0512eb289dcf 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -936,12 +936,14 @@ static void nvme_tcp_data_ready(struct sock *sk)
>>       trace_sk_data_ready(sk);
>> -    read_lock_bh(&sk->sk_callback_lock);
>> -    queue = sk->sk_user_data;
>> +    rcu_read_lock_bh();
> 
> Now I understand your comment from a previous patch.
> Can you explain why is this convention needed?
> 
> I would prefer to have it as a separate patch with an
> explanation to why it is needed.
> 
This is the slightly odd socket callback handling.
Any driver is free to set the socket callbacks, but it has to be aware 
that it might not be the only one in the stack doing so.
So one has to be prepared that the callbacks are set already, so we 
should be calling them prior to our callback.

>> +    queue = rcu_dereference_sk_user_data(sk);
>> +    if (queue->data_ready)
>> +        queue->data_ready(sk);
> 
> Is the tls data_ready call sync or async? just for general knowledge?
> 
> 
Sync, I guess. Otherwise we wouldn't be needing the lock ...

>>       if (likely(queue && queue->rd_enabled) &&
>>           !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> -    read_unlock_bh(&sk->sk_callback_lock);
>> +    rcu_read_unlock_bh();
>>   }
>>   static void nvme_tcp_write_space(struct sock *sk)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


