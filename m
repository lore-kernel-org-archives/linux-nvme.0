Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D84C77B7E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpOBAS8Bi4kBG+sylQuaVNwQB72hawQBUTtbh7SjPqA=; b=JnawD9f33pDvfX015pAZg1Pnox
	dfgTIYTdgF8jGwsIAgzm+7BSvZzALwvop54mPTKp+nI9IaF8+s4BOMW2bysITkkj4WLAKAnmkFsZf
	b06wOpSVL9C3D5sD8WbgRRMANMXkEfodT86WnWfFelJ5rEJAECgp7idj2TTnBgXrZeDyS7rWIXHly
	cR9+9u9al90qmGb9bO79vhFc4318rYOXVBY0AEk1hySyFPjmfmWbfAIx24XOErbM42AV8CPFJYp+q
	mbA9/lqjfBFq6eETsjSvqcI96hqJtDxmi6RqEo76numjwQOKSDXE0+032Ot5MC9qCbVqcoQUZEdZ2
	bWL6BVLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4jog-003x2k-2T;
	Thu, 01 Jun 2023 15:02:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3xXc-00DeeZ-0S
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 11:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685446166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpOBAS8Bi4kBG+sylQuaVNwQB72hawQBUTtbh7SjPqA=;
	b=B/sTW0SE7F6H36fs6qw9rv1x+lZq9zkDir32hC1uRG2yBv/N0OFHnQSbmprDZ8VPwMnmWc
	ThWsajj81IH3FMBovJIZk3e8G1BWFoqXGd4lEVpEtBIC8e/Xw+miirHc8cQwXz0lwpfc5Z
	dlUB3EWDh58aPD0oQBZpc638Rjtx+FI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-wcL1RqhGMiGH4g0FX3hHaQ-1; Tue, 30 May 2023 07:29:25 -0400
X-MC-Unique: wcL1RqhGMiGH4g0FX3hHaQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4572f83f5e3so826596e0c.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446164; x=1688038164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpOBAS8Bi4kBG+sylQuaVNwQB72hawQBUTtbh7SjPqA=;
        b=MbsjgqBsX5cX4o5pnPpdLw7VrLhIzRX0R0NX4DziP0swJXVm6TYf19LKH7gQmwxXmg
         /33QbToQs1vy34PqBniIYJNECnsMtcqseKUdCPYaJO1+8tmiv6546dOcGLf/AnLO6EHR
         7hGQMlOJbOFUhLcjN/mBUsLCwuSeW1ywEjsq7QKblZC/yf8MeNwV7F0mEoV7iIXQAUZH
         7fkhe/rXrEDSZHjGIz344bI7wwTxfbX0IciUlcCEihe7L2H7LTvc0/GGrFyTbI1rCNqk
         PKKf7gyzZVNstNSN+QGycKBTJ951wlTkYMXN+qHmVs6trtXJaFy+c6lCk/IvIYqVZ7gA
         45tw==
X-Gm-Message-State: AC+VfDwBH+nxMYW0VkhPGAmLFvNiUwxLMPKkth/PjWkSYxclxswTAxnv
	xT7fbEZWVDn2w/qFW6oSlK6QHGqfUJiVqdOw4Tf0+X2frTJtBEOe7e6k5kiUtPJPgoNGmsuQGiN
	gIXYP/S1G2MHudcZXNvC9UDk79ts/GKW068klgIlc9C0=
X-Received: by 2002:a1f:4b45:0:b0:44f:cc32:1585 with SMTP id y66-20020a1f4b45000000b0044fcc321585mr396093vka.16.1685446164688;
        Tue, 30 May 2023 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60g8d6uIJQJ6uxHej74jlrBVrcHx9EcH35VqVEe7Tezem4ctVekj51qYF9EFj7YKA4koNTixi+3DAOC1La86o=
X-Received: by 2002:a1f:4b45:0:b0:44f:cc32:1585 with SMTP id
 y66-20020a1f4b45000000b0044fcc321585mr396070vka.16.1685446164430; Tue, 30 May
 2023 04:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-1-nj.shetty@samsung.com> <20230522104146.2856-3-nj.shetty@samsung.com>
In-Reply-To: <20230522104146.2856-3-nj.shetty@samsung.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 30 May 2023 13:29:12 +0200
Message-ID: <CAFL455nMtKbDt1HeN6D2WPB2JjOYq2z1=RagmmuhmQ33eL2Bfw@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org, 
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com, 
	gost.dev@samsung.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_042928_264699_7111EB28 
X-CRM114-Status: GOOD (  13.63  )
X-Mailman-Approved-At: Thu, 01 Jun 2023 08:02:17 -0700
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

po 22. 5. 2023 v 13:17 odes=C3=ADlatel Nitesh Shetty <nj.shetty@samsung.com=
> napsal:
>
> +static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t po=
s_in,
> +               struct block_device *bdev_out, loff_t pos_out, size_t len=
,
> +               cio_iodone_t endio, void *private, gfp_t gfp_mask)
> +{
> +       struct cio *cio;
> +       struct copy_ctx *ctx;
> +       struct bio *read_bio, *write_bio;
> +       struct page *token;
> +       sector_t copy_len;
> +       sector_t rem, max_copy_len;
> +
> +       cio =3D kzalloc(sizeof(struct cio), GFP_KERNEL);
> +       if (!cio)
> +               return -ENOMEM;
> +       atomic_set(&cio->refcount, 0);
> +       cio->waiter =3D current;
> +       cio->endio =3D endio;
> +       cio->private =3D private;
> +
> +       max_copy_len =3D min(bdev_max_copy_sectors(bdev_in),
> +                       bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
> +
> +       cio->pos_in =3D pos_in;
> +       cio->pos_out =3D pos_out;
> +       /* If there is a error, comp_len will be set to least successfull=
y
> +        * completed copied length
> +        */
> +       cio->comp_len =3D len;
> +       for (rem =3D len; rem > 0; rem -=3D copy_len) {
> +               copy_len =3D min(rem, max_copy_len);
> +
> +               token =3D alloc_page(gfp_mask);
> +               if (unlikely(!token))
> +                       goto err_token;

[...]

> +err_token:
> +       cio->comp_len =3D min_t(sector_t, cio->comp_len, (len - rem));
> +       if (!atomic_read(&cio->refcount))
> +               return -ENOMEM;
> +       /* Wait for submitted IOs to complete */
> +       return blkdev_copy_wait_completion(cio);
> +}

Suppose the first call to "token =3D alloc_page()" fails (and
cio->refcount =3D=3D 0), isn't "cio" going to be leaked here?

Maurizio


