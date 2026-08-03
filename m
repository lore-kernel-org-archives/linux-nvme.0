Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B827C55182
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 00:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=; b=nFPrh3uXPSuIA9aaSCo7wc4MD/
	zgV9m3kg+QilSdW4n3Sh1dUuey/+lP5Kue3zGnRXVji0ZB5Kn2L0ODHi+YvGFzmMb/82Al7Pqy0Sg
	wGXIxmY4mlD19LMK1QdytzODy6qV57RjtdeDM4pDPvOuECtTWs4dNJsX7vOKrm7dCQuYGih60gqDf
	SBS1Q0Ap+usxMfzQThQmeoPBnHWaMQicWOlMZvn0Zjxr6gPwVcfSP841aJdVwWok+80Ao4flzoqBI
	KB94sG/fUdqoIIk75Z8qaHmfvy2glywYKBF8Ck1W8dpKtkNoknKo4AiWMQviK51kprhWfsw+MXSZk
	FWb448PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr2cR-00000000jXS-2SQB;
	Tue, 04 Aug 2026 00:02:55 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqsbj-0000000H9H0-229R
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 13:21:32 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso4269929a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Aug 2026 06:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763289; cv=none;
        d=google.com; s=arc-20260327;
        b=aSxGE420d4kgHoaNAR+lhXyFLUz5xmqBtdbM72KIjxW94FkGydgDPAj0sYYNhzS5Wd
         xvPA1aCGF/TANVDxm4px6OH7zRGBNyjzsx8QJZ9abDoQCHb9gvo/26gEaogI4jSDWgWm
         wf2gzXPK5p4F8n2/+uFEVxrG35vT2dYes64qior4mONKyeZG18+f1AwA2xfAutqIIxGW
         9vxGLPvYqz4QlRfJV5pA1vZKgMqkLI134fBusutf3y3DB39pCQVlPDkvea1bIsbLjDTO
         qlWmeByybP3YNSxlYNEaD9BFyVQuIT4Ov9FlF7M6U+frAd7yok2K6rsCelVBNLTycLsx
         vtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        fh=4Zb3N54vU6rFcIaPQ34H+gHnsvxdU6d4u5c2IOI3DPk=;
        b=gLmlJcHrY9/S5LZ/TH5kBOAbv6qi/s4KjEPQ7v2Wfqodk2OibWzDwUu+SEYLZgecS7
         4Bv4udMfFVtgyw7h02hLPW3jhMuKVDE7GOsm7lVT2ZDCXCR7b/jvFOzr5PECV2H50OdB
         CCiD9O476s3XBWGt2TlXOk09Jm9kyFeq5IE2nL5vglrPZ9FnnK7zCSYncKFWngaMA6Z1
         OrJkNt18J1U1uEiSqmjEytUPr0uUMtWANembGolL8JkdU7R4qzv4QhQECsz7g/uz6wUp
         Q9lF4ZDt0MvZzI3ZAMpm207rs8Mvq6lqRbzstOAEUSyNoCmVmJVVP+Lq3EP7dXYGjBv+
         AIIg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763289; x=1786368089; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=cveY8h9H4LJKP+vWvmktHGV9Lc/SWBQ+AB/9BOOKuF5RhT4OMo/9y4tFASWY1P1a9f
         XkqHQg8yJszcWhnGNYE9cypXsUcsCHd/Nagoe0Zv6OqadpPOMS81leDHX9E6TEjUBLf4
         OnqeDTd7ymnW9IjlfsGDiTCdzcCac5H3dCh+Mbqbed0LvApFDKW7/SBIfBjuXqHuC0qJ
         wvSzOiTfHQBsf4bOwOV7knjUi0/3Cbz3Mxpyz0xhyfgiOkg4kt7x8uDbmKWwjaO4gGDb
         fj+N69QPgurCoLI0NqfGs7NuYfvUp9FuusWMcOflZADdgFE8qkWG1+6goBMgaWfCvhiR
         RXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763289; x=1786368089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=FbpCU6iK8pJAaAhsvyUBCj9lQEYDfUiajPp/GqXN4jaBk+lKpGrf2+e0cIvsVyhd2M
         4k99yRqVG3FaE8vpPbC7WU0M0svUMfYajDWUDT/qQxngARB3jb8ZPC0OomO5eQ3r5g4r
         95zRsKTlXo47NbAT3ovf91Ivls54pgvJvIrZyv+LA8YOau0Rp25iqhObhz0RQxEef9LA
         JOWJqO4HVsqOR4akugy6KUTxWOopp8JALhIyFU5eSTuQ1Q+suBqfc3znfzxzPws1Xjyj
         PeOoRHSChRcQ10q5MZxC7U4uLLfnMYyG+DwZY20wz4CvXfLSnxYbtOBGXPDwPmayI4R3
         MiUA==
