Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB5EC3ABB2
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 06:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0wzzmM/TLimpMJSyGLnu34q+1JGriCMT42u5lEc8qc=; b=f07bQbrJgohKH5yvsnA9V+Wglf
	I1r0jPInpVa/2HDGyt2gxE3eiYiIGL39pWKsP4YxVbZIu3Dwsb8XxztIav2b7Gar9o1GISgCwH5tw
	q3DfHpEjjAy5hVjdFWoVsTkw4FK45gb4RdUahbuldM/IfNAHxYQodqRwoQsjIHL43foPy1O/7Nhuq
	Ib+7ZX4gsao/9cX56BhUakL+xJErubh8DLb5GrXJoQcjZOzKDZG2wur0JnpDLVlc6hNtgvx6+iEH5
	iC0KgB9mq2kyHNCdi6AzCXn61kwS53BXl6hSrY36CcJWOOw/X8UaIJkT5OFHfn15MKkMSSeHAEoR2
	2HlpIOJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKtS9-0000000HNAm-3sps;
	Fri, 30 May 2025 06:42:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKtS6-0000000HN8j-35DL
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 06:42:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60CBA1F79F;
	Fri, 30 May 2025 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748587367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0wzzmM/TLimpMJSyGLnu34q+1JGriCMT42u5lEc8qc=;
	b=2DKFHGEWYvyTQ38ZzSZ9UTt5tYvkUO8FDkhJl4zFMmS9gg5eAwnc3QU5bS8AUkR9GkYoAa
	QRnMQU8Wk0x9tod3jJIVZoSLR8978xtdAEOJjV/aH3Cra7wsNS6Lc2eRYGCbJ+4IIfaHry
	rWQqeglIn10X0Z1PH2IVitsuNSAZiz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748587367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0wzzmM/TLimpMJSyGLnu34q+1JGriCMT42u5lEc8qc=;
	b=qsE30skwylhn1lgZK5KT6I2J8prNwLwXZjOgkFi0hSBr/4fVtKL6qzBlc70eHf938tgCSE
	LnG6rODfkpqPHdAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748587367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0wzzmM/TLimpMJSyGLnu34q+1JGriCMT42u5lEc8qc=;
	b=2DKFHGEWYvyTQ38ZzSZ9UTt5tYvkUO8FDkhJl4zFMmS9gg5eAwnc3QU5bS8AUkR9GkYoAa
	QRnMQU8Wk0x9tod3jJIVZoSLR8978xtdAEOJjV/aH3Cra7wsNS6Lc2eRYGCbJ+4IIfaHry
	rWQqeglIn10X0Z1PH2IVitsuNSAZiz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748587367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0wzzmM/TLimpMJSyGLnu34q+1JGriCMT42u5lEc8qc=;
	b=qsE30skwylhn1lgZK5KT6I2J8prNwLwXZjOgkFi0hSBr/4fVtKL6qzBlc70eHf938tgCSE
	LnG6rODfkpqPHdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2718313889;
	Fri, 30 May 2025 06:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 27CLB2dTOWiLQgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 30 May 2025 06:42:47 +0000
Message-ID: <918f6b70-cbdd-4ec4-ba0e-f696ceea1a4b@suse.de>
Date: Fri, 30 May 2025 08:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: do not queue io_work on a full socket
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kamaljit Singh <kamaljit.singh1@wdc.com>, linux-nvme@lists.infradead.org
References: <20250528064535.135653-1-hare@kernel.org>
 <20250528064535.135653-4-hare@kernel.org>
 <8aa2cf47-580d-49f5-8afd-7fba9451c9f5@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8aa2cf47-580d-49f5-8afd-7fba9451c9f5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_234250_924405_60AFCDF4 
X-CRM114-Status: GOOD (  26.22  )
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

On 5/29/25 14:38, Sagi Grimberg wrote:
> 
> 
> On 28/05/2025 9:45, Hannes Reinecke wrote:
>> There really is no point in scheduling io_work from ->queue_rq()
>> if the socket is full; we'll be notified by the ->write_space()
>> callback once space on the socket becomes available.
>> Consequently we also need to remove the check for 
>> 'sk_stream_is_writeable()'
>> in the ->write_space() callback as we need to schedule io_work
>> to receive packets even if the sending side is blocked.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0e178115dc04..e4dd1620dc28 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -411,6 +411,9 @@ static inline void nvme_tcp_queue_request(struct 
>> nvme_tcp_request *req,
>>       empty = llist_add(&req->lentry, &queue->req_list) &&
>>           list_empty(&queue->send_list) && !queue->request;
>> +    if (!sk_stream_is_writeable(queue->sock->sk))
>> +        empty = false;
> 
> This is wrong. the fact that the socket it not writeable does not mean 
> that the queue
> is not empty (meaning we have rqeuests that we have yet to write to the 
> socket).
> 
Admittedly I abuse 'empty' here; setting 'empty' to 'false' just avoids
the workqueue to be run. If 'sk_stream_is_writeable()' is false starting
the workqueue will just cause sendmsg() to return EAGAIN, and we'll be
notified via the 'write_space' callback anyway.

>> +
>>       /*
>>        * if we're the first on the send_list and we can try to send
>>        * directly, otherwise queue io_work. Also, only do that if we
>> @@ -422,7 +425,8 @@ static inline void nvme_tcp_queue_request(struct 
>> nvme_tcp_request *req,
>>           mutex_unlock(&queue->send_mutex);
>>       }
>> -    if (last && nvme_tcp_queue_has_pending(queue))
>> +    if (last && nvme_tcp_queue_has_pending(queue) &&
>> +        sk_stream_is_writeable(queue->sock->sk))
> 
> I think its fine, because either this or the callback will effectively 
> not queue the work as the work can only be queued once.
> 
>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>   }
>> @@ -1074,7 +1078,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (likely(queue && sk_stream_is_writeable(sk))) {
>> +    if (likely(queue)) {
>>           clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>       }
> 
> I'd keep only this change. Unless you are convinced that the other 
> stream checks are correct?

The gist of this patch was to move the checks for 
'sk_stream_is_writeable' into io_work to avoid it being queued
when the socket is blocked, as in these cases io_work will be
restarted via the callbacks.
Prime reason here was to avoid recvmsg() or sendmsg() return with EAGAIN
as this will increase latency during command processing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

