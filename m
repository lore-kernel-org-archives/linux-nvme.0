Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81011C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhatZJ5AiKUwDQB9EmTK177z54C6nmao2T7uPHIAGJQ=; b=afPoDDogMv0NPwzHXLCmIX0HIv
	2bPtkbsqahI3R79nDBIdMtbtsm6Nw3MWycZJQ3cVrWZnrmNd52DUj+DazJKR8PpJwPznwTXdyxmuX
	/8NEtPKYNjNyj+L23QbIOgXauJMJDD0jI0Uerf4LcGgCaxjLM4veMnE/mNgdpycVUwUx3T/eANF6C
	UuXtSAzBj11mwBPlv8lz0fC9D6Zw1k7KMyVUqotRfS0ji2niUOmGc0ByXkwy2U61AAX1fvpZLFzQ2
	FWC0897fg3YQHRxUmEf2YnMYDpbx6b+joS8JB0X/RnUarW+tICniPD++na6KjGobJjeoGeQm1sDAZ
	ddoNZOPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKep-0000000Fy7y-3jlf;
	Thu, 18 Jul 2024 06:30:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKek-0000000Fy6q-3Ayf
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 06:30:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4907621C29;
	Thu, 18 Jul 2024 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721284221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhatZJ5AiKUwDQB9EmTK177z54C6nmao2T7uPHIAGJQ=;
	b=p7ttgIgeUaeQmRu/RmhaoFor+VpKociO5VrhVwHIBBhqwUTUwWmyh/cvp10QRkOuKcXyFM
	R6W8DRe4KV5Lf3JOQ8Mi7X5on7U9i0l6RXBfcwlKHTD15FoxsXXocB4l4of60JRXaOQv9f
	faMK2Z3Bh0zZ4UFObhQaZ2h/nZ28yiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721284221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhatZJ5AiKUwDQB9EmTK177z54C6nmao2T7uPHIAGJQ=;
	b=k9545EQpLb1cWKJKLhRDpDU0I2IEgr54Cd9vGogw4LB1RoKm4p9FaMxT5ii+YUIAnUvKbZ
	hjhEct1prFWufICg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721284221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhatZJ5AiKUwDQB9EmTK177z54C6nmao2T7uPHIAGJQ=;
	b=p7ttgIgeUaeQmRu/RmhaoFor+VpKociO5VrhVwHIBBhqwUTUwWmyh/cvp10QRkOuKcXyFM
	R6W8DRe4KV5Lf3JOQ8Mi7X5on7U9i0l6RXBfcwlKHTD15FoxsXXocB4l4of60JRXaOQv9f
	faMK2Z3Bh0zZ4UFObhQaZ2h/nZ28yiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721284221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhatZJ5AiKUwDQB9EmTK177z54C6nmao2T7uPHIAGJQ=;
	b=k9545EQpLb1cWKJKLhRDpDU0I2IEgr54Cd9vGogw4LB1RoKm4p9FaMxT5ii+YUIAnUvKbZ
	hjhEct1prFWufICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13329136F7;
	Thu, 18 Jul 2024 06:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TIVHAn22mGbTfgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 06:30:21 +0000
Message-ID: <da9566cc-8e99-43be-9ab9-a8c36a5beda2@suse.de>
Date: Thu, 18 Jul 2024 08:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvme-tcp: switch TX deadline to microseconds and make
 it configurable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-2-hare@kernel.org>
 <f73ab2c4-e273-4da8-9a6e-462b3d2b8ac9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f73ab2c4-e273-4da8-9a6e-462b3d2b8ac9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_233022_976551_BADD8B04 
X-CRM114-Status: GOOD (  19.07  )
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

On 7/17/24 23:03, Sagi Grimberg wrote:
> 
> 
> On 16/07/2024 10:36, Hannes Reinecke wrote:
>> The current TX deadline for the workqueue is pretty much arbitrary,
>> and jiffies is not the best choice for sub-microseconds granularity.
>> So make the deadline configurable via a config option and switch to
>> ktime instead of jiffies.
> 
> I thought we agreed on bytes based limits. Did you try to look how does
> that behave?
> 
I tried, but this is not the objective of this patch.

Main reason for this patch was that we are trying to measure
sub-jiffy granularity. When running with HZ=100 (as I did)
you only have a granularity of 10 milliseconds per jiffy, and
the call 'msecs_to_jiffies(1)' is getting ever so questionable.

So while you can have the jiffy displayed in microseconds,
you cannot _measure_ a value below 10 milliseconds.
So all calculation which you try will be inaccurate, which
is quite harmful when you try to do an analysis based on
those numbers.
So switching to ktime gives a better precision and with
that a more reliable data for analysing latency.

>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0873b3949355..3cf9a9abb0e0 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -44,6 +44,10 @@ static bool wq_unbound;
>>   module_param(wq_unbound, bool, 0644);
>>   MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO 
>> context (default false)");
>> +static int deadline = 1000;
>> +module_param(deadline, int, 0644);
>> +MODULE_PARM_DESC(deadline, "RX/TX deadline in microseconds (default: 
>> 1000)");
>> +
>>   /*
>>    * TLS handshake timeout
>>    */
>> @@ -1278,7 +1282,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>   {
>>       struct nvme_tcp_queue *queue =
>>           container_of(w, struct nvme_tcp_queue, io_work);
>> -    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>> +    u64 start = ktime_to_us(ktime_get());
>> +    u64 tx_deadline = start + deadline;
>>       do {
>>           bool pending = false;
>> @@ -1302,7 +1307,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>           if (!pending || !queue->rd_enabled)
>>               return;
>> -    } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>> +    } while (ktime_to_us(ktime_get()) < tx_deadline); /* quota is 
>> exhausted */
>>       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>   }
> 
> The rename to tx_deadline does not make sense in the context of this patch.

Ok, will be renaming it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


