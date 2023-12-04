Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A91C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNAeyzY5pc7VMUm+A7dLwdlpqS3anz6F45PtdHvureU=; b=afdM/BtZRVcBuTEEt1gD1woqw5
	NJfE0fN+xuM8fJpxuEmHHqaasTaBtOTNkLb99ox7pSnf/JI8thUsEwdUP1ZRQzgDTUoQM8njocRBN
	PsP39roKZyRSIwEdAM+3l3oVO80RZI6cPTdFCd750tkoZXi0s/LWRlhWnSQn2K6TT+AQSHUcHzMav
	f5Y4JUXYi+2J65ofUb2b6fUnQoc+sN7i6P8LJawEt+6T/aDfC16SWOWoXucDv8+tBWWRP2LH9W2Cw
	+8WKKd4sAJGobW9xLiiXrUtY9h4ozzfTzpwmqUeFp2EIgfod7JJ+05AhQ+c9vf72tCaJVh6/hZWp2
	lVBNeIWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rADTO-005GnP-0D;
	Mon, 04 Dec 2023 18:15:14 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rADTL-005Gmi-0R
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 18:15:12 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d7341be5cso1138385ab.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701713709; x=1702318509; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNAeyzY5pc7VMUm+A7dLwdlpqS3anz6F45PtdHvureU=;
        b=dgE+Bdccu5h2sVC0bidtGiiZwE/uIIsnRDDWRpSRZ5W6iLDdCxaElw9C7IvyLNoZ5u
         77MHeIJPg6Vkp3S3gxqS9O+sHefjTLcgtj9orFa4K6zWSXw0snkjpxt17NfXphBwt2zy
         7hOifcpH76ApsDhUeY/rjs/nzZ7mP1XuPSXoRBDh6HH/456m8c/ntti4xY9easUjWedo
         A1JUwsD2e/WZF5I9WbBzWJ/blMRq2vkBVMGqKh+iiiVn4eyC5gxot4uIQttOZwFLttdv
         hVK1hOe2QjeNaHf+nFWht3/UDUEwfWt6B9D6oGu/jLtQItuVvAZxm42+C5VqRohcY5+G
         uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713709; x=1702318509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNAeyzY5pc7VMUm+A7dLwdlpqS3anz6F45PtdHvureU=;
        b=lDfdJtlu81yaNjd+EETxU+07xgD9vYfEZ9dspxGvCt+Jx+9WrH7cGP0MSXIBl748De
         OrCjagcsYnhjt9VHguvPjb31c7xU6QsrM5XLnbCe0v3kpDmFnBlGyy5Aw5n8sgB5HEex
         G3vUnAttnhV+pWCre3CPR+/9SEgcZ0bdRF8Aj73GjJ6+XKLkiF/3VwEx7aefLbtcJnCb
         BQWNb5FgQFH0JecyuS86ptWC0X0WKgD2JdpPcv+eG3ScXkL2fOfRgqUUrXYdLizsnEJH
         26suW3C1bbo6ldETxwOxJBNRxJC0i+dCpIlz6PFih0pC8sLBeY+qezF+7X5vlmrKXz2n
         NQ9A==
X-Gm-Message-State: AOJu0Yyo4g+7MS5+I10OnIKxqGtYhFZKrUdNGGzMRdi9DPHRUp8iAa0Z
	rVMU96vK8xy1y28iuWR03SyNnA==
X-Google-Smtp-Source: AGHT+IHpRAm6dzCfsDsfv5H9dsyqYlB3DU0GyLqs0l9tJFjoO/C/Yio27CPRFQOcl8QHSiSxkYQ/Gw==
X-Received: by 2002:a92:dcc8:0:b0:35c:ac42:f9a4 with SMTP id b8-20020a92dcc8000000b0035cac42f9a4mr24092773ilr.1.1701713709521;
        Mon, 04 Dec 2023 10:15:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t16-20020a92c910000000b0035d714a68fbsm40151ilp.78.2023.12.04.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:15:08 -0800 (PST)
Message-ID: <3fbd675b-78a8-4182-8afd-10f2bd15c7b5@kernel.dk>
Date: Mon, 4 Dec 2023 11:15:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, asml.silence@gmail.com,
 Keith Busch <kbusch@kernel.org>
References: <20231204175342.3418422-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231204175342.3418422-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_101511_178022_B46439FD 
X-CRM114-Status: GOOD (  11.86  )
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

On 12/4/23 10:53 AM, Keith Busch wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 1d254f2c997de..4aa10b64f539e 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3980,6 +3980,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
>  		ctx->syscall_iopoll = 1;
>  
>  	ctx->compat = in_compat_syscall();
> +	ctx->sys_admin = capable(CAP_SYS_ADMIN);
>  	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
>  		ctx->user = get_uid(current_user());
>  
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 8a38b9f75d841..764f0e004aa00 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -164,6 +164,8 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>  		issue_flags |= IO_URING_F_CQE32;
>  	if (ctx->compat)
>  		issue_flags |= IO_URING_F_COMPAT;
> +	if (ctx->sys_admin)
> +		issue_flags |= IO_URING_F_SYS_ADMIN;
>  	if (ctx->flags & IORING_SETUP_IOPOLL) {
>  		if (!file->f_op->uring_cmd_iopoll)
>  			return -EOPNOTSUPP;

Since we know have two flags that would be cached from init time, rather
than add a second branch for this, why not have:

io_uring_create()
{
	[...]
	if (in_compat_syscall())
		ctx->issue_flags |= IO_URING_F_COMPAT;
	if (capable(CAP_SYS_ADMIN))
		ctx->issue_flags |= IO_URING_F_SYS_ADMIN;
	[...]
}

and get rid of ->compat and ->sys_admin, and then have:

io_uring_cmd()
{
	issue_flags |= ctx->issue_flags;
}

Then we can also drop checking for IORING_SETUP_SQE128/CQE32 as well,
dropping two more fast path branches.

-- 
Jens Axboe


