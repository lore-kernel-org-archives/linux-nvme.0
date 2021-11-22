Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C5DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0B83Z/pMJS/3Kw2AnU6hlZi7ua50hKFS6zMaB5ImF8=; b=DPUZD9sn/WDZKR2s6ekofsEaQI
	TVSCuZIGvmDn8CVvExn243D8Lsb8GEw90SSiirbWPeb0hbOKK+9L9CUyBxxsr1Q5TMl5rXPEENgbD
	7ZUN06djo4ZlVKu6/johqewvrtcsg12QXhHRhcmEFCb8fJl2D/uTE2se4xPoAKEF9YRdLIsHGH2V2
	vBXPh/lfpG+y/t1vZnaFso8MJ5fxJLyLyfzfbrK1nYWTSl8hzYCqnOvgFcgQNqvAZYrpugkfvRjE0
	wObOTQcczLevyGSd8kbM5kGMs65s+KSpUPFk5/s6bYcfHHzsNz86PQBW4VFve16/ZLhS6tgzip+UU
	+ilGoX2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Dn-00FBo3-Tp; Mon, 22 Nov 2021 07:58:40 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp49F-00FAIZ-Bo
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:53:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id u18so30999124wrg.5
 for <linux-nvme@lists.infradead.org>; Sun, 21 Nov 2021 23:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q0B83Z/pMJS/3Kw2AnU6hlZi7ua50hKFS6zMaB5ImF8=;
 b=WWYXWjVicSOKX5myT57cnovMrPqbBw/09XpGwJ8MGjUmJYCZ6tvPaaFH1Ow8juJ7yA
 Xmq/9M71Oxm9ic+ERNo7wZ3z4Gs9Ru3X2J4k8eM5Bp4Tf/vkgTUObsnh6n+8S7YvnzXU
 fu0ePWcA0qoYi80Opx14s1M2UWY0E4JE15X8d+uxPziYPu+793SiHCqJTRexF3x/i1fc
 w8or70zO4bcVsssOHLajQaxb73yb8y5VN7DibRGxekMTRIurp5LwEKWAIXClTtoKZsq5
 ssLTJuW3V9Cvgf0orNisS60V66MhkjAVlO13KojQZ17b7XspHAjeeXepMdjUg5rE/VKX
 2oPw==
X-Gm-Message-State: AOAM53241bqrpmbxWw7+9A78Wm9m2blW2PT12C3DapsdYttPJfpgPADr
 J+mIGkWrJrQZtLp81D0lgFM=
X-Google-Smtp-Source: ABdhPJyfYMEviMX1WCFI8FxFujbqZf1VpqWmBEpT7IINxm5fp+vIrw3VQnXe1IteGJjr8dDNyHfOow==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr36635909wrd.10.1637567635391; 
 Sun, 21 Nov 2021 23:53:55 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p13sm20816547wmi.0.2021.11.21.23.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 23:53:55 -0800 (PST)
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me>
Date: Mon, 22 Nov 2021 09:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119021849.2259254-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235357_458590_B0FDF1E4 
X-CRM114-Status: GOOD (  14.12  )
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


> -static inline void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> +static inline void queue_unlock(struct request_queue *q, bool blocking,
> +		int srcu_idx)
> +	__releases(q->srcu)
>   {
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> +	if (!blocking)
>   		rcu_read_unlock();
>   	else
> -		srcu_read_unlock(hctx->queue->srcu, srcu_idx);
> +		srcu_read_unlock(q->srcu, srcu_idx);

Maybe instead of passing blocking bool just look at srcu_idx?

	if (srcu_idx < 0)
		rcu_read_unlock();
	else
		srcu_read_unlock(q->srcu, srcu_idx);

Or look if the queue has srcu allocated?

	if (!q->srcu)
		rcu_read_unlock();
	else
		srcu_read_unlock(q->srcu, srcu_idx);

>   }
>   
> -static inline void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> +static inline void queue_lock(struct request_queue *q, bool blocking,
> +		int *srcu_idx)
>   	__acquires(hctx->srcu)
>   {
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> +	if (!blocking) {
>   		/* shut up gcc false positive */
>   		*srcu_idx = 0;
>   		rcu_read_lock();
>   	} else
> -		*srcu_idx = srcu_read_lock(hctx->queue->srcu);
> +		*srcu_idx = srcu_read_lock(q->srcu);

Same here:
	
	if (!q->srcu)
		rcu_read_lock();
	else
		srcu_idx = srcu_read_lock(q->srcu);

