Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92900C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DkUVoTAl7YZ8iV+h+p/E7rejIu+4PoMJoPM9UjUbhrQ=; b=SbIqh2QQZW/CuJ1E1jwqrpfmRi
	8j7URzKdhR72CLJQOvOEDb/lPrcy/dYjd9jnUTYHHPeMgrft2QS2joCVdmKLd72YIFwX+xo3gRXC9
	KeLOJpfySWcavuvsboruFaMKSfb7OrfAo52Nu3308N9HjAE5cVu2zX0cKYro2zi1uT5j/VnxdtwL4
	7p8WdCFDjPBymzduToBhIT6t0DYquXF7UGGfGOX0+hJm+N7FQw/tRvu8cfTtDG8jn5Zl8tn1gVovR
	CnqALOfyPvSa4PvZ+fWVohJxEv7+ZhF6DfxRjf3Ah5waj7CWCFfm6daQHaPjXGyoOu1iRho/Xc2xL
	yMp6gU8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VMJ-007CMo-Kf; Tue, 06 Dec 2022 10:39:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2VMG-007CCi-G8
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 10:39:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670323167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkUVoTAl7YZ8iV+h+p/E7rejIu+4PoMJoPM9UjUbhrQ=;
	b=QomF4vJXbBCTDRXKmS+ZNmpZ6zgWlNLz/ST6FtQqrmKFFhEQM3cGIoS827vwwYlU2Q+Jab
	gqrK+lrOWc5C8gDsxw/9Z5ftM3GwEKpjREmYSL3n2Xat+DPWyHJ4dRfUizIwYuZXvT+Avq
	2aU8VZcT2O7CSEAq0MlBMaFrLFTzSZw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-zFt9bBhINxSC0NZqikZ-jA-1; Tue, 06 Dec 2022 05:37:54 -0500
X-MC-Unique: zFt9bBhINxSC0NZqikZ-jA-1
Received: by mail-ua1-f71.google.com with SMTP id z44-20020a9f372f000000b00390af225beaso7308177uad.12
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 02:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkUVoTAl7YZ8iV+h+p/E7rejIu+4PoMJoPM9UjUbhrQ=;
        b=H0j5+5GignGvp2jhySP0J8IkakCI5KiWI2RJkewSCQTXVH9LHwRQ2/XABwnHzd/mNx
         4n4rjCw6L2dB8zBNhH/Vj8fs6xrRNfCt8icEC0T2rheXwiGebtG2VFkfd0O9dnHBODof
         hxwWXfkf6tE/xBLXihkEVS4FFWd64KiiHw5ev8r8ZQTlLZAn46zz6Hurzk0B8SyrwUfD
         IGONpKslljGJwrrXTxKmt6sMpwXlKkxwto2pGNqPf5ROQXmwqxEJ4Km+tVf9I47Y8W70
         5+NSqtGKkDwtBLaGZkIOGLOchsq4WVHNCZH5PxVEz+lpFfeaCRDULcGVgzeDjgr3ZPA3
         5Vbg==
X-Gm-Message-State: ANoB5plhzitQs9szLzw07B+NOPBi+BHkYkXiquNnhnYmOKHhIni7oioN
	bKRWLuit0+nZV6RxzdtBZ23QkAR0c+7cPc0FCNfMoAlGH91q5gwEHvuTonBw8a1nlO5MqUeYFOj
	QKb6oYzx46Djk2ZT4vQl0/OMT0cGz/6ovYSqNijLcCx0=
X-Received: by 2002:a05:6102:3129:b0:3aa:125:9040 with SMTP id f9-20020a056102312900b003aa01259040mr52571441vsh.13.1670323073983;
        Tue, 06 Dec 2022 02:37:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6g7L+LzHomWoPugltUcCEbFCYXsailw2SvmbWFnpYUoOMzTBFD8TqxAz2rJgHpXlRIYrnKnvS2Ku+ZOMZW4I4=
X-Received: by 2002:a05:6102:3129:b0:3aa:125:9040 with SMTP id
 f9-20020a056102312900b003aa01259040mr52571429vsh.13.1670323073783; Tue, 06
 Dec 2022 02:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20221129132208.4337-1-hch@lst.de> <20221129132208.4337-2-hch@lst.de>
In-Reply-To: <20221129132208.4337-2-hch@lst.de>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 6 Dec 2022 10:37:37 +0000
Message-ID: <CAOgh=Fxb7f7aozjxYM8uXd5RdLnxUmiQ2MiT7vAWT94OgdyUpw@mail.gmail.com>
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in apple_nvme_disable
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_023928_656106_2532AF09 
X-CRM114-Status: GOOD (  16.32  )
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

On Tue, 29 Nov 2022 at 13:29, Christoph Hellwig <hch@lst.de> wrote:
>
> nvme_shutdown_ctrl already shuts the controller down, there is no
> need to also call nvme_disable_ctrl for the shutdown case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> ---
>  drivers/nvme/host/apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 94ef797e8b4a5f..56d9e9be945b76 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>
>                 if (shutdown)
>                         nvme_shutdown_ctrl(&anv->ctrl);
> -               nvme_disable_ctrl(&anv->ctrl);
> +               else
> +                       nvme_disable_ctrl(&anv->ctrl);
>         }
>
>         WRITE_ONCE(anv->ioq.enabled, false);
> --
> 2.30.2
>
>


