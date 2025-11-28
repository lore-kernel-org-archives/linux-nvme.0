Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B84D116F1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cDb8wvl+/S3cs8WDouA4IaIUDYl/lhw5kT6xFlbeDqo=; b=ViZBY17D3VcRj3fULjQzv+ql5N
	fzCUbq0sIxFz5wG17PXF86QiOEVNkemOB3REBgpAVOitbXlIdaWnfAIwRjLpYUaWX5j0UN0sYGaNb
	rX5vQs8S37vjj42//5/p5k6KB+j2tYSfxNN9mKil/Vkls0yczrQ1Qv4Ge9zVWOueHa0CdBFPTb/+x
	ZqryA55HpO++cdePUzhkk81hwkM/qnH8x0+xbb/Vzy0nU8npygDFZ2OWjoWzkt+w9+1TWjus1kJzr
	gVEiWyxdL9RgN+q3QzogRslL0MWfoN70crVZnC5c5rsWlIYJ6IqqwJDA/5WbHwVcKDiziShZcnkSq
	SgMxRU1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOyG8-00000000T7P-28D3;
	Fri, 28 Nov 2025 13:11:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOyG5-00000000T6r-2KrU
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 13:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764335492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDb8wvl+/S3cs8WDouA4IaIUDYl/lhw5kT6xFlbeDqo=;
	b=NIygpMCjROe06ApYalrjCwRGN6G2Tx+linFraEADItEpQw2KNmtseValASb2gjO06Aw76q
	n1FD02DdItSdCyNLrX400ubJ06v/7QuXk03zt3yYqPeTo2DW/sTEKRYaCG2V9XX/LqKz6H
	ia/Dj+q5XlYYmWUNeQDjF/EmM7g2jfs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-OkVt2IcMNHOqSpzt4Yklew-1; Fri, 28 Nov 2025 08:11:31 -0500
X-MC-Unique: OkVt2IcMNHOqSpzt4Yklew-1
X-Mimecast-MFC-AGG-ID: OkVt2IcMNHOqSpzt4Yklew_1764335490
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e324b2fd0so1968389d50.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 05:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335490; x=1764940290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDb8wvl+/S3cs8WDouA4IaIUDYl/lhw5kT6xFlbeDqo=;
        b=jnrlNWhJGE4gpGrJMjvGW67wEgyksI9T6A2vYXi406ANETwOqsGdxhkZcM6YfhOuNO
         xkRqaDMmR6LLsrsS/THtkQ4OddIuHgsbt9wOZ/GgcKZHMWkl/pwukGnlk5iDQ9iF/7Sz
         XNkK8U0cAGK8omtZ17kV8p0I2as86vp5zDG2pmCNkrfnjzq/paAvpTSGCzsEogATG2CW
         fTHLpluMw/GoM9sQm/1ficGM6eXJMtBUcVeYN97A51CH0T+8w08MeeoAtw83lnZIMTB2
         oio92cDuVtSgjJADziUTQF5Dlyl/fmElGbe5JbaeEuKxv8Y5xauetGLovy33GoAjHZev
         jGuA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJwMQio2k1NRAG0dyCb2CA48ySmjz4tNlhAqW9f1X3qxRcxIi27Y7eJ6bNClzLK8yNL17h+WAHHBI@lists.infradead.org
X-Gm-Message-State: AOJu0Yy51A+L+DNklo/+IsC7ARjKbLrOMoJi0VMYffz0ligKZYZDsJnE
	Bsremq8VGIBjQgSMwKXCldkUSFB9B2WFBmCbPi49IzGm67wtAhHdctfDmTVjjLMGeSZrWJxCYFv
	NtIKyFW5VSQOZ5JIMAw7MMaf6jO8xKXeC2A9UovLPrAo8JMZUUZFsDBGAIKLxne9TFinz2PL5xM
	gx7jxgnNOJptz+xUtbGybx/nai/Z4PGig3/SOQxETh2rY=
X-Gm-Gg: ASbGncuvQLG6aEaR2wqkJQmno9Rb8q9Qvg13xAjBxXBMKiepuubwUo+MZfm4OYAdi2r
	W+Zoy8wTRNqX/TYUvfeuSOo7kv6h3aQCoxo1zOtqEYlUSOjI7Xg6SW/mAeM3vhmGoaTx/JB9Il5
	XSlP0D4QBZ5vbaaxj/ZDZZbGZd3YKnjCGFm/QHmMwpqANBV6QWwMXUlIt3JTgzUZTm
X-Received: by 2002:a05:690e:8d2:b0:63f:bd67:7c52 with SMTP id 956f58d0204a3-64302a48446mr15103920d50.29.1764335490426;
        Fri, 28 Nov 2025 05:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpYs6Bqkkw2QMj53nrShI4JIcUgw0aEZxMMPQ2h/FT8I7boFY7Ao7pNuY9j2sTWaBF/Hvop1CT06FKU/ZbYVo=
X-Received: by 2002:a05:690e:8d2:b0:63f:bd67:7c52 with SMTP id
 956f58d0204a3-64302a48446mr15103893d50.29.1764335490100; Fri, 28 Nov 2025
 05:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 14:11:19 +0100
X-Gm-Features: AWmQ_bmMbDxUx7xf6l9s72idOADcxGPBv_GTFewzDFs5Yo-0xMy2x8K16_Wfsjs
Message-ID: <CAHc6FU43FWMYm2y2b9EvrFzsJdOn55s2QOMxCfRiHKVMVRqQaQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _nFUmAxPThn4QeeAl-nMbr-QJw871Mn4eKacpdPYyEc_1764335490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_051133_663610_D49F4EC8 
X-CRM114-Status: GOOD (  20.41  )
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


