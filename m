Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794D1C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8df5SmQnjq9wYyy9SCOHDGb1UYC6Cv+xhSqrA9kdvWI=; b=V6MbXmJQp4FpT0O5Jj1WvPnJbE
	3F+VFtkVoJYDym4H0QBj6bkqbnH/TCQUhncv10S4L+lxAHw3rqc5gaAkQ0FWGdb9b+qYwOAR9luzR
	SmKvQiD9wFDutE5DZolS10GWxUDDLqxosqg+KvaWhX3s8ma8ZgAdgv87JSS/fFT8MUhP0Jzh2rToe
	rM1myPaW0/liao6yiZxs1HYGIVOnZ3GPoGa0YuRewza8sHRctKxvO33DwcdohWxkPtmFJ8qh29KIs
	/70+n1ofwqDZYEfV+R+/Ao5fvXcFQ5iI+d+Dnt0l3vS7MrMsBgCteJplYmIfkrx4LTGchzg+9irZH
	9a/8n3Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz7y-00000008Xbs-1plw;
	Tue, 11 Jun 2024 10:53:22 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz7v-00000008XZX-0RQ8
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 10:53:21 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f0b9a1dd7so480508f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 03:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103194; x=1718707994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8df5SmQnjq9wYyy9SCOHDGb1UYC6Cv+xhSqrA9kdvWI=;
        b=NwAU9Cj05VMfdQPVDEnBNNe7fAYnLV3pz0SX9n4POIUryL4hdROewR174k5+LsuQtU
         pW9F9kp0rDw/JyYmPveK0ohMSkVBJlkjHBh7GgM7zENnGhTgElcugrql8IajV4CK7lW3
         k1U5LsP33q8Hx2N7eKHuJyQDgkfu8sibbZL0oMeiP5LjzYZFr2Kb7Z+n36C/s7j0ihjn
         +oYf9V2fXvENGT1yUHxc9OgoRy+zY9sfmpsNsggYdfH3sDHQbVrzqB5MbU6l9rqT/FpI
         OlFoTJQW0wuxoucR+WDqHVX5kIuXMuWY4an91s3JayZAWagtr1cbtA8g7xlVYxxOg14g
         JYxw==
X-Gm-Message-State: AOJu0Ywj8x1d58+CPY6fNOimLF6M93EHdrEOv74YoTJEr7sWZFQIFCit
	TTek4wdPLtPEFD0KJkq1IedNbnBJ2XGl4extNjbDPLKnvSHd+hNq
X-Google-Smtp-Source: AGHT+IHPMmyzGfHwz8Yi5o8x/EXTxcK21g7guAhqnL8cckLypQIl9x5GJ2gr+/aYeZxLBJMAk/4ZQQ==
X-Received: by 2002:a5d:64e5:0:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-35f2f97ea45mr620932f8f.0.1718103194304;
        Tue, 11 Jun 2024 03:53:14 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1bcbc31bsm7838861f8f.44.2024.06.11.03.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:53:13 -0700 (PDT)
Message-ID: <c6b15807-dc35-453e-b162-982fca77443f@grimberg.me>
Date: Tue, 11 Jun 2024 13:53:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: avoid double free special payload
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org
References: <20240611100208.115211-1-brookxu.cn@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240611100208.115211-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_035319_176615_36BF4353 
X-CRM114-Status: GOOD (  14.76  )
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

Looks reasonable.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


On 11/06/2024 13:02, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> Now we may double free spacial payload for some requests, such as
> discard. This will corrupt the memory and lead to kernel crash. Now we
> will free special payload before retry it. If we disconnect device
> before reconnect success, then we will fail request by
> nvme_fail_nonready_command(), as a result we will double free
> special payload. Here try to fix it, we may can clear RQF_SPECIAL_LOAD
> bit after we cleanup command. This will not broken following clean
> logic of blkmq, as nvme request will not be partial complete.
>
> Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to core layer")
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5d150c62955..c40930d10bd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
>   			clear_bit_unlock(0, &ctrl->discard_page_busy);
>   		else
>   			kfree(bvec_virt(&req->special_vec));
> +		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
>   	}
>   }
>   EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);


