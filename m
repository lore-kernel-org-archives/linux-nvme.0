Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B010ED116E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=; b=ccemXrFAT/NzMELI3q91dSNvvU
	vpjpJrT06rO1XwHc18pUPz2TzHYyJ61AwV3GStJZOUTkyduJcU2ozDO80IuyPQn+1xrsoDyNz1SOt
	i3fg22mFDFPFV2oA4AbIEbX0hTWgv2XbOhJZM5cKY4xX0I+zxKatdLOCdFIgNPiPf3g7ZZ+RvZfDA
	aX7DD5yF4iY8NTeGeo5w71ZPIoiw+1Y9wocxmlt9cA2knDR6dzcztjFkPyU0fmB1sK51ZuHjQeCQp
	GHkr15UZQTlwQaToJwxhrDb7ZbhtZAPWpXgunFuFwEiqwy0q8Y4BQ4yjZj+f74LKefhCvRd7UUqX7
	uRwzKUJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP4Ov-00000000qlf-16A4;
	Fri, 28 Nov 2025 19:45:05 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP4Op-00000000qko-0qFI
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 19:45:00 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so157162b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764359098; x=1764963898; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=f6byDHTRmVKxS1b4ehVOhxVNsgWoXZzgOv0YZB1sDL7JkLFnK+cPtEOKAhP36xdiZc
         wZnQ+9AWS454NOVCrzfjRK19LBFI0P06kty4rurDcQM5bQn55qEo+Ww5IZMm+ZR+v3vF
         s+d6n7hWko7HK70z7W9trlMt9GEXUPD2OvRiQnvV6JEmRXNuXYJcpdKuHS4Q1WKSRnMv
         XN6vFxrMqpcjP6n+HMAP9a9Vnc394d1fhpbeFufTzSLWvXJTdL5NVbVdCt1fNA9ndTiN
         PHqpQCcKPRC4tOSefRV9TJHBvFw3C/kwL4jwEGICJBAP+2ryW+mirby8t2VCC9kalb3m
         1W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764359098; x=1764963898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=M31AZrr5+WX3PwB7GejXIVjAT3J2vGEknDEIshZF7ghNeowvzbYdbr0MlNfDSfk13h
         dKkx10POISrKDrPjVcgS/ysxi9AZYSXhYuOIrqtIymq/yLkeg0ri5NgZBca8kHPSssq2
         SbnlOXuly9nTiRH1zUTfaks6jPXLXYD4Sf48/g+naboXjnQwR19FkfIfzvVsTkXy5SP9
         hBSxl6r8Nebb0+/7R7uOxQ1Bx1MaDwH5WPODvBx1ysnjBD1VgkfM8SJS77xHAEAfoMpF
         skN+U3xvXRWdI2TfjdDhLIxQijef7wmTZyzsJtX8KUtfqX2VIPfm4pphNN9Hb3r4f6Kt
         lESg==
X-Forwarded-Encrypted: i=1; AJvYcCVpBCB1Fj6SKfjAF5ivcdfGb5Q++xp5PmjSvdmZWAgC5XeOy8BI+herSQ2tqQRF9NFGEOkM4BSTOikz@lists.infradead.org
X-Gm-Message-State: AOJu0YzgT4SC9/54RM6C3MmcAZAVLOuwlmgZQ6FSr4DzzxpHDEyOuRyz
	5Jp4lJ4p6v5Ij7If9k9BOX6A0+c0UPEjJuXc53g4IFihluJbK1ULOdxooNQfYFLTpBEJA3oW+KN
	/cmdzGdrXQESOEBbNl6UlyfKV/njJzWAqg5Rb2O7JTA==
X-Gm-Gg: ASbGnctkv/6Uu/2qT/iHE08s+nMZGDZfDPqY5QMnlRDvicysj3IAGfiuuj/XS6eSJSe
	/fu2iEt4ZE9oYfcZ4T3Z9UcZaxKSgaGubnNJOON3lgQwXCSK6Ygn65g7K1BeEOBbijVJ8sK0CA+
	U0IA4MvpLUUXVk3rGV1l5/nqgee0ysyFILAtP90iYiHx6EMyiHqX6A2A5Bt6PUwbFJmHc6pOjT3
	5xWnd0e8+9aLqqEf6OhGBK80/6YNrltuDnh/tm0/SaHrucUqQSm4dSeyb//R+mppXUTjd2rN9Sf
	ppJqar8=
X-Google-Smtp-Source: AGHT+IGrCksmBbxz9v6OODWXw3jg5JUAuqr2uXfNM+p+AOqeGW6UtPYXkYo+cITOMsNqpMT81gOSwHim2ngfe4fkcew=
X-Received: by 2002:a05:7022:69a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11c9d5538e8mr18207898c88.0.1764359097859; Fri, 28 Nov 2025
 11:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Nov 2025 11:44:46 -0800
X-Gm-Features: AWmQ_bnZzeizOKu2WLPi5AEBKsrxZhyOw3plwI8tIQrc3qIRhB_hMon5zXQE3Nw
Message-ID: <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_114459_414095_E54CE2C9 
X-CRM114-Status: GOOD (  19.12  )
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

On Fri, Nov 28, 2025 at 12:34=E2=80=AFAM zhangshida <starzhangzsd@gmail.com=
> wrote:
>
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

nit: this variable seems unnecessary, just use &parent->bi_status
directly in the one place it's needed?

Best,
Caleb

> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);
>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>
>

