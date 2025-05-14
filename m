Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8AFC3ABD9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjMFQzsW8Gry9Hq92/gFT0YkS+5JWAyK+/6Z+2QWQ+Y=; b=IKFZ3uHjU9Kmu1+VSQLnAbJvId
	nRDiLo0JM7mFEl8k5QJ099+cgRuHWSOC2L/m7WuGDWCzBY2Het5DxjMmyVixwEcqK8wUzbVE4dx8P
	s6/sfbx2klrn+0yBXyCYGoo3HrgkHK+xdoBTkJzyqDOs/zElvkX6YMiwIAuBcowgFcHjxB8Soa0gO
	vt6dM1yb7rVk2EjSxlkvntAQEKMxyjVw/KOKSqFxeDR/Z3NPUihWEv/mxVEbDYSZ10vOtDZhdhQNv
	/I5LODI68z67t8Rvw6MzeQGCLIsmIw1KOLi9cx40fU+KZDHIa7L9GPBdsIGVvB/8DGurIazYEosvg
	oFxqdD5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6Vb-0000000EJFf-0o28;
	Wed, 14 May 2025 07:26:31 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF6IO-0000000EGMo-3A0D
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 07:12:54 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3da8e1259dfso22603995ab.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747206771; x=1747811571; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjMFQzsW8Gry9Hq92/gFT0YkS+5JWAyK+/6Z+2QWQ+Y=;
        b=gU2845S98VtEocz3BzNwqXxFoGPLbWmUKRTM7CK3IIYbnb11+6bUF0tqhU7xgA2ja8
         jOalFYUoSjKGdFG6Chp8VuIbods3pHKz/LTYIBNOJOhJ24TblWAz6SN5+adN1Zl0Wqc2
         VLzfUxK3CGg0Cq02sTq8wd8xhQKeA8IwHmiI+4U6aWMBkgAX5eY4pDpaOURtIsFeoNEJ
         nqKKUs6Uz4Q+dL6qY4TMGY3I82hw2jc8JaN+euW9Ztkzj3nkulQpkV9pWJPWPIe3XHmG
         GUvwWjcw5l3/jZWGbpOERHDQFLY5LAwQMwsSc0uAII7y+traKjneNvxZPmmVOvIs1eDi
         29xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747206771; x=1747811571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjMFQzsW8Gry9Hq92/gFT0YkS+5JWAyK+/6Z+2QWQ+Y=;
        b=OI7+Kz1KX+RXEYIaCJ9trR7JWQxZFPb3IrRIQSRDU6vf1MiW54d7WRWCeY2nXrIJN9
         5FgTe3vuleXitJhkv8K2U9FQMTaF1FreQsazqZkfTIo1vGYsLblXSUP+idvT7rpmrVMu
         3MxypLzViIsxC1e/aQnh6YFRlcTtwNTlfnyoC8EFOKkotfwlGOCYErDPQNZIoc8P4MhU
         11iZAG+E26+/5aLvNJu5LwLwPSPQEMo4lqbaTjwDesqG1kk8Sj51kHawcX2n6bElrIwE
         mLYbQPf4CeU6Qh5ZR2Vqj4xOLBMZm7+adLXM+nacW3jQznqOiVgWlQIN0Q9LeGzT88Mf
         5nMg==
X-Gm-Message-State: AOJu0YxfnOiWaT0ApT5eE8cdW+AMRJYy/g5GsWAlS9smAha3ioIQMh4R
	a8RFJ9A1AwCata6RmtE73TQ12qCZTiqmqzrPWxn/t8JtEn454kQC2SOrE1wMgaBCM+0zfzV5DXl
	ut28p2NaXEyDwwlSDHVipFnin6EE+/RS2a3LiUoweVHPSQ0hOZQta
X-Gm-Gg: ASbGnctab0wB38THQAJMYn5k0ZoiJQG4l1howIYHZOYfVp5HA3ZmXaEi0Buv/UvVxtS
	CYx5QIBfNgfCgkdcUJ/gL/YKPCXQJc8FKQS+0JWIRWJh3AJLLymTJ5IAXQ4iC8acC9q8vO3W08d
	cGw6c/uI3Na7agtI/HXeflav8W/lG1GXUb
