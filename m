Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB91C5B543
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jun 2025 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+ja4+M2xOWPi6Bygoxn28Zjqtj43MyDHO0fI4xSLYw=; b=rCJnUtMZZlphII5RVRefHViw0y
	2xhYWb5mSKA7nZxfour4trNCbT4TiEDo7OxCUmG4mGgEjAC18mnlizSL5PD18ENpp3G8r91uTiMoy
	N5GRD1daCGKIE+dppWNFHzrKzye0y4Mu3nNHmjxGVOjdIluncXcmwNCvPzkvmsCP2pacBvFgLa2cx
	JtO57Mzd3R0tQKnKVaGcH+jIhvLNz9gOF0xvxk35+zniXHG5aV8BTyfMkBXt5FRacbltq0lXeirQl
	FzZ7XP9ikzL8rxwuHohG/bABgVWc4tqEOAMmhdciYyX4QQ+bkFVnSNGcQrIMFLG6KM5O82rM1PSs5
	HxpV95qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN9y3-0000000FVR4-0kVL;
	Thu, 05 Jun 2025 12:45:11 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN9xk-0000000FVGf-1pBs
	for linux-nvme@lists.infradead.org;
	Thu, 05 Jun 2025 12:44:53 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4a43afb04a7so4095371cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Jun 2025 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749127491; x=1749732291; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+ja4+M2xOWPi6Bygoxn28Zjqtj43MyDHO0fI4xSLYw=;
        b=MIwXhO1r+LrLEbzUoIoM6tBSkpMoINN1ehaIi0QNQd+2p3zkG4SuHjpaB0q01/fw0O
         ksOZEc+V+zxxtBtWgZ/+PDR6FoDKzSkzEd6oHiROKIaLNyP1St5rdL3xBjEFQRGELeZk
         40sAmuBzOcTVhPwHz3LaEacth5mJo+1TkdVolpMpp+iACch2nJfXUtL7/2sXMADDDXHA
         ru7YpsW2WP5Ah+kpt5xu9HLh3byOj+qV5hxHEP3eVlLM08ddJSGCW19ZbUWkS0vidxNo
         PRd5VNwOaQIZMzRd940om29Np5Zbff0pDyXI+aGRW6qLCyraUBKEq7kIdUl3P6OHIIEO
         Wh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749127491; x=1749732291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ja4+M2xOWPi6Bygoxn28Zjqtj43MyDHO0fI4xSLYw=;
        b=uKfvjWCwwe8l35+O4cFbp2CVXb2gsAMmNnCDR8arfrcsehQkIuME2Hf/i/qCMMOmBZ
         bgDaQkiACPLaIQAUkWPgc3SIAgA58c9HUMXPZzmuM5KEN9gelWXYi1IujuzByiwPJGRJ
         0CNNCV5q8RhYNH6zA21ncevENeto8a1QzSNoMdTQr+R2Pl7wCQ4vJ5NVL2ECQbDAVzHU
         BZZNFBwNVERsvX++Tl9c7SpYWE6jXAgjT6KsPpmWtzSViNRfVgJsBmLFQdSQHEmT0FyO
         Yli/9FpoU4ul/FX3yn5iskF8t5e8T9wcDJJYVc6uyrXXMVuTJxz0R7E8GUR6t9DRcI9C
         T3FQ==
X-Gm-Message-State: AOJu0YxJ+MAKJY88UZbis7JiO45hCQh+dV6HXn6WFHNYVIixI4e9NmR/
	yYmNz69kF3kfZVd3LXWSOvcLgGjds4/3chRlREn71ZOoRO9OaWpWw11aT9rjtklY88WjN60lmci
	yvDgEMw9d3OY8YTsQ6Z6xLJvMb3S6YnqxeRU20H4S
X-Gm-Gg: ASbGncv8zoh/6jdhBxfhEQUHifJI5KDbfzlGBg3WG35TCBRa92Js7gd1iF0TUrF8hqD
	kGeUWMNbYjQJtDZL6MnXHYt8JQ+AevU2EoNpvFKFurrxfIgnaB5QDaOwvXqNCfRHCTCG3HSwFWR
	O2WqT+0R0GeFrlla35Ieve7hYZlBCXgIoU5uCJ+M6BaFA=
X-Google-Smtp-Source: AGHT+IHqFrG2DFMtuDJWcNH3yBa3lwc6UQVRUn1VXB36hEb5kwOFTUcIAYFHWNVi3s25DT33VFaHpvlR/7SkQZ+Uh4s=
X-Received: by 2002:a05:622a:4d48:b0:49d:89bf:298f with SMTP id
 d75a77b69052e-4a5a5768e7fmr95088851cf.22.1749127490981; Thu, 05 Jun 2025
 05:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com> <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com> <253y0u7y9cj.fsf@nvidia.com> <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
 <253v7paxv1t.fsf@nvidia.com>
In-Reply-To: <253v7paxv1t.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Jun 2025 05:44:40 -0700
X-Gm-Features: AX0GCFuwcu_gh1VljBmLTBOpOh6i_LMFTvbsRpVwTihlPW3hlvD6yXK1BWR9a3E
Message-ID: <CANn89i+y4cKYezwQ6Zr0fr=d6ky8K20E9zYOz=EUiRi_vY8e_g@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_054452_471505_6AFA5C7E 
X-CRM114-Status: GOOD (  14.55  )
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

On Thu, Jun 5, 2025 at 4:55=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> w=
rote:
>
> Eric Dumazet <edumazet@google.com> writes:
> > Adding one bit in all skbs for such a narrow case is not very convincin=
g to me.
> >
> > I would prefer a disable/enable bit in the receiving socket, or a
> > global static key.
>
> We can move the bit to the socket, within the sock_read_rx cacheline grou=
p:
>
>
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -420,7 +420,7 @@ struct sock {
>  #endif
>         u8                      sk_userlocks;
>         int                     sk_rcvbuf;
> -
> +       bool                    sk_no_condense;
>         struct sk_filter __rcu  *sk_filter;
>         union {
>                 struct socket_wq __rcu  *sk_wq;
>
>
> And then check for it in skb_condense().
> We are still evaluating it but it looks fine for us.
> Would that work for you?

This is a slow path check, you can use one bit after sk_no_check_rx,
because we have a hole there.

