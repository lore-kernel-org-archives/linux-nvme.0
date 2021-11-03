Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 09:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F0D60E78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 09:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6F0D60E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+B3s3lEFflMQ3YHrgm48jGXWsy9ikhgF3pnVREcU1o=; b=AN35oQa95qvB4g/cohmueA2fPC
	DgJYLuk4pa54QF0+27FsUwD4oNYq5GaFucEZUMsrDYqE6rbyPwJTrW8tWlAZtHhcEI3REr6LNZOP2
	luDPBn40JdVXw0WM7l5fg0wSHPvS8ARxEUS3hf41sPdAHI0lFJfJjFuZmYrFsEoJfume/Fg/QyTgq
	ebru42o+UPWTwf1WshOLldB4SBa7nmpfV90izCyjmZCYyRK7dcT2hBoOLAoF7ErIrN36tzZwi6HTX
	FZ+d9JpIeGlkYlqVYPG2WeoOcHX9rlSzwiVCLaNSf0ydekUzX8OHYs+4UiFemJA+1ehhgfa8/FQNp
	m1JfXltA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miCUr-004i6h-DU; Wed, 03 Nov 2021 09:23:53 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miCUn-004i6G-Vu
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 09:23:51 +0000
Received: by mail-ed1-f42.google.com with SMTP id g10so6894245edj.1
 for <linux-nvme@lists.infradead.org>; Wed, 03 Nov 2021 02:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I+B3s3lEFflMQ3YHrgm48jGXWsy9ikhgF3pnVREcU1o=;
 b=yeHAIgiWl4ymT/4KKfR7YsUW3ioxAxXCFexgJ4za9fyGC6kbFyVku7JjnOTTprCHmX
 Jugm2ZYRpYmquc5ZM6eD5SeaOYj5qVYpKiM0u9nSrJaVtsUmCEJYEQ86ePBDxluHd9Jz
 4Xz04CEkoFrceClChHQhriSySjRA0qkoq6/m66MmwT4CZS+AG1htUjc0YWgA6bVZGTjW
 sGO9DqB1tPZjYzA6AtU8FnbGiyGLVfgiuU03fRP3QVMZ1ldUxiCIWCkYG4SYBw8vkI8y
 yf2UHUTk2iBtpSHZq8k0SXfOclIQGrvcb5rRcqurM+CdBSK46jq93eef6nedu9Erbefo
 ABbg==
X-Gm-Message-State: AOAM532CYuJolcbsF17nJvP306juORfwJe25BM7pxGYBH92ju5RhBrPZ
 UdmViw7rdihrfs1MO4/LRUI=
X-Google-Smtp-Source: ABdhPJwvfGIDgsECLZfBFliQpP7ydLgCwQGD3darfP07bRHo2HBQmaNEpdEiYg/RHzEDdcdPpPZpAA==
X-Received: by 2002:aa7:c656:: with SMTP id z22mr49101158edr.251.1635931427758; 
 Wed, 03 Nov 2021 02:23:47 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id he17sm811314ejc.58.2021.11.03.02.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Nov 2021 02:23:47 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
References: <20211103081817.94820-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
Date: Wed, 3 Nov 2021 11:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103081817.94820-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_022350_117372_914D81FC 
X-CRM114-Status: GOOD (  18.55  )
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


> Release the page frag cache when tearing down the io queues
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 07156ea9d1a8..999417626b15 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1229,6 +1229,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>   
>   static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   {
> +	struct page *page;
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>   
> @@ -1238,6 +1239,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvme_tcp_free_crypto(queue);
>   
> +	if (queue->pf_cache.va) {
> +		page = virt_to_head_page(queue->pf_cache.va);
> +		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> +		queue->pf_cache.va = NULL;
> +	}

Thanks Maurizio,

Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
bit.

