Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A3C369D3
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/R0E1mx7dvW4tnYJ3x18g2EC5VfC8B2tnZfDn7TqyVI=; b=BVomDB9zfbfdOvrNiSw2z0LhOQ
	RNM8csOTriEyI5zRF9o4WM/uW18INpszTBxLG2sK8WvW9uUgr6bf0hCcweL1aYzQo2scH29+uxzWv
	NO9eeoPPcIMCdQ9IpeWdeC7lU/hVYbxaEsJs/qygDd740AyKkdS+YNcNmZl00sqXXfpbIoe/UhvKE
	ny/SSnz3NfyD+Zy0h5pYIz5rWRbbedKn0mVavvpJhM+818wvJ7DVKJEozpxqYR6RpF/xtQWdtSodp
	V8sH1fJvERU1XLIjlCp8dbqIXoN2UfVQcsJ5idke4cFsScqUeZob4KTJouQDsQ42u0EB7ij6wbF1T
	qpnyawZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uG8-00000004kgC-2LaN;
	Mon, 21 Apr 2025 16:44:40 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uF8-00000004k5J-2w3j
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:43:39 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-227c7e4d5feso8332375ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745253818; x=1745858618; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R0E1mx7dvW4tnYJ3x18g2EC5VfC8B2tnZfDn7TqyVI=;
        b=AxECMlZ4bk+iTOjruec50Xtl8DfsL2xknBBY/U6o6Th/qKjZHCaugB0/Zl/uVDS4zJ
         dKjq0+OLLcctwX/mde7btD9N918ezJ9Dl+4Zw/qBDnTczkeYWwrdkERIO4JygJiyPLnW
         YxUrDg1pNVxMZ3pQ6CUhlaasbp+SlrNfH6QzYG3wU9h2NcEjRkOObr0ac2TrqK8XmerG
         KF9ay9zEsvkxq0Jpg26QXNzWSvrK1DUOfMKUyACQ8iO5HeZAiSgbe8C11S+D2An2Hx7z
         XYpwMdl8H11Vx8as48P37wqgUrZDzgSaS70aW4DOFAjCLSuU9JXucVTc4biaTGPmvAkb
         7mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253818; x=1745858618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R0E1mx7dvW4tnYJ3x18g2EC5VfC8B2tnZfDn7TqyVI=;
        b=eVjr54SSlvX0ohw2uW+yjoZyz8NqCjU0sfjeu79yjTc71olKScVhgxFGpM8NRXr16C
         Iz7WF+DH5jPS0oYrX6FKtahtXXQZMIP69BErz4mfazPl4fCGA+tWHmEoYCEG18BT4Ikl
         jfy8MsgBYa/5SkqgHAbuLE/dxdGkDBVDC+w5huvk6H9OLpGXuvUW8NBXkelF7J8A0vIk
         17+AugfBTfqNY0Nt/tnoA+bYVKh04tLwT+AwP92Fn6Le5hcCM1dpfSYSJf7rntb5bOfa
         EnBr2YP/TGS66YM1Y0k0dlTI2bSbJ4MqJP6QlFfTRF1dEgL9ora1RMD7pFBfV4gk2pCj
         X6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXGS6se9flIXXUELT9YT//Q7hAcNWTVzuWa8P0nDjdGLSMCMTtXZod4Mnca8ZzDNKbs9m7PPD/+d7zy@lists.infradead.org
X-Gm-Message-State: AOJu0YzZ+KT+tJiOB20bvowYYOsRSGy06V+GywPqEZYkxhKsJXtoGACy
	hQsSIw2C+KaxfYMW9+n0UpMhDJHPqCIxyxe+EpHQFH6ZXIO0ZXz6PVij3Jjp/KT0pJ3aPN2FZlh
	fDHmg6ChJSgECpi+Ntf9G4pHt3D8RAfhBEgY2sw==
X-Gm-Gg: ASbGncsRjh686KHz4DrLphiifgtCm46tdJWsDHZyiFLIlbeFbPdePNzyaZEdR3ShC+z
	0XdXfYSiVE2AjlrO1dS/hZe/af5eolgeXvRSddglrQpMKbyjhSxp155ejR0K1z0Hy9/Umb0vwCX
	yKzvIIenmwE13aKzpR45nwWg==
X-Google-Smtp-Source: AGHT+IGtj/moGGOjGJbBLeF1/Nifu2e9fYeEVC64jWQjeSA+dHu70c1OjZleQZlVG7RSN+5MniQNI0xE02c8J/rL5eg=
X-Received: by 2002:a17:903:247:b0:224:1005:7281 with SMTP id
 d9443c01a7336-22c53614f2amr67689965ad.7.1745253817657; Mon, 21 Apr 2025
 09:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250421161725.1610286-1-csander@purestorage.com>
 <20250421161725.1610286-3-csander@purestorage.com> <aAZzd-9YjBP4IyNK@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aAZzd-9YjBP4IyNK@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 21 Apr 2025 09:43:26 -0700
X-Gm-Features: ATxdqUE1AVehSId8RHFGCMYPJxs7qiDwVp4k6VrPCaISqm4a0TcetgZfF7dPx-k
Message-ID: <CADUfDZqeDeJBVG9AFzSfP9CCAisaUsUa6o=D6NWxQEqorLQ6sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_094338_736463_C40AB6A6 
X-CRM114-Status: GOOD (  15.73  )
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

On Mon, Apr 21, 2025 at 9:34=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Apr 21, 2025 at 10:17:25AM -0600, Caleb Sander Mateos wrote:
> > +static void nvme_release_prp_pools(struct nvme_dev *dev)
> > +{
> > +     struct nvme_prp_dma_pools *pools_end =3D dev->prp_pools + nr_node=
_ids;
> > +     struct nvme_prp_dma_pools *prp_pools;
> > +
> > +     for (prp_pools =3D dev->prp_pools; prp_pools < pools_end; prp_poo=
ls++) {
> > +             if (!prp_pools->small)
> > +                     continue;
> > +
> > +             dma_pool_destroy(prp_pools->large);
> > +             dma_pool_destroy(prp_pools->small);
> > +     }
> > +}
>
> A minor difference in style, I think indexing looks cleaner than
> incrementing pointers:

Sure, can do that instead.

>
> static void nvme_release_prp_pools(struct nvme_dev *dev)
> {
>         int i;
>
>         for (i =3D 0; i < nr_node_ids; i++) {
>                 dma_pool_destroy(dev->prp_pools[i].small);
>                 dma_pool_destroy(dev->prp_pools[i].large);
>         }
> }
>
> Note, dma_pool_destroy() already checks for NULL, so no need to check
> before calling it.

In that case, nvme_setup_prp_pools() would need to clear the large
dma_pool pointer in case of partial initialization (the large pool is
initialized successfully but the small pool fails). I can make that
switch if you'd prefer.

Best,
Caleb

