Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A056C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1zRha7BHAhGg6ATSz7b6xyQOdyDIKVBqdliEZL7zC0=; b=VX7fWLNa94Hh1Vlwr9MYsAmCaG
	85ENRBNkFiahCgMoMuxZ2UbL4CiJlF4h7upUGk8QMHqXtJI2pho+VTp4P9/caK1wjKXQ7vfG/Wefk
	MeUoWnawsWQLaeUFNnCJqBlK40v2QUYvtWSLWzO7trBmgIRRHl0YEjaldenf5C+J9l0mZsOKKQBnb
	qH3/bvyweqMBxOBQVmwXzM/hPRlcGe/l2K+ritR26AHjAJ9hEYZmUA69xyfOWjfZjKb+nkxePS6CC
	4PQa1feXgn4easiwOs5YdYgcF+OU66aOMAaS5Y8UVAIB9fZTmxU9zgj/RNWfGWd6l/Fp3+hcKReof
	RhsDPFPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgsHr-00CAwA-20;
	Mon, 27 Mar 2023 19:13:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgsHo-00CAur-2b
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 19:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679944422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1zRha7BHAhGg6ATSz7b6xyQOdyDIKVBqdliEZL7zC0=;
	b=iwQVaKbfPg2IS19GJDO5SSD/v2Yy0dq4vA8IbqBymRhNSEIK4K78cSqi54Vemciz02VOfe
	ZYEci4aPHi5jGtf3mZjc0WuiQAgqL78fhv6ELvS3cmaZ7EkPKLe+fdDMMaDNftCsm6u8jh
	HKEU4I4goNN1AbksZHUgNsHULK1ydmQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9FwIzY2iMceRO1vC_ck4Mg-1; Mon, 27 Mar 2023 15:13:41 -0400
X-MC-Unique: 9FwIzY2iMceRO1vC_ck4Mg-1
Received: by mail-ua1-f72.google.com with SMTP id o4-20020ab01c44000000b0074031f8fe21so4610670uaj.18
        for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 12:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1zRha7BHAhGg6ATSz7b6xyQOdyDIKVBqdliEZL7zC0=;
        b=GXx/kpHzdqy9StAuFAslg4y7hRaa/CVHDBwVsVEkmB0Lw6+e9cWftg4+DSl9jSdkSc
         cQI+nXMutHgW58WBvevSe+FQ+K763bmE5cg55vk6q+de0N8yBCRzbpuGzhaf9QR637rO
         KCzEGe9CQag4cle7Nqw6tPM/QbsG/KGlTYr1QVhYjWwqpiCRSfrOqBLBgbYGmcinROx0
         vJB3zXg3o6ZQEhWfXBsMhYcMnAAFBjglE+ZOds6NkOEzoLTdGJmcTaxIYaGdVJ+bwU0X
         0Maa25ZJfhGALDqA4IxNcMakHCpKkqDjOel0FfSqNIMJj5aWgfFMZYWlpv/U1KACdxFd
         3jhA==
X-Gm-Message-State: AAQBX9cwA8ZFwZ6wXoKnwZzz5MDBQ0G3vd4uexwrpD2xNe9sceAdFuHS
	In18hatwcvjQviYNYz477ZeJzH99lqd9MXnH7cY2GbimaouZn1ZpLs2oiIpihYy3gVQdn9Fp5qG
	+YCcesskE8vWKfPOaefhWpdsxdhDl5h+Xg83amR2j798=
X-Received: by 2002:a05:6130:c0d:b0:68e:33d7:7e6b with SMTP id cg13-20020a0561300c0d00b0068e33d77e6bmr7024121uab.1.1679944420934;
        Mon, 27 Mar 2023 12:13:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350aaQogn32n+L7ho5TXNxSDqxcL5rz6nhgbIjh/RSrzQQA6apKf0AxmPK9a0UJLy7cSZ4T8TLlgvPPzbQgzK2iU=
X-Received: by 2002:a05:6130:c0d:b0:68e:33d7:7e6b with SMTP id
 cg13-20020a0561300c0d00b0068e33d77e6bmr7024107uab.1.1679944420622; Mon, 27
 Mar 2023 12:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230327054838.67353-1-kch@nvidia.com>
In-Reply-To: <20230327054838.67353-1-kch@nvidia.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 27 Mar 2023 20:13:24 +0100
Message-ID: <CAOgh=FyVPSmXLJgvsfep0waEoKDT3BsuVg7ZYY=_98A=TYJXng@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme-apple: return directly instead of else
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, asahi@lists.linux.dev, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_121344_937597_D41F2A29 
X-CRM114-Status: GOOD (  18.05  )
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

On Mon, 27 Mar 2023 at 06:56, Chaitanya Kulkarni <kch@nvidia.com> wrote:
>
> There is no need for the else when direct return is used at the end of
> the function.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/nvme/host/apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..942a3b71a6d5 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -209,8 +209,8 @@ static inline struct apple_nvme *queue_to_apple_nvme(struct apple_nvme_queue *q)
>  {
>         if (q->is_adminq)
>                 return container_of(q, struct apple_nvme, adminq);
> -       else
> -               return container_of(q, struct apple_nvme, ioq);
> +
> +       return container_of(q, struct apple_nvme, ioq);
>  }
>
>  static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
> --
> 2.29.0
>
>


