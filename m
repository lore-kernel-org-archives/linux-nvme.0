Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C953E9A03E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNVQyKLX8ocR3vbGIm92cdsBZk7+sfodVXOXMq67+Ik=; b=gyUevOm9iFvNYlnPj/du5gKl+S
	rpYlGK22Tu886TwzAtUAKvORACkGxZZa5bUxBFyEXOLWFAPpLJ+7ligc7emRQdI7ExV3FHJPXIuwF
	maggt4PnG9oajpSbUAnHtOGHoK1kzdDyShfaOXwn8K0KtCI6g/sUZ/f74RaHQ0U1gsDInSS5ZKIp9
	RPJVkDzdeLexvwtDvjg/5G84jJvZhEXWTQ/iWgXUTZz3pJWivGUOVkMniX7bTJ8Y06eBcVofzX+xt
	xm7O5c2beCn0VqtB+KLRIThEHKmp/MoJ9zUoNhohHDCLMDQ6WUOo0ND6Yha/+DyBcy0sjYkBo9HIz
	H0rmb3EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRTb-00000008qMJ-2JgZ;
	Tue, 17 Feb 2026 20:15:19 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRTY-00000008qLf-0qZk
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:15:18 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2b740872a01so10013404eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771359314; x=1771964114; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNVQyKLX8ocR3vbGIm92cdsBZk7+sfodVXOXMq67+Ik=;
        b=UkKIzLyBzLqQua6u07yqOEiPzhnsciQI5IHUk743lTfi6fIW0JgFl7zZ/lmr03uC3O
         uFrQfWJ87vet3kXM9ZzrZMPVSZY1xoS5lBFWFU266PCZuw9Bel3VnAt8pRRTloa+933X
         2t0wNQwdKzrAUE/r2cIlDzC/EaEFst6CFpNbyJDI11Z8PF/id0T+xPP43zrnFagHnXc5
         ggFIxOKDgMd2UJXRWCZPiMXYr0S6AJpQvFWu7A2L71TkWihSWsJs5BafAa/KnKvJOCqn
         aP+k+mL5H8+H0CEdv3ySPy6WgQWP8H2iRZ18UTt0+iqsKlO70wP5Q/Qq2JD03ivdnDuK
         ovXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359314; x=1771964114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNVQyKLX8ocR3vbGIm92cdsBZk7+sfodVXOXMq67+Ik=;
        b=pa8wGUZAeq2DW+pJ9wcgb0eWFWFBzR0UcvOITQTAP8VsshlIlPaT7mTnOq4ZLm7eXK
         U3n2YsEhKnzWNTlk1HgwRt3b9wGpEoQQq5Qd03vbNTFT9p2ndkmkkZbsRnJv2X8Em5Dh
         RCzw+76r5juiINnc1iat7HKzjJogvn995ve62G3l/cpsoTefFaQRuVnLtvrGlprVCkle
         5NNHzUoqK+aDhtaCICBBfv5iAGXrx5bDQYnytHy7NUEdc6CN3tHqZ+pzBX0oU1lhSrGE
         YPB4jKtfH6g5/VNY1XuCarkoawCYMmD1y0DgF/GjkuGIXXNow786H5n68mFNkjTwWz/h
         px3w==
X-Forwarded-Encrypted: i=1; AJvYcCWpeaGRLhLIBdGgKWGivrRmaT+m2MuHW9MzK06jU/Z1raW68luFIkbHfLVJMA3ONKZcrYITGxoxTGBf@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0ZB6q6+I12k+MsAmxPFFrFdMjM1bKAUD/Yxjgw6crkFKySS+H
	O3IDcVabGuQVqD3TbwQ510xsZmbESdVHK/xd7JN+L6vbjxcmutxC+DIxpcCIAD1qZSM=
X-Gm-Gg: AZuq6aJCUOkV2BKtc63GSBC980qXL7MnnxLMOOahT8mnwKkTn4NWBJ0/tA6COzb2Bot
	zQyY4cgjuCGsSosUfyzTa1IbiBUtxbkUb660YEwOb/Eo5LDPgM0XpqcE51C9zlgsuHXIUEOYyby
	sBon/9xcBfQYRu8VFBvyRRN/2z2wZu+x8PUjQfCsOMN0FB5wBpIfWoxADqarxoXg1G9QNSyKnmp
	P2DcaufLYaMajMW4iEI9QRmk1CM1CQK96/Id+LqAuwSTEBaATSjbXWQvF92yhbeWmrWeKpWCBKV
	wpY5IveFD6XeqI5MA/W/81ZSsvDl4raXUHFomFVNDe+KS1gN+Q6MFA+e36SQ0tXAb+RltCnXWLY
	Gjo8IlT/0l4Val+GsxtLsaPZT64Wv8xOBHrKoCZrtasHubl0uvDjK8/IRcn0EpVv2cP7BosfMm/
	e2NkegBaxGEjkrBFFcO6Ba+7O/6zf+LDG+rtjGrYiFobU=
X-Received: by 2002:a05:7300:1348:b0:2b7:9934:c427 with SMTP id 5a478bee46e88-2babc46ea3dmr6429267eec.28.1771359313571;
        Tue, 17 Feb 2026 12:15:13 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb6782e5sm15323459eec.29.2026.02.17.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:15:13 -0800 (PST)
Date: Tue, 17 Feb 2026 12:15:12 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 1/5] nvme: Let the blocklayer set timeouts for
 requests
Message-ID: <20260217201512.GG3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-2-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_121516_273959_5E84F9C3 
X-CRM114-Status: GOOD (  27.43  )
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

On Thu 2026-02-12 13:09:47 +0100, Maurizio Lombardi wrote:
> From: "Heyne, Maximilian" <mheyne@amazon.de>
> 
> When initializing an nvme request which is about to be send to the block
> layer, we do not need to initialize its timeout. If it's left
> uninitialized at 0 the block layer will use the request queue's timeout
> in blk_add_timer (via nvme_start_request which is called from
> nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> NVME_ADMIN_TIMEOUT when the request queues were created.
> 
> Because the io_timeout of the IO queues can be modified via sysfs, the
> following situation can occur:
> 
> 1) NVME_IO_TIMEOUT = 30 (default module parameter)
> 2) nvme1n1 is probed. IO queues default timeout is 30 s
> 3) manually change the IO timeout to 90 s
>    echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> 4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
>    commands with the 30 s timeout instead of the wanted 90 s which might
>    be more suitable for this device.
> 
> Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
> changed the behavior for ioctl's already because it unconditionally
> overrides the request's timeout that was set in nvme_init_request. If it
> was unset by the user of the ioctl if will be overridden with 0 meaning
> the block layer will pick the request queue's IO timeout.
> 
> Following up on that, this patch further improves the consistency of IO
> timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
> could be inconsistent with what is set in the device's request_queue by
> the user.
> 
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  drivers/nvme/host/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7bf228df6001..b9315f0abf80 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>  		struct nvme_ns *ns = req->q->disk->private_data;
>  
>  		logging_enabled = ns->head->passthru_err_log_enabled;
> -		req->timeout = NVME_IO_TIMEOUT;
>  	} else { /* no queuedata implies admin queue */
>  		logging_enabled = nr->ctrl->passthru_err_log_enabled;
> -		req->timeout = NVME_ADMIN_TIMEOUT;
>  	}
>  
>  	if (!logging_enabled)
> -- 
> 2.53.0
> 
> 

I wonder what was the impact of these lines given that req->timeout is
set to 0 by blk_mq_rq_ctx_init() when the request is allocated?


Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>

