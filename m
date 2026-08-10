Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82D9C5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=; b=ReaPWyjpbwbhW7VF/SjzZcvX78
	yv9zeAA5nmQ5vut/TwdRs6qwXJj9VRB77juub5x7dFcqCAc2W0qk+yOyinCEsH8+K+sc0yp4w9yQH
	a4XcCaesPiJAvJIt2AipN1052oKfjrYMYY1hOoBdXTmwBW3UiNSf6b3IGld3paE9gXMX0B4621wcS
	pqD8ZAIqLJH7upliTVFp4MLYKx/CGXCgssXSrnEDNAX4NQLwkISdH6wvCeEIFNMLsNu0QR9vOeNEI
	zfNOS4Ip8wiGVxkPZIHdigbB/WC+/Z/QsJKQ4oq7mdi//UVG50zcA2DoT17TrTRJZkL28D+t9KlgC
	s0zZ5O9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXIs-0000000Ct5j-1PZT;
	Mon, 10 Aug 2026 21:13:02 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXIq-0000000Ct53-2IW2
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 21:13:01 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so3557067a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Aug 2026 14:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786396378; cv=none;
        d=google.com; s=arc-20260327;
        b=gN0rC1pH2cQVQ6d65vb+xdmHC4mGT+HNG5LxTsuB5JRkPrW5iLj3S10OtIMamGaQm0
         1XPLsrlXVhDAcUSu12hdQkokZ+Tz2cCs4epZohoRoDJYDikWIYC3Zu4qijKCHHeYG2w6
         WU1l6ns7swoB0OZirSQMlivSUNiQP7anepnm752viC0xfzbufx580zjY+LEInLVCHr0O
         OGvA7ict6hjpKxyPJ5tB0I5yUQRdPpgUPmYQcwMqb1Dg24DCR5Y/dk3d/7SDcbIhdKi/
         +gTpytV02jwGRnc1SyjtZ3cPhYa0KCllGk19R5VUszjwyYv5622CaCQPn8VX5X6+iOZC
         HInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        fh=a/Gp0ALW3hZ3x9AqQUino3JmDdqyEJR3PhdT0YPorh4=;
        b=JsanFifG3wX73ypVmEsxcNa2HLJSrRlm2nQwCqswOJTxZdHZDHOnLu1J5VD05J7KK7
         VFITzUXFdEa4JbbBSCP4u6iMIi6Ixwcqvw1PTM9OoCRU/OKm0K7e7UCfFpNg31KvFxDr
         kcvgZlNTIUCj+8fd1GKYFeW7udsROBj/YCJKLuXpLPKSAoN1kU1AQbwIpNPdGj5o1aSi
         5+U2a6T+tX6McPuA0vbnJ/4+BpIuKVZBUYsCd26ZRwYNNKZPNGKnBvYSjnQNK4dOh+YZ
         G4HTVudOrdNMOKgUgr9BYAdRULumu36RTAZmqifqEelC7KmMXNC8CvHjtjUY3N2JXIQa
         GULQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396378; x=1787001178; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        b=kqE03CvFAhzjqy/ZiW7Jj4ngnb0XDQLfHCKJomVHf+D/HplpUzWgCNZf2xPGd/yNut
         UBjoRpkzAPDY7uuc9c3jb7GZboo22adhI4ooEE4zk6GcZwvraHr19lZV87C/FEKhnNxI
         OBVvYr25I9qW35q55uf/dnvFGA/7lryOxKlBMlvLjGIwn5d2YAgBzLL1/KchezETIkX0
         gQZXQffmiHgTEZImb5ZtRQWIsOHSLVMlW26g8n3ySzNYj2hNPV3hmjdjinMqBg3lECBP
         HTq6Z6AjqmnYVWCdgz85wEHwxu8UeA2Q+3KrJCMHEjDJl7RK1tn14rhcULJfZK9ZmJQH
         g+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396378; x=1787001178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s9mQ3DkJJifPOKJnOS5mdERe/d6CjgCqbbWdO6jwj4=;
        b=UYLR0AlCGnGgWrMpHzxJ/N3oZ5fk8qt2JPShpt5jqMbtRE62IhAaDyBObtuthlxpht
         WjDOQW8Hwg13mABwOzHxpG7UMqsKHT836TmQCRDxvCOU/9NOoKO3c1IRs8I7ebAAMeI6
         InYYZKfuK1JTmbg5EUNF5MqQlHHB6izVLpBB7we/ChchDBckoqaIiMOjQHtG26y9nurM
         y+rgVC4341BZ3z2ujYuB5I3veWFNPFMQiALO9gm1CZP0viWY8bBD7JDrNNHdOS/dwu5u
         ReldqKhjX4Z5hWNeOONEXIBbRU/Xp5MlG6dWPVJxZSMInSeQ3GTg2E8DmTmKVbWbfn/6
         yXug==
