Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0515DEB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XHd7VlWT5089RYk8VvnEBTraJMSbmuk8MZ7pf4VxEWI=; b=pzFQTNfgliguGPG6WW7og9b9x3
	bRVGjV1j910wTNdh4o5watkj5u0wK9z3pUiGDjk09tDM4m82v/MMbubnBMiN/vXDM3VfZ/Gvk0qf3
	7fDC2IxvEYK+ucsmIrV7/dOfYxPUYGwRy9/0kKugzv4OjFrhWaFdvOdKDhTdiSR652D147iGjJsKS
	aBItMXuu95gwM+NWP1Nz3V9PwzwGuq8eSRfDqs0DIsnmTjUYVuEx/4aIADMISjL5aC4DPLQ4hNUsu
	MPaMBzIUV6xM58Dyg/pyOcsPFvetTIGgZYLLUr6xNntMJISKvbnx026Nuj95dL8HlvZXDBD8UmRLa
	qm9z9XNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFI7s-004CjI-2f;
	Fri, 30 Jun 2023 17:41:44 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFI7q-004CiM-08
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 17:41:43 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9926623e367so249869566b.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688146899; x=1690738899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHd7VlWT5089RYk8VvnEBTraJMSbmuk8MZ7pf4VxEWI=;
        b=eMLbaOjq41xKahwcNrk87AiQuRXgoyW8HAnAtO2++QkFNVTz8l56nSY8fPm4bkxvBt
         vU4dJIGBog46bn1MtGzEtWe3e1VAlFmlNU7DgZL/tq3oG06WWTPxh8cTfQmWXAFNZPMr
         Ig2LPvgsGgPFfFj+QOsrTJoQsXsWcPJiye3HAXcC/n+0c7q7ASqnabsv0pzkkS4ZuP00
         f8+IcbpBsIr9DSXfPr6/GJC1iKabP9oaECURRHaa8hmvsrmRaKqR/UHWzi8f9CVyGcMt
         tqk3jG0i6myTdLmx5laoFKjNvvjrM3oEVGXhPzXJZVmMKkqfu9Jx0XRmDFexJWDydKxV
         OIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146899; x=1690738899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHd7VlWT5089RYk8VvnEBTraJMSbmuk8MZ7pf4VxEWI=;
        b=jZZymzJSFD9eiC6VMpbzvbKrQD5oOVr78JHvIgHttzVxaQnPX+QQWylaihIgjDgtPS
         wcwivBrc2aPC/esa3c3wPJ7DjUe/AW9PyrVwCnqzlhSECJtOEJeNGnXMHvOkGww9Q3Pf
         U9Og35nWos6cGtehcfIOeZ0cJuNmMd9OaXBjFSz9snJ4nSMuvqDV9be6DF8LlS7u7o+1
         J4RJ5qJUu41vAAoMrP/O0UVvEMrOAwTK/RPA9jGeN4aklFX0wqQpIVppxsXC8pduA7xX
         ZehJ+u56T/975nQkhxxIer7YafT642f6zIi1KMHau8a1bnpXnJwKbMmL0F2cuP0fSHxN
         f0zQ==
X-Gm-Message-State: ABy/qLbrNtcIPGp+rckO+Wk8UNTc1Hox7KQkexdg9yj786pyrgw9Tlg5
	4n+YirI2q3x6AqLPcsS8G4JK8qpV1hPYMssCB0Q=
X-Google-Smtp-Source: APBJJlEz5vgg0kGBkFWe6kqi1AzzahHI2hlYrrqeolL6qcS9s2jDu+MwH4HjjfInOzQF6gwF7Gm26dthFYL5BMcZId8=
X-Received: by 2002:a17:906:6c90:b0:974:1c99:7d3 with SMTP id
 s16-20020a1709066c9000b009741c9907d3mr2219642ejr.25.1688146898924; Fri, 30
 Jun 2023 10:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230624103502.8772-1-irvincoteg@gmail.com> <c68c669a-21e0-b257-5a1c-bfabf8d6f558@nvidia.com>
In-Reply-To: <c68c669a-21e0-b257-5a1c-bfabf8d6f558@nvidia.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Fri, 30 Jun 2023 19:41:27 +0200
Message-ID: <CALL+9egLCiTFyOpvt9tUhmkr-x3PoCzi3JeDxZ-FTCyP7BkDxw@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: check id->mc before setting NVME_NS_METADATA_SUPPORTED
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_104142_077688_ECE6F7C9 
X-CRM114-Status: GOOD (  25.55  )
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

>The MC field is primarily for use when sending a format command to know
>what are valid possibilities. If the reported MS and FLBAS are out of
>sync with metadata capabilities, then the controller is broken.

Beware having MC and FLBAS out of sync does not necessarily mean we
have a broken controller :
MC could be 0 (no metadata support at all) and FLBAS has no way to
express that, it can only indicate which metadata type was selected by
the user.
In such a case we could wrongfully signal metadata as supported when it is not

On Tue, 27 Jun 2023 at 18:02, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
>
> On 24/06/2023 13:35, Irvin Cote wrote:
> > The NVM Command set Identify Namespace Data Structure defines
> > the metadata capabilities field (mc) that determines support for
> > metadata. Check for the value of this field before enabling the
> > NVME_NS_METADATA_SUPPORTED in the nvme_ns data structure.
> >
> > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > ---
> >   drivers/nvme/host/core.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 3ec38e2b9173..465206b5cf6f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1841,7 +1841,8 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> >                * Note, this check will need to be modified if any drivers
> >                * gain the ability to use other metadata formats.
> >                */
> > -             if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
> > +             if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns)
> > +                             && (id->mc & NVME_MC_EXTENDED_LBA))
> >                       ns->features |= NVME_NS_METADATA_SUPPORTED;
>
> this probably should go into the WARN_ON_ONCE above since it violate the
> spec.
>
> >       } else {
> >               /*
> > @@ -1852,7 +1853,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> >                */
> >               if (id->flbas & NVME_NS_FLBAS_META_EXT)
> >                       ns->features |= NVME_NS_EXT_LBAS;
>
> we can check the NVME_MC_EXTENDED_LBA here and WARN_ON_ONCE if there is
> a spec violation.
>
> > -             else
> > +             else if (id->mc & NVME_MC_METADATA_PTR)
> >                       ns->features |= NVME_NS_METADATA_SUPPORTED;
>
> same here.
>
> >       }
> >   }

