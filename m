Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2231091900
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qF9W3zO5gt6g59Tywgu51teuUsXV3uqYu62hZk259SE=; b=ri3WiSVolFQXT5y11w3xSCjWRl
	BjI6wy6JSlnUAaf1jz4dHvQro5N2g3UbqhwFjvWyaH65vHsxslv6R/B/Ked/85HKXtsUUWdtNTf/G
	e3u5CyIS2NaN1wMNbSYGnk/dCzDPacBZxr+pLk+wsxLu228K7+y6JNy4R0cXr3UPhWnszlUUTEblz
	Iu0IAf+9IzRVie4AP0f4QX14XdFEfwbJTqCokEXsVy13YqjTtY/o9iD+6ramLuW47Cs9kk9d0S5gW
	36+nndid7S3uLrC+Hy0yYeeqKpXF/vYhRn2GTAszSheMJ7oYxUy/fXQY+/WhxBAcPStHLcO+cXAye
	znJzwrvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Hfs-0000000BFvS-3Uys;
	Thu, 19 Mar 2026 18:00:48 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Hfl-0000000BFuv-2pPH
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 18:00:47 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-439b7c2788dso719103f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2026 11:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943240; cv=none;
        d=google.com; s=arc-20240605;
        b=cKk56mSde93+ScnoOMcMbDJuDO1WabrLuxI9NKfPZ3tL2ss5coju538G+hA9Nc9kpc
         VqAbAektitSYOXwyphzglIW+kYzFCWh2OPfppXmu2ehh+z3s1xaqhUdJrpSzNVSEFO95
         Hwz5MApmXt07tMLyDm/togqXjivibjz1HNZ3s0Zzshapym3HMwk5/EPxNuSFi0qfA4K2
         8KM724yq4yFF6UvNA42GYp/CMX3d7b4JFjXBqFPvQdTIfTAsPDOKnWGjKIbT5GMjcbdW
         x9nHXolvdzfRFsPL50SZV/iq68xM1zFNuHcrhQZABbB+Ec0TAY+ckYsmgRT4E5U3h7Z+
         j6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qF9W3zO5gt6g59Tywgu51teuUsXV3uqYu62hZk259SE=;
        fh=wJcC0M+xEf5edjCtFGGdlyecvXAMClYiPmMOU5IksBk=;
        b=PGg7jBjtji9w5CK3MRgUFKH28geRvUmT6VaEllV26cSszxzHgEj5bZsHjXwOu66fpn
         xM4mZTWWSE4mbAAaWpuH0XMhRWbnAuCG8Jr1vreUDxvQkOxzC5RAR01x5PxxEpTMGqB0
         vqncf22qbsp0UL3BHbKI0LtRPUb98AKYnOMXPXlownjTLrXTtPm9OpNLZlzxf7XVR6JX
         yKPWB4YyL5cwZCw9XAZjroNgLKOhegD8hfVfqnLcg7sb5UTiloo2VWaiRDZjIY+KwTmB
         9z/N8UZo1ay0C2XI7xGkG0PWF0KvKtDV9NEAMlx8nZvi6kI8xuK3GN5pU9OQ3M78xI78
         i/vw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943240; x=1774548040; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF9W3zO5gt6g59Tywgu51teuUsXV3uqYu62hZk259SE=;
        b=lQCI5irdACviOmkZ+AH97dtnf+UPGLTjyuIi/mnzAJfagK5FUBhLb3mvetF/EksfDW
         VaWc11kWNirAwCmpixHYYZvMvEs1/857Dv04O3GEwYXvCmm0HBdQ34ZIu6QhP97vgK9u
         c2BFE1DivTrGsPce86WdwSGAZ2NMWNMpQdzl7BLnXRNaH55GpYEQwb/C8pl9PFSMg25q
         +WRrCgXcNfEeA1XkjdTT6Mw39srEYXI35EMoCcBtmAWEl5xl8JZQND+2b0o6AXCuMnLw
         8hZW7+XMml2EeTmhCEjTbuzeUu/m9tE0TeJMKeCIT7Z3cjqkLwXaRu6oBZ3ogodLZt1/
         eeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943240; x=1774548040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qF9W3zO5gt6g59Tywgu51teuUsXV3uqYu62hZk259SE=;
        b=py8cISU+H6l5upBc4YUuSud+F7uGDfXO+zJNgqj7lNVcTkb7LVBezqdyTa90GIwLWP
         fVuj/W1g2DR0/BV1X3Nxa5pb3FCK9MHvzi5F87znWBFxx6N0K6ZkupNXMX92Ck7Wpxcq
         Z3LcKaPD6xrYrpZQJvknAl7YuhKomcy5XWy4CPtcSxCmGa4rXiCzo1uRiO56g+UpBPEo
         92EQdlBKTG4CIeayZQhuByB+MknMLsIXPqRqEakyue19u8IBV4yKKvifiUy7nNyGw9hO
         ORg3V/tfTf7rRCns78sqPZcmb5bWa3LwrX0mw6dFriLFQqtBrNQuJ8ZEx0VGrULjzYV4
         AH9g==