X-Forwarded-Encrypted: i=1; AHgh+RptII01qTU3bzUlAhsKRKYPXsib9lqSKMXIjr6Kkid3GeRSN8dJyqimc+t21tjMHfB65kNu1kWLvH2G@lists.infradead.org
X-Gm-Message-State: AOJu0YxWPwuQfSHJ23dJeKMGDEGMJiVkeg2Mor+PSVaH8tXAKvwSYrCh
	GtGY4wjkgHZYKLsII2AWOtPUT3jUpyHDBHVg72phPTADt5xkqZWiQee+j+QiVw0wd2EmV1ywW9e
	P5aFwxfBedO9HCzcV8RCH7M6qu2lqASA=
X-Gm-Gg: AR+sD12+ZiouCdDdkyQuohNaoI97HaTUaP2yxqnVULkBw/fIkovpoEhjQpeGGw7G5CW
	LCDPy2Mrt5bZfBNiWBASQpwD14gpiD8+rg2Oy8sWGLXYFo+pyeW4FNcgqu2O/uNf6qNMV6LizPQ
	z7s9W6YDqeJhORyeifRUl/54PcRtnPM4X07DCp/TSMK1STf+1nfgq21e25RB/DsiXC2xZp2+PVT
	7VQURdgwAL/AV003z+wcf5bueMcZ2QiUkPrXEaq02mjlrtGrkWgoVhKCwozj5BdpC1cZE/TSSpD
	nZY/XbmYs8e1XSKP1so1/A3SuvS07qCAKQNgrXp+lYVD
X-Received: by 2002:a05:6402:504e:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a1e62d8b29mr12930000a12.21.1786396377743; Mon, 10 Aug 2026
 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-4-kbusch@meta.com>
In-Reply-To: <20260519172326.3462354-4-kbusch@meta.com>
From: Chris S <coshi036@gmail.com>
Date: Mon, 10 Aug 2026 17:12:45 -0400
X-Gm-Features: AUfX_mzNv25W_1qVDbnXAMrPYIPaAVX7Rm_Mr4yXO-SFDG25EsvlS7LE2Un-0EY
Message-ID: <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, Igor.Achkinazi@dell.com, 
	dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_141300_625581_F2F4475B 
X-CRM114-Status: GOOD (  32.65  )
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

On 2026/05/20 9:25, Damien Le Moal wrote:
>> Should this be a pr_err_ratelimited() ?

FWIW, I think pr_info is deliberate and worth keeping.  The comment this
patch removes together with bio_check_eod() gave the reason:

  /*
   * Check whether this bio extends beyond the end of the device or
   * partition.  This may well happen - the kernel calls bread() without
   * checking the size of the device, e.g., when mounting a file system.
   */

So it fires on a legitimate and expected pattern, and pr_err would be
noisy for it.  It may be worth carrying that comment over to the new
location so the reason for the level does not get lost.

Keith, I checked this patch against the nvme_setup_rw() WARN I reported
(the second link in your cover letter).  __bio_split_to_limits() is
called from blk_mq_submit_bio() after bio_queue_enter(), on both the
cached-request path and the newly-allocated-request path, so the bounds
check is now serialized against the freeze window in
nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
failed here and can no longer reach nvme_queue_rq(), which is exactly
the race I hit.  Thanks for picking it up, and sorry for the slow reply.

