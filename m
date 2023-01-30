Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233FC54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+UsnDYEEEOfyUbH/lXJAyb1YrNHDU89XvWY7p8gIqU=; b=B+7cMm3X84jPASRmTbsebEbuQa
	xO6e0PAiUF0Kx2KvwyamyOMaRkJx6ym2b3QOHBJpGXbK3Rg1C86/jBoz4gUpQx0E93gZcEqWl/8dy
	xOzNiZXPmdEQpc/rEEeSBOrMRs1zpW2PgzAmLPMP4qNZ5rfR/MKETG3h50mr+svejwRDtv4QUHcg4
	dehxwR0UEUAiHsr6Rw6w1M2ngYCojqip5it1iF1yPQZbPsc8MR3r+b2lwq2MubTEQkvmBm4H19LKG
	lzWJuUEQQeziM5k0lY8qBURM+OSuRB2ZaLwxENpko5AVX07zaGa5c47arVnzCqOtxV5RrGroc9V6D
	BqfdHHbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYRs-004nBE-A2; Mon, 30 Jan 2023 18:00:08 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYG7-004hPH-Jy; Mon, 30 Jan 2023 17:48:01 +0000
Received: by mail-ej1-x633.google.com with SMTP id k4so28601868eje.1;
        Mon, 30 Jan 2023 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+UsnDYEEEOfyUbH/lXJAyb1YrNHDU89XvWY7p8gIqU=;
        b=CpIi7U8meqUvpwwHiSGd1IdVplT9N/wEXPlMlTsFFXyhK4irJaVCltXVoisRD4OtsJ
         Rp+GETx2zPi+LRHBbG7TedN9tCa2d44rv6ERS9LZ714bjXED6oA4tXrKaQgaZefoLEBT
         FmxpGFZB4292Hf7PShZjUN1dUJCt8d/dMntxKh5EE3vQ2/1IMSkKRPUher8dCYs0V1yG
         b8LfOHrulCQRh/AAOTrO0gUY89a5W9PLGsq/+xfSMRtf5+itz58cVqKOZLq6B2OfqfRh
         /PZRDDptgKbJtfY7tCnEgNDOmTGJa40XfEUjVp6cWOKwTJy7dVnFZRZFdHwf9raQ0FKA
         U+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+UsnDYEEEOfyUbH/lXJAyb1YrNHDU89XvWY7p8gIqU=;
        b=GiLKSl3D82KAYb3K9oPLQIpm/2YDb5oZ37L+yXilqeoXKSh9ru0yBuqFza06aq4Q8A
         heTJqM3aXB7mqk/ckeZ7g0FnQmrUd9tJ9O8toKEnYt7o5pD1XmD0jUSbaCnbIdFmXD2q
         oc0j+mXlcpbk6Gx4hJmoPpCeMXI5dWMtRQJCHb2Q1HM9Vf4XtqIDeUmmuVZLd5neT4F2
         GwcQMl6TteYgNcsaE3YgjjfsNt64bbcRis1o0q1tdHjouuAmJCSbWWugsIjnApfROdgo
         +SW91YxAQVlG2pAyk4uc6eszRm7epg8bPs0+E+QgD9j4Kgr1rB3hqWc95GIjSbNyvaz5
         LOJQ==
X-Gm-Message-State: AFqh2kp3TXfEsRjnlz0lYovHuGwHFW1auySHQMdk4M8rHg+u1n0qux9b
	Bwvv1c/OAGofPxf5c1EhvFlEI6Q/Rzn9x6PdLW0=
X-Google-Smtp-Source: AMrXdXuRX3iGxgJVTohVZn9PzXrmwlAnwYJ6yU/LKWcFrxKFgKe4FiyCZtPmYi+BznmfdmjECdu7m6UwdR7AVtAfqLc=
X-Received: by 2002:a17:906:3658:b0:872:68a:a17e with SMTP id
 r24-20020a170906365800b00872068aa17emr7392236ejb.159.1675100876297; Mon, 30
 Jan 2023 09:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-9-hch@lst.de>
In-Reply-To: <20230130092157.1759539-9-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 30 Jan 2023 18:47:44 +0100
Message-ID: <CAOi1vP9AAQP7yqrXNRjvahy_t_Oz4+Z-CpT=uHscngC2OMWf5g@mail.gmail.com>
Subject: Re: [PATCH 08/23] rbd: use bvec_set_page to initialize the copy up bvec
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
X-CRM114-CacheID: sfid-20230130_094759_704801_47C5344D 
X-CRM114-Status: GOOD (  19.55  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 09:59:55 -0800
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

On Mon, Jan 30, 2023 at 10:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize the copy up bvec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 04453f4a319cb4..1faca7e07a4d52 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3068,13 +3068,12 @@ static int setup_copyup_bvecs(struct rbd_obj_request *obj_req, u64 obj_overlap)
>
>         for (i = 0; i < obj_req->copyup_bvec_count; i++) {
>                 unsigned int len = min(obj_overlap, (u64)PAGE_SIZE);
> +               struct page *page = alloc_page(GFP_NOIO);
>
> -               obj_req->copyup_bvecs[i].bv_page = alloc_page(GFP_NOIO);
> -               if (!obj_req->copyup_bvecs[i].bv_page)
> +               if (!page)
>                         return -ENOMEM;
>
> -               obj_req->copyup_bvecs[i].bv_offset = 0;
> -               obj_req->copyup_bvecs[i].bv_len = len;
> +               bvec_set_page(&obj_req->copyup_bvecs[i], page, len, 0);
>                 obj_overlap -= len;
>         }
>
> --
> 2.39.0
>

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

