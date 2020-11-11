Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9080C388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 09:55:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3062064B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVTH7SkO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flu0kG/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3062064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0M78n6OGksw6nySu2hqWOG92PZg9MG+IpxoywJWJtdA=; b=eVTH7SkOexZGVkWiHrv1doV0y
	/xAK6IFQP1VhEi2jV2fNTq16jTFNQEL/mC6lWN8Nyx2nUacB2dc47ZufrlGs2t8V/8CZoKtsEq6ka
	d4BODeRm5VCqs8iSH0tSnROTq9Qrt4PHJ5gbvNIx3A3HgEUoIfZQz4/B6iTLUPu27xY+9NIKCizzf
	+ekbYY091h1mVy9NwMBwkAMAf2w7+S4iDtTMmeOSg6Ho9hH/arZVUu+qWj2i2uqzZfptGqZqlPUSP
	fRwquDRQBKcKVw/CAUg1QnGQLpfxwuvhKaPWbASnP/YSgwENxwic2oiyZvkA/yzw8R5nPOtrR7KU5
	GEEADzkbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcmr1-0000An-PA; Wed, 11 Nov 2020 09:55:51 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcmqz-00009H-7t
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 09:55:50 +0000
Received: by mail-il1-x142.google.com with SMTP id n5so1432323ile.7
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qfEf7xRtwJh6vel7ndE10SMbjF6zTEFOWV8RA9xu3eI=;
 b=Flu0kG/G8H5tmdzF22ns+x1T3WixC4FBs0RbA9YeGx20Pw3IL573gomPOrRSgLhidi
 jxm4xXdraWCqe23Uz/lTRF5Gzul+neu0ZW5SRlL8rLtuRaQOMWWnKLr+e1J5E2f/IB4R
 iaO9iEipyz2F49FzVbspMmUTamyYBNigOi7Hq45S5vTkNhsbMM69J9bWbbawzfmKvyaE
 prBgh+sprAAWuhDKQzcpJRm9c4LoRmjW0z3OGufy4OEk4vgw7impUerADJ8+P1l4Evs/
 gUeZGg6Qzu0m4oCwYhIr6na+Ay9Hq4ATHKFwzo1XQC1pmqP6NOhCJ7ijtefRPRR/Tb4r
 FFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qfEf7xRtwJh6vel7ndE10SMbjF6zTEFOWV8RA9xu3eI=;
 b=WKUL8+uDHW7Yt8OuXOVUYTnAmO7L3F7s6eqGmgdZfGLSQbbmCQoL6en/xALJOKkIuY
 QuavjBaLl1y1/QbPVOorJqkbIXE2SxImY1f7RRPB4ojJFpiKuj+DnSQizf3UcLtIpa1D
 +xA9thGWsBRWby8NiDp0Y+mrMY8Z6KxuQk1mNQuVf1TS4Y8zQdNH3Ukvhd5lWYr5TKws
 kWRoTgIq+Ca/OYn2sVvfFhS3iWaZIEhzzgz7xBtWfjU6C+6d5skp3J1UteP/IJtYUyhy
 YbwPoFeXT2B5tbfmnudn4XfiHo4Gq3yazGNJjLVqPOVzin7H4YaQbXqiCu+uzQE+erm+
 XNeA==
X-Gm-Message-State: AOAM530fIlErTboPQRUmHO/Q5UATI0oIkAXTe3rvZieHlGEzoyqu2jkq
 Of69hxxzSxRUYCaVHGh1O/56nUMtkRU6DVxtoDU=
X-Google-Smtp-Source: ABdhPJy9ZPoku1YjH4P5V9sTrbXGNc0TDLR8E4ST1Mn4KA5kvu+HvwpbOUC5MO/5tCHlTeWvzQ658Y1GM8zrKYsupSY=
X-Received: by 2002:a92:1f43:: with SMTP id i64mr17516886ile.281.1605088545285; 
 Wed, 11 Nov 2020 01:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20201111082658.3401686-1-hch@lst.de>
 <20201111082658.3401686-18-hch@lst.de>
In-Reply-To: <20201111082658.3401686-18-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Nov 2020 10:55:45 +0100
Message-ID: <CAOi1vP-JjnNdAUqd9Gy6YdFgi8Ev4_Jt3zcB9DhAmdAvQhG7Eg@mail.gmail.com>
Subject: Re: [PATCH 17/24] rbd: use set_capacity_and_notify
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_045549_346840_073E3D36 
X-CRM114-Status: GOOD (  18.78  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Lars Ellenberg <drbd-dev@lists.linbit.com>,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Ceph Development <ceph-devel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 11, 2020 at 9:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rbd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f84128abade319..b7a194ffda55b4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>             !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
>                 size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>                 dout("setting size to %llu sectors", (unsigned long long)size);
> -               set_capacity(rbd_dev->disk, size);
> -               revalidate_disk_size(rbd_dev->disk, true);
> +               set_capacity_and_notify(rbd_dev->disk, size);
>         }
>  }
>
> --
> 2.28.0
>

Hi Christoph,

The Acked-by is wrong here.  I acked this patch (17/24, rbd), and Jack
acked the next one (18/24, rnbd).

Thanks,

                Ilya

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
