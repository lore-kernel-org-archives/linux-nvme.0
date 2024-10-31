Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B2D767F2
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yx1Qac1de1Zs6DaCXK6vx+CLfs1Hn/NJAOE3KhROYK0=; b=0GRiWIidcwLrbM55roZZK6LNWe
	ZKfxU4zSdP9+31ATbI25YTsLojpVDFx7cZeAhWIXUdDmHC0XFU5l0OdS+llQcNmRxTFz9uK3zDKaD
	qKvyGJl5H5NNKipRRwALcNKnrWxcPIXOiinsQArX/PTdrB4vW9PnPh7+b9o7lN5+truCP4KLlbLtW
	fsm3MX86YlLtMxjosdzMYYIz6p8U9MmCx6wlPsph5CODNNXAm8OwpeTo0qH55IspOUpqLZWhdhjiX
	FwECHZSbnxVnEkaQAh4a/Es+h7ItQfuwkonuJaz+3p9AA9ZWn+EiqaHStPLj82q8HI2GB1zo8QZMd
	Q5Wyc19A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZAt-00000004NNi-29Su;
	Thu, 31 Oct 2024 17:41:35 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZAV-00000004NJj-3yG8
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 17:41:13 +0000
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso4541265ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396470; x=1731001270; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yx1Qac1de1Zs6DaCXK6vx+CLfs1Hn/NJAOE3KhROYK0=;
        b=tCEIb+wXTKC8SuOieDYKSXPCEsjpYR8S5+++E/tC9YOH9FdWTJqKOh+WCOLRcwM116
         ePKRtau8O64UW6fqxFYGo+sjMK77mYlpVDWmJSUWPyJh5bXE4wqR/l22p8I4Ix3iBR0j
         WLTr6OnSEXF4ZsnN4yORPWeMxV+0GZ200YtT2QlpRwpjPbqpO3Fgz+cAIflZcbmEZE71
         JjJUIG2bKrDcAAyPGnJxlJ9bRMmZUE/P0sjjHlU/IPvdEU61wQoVIaXhqdNZPIcy7L9J
         RZMxkwPC0rU6ik127oiuLhRBGmJBJiZeNkeVAIgEFLIwr6QJjG6aGO9r5T4g4frHVP5A
         5g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396470; x=1731001270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx1Qac1de1Zs6DaCXK6vx+CLfs1Hn/NJAOE3KhROYK0=;
        b=CzZq3hvMIgjJT+G8Vqn4kXGRhSwdLU0nQactZYdBK5ywzb4VVQL1IJSdBm8S600UZe
         qtdy1Z1Bd1u/vRUYAi+5T/Wo+9PHoPfEKZiSME8vU9pVKW5NJHRdd2Uhga1JqAXVfRQK
         DbVziS6OdesVYDiF3iRm6YMKHKgAITwZw1TAKry/aTzKAbTepk6NITSkIBLHXLEXBIgu
         C3sWc58TpA32v8beOGjYt9X83YBzJvfrM6S/0WdV27qENVRmAoP7h3Hfb7sGM75ZpAoN
         meNPWiI/QcFW5SQU4FmOpvER86b1urslXLoh6rH8qmSgNiqU4h+jVpCL0E7wusPvXW1/
         qzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYjxYcRg1PlDrPIXYR+tqEbTF1SpIz3ASJY/XGKd+Yf/3nLR29Kd3QtA7a9X1YXpnV7G4NYBiiL4po@lists.infradead.org
X-Gm-Message-State: AOJu0YwTvkTQ92RnbE5kw/iounSthcEu7FuLslF1sMEj/7satkNac00J
	0Xp1aOkAxPrTcuw9v0oFNg86QlIuO5dcAAKOcJN4Ebgj6x8Ku9aAWx+EZErgoII=
X-Google-Smtp-Source: AGHT+IFyXNo+4SkkDpMF9EOTb5M/8YLNvanS4IsBDAEKJMERveCtkiHuWa2Wiv0xiuh0/9TvWImYxQ==
X-Received: by 2002:a92:cd88:0:b0:3a1:a619:203c with SMTP id e9e14a558f8ab-3a5e262e89cmr84852595ab.23.1730396470496;
        Thu, 31 Oct 2024 10:41:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6b073f258sm563215ab.79.2024.10.31.10.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:41:09 -0700 (PDT)
Message-ID: <780facb8-b308-4e11-a7e7-7c258545e9e1@kernel.dk>
Date: Thu, 31 Oct 2024 11:41:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: rdma: Add check for queue in
 nvmet_rdma_cm_handler()
To: George Rurikov <grurikov@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: MrRurikov <grurikov@gmal.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, George Rurikov <g.ryurikov@securitycode.ru>
References: <20241031173327.663-1-grurikov@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031173327.663-1-grurikov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_104112_169397_DA0100A4 
X-CRM114-Status: GOOD (  12.88  )
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

> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1b6264fa5803..becebc95f349 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  		ret = nvmet_rdma_queue_connect(cm_id, event);
>  		break;
>  	case RDMA_CM_EVENT_ESTABLISHED:
> -		nvmet_rdma_queue_established(queue);
> -		break;
> +		if (!queue) {
> +			nvmet_rdma_queue_established(queue);
> +			break;
> +		}

This, and the other hunks, just look like nonsense. Why on earth verify
that the queue is NULL, then not use NULL after that. Let alone that
whatever you pass it into happily dereference it, and now you've also
got fallthrough errors all over the place.

This needs to go back to the drawing board. I'd worry a lot more about
bad code than "potentially malicious hardware", to be honest.

-- 
Jens Axboe