X-Forwarded-Encrypted: i=1; AHgh+RqXtOGNJXOm3/+ku+ray1/SiyYws7iv1rH2mP3CnIqu2ivw2EHdLPhoQC3Y3dRGz/sINo1eka4pRyLP@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5nUkEUsJD4dAyiFYhmuzqkUFCUAI8FogxzjgqNjQw3XYRTZoq
	Rrx4KnLh1B8WWQDWNvOE3ySq2TqaRrR7hC7sxZ8K2F3j8l3SSw+IqFwdpfvSzo1iBDyriyK50UM
	1J0ov6H2nrinGlJxOoylYuq8cpTAm5g==
X-Gm-Gg: AR+sD10puv4+WeK+KtgAz+J4quiw0NrFm4DxPgFnKEs/B04Qs3bQg295rKJCzz99INX
	tYSywDWgMTLqe2DaNUOakdCyHUAtmO4pvFHSg2GgD++cfoQMGlyJvQIPkFUfRmPM6iXZ0a7tyvV
	Ig0iv2BHVzFuQcLRDJldjGXTJb/nSpay7QEKUU6XrJFHDSaK/JoAHh14sw8YkyQJb9thIxiTfSE
	NDw0SnzpWCZbmScro7n6xxuLx5uEwfp7PUtIvZUYADTUNltEEcFimapIyLnP8Z7dM9LRV4MN8sw
	kaJs9G9xnDctrnSJOq6E7sTrMSkURR1wJJ66VtTb60HI4zX54V0ZTgSohP8wqc1OIpvCSZ5WOZx
	pgwFzZ7B0c6hWM44=
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr7875783a12.7.1785763288576; Mon, 03 Aug 2026
 06:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785596451.git.asml.silence@gmail.com> <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
In-Reply-To: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Aug 2026 18:50:50 +0530
X-Gm-Features: AUfX_mwnLWCAPfRurFp37qU73Xc2KDpD6en6Q3cA2kgelroMq6uNFVC_YKEZqSE
Message-ID: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_062131_541315_EF39D979 
X-CRM114-Status: GOOD (  14.75  )
X-Mailman-Approved-At: Mon, 03 Aug 2026 17:02:53 -0700
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

On Sat, Aug 1, 2026 at 9:19=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const st=
ruct iov_iter *i)
>
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -       if (likely(iter_is_ubuf(i))) {
> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>                 size_t size =3D i->count;
>                 if (size)
>                         return ((unsigned long)i->ubuf + i->iov_offset) |=
 size;

dmabuf_map shares the same union slot as ubuf, so this reads the map
pointer as a user address. gap_alignment() below already returns 0
correctly for dmabuf - this should too. Checked the rest of this patch
(advance/revert/restore) - none of them dereference the union pointer
for dmabuf, so it's isolated to this one spot. Doesn't affect the
current series, nothing reaches this with a dmabuf iter yet.

> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov=
_iter *i)
>         size_t size =3D i->count;
>         unsigned k;
>
> -       if (iter_is_ubuf(i))
> +       if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>                 return 0;

