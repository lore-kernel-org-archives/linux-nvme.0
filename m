Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21E0C38142
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBzVAZuwNKx6fofSwwPJ1BQJATFOj3CkHpKBIqgaMEw=; b=AO+OIRZcl+0W+Zn2J+azgsZYue
	59FK9DS7odnRM9zrPdYLaDGQFndZXnSpORqmZD3ULbiM3rYBdzalLcyUjbLTJjRuLqSTCmCehpX+A
	UVP7UaJhMya7zrMB10lYkKzS3taGVJa72JGV8MYs2sEoSO7yrTw/c/770Z1ZJxh8HVY+2F3DjseHN
	1ZnXLBvORuSopTHWJaxtZC5GZp1vqMTEZCBZqrSoabDaOB6Nk+/GjM1hW3lsF7bG4f2Q97W8qnDMp
	zEJUZPtdVcLHhmWVecqnQ/gdBtEgoDKpikXGiZ371qF7TLJTQ/yZgMGOHhdF4oPu0eLb4w6lsKV7E
	r4F/kYqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pISby-004Vxv-FY; Thu, 19 Jan 2023 10:57:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pISbv-004VwZ-2m
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 10:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674125852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBzVAZuwNKx6fofSwwPJ1BQJATFOj3CkHpKBIqgaMEw=;
	b=QHQgRSfvB5JiNxrnMcIWNPZOqod2EKQYdyBXk/Ws9PjKeb4Pvq0rcmZIbCP/4NZF0or8nj
	L3Ox6FpzRFLy6iWxgXvDuIuHapDGBYL7Xo6Te0A72MvdcJwLbD2c6VnGdc/n7mFNob1ePL
	tDj2AxBPdiwp8ZOp24D5f+bwWDYeNnU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-ybCPjN9zMECL4Ji6xwU6sg-1; Thu, 19 Jan 2023 05:57:31 -0500
X-MC-Unique: ybCPjN9zMECL4Ji6xwU6sg-1
Received: by mail-qk1-f199.google.com with SMTP id bl3-20020a05620a1a8300b0070240ff36a0so1120739qkb.19
        for <linux-nvme@lists.infradead.org>; Thu, 19 Jan 2023 02:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+YxX0wT5arsqEpEVRlF0GTgX6zkshCJMCpK1xpEa/s=;
        b=xd7BL2mvL0SstPDmueq7FdE1Hhmpe3HltDgLLCvov9z2DHkf/kOkqVWfXsvqEwrOV1
         Gqo8r4dH3t6agTDV4KLP60dEv9ttarHThEsHu5JvpBKD0STSC2qSsBVvtvXuQyq079bd
         B3rG5/RytUY2kN1oQ80RoYMWrg4Ca76ukoeEe/8Uq4CwQkJHbMPx1noNozgVsK2A18ff
         WMpb7Qi2UXQPq80NThZxLjiUtcLCYV65BCTkcO1D3ex+08+SKrmByllYiwfWk3Ryg2rU
         ODUp6o9RU9Omj8V1BwFbjDKK/cKzJPbhwoVQaiO1A5vLoRvD8OCGX8jWaEo/Kea/wjCm
         9ZJQ==
X-Gm-Message-State: AFqh2kovesOnNdico7krzvGXA60JRl8goDLS4CXrq4A2TPjaiMFWMCUN
	BlHBm5ox4OubsdU3DY2smA2XiGpjIfAHsexYTJ3LB5YoNiipHnUH0jaMFz0mGJJxAS75rDTbb3k
	zB4E76E+npyfclbjTaQRBw1Ls2eQ=
X-Received: by 2002:ac8:60da:0:b0:3b6:2dbd:7610 with SMTP id i26-20020ac860da000000b003b62dbd7610mr25558355qtm.45.1674125850263;
        Thu, 19 Jan 2023 02:57:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXupQRvVQygNExc2oOm85l9McoTSlTe0Fg5Auoq0sA5YQxEQEnuJ9CURNUqSLdeH9/2tyrNSfg==
X-Received: by 2002:ac8:60da:0:b0:3b6:2dbd:7610 with SMTP id i26-20020ac860da000000b003b62dbd7610mr25558340qtm.45.1674125849981;
        Thu, 19 Jan 2023 02:57:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-124-97.dyn.eolo.it. [146.241.124.97])
        by smtp.gmail.com with ESMTPSA id h2-20020ac846c2000000b003b2ea9b76d0sm9077076qto.34.2023.01.19.02.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:57:29 -0800 (PST)
Message-ID: <65d3fab9c64423fbf9841b21448fe48cd825070c.camel@redhat.com>
Subject: Re: [PATCH v9 01/25] net: Introduce direct data placement tcp
 offload
From: Paolo Abeni <pabeni@redhat.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, 
	axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, 
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com
Date: Thu, 19 Jan 2023 11:57:25 +0100
In-Reply-To: <20230117153535.1945554-2-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	 <20230117153535.1945554-2-aaptel@nvidia.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_025735_248932_F8EBA25B 
X-CRM114-Status: GOOD (  10.36  )
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

Hi,

I'm sorry for the very late feedback.

On Tue, 2023-01-17 at 17:35 +0200, Aurelien Aptel wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cc072d2cfcd8..c711614604a6 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5234,6 +5234,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head =
*list, struct rb_root *root,
>  =09=09memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  #ifdef CONFIG_TLS_DEVICE
>  =09=09nskb->decrypted =3D skb->decrypted;
> +#endif
> +#ifdef CONFIG_ULP_DDP
> +=09=09nskb->ulp_ddp =3D skb->ulp_ddp;
> +=09=09nskb->ulp_crc =3D skb->ulp_crc;
>  #endif
>  =09=09TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D start;
>  =09=09if (list)
> @@ -5267,6 +5271,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head =
*list, struct rb_root *root,
>  #ifdef CONFIG_TLS_DEVICE
>  =09=09=09=09if (skb->decrypted !=3D nskb->decrypted)
>  =09=09=09=09=09goto end;
> +#endif
> +#ifdef CONFIG_ULP_DDP
> +=09=09=09=09if (skb_is_ulp_crc(skb) !=3D skb_is_ulp_crc(nskb))
> +=09=09=09=09=09goto end;
>  #endif
>  =09=09=09}
>  =09=09}

I *think* a similar check is additionally needed in tcp_try_coalesce().
Possibly even in tcp_shift_skb_data().

Cheers,

Paolo


