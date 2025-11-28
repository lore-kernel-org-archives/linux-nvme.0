Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C5BD116F1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=; b=N//KFTJCfK9GbG4FHaf5XvXv8B
	e1bLjjDLVvE2HcVCDHrb7Ktv1MpiAAN2fAGMT7Y1vBV47kNnlhr7jQNwchUfQBJmdVq5ZQbBfKVxG
	d3WwHw0citZmS9dup46yJJ3gyYt41woKAU3XOOweTZu2lWtSwaYpIdc6A/EUPZa+R+QA5x1I6l2mC
	TbQMKZGUdkhCFrbQtgb+X6R3P8MqDHsUVMFHXr/XDP2ov6JtpE0mDShhQoekAR12yPD6i+g+m8dCV
	SkDU6kFRsZntwxYjJQ6YLEaWY/TW0xtykcNgkcBe3v0JHfPK+tbxlnsVyoAo+RbIl99T2T0j3myQK
	NYZdldeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy4l-00000000SMk-3RxC;
	Fri, 28 Nov 2025 12:59:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy4j-00000000SMD-415Z
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 12:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
	b=CDbPbFYntz9W94Rw3lzyOK+t85U92tblpAlghG0mWLtqwlZuDrDkYJtTiTSv65S6KwtT+/
	wJu18YmMY3CzvFTQZKX5e8a+oUouvs0LZ66epdIdXxZwI88YQW9m3jUHL58OiOHCf8LGBh
	9HDe4GmRIWYKVLhotAd/UKEhLbLd3ec=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-UBmHULtgN6a3s6S0ucxWZA-1; Fri, 28 Nov 2025 07:59:47 -0500
X-MC-Unique: UBmHULtgN6a3s6S0ucxWZA-1
X-Mimecast-MFC-AGG-ID: UBmHULtgN6a3s6S0ucxWZA_1764334787
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-787e3b03cc2so22144767b3.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 04:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334787; x=1764939587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
        b=RyDbDFSuu8Xlc/6WBYJSJbVOk3uxeCji9N3fmraVfXzthZELI/dpgI5NkErwsp7gl3
         K5kfbF2wLv+5KFCrp4HaYVX6ylAqEyiMtyKBB5AEqbQ4MYXc4xvQAbvFcEl8gsiYvyfd
         WGSX0aWziZeVaLhjyO5BzCNjPygbRRXWU80lEfA3wBcaNBo1VeaITfErJeQgnbsQ9rpR
         +UPvPFv8gcOzvzbMDs10m1WaxJgplBBdc9rBp2StmlgSD+ksCtV1da2EWZJwW9LnYk0q
         Mz7jFDE3d+dqt87gWF+FGAQRMSgxSB14swC5rN8o3KFTfIurJ3YYmE0M+0rOeGXQxo1a
         gVxw==
X-Forwarded-Encrypted: i=1; AJvYcCV44F9anRhkIKzxKTqdX9lWqAU5ThYC/4EwKmqZxukKAEuA6EKYBlbZafNhJiYc563g9emdZwDV0X3K@lists.infradead.org
X-Gm-Message-State: AOJu0YyHGanVUE+KW4JGtup0gTl5edr1GLTXcRyJ1A5ZKtlQb3hHyr4i
	UPhdeE+qsO9tOzcJA3gKaz/uzPqdyb9ufk78DySbvAGVhQWU+WB6e88r9Fw3fRFgAjGVFrkK7y7
	UFpESpwgpNT1a/Kct0c365X3vXpLEVfONzLxV/4+bLmdcv8W2FXFcSwjXh/92R2NnwAkipTD3Q8
	UF/+oYJC0doGTC9GiVa1A3ifP/1e1hRk7VmMnDmqGFEeM=
X-Gm-Gg: ASbGncuMV/bhfB2yLvSTHmdmyAMVnEQ4RxK2UH9tUqY75UcRtvLdLBb59HOcUbI8JPN
	8c+LOZDe6Fr6ZN61ranqopZugs8vRGJ75oJIpDcibgvootyVEDK47GNCQkyLnDlqb7wAINqZsbx
	WQ1m9b1Jk+7iBgm3DaPTSem4OZqkhwdURV6nKkWAFSOOtnZ0Ngdm5pVIYIHwm7vUUK
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id 00721157ae682-78a8b47a179mr234771247b3.7.1764334786907;
        Fri, 28 Nov 2025 04:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGesqVOsUJELcTkEGN3hauFQ6kd2TkNnYcjHT4c1bgANcOfukNB8/4Sre15bHJPI3DpWDPFXhJhMME6PGLKN8M=
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id
 00721157ae682-78a8b47a179mr234770957b3.7.1764334786528; Fri, 28 Nov 2025
 04:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:59:35 +0100
X-Gm-Features: AWmQ_bmJ3AOy1Ou64bzbzmfYJle8eXItasxBb4QbS7GrXBYKV503HxVqfGGmAks
Message-ID: <CAHc6FU6H22GEQTaOh4tm_=yL7CZ-Ck4EkXtmdsn_oyAW7OWB6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CxqKtjsfsmNh-NxotcW8JKDNrUWBEDbdF2mk4emhbQg_1764334787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_045950_076977_6862A403 
X-CRM114-Status: GOOD (  20.09  )
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
 wrote:>
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

>
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


