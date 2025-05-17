Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EB4C3ABDA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9kA7G8jvAebsZm9fFd+gZxu9or/CeU8wcOw+bvlUpY=; b=VcwXkTY/pbqRX+S8xKoJs88WV5
	F9ZmEdVRGmhuKvuWZ4R4eDXe4TSjkunJCMATncLII5V/pVEOLX3/qoMc/r054Fa3cEP/3ktQOj7eT
	IP4KJYiIz2G+2GDPQx9DlSu6iSPfbsP9HK2KiSVPcDgi4rKAFBfXivBIOawn3seT2CdhEtaPRuhig
	2+7YnV+e8GOlyB1W/cALUvjrUtctrgOhhzBE+u/9JgHKb2ue22zw+vmJdfYBhGjbG2FeiFmgWvcMa
	9e78ost+BvUut4KUmOc4KGvvK55fbBBBZ05yaMAu3BhIDUTFSnMnvwhkTXewaITBf+kRu9QmAJIQV
	Y5eMI2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGC87-00000005Lqk-1kJN;
	Sat, 17 May 2025 07:38:47 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGC85-00000005LqP-25aM
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 07:38:46 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-47691d82bfbso51779461cf.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747467524; x=1748072324; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9kA7G8jvAebsZm9fFd+gZxu9or/CeU8wcOw+bvlUpY=;
        b=QuDOfWHWG2cTjBE3OhANAMiNBEnZgS1UsXaOfMEZOUdBrewfw3QrS8V8ly6Z9Wf94o
         PSEUItUnJljkTlE7QeqMks7220wx0bsEgr558NXpkvuXJH52I0eFRzA/MhFUhrFIwUO6
         MKWbP/bpxP2N654xGvtXMyLFPgtBXha6rSJyP7NVo5nh8tb5siwcgZKm6u6T6QybYaqS
         k6LUic7kBCrmSqPGUivbH+AsmEuNkmHfs6zEpZ/QzV/SMhN35kNIfW0kT/5pVRBSPmUf
         CxCGKSToUkYSVTJRtuWQwD4PLnyRYkDsAFpy9Q53pmRh7hv1/8q1bFrFKPKDMKfx3BaU
         Z+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747467524; x=1748072324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9kA7G8jvAebsZm9fFd+gZxu9or/CeU8wcOw+bvlUpY=;
        b=EzY20KMqS/ACbPr3HJXmDrEW05322DOqa+PKrIExcrrSkvknkbva6rDr0u7Os6O4Lt
         hH4FfkQxXuZN9JW+XJWNnqkc9l0Ro76T4Ot74lN06/neNlwxnd9yichs7mXVnfHb1Vs6
         tN23ptJ2JLlhRzxr4e4Rs24SASQAB152p9lwq5uwuGeiJ6jE4ijQZcQrRKOG657F8SVg
         K0ou6wowLhwyy/TSsaTiEFZfqT/r8XjDVN3qYszwhmjc/470HshPBMfUDJV7j0skEqtn
         EtiMrPdrwJTKJ9CEKdPKpeJUO2FOHflYQIHMbbMWvVhw3eJ8NAhANBjTdtIHeNX5hWqm
         Eqjw==
X-Gm-Message-State: AOJu0Yxsx9gEQjk6Zdk3a7dWYduukoikfMgDhlw0zAEp6NApR1ip/A/E
	PuWVhcz2ys36LDab21I6DfyDbuUIY0xZ7TdFHv2ix2PfO2SWR/rwx8hekvA+u1LTaK47pT6bagX
	N8YzJAmaTS5jGxdmXtFRzekBsEPDHbobITP2Z3211
X-Gm-Gg: ASbGncvXNRx+c5g6J6EZbm7/A6dtDcEY+4h5/SiAHVDcGqFZVNNk7G8xpl+A9Xv92lW
	9VT0fl71bvP7iHynhlANXJ/W8YPqAB9P3wqA1JjnhaD8uWzWdKBxY9PhcZoQdxufTsNOvLhvs9x
	94qboYCpe/YftX5yJrxaB8H20sKvk6pw4=
X-Google-Smtp-Source: AGHT+IFBfqp+Um/HWnxSdG273xN1f/RM4LtAAlsUIHqaQXuBsq8Q9M571VqWyPoxieYzKpp8L5rKZkatRVDwKHE/5cM=
X-Received: by 2002:a05:622a:5915:b0:477:1edc:baaa with SMTP id
 d75a77b69052e-494b075afb4mr90658281cf.6.1747467523796; Sat, 17 May 2025
 00:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com> <2537c2gzk6x.fsf@nvidia.com>
In-Reply-To: <2537c2gzk6x.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 17 May 2025 00:38:32 -0700
X-Gm-Features: AX0GCFuZltUxtYUb1nPOItK5LArEgIDp57rbKbS10vKZC2yAJgYMDJKD8I5OG_4
Message-ID: <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20250517_003845_561762_DF02AF17 
X-CRM114-Status: GOOD (  12.87  )
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

On Fri, May 16, 2025 at 7:47=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> =
wrote:
>
> Hi Eric,
>
> We have looked into your suggestions, but both have drawbacks.
>
> The first idea was to make the tailroom small/empty to prevent
> condensing. The issue is that the header is already placed at the skb
> head, and there could be another PDU after the first payload.

What function in the driver puts the headers in skb->head ? Of course
you would need to change it.

Something like this

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55beb4ed277a5ea896a6859350b72d21..9a87b3bb46c01dc09d729923e70=
5ca6df93f1df1
100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -553,6 +553,11 @@ mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct
sk_buff *skb,

        dma_sync_single_for_cpu(rq->pdev, addr + dma_offset, len,
                                rq->buff.map_dir);
+
+       if (ddp_mode) {
+               skb_reserve(skb, skb->end - skb->tail);
+               len =3D headlen;
+       }
        skb_copy_to_linear_data(skb, from, len);
 }

