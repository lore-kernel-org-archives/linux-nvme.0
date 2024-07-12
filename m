Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB92C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Em+4lpr48F+sTPUkNgk9R0TQyrZ2qwV17RRP7sfDWpk=; b=odSKeoXYg+yWDkSVKUOc+kkFKx
	YlZYRCLtbKw43Aw5WbA6nQlAcpMDFKtdVr6RjXJV+4ZcWX2ezDAjKJW1+UA9BbMj0I6cKoov7r7QE
	lhXhHyKS+MocVYcKLfKCMPVewpVdkLOVWlsthXoWaWdMoyPmNN3yKqBr6Wthw0totuFNGR/PLJfyj
	VwBltJ+zaV0qlDBOUPjjDFSea+YLnZuGd1byQjzEoqFUfpDlOWciCK9yXSvCDPkPgNQ496BFS7QYi
	7XprHWcnp7eaEc2ev2jVU6gtS3zqugm3VAMTVkS+d40mXs+s0YIBvLr7OK0/Pq9g/QI9deCgqcwqQ
	ZW8NkC7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHJe-00000000KJz-2KMn;
	Fri, 12 Jul 2024 14:32:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHJb-00000000KJ2-0rgk
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 14:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720794721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Em+4lpr48F+sTPUkNgk9R0TQyrZ2qwV17RRP7sfDWpk=;
	b=RW6Dvb3Yunh2OqApfQlGNR8cMwqhwCZsErEm+nx29s7hk7xK/SAs/l3x9vadFAK1m/cPOU
	XgKL+7cncEYM7nBwOnPAiDDyA93v6bhxvLxaj1uOET0bifgnekG2JwKsjGGXo97gCc2fqT
	u7x6j31iizL5gKLr2BPT/SLyAvO27Y0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-02dibe9GNGyx7f_KZdDNFw-1; Fri, 12 Jul 2024 10:30:00 -0400
X-MC-Unique: 02dibe9GNGyx7f_KZdDNFw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c9fca572adso1852978a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Jul 2024 07:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794599; x=1721399399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em+4lpr48F+sTPUkNgk9R0TQyrZ2qwV17RRP7sfDWpk=;
        b=nPDYAl7WVggnynF8SDfRcc5eGpZJoytIKal5854bp5sqAQMklkKYkygEesRGxl2Zgx
         GW/qWCTv97AOaKHzEVHWOhoFhv+HoEutSE2RGCcQjt59LWlZbIC3aRxsLjUZQ28rQU6t
         M82v139sJAbZgRAK53lmxP+lX8QPs/fzOFCkmvJqDWG+dSbrxFpodShJC0yo1/kDkcqV
         9BmVtOAn6nmzhOdtErhHkYd4wGX56cZwAiDcmb1Ock2gORfUYRrevyX7gnIBqV8H/BDf
         NAArAK8CHzTBwkrFtp5+v+Zzmq2/Kibeue4QmCiVGMRpicOKiiCefsGhbLEYpt2NBbz2
         7/kA==
X-Forwarded-Encrypted: i=1; AJvYcCWW4urMtutN9ur5O19t01mxlJXfOwPFByWcLNU1UVPYsbgPZHQZKx4UFVx3kPbm0FdGVVOrYjJWT9OFILxzVVDsaNiHTyhXttCnObZWm5A=
X-Gm-Message-State: AOJu0YzAOApy4xjZiSUk7IA/Q+58J+xI9anNxp0OIQG3RPhU3X82ryaJ
	GmjKRFRcHFLCbS+sREY8ry+x4blxsmcsBUzaGQNYszS+9HaJtCFBDzI6iNLkAOXeYIIF4lZUAyl
	UfX4uL3bHu0ZJyw4gIm46BS5xtMALEJjPwqF5oRj08C0P38bKziV8lmGyctSCPPu1t2UDp6TZ9H
	c/wGcs9ndVSNLMyxZFkybKlcl4NGmF6KU3Jw73A3U=
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2ca35d43887mr9092101a91.39.1720794599172;
        Fri, 12 Jul 2024 07:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyEXCNphbXM4G/rPhQQo3eVo3TcpH/vUgTlLXnK+HK0NsMDnIjoeWz76/qY2/k2Ca8KWUcmscnLjrUmqi++Q=
X-Received: by 2002:a17:90a:70c6:b0:2c8:87e:c2d9 with SMTP id
 98e67ed59e1d1-2ca35d43887mr9092063a91.39.1720794598057; Fri, 12 Jul 2024
 07:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
In-Reply-To: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
From: Eric Curtin <ecurtin@redhat.com>
Date: Fri, 12 Jul 2024 15:29:21 +0100
Message-ID: <CAOgh=Fx6hcJdbQpna2JJhnzp=YG_nyg-gpd=ZH7CewudtgDhAA@mail.gmail.com>
Subject: Re: [PATCH] nvme: apple: remove some dead code
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_073203_364418_58E158E7 
X-CRM114-Status: GOOD (  18.04  )
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

On Fri, 12 Jul 2024 at 15:13, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> platform_get_irq() never returns zero so we can remove his dead code.
> Checking for zero is a historical artifact from over ten years ago.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

There's quite a few return paths in platform_get_irq_optional, are we
sure it can never be zero?

Not calling out a specific case here, but it's not so clear to me how
we can guarantee platform_get_irq() is never zero,

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/nvme/host/apple.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index b1387dc459a3..f5a3a4e8b1e5 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1417,10 +1417,6 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
>                 ret = anv->irq;
>                 goto put_dev;
>         }
> -       if (!anv->irq) {
> -               ret = -ENXIO;
> -               goto put_dev;
> -       }
>
>         anv->mmio_coproc = devm_platform_ioremap_resource_byname(pdev, "ans");
>         if (IS_ERR(anv->mmio_coproc)) {
> --
> 2.43.0
>
>


