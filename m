Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C92AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LX0ZEtsJlQyXvzvg1XvOUTr9qLeSrEWejf3et+GtoUE=; b=jWRgOq1RBTV2GM2tKpwe8F5NSo
	bB+quZJRGz2XCQAwhlvW+7aHzBFq/rmjznm8X/FskQAC8rK+QqGB45kRtY6nnDoeGvuZdYzbOcj4x
	+tZU0ZLlj7iuiVbJTBzJxhpn2ocmLQpOaq6tTD3NhHYH8xvvH5742WP9g6XP2RVs+UnrWbuTWirqq
	CFXy+DlWdX7HnSc3NssVKENocGuWbKqdyXlcnxBxUN5N6njSIZDBmgVE1MZcd56bCVhaJiPp8pRHm
	SEvQBtjmZQvyXWKJSM7QaJkzIOpvcTHpXaHKWgIbdRC2GITbYGI6OddOSnsoRYDTUDX6ASozO7e3D
	XEfEouDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj5wi-00BSEz-S4; Mon, 25 Apr 2022 21:08:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj5wf-00BSDl-J9; Mon, 25 Apr 2022 21:08:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 71AC86138B;
 Mon, 25 Apr 2022 21:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27B8C385B9;
 Mon, 25 Apr 2022 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650920910;
 bh=yN2FFsgqiwWmpQIWXC94b82E2wpYjQTq/CU/u3g3cjE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pdKHj+9jtFEKRxbFIKbp6BN5W0SKHdhPUGdQDXd7Xqx9vi4EpkMV1Y4FokX/IkPYa
 fcHGk/4On2XWYf3uADhfEsr+7LxnZ49Mj82N7KMHrZLd/dwLJ08US+RaehkUasA6/k
 ULzEmN8W11D5KZ+Cm4S93JoYXPgu2ne6zBKyDbG+PP7TNy6nKJUI/Prlkq4aTHvM+N
 eDTgN5VZZLATieGxC8vMqcHVTHdQIL63mmQQGdiCPeBj+cARAR4cnGnqJ35UI9ZFbn
 uSL8Ys/PCGOp1a6uCJDJdZhN6mhZ0J51T+/xZ6Bj+aFJUo7nkxoRQiwNXWKGnT6ByK
 ZiFdXEcFhWfZg==
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-2eba37104a2so162998657b3.0; 
 Mon, 25 Apr 2022 14:08:30 -0700 (PDT)
X-Gm-Message-State: AOAM5316Xi1cBEkxYv59W+gO1rEzV1JXDdUa62JpqLGQutL3oAluN0A7
 ynwltCk7hy5Koyqj6L3kQ94asHV/5cSs3x0ApRc=
X-Google-Smtp-Source: ABdhPJxgUnh58spmwdi5KGXzmrzAEx/WM60nf6Oi6YSWPgwfZEJsfaGjWIDBRUKlPyettQyT9R0PC00gVw9kzJ9ffYQ=
X-Received: by 2002:a0d:e343:0:b0:2f7:cefb:577b with SMTP id
 m64-20020a0de343000000b002f7cefb577bmr9909411ywe.472.1650920909604; Mon, 25
 Apr 2022 14:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-7-hch@lst.de>
In-Reply-To: <20220418045314.360785-7-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Mon, 25 Apr 2022 14:08:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7fpiAqAf+U491dTH4mWORZQCxfyT6zWQwN=4r5WJ429Q@mail.gmail.com>
Message-ID: <CAPhsuW7fpiAqAf+U491dTH4mWORZQCxfyT6zWQwN=4r5WJ429Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] raid5: don't set the discard_alignment queue limit
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, 
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Mike Snitzer <snitzer@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
 nbd@other.debian.org, virtualization@lists.linux-foundation.org, 
 xen-devel@lists.xenproject.org, linux-raid <linux-raid@vger.kernel.org>, 
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, 
 dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_140833_706175_C77D4C00 
X-CRM114-Status: GOOD (  19.90  )
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

On Sun, Apr 17, 2022 at 9:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by raid5 is mostly
> harmless but also useless.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid5.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 59f91e392a2ae..39b0afdf40d0a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7749,7 +7749,6 @@ static int raid5_run(struct mddev *mddev)
>                  */
>                 stripe = stripe * PAGE_SIZE;
>                 stripe = roundup_pow_of_two(stripe);
> -               mddev->queue->limits.discard_alignment = stripe;
>                 mddev->queue->limits.discard_granularity = stripe;
>
>                 blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> --
> 2.30.2
>

