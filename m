Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A64D2AB3B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXEU0K+HVbTbvp27dG/5AsENh9x1wq4XCrDbezUDB6I=; b=Hesk4UetczEzVF36h79fRjkWgM
	yeFc/lWhIWOQjIplGr9HXBZfdjiDzIXR34Ks01oLHKxP9f6+AqW4H8tgfQV8/8ZU1LV0JL18tMMx3
	lTxpjTX4Y8z3yVRcd7ezLDYkXwk4r+ssDgRFoPq1hkxBjYaWX0rjwb9EYrSJVA6X4fk6YsenBiYBX
	09kayKSFWJs47nOFJ7PsjRypoiyE4wPyCHpdC4PJBmELNaNQTQA6zO1V2CzmvIAdetPhEHp5jN5Np
	z9MMiDIm187+I4yD0pZYFbuRxcP54XP0bJyQWy3/ImG7uLVMTTBweladuvP2l1yAC2DX9K5YN0NXD
	7ZhNpckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5m58-0000000EXVq-1GuK;
	Tue, 29 Oct 2024 13:16:22 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5lct-0000000ESYE-0Ios
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 12:47:44 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2618972a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730206028; x=1730810828; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXEU0K+HVbTbvp27dG/5AsENh9x1wq4XCrDbezUDB6I=;
        b=dsEvOsxEAlzJGoNligUO30pf1LjXT0KAXZl7KqIxbwqWBn7tPNLblZt+ghUs3OMAeF
         Vfwva4JG7ofCG9dTzM5vz2pGOuDFBQ7BF3VVCD/EmzFlhsjW9P9aCtjtwcqvfQuOkBfV
         +xbT1MoTVAXEnhsVt/h+bsHtvcPTTXv0D8tFS40y2/KrrR6QS6xpFJEurcWFLtfe38MW
         w6lajHOeYXw3zixOBA43I8t3h7tfXxvJn7MCyBsdli2kkTA3YqrEWSx5X52A0AYYE/vQ
         ZVjm/NPWwa+tJhCQfU/WEz34WMYuLmq1WRiYdOy3qIi2VAEhGvzOdy2ojMsDz2QpAxUo
         VuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206028; x=1730810828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXEU0K+HVbTbvp27dG/5AsENh9x1wq4XCrDbezUDB6I=;
        b=c/2QiK6a3RXRNx+GY5u6TFpl2C9tc66dQIvJFqKZxgj/XrCldtALLxArbmi6Ak7zAx
         +D8kbVslePxVBsbt4C/+fX2Jli9Nbe0owsoYK0gy42uQzDenzg3yh8AKS9LfBSAv6jqz
         dpW7uXODijfPGB1Zb0phaoluSQujWTznEMh7NpjWAiY5wuZAD0078f/VxF3+qJXDcydX
         OHjHfXlEg7ThAvJvMvMcaG9EtiaNki1V9G6qdHV7Fmh+wETb3a9O+ToCvpnlj+OKrZux
         Y/p13WCsIUuLCGEkvazH8FnNmBjvUZ90B5j97VSDX58m5T+r0xJX1tBnUWN5d7v2x7Cr
         DVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUYHoVGNqARuqYuM2+6NDJwq7H5Z8VyXmqo/sNFVhyexXOX2JqNHH9WMWYd4NPGsR8Z3USCWc2abebn@lists.infradead.org
X-Gm-Message-State: AOJu0YzjcOpajvymJjKDQNLP4HlHxfc3Oc4ku9l/yv33g8gM6G+hoL5x
	eHySsK+r17Sg1a8+I6AXJUafBr9sa7hTzv0H78K9HNdC3oREI4OeDu2LrhgWcMiN2wjuehe/mPd
	ZyuPKIeYsjuX7neVpXsuqGIhEfQ==
X-Google-Smtp-Source: AGHT+IH24jDXrN1/rLUODZ7dXWnQNAXgArrAqn9CD/XkQZPaaSbgd3HS6kL07anh4QVcaAdjYqc8XepfsP8tIRg++xU=
X-Received: by 2002:a05:6402:348f:b0:5c9:34b4:69a8 with SMTP id
 4fb4d7f45d1cf-5cbbf889850mr13754716a12.6.1730206028117; Tue, 29 Oct 2024
 05:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-6-kbusch@meta.com>
In-Reply-To: <20241025213645.3464331-6-kbusch@meta.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 29 Oct 2024 18:16:29 +0530
Message-ID: <CACzX3AvZ=+cBaoZ9oKW3osA1WiWm5H5b7+wWAouLryK4-ymYfA@mail.gmail.com>
Subject: Re: [PATCHv9 5/7] io_uring: enable per-io hinting capability
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com, 
	javier.gonz@samsung.com, bvanassche@acm.org, Hannes Reinecke <hare@suse.de>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_054711_143901_22D24009 
X-CRM114-Status: GOOD (  25.87  )
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

On Sat, Oct 26, 2024 at 3:13=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Kanchan Joshi <joshi.k@samsung.com>
>
> With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
> all the subsequent writes on the file pass that hint value down. This
> can be limiting for block device as all the writes will be tagged with
> only one lifetime hint value. Concurrent writes (with different hint
> values) are hard to manage. Per-IO hinting solves that problem.
>
> Allow userspace to pass additional metadata in the SQE.
>
>         __u16 write_hint;
>
> If the hint is provided, filesystems may optionally use it. A filesytem
> may ignore this field if it does not support per-io hints, or if the
> value is invalid for its backing storage. Just like the inode hints,
> requesting values that are not supported by the hardware are not an
> error.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/uapi/linux/io_uring.h | 4 ++++
>  io_uring/rw.c                 | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
> index 60b9c98595faf..8cdcc461d464c 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -92,6 +92,10 @@ struct io_uring_sqe {
>                         __u16   addr_len;
>                         __u16   __pad3[1];
>                 };
> +               struct {
> +                       __u16   write_hint;
> +                       __u16   __pad4[1];
> +               };
>         };
>         union {
>                 struct {
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 8080ffd6d5712..5a1231bfecc3a 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
>                 rw->kiocb.ki_ioprio =3D get_current_ioprio();
>         }
>         rw->kiocb.dio_complete =3D NULL;
> -
> +       if (ddir =3D=3D ITER_SOURCE)
> +               rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
>         rw->addr =3D READ_ONCE(sqe->addr);
>         rw->len =3D READ_ONCE(sqe->len);
>         rw->flags =3D READ_ONCE(sqe->rw_flags);
> --
> 2.43.5
>

Since this patch adds a couple of new fields, it makes sense to add
BUILD_BUG_ON() checks in io_uring_init for these fields to assert the
layout of struct io_uring_sqe. And probably a zero check for pad4 in
io_prep_rw.
--
Anuj Gupta

