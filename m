Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC6DC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gr8k/Vm02ygPW32aJTJ9dTPWwg2hxQoQtvUykdUgDb4=; b=roE6zu9wEGHlbXajuLSFB1Gfn/
	a2Y9CA0bz/8gkbPYeKMZhp7n3xLKyEo17THqIoyts772ZmRCnKni7KSTmHz7mLegh1tdUwIep/P2G
	O2Kcux9wxouFCbeeuly1G8CoF3ZcP9FDCHBot9H4VzAM1hH8Qs0cFwYcytlhPTlqWEzsVfcfkYbNg
	9EyA59HA2nS1oL9cCgKQAsJevbugTI0RQPseFUnmn2jKK2QWof3kqQiEgCrFxwgmFWM5ZwPLfjiTN
	Xu/0HLps0hgroUlPfC9lEuMH5Ux0CYCZskGnTLN8D7BXOnkvSqNj4usGkWK7SCx4j7k6wl183KDy8
	EU+o1ZTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD0iW-0000000A6nY-2SX1;
	Fri, 31 May 2024 11:46:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD0iQ-0000000A6mn-1uSy
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 11:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717155992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr8k/Vm02ygPW32aJTJ9dTPWwg2hxQoQtvUykdUgDb4=;
	b=YFH+bIWgrlK3omp36Gogj48UX9ZLf0dcnOEwDx1CQjylWB1NK9rE72GYI2y2/Qu4ppeZcL
	0//qhJCjfEw8oWH4ZsX70gppPtm/YKGnEqT+1ruV6850ySZbz1K9kOJK/3xemTWtRZZwrC
	tmzjSzZSFbZNwPCiDQ0BRM1YU/PJ0j0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-mOhGzjUJNmKMd7pFQWXdZQ-1; Fri, 31 May 2024 07:46:30 -0400
X-MC-Unique: mOhGzjUJNmKMd7pFQWXdZQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2bf7dd49cbaso1642620a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 04:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155989; x=1717760789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr8k/Vm02ygPW32aJTJ9dTPWwg2hxQoQtvUykdUgDb4=;
        b=UJgJElrv4O5f0P8VNPwLKeBX7iMXLqwViFWKU/Ap9h9yyEUDUytk7wdCQzzTXxyife
         FyfMHBXh21EnbzNxQvI8efuKTJqqD4rCUQuCHqauMoaQAyxA6XrpywFitikECQPqJkMJ
         OPH2x7gd5ClXnlcJp0Y0G/CKyPSHfXXyZ0WDG/xpYoFVznlB+cfI0vv3E3qmVpfZR3ZV
         RRhv40i57Nl+ZeeGu5K3DOnWk5r1Dbm4JsOk3hcYCnDkjlAp0vjmuIKGg1LRkHQ/hv3H
         b5uoa7W/qkpRkVouWIKuZAb+MapcGYoQWPRDTKAfxm+tXfvzLWkcNrHas8bx+TIhkJTX
         z2tg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Z6z6K9RFFpxQzQMUfM7F01bS3z5dsIptj1SxiPcsNTzDhAoGFBST+OL7PXbKEfkjcK9ZqzOKUr7Rt9s8Cs/KxO/all+DW+4OIIizA7g=
X-Gm-Message-State: AOJu0YzKKjV2Oit3Vn/ZeL0tnMUq1ju/UwRRxEsTEVhsC4N4jO8Z+4+a
	xIQoVrq9zpPP5QIpfBd21uQlLSCR3TjMOkgzWd27c1pYL7PlxSKwlbaF17FUX2jc8cWXs2TSWKn
	wEzRvxkrMVjyhHzuRfrKpoSgichR/YkzxsXudGcrt50w8IdUM9KfO2AjrzPbUAP5bjXrPbEYw3c
	8Pcjy99/d+BBQ7BwhQ/nMoZrtz3+4ePaguf8t4uuA=
X-Received: by 2002:a17:90a:aa94:b0:2bd:f049:932a with SMTP id 98e67ed59e1d1-2c1dc5c8832mr1704309a91.34.1717155989415;
        Fri, 31 May 2024 04:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTq1sroVC/zyco89stsGzLWmiBt5HeZSFTphj0DZrCDCYOHtXNSLNxvKpXEsf8gGnY0WWV2gmiczJH02FvAx4=
X-Received: by 2002:a17:90a:aa94:b0:2bd:f049:932a with SMTP id
 98e67ed59e1d1-2c1dc5c8832mr1704291a91.34.1717155988960; Fri, 31 May 2024
 04:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 31 May 2024 12:45:53 +0100
Message-ID: <CAOgh=Fwfab2W=6QzhuBfm4fazXMnNLudSQpWw3rmX5ZcSo36yA@mail.gmail.com>
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_044634_665607_02C64997 
X-CRM114-Status: GOOD (  16.13  )
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

On Fri, 31 May 2024 at 06:25, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/nvme/host/apple.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index dd6ec0865141..0cfa39361d3b 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1602,4 +1602,5 @@ static struct platform_driver apple_nvme_driver = {
>  module_platform_driver(apple_nvme_driver);
>
>  MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_DESCRIPTION("Apple ANS NVM Express device driver");
>  MODULE_LICENSE("GPL");
>
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240530-md-nvme-apple-e0edb9b98c45
>
>


