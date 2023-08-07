Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7720EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ks6LvIxEggRmM7ZUlxU/KKwpgcWnO2xojK+NqTVQkDI=; b=OtKV5JCih5LuTNZGLMh/R1bI1t
	j0pjd7gD/VhbdRahM4pm86s4qFwXWFeCidGKlDqy3IL1FXjYCSNBEvLiengwSgT4lrPG8njo5EehN
	AeEH/sZHYQ+WtjBpnKjX14Q+Grt478JIAi+xIkUL+onjvxMcnzXyxHWypZZ39C2WhQFAnQ1HikKoL
	InRYA7bFhG6eJ19g8bxL02LBlEnHT9tkXRzKi4DMT6lxcfjsrT8djPplfqcyGF0m1F8j9Xn294f3S
	MrlUsQvVD+boDNk5SyiapsSWgMNzxOoVnkqgyL+8AKMov2gMXq04h0mxmXUbAVEFJM5Z+tzzpZbCl
	g1RxQarA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvw1-00GUgF-2d;
	Mon, 07 Aug 2023 08:49:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvvy-00GUf2-0e
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:49:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08B621F460;
	Mon,  7 Aug 2023 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691398188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks6LvIxEggRmM7ZUlxU/KKwpgcWnO2xojK+NqTVQkDI=;
	b=j08QxPSQBKrBtuxjoXkCPn8iKH4vgD98PJQuMFzz8YjIbrK4u0meQBdGsVO9a9Vm0chCb0
	/pFq/z/T7GQcn437z899yc53v5TAef6K07MQ/1efrvXQowfLvXItzmPXgAR2DLcld+QGq2
	nmjolDB9pnYmDYzgKPm4vckhgdHGnt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691398188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks6LvIxEggRmM7ZUlxU/KKwpgcWnO2xojK+NqTVQkDI=;
	b=Uqb46Nae8XU8etb1v42yUNtxoSDFySKosYUU4GVyaI60Lq9VXlh8Y16f5hQ5yoqqYES7wd
	sKKA1Ntg6+Zf4eBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A51D313910;
	Mon,  7 Aug 2023 08:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NgTBJSuw0GRPDwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 07 Aug 2023 08:49:47 +0000
Message-ID: <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
Date: Mon, 7 Aug 2023 10:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_014950_382304_492E49F2 
X-CRM114-Status: GOOD (  16.34  )
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

On 8/7/23 10:27, Sagi Grimberg wrote:
> 
> 
> On 8/3/23 13:51, Hannes Reinecke wrote:
>> For the TLS upcall we need to allocate a socket file such
>> that the userspace daemon is able to use the socket.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 868aa4de2e4c..fdc351f591a4 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1493,12 +1493,12 @@ static void 
>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>       nvmet_sq_destroy(&queue->nvme_sq);
>>       cancel_work_sync(&queue->io_work);
>>       nvmet_tcp_free_cmd_data_in_buffers(queue);
>> -    sock_release(queue->sock);
>> +    /* ->sock will be released by fput() */
>> +    fput(queue->sock->file);
>>       nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)
>>           nvmet_tcp_free_crypto(queue);
>>       ida_free(&nvmet_tcp_queue_ida, queue->idx);
>> -
>>       page = virt_to_head_page(queue->pf_cache.va);
>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>>       kfree(queue);
>> @@ -1621,15 +1621,16 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>           struct socket *newsock)
> 
> Why does the function change from retcode to void in this patch?

Because the return code was never evaluated.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


