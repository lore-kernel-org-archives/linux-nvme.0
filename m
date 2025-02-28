Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF0C282C1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FgeRbDBZj/Kmr7MOY4QlYhLgpNtskrfBfuQ+fdrrXK4=; b=0Z4sACynDCbrod5CNAhROqy7Ba
	mm2bZ7RNSZj3YpIPdhNvBToNhhk5SLfY9sNbHOIeJsMJGvZ7+tnrgfelgdmonXP+QBe/ee9iU2V0L
	UvwSJx4p2c5MoLCp0Xsc0DGPnalj0yFfw6+BbOKFNAfQqK1nFX8wAmOZr4bv1CjMRXpVAe3c0obzv
	w9nQ/CTq+jQJFKLzCZYhFuacNh1zWB7W85oMkeMIeJf8zcRWLb0dHEBUcatmEGqAT2260ThopBele
	+HF8CtXVuei5qfIgGBoYESitWRV8AKROPUoDevx1wyYbGDq80GlR4vRYweRZ6Csa3rZ2un/oftYiK
	XH3a6R9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to36a-0000000Be0O-32Tw;
	Fri, 28 Feb 2025 16:20:52 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to35w-0000000BdtK-0Vut
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 16:20:13 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so605166a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740759611; x=1741364411; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgeRbDBZj/Kmr7MOY4QlYhLgpNtskrfBfuQ+fdrrXK4=;
        b=I3KYsXXragHsUIdg/cDzOiBdw1rpi1DXo1FxeUERtEi8JKfWBwN3Jxjl+kfQlfty00
         ygpHrjandB6KROZTI0kOxKocsoMAJPlBpfvsAQJuhavsOQHjhziuY13q27ftSxd3YElU
         ZdeUOZhOGXZCKCQKXEHWR4MKyK1jqNqTMVX1Knvh+cyGphjauDZb80morQ2vzVnddrkL
         ou7GpIg1z1uVjIgweB1N5u5YxSmhYlYCJWqJ+WFOBdrd7Mka8Mmt7xCZigNvsxxF/Tqg
         aJ0j/PVa87zmJXNhBfha0Pz2pTuagd8yA20uZ7AQJB1v30hcsMMij2Vp3DGUGTFAWiZl
         3TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759611; x=1741364411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgeRbDBZj/Kmr7MOY4QlYhLgpNtskrfBfuQ+fdrrXK4=;
        b=Oq8xIpU4219pXfWbjy/c+/m1HJLGP5cIx6S6+Gytm6lxEHyTRxLa0IJvYEAcmHWrVw
         6Xs4gcKWve3fnHWYtNxMtFz6rxHDxmI0OX8zkx/9T2erqNxjZWsORJKR6GNqlpDiDm29
         eUOKEaXaFUjyTsEAx2HuSheLxP3JZD8rZHmqZwfRkhW1/OJQhGXSv5iJK2T9fERIS6qs
         wfQz8KNgXXXT4f4HFb9RTBKW1eWjjkMVPZ8yuxDfsG6bD4VQoiQZearV/7R1Eloy7nDf
         iLdLiYEfeNDudiQdTTdcUgUAdPeCQN33C0dHX+zJI92mtsu4nfiNdyU90kErIH0B6o5v
         bBAA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/J/ATZ7Tjs/DU7lin00nN2HQNSEJX+k9NlwC3p0Z+aApV075/966M3hc/MbcQSSvOqa9OrThRLg5@lists.infradead.org
X-Gm-Message-State: AOJu0YzUSrlHQ9grTswoNTwuPMAQI5ySe3nO7hjYQz+3GVaEY7KffZ/w
	n3WFw+KC3RbSbXgXbL97xCteX11BYpgjMbuqsD7LBaWfDUQqHC/AanNq8Dl3hm4CVvawy4KdO1y
	xfXdtQCTrx4fUFgKDEgShkH11mzuzNU4xMT1FoA==
X-Gm-Gg: ASbGncvDmUa6L1rRyFiOO7XinPrP41rt4ZbORio8OaVenwwk739DMfh+XWAwK+9b9mG
	dVIunoLxngcZtIGfH6eApsQUAG4hDw9zIBGXpjfeMy/7FKc4SKYJBIPmw9IE9EkVBexBkAXcyGg
	vA6O3BQw==
X-Google-Smtp-Source: AGHT+IGrPFexLq2p08fvEV+7vi1y3CJa/f7XRnyFy9qcLiZdIYOI/25rvbAAY8P6RNV0DwhkcTgV3GIHP6AtdYEir/o=
X-Received: by 2002:a17:90b:1d02:b0:2fc:25b3:6a7b with SMTP id
 98e67ed59e1d1-2febabf856bmr2465912a91.6.1740759610894; Fri, 28 Feb 2025
 08:20:10 -0800 (PST)
MIME-Version: 1.0
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Feb 2025 08:19:58 -0800
X-Gm-Features: AQ5f1Jp0gEH4Qx2IhSi_EgMbX05yYyRpMAompI303gVwrEuEcTt5M__EGuq2aTo
Message-ID: <CADUfDZroCBhuJbc2jMsQAKhMZF9y3Ye5zowhusbUFqOdaA7PZQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_082012_303254_D0507FBE 
X-CRM114-Status: GOOD (  20.16  )
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

On Fri, Feb 28, 2025 at 1:39=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
>
>         if (ret < sizeof(*icresp)) {
>
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Add a cast so to avoid the type promotion.

"so as to"?

>
> Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial =
ICResp PDU")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch, thanks for fixing this.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8a9131c95a3d..361b04ec5b5d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp=
_queue *queue)
>         msg.msg_flags =3D MSG_WAITALL;
>         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> -       if (ret < sizeof(*icresp)) {
> +       if (ret < (int)sizeof(*icresp)) {
>                 pr_warn("queue %d: failed to receive icresp, error %d\n",
>                         nvme_tcp_queue_id(queue), ret);
>                 if (ret >=3D 0)
> --
> 2.47.2
>

