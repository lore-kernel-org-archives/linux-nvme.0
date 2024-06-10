Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B59C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPxDOJtBGiXCEwsNw0PSamD2lxZ6+BuGL88bRkvKmGc=; b=0MW29J3ikQwpmXaK0VUzarkHOo
	//JWlTaA8XKInNyC0TY1Xk0wdCm9LYnyPxv1sXaPYCI6CpKdiVbRiv2y4DYkFYOVXpOr9wCcWjYU8
	+gK41H/uix5UTuvPpAtwenAl9LftxXX3h5x//14tF7RGnOr6tJanY++7i53LUMxPWTuMUvQSFj93T
	U88ogZ7JCRBeWIQ8CjoXJOLMAtxi+3qAAOd+oXu3PCob5OmRIOCQTgI/2D+5okSWsqmOGRBis4Yc2
	rvldPpEHNNpiFS4GAe2IOS7at43Dy0DBWIirFqg4lpCCX1ACgS67S8j8i862VdL1dEKlZPUVliEe+
	ROQFZ7Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbty-00000004Z6e-0aWr;
	Mon, 10 Jun 2024 10:05:22 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbtu-00000004Z62-2DeA
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 10:05:19 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42181803bf2so456125e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 03:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013916; x=1718618716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPxDOJtBGiXCEwsNw0PSamD2lxZ6+BuGL88bRkvKmGc=;
        b=Q3Q1L7oaTAnaEcSe8lZ5BjFd39CchZyTWSiLJyY4E+I/5XHugP6FUowxnNH+2FJgdO
         nZkaQ0cWaS5P5eoMKlI18I0SfwKEHu+KOx83KSrzjRMKKobYqP4R5D5LsywXOGqlRMgz
         lCYCGXmgRwt8u51Kh1zxnrpTZcsWmzeE7rzESQ3ucoFf0kaGbYhTy0TAXgZdkepEvJIE
         eqoXHN98ojwihljN8fE8QmmgLkY9XCZAz54Wy+lb/s4FHtDAwgiDlHTC339uGqPTegLT
         71cboRZRvmgqY6eTXu9ehzXaO+krFij8ljK1OTvYKeJE3focqfMxTGjNWSFXtgNeZKJ9
         gPXg==
X-Forwarded-Encrypted: i=1; AJvYcCW7088vgduNo0VcANAi1a7QD/xPIzFx/TpdZMV8B+PCeImM/vTj+IidmtcZ0SaqbEoWKCIddCpwemKAbbXt6GbRrUoUE204lTvcBp9K7Wo=
X-Gm-Message-State: AOJu0YxWiPEzR1RWPSb2mt551Ehu7FTN3ubZywG86NqmAkvly9KD3jZ9
	9IfmevG5VaQSf2zYjcGbMdJvW7O//chc99VhcQbAj4/TkSjFYSNl
X-Google-Smtp-Source: AGHT+IE6UPZS8bKWfPcSCEvXL5Mn6tb7fajf/wnPYc9kjt0FZaI/nNLOOovqnumfJenKH3vEDaiJTA==
X-Received: by 2002:a05:600c:5129:b0:420:29dd:84e2 with SMTP id 5b1f17b1804b1-42164a2a8c7mr63035595e9.2.1718013916264;
        Mon, 10 Jun 2024 03:05:16 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7cbsm171616535e9.39.2024.06.10.03.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:05:15 -0700 (PDT)
Message-ID: <5efdb532-2589-4327-9eb7-cfa0a40ed000@grimberg.me>
Date: Mon, 10 Jun 2024 13:05:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] net: introduce helper sendpages_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240606161219.2745817-1-ofir.gal@volumez.com>
 <20240606161219.2745817-2-ofir.gal@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240606161219.2745817-2-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_030518_605037_940BA4E8 
X-CRM114-Status: GOOD (  23.51  )
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



On 06/06/2024 19:12, Ofir Gal wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   include/linux/net.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 688320b79fcc..421a6b5b9ad1 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -322,6 +322,28 @@ static inline bool sendpage_ok(struct page *page)
>   	return !PageSlab(page) && page_count(page) >= 1;
>   }
>   
> +/*
> + * Check sendpage_ok on contiguous pages.
> + */
> +static inline bool sendpages_ok(struct page *page, size_t len, size_t offset)
> +{
> +	struct page *p;
> +	size_t count;
> +
> +	p = page + (offset >> PAGE_SHIFT);
> +
> +	count = 0;

Assignment can move to the declaration.

> +	while (count < len) {
> +		if (!sendpage_ok(p))
> +			return false;
> +
> +		p++;
> +		count += PAGE_SIZE;
> +	}
> +
> +	return true;
> +}
> +
>   int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
>   		   size_t num, size_t len);
>   int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

