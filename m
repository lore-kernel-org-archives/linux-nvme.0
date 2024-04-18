Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AFCC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nf7RApMY0PXWK9vhuOaCED30ltnullrbRtuEmwbg/FM=; b=f0bc/fytF6W+4qMA0SjFiFvwp8
	4KwP3dx1f14qWABDg3uL4PD+HvzRq3LIJ4Jko7jWkolrqIl5lf0oG0hzqnOWpFX5tP3UaOMvUPy97
	5Mc+bByPs4Isz2Zu8atVQSZpEZAqgVlYbna2VIhEZHX6SKyq+OEHufK8oe9oZ4MMaQd+uBfRjsLXW
	cNjfmFpvQrruYny1ybASZzl7Bmt+8CSwzPZW3qAXg2mfbF1cEnaAy3ULNlgkthc2ZuqVPT/NCQ9TP
	J1b6Qn1VYLUu6ipXJI3t1qWCQWMRr6LmsEaRbCSK7iiy2DVSuZsWmrEQefEa9Wwd/W5Wl3gxg9WlC
	pd1nt3zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxNiV-00000001Xiw-1vrj;
	Thu, 18 Apr 2024 09:06:03 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxNiQ-00000001XgS-1zIN
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:06:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D403F5C769;
	Thu, 18 Apr 2024 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713431155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7RApMY0PXWK9vhuOaCED30ltnullrbRtuEmwbg/FM=;
	b=Q3zpntQgGUDmzzXaW8uvjL4fW9NRh6odndy33XsEehDTlex3OMDyLVKfI7K3DRkXmBq1xL
	cXfrrUpEJbTYigQfcYSvZYbx7ascgXdb0IVU0nueKvGJ6uBerjIQl/CF1IBRmz1ZiOjYpB
	xFi2w7X6SnxETtjwEKA4+x2tD6RsPwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713431155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7RApMY0PXWK9vhuOaCED30ltnullrbRtuEmwbg/FM=;
	b=SrMGgWYWC3txA23oGJUMiILGiYEc1fj+68R4c3n1HvvZ/YD6hePr2MMPqNDf6j/MhPh6AZ
	ixwTKmym8AuWP6Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sEx4J2QM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/FlL1oZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713431154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7RApMY0PXWK9vhuOaCED30ltnullrbRtuEmwbg/FM=;
	b=sEx4J2QM1Gjz/dEjU3qMvDVIN7S9pQzhwyByLjjr+hjT9P3qPKQnWTl68EwJo1TUSZJdZR
	u5lzj9TaB2YJTcYiXfQqMFUvcQUrRpompwoUsvDEuNEhQiXICiNpvdXfwEvo7/h4Xrf8S2
	fDBNdIEsXqJcWILpJiz7FKohLcS+5SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713431154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7RApMY0PXWK9vhuOaCED30ltnullrbRtuEmwbg/FM=;
	b=/FlL1oZg1xcjSen2bybHHn1HNVducJ7YW6eCmCqG5fM2OHZRCwtd+dK2i0538RrSs8B7fP
	Kk6Wz0HNvf0Ho3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B73401384C;
	Thu, 18 Apr 2024 09:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S1+ZK3LiIGaJMAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 09:05:54 +0000
Message-ID: <0c9c08ba-e03d-4d9d-87ab-fef04ef10a65@suse.de>
Date: Thu, 18 Apr 2024 11:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240417153923.100342-1-hare@kernel.org>
 <8a52ce1e-3cdb-468a-87a5-3cf8a118cad6@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8a52ce1e-3cdb-468a-87a5-3cf8a118cad6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D403F5C769
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_020558_697179_5F997504 
X-CRM114-Status: GOOD (  18.78  )
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

On 4/18/24 10:01, Sagi Grimberg wrote:
> 
> 
> On 17/04/2024 18:39, Hannes Reinecke wrote:
>> TLS requires a strict pdu pacing via MSG_EOR to signal the end
>> of a record and subsequent encryption. If we do not set MSG_EOR
>> at the end of a sequence the record won't be closed, encryption
>> doesn't start, and we end up with a send stall as the message
>> will never be passed on to the TCP layer.
>> So do not check for the queue status when figuring out whether
>> MSG_MORE should be set but rather make it dependent on the current
>> command only.
> 
> How about making nvme_tcp_queue_more take into account nvme_tcp_tls()?
> so we preserve the behavior without tls.
> 
> i.e. something like:
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0ba62fc647b3..bbffc67f8a1e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -360,12 +360,18 @@ static inline void nvme_tcp_send_all(struct 
> nvme_tcp_queue *queue)
>          } while (ret > 0);
>   }
> 
> -static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> +static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue 
> *queue)
>   {
>          return !list_empty(&queue->send_list) ||
>                  !llist_empty(&queue->req_list);
>   }
> 
> +static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> +{
> +       return !nvme_tcp_tls(queue->ctrl) &&
> +               nvme_tcp_queue_has_pending(queue);
> +}
> +
>   static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>                  bool sync, bool last)
>   {
> @@ -386,7 +392,7 @@ static inline void nvme_tcp_queue_request(struct 
> nvme_tcp_request *req,
>                  mutex_unlock(&queue->send_mutex);
>          }
> 
> -       if (last && nvme_tcp_queue_more(queue))
> +       if (last && nvme_tcp_queue_has_pending(queue))
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, 
> &queue->io_work);
>   }
> -- 
> 
Would work as well, I guess.
I'll give it a go.

Cheers,

Hannes


