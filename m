Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA9FC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZm8Fosx0a6V1sAfiU+oEr1Hxc/6MhVbSSXztvqe7Q4=; b=nLFSyNtPB30qqyMdayzRkpfpuN
	RvlkSW4UiWvLBAPaEjgyfRIi5rzPs1j4IcPZs/uk9LWmsAPbiToa4b+MROpK2bECN3ckHOtLIz1eA
	G0fibREPCeGN8zt+OpbME55V1+gb+pqoTXMmZIRFQsx6lRBJSpSEY5d38aTmYgetLHbMz/6Y5n7N/
	I35TSZNxngnDlCCWosVVwnGO/5ihGX0iKgbVu7kPNLRNPQaCE3kgQzJlfj2ynLYyVG8oi1fFIhxZF
	sf535gsXX8EKNWYZttWbklmKzN2l3XKKiXWpM74m5TFo8Q5LlQ6ejLEOIXth99ym7+YLfuR6xGu1R
	D8RtwtNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFHDh-0000000G5g6-248K;
	Wed, 14 May 2025 18:52:45 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGqf-0000000G1gv-3Aq8
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 18:28:59 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b0b229639e3so3055a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747247337; x=1747852137; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZm8Fosx0a6V1sAfiU+oEr1Hxc/6MhVbSSXztvqe7Q4=;
        b=ZRWGSB5bYPYpOEnIF9m4oNMnk2X++avwT1gans7pFnBXselv78yjtJfxfXwDmxR+YQ
         1qkmMH2naJ7LSSkmwnlUebcNke6N0eqnrSOi6oAv9QiB/DbmkyFlL/nPNa0op21UTjez
         AON0CsYHt5UhGuk1Fosd0W0OiMAXywOClGGFRk5Y0ZjzCNwmB7Fxg2uT+6bKp8f5JUVI
         ETmHsc+4oCc6qf4JYz12DQDbRJmVtF+40LlCMkOkwn+xhy6Ty8GaC/q7NeVKt56W9Ds1
         b2u7sxH25lENAusugVy7xrwINnvmuIr0wP750yd4Z08kuXccUhBMhrNO4doCuZjYDPGB
         RCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247337; x=1747852137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZm8Fosx0a6V1sAfiU+oEr1Hxc/6MhVbSSXztvqe7Q4=;
        b=prnoJfj/zGUJGxlpbAHULxt5XgnelTpOgf/vUxE6nHuWJeGGPLWHvdkNK6axRTtUf9
         Hi9o1mz0h4xRKz9c8ztjFvhRoWdLZxG3v9XSLTf0jdXw3/99Qyra8GPkY//kceMr6UHw
         SuKjDoi+xFcdYRwwys0MqwpMRU97GmMDlBTOPZHtYgY7yJ06muTQTnCsphXhrDG5qUQR
         +pYRDoh/BzoAW9u2zvy6rKx3Yvl5LA5fEsDWGZPIyeuMetHMW7Ez+lEsmUp42jJvJU5v
         sezK1FqylHvv2YscB2eIB6NT6eeMnNPSjm2Ueiz9KF+jVxSMYGlO9zfiWXwsV8RjlTg+
         uKGg==
X-Forwarded-Encrypted: i=1; AJvYcCVKPb4zJo7Wqiw1Xqr8WVPvIS8cKm7B6zvbYQTm6vGcbI+cxiXMVOPJOSc3RuYlPuyTgbNRbbh4rmCT@lists.infradead.org
X-Gm-Message-State: AOJu0YzIwIoiK8x0TwtC+729dtR4GPtAIuZpB4XaS/x9DMl4iM+Gd4GB
	CpzB0EdMOxb9UnKJ9JPHMWQx5NeRQrc49kZfVfv+MftF1rD0r+76BauFcDolqvm7LtZ8Q3anePZ
	zzfBKZ24Qhfgo1lnVI/z90UGEhEcRntrmijD66g==
X-Gm-Gg: ASbGncueu7zTJsCdInJmrq3PwtxFP54GpJ+1RlW7Y1O7qRu3ckJjcHqejgjjXzp4t4V
	Umekv+dUB1zUlG/B+0RLvbnVTk5w6kRUkWPp0GzQptyMCeQIhIwBBNrSCt+wkVN75/toV6Od7M6
	qeON9+BE9QtTyz8Fq42YNmtXeY1WnSfqfc
X-Google-Smtp-Source: AGHT+IGen2m2N7PAT9Jf6d5ia9vn40z1VW6RTtoGzAQCnxDAdK4ahCWCKN1Ro12BIsn9d7i/U/K4NIXLBlAkZuLul/Q=
X-Received: by 2002:a17:902:d482:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-231980befe4mr24598835ad.1.1747247336929; Wed, 14 May 2025
 11:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-8-hch@lst.de>
In-Reply-To: <20250513070025.830930-8-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 14 May 2025 11:28:44 -0700
X-Gm-Features: AX0GCFuIQWGWEPdx21ed_GXj_7Yvn4lL5lVKZ0CufFtKOut5PVdKbGLkGQIhumE
Message-ID: <CADUfDZr2niqMMexNTNEn=ykGufP2Th9EnGcEyiy9QjNkSGOArw@mail.gmail.com>
Subject: Re: [PATCH 7/7] nvme-pci: use struct_size for allocation struct nvme_dev
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_112857_794710_DFF80E69 
X-CRM114-Status: GOOD (  15.41  )
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
> This avoid open coding the variable size array arithmetics.

typo:  "avoid" -> "avoids"?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5396fe30eb94..0efbc9329291 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3212,8 +3212,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
>         struct nvme_dev *dev;
>         int ret =3D -ENOMEM;
>
> -       dev =3D kzalloc_node(sizeof(*dev) + nr_node_ids *
> -                       sizeof(*dev->descriptor_pools), GFP_KERNEL, node)=
;
> +       dev =3D kzalloc_node(struct_size(dev, descriptor_pools, nr_node_i=
ds),
> +                       GFP_KERNEL, node);
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
>         INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
> --
> 2.47.2
>

