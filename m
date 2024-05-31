Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BCC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FW4G8B4caU0ie3GvcsCDqWy2GOMbEDVFmUW+vM3YSGY=; b=JZsDX2jc2wds4g5f6DTuz7LcmE
	X4xuXxLD27T1BKSi8bP/PUbZx0O6+XNa+U5pd5I1jr2tGOMRad5OA8zHy3kp0gbbjKaf/uQ+7i/hv
	3VlDUgOL17MxDjveK4gMWRJavT/TPyFDfYJAslIkonPLZvpBjgMGRItNZYm0jnGfjTf42+f/vI8b4
	1eXSDESxelNdenfnioJ98WU0qC3sHiSrH3GzBCIaxBg0ZOmhd8qyobBz7YZFRYYa2nu+ikWrrA1XZ
	+Rd3Yk0y7iusERdxxTRLY5taDQA6cL6t59q/eyAYda9ITnAkpoqIM/NfvVkv0Djx8+SnrK2BoUZ0C
	Xbw+fLiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxyi-00000009gPT-02aG;
	Fri, 31 May 2024 08:51:12 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxyf-00000009gOb-2JM2
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 08:51:11 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42115de211aso2350415e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 01:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145467; x=1717750267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW4G8B4caU0ie3GvcsCDqWy2GOMbEDVFmUW+vM3YSGY=;
        b=eFFVx7+J0Ar2OqScFFAiGpUcQHGP/1NB9Qwqhte+010AGzkQGDilx25KNg+NWNgKAe
         +gsxv+s7kwdy+5YfDdzmmVS9B5KltnH1v9o8Y1YIB5LbcIE77TGzu2+SQ0f2+6Nd0BfN
         vjeIxEWr5+46/v65uMJc7FTRQRami7ADdZWpjFVsYWU+TAC48UsqDYgEyBJJuiEQM5KL
         WQhPLkBLh77POay/7GyDc/+u0dILVu1bUONzmHDGUjP3tbA7Lj8MjznP5hneEHr38Y8u
         JdON3yzmpj+4cKdkSv+PxxxaugzzUYqwAaS/2O5YB6lMukl8d0Ir7b4kcfRmZ9dkQp8c
         KPZA==
X-Forwarded-Encrypted: i=1; AJvYcCUmnrH3oMGe1ejBEgDlR/jpEgWqT62CfFTDn7KcnhwMyD1FI9ry2Ss6hlRsyiW6fByhnihSN+StpLAUU4nKHt46A0NZ0rdH5ytrtLCr2Cg=
X-Gm-Message-State: AOJu0YzqtDBCJinJ6Ppvkf0JFaVkWnt5j8mykVCfC47otkbxVrbfO4/f
	n+GWPE1lP2EpxuPI3IH3jmZkciKiWJXEkB3Udw2Hg8skrw3dkI3Q
X-Google-Smtp-Source: AGHT+IE0qlRpHCk7A3rlMfeWBmqpGsLaF/G7osysiPnBEXojpS8nDJKC0ci0ffQT8IRDohTHpm1cAg==
X-Received: by 2002:adf:f308:0:b0:354:db35:63a9 with SMTP id ffacd0b85a97d-35e0f1af8c1mr944414f8f.0.1717145466515;
        Fri, 31 May 2024 01:51:06 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0a33sm1389227f8f.7.2024.05.31.01.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:51:06 -0700 (PDT)
Message-ID: <8d0c198f-9c15-4a8f-957a-2e4aecddd2e5@grimberg.me>
Date: Fri, 31 May 2024 11:51:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
 idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-2-ofir.gal@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530142417.146696-2-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_015109_689670_90B454BF 
X-CRM114-Status: GOOD (  25.23  )
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



On 30/05/2024 17:24, Ofir Gal wrote:
> Network drivers are using sendpage_ok() to check the first page of an
> iterator in order to disable MSG_SPLICE_PAGES. The iterator can
> represent list of contiguous pages.
>
> When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
> it requires all pages in the iterator to be sendable. Therefore it needs
> to check that each page is sendable.
>
> The patch introduces a helper sendpages_ok(), it returns true if all the
> contiguous pages are sendable.
>
> Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
> this helper to check whether the page list is OK. If the helper does not
> return true, the driver should remove MSG_SPLICE_PAGES flag.
>
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   include/linux/net.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 688320b79fcc..b33bdc3e2031 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -322,6 +322,26 @@ static inline bool sendpage_ok(struct page *page)
>   	return !PageSlab(page) && page_count(page) >= 1;
>   }
>   
> +/*
> + * Check sendpage_ok on contiguous pages.
> + */
> +static inline bool sendpages_ok(struct page *page, size_t len, size_t offset)
> +{
> +	unsigned int pagecount;
> +	size_t page_offset;
> +	int k;
> +
> +	page = page + offset / PAGE_SIZE;
> +	page_offset = offset % PAGE_SIZE;

lets not modify the input page variable.

p = page + offset >> PAGE_SHIFT;
poffset = offset & PAGE_MASK;

> +	pagecount = DIV_ROUND_UP(len + page_offset, PAGE_SIZE);
> +
> +	for (k = 0; k < pagecount; k++)
> +		if (!sendpage_ok(page + k))
> +			return false;

perhaps instead of doing a costly DIV_ROUND_UP for every network send we 
can do:

         count = 0;
         while (count < len) {
                 if (!sendpage_ok(p))
                         return false;
                 page++;
                 count += PAGE_SIZE;
         }

And we can lose page_offset.

It can be done in a number of ways, but we should be able to do it
without the DIV_ROUND_UP...

I still don't understand how a page in the middle of a contiguous range ends
up coming from the slab while others don't.

Ofir, can you please check which condition in sendpage_ok actually fails?

