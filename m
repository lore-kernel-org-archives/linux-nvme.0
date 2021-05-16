Return-Path: <SRS0=Quds=KL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4730EC433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 16 May 2021 18:02:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CF1600CD
	for <linux-nvme@archiver.kernel.org>; Sun, 16 May 2021 18:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CF1600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZicVh/r0uppKj1ZbOWwomOgM6fMhEfAZF9dnlF7qS48=; b=bDSAgk4o1DYuVrkfXRfnNJ9G3
	nvOW7FJfNxwilZB9Fi9oEsTC77g5W6XgRnuSsBjmaFVBQsENmko2j7ju2f4Di2yK23YxUMu4n7NgU
	n6cz1aIX++U08FL4xU+L5hqi1zrmeK2fZHOC8Ox62qpl9RnHvxs/28hj7pTxK+9Wti8mUc1QK2VJj
	gqemE+QjhRi6/19ULeAeTZ4XbAUrv3BMuWNDykGpLxx802ZhXl+8nTW4MnWUjXH2ekJnWPKGDCqCV
	T8ARbmGdcMTdJzU869hZsiEQMC9Ylq2HSMcEMJGsejlmriXTFUtl8eTIVS0HPxcHu5grUG059WvUF
	4Ugt+gBDg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liL5n-00ChtA-W5; Sun, 16 May 2021 18:02:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liL5c-00Chsk-TE
 for linux-nvme@desiato.infradead.org; Sun, 16 May 2021 18:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=v5QeMzC7egI7pjAS/w22YSUqGDibggEE9rbaYoIGpqU=; b=geBkLF5rkJ15cEsD6UQnNVcgOf
 DciiKdfdaHo8lEVTkdMMC8OyIM6VgL0xl6XDZ8MHRZCugnxy+9/6O3LKVpY4s4Z0BkP2qiTPnaz2Q
 3FUmasQQoHGHZ+T1a57COpj5vy+Q0Wu2t2thNcMnbKLzDZvk2VyNAOVqV087rczaSazU7GFUpqyNV
 KRLmMXocvucDZkFGjAC5qQloiMkkmOG6kE8r9GavOfzMEsl0po8LkonyV1L0KKLkN9mpC5Tf3G91u
 YfU/RsFk8I3EtI34XjFCDbLCZjgOhfZWBBzoe0eK00maDyT2Ka+PTybd+3BcfoLH89HwIxn7Q4EuJ
 ScqevfTg==;
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liL5Z-00D6tU-TL
 for linux-nvme@lists.infradead.org; Sun, 16 May 2021 18:02:07 +0000
Received: by mail-wm1-x32d.google.com with SMTP id
 b19-20020a05600c06d3b029014258a636e8so2272674wmn.2
 for <linux-nvme@lists.infradead.org>; Sun, 16 May 2021 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v5QeMzC7egI7pjAS/w22YSUqGDibggEE9rbaYoIGpqU=;
 b=jJ13KUi89rkNTv5tEp/or85ah2IUrc70DM23VD2NFuKqNXgbGkxRibfZ1yAv3qhGz+
 he7zfD+uCJJZqQtGUv8Jlrs+c6G1WzUzpODftpLvaiEGqEJCD+2TCQJqlRAHWUsRMVIq
 ZdaQVjzjaWmXSNhnya5mX2xStw+rRNkB8dMy/68hO9shWxp4ICdobyQh1325TaIb5CTI
 pJxNJIqSUnBWUW5YL7z2UHv4dJpUdMhezplO4j3Sn03+rdASCUUdJlsqvrzTFw+IbWeJ
 CSmboMAyYaBs5LwZiggmQnaVhdr8a92HVxaa4IzHaxJss7T1K0dIGvLwR1IVXaP2IoDV
 UhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v5QeMzC7egI7pjAS/w22YSUqGDibggEE9rbaYoIGpqU=;
 b=dM5/PKV7IzEnfZQiukrJHrPXWevqm2MgJcUjz7VkAWddA12IHJAttcibZMKiOIxClw
 HMIctGDeR4mPajYL/zwSr4LiU4TtieUFs9na6uQ730KU4HBHuPgPlbU0oqnKMTL12piw
 fbRmfBLNNgvddHZUAY9QenpAO0DAyQ/yzuTF+eTmNQDSL/sHfI/Yh+7HghodICgL16Mj
 VVnJaMNaXTjK8zd8GJxZl9Uz8YarNketIkwHh/USJoOgSTDPPEh5VVNjXRvP0CDmZPSL
 YhjSef7hcJ3S4QyAOeGUxU/U4tZ1/AwVwTIMpDGQU7nf5XbSCQs+1Ht5lkk/gAT24lzo
 xmPQ==
