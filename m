Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64518C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cYWoYM3Mvlmez0qac6WP7WqjUCd72g9oZuwbz0tyju4=; b=42nXyKc2H97f/67hQb6E2Eovgm
	RgcELRfG0G7BRVG1O/dG7imMmFwQsQKuTulRXHzYIRkvNmA1hms7fpDeHzRRGwjPq63eTKxI7OFG4
	MJ1F18X3ZKcDbDkM9Hl2M2To7Zh+VoU2uDc/Shicc5UsBHmSA/C+uL1XxbhjEjSXEltag7liscz2v
	9sUfsoxVlWYOVbxxNJadJUCLc1/UulfeopRAPHhRtPyZLbjiOpciJQ7YWFc4MVteK7BilgPzq+lmz
	p/xi6EuqPpkg8PBQX6tYb8U6EwdKHZP9+l8vzuZTFt3ArOv4ozI3a3nmeMSkfYQhEvgLcgVbhBjdc
	Der+HmhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCG1-00AS9U-04;
	Mon, 18 Dec 2023 11:58:01 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCFx-00AS3Q-0H
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:57:59 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3366047d9a8so254853f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 03:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900673; x=1703505473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYWoYM3Mvlmez0qac6WP7WqjUCd72g9oZuwbz0tyju4=;
        b=R+6DvUkHlJAxeGjmxwf5SylbXYPMQiSXhhQo7q9U/GpLa07ze77wDfi5WbEhV3ebFj
         5ErwPd78ICJMOEbSkND4BLEOBPmFmajdwOYTepsoVjGRiZ2gQluEHgn4fqxSk6mzQ6v3
         Zdk8pZ5LNjnUhXm84Vhnd/Zz8+WJkVQlOp26NtGKTyQzOCtWqRBwNPQB3GQ6TPRUTU3P
         Onq9/F30fKbmsC4HHgAswOcQPl8+ezVYWW6oaI2W0eK6KalvExpNTd+5FhFkgJX+M35I
         KzFM3YKXCJ2n4qFPAsvvgZJUQsaxLB/epep6I8AE8qF2Y6tqybe7702rHPBSybSBVeUK
         DHqg==
X-Gm-Message-State: AOJu0Yw3JQz/jzdpJbIBUZ1liImsoblJzN3p5TQ3odprVWiyTU7AMYPZ
	oMp7MmBp0BpNKe3euD/O7TcQQYvWbDs=
X-Google-Smtp-Source: AGHT+IEnBuzehXCEdENokl3eOpMigTZtfOOyfx+3xmi6SZcuD+5XgE4C3F+3woSa8EULj4c3he49+g==
X-Received: by 2002:a5d:5888:0:b0:333:4d89:f73f with SMTP id n8-20020a5d5888000000b003334d89f73fmr18925472wrf.5.1702900673008;
        Mon, 18 Dec 2023 03:57:53 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033668993237sm2396484wrx.49.2023.12.18.03.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:57:52 -0800 (PST)
Message-ID: <b1d2b392-f6a5-4eb4-bc44-d2850c934e8c@grimberg.me>
Date: Mon, 18 Dec 2023 13:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] nvmet: rdma: utilize ib_device capability for
 setting max_queue_size
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
 <1702897533-49685-3-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702897533-49685-3-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_035757_134451_0C50E75E 
X-CRM114-Status: GOOD (  16.53  )
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


> Respond with the smaller value between 1024 and the ib_device's
> max_qp_wr as the RDMA max queue size.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/rdma.c | 7 ++++++-
>   include/linux/nvme-rdma.h  | 2 ++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 8a728c5..c3884dd 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -2002,7 +2002,12 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
>   
>   static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_sq *nvmet_sq)
>   {
> -	return NVME_RDMA_MAX_QUEUE_SIZE;
> +	struct nvmet_rdma_queue *queue =
> +		container_of(nvmet_sq, struct nvmet_rdma_queue, nvme_sq);
> +	int max_qp_wr = queue->dev->device->attrs.max_qp_wr;
> +
> +	return (u16)min_t(int, NVMET_QUEUE_SIZE,
> +			  max_qp_wr / (NVME_RDMA_SEND_WR_FACTOR + 1));
>   }

Should be folded to prev patch

>   
>   static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> index 4dd7e6f..c19858b 100644
> --- a/include/linux/nvme-rdma.h
> +++ b/include/linux/nvme-rdma.h
> @@ -8,6 +8,8 @@
>   
>   #define NVME_RDMA_MAX_QUEUE_SIZE	128
>   
> +#define NVME_RDMA_SEND_WR_FACTOR 3  /* MR, SEND, INV */
> +
>   enum nvme_rdma_cm_fmt {
>   	NVME_RDMA_CM_FMT_1_0 = 0x0,
>   };