X-Google-Smtp-Source: AGHT+IFpTFiInpVx/XhpGCCn5yY4ZScNu3ZrSvJalOE7xq7jKxhSLbKDTdApVZNOfqKZdtuFzFUgtfEd2C/uPJWfPqw=
X-Received: by 2002:a05:622a:4c13:b0:494:7976:348e with SMTP id
 d75a77b69052e-49495c64b96mr41372841cf.1.1747206759735; Wed, 14 May 2025
 00:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
In-Reply-To: <20250430085741.5108-2-aaptel@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 May 2025 00:12:28 -0700
X-Gm-Features: AX0GCFsuKEnHR04FTvqSAVZ08Xj_h-2AZjziHyzDpVs1MANsenOZbg87rqhebn8
Message-ID: <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_001252_795418_1419E90A 
X-CRM114-Status: GOOD (  29.02  )
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

On Wed, Apr 30, 2025 at 1:58=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> =
wrote:
>
> From: Boris Pismenny <borisp@nvidia.com>
>
> This commit introduces direct data placement (DDP) offload for TCP.
>
> The motivation is saving compute resources/cycles that are spent
> to copy data from SKBs to the block layer buffers and CRC
> calculation/verification for received PDUs (Protocol Data Units).
>
> The DDP capability is accompanied by new net_device operations that
> configure hardware contexts.
>
> There is a context per socket, and a context per DDP operation.
> Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload. Furthermore,
> we let the offloading driver advertise what is the max hw
> sectors/segments.
>
> The interface includes the following net-device ddp operations:
>
>  1. sk_add - add offload for the queue represented by socket+config pair
>  2. sk_del - remove the offload for the socket/queue
>  3. ddp_setup - request copy offload for buffers associated with an IO
>  4. ddp_teardown - release offload resources for that IO
>  5. limits - query NIC driver for quirks and limitations (e.g.
>              max number of scatter gather entries per IO)
>  6. set_caps - request ULP DDP capabilities enablement
>  7. get_caps - request current ULP DDP capabilities
>  8. get_stats - query NIC driver for ULP DDP stats
>
> Using this interface, the NIC hardware will scatter TCP payload
> directly to the BIO pages according to the command_id.
>
> To maintain the correctness of the network stack, the driver is
> expected to construct SKBs that point to the BIO pages.
>
> The SKB passed to the network stack from the driver represents
> data as it is on the wire, while it is pointing directly to data
> in destination buffers.
>
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->no_condense bit.
> In addition, the skb->ulp_crc will be used by the upper layers to
> determine if CRC re-calculation is required. The two separated skb
> indications are needed to avoid false positives GRO flushing events.
>
> Follow-up patches will use this interface for DDP in NVMe-TCP.
>
> Capability bits stored in net_device allow drivers to report which
> ULP DDP capabilities a device supports. Control over these
> capabilities will be exposed to userspace in later patches.
>
>
>

>  /**
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index beb084ee4f4d..38b800f2593d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -851,6 +851,8 @@ enum skb_tstamp_type {
>   *     @slow_gro: state present at GRO time, slower prepare step require=
d
>   *     @tstamp_type: When set, skb->tstamp has the
>   *             delivery_time clock base of skb->tstamp.
> + *     @no_condense: When set, don't condense fragments (DDP offloaded)
> + *     @ulp_crc: CRC offloaded
>   *     @napi_id: id of the NAPI struct this skb came from
>   *     @sender_cpu: (aka @napi_id) source CPU in XPS
>   *     @alloc_cpu: CPU which did the skb allocation.
> @@ -1028,6 +1030,10 @@ struct sk_buff {
>         __u8                    csum_not_inet:1;
>  #endif
>         __u8                    unreadable:1;
> +#ifdef CONFIG_ULP_DDP
> +       __u8                    no_condense:1;
> +       __u8                    ulp_crc:1;
> +#endif

Sorry for the late review.

I do not think you need a precious bit for no_condense feature.

After all, the driver knows it deals with DDP, and can make sure to
place the headers right before skb_shinfo() so that skb_tailroom() is
zero.


If you really must prevent any pull from a page frag to skb->head
(preventing skb->head realloc), skb->unreadable should work just fine
?