X-Gm-Message-State: AOAM530J+UIt3o9vJ2dHu6KIPoF8bb9MfekXX7VlnHII5d7laFzWxkdo
 sgaNx2xXApWMZYwn+pDd6JkGTwqFzBgiuJWPrKQ=
X-Google-Smtp-Source: ABdhPJy/YKSh7Ymq0zYxR42sFCU6UUWGDIoSiLs09paq3ntNO3TKKfvRjNNb8S60ZlbPFETzHSzEp2EIVBGwPdhpQBI=
X-Received: by 2002:a1c:a442:: with SMTP id n63mr12383114wme.25.1621188123406; 
 Sun, 16 May 2021 11:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-3-hch@lst.de>
In-Reply-To: <20210512131545.495160-3-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Sun, 16 May 2021 23:31:35 +0530
Message-ID: <CA+1E3r+8HrUymD-4Q06drqi_qV_L40OjgPCsw6C_Y6Gn_3FVSg@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: don't try to poll multi-bio I/Os in
 __blkdev_direct_IO
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Ming Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Wunderlich, Mark" <mark.wunderlich@intel.com>, "Vasudevan,
 Anil" <anil.vasudevan@intel.com>, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210516_110205_992701_4E4FBF54 
X-CRM114-Status: GOOD (  21.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 12, 2021 at 6:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> If an iocb is split into multiple bios we can't poll for both.  So don't
> bother to even try to poll in that case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index b8abccd03e5d..0080a3b710b4 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>         struct blk_plug plug;
>         struct blkdev_dio *dio;
>         struct bio *bio;
> -       bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
> +       bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
>         bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>         loff_t pos = iocb->ki_pos;
>         blk_qc_t qc = BLK_QC_T_NONE;
> @@ -437,22 +437,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>                 pos += bio->bi_iter.bi_size;
>
>                 nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
> -               if (!nr_pages) {
> -                       bool polled = false;
> -
> -                       if (iocb->ki_flags & IOCB_HIPRI) {
> -                               bio_set_polled(bio, iocb);
> -                               polled = true;
> -                       }
> -
> -                       qc = submit_bio(bio);
> -
> -                       if (polled)
> -                               WRITE_ONCE(iocb->ki_cookie, qc);
> -                       break;
> -               }
> -
> -               if (!dio->multi_bio) {
> +               if (dio->multi_bio) {
> +                       atomic_inc(&dio->ref);
> +               } else if (nr_pages) {
>                         /*
>                          * AIO needs an extra reference to ensure the dio
>                          * structure which is embedded into the first bio
> @@ -462,11 +449,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>                                 bio_get(bio);
>                         dio->multi_bio = true;
>                         atomic_set(&dio->ref, 2);
> -               } else {
> -                       atomic_inc(&dio->ref);
> +               } else if (is_poll) {
> +                       bio_set_polled(bio, iocb);
> +                       do_poll = true;
> +               }
> +               qc = submit_bio(bio);
> +               if (!nr_pages) {
> +                       if (do_poll)
> +                               WRITE_ONCE(iocb->ki_cookie, qc);
> +                       break;
>                 }
> -
> -               submit_bio(bio);
>                 bio = bio_alloc(GFP_KERNEL, nr_pages);
>         }

dio->ref update goes amiss here.
For multi-bio, if the original code sets it as N, this will set it as
N+1, causing endless-wait for the caller.

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
