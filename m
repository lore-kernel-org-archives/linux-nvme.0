Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE895C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3T0Ds3+gJeCWCdUWPMSk1WMpwc6o5xTmmNwTPYHSZjI=; b=IqP0Xoc2ImRjFFfYLXApxkCGi3
	PJpkE5AOVRKNeCAiHyzl2Se0JxJfYqGTCBUxqJf0sIc5YvfLYPUSmpgM9yz9tvfrOQUrZQs4T5lOM
	FZSK8NTHy+w8ZIECs6Qs3VLz7wlv/vtJinyzYZwjdeN1I2AOtwNavSzKIzlsRiqlQtZkUlKO7IyeY
	3IHZbI/TPtzRSi1sc9XfAMEnl7lljMNrzb7X7LeHDyMHyxd98iD4Aw5J4R+DBqpbjnJv6CzpAsecd
	cYvuFg5rDp56BkEXD7qPtyI5O2k7Y9T9dAFwLsPj+je09VVtch2XCYsXIDHFCtKLwHcCqCWh+IgeO
	vhN38UiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexFe-00Fs1q-1A;
	Wed, 22 Mar 2023 12:07:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexFb-00Fs1A-2r
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:07:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF5120D4F;
	Wed, 22 Mar 2023 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679486850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3T0Ds3+gJeCWCdUWPMSk1WMpwc6o5xTmmNwTPYHSZjI=;
	b=AsdGdWeaJIZjVqIHhlOqOA3d3W2wFyV/kcmX+C0CpAzvqVOYV0+7KglNCAL4fT8Hnuxp6r
	z5dwfig/B9khuxrzExpfIDkUsF2yu5eoBiFM3iO2srHH545f8GEk33LAjYhGcGeL7AWUKC
	BEiozA1VgqWHPT4sGQDIuitRKoJjmmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679486850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3T0Ds3+gJeCWCdUWPMSk1WMpwc6o5xTmmNwTPYHSZjI=;
	b=9jj8xXz8cmsmJQWtq2dR4Z47WsConWvoaOfkuJ3+ZTeXQZhP7R/YE9lfgVI5vtb0w6AAgA
	ZGKJSvcvIUo5kSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57E8A13416;
	Wed, 22 Mar 2023 12:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dD4VFYLvGmRSTgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 12:07:30 +0000
Message-ID: <7d9817f0-da10-15e7-dcfb-038f7b3c0972@suse.de>
Date: Wed, 22 Mar 2023 13:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/18] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-14-hare@suse.de>
 <8b037b12-86a6-f610-7b56-6d3201b30a25@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8b037b12-86a6-f610-7b56-6d3201b30a25@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_050732_068220_A5A26C00 
X-CRM114-Status: GOOD (  32.09  )
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

