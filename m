Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F277DC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6oBo9zgyt6kd8ybd493kKZpaIisYcCPUD4+15shZ6I=; b=ZuCOz9UzWldp0D7VX349maAYUH
	hOeSgGIbs0R960ciYSfr8y1jOW/DJARY5gzLNKZn/StzLppVqG3M2tOtDjcZSJnnee3SWhC6+6C/I
	fL+DFhj7B6LHgjxy0sBShLGsP72WTQFVWoJA04YbmELlWMstmSmxXSpYn0Y3iZJXgu9vRvTNHQuwT
	kcvR+KLPwAQ7CPBr2BRw/W2/WqXBkGIqLUJRlvWBmb9KhCub0vWIejWayOrHH41DHEUk+gw3vwd18
	13CAmRrXstzOaZqiIfOS10+9XZvUtdj5tGHC4UUZvlWiz/NjAzeIsfHSdmS4TL4p2XEwhn2/hJMj7
	AVFW1quA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgsIO-00CB1d-0N;
	Mon, 27 Mar 2023 19:14:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgsIL-00CB0o-0N
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 19:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679944456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6oBo9zgyt6kd8ybd493kKZpaIisYcCPUD4+15shZ6I=;
	b=ZLnPAi3pq5x31IEN+IXegdUjo2fyiC507T0udm8om2xEudv/GY+DiCsmNEvUmXq3u46945
	8nFusc3D1SsCj7hUF0IDpeG+isuZH3a+mMEqILP05KKSsik/uC71yW0SCf0EKUtC0CYQCD
	5OWo/13zyrGwn3AHbjkM9jjRJ6KzRXY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-qSvGSPcrMbWaUSunXFcUHA-1; Mon, 27 Mar 2023 15:14:14 -0400
X-MC-Unique: qSvGSPcrMbWaUSunXFcUHA-1
Received: by mail-ua1-f70.google.com with SMTP id z4-20020ab05cc4000000b0076095468c75so4646525uaf.20
        for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 12:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6oBo9zgyt6kd8ybd493kKZpaIisYcCPUD4+15shZ6I=;
        b=laZiyaAM6uEYmy/eCKkHSgVYCSdnT0JLYOgu3ElrT97wwDo5c7kQqh28crrtvJuXjD
         VaL8fGQXvBPYcNsYnn5xtp9VhIe2ANRZ8oxebYQzIOj340tbJWIjy3OwUpZc9j0Swzlj
         a/Mu1HBdo6NxAXt7yUZr7uC1NZBdKxyyKZyoZwVMairif30LaVMB5D0uH6XSxIRdOIuR
         IoprPjQ3bZ78Y/DZ+rGm4YYqFl6J+3e6L/65J/Fc0mYvYeUag4O9zTYrndtNkY79Jt39
         KNmXW5uiuCLFNO3xVzeCGQUF9E4cza1lUl71mm5/tFDGqqo1qyX0tVlJ3RbeNvFUaJV3
         bhyA==
X-Gm-Message-State: AAQBX9fyp/vigZUa+gJPQ16J+Hhq7C2DlUCIg/2xfeFMtpGPzK6Eo4iP
	7oo0CwjemvY/bfbr8n2tOrASka89aDHa9A5vnzzTlxhfRtM4DTB7wN4kgoAFGUOyzZGGtqerF4s
	vjPVa//5ftJXjHJQMftur+b9weRe1qdCvgLX6u29SE+A=
X-Received: by 2002:a1f:94c2:0:b0:43b:ce2e:89f5 with SMTP id w185-20020a1f94c2000000b0043bce2e89f5mr2261074vkd.3.1679944454159;
        Mon, 27 Mar 2023 12:14:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350aGKl8HZ9Z+eVtu17x45GHcnHGj0XkMhWL6GbKsINsyHYa99P9v4nA7zglNqeZf26tAGq2BMEqDU9BNf47/tIc=
X-Received: by 2002:a1f:94c2:0:b0:43b:ce2e:89f5 with SMTP id
 w185-20020a1f94c2000000b0043bce2e89f5mr2261057vkd.3.1679944453861; Mon, 27
 Mar 2023 12:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230327054838.67353-1-kch@nvidia.com> <20230327054838.67353-2-kch@nvidia.com>
In-Reply-To: <20230327054838.67353-2-kch@nvidia.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 27 Mar 2023 20:13:58 +0100
Message-ID: <CAOgh=Fx3e0M=oRhJ8m_-doRjs2nGfVNVGKq2Z7YsOgz+z34g0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-apple: return directly instead of else
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, asahi@lists.linux.dev, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_121417_229380_4D3E18CE 
X-CRM114-Status: GOOD (  17.72  )
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

On Mon, 27 Mar 2023 at 06:55, Chaitanya Kulkarni <kch@nvidia.com> wrote:
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
> index 942a3b71a6d5..33601494ae50 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -217,8 +217,8 @@ static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
>  {
>         if (q->is_adminq)
>                 return APPLE_NVME_AQ_DEPTH;
> -       else
> -               return APPLE_ANS_MAX_QUEUE_DEPTH;
> +
> +       return APPLE_ANS_MAX_QUEUE_DEPTH;
>  }
>
>  static void apple_nvme_rtkit_crashed(void *cookie)
> --
> 2.29.0
>
>


