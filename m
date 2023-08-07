Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E040EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vF94QM5uO8rYpBlaM0z6Tup0+VSeNdQKzmXitXIPZT4=; b=CODfho+mg6NidvNAGvzz8dbVrl
	QNry8o9YNLfqKi8D7XZt/kIuu5ktj5Aki3WPp4ZYaav/aG4hFYHI1HsOBDciye4W8stgHMjjoC6lX
	U1uv222B194PPrmcK2K1Tvu9Qxyr17Krw9MQ+LfqAdpbd0L4/fN3P1KJprh7Ntg3KOAry4O1t/AOO
	RAaPfzSSLyiup55uNn+xLDZ6psFV7mH+MarAtXvcvtCQVyrisKP/Uj2AdL8PWaGB7jfKgiSdxCnt8
	JGxFgDuuEKRmKyP7RWYcrDfHZAkX3HJZE+e9SgjfPh+IqKsboyvyp9nUM+vZwDHlLSho4XrCF/wfR
	SUXfPNbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSva7-00GRmZ-2u;
	Mon, 07 Aug 2023 08:27:15 +0000
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSva5-00GRlX-1k
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:27:14 +0000
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99c4e426714so130549266b.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396830; x=1692001630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF94QM5uO8rYpBlaM0z6Tup0+VSeNdQKzmXitXIPZT4=;
        b=RmVH8wVTeOjLa9ZVXfdy9dJjBp+LVqI6B9hHqqhrTadkdBDe2cAJMNyYw+JLVsfpz/
         vIBFlLeAe+6GAjNcPkJI1f3bXPB46JFVxy+7qg7bBx68x3gZpTWO7+oQZp73nvBtk3aJ
         5OX0rJVHOpI7dHbmA2TV/+wBdux7u4A7lXBN0tRVYAGYq1sA3V9wgdcQoC41K96KENuL
         cYAzBcUJ/4qq2zqj/4Zomq0vLgqBqABpXeroFGG9PGxPpY3SnhMbfLSIYOB1mSw/g1Ba
         F6HM338W89rBwONG88PPDQ3H466tlvz+8qB9E9qDBVnP4s2L0KMjpFJlJOW9vqQQWpAx
         aDmA==
X-Gm-Message-State: ABy/qLY3BlcXkok0HIKN7Bispcvl05ETCYWWizgHTLlVCPPo2Vku8cOm
	hSxLfqJTku5RMTYj+rrodb0=
X-Google-Smtp-Source: APBJJlGVw6pOi3w4FQY5Jx9bnPiPEmyTPzpceIam0WroF3cRCZv8753GKQgBdqbJkJ0Jl10GZx13CQ==
X-Received: by 2002:a17:906:5349:b0:99b:d03e:76e8 with SMTP id j9-20020a170906534900b0099bd03e76e8mr19389013ejo.5.1691396829901;
        Mon, 07 Aug 2023 01:27:09 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b0099251a40184sm4897910eja.99.2023.08.07.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:27:09 -0700 (PDT)
Message-ID: <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
Date: Mon, 7 Aug 2023 11:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-13-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_012713_575492_0DBA6F5B 
X-CRM114-Status: GOOD (  17.82  )
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



On 8/3/23 13:51, Hannes Reinecke wrote:
> For the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 868aa4de2e4c..fdc351f591a4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1493,12 +1493,12 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
>   	nvmet_tcp_free_cmd_data_in_buffers(queue);
> -	sock_release(queue->sock);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock->file);
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
>   	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> -
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>   	kfree(queue);
> @@ -1621,15 +1621,16 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	return ret;
>   }
>   
> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   		struct socket *newsock)

Why does the function change from retcode to void in this patch?