On 3/22/23 12:46, Sagi Grimberg wrote:
> 
> 
> On 3/21/23 14:43, Hannes Reinecke wrote:
>> When using the TLS upcall we need to allocate a socket file such
>> that the userspace daemon is able to use the socket.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/tcp.c | 49 ++++++++++++++++++++++++++++-----------
>>   1 file changed, 36 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 66e8f9fd0ca7..5c43767c5ecd 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -96,12 +96,14 @@ struct nvmet_tcp_cmd {
>>   enum nvmet_tcp_queue_state {
>>       NVMET_TCP_Q_CONNECTING,
>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>       NVMET_TCP_Q_LIVE,
>>       NVMET_TCP_Q_DISCONNECTING,
>>   };
>>   struct nvmet_tcp_queue {
>>       struct socket        *sock;
>> +    struct file        *sock_file;
>>       struct nvmet_tcp_port    *port;
>>       struct work_struct    io_work;
>>       struct nvmet_cq        nvme_cq;
>> @@ -1455,12 +1457,19 @@ static void 
>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>       nvmet_sq_destroy(&queue->nvme_sq);
>>       cancel_work_sync(&queue->io_work);
>>       nvmet_tcp_free_cmd_data_in_buffers(queue);
>> -    sock_release(queue->sock);
>> +    if (queue->sock_file) {
>> +        fput(queue->sock_file);
> 
> I don't remember, but does the fput call sock_release
> on the final put? I'd move this into a helper nvmet_tcp_close_sock()
> or something.
> 
Yes, it does. (Took me some weeks to figure that out...)
But yeah, we can do a helper.

>> +        queue->sock_file = NULL;
>> +        queue->sock = NULL;
> 
> I always get a bit weary when I see that deallocations are setting
> pointers to NULL.
> 
And curiously that's a pattern I commonly use to track invalid accesses.
But that's just personal preference.

>> +    } else {
>> +        WARN_ON(!queue->sock->ops);
>> +        sock_release(queue->sock);
>> +        queue->sock = NULL;
>> +    }
>>       nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)
>>           nvmet_tcp_free_crypto(queue);
>>       ida_free(&nvmet_tcp_queue_ida, queue->idx);
>> -
>>       page = virt_to_head_page(queue->pf_cache.va);
>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>>       kfree(queue);
>> @@ -1583,7 +1592,7 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>           struct socket *newsock)
> 
> Why is this becoming a void function? This absolutely can fail.
> 
Oh, it can fail.
But it's being called as a last call in a 'void' function, so there is 
nothing the caller could do with the return value.
And the caller actually just uses the return value to print out a
logging message, so I moved that call into nvmet_tcp_alloc_queue()
and made it a 'void' function.

>>   {
>>       struct nvmet_tcp_queue *queue;
>> @@ -1591,7 +1600,7 @@ static int nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>>       if (!queue)
>> -        return -ENOMEM;
>> +        return;
>>       INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>>       INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> @@ -1599,15 +1608,28 @@ static int nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       queue->port = port;
>>       queue->nr_cmds = 0;
>>       spin_lock_init(&queue->state_lock);
>> -    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
>> +        NVMF_TCP_SECTYPE_TLS13)
>> +        queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
>> +    else
>> +        queue->state = NVMET_TCP_Q_CONNECTING;
>>       INIT_LIST_HEAD(&queue->free_list);
>>       init_llist_head(&queue->resp_list);
>>       INIT_LIST_HEAD(&queue->resp_send_list);
>> +    if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, 
>> NULL);
>> +        if (IS_ERR(queue->sock_file)) {
>> +            ret = PTR_ERR(queue->sock_file);
>> +            queue->sock_file = NULL;
>> +            goto out_free_queue;
>> +        }
>> +    }
>> +
>>       queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
>>       if (queue->idx < 0) {
>>           ret = queue->idx;
>> -        goto out_free_queue;
>> +        goto out_sock;
>>       }
>>       ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
>> @@ -1628,7 +1650,7 @@ static int nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       if (ret)
>>           goto out_destroy_sq;
>> -    return 0;
>> +    return;
>>   out_destroy_sq:
>>       mutex_lock(&nvmet_tcp_queue_mutex);
>>       list_del_init(&queue->queue_list);
>> @@ -1638,9 +1660,14 @@ static int nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       nvmet_tcp_free_cmd(&queue->connect);
>>   out_ida_remove:
>>       ida_free(&nvmet_tcp_queue_ida, queue->idx);
>> +out_sock:
>> +    if (queue->sock_file)
>> +        fput(queue->sock_file);
>> +    else
>> +        sock_release(queue->sock);
>>   out_free_queue:
>>       kfree(queue);
>> -    return ret;
>> +    pr_err("failed to allocate queue");
> 
> Can we design this better?
> It looks backwards that this routine deallocates an argument
> coming from the call-site.
> 
> I know that this is similar to what happens with kernel_accept
> to some extent. But would prefer to avoid this pattern if possible.
> 
Sure; I just followed precedent here.
But no prob to change it.

Cheers,

Hannes


