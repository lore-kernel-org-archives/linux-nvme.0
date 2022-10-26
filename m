Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAE9C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8OuWhWTANesBuaVz9a5G8CeCa16HNfzUwXxQUSd7rH4=; b=SEWBuH/MfJioLW+0s/eDlbn191
	+CSNcg0qP+ypBcP7s0l9HMZdo4jw2tIeeaq4mWfNYQpKR2uuWBmMYggruBgM6XYw8qQh34VQ8HBd7
	eTjmZJAZBhaqDz4EA0vkblYh6JZ12eOTy0rSCvv8gyfn6AZY5kK0RlvmVleucScoqL5xinDj3GMCd
	i9b2ikEDmpqBelx18afa3tPngrdjvvje36zlBCwFtcrIUewtSl9VNJc2Y7Bzn0r7k7mW7gq/mgRy+
	gtbxwWAhfXXyjMlrznQjscSX8wbR3VvQQnjndODz6QSH12iBz+k6eVvzoNs9qNsbed7XoAsacipFS
	jdGkrPSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfqf-009H7U-Fx; Wed, 26 Oct 2022 12:49:33 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfqK-009GwE-Ev
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:49:13 +0000
Received: by mail-wr1-f52.google.com with SMTP id bk15so26126228wrb.13
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OuWhWTANesBuaVz9a5G8CeCa16HNfzUwXxQUSd7rH4=;
        b=W56B3L2YFGDUwzFQV70IkuMjkG3Qa7Auzm/OCXh2NZ6cSg8CsPg2MzpIL0AhXf2KE8
         IR0FtadvQQeVFBjDaLJ2exiNJDEarvAjp2MVO+404nPWIXjOlxpFWjEj8T5D/30Tm8XN
         uGPgB+OmctCW9/8xLNV5pZCkxAka/BuhSKC/8CAkZDr5T2guRCIRwsx/ZvrMMc/YoFZY
         FKjm+X+8m49D/dLL7d7+c3lTHTURGJZbE7HSPpc7HQexdvNDJNIxIek6TbmBSAUhsFsG
         iIbGw42Q2bav6jQRqwjvHYmiePLhher7/Ccyb20zapSgEzHV460Bjj0qI5+u1a3xfGjG
         AW7Q==
X-Gm-Message-State: ACrzQf3z7P8C1J2nEt0TFx2UaXmYjF3ottKWnXvBV/OImnh0V5FRtXSn
	sTaVbMc88YKnUereblagros=
X-Google-Smtp-Source: AMsMyM6unar3omaVFyALulU/QQJJuXjmpkKZLYF8CSt1Q78QYL7KykC0lEZMXqQdlGZJ0uiWcq1yiA==
X-Received: by 2002:a5d:6d06:0:b0:232:b56c:e5c3 with SMTP id e6-20020a5d6d06000000b00232b56ce5c3mr27511859wrq.506.1666788548517;
        Wed, 26 Oct 2022 05:49:08 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4c90000000b0022afcc11f65sm5329244wrs.47.2022.10.26.05.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:49:07 -0700 (PDT)
Message-ID: <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
Date: Wed, 26 Oct 2022 15:49:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/17] nvme-pci: don't warn about the lack of I/O queues
 for admin controllers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_054912_544950_E091F057 
X-CRM114-Status: GOOD (  17.27  )
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


> Admin controllers never have I/O queues, so don't warn about that fact.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 51513d263d77a..ec034d4dd9eff 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2917,7 +2917,8 @@ static void nvme_reset_work(struct work_struct *work)
>   			nvme_dbbuf_set(dev);
>   			nvme_unfreeze(&dev->ctrl);
>   		} else {
> -			dev_warn(dev->ctrl.device, "IO queues lost\n");
> +			if (dev->ctrl.cntrltype != NVME_CTRL_ADMIN)
> +				dev_warn(dev->ctrl.device, "IO queues lost\n");

I have a feeling that we have quite a few other messages that are
irrelevant for admin controllers. And I wander what device you have that
presents an admin controller, but looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