I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
unusable metadata" patch in favour of this.

Reviewed-by: Chao Shi <coshi036@gmail.com>

Best,
Chao

On Tue, May 19, 2026 at 1:23=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> bio_check_eod() in submit_bio_noacct() validates that a bio does not
> extend beyond the partition's available sectors. This check runs before
> bio_queue_enter(), so it is not serialized against queue limit updates.
> A driver that freezes the queue, updates limits, changes the capacity,
> and unfreezes can race with a bio that passed the early check under the
> old capacity.
>
> Remove bio_check_eod() and replace it with a bounds check in
> __bio_split_to_limits(), which runs after the queue usage reference has
> been acquired. The check uses partition-aware arithmetic to validate
> both partition bounds and disk capacity in a single comparison that
> works correctly on the post-remap sector values.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-core.c | 26 --------------------------
>  block/blk.h      | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 92a802dc8042c..c200d0fc44fe7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -547,30 +547,6 @@ int should_fail_bio(struct bio *bio)
>  }
>  ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
>
> -/*
> - * Check whether this bio extends beyond the end of the device or partit=
ion.
> - * This may well happen - the kernel calls bread() without checking the =
size of
> - * the device, e.g., when mounting a file system.
> - */
> -static inline int bio_check_eod(struct bio *bio)
> -{
> -       sector_t maxsector =3D bdev_nr_sectors(bio->bi_bdev);
> -       unsigned int nr_sectors =3D bio_sectors(bio);
> -
> -       if (nr_sectors &&
> -           (nr_sectors > maxsector ||
> -            bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
> -               if (!maxsector)
> -                       return -EIO;
> -               pr_info_ratelimited("%s: attempt to access beyond end of =
device\n"
> -                                   "%pg: rw=3D%d, sector=3D%llu, nr_sect=
ors =3D %u limit=3D%llu\n",
> -                                   current->comm, bio->bi_bdev, bio->bi_=
opf,
> -                                   bio->bi_iter.bi_sector, nr_sectors, m=
axsector);
> -               return -EIO;
> -       }
> -       return 0;
> -}
> -
>  /*
>   * Remap block n of partition p to block n+start(p) of the disk.
>   */
> @@ -802,8 +778,6 @@ void submit_bio_noacct(struct bio *bio)
>                 goto end_io;
>         bio_check_ro(bio);
>         if (!bio_flagged(bio, BIO_REMAPPED)) {
> -               if (unlikely(bio_check_eod(bio)))
> -                       goto end_io;
>                 if (bdev_is_partition(bdev) &&
>                     unlikely(blk_partition_remap(bio)))
>                         goto end_io;
> diff --git a/block/blk.h b/block/blk.h
> index bf1a80493ff1c..e70acb2d358e3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
>  static inline struct bio *__bio_split_to_limits(struct bio *bio,
>                 const struct queue_limits *lim, unsigned int *nr_segs)
>  {
> +       if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) =
+
> +                                          bio->bi_bdev->bd_start_sect)) =
{
> +               pr_info_ratelimited("%s: attempt to access beyond end of =
device\n"
> +                                   "%pg: rw=3D%d, sector=3D%llu, nr_sect=
ors =3D %u limit=3D%llu\n",
> +                                   current->comm, bio->bi_bdev, bio->bi_=
opf,
> +                                   bio->bi_iter.bi_sector, bio_sectors(b=
io),
> +                                   bdev_nr_sectors(bio->bi_bdev) +
> +                                       bio->bi_bdev->bd_start_sect);
> +               goto ioerr;
> +       }
> +
>         switch (bio_op(bio)) {
>         case REQ_OP_READ:
>         case REQ_OP_WRITE:
> @@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
>                 *nr_segs =3D 0;
>                 return bio;
>         }
> +ioerr:
> +       bio_io_error(bio);
> +       return NULL;
>  }
>
>  /**
> --
> 2.53.0-Meta
>

