Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E2EEE57CA
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XAmWZXxttt9n0R6KB/WSt+Zpt3ntHIlEbsHWqNmT1/k=; b=trXzlNNpRAU6jwKKDGWVWT9jg9
	mT/8kEy16kZXXATrB5yJiunb/BiONIQekDHqFhcRHRzIkuDpKy69nPNwzaogZTqNn54dKiqRADxLh
	M9uLt7w8bipOmfKGmA0jpaYK/K2QMZxmwAMDVxYVTiNC55jgGlNGiR5DHC37jNfRf7E8q3HlWilfW
	PgL/T7KCBrzZ7prw8RzxH/I9IU6cGqgt57K9qig6fOPcjrXeGnQgQK/FkKLnXtr/MNOSRpMOMxruw
	J0lpsnxbTiKq30qcuDu3R0rY8jwPPN2GSTGZL5eBcpJ+IwklQqNb6I9/b+z09GPdr24uzrWaZtFV6
	HrTVPIag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vajqF-00000005UU2-1nv0;
	Wed, 31 Dec 2025 00:13:31 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vajqC-00000005UTI-2qGK
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 00:13:29 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so3673572137.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Dec 2025 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767140007; x=1767744807; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAmWZXxttt9n0R6KB/WSt+Zpt3ntHIlEbsHWqNmT1/k=;
        b=Omb0ZIRtHK5L8i4mMvXwC8pu3YgQXur+g3Ipz4g8l4lKjI6c+QOZd2xemSFvp4RVNP
         Gnh+b0tKAqbYoc5+qhSeT6Mre9ba35172U/VuK6etKp04fkjHflEGURfu/AE3LOgSOs+
         Bw34lG1VvLwEmD5QaH4sU3kWHboPQ4bj4BucRhIxuN2c2Azn7iT5JkcuOK87BxoxcajW
         FXdfX8gfayRP4tsU0lkjuBiLbUMlu9CqtVHMdQHY4RVjrv9JFHVS8lBwcj9r5oCK6ixh
         6tWZUDnzqynQFHoUpwEuBcd3XB5Aij+dLfLCTUCZ68/+9MRT0X4YTY6I20HaUoRp13W6
         4vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767140007; x=1767744807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAmWZXxttt9n0R6KB/WSt+Zpt3ntHIlEbsHWqNmT1/k=;
        b=RifOzzLx1fxZBxlCSabF1xt8oXE26k0N173ej1SGQ3G12xteGrszdeARGJy+vwBJ0Q
         tI477vYrHf7HG7YSSfNfnbfU4LLSHf5cCwS5xqzxH0CF/ypxMmq8uT3T7Bw4FHyTJfgh
         U9Djoogd/6SAR/4uAyN0PKI32i8h8MFcx/w83JqbmqO6Z/FQxJwwTOub4UZVjMrzeK1X
         ocWc8TYBnfYgkcWPuh4WO9IDK5Wva55GoyCFjIiXnEHQ057f0Wd5fnIM3Afe2CfbgoKe
         8Vtnjm2ELumfTOAq38kskhEoJimPCwgOxnrJZqo4X8RdVVvEsSUcpzvI7/u5vmYiIzrX
         2GkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZmuh1k6TzGJoRS9KydenKHGmdLKyQMhLWQW82b7wJKywWVv1EITlKhqG8Dgg7AF6NoM+Ky/E1iCxA@lists.infradead.org
X-Gm-Message-State: AOJu0YxhdrggquBWzvoRPHz4U5fkhP5yGmfIezHfV/Ee7dCv65e/l+WD
	N3DI2i0U/EP8UYTuC+V0ASYwwSqz0myFjYSmdhpb+BIc2UK5E6ahlKgS/htsCUlVaU6l0uaiVNm
	ZMWKWeBa1Y8X8We068LU6M8LGKvVgcE7WHL36NlROaw==
X-Gm-Gg: AY/fxX5wXWslIr1c5d3RH79vgVeT7ulxRXKAzohQga4SQxvVyHhP9v8Bn/mbdDppFC4
	OeMz2JkJcYbKmvmadGt1b2RAdWuz6P00uJZfdb/DIDks9l32DjQP4Km0ggn6BfvbW84bNZ8o+L2
	Tv2kXlRUZbPhkIf447jzVW1Rk8jAb8QpibYM/jreMbmK1NqVYtyt23ZJYI+OMGUoYZK3Msxostz
	gw99tRbJlGMLU962comAJ0e2+zlH2t1409TyAbRR2pU0hlIawXOqv0c2YEsgnwRw1xvruSnOnaM
	XDRXXw==
X-Google-Smtp-Source: AGHT+IHJoiDbYVRupeMyPyw6s3A+3xwVSJiIVFXkfzjcR4XUzJ8+e+g7XQsZSVevvUNv7MsmQQOk4Wu8ymn1EvsmSzE=
X-Received: by 2002:a05:6102:6b01:b0:5e1:82e5:200b with SMTP id
 ada2fe7eead31-5eb1a817e40mr10371410137.30.1767140007277; Tue, 30 Dec 2025
 16:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-11-mkhalfella@purestorage.com> <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
In-Reply-To: <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 30 Dec 2025 16:13:14 -0800
X-Gm-Features: AQt7F2rdxlzDAY75v64pqW79gxkGGthemhWwlIUj4omLQbVesNbCO1W3xWn5Eqo
Message-ID: <CAPpK+O1g+Z=CYDfA1u6-iBx8L5tuhFOgipbyVvmj=oqW9UbLkg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_161328_724338_EAC626D4 
X-CRM114-Status: GOOD (  12.91  )
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

On Sat, Dec 27, 2025 at 2:35=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
...
> > +     dev_info(ctrl->device,
> > +              "CCR failed, switch to time-based recovery, timeout =3D =
%ums\n",
> > +              jiffies_to_msecs(rem));
> > +     set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
> > +     queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, r=
em);
> > +     return -EAGAIN;
>
> I don't think that reusing the same work to handle two completely
> different things
> is the right approach here.
>
> How about splitting to fence_work and err_work? That should eliminate
> some of the
> ctrl state inspections and simplify error recovery.
If the work was independent and could happen separately (probably
in parallel), I could understand having separate work structures.  But they
are not independent, and they have a definite relationship.  Like Mohamed,
I thought of them as different stages of the same work.  Having an extra
work item takes up more space (I would be concerned about scalability to
thousands or 10s of thousands of associations and then go one order of
magnitude higher for margin), and it also causes a connection object
(referenced during IO) to take up more cache lines.  Is it worth taking up
that space, when the separate work items would be different, dependent
stages in the same process?

Sincerely,
Randy Jennings

