Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E0C25B78
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=; b=WRDoRVVWsmLeqfre0QpR2+wVc8
	qvWXbcyQISzarnXAfe8xkrVPBot4K0uS53BeB6EM4x7pz2V1WyGrGbIeZFXqT+8bvhz2/9/FfbSjE
	gmb4ANOdrS+PlCw/aTHTmBSlLHB2L2eBT5Lt1eokjDCvsVA5bq5i8jjoB6GKNroRgB3YlLHsxNqCX
	lU48PKYwN+NHnB9YNPp8Hz4e49jyoUSGYwJAAYZInX6IPEw0+Q78/N4nbFRV9E4I/eOrtp5tWoYHW
	hN6FVn6ptryDejkVKbFkBZDcevL5Bv3uCTmgvHWjD0MrRweIDsOrk6Cd5mZwipJp6XZpdZU7rrgmH
	IJRUAqlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVO4-00000002mfl-2BGS;
	Tue, 04 Jun 2024 14:43:44 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVO1-00000002meO-3glN
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 14:43:43 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso2823390e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1717512218; x=1718117018; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=t4C59PwMcjQ5jFyDAifvsFLctOdoYY1P3EcpHGBbFUbEU2CTXATt0jzyl5VHipQL2Z
         LFHPorXwy63XzMbLqfQZWaP0Zj+AQ204koSbAbk+cR3/wJO2nb9rYVt2fFnQElUSmqKD
         wqdENN5ysQPm/ElDanDeMVnA54NSLnUHyRG8Fn7JciUuEbvCBCP33wyC8ZFxZ0T5LJqx
         7qeQhtkBy3YcR2ZIksycaRWZJsdyPF/xg3tlaCv1TxUy0Sm/QIzApJUmfQU8qyicp/ng
         xU8hO4QdFpF08aHV4nRaxJRReDP/FyWco8ULUPc+ISBHBBmteLAYHIDfO2rF0CXnAj+F
         8WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512218; x=1718117018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=vLOCsJ79mN4VYzaWqMd06KcByzYH08lljR8hF1XG07qpfmEE7YS0KJOcrrIgQ658BX
         PVUAuPH713SecUQ5RhbrFr8eZpPYrWLhrlRbYlnGRj0foY1tyEe+jSbvqDcnshREuvBK
         TyCw9pq54KLXhJWw57BQvnvXhnRP6uWe8ITgu/LprOOrG8tVqgdMrrd8CxIuNb8yVqus
         7jOfqB5DVVoqKI9FK5aLnMwSCwNd1PYbSU+kXEJfZlLVaPFmJLyeVPhAnjHKRUeLmh5T
         B8rpjEgDWhVrYsNsVowASvG52ahbko9Yng1DmHgs3yYX7mj6LrcRGqFiK9IyUe/gdh0C
         lfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzgsuAGonRG6H4du2WhIfMUy+PqUKUT9lt+mG9Wutf4TOR1rZdHhp8YduRmSTXkA9I7gV+T/Ek4vCX+nt8mB0MoYmGmLPntswbmO5+IbY=
X-Gm-Message-State: AOJu0Ywy6upHzgONicPBqYUq/RKTmcLroAbfazNBtKg5qqmAG7dTPfe/
	IQz+Z0zlG+MKEvKZ2QJo6Ocpnnlj6mg6jlFl+nokqJVxVmm5Cw+adLdZYPadtfE=
X-Google-Smtp-Source: AGHT+IE7Xgjew2+pYIorgscT+zEtC6CiHfD7k5h5SBbUKiV5TVIkUTo4RiJEiP56EYmy6Bj8NTlM6Q==
X-Received: by 2002:a05:6512:1152:b0:52b:9c8a:735a with SMTP id 2adb3069b0e04-52b9c8a74fcmr3991508e87.40.1717512218053;
        Tue, 04 Jun 2024 07:43:38 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6522d405sm3599992a12.1.2024.06.04.07.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:43:37 -0700 (PDT)
Message-ID: <c117893f-865a-4fdf-a480-705c31a72ee3@linbit.com>
Date: Tue, 4 Jun 2024 16:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drbd: use sendpages_ok() instead of sendpage_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-4-ofir.gal@volumez.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20240530142417.146696-4-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_074342_265177_A6AD0FCA 
X-CRM114-Status: GOOD (  19.33  )
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

Am 30.05.24 um 16:24 schrieb Ofir Gal:
> Currently _drbd_send_page() use sendpage_ok() in order to enable
> MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
> may represent contiguous pages.
> 
> MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
> pages it sends with sendpage_ok().
> 
> When _drbd_send_page() sends an iterator that the first page is
> sendable, but one of the other pages isn't skb_splice_from_iter() warns
> and aborts the data transfer.
> 
> Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
> solves the issue.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>  drivers/block/drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 113b441d4d36..a5dbbf6cce23 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -1550,7 +1550,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
>  	 * put_page(); and would cause either a VM_BUG directly, or
>  	 * __page_cache_release a page that would actually still be referenced
>  	 * by someone, leading to some obscure delayed Oops somewhere else. */
> -	if (!drbd_disable_sendpage && sendpage_ok(page))
> +	if (!drbd_disable_sendpage && sendpages_ok(page, len, offset))
>  		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
>  
>  	drbd_update_congested(peer_device->connection);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

