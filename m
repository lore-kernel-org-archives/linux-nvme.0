Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6AAC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MURZWyeMo1Womq6lRyA26bcEWzkllzCUJ46JzjjNMG4=; b=eDaH9dy/UhSEXSOU3vE0PsVEDg
	+jgRLkWGguIvGa/OQGzz5b0fsuLnIWCO7v8GNfAWD70EKCvQopuXsd+aMpUanujppYBKEPweUt/yd
	WfeoGuNy6PbrJcTJo+eHRCxMhaOVMzhdyeY3lr11n5XxNbW42CnQKUtqGU87DeuWmyPkOuRker/gX
	wpJf0zSQv56P1A3wBX3UIg9IMo4YzSR/K3FBhCJ47GgnnlH1lTVYVNWyOqnRSdBLr1hVOK6D3u3LD
	l+/DuVsE2QUQFrQmdEtktDrKIGRT3wHeC4zZR4mDJjoEACwPTVYFujcQYKOtAE6b4ANbLNmu7g1WU
	G9AmdiVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwQf-00000003kkq-2em7;
	Mon, 17 Feb 2025 08:24:37 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjwPf-00000003kdG-1xHM
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 08:23:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4396a82daf5so25713965e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 00:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739780614; x=1740385414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MURZWyeMo1Womq6lRyA26bcEWzkllzCUJ46JzjjNMG4=;
        b=WG3ov8LtTVo7mlcN+nRBr5dGvvj0Oy1WQQd+gJjgu58fZ2NTyVVDgySpkfGmgmrLt6
         wdZjLX1n4vhGwqtdYPmhnKfw6NeQ+YTRrkEqZ4CeNJnH6DNgTOrz6BCGY2gQ4PSdUeQd
         aJ3eHVujkclVV8ywnQWWYXj0++jQH3jXkd9u/xL0bAndGVkcThm4JSaBnoF3I2Il/XDu
         b7DT3kXH40628Xam6VbsWj51nFn5tYMrF9zM4XhiSgG2uhK/0XVNicfGHY8SD9nS5kYm
         QtvmCPlo7SpzWaxQxuDBacrj56tVIwpNeutof/lM57xf5E/IT2tJdJLHvqpeVhH71V4p
         AbgQ==
X-Gm-Message-State: AOJu0YyDTQQISZqeAclehp/dKdpegLn7yA7Vd/F/zpEEHfLSbcNfTKsi
	fjsmfeC5kFbs4psizY6yGTIumz2ysTkoVGLizMtmewoFbT0JKNJVFRo0BQ==
X-Gm-Gg: ASbGncuLGc2lALqCADc3gUvlPlFvTJP7jeQc3Srh4AjjlRnQZQo68UFhwx2pHcX17rM
	uysHDeuDusrBRI2BUuX0Y6SwZN0f9ZZ3gakoD2+RopcfahcEG608EN/vpJfS6fXDkLr67RVIv25
	FJTCRqwZn/QReCGo1lREN4hYxnA52FAXJqBi628q4HDeBQdWElIQohBBOsjcS9BZoy3S6t4wZUa
	52pvSZig1evdXsBqwJ+VSoBsWQY6P6cD3AYKWC4wl6YZG2xamyfl7Zg/4rYl/fmGu4l5hw/CghP
	R164KxSMYA7CGqOTwJuYnYn6U96j3g8q4nn2rFjGMCSYv9/Kkwi4Bc4ufg==
X-Google-Smtp-Source: AGHT+IG4AvEGTbUxffMa0tv61/tzEfy4436k5cpp1GXxUi9QewDM9liYFY8axJzPc+dJvD0kIF8Cdg==
X-Received: by 2002:a5d:5689:0:b0:38d:da11:df19 with SMTP id ffacd0b85a97d-38f33f43875mr7160828f8f.41.1739780613927;
        Mon, 17 Feb 2025 00:23:33 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm11327745f8f.89.2025.02.17.00.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:23:33 -0800 (PST)
Message-ID: <4ae86f5e-e684-4f5f-9331-0c2b83ad49cd@grimberg.me>
Date: Mon, 17 Feb 2025 10:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Enforce update ordering between queue->cmd and
 rcv_state
To: Meir Elisha <meir.elisha@volumez.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250216150804.1542552-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250216150804.1542552-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_002335_507719_93891EE6 
X-CRM114-Status: GOOD (  15.16  )
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




On 16/02/2025 17:08, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
>
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>

Hey Meir, thanks for addressing this.

> ---
>   drivers/nvme/target/tcp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..b66aa93baaf4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>   	queue->offset = 0;
>   	queue->left = sizeof(struct nvme_tcp_hdr);
>   	queue->cmd = NULL;
> -	queue->rcv_state = NVMET_TCP_RECV_PDU;
> +	// Ensure rcv_state is visible only after queue->cmd is set

Nit: let's stick to c-style comments.

> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);

Isn't WRITE_ONCE() enough in this case? We don't really need smp barrier 
here afaict...

