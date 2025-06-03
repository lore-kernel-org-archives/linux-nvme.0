Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A73C5AD49
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oKGTTBxG3TxSiwiwceZHKicVjT0Ofmz6J43duGzvDOk=; b=iPCgurqqY8EhND7j6uqb/IBIBS
	NiWjNzUw0s13aiRs8C6z2NLrohsgKfZbjTjeye9PaGVIi8kRv0lqlY/y7f1CT7RJ7NqTVCvf1SkDo
	IiIB/RLwkc+mUTJTeVb5aITFMtHW9iHCtHD7DoUPqqKjEAhOlKVM+ODYpsXUeV093fFcDIch5uQP6
	hvk7WHNHih4xDhdsdcb8o4/YgAsUPOSULFn1ySzONbX/VpQ7UWifhyHMmjuTYyOlOBrpgrRMLI7qV
	Aps3pvaDKLt44u8k9o0uwkPeDpPcmNni3I6ukXmoXqOUupk4NfPL7cWLmz7PMm4E+AWlvhGYORoFk
	5S1FlGpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMPLr-0000000AjT8-2wJi;
	Tue, 03 Jun 2025 10:58:39 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMPLp-0000000AjRy-2ce2
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 10:58:38 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso20571945e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jun 2025 03:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948315; x=1749553115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKGTTBxG3TxSiwiwceZHKicVjT0Ofmz6J43duGzvDOk=;
        b=lBw0zwSTEK1m5FnunVkteMCUPQbsPU82YlbdrthVIGDyc8MWAb5eaOUZ0ZH1MZTV+y
         eBonr6pRjZ6ST5en0RWlkRv2ukN0bYN6P4f8lZXN5QCZtFie4vNw7fUxNoc4czUm2Xb2
         e5PRRQZJz3fjfdDBisx2WE2Y3tpC5okTy2xKnstyrHQuzVwlVWYmf0FiZXiXFea6gCFo
         2SXgrOZueFN6xQfA8s/+efy2Hlq6HMZaazVvzr/wkTLpXzk2Zf+q+T9LQGX2y9zO9W6Z
         CC9/xKRfdT+AO8rQmjI4Bd/C1rCl6c3rj7fwbx74E0/ofy/fJZB7SnxbdCsRcPJSarlA
         Coew==
X-Forwarded-Encrypted: i=1; AJvYcCVpjA9RepGtkMuxYJBa+p6cH459lgIpD6ySDeKn0TrM0HIwUraGnfcwQmS0yS1hu9C09SIeU+GjQ1T+@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9H0noGIpnt6f0emWWRuqCSDOMrr4ili6MUUFERSQoCa8q8lRf
	yG/sV4/qNAFvVNCPJDvvS4anWuRei3mlySXTzNr0PDcKtviPICKeCdTBFN+XUw==
X-Gm-Gg: ASbGncufgYgvnWu2QPx/xf1LKOhHKWRuiWrmsna7x+cBa22M3S4Im8qeaIvDlk/G3mL
	ExgJPDL/ju262YMdpFa/dZVHlpATaFfJ2a6Du+I8tM8CNJm1+FTVFQeGh56Lek1dcV6MfRXm71G
	HpGEUee7XGvzdXsQXUtzzoEusXFF8o/C1AH+h1wnp55V4k/3vIUOUY1c6+zDkyEEReMMRA5nVVh
	IGozWil69D1/Zn82OLPiLDVZdoXfV0ngje4QElt1osbcViEp07+N/hrRA4mAgfWQVzda0CeW9Ss
	4UnVI39mJ5iqxmDT3zxO/fSwGlK/KdAa3Qv8o6XU6fa/U0PfNaShBJJk/4SFa6FbkAFhYaTEtJb
	15zVQT27861VwWWFAjg==
X-Google-Smtp-Source: AGHT+IG65hr01ZjWZz5JlH6sD7yyV82J5iljnnA+Az4cNDMtG1CPssfH4aLDpcarzE7i0IJ2f6m9lA==
X-Received: by 2002:a05:600c:470d:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-450d64eccc4mr155186495e9.13.1748948315037;
        Tue, 03 Jun 2025 03:58:35 -0700 (PDT)
Received: from [10.50.4.239] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a182dsm17755387f8f.100.2025.06.03.03.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 03:58:34 -0700 (PDT)
Message-ID: <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
Date: Tue, 3 Jun 2025 13:58:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_035837_657356_16207604 
X-CRM114-Status: GOOD (  20.98  )
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



On 02/06/2025 7:35, Shin'ichiro Kawasaki wrote:
> When the nvme scan work and the nvme controller reset work race, the
> WARN below happens:
>
>    WARNING: CPU: 1 PID: 69 at block/blk-mq.c:330 blk_mq_unquiesce_queue+0x8f/0xb0
>
> The WARN can be recreated by repeating the blktests test case nvme/063 a
> few times [1]. Its cause is the new queue allocation for the tag set
> by the scan work between blk_mq_quiesce_tagset() and
> blk_mq_unquiesce_tagset() calls by the reset work.
>
> Reset work                     Scan work
> ------------------------------------------------------------------------
> nvme_reset_ctrl_work()
>   nvme_tcp_teardown_ctrl()
>    nvme_tcp_teardown_io_queues()
>     nvme_quiesce_io_queues()
>      blk_mq_quiesce_tagset()
>       list_for_each_entry()                                 .. N queues
>        blk_mq_quiesce_queue()
>                                 nvme_scan_work()
>                                  nvme_scan_ns_*()
>                                   nvme_scan_ns()
>                                    nvme_alloc_ns()
>                                     blk_mq_alloc_disk()
>                                      __blk_mq_alloc_disk()
>                                       blk_mq_alloc_queue()
>                                        blk_mq_init_allocate_queue()
>                                         blk_mq_add_queue_tag_set()
>                                          list_add_tail()    .. N+1 queues
>   nvme_tcp_setup_ctrl()
>    nvme_start_ctrl()
>     nvme_unquiesce_io_queues()
>      blk_mq_unquiesce_tagset()
>       list_for_each_entry()                                 .. N+1 queues
>        blk_mq_unquiesce_queue()
>         WARN_ON_ONCE(q->quiesce_depth <= 0)
>
> blk_mq_quiesce_queue() is not called for the new queue added by the scan
> work, while blk_mq_unquiesce_queue() is called for it. Hence the WARN.
>
> To suppress the WARN, avoid the race between the reset work and the scan
> work by flushing the scan work at the beginning of the reset work.
>
> Link: https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ [1]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index f6379aa33d77..14b9d67329b3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2491,6 +2491,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	/* prevent racing with ns scanning */
> +	flush_work(&ctrl->scan_work);

This is a problem. We are flushing a work that is IO bound, which can 
take a long time to complete.
Up until now, we have deliberately avoided introducing dependency 
between reset forward progress
and scan work IO to completely finish.

I would like to keep it this way.

BTW, this is not TCP specific.

