Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF7C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cT+4YC/mheJocNiFQ9dpjgmB7r6hZL7ROf4mMG+AfOM=; b=UBZagdTlCIrMu8UPSD9fbQyxjP
	NEnQuzmYwXhw2tN5IBk9geOQT1EFjK1qCaWERnfcJoKY4wc6k/Qvp0g6pKUS6r9EIABG+RMBWSgdt
	C9dobm7PfrrijCHo/USpJEewjSVSBIQDb+4HSfZ+C9Bz+v04oWSITTJbsqfuPgV9gBb8Ht4MwX+zq
	F1p96/L/sjApYt53r1VJzMF0cYwUb0i4sBLqKulSs61YXwNUIx5w3oDjpD9BtPkNd9DqarRZgYTUR
	jhZH0Gj5wEuXlUJ1q52K+arOPYAMNfdJrcseBFWJRyXVVDU1hV6Ymqxadh4Dk3sT0TEuAmHYzw8K3
	uxN4JC2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rADJc-005Fbj-0h;
	Mon, 04 Dec 2023 18:05:08 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rADJX-005FbD-1P
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 18:05:05 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d374bebe3so3477615ab.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701713101; x=1702317901; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT+4YC/mheJocNiFQ9dpjgmB7r6hZL7ROf4mMG+AfOM=;
        b=yNrxDlpOpVsTkRoPc5l2xUo3Vh8UZrGkMi6eLp1/gIW7DNlv2NUA5Zs8F2IZygoGWr
         JVZ3tNFBElcD5s8RrOKcAYMLNp+qwFx/yUO4KQEhN68nUU7kKjF+gaZ374G/gftBOjK/
         c4YshLhTlPzP+6dQ37yZJc4tSjSsGg5jr/sUxoKHL+96bcnzYm7Ntrb69G6zFITqZEb7
         R0DtG80h7c0/tB+0xvH3l1bmpCJP9Cq3QaCQndaVPyM26Ao6ik0qj+Fu+nNXKvWuEI0X
         MObZKzrlJFNiMB9qy81cqsyYlqdX2yDxk4yWl+mD0oFe3R5ELMaPmvJoc7j9145IT/Kk
         CG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713101; x=1702317901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT+4YC/mheJocNiFQ9dpjgmB7r6hZL7ROf4mMG+AfOM=;
        b=pYQyLISSeOqH1JYNqOWvUoBCLaHXdU9irJb8b2ey9MFc2LuNsvJR67kWp2m3+f6JDd
         rEaYrDjFfsWGYFVMrZYI9ECfA0hb2SXhJK8McSNbQgQTzfnwxm3nm5GpZP7bWaHAhqB+
         ljDj/17ZfHUNHgp+e7PzjkzzD2X6RbInDQEfZVIgwWMOcuFdV4pGS8mQYxIi/TYdF5Fm
         mIvr3NNvzX4tAUPUw3h3o5fgSOyRPOtIKAoT2ITGy9Z6FMZzdWKZWmWS63tmBol9Zeub
         lb76f98gPBfy/UfUGEjGiGKP29zx994NIbT0C1ZrUZxw+D32ipipnlUqb83moHpWAslQ
         JSag==
X-Gm-Message-State: AOJu0Yy9tJQmTKSjS+zFAu0jGuYLfKbrz3GmRSUIqRWqHRdsGqQ4Hjj1
	h4DuIX/henIh8xDQwdgBPiKz1g==
X-Google-Smtp-Source: AGHT+IEvGG2jQ2QiKm4yVfTLz6F1ahd/oETC2RXWCrCdVtSXGsP78J3QfviDMwPQAkwPVUqdn41Oag==
X-Received: by 2002:a05:6602:489a:b0:7b3:95a4:de9c with SMTP id ee26-20020a056602489a00b007b395a4de9cmr32362013iob.1.1701713101320;
        Mon, 04 Dec 2023 10:05:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f1-20020a5ec701000000b007b0684e260dsm2910040iop.2.2023.12.04.10.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:05:00 -0800 (PST)
Message-ID: <a387fd6a-7d4c-49e0-bb89-be129b10781c@kernel.dk>
Date: Mon, 4 Dec 2023 11:05:00 -0700
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
X-CRM114-CacheID: sfid-20231204_100503_555640_27526C1E 
X-CRM114-Status: GOOD (  12.43  )
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

Hmm, what happens if the app starts as eg root for initialization
purposes and drops caps after? That would have previously have caused
passthrough to fail, but now it will work. Perhaps this is fine, after
all this isn't unusual for eg opening device or doing other init special
work?

In any case, that should definitely be explicitly mentioned in the
commit message for a change like that.

-- 
Jens Axboe


