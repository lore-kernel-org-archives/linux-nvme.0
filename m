Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138B7C636D3
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESqBBPYpgVN5uZcCivO5DaR4zZN15VVDdNsOZiTKtrU=; b=HYp9dj2BjAAqwRmMfUiCnDDwJ4
	hXtKkhD7YMguN2SFaMTpPeEYKcx66Uylk8Yo0REGESxni03/lX0LAwKL4MVBWq+lFMCKhvwW5fIID
	WF8638meg5FrCaLoHGuuzjQQ4jnP7eQViAygYX1O0iyv+pV6dwadgB6E7xg245v80vpPqVhj5AdRZ
	Hlvk894q7Col03LhWh73Jz0pAB3hC7PxA5Hkzj/S62ewuon6Eb8YUuG1+ogFdcGUzQx+SZeQXL7lZ
	sjyuIEu1em9pvATEiFT1eUQGrhtoKkIebPxlRBdFuVKNLZ/Vt7220kx5lGHvk+HiiigOI7zzm6Ujz
	1RJngCwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjjq-006NTH-GA; Tue, 31 Jan 2023 06:03:26 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYld-004w1g-Oo; Mon, 30 Jan 2023 18:20:37 +0000
Received: by mail-ej1-x636.google.com with SMTP id dr8so12765127ejc.12;
        Mon, 30 Jan 2023 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESqBBPYpgVN5uZcCivO5DaR4zZN15VVDdNsOZiTKtrU=;
        b=nKCKI2eUxGRcaSZgTmFPehKr3qVxRp0sSTX6As0CJA6cEO7S5tDGHwTtxcWOBvjG+5
         ClZltX4Y3POVohJyazbmQlAgJeqcXDECvGEvMfxGmFMz3/p/ZhQ+I4K6gGF2MU13LJ4z
         19Axk50kaCOy1pUa9HjxYbHCoGtn4Ea+kFtIk141HMca3CQJQn9DvmK96fWyEakjLuFq
         iS3N2a/s6O/Q2gCI7ySoWzJQ5GPGtaTalwh8TJ4L/KQFPakIBY+KAO+Np+5mMe0R40Ay
         cBp8FloBIDKo0FIkdpo6fBsfxBdHgDQ9NaLb0nfuj9pZ+SEcS+GIfKSiynUsG/BBJ7OX
         +CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESqBBPYpgVN5uZcCivO5DaR4zZN15VVDdNsOZiTKtrU=;
        b=BiLB7IwIJ+w0osQA67lVutp7RGWekBvld2xfIJEmlVar7i1YxCPajklmUFXGIDLLbU
         aT+nWbHTaDmyaZpOXTyXOxjRAM9WDEkplebOwtraV9mZPY4hjNpwq0o+jT9xePJr2e/8
         ERjP/Gdgfq474r7Af+AQRaKSDCrW6xPVqTfpeGeb4PpsUzR5McilkwSwiGZXrtK3kDuz
         tSsqqsX0sbzc+sqG2E8dn7ce+tiGkx10j58q7dtxsDdXC3aiKI/mIicNF8x/oKPkBkVK
         oZss0S99/kRi0xxUOrdYcTeW4A78D9MpnEn34LgEcDuZCmCmX6qwf2c/pTm+wYvD6CeA
         UHRA==
X-Gm-Message-State: AFqh2kqvgGAQWMsiYACamzEKchSw9gnvHTeSKbORwMsFTCjv+qibnj3p
	cz3YtRZ/7lAqSKpGSRmGhVND7WwJ4ufkEAR/zZQ=
X-Google-Smtp-Source: AMrXdXunXSZTlv6MlRv2Hm0y6kSEWFLV2akgLcFsz+yoVqsfzKFvu004fWkS1yRIAW4Rk97VhQXcJdOpL6Dcz/TIiuw=
X-Received: by 2002:a17:906:7754:b0:86f:2cc2:7028 with SMTP id
 o20-20020a170906775400b0086f2cc27028mr7705802ejn.133.1675102831692; Mon, 30
 Jan 2023 10:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-24-hch@lst.de>
