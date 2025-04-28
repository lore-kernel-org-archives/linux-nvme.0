Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BC6C3ABA3
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DsJw2lvYwiq12LP4zFq0KdvgXLOSONLU5r9+iJsiPhk=; b=mVQZIbXsDVImJZbC+KYYBUFvOA
	+n5ML7U807HeObYqWSFXBf4xlEwLDu/sCuzI0QAGhxIWc2chr09+VzqHZVpv6RelsR8xSF1xfX2Jq
	G/bCcnyGpictBgD/DJhQz/DG0aJGukbK/Rlld/K+oQWL9YSeF2EUblc74W82HcaFxS1YXQBiY2xJs
	RK/z7hX/iTpNDUuq8J4eJ5EJMw1AdzHTyI6TpPabQU9rQNAyky8+PQoasOuX73mnvpqA1JoGdNJFV
	crqY3FbBQvZDcmCsyH/pQhcHi8+CPEEDlLziDCO3iapoPPYQeJTuuOSmYqb5H3kQHpKLGd6eP0qFd
	GBWDRoHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9N3U-0000000630t-1DM8;
	Mon, 28 Apr 2025 11:53:48 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9MbE-00000005wlI-1eWV
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 11:24:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso41608945e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 04:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745839471; x=1746444271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsJw2lvYwiq12LP4zFq0KdvgXLOSONLU5r9+iJsiPhk=;
        b=XEJWpB4MKWVz+Wrh5B5u4xFNNChT/sUwT9ifiqNcj/v7gLoaNBX8CsiOImtP6Ld0BE
         WopEzvdqbP0tN+IS4O68wSUulXPf4ao7uQl8exKEC8tk5WsrhEdKnEoEYi7GMYLWPPb3
         5PpSe/WpI+XoWSeo2vjvdMMOcCL6LyTkbrsOfwAGPtX5lC8d75pVEjaRuiDlTMFAr2Rf
         0e0elGwO84Rs9IMSYrrZ20P/E/4UxSX8kmFQl+C9e1hh+LmxZ79pxMAm1ouXV0YA7mUC
         6tjRA67ZqXdFfY9Tyfw59SLsEy+EjCzeEzP7DDBDKv6OQToqHRhlvdxprIKU1gYVZq5B
         4ETQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3RcIREsr4BYLdUKIXcgl8KPnsnLgDBHSKnStkj2EbNWmjw4S4FfQn/70JXB7S4c0LfWj+dtymIyZ7@lists.infradead.org
X-Gm-Message-State: AOJu0YzxCqJItzl8GyGgwYtzx4Ldjh3JhSLnj2uZhXC5BnXv+2vAwn1u
	iovlN2odpSvPBTJkdkEQNFILHuOj/B3uT5RyLXZE+oOU5RSY2F/8X6PHqA==
X-Gm-Gg: ASbGncuBtOYE49EB0tpwR8Y/+0Hr2R363Hy16cHQzTVmveVFoU9esWT0QsykcFXGOvc
	ACh+MLOQNiipLqGRZ4kiI5H89qOikAqgqavpGTrDuaa0ndTZSqeNTFkksFRHh6dpzpGBSlpxpAL
	GGOouGznqTx/i43XaKYt5Zf9DQZoXAWf6SNxx74MLWDRRoFAfzAOwJ1RLo3NTl4Y32bP0A4rzsX
	z4CFuvu8gul/Aw/IgpuxGKtfFhuEQUS7QmLVsZXqMK9zfol8QUBZ6oj3R8tfAa6V12jwuDRgYVh
	JmIXzDks62WqwZQ0oDGjwtRrFFS6B/XsxgVW8Kx7CtFx2jZkB7fTzcw6InmqUKIE57FiPhlbTe4
	XAUEg8Q==
X-Google-Smtp-Source: AGHT+IGKQ+nEam+7sy5gS+XmIKJ0n53OYiBcSMynw7r6xFSsTHyrkN28r+AYnRu0KSu6tlQJIMuzoQ==
X-Received: by 2002:a05:600c:3b1d:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-440ab845efdmr43812385e9.20.1745839471278;
        Mon, 28 Apr 2025 04:24:31 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530f6e6sm120205355e9.17.2025.04.28.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 04:24:30 -0700 (PDT)
Message-ID: <b1bab4bb-c957-4020-8ddf-2f430124e7b6@grimberg.me>
Date: Mon, 28 Apr 2025 14:24:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Kamaljit Singh <kamaljit.singh@wdc.com>, Chris Leech <cleech@redhat.com>
References: <20250428065040.32663-1-hare@kernel.org>
 <20250428065040.32663-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250428065040.32663-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_042436_435502_9D3B6D43 
X-CRM114-Status: GOOD (  18.53  )
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



On 28/04/2025 9:50, Hannes Reinecke wrote:
> When the socket is busy processing nvme_tcp_try_recv() might
> return -EAGAIN, but this doesn't automatically imply that
> the sending side is blocked, too.
> So check if there are pending requests once nvme_tcp_try_recv()
> returns -EAGAIN and continue with the sending loop to avoid
> I/O stalls.
>
> Acked-by: Chris Leech <cleech@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 10ccd7cf5b8c..5c73af022273 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1363,7 +1363,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	queue->nr_cqe = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>   	release_sock(sk);
> -	return consumed;
> +	return consumed == -EAGAIN ? 0 : consumed;
>   }
>   
>   static void nvme_tcp_io_work(struct work_struct *w)
> @@ -1391,6 +1391,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		else if (unlikely(result < 0))
>   			return;
>   
> +		/* did we get some space after spending time in recv? */
> +		if (nvme_tcp_queue_has_pending(queue) &&
> +		    sk_stream_is_writeable(queue->sock->sk))
> +			pending = true;
> +
>   		if (!pending || !queue->rd_enabled)
>   			return;
>   

Looks fine,

Need Kamaljit to verify it.

