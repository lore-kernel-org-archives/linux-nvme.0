Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97967C3ABDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ne6xM65Lrx875URRJfmoGqN+KZ2IlPd/hwyant4+B5U=; b=atcxC3/S61HAtkKtu6FfUQyozD
	f3D4oMYCelkbRHEcMKP++7l/5ng60aPRUhO0AX85yQ/gOZtMn5HOCYHmgY45QuGQjsi8zDqebqKQx
	Fsc9Q6yM3Xj8Q/u/TIbcinPNLFPpJOlqRx6lZJaMZqIWcffqRbGMX5/wElXA8/7yHILJ8y9Gl+XNT
	G84z5q+SE1/S9H2z1iHuaXwVQNsCF8OJ98vn69NOoS5lv3FE2fJMliDPVEw6ZflozKQ5SZiVbkmCI
	Wof2eU/VYKryQe2juz0wboZGReHoS3r5Clsu281dKh5szGZlI9DKWeH2+iqYW+DI061/0SCbNz1PX
	DZfPqNSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFHDd-0000000G5bN-1Pny;
	Wed, 14 May 2025 18:52:41 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGmL-0000000G1FA-1oaW
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 18:24:30 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-23179999d4aso166395ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747247068; x=1747851868; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne6xM65Lrx875URRJfmoGqN+KZ2IlPd/hwyant4+B5U=;
        b=QIIe0pRKmtObalfcQnNogN+MD6K6vCVEAtR7YWbamrq2D1EKMhBK/Ggshh6zYD7783
         quTcoNjvoI1D8L+itBDgh13GiTe3gUMu4UX6b+/UezbfvQX3Y7Rj7waf2uSgPyxbuOCa
         C/AS/N8M/HPr2h9iLw9CglbZVJpWMEAgCu3RiTMa5HWiHRl90HMyQTZWWDLeYziRuxwJ
         GFYw3qDXlKV3DVbSjLkHv0Q6JofsRwikx4c4ItuUBpPAab9yklziUD6mFacKzIJomsM3
         oM9NXWhfEPaU2owaHvXahELtmrlORBbrAK+hmHffBSjt7aU44tte12a+9SmzJbESuK4x
         a9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247068; x=1747851868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne6xM65Lrx875URRJfmoGqN+KZ2IlPd/hwyant4+B5U=;
        b=BcL4ORS8lnrEE6aSdx2WtizK/QGrVNGns/C6G8tqxoE1272xxOKu4gjZYkmC93owin
         Rl0bsJzKNKAA7brsY1lZhPvDaKFKxjUPY5GZAvEpfi9CPZKDI7AqEWwBsmbS+ppyPufP
         7wDl579ig16pm/ukSGnFSKjDfepmg147e4kHd+PQ0JzBQRaZiKOtowfhRpnVA+Mmdy9S
         AF8aSzKJOy/BukJrpLBf6X5agtxzIDBD/gnOjssJgm4CqYhXeB5HOHOiR4iiLzY3uylP
         H8vrV7YCj2pQTSUDfcx+H3tIil7KB2L7m0zfhSzk7huvVCOS8kiJ8FxHk1Nc69tXWVlW
         HZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2QeerDZZqbUgP/bNTg3MIRwaHgO4NyEFNg0LfWZJSY4dIpVI/Xx3RenXvMu432g4h/eAQk2v6WpDK@lists.infradead.org
X-Gm-Message-State: AOJu0YwPytoTawBte5uoYeqXrEN8gzG5qSX0cUlXlgIx5ET3TvJRqs5d
	HUPfSbIjoNMfEvyT94UJXsGmx5UV2DvF0UMcEIdxmXrGhbZjlNHY7r+KJJf2pnLxTk+Saaqclv6
	RYMrME9AaCqtvh+EYIVvLybaMfnpGBA/trGTPgg==
X-Gm-Gg: ASbGncvgFpsTs5JopWwuCxR1GLBjquyORG9Ubu8KrrRotSTuvIFvWh386mvn8klIJ92
	+fMx+nYg25LQdaXe/w636tRss1rx5rzoxb2SIWN3kygRquWWGAnlDDgJAHCXnvA/cWAOY9lN8wM
	QIgN5DaBVT5V6Ip2Y0C6zEPnTGq5WDKYDu2A==
X-Google-Smtp-Source: AGHT+IG1Tkyrh3cTuvt0X3PmbuG842pF/rvWZABF/45Xl+tGiEjq1i83nASDeLO0PXzsnFzCWlhVHt2BYZeVuwW9h0I=
X-Received: by 2002:a17:902:d547:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-231981497e1mr26481775ad.8.1747247068492; Wed, 14 May 2025
 11:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-7-hch@lst.de>
In-Reply-To: <20250513070025.830930-7-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 14 May 2025 11:24:16 -0700
X-Gm-Features: AX0GCFuhTspoGZdUKrkNvPVmy3gTbkP5sSQHAjzHd9qJh6a2IKrhhzG_3BltwqY
Message-ID: <CADUfDZresXeChvuf7kJzoccz73-Ao7wS9jEzHSRE5-u_NDGDjw@mail.gmail.com>
Subject: Re: [PATCH 6/7] nvme-pci: add a symolic name for the small pool size
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_112429_607051_7CF4CEA3 
X-CRM114-Status: GOOD (  23.30  )
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

On Tue, May 13, 2025 at 12:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> From: Leon Romanovsky <leon@kernel.org>
>
> Open coding magic numbers in multiple places is never a good idea.
>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 16e2ce25da83..5396fe30eb94 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -37,6 +37,8 @@
>
>  #define SGES_PER_PAGE  (NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_des=
c))
>
> +#define NVME_SMALL_POOL_SIZE   256
> +
>  /*
>   * These can be higher, but we need to ensure that any command doesn't
>   * require an sg allocation that needs more than a page of data.
> @@ -407,7 +409,7 @@ static struct nvme_descriptor_pools *
>  nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
>  {
>         struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[nu=
ma_node];
> -       size_t small_align =3D 256;
> +       size_t small_align =3D NVME_SMALL_POOL_SIZE;
>
>         if (pools->small)
>                 return pools; /* already initialized */
> @@ -422,7 +424,7 @@ nvme_setup_descriptor_pools(struct nvme_dev *dev, uns=
igned numa_node)
>
>         /* Optimisation for I/Os between 4k and 128k */

This comment explains the choice of 256. Maybe it would make sense to
move it to the definition of NVME_SMALL_POOL_SIZE?

>         pools->small =3D dma_pool_create_node("nvme descriptor 256", dev-=
>dev,

The magic number is used in this string too. Maybe change "256" to "small"?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>


> -                       256, small_align, 0, numa_node);
> +                       NVME_SMALL_POOL_SIZE, small_align, 0, numa_node);
>         if (!pools->small) {
>                 dma_pool_destroy(pools->large);
>                 pools->large =3D NULL;
> @@ -689,7 +691,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_q=
ueue *nvmeq,
>         }
>
>         if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=3D
> -           256 / sizeof(__le64))
> +           NVME_SMALL_POOL_SIZE / sizeof(__le64))
>                 iod->flags |=3D IOD_SMALL_DESCRIPTOR;
>
>         prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC=
,
> @@ -774,7 +776,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_q=
ueue *nvmeq,
>                 return BLK_STS_OK;
>         }
>
> -       if (entries <=3D 256 / sizeof(*sg_list))
> +       if (entries <=3D NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
>                 iod->flags |=3D IOD_SMALL_DESCRIPTOR;
>
>         sg_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
> --
> 2.47.2
>

