Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CCBD116F1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2NUtFfF9SbHj+pN5h7ZLsSymt83AD97eoXiZYz42dA=; b=NXfU+dzT6VPOoRIlNncuVqG6g/
	6fmLyj18uejVmD6stKjFTuihBPHTiv347Yp1nAtdCkviDxQgvXqwMTy3JY5DHRhNykIn1dJn/UPwx
	0Mntbq+mKO6I2WeEAo0Lw6OxHMdrQAo/KgvM52/g68UyTAxMAVdlDzw9Z4TonKiymSBXDYPFn1qQ0
	4acaLRK3AzqET/DsO84XHH74uaQAgeUr3N3wHePkabrCKcLE5qtmZTkGZjaRQVBfGmQB1veiUpTZG
	MJCEfNrX5JfjHqexv3Iyzjrq2JwozAm0vju/Q8SMgK7KukR5ok09PEhUYnEBpTeO4l+WF8QrM4s0O
	c4CzDTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy2h-00000000RxI-323N;
	Fri, 28 Nov 2025 12:57:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy2c-00000000RwH-35Jl
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 12:57:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2NUtFfF9SbHj+pN5h7ZLsSymt83AD97eoXiZYz42dA=;
	b=W4mPGyc6d9fc3wQCgcF+Ox8Tlni3InzOhGY+lVD/6MbVepZwZrzCJRBR7Ood5pw/JMTQtd
	aQ6B1T5UQPv3Du77Vl7oi3qxX8+oroCPCkPIi3deKJuNpah7Icxy1YxsoFNlo5BZU+HE2e
	GRgXJpL7qeeejRouXXYFAAe4ltvfyr0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Cnl7x1L6NwKZZtVOr_c5Lw-1; Fri, 28 Nov 2025 07:57:34 -0500
X-MC-Unique: Cnl7x1L6NwKZZtVOr_c5Lw-1
X-Mimecast-MFC-AGG-ID: Cnl7x1L6NwKZZtVOr_c5Lw_1764334654
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78ab0ef3673so24315157b3.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 04:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334654; x=1764939454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2NUtFfF9SbHj+pN5h7ZLsSymt83AD97eoXiZYz42dA=;
        b=bS914MOjkxJe4c/W+kMBuaIHG50zByqZgOAY9yKvpExec632YKvTIaD9Rsg95rfhLv
         CA1xb7ZuUVf4kqi21eGWJlIzjFE6sgVNTrrN1CY4cNeDuzkF2aT6geNfo+59Q3RlJj1n
         6t27RM5ikd2mK90VHmIR64YoVlFRJep2QYmkYsjnMlgC7zvLja3Z/dUTSXoDa9zo9vK0
         /xZGspGUp1WVl0hzmI01Or/L1zVcRojzsYjr8nMd/Wgi9CxpgAGAOZeSW6/e+DRjZPOq
         DKn6kbFNYet4Sr2MBhr7loz46aQJbg4saNSKDxfCCxO9dOjy95ZXSYRmebQo/rLoZDMM
         5CNw==
X-Forwarded-Encrypted: i=1; AJvYcCU0JrpGZy2IVSKo1jTFKWGJP/8Vphy9B1/0Tx5tjsfrHLUL3mQpkbLeXcpoT5ZTqHj0u0nxaz6pd+UR@lists.infradead.org
X-Gm-Message-State: AOJu0YwkZYrfdzqBObWNb7EkzBB2wHxtRfBXWIIYRKKI+w1fxF1Z3pGf
	HWMJlJZpQK/QbMXMOPswCykVMwtABSRXaBpdlYeEtj+Bvb7x02BwJct3W5Gaollp8vOt+U9EXhm
	IGM9IG6M40s7tIIfgjWkmcr/H54bca1gBP2vbitNRvaI9io0ugGNWcJON3F4QXHpcVnlGoFy2EL
	t/FnylSN2OI6dHZGa2SVDzVSZrLxoNGamj4fqd9OUwFTk=
X-Gm-Gg: ASbGnct35xiD6KEI8+/Se3aowzgKRuNlRm1JZe3cIgogAOxV2sKRQTmx9GqCzil9Gn+
	VIMgt4eSSam4HrxTqr98Xfi7b4VdK7JN1vbMdEFsL6/Nj8Olch60OO1m6LX74O/pXlEM3vfhHL8
	1ydQfoNzrnzvzqsOkmVcnS4k0Tkjycj+JEWfx81siIyhQw5D/Tw35Z5nR5W6Q3yout
X-Received: by 2002:a05:690c:3348:b0:786:a967:5a8a with SMTP id 00721157ae682-78a8b521351mr209364407b3.51.1764334653916;
        Fri, 28 Nov 2025 04:57:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYKB1oLuPGJAVoxdwBsDfFu85nnaWrR7frU4rGijoJHAkyVO4VlXEEBnQXgKFqXNy1QVvTkGpWt9+fdpViZKM=
X-Received: by 2002:a05:690c:3348:b0:786:a967:5a8a with SMTP id
 00721157ae682-78a8b521351mr209364247b3.51.1764334653580; Fri, 28 Nov 2025
 04:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:22 +0100
X-Gm-Features: AWmQ_bncrRsjrklAzt9B3bsSktqMzFJHIbAcDYZydnWE535duaAjUcuyPEWTG9Q
Message-ID: <CAHc6FU53GR-FTPzWSuxQumJXX7z6HrzFGo5=kfA1VHt3KxwNOA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gtehQ8YtO-XYbTvIP1SPZKXVgNiociFru9aVkMpOc8c_1764334654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_045739_185724_05E60897 
X-CRM114-Status: GOOD (  20.49  )
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

On Fri, Nov 28, 2025 at 9:32=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> The check (parent->bi_status) and the subsequent write are not an
> atomic operation. The value of parent->bi_status could have changed
> between the time you read it for the if check and the time you write
> to it. So we use cmpxchg to fix the race, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..aa43435c15f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
> +       blk_status_t *status =3D &parent->bi_status;
> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);

This isn't wrong, but bi_status is explicitly set to 0 and compared
with 0 all over the place, so putting in BLK_STS_OK here doesn't
really help IMHO.

> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>

Thanks,
Andreas