X-Forwarded-Encrypted: i=1; AJvYcCWtcvmu08CLKYQ6+Biy26jMeJrsRZUup0bba3lUbfEE0kzzXnr4UwqvqEvt59eL0rLc8xisNVFMavIk@lists.infradead.org
X-Gm-Message-State: AOJu0YwCvtZ90mbeo0Y/QvShuod6RdqP0WgeX5f9VdelZj2l4rcVs5Qr
	9IvJUUeLJsz+p0/PePMyv31QeoBZfgwSRJLlRAYsjzBjyrM+KEIxHApUW2Y0UxwTK4Y5EVC38cs
	jyPJFVYpv6yF2pCepxA29wVKhc2/8ho62lu5C
X-Gm-Gg: ATEYQzx6sxiANfofqMv2elkYDtfZewaQjkjwzUSZzkeTKto0BpxHiuY+a0z9YoXu9RA
	77ecmZlZKGcY/0rQjxp0d/6pVEQNf1isB+QTGFoK7uQdui1y9pISmax5aCZSOhu9EO95DBl7dP4
	PztuF/GboaaBBIuiv/vZd3+9lNF9TrfO3WrQfijLCtRaqL4ao2HFjsvJ9/0taB0YD7GazcZCTZy
	sgcD7I+vtWqJmdodMNMEDgjMZPIDRLmK8ZSyRba+A+um19+LZoZErOhUmeIROgfkogGqVnNFa/B
	HAZU8qCwEA==
X-Received: by 2002:a05:6000:4007:b0:439:d769:ec56 with SMTP id
 ffacd0b85a97d-43b63fdd30fmr481087f8f.0.1773943239400; Thu, 19 Mar 2026
 11:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
 <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu>
In-Reply-To: <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Thu, 19 Mar 2026 14:00:27 -0400
X-Gm-Features: AaiRm50Uo7IOWJpKdjbntVz9yfMPNYXSVlq03Qjw6yzYd-GTZ_GOiWICtZ2uDAs
Message-ID: <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: gregkh@linuxfoundation.org, security@kernel.org, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_110041_745171_5FE9488C 
X-CRM114-Status: GOOD (  26.56  )
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

Hi Maurizio

Thank you for the review. You're right, I was conflating the per-PDU
H2CData limit with the total transfer size for the command.
And the error handling should trigger a fatal transport error rather
than completing the request with an NVMe status code.

Would setting a sane default for MDTS be the preferred approach here?
If so, I'm happy to send a v2 implementing that instead.

Thanks,
Shivam

On Thu, Mar 19, 2026 at 3:59=E2=80=AFAM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Thu Mar 19, 2026 at 2:26 AM CET, Shivam Kumar wrote:
> > nvmet_tcp_map_data() reads the SGL length from the incoming NVMe comman=
d
> > and passes it to sgl_alloc() for scatter-gather allocation. The only
> > existing size check (len > inline_data_size) is gated behind
> > sgl->type =3D=3D NVME_SGL_FMT_DATA_DESC | NVME_SGL_FMT_OFFSET, meaning =
any
> > other SGL type bypasses the validation entirely. A remote attacker can
> > send a CapsuleCmd with a non-offset SGL type and a large sgl->length
> > (e.g. ~3 GB) to trigger an excessive kernel allocation, resulting in a
> > page allocator WARNING and kernel panic when panic_on_warn is set.
> >
> > Add an upper-bound check against NVMET_TCP_MAXH2CDATA before calling
> > sgl_alloc(). This value is already advertised to the host in the ICResp
> > maxdata field as the maximum data transfer size.
> >
> > Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> > ---
> >  drivers/nvme/target/tcp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index a456dd2fd8bd..c7253221c342 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -431,6 +431,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd =
*cmd)
> >                       return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_D=
NR;
> >               cmd->pdu_len =3D len;
> >       }
> > +     if (len > NVMET_TCP_MAXH2CDATA)
> > +             return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
> >       cmd->req.transfer_len +=3D len;
> >
> >       cmd->req.sg =3D sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
>
>
> I am not sure this patch is correct, the intent is valid but you are conf=
lating
> the total transfer size with the H2CData maximum PDU size.
>
> In other words, if I understood the code correctly:
>
> MAXH2CDATA is the limit of a single H2CData packet's size.
> sgl->length is the total amount of data to transfer.
>
> Also, will the request be completed with "NVME_SC_SGL_INVALID_DATA |
> NVME_STATUS_DNR" code? If yes, this would be a violation of the spec
> that states that an H2CDATA with a too large size should trigger a
> fatal transport error.
>
> Maybe the correct fix is to set a sane default for MDTS
> (Maximum Data Transfer Size), at the moment it's left to zero (no limit).
>
> Maurizio
>

