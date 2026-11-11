Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A7606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jpOwUc6A;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=l5qKiZQ6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tj3GxIxqCdUc9IJQxKZYu3eLGgYe7ecnDezY1yOGQuw=; b=jpOwUc6Af67Hr8tCiRIp+FyuuN
	NqRCUdgiSIgMZCvBgeLiIvrhdwi6i6exwdlBATHBhnBNZ5wZPHls78jgizsvVSWqgPOf7/Z4B5JCx
	Ggg1Iv9mb7AkbN3ZfpoKS5tipuINI80JUejh8BVx5WGpmB4awO5K7D3gEQ6gph8YjHnnEVNiH3ZRm
	iyw3vo+wUaeTCyiXNZ1Z9kB9hbnFFEROno3UnNaC6r7DW4CCoy3XsIWB2sVkQfGRz6FewUDDXRQTl
	HHy2tTjgr+zcZ2GlFCyNL4ch37R++GQCRSeYGNZZndQf4SeLUicvca8bXhm+K03LK6AcMIvgmPwnP
	W8vP6xPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRANz-000000076Jy-2EWA;
	Wed, 11 Nov 2026 15:37:19 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRANw-000000076JN-21l4
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 15:37:17 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-91eb7d147b0so14766556d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2026 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794411435; x=1795016235; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tj3GxIxqCdUc9IJQxKZYu3eLGgYe7ecnDezY1yOGQuw=;
        b=l5qKiZQ60ftNCDsHHuDepHFj0NryQw5O+GjBvryFV25zDvkNjTmY8V5yM4y3l+8GAV
         E7AITD11TSzqxFbxz5gMm3ysN0ZeRR0TEhNJhcRWq2xrtKgHh8e/BxGwYlCE9GQxex/c
         ZI4SKuU07HI+kCb1iBKyR84C3aqqIDdNRF5fYegrhasneaZC/jy6jrTqZgdR82Vtt+rL
         bFWHuUStIM3ynMLIfhn55/JWGRODcNNLc4Vf2hmB0RuZvX5XIv65sKFZZlY2ir7QuWXL
         uQTYZP6f0S0CdBlygLpi15k61YCqs0bmWEiA7jfQmEn/sCGetz5aQYFtor4HNDwMXNBy
         QccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411435; x=1795016235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tj3GxIxqCdUc9IJQxKZYu3eLGgYe7ecnDezY1yOGQuw=;
        b=2GHbdQnMOF9oGyigolJ8Iyp6WsASTPaNgqhT8SBnm+rWYNQK33ZjcZ6brJ4XDSH/S3
         Md7x+ci6+dX3OgB8dL/pFcGGi/BFGr3vUnZOVY2mux43Eq1Xwr9c/tyuz3yqYiGvGsou
         ea4FCZnINoMZ69ojZ9lzBjBi9ybdQizmQ087onQ+cGQjb5HKzLYi7JwSkADELKLWWMj9
         S1IyZlrdZ9CUz+RrD1NDo/KMbHK7G1YCp2zTkzvIEWTinThqICiV22YTyHZpVFxe01tF
         mgK4VGxtqDXGhzwhE3LH9wnQAUa22qngn4iIXbpAtnSNxO7Gl1CIeKNo1/TGnZvEp77o
         ZITQ==
X-Forwarded-Encrypted: i=1; AL+hErGYiJcm8p0sj2JoTNuOSD2Dxnee55Bm0nw87kKQ3IBJ7j4mdIBvvpfDpu4++kBdQ4DkpbAtM/+y/q8T@lists.infradead.org
X-Gm-Message-State: APuU4Z/9lPswOrAfGC5MnacftbPJ02utiNURljYg6phOSOiqL9uAGAdw
	lRikfB1XVccaY+jLqmbvIV5QtJ3Gze4oTbY9TyQIJQCTvYutS0nVJwhrdZiGWZAVg5KmMdeYVOh
	uaZzo
X-Gm-Gg: AYBFou2xwCOMnhGAP1iePKEaWUXLcA27WOuctzZeMErLe/AFdhrsAxyqAdUf713JgLF
	SBHPqFINvUNe2uY6mGUg/4oi7gHYrPMNOfiLEV1wo5N0utvDVhQgXRjqmLphRl5Fu29ns2GRrWe
	vKhdEqi8wBsVuQNtSg1B/C2C8ddjHLgMAYFBeCveKB5CWVwvjVHgJEjfy4XuJRcJ3aSmg+DQNWu
	tBmEXQrHOe106r7Q/aSblj6bmx4TMRyGq3h+oDgFYMGSHe0EGlhDIlgOvTcgXmCcEfJRj76dBYs
	DllJCZ9pVaAZw3Nzf4QelVrlNC6FbZHyJesmcgufgbieKmOBXtQVZ0RTX6upzvdC5kbKDn+HRvl
	2kZSR6xVwYlHItbRemNNcUsnNXoDlUNP9cSKErR5dFxf7fEUztAvAwrxvgeDWcOi0D8Q+zX569G
	MI3lecWh++ofkoqzNEeNTjsUimWw4Tm2a5p5sfv5QJEqleB5udFjZFOS4rAQEo7PbyPGaHWUxbX
	/3Ec1AWrspv48d0BE+QoawrhEs3NB496tCRjGO1HXedW+aYX3dY1gsaCDwe7No9InlxwUF3fJq2
	dQ==
X-Received: by 2002:a05:6214:3d0f:b0:91e:97f7:c7a2 with SMTP id 6a1803df08f44-91f04072c9dmr46236076d6.11.1794411434568;
        Wed, 11 Nov 2026 07:37:14 -0800 (PST)
Received: from ziepe.ca ([99.192.80.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef05493desm49564276d6.45.2026.11.11.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:37:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xRANs-0000000AjhG-2xzE;
	Wed, 11 Nov 2026 11:37:12 -0400
Date: Wed, 11 Nov 2026 11:37:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: Re: [PATCH RFC 2/2] nvmet-rdma: use a separate lockdep class for the
 listening cm_id
Message-ID: <20261111153712.GA2532299@ziepe.ca>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
 <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
 <20261110003243.GS663069@ziepe.ca>
 <avP07JWvBtMboL8k@shinmob>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avP07JWvBtMboL8k@shinmob>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_073716_629097_D46C837E 
X-CRM114-Status: GOOD (  11.57  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 02:01:58PM +0900, Shin'ichiro Kawasaki wrote:

> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 337a49d1acf7..334f39c2f5e5 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -3949,6 +3949,12 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
>  		container_of(id, struct rdma_id_private, id);
>  	int ret;
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	static struct lock_class_key cma_listen_handler_mutex_key;
> +	lockdep_set_class(&id_priv->handler_mutex,
> +			  &cma_listen_handler_mutex_key);
> +#endif
> +

This seems OK, I think we already have examples of this in CM IIRC?

Jason

