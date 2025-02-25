Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D279CC021BC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nFvercYRlsaQmbbEmex586DDS54p3SFZRkpRH2olSTU=; b=XaXheN1Co6/TmlvO19n9Zkzzdt
	NzqMdcMOd7ceK4leoiX0b3S3U2/yukRPyrp9OLKluLTvVKZiGeRbkGDGq0ublrH0906ajynU4O9ye
	KrUYfxDjE4K7LLcoEse6IJwCeJ/As08OpkWf6x1+qSYNWgVgyTMrUi1D/fTBbHOf1wT65h4/QmlXQ
	TXdR5wH2OfY9UiSN5nd6vD2QH0zHCE5wPH4JkeWOKYl1pW+WEavE/Lc/OOjjAOEdmt4SSgNLcBzmt
	kR/1pATHHpfxtgAV6QsapVntf+HP0+8qIT0FPbkND19z8HUFYzMTE9xJvqYHGV4+UXJ2Uajg/6/su
	4NZWl5oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmseL-0000000GvdA-0a4G;
	Tue, 25 Feb 2025 10:58:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tms6A-0000000GoKY-2sMn
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 10:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740479013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFvercYRlsaQmbbEmex586DDS54p3SFZRkpRH2olSTU=;
	b=f8Qfom2GnJ3Vkhe+bNjPjBhKXN3hfLicacATPGEQAbrRXlvVTFIdagHv8PA1hs05dFZEAS
	HAyW/kIl2oPkKAI5HX3HHrImfe9vY+HDhJT6Id1YJXh3utnkfTTXDwcQusXcj7DtXP0ujv
	F6ZN3EjdlM4Bw8Y5SVRBq+h1ja+Dn/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-lfiZD22XPWmJqPX1KDKvWQ-1; Tue, 25 Feb 2025 05:23:32 -0500
X-MC-Unique: lfiZD22XPWmJqPX1KDKvWQ-1
X-Mimecast-MFC-AGG-ID: lfiZD22XPWmJqPX1KDKvWQ_1740479011
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2f438fb6so6588540f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 02:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479011; x=1741083811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFvercYRlsaQmbbEmex586DDS54p3SFZRkpRH2olSTU=;
        b=CGZifkopGi1UAzAV6JPp7OtX5GplsbtkWw/zcC/InJDOm8AE6OH+9+XbdVltCRMv8i
         PKNGh2XKk78j2bdS+xWx6zE/huDVD2IWiGwNYEnIvQ+CEeYpR6A3fn4Mk7Rhfed4u0dG
         +TgCYq7kqRZXjWGE55jYcu214KgR18fAO0i4va9c52xVvcoW453rTLn6SxJvrVdqNqqe
         1OMNQ8fTPwbV31HGjdvkQB/zB1xe7ZJYYSahfMrZ7o/U2Sx1AJlGblkJDYvFSZkuxYEk
         Hf5puLDAAYPjrR+4Ev+zlijAfLvRNuEjZf9SzYIsBcBH6IFiGmPBAqkv2BoHb0roHp/R
         Hn0g==
X-Forwarded-Encrypted: i=1; AJvYcCUPQUHmG71LWXGjYIFL2soh2AuEpivy0nxXPmLx2D9nTLP79tIlaVfhM5yclxruO2Y/bjcOYV+8u9l9@lists.infradead.org
X-Gm-Message-State: AOJu0YyTq6Yukg+DcTm2tMuQIi6QUYAxxMo0OO9hfDD2K67+kxfq5J0E
	XojGgL24Tl9HWOQV8tjYUPFoEyGEuATvLYS6zGJk1Bz/Jn03EgITL+pu/WW/nj8G3gKEERj63Od
	8rIlbpKA3LAQz831CLlnvKhfiXpEBx/U1Rfx5OLm0LoD/VmXTDdjXf9zbQVe4ObdZ
X-Gm-Gg: ASbGnctvTa2otsORjfP9BVkQLW6RyDCoOJg+kNp+N75C+/9nOjynpHTtwjac55wXzZd
	V8tbf0i6LyoZT0nwptZZc8JPvrg2qsvJPI1M7utTphpSbW1WecKm326vErTqWmTY1Ii3oFrvoo8
	niAwlR6xIDS/53+z+ChcoNknpEcOEeVfuXtymU5GIKvF8FK3wb/w+eSvLH8GOxYB5RCz0fX7XLQ
	skVj21X3Wk/ZQ40/1SNEZw6g8M0kQ1rnAHPtrz7WAQn61PGnK5Ci7cyxaL0zQd73er8op6AGFAm
	Gpx+6jJ6LgGGz1kYkVPn9dgqVRVzIEqYhDk4PYmRtSk=
X-Received: by 2002:a5d:6d8c:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-390cc5f573emr2347335f8f.8.1740479010965;
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4JZUAibWUrdhy9yrIVRgWtK2z4/VkN+tAG5NwhKKNfEC0TXMFvvpKpTwouW0wrrU1Rw5vw==
X-Received: by 2002:a5d:6d8c:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-390cc5f573emr2347296f8f.8.1740479010610;
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532f20sm21118625e9.8.2025.02.25.02.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:23:30 -0800 (PST)
Message-ID: <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
Date: Tue, 25 Feb 2025 11:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-2-aaptel@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-2-aaptel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aEKBwndyy1q9qPcZYpA7TLkh_sGzsXy3Ql0aRRhWnIs_1740479011
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_022334_811550_6699EB04 
X-CRM114-Status: GOOD (  15.01  )
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

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops)
> +{
> +	int ret;
> +
> +	/* put in ulp_ddp_sk_del() */
> +	dev_hold(netdev);

You should use netdev_hold()/netdev_put() instead, with a paired reftracker.

> +
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
> +	if (ret) {
> +		dev_put(netdev);
> +		return ret;
> +	}
> +
> +	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
> +
> +void ulp_ddp_sk_del(struct net_device *netdev,
> +		    struct sock *sk)
> +{
> +	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
> +	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
> +	dev_put(netdev);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
> +
> +bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
> +{
> +	struct ulp_ddp_dev_caps caps;
> +
> +	if (!netdev->netdev_ops->ulp_ddp_ops)
> +		return false;
> +	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
> +	return test_bit(cap_bit_nr, caps.active);
> +}
> +EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index fbb67a098543..771720c6e0da 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5474,6 +5474,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  
>  		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  		skb_copy_decrypted(nskb, skb);
> +		skb_copy_no_condense(nskb, skb);
> +		skb_copy_ulp_crc(nskb, skb);
>  		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>  		if (list)
>  			__skb_queue_before(list, skb, nskb);
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 2308665b51c5..bcb8055bbb0f 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -346,6 +346,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  
>  	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>  	flush |= skb_cmp_decrypted(p, skb);
> +	flush |= skb_is_ulp_crc(p) != skb_is_ulp_crc(skb);

Possibly a `skb_cmp_ulp_crc()` helper would be cleaner.

Thanks,

Paolo