In-Reply-To: <20230130092157.1759539-24-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 30 Jan 2023 19:20:15 +0100
Message-ID: <CAOi1vP9U6kTyLgiXDFPtg4nr2ut++cAoowZONsoAtzWV0VosUw@mail.gmail.com>
Subject: Re: [PATCH 23/23] net-ceph: use bvec_set_page to initialize bvecs
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, io-uring@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_102033_899037_C1D48961 
X-CRM114-Status: GOOD (  21.61  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On Mon, Jan 30, 2023 at 10:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize bvecs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  net/ceph/messenger_v1.c |  7 ++-----
>  net/ceph/messenger_v2.c | 28 +++++++++++-----------------
>  2 files changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> index d1787d7d33ef9a..d664cb1593a777 100644
> --- a/net/ceph/messenger_v1.c
> +++ b/net/ceph/messenger_v1.c
> @@ -40,15 +40,12 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
>  static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
>                      int page_offset, size_t length)
>  {
> -       struct bio_vec bvec = {
> -               .bv_page = page,
> -               .bv_offset = page_offset,
> -               .bv_len = length
> -       };
> +       struct bio_vec bvec;
>         struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
>         int r;
>
>         BUG_ON(page_offset + length > PAGE_SIZE);
> +       bvec_set_page(&bvec, page, length, page_offset);
>         iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
>         r = sock_recvmsg(sock, &msg, msg.msg_flags);
>         if (r == -EAGAIN)
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 3009028c4fa28f..301a991dc6a68e 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -149,10 +149,10 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
>
>         while (iov_iter_count(it)) {
>                 /* iov_iter_iovec() for ITER_BVEC */
> -               bv.bv_page = it->bvec->bv_page;
> -               bv.bv_offset = it->bvec->bv_offset + it->iov_offset;
> -               bv.bv_len = min(iov_iter_count(it),
> -                               it->bvec->bv_len - it->iov_offset);
> +               bvec_set_page(&bv, it->bvec->bv_page,
> +                             min(iov_iter_count(it),
> +                                 it->bvec->bv_len - it->iov_offset),
> +                             it->bvec->bv_offset + it->iov_offset);
>
>                 /*
>                  * sendpage cannot properly handle pages with
> @@ -286,9 +286,8 @@ static void set_out_bvec_zero(struct ceph_connection *con)
>         WARN_ON(iov_iter_count(&con->v2.out_iter));
>         WARN_ON(!con->v2.out_zero);
>
> -       con->v2.out_bvec.bv_page = ceph_zero_page;
> -       con->v2.out_bvec.bv_offset = 0;
> -       con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
> +       bvec_set_page(&con->v2.out_bvec, ceph_zero_page,
> +                     min(con->v2.out_zero, (int)PAGE_SIZE), 0);
>         con->v2.out_iter_sendpage = true;
>         iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
>                       con->v2.out_bvec.bv_len);
> @@ -863,10 +862,7 @@ static void get_bvec_at(struct ceph_msg_data_cursor *cursor,
>
>         /* get a piece of data, cursor isn't advanced */
>         page = ceph_msg_data_next(cursor, &off, &len);
> -
> -       bv->bv_page = page;
> -       bv->bv_offset = off;
> -       bv->bv_len = len;
> +       bvec_set_page(bv, page, len, off);
>  }
>
>  static int calc_sg_cnt(void *buf, int buf_len)
> @@ -1855,9 +1851,8 @@ static void prepare_read_enc_page(struct ceph_connection *con)
>              con->v2.in_enc_resid);
>         WARN_ON(!con->v2.in_enc_resid);
>
> -       bv.bv_page = con->v2.in_enc_pages[con->v2.in_enc_i];
> -       bv.bv_offset = 0;
> -       bv.bv_len = min(con->v2.in_enc_resid, (int)PAGE_SIZE);
> +       bvec_set_page(&bv, con->v2.in_enc_pages[con->v2.in_enc_i],
> +                     min(con->v2.in_enc_resid, (int)PAGE_SIZE), 0);
>
>         set_in_bvec(con, &bv);
>         con->v2.in_enc_i++;
> @@ -2998,9 +2993,8 @@ static void queue_enc_page(struct ceph_connection *con)
>              con->v2.out_enc_resid);
>         WARN_ON(!con->v2.out_enc_resid);
>
> -       bv.bv_page = con->v2.out_enc_pages[con->v2.out_enc_i];
> -       bv.bv_offset = 0;
> -       bv.bv_len = min(con->v2.out_enc_resid, (int)PAGE_SIZE);
> +       bvec_set_page(&bv, con->v2.out_enc_pages[con->v2.out_enc_i],
> +                     min(con->v2.out_enc_resid, (int)PAGE_SIZE), 0);
>
>         set_out_bvec(con, &bv, false);
>         con->v2.out_enc_i++;
> --
> 2.39.0
>

Hi Christoph,

Nit on the patch title: this subsystem should be referred to as
libceph instead of net-ceph or similar, see "git log -- net/ceph" or
MAINTAINERS.

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

