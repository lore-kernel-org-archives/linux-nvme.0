Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B1C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 04:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBtLiqsQAZNornH5wgD7b3jJYD105S/GiDk49aEDwGg=; b=PiXZVtKCtAfAvM137x/vbiPvZU
	OXiT+Wtp4xWzu74QQvTspapdT7sstBnk4WGnhA5+5N70D1/Ou4+V1nG47SKYQxODa46AsT/9siBVF
	FlNAThoVu3KeTYV9Wze2fotSrHZbbBeTC7zBuZ9uc49wH1WQEQtnWJpUGrfyfS3XJYrBe14Yzl2BT
	/rBAhIOiunf+nU9g+Stp9wPqH2YwGuyauFzFxCuw6tfvDJY5NATMsRPi9nxxryY6Ulo1gIw6mhtWn
	gIskUQ9YmpyA39uNML4E+L+wE0jnvsnYs82EmsjyiBi6ttCZrnpmpqNeHnv/OSPpk/yfcAahwB2zD
	pomporaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC9uY-0000000ADQM-2Gil;
	Tue, 06 May 2025 04:28:06 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC52W-00000008zyq-0QFJ
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 23:16:01 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so341596a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746486959; x=1747091759; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBtLiqsQAZNornH5wgD7b3jJYD105S/GiDk49aEDwGg=;
        b=G2PmN4+Rk7oyEmoeKBfefVM5eYI2Zr8jdIcQG4wgVqqMZk3rCGNkfhyG/2YnlVv7Rc
         QHYrBseaWk/f3r6hKqc9XTaPMmxpfjpYM7eGN7HPOOaJDvSQZD65Kq5Dm1/CKPYxJa/X
         Gz02g/KZtuxVRscB2TQntgWot0444qoS5MLcXlhYsGIQ3i30XjBksjI91NfbXr+e1gJE
         WJrCGR8j6mDx5ME8gEGPbL11wNYpmO7bi50WN7o7lL8h1FWdF8XUF2KwZc8tA85oB0XB
         OlYdm3enfgzMaG5Um3WREis4mxSyu7Lm8A+iRwyLAsigrLewNt1wImS55GMX2oN+onCF
         BeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486959; x=1747091759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBtLiqsQAZNornH5wgD7b3jJYD105S/GiDk49aEDwGg=;
        b=G1p5jXm3eSMwEZ7oraw4WwViFAjJ9ICp9unUqnfK6FhBsGmX8UMn1Qxs/n4Ojg5foF
         194lOzhyZuZt7gH7G7DIGurEjn9gOZEVNvCsgGABJ4KpqXUvWVXlW9bqQvD/OIwAPHAU
         lkJVYHxguW4EEyl5+Vc3Pnr9oRHXianGKuM1mAVbxu+g/JgyZl3nggkWFZkjJSwZRbwW
         Mcd/I/QV9JrfkSUs49nqiVSs7/U9IuLIc+iQqlQuiCs7jGBhF/Teq5B/O2yHnXug59aG
         6bKkV6WbHk1wpmRBbCLmq6CNyB7lTl8GKhXRdEk3i8uA6DBi7V+6OuMNfE65fwaNJPkw
         alqw==
X-Forwarded-Encrypted: i=1; AJvYcCWVlwaVv3QxTCnb5x1Mt7aq3fupqCIuOiB5W4MVuRbw0IEw70IZWoCj4gWYTeg+CIdZ4Du0w5YYnbjr@lists.infradead.org
X-Gm-Message-State: AOJu0Yybm4jqc5a2+0bbGYit8ARWcb5hVPaS0P7XrRVU4bZJupz1KZ8U
	HfLNeASfT5fGiihBZsO8CgklXyNv5FbO7QZPIetMK0BDorI34YVoofjrN7BKa4ruWAXOU2HAPW1
	sShdXpzfLD25DallHLmBLzbQ04hMnHDSvPytdy/ptW2HoWgCwP9E=
X-Gm-Gg: ASbGncs/eIxM91R6dDvf7ZPA33xVjERToef3tfDErcB9hlJO+hflaphJqcwEBVQpKLj
	N2RtEHgBw0yW/nbE+h9TaDni2BzA+ej6fviLb4w2XfAKEvNdDLdhdNhdVlGMWQpgqUkyCyp5Cn3
	ViB5FUCY4RBFillN44uq9I
X-Google-Smtp-Source: AGHT+IGagPTPgVx/zK3NsPeBBD10ssAbHcDl4TLAybNA5eLO8eptE6YlSL4cJMULg3pPnx1zFjy8HZWl4F2Kr8E+HKM=
X-Received: by 2002:a17:90b:3842:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30a4e6aff6bmr7959705a91.7.1746486958763; Mon, 05 May 2025
 16:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-295-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-295-sashal@kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 5 May 2025 16:15:47 -0700
X-Gm-Features: ATxdqUGHxmzJ-iTUgsy67bI6uusSMYHzrvElI7q_8rFZmVYMhnN19Tk8UkIP6Bo
Message-ID: <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if
 address is 0
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Xinyu Zhang <xizhang@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_161600_286502_C7407612 
X-CRM114-Status: GOOD (  23.19  )
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

I wouldn't backport this change to any releases. It's a potential
behavior change if a userspace application was submitting NVMe
passthru commands with a NULL data pointer but nonzero data length and
expecting the data buffer to be ignored. And supporting the data field
set to 0 is only necessary for ublk zero-copy, which is introduced in
6.15.

Best,
Caleb

On Mon, May 5, 2025 at 3:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Xinyu Zhang <xizhang@purestorage.com>
>
> [ Upstream commit 99fde895ff56ac2241e7b7b4566731d72f2fdaa7 ]
>
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.
>
> We can skip checking whether the address is NULL before mapping
> uring_cmd data. Bad userspace address will be handled properly later when
> the user buffer is imported.
>
> With this patch, we will be able to use the kernel registered bvec fixed
> buffers in io_uring NVMe passthru with ublk zero-copy support.
>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Link: https://lore.kernel.org/r/20250227223916.143006-4-kbusch@meta.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index fed6b29098ad3..11509ffd28fb5 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -514,7 +514,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
>                 return PTR_ERR(req);
>         req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : =
0;
>
> -       if (d.addr && d.data_len) {
> +       if (d.data_len) {
>                 ret =3D nvme_map_user_request(req, d.addr,
>                         d.data_len, nvme_to_user_ptr(d.metadata),
>                         d.metadata_len, ioucmd, vec);
> --
> 2.39.5
>

