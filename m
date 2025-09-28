Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4617CAC5B8
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 03:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krwM3W8psc0mcCtGY/u2spisGNJeWbIPBvcoyrTaZ3I=; b=dXHf24MMbeGbapzniSbHN4znic
	1OeSQKgaQ2OVcPz9eFojh1GgsMDKBjHfHjKQ60K3GzskVmJZ2DoWPYL24ZtcR7Mf8LSSn0+Tfl/vQ
	qY2+PmUHAgK+nXSUzoyUPm//60+gs4K3yyYvM2NfdNYuYBB9QaXcZZQwn8hx1jW3TWbghD+bZQBPA
	p/qnP8w1chtTj4dnpTvc5PY7dbeAzz5KNC1cG9d9V8TeoMtCHnHvn/rMPFSXh6SGXuLTDL6T3rh9/
	uLFpTHFmXIn0JfUVyAJEqlqXRTTRz53CdtWO9XtovMjCC1tVK/vO8x3B3Fnrr9QTbTgsdETT4Nze4
	5A/a6q1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2hk1-0000000DND0-3eHW;
	Sun, 28 Sep 2025 03:06:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2hjv-0000000DN8M-0Y0v
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 03:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759028775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krwM3W8psc0mcCtGY/u2spisGNJeWbIPBvcoyrTaZ3I=;
	b=dAwL9I4BhUErR9/qdFYXcnhCWMQ/wOV9ZLVTSzqj1FsGXw7wYo6H/I14puJL8f5zAHeeQ1
	noEJuQbDkizgOQ158qEVEC+37/Nx5SNdgVmEOvIUWW+p90k7ARl5yVK2OWPGhBxVdW4N8k
	alsqg6GxM9m5wQTyGXgAvVyXgc5ITwA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-9l6QrKN-NtqplUybe3c1rw-1; Sat, 27 Sep 2025 23:06:05 -0400
X-MC-Unique: 9l6QrKN-NtqplUybe3c1rw-1
X-Mimecast-MFC-AGG-ID: 9l6QrKN-NtqplUybe3c1rw_1759028763
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-368348cf7d5so17233901fa.0
        for <linux-nvme@lists.infradead.org>; Sat, 27 Sep 2025 20:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028763; x=1759633563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krwM3W8psc0mcCtGY/u2spisGNJeWbIPBvcoyrTaZ3I=;
        b=htJadQhoCg7PMAlL/rCSgayW7Fc6ghixN9Q565AeI+8JQApqN66CA3PQLyZD6RLyxk
         z4HFaobj2cf7atCc2ArWotXqE8UMHcv1rs91mclvv/uoNmr9Tt0rcTeguy4jJjF+4v2n
         bAJEkVXfN3YmLRvk00D1396wEliaqsmd8ZG8MorG2lHstAfTOE8pm2hYBsnHUPFDa1u0
         C4qmsZpKq5ng5mN+Yb+AA0UGQN8j6kpVbgFaNN0mawU/2MMn11vNRx3iPhXkK9nz4s2I
         c3RTDEd2ueSr/41BVvHAK2SqMkQWGYy54KR7/jjBcQMGCVMMjd4HsDk1D9ANDM/0TX4D
         6lTA==
X-Forwarded-Encrypted: i=1; AJvYcCVOJmOXBqFx4v7DsWz6QFlHu0KO9q65CdsgvZdin+raw572ngqyagTtzk8/l4jarxY2Z82gfCFLO1pS@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0tXw79xh2kSF+07MBsFS4bQ7do2QSexv9ObQjA9Vf/8W+xUQ0
	tjWFZgrjbGBm0fT7fbCIKGP4+GJ5igmslGt6kEhDjpNQ6213VY2x2bmiEuL5wn+TJxujK9ejsJA
	ZgEzecV2eB7MddxQRmZV2a+bRCHKL1xJqVejmHhKIgCIQZxskq81MWRRNY/dYB8vhSGW/2dpt5u
	CkzrYqUSSWiRCDM49s7b3xsYVQTqlqUz4cec0CdVsxCus=
X-Gm-Gg: ASbGncu1WzRUnOvMTdmRyufexgnN9GwBN0dIHJyeqP7CpVuOuwwLDabA+bokjRnNDdU
	TZJXovTcvyIcDITR4uUnZ0gC10PxPdPl/wAMF/oLmPc112GwfSisgdkMr7NdOyMNEZSs+/uFwqr
	LyklYrFVK48X0ypFaTXb5IFQ==
X-Received: by 2002:a05:651c:541:b0:372:8ccc:2629 with SMTP id 38308e7fff4ca-3728ccc277amr7545041fa.34.1759028762704;
        Sat, 27 Sep 2025 20:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbyvIFYAn900ypO644/TA2Uh0Ur9xFGZpD+gKs/PI01AwhPlOihLOvZIx+R93TNYfqfXrfA0crrP9020Cjns=
X-Received: by 2002:a05:651c:541:b0:372:8ccc:2629 with SMTP id
 38308e7fff4ca-3728ccc277amr7544961fa.34.1759028762256; Sat, 27 Sep 2025
 20:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250818093245.41641-1-hare@kernel.org> <DD2QS4LQ8MDJ.ZQ6LZSFF0R0M@bsdbackstore.eu>
In-Reply-To: <DD2QS4LQ8MDJ.ZQ6LZSFF0R0M@bsdbackstore.eu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 28 Sep 2025 11:05:50 +0800
X-Gm-Features: AS18NWB9rBuaGjOwiHdzs2QydKEemPXG6aZDFDF-FF9uSPPLsnC37-DtOFVV7R4
Message-ID: <CAHj4cs_JrogUTSnqZ_6Z2VR0C0EqpQqLr8XSdRprPmgKick4ag@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KoANu_RWqLAnzkJneyK6yn3mO2Ql1LqsE3aFHQOblVg_1759028763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250927_200619_241750_D27D65EA 
X-CRM114-Status: GOOD (  21.38  )
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

On Fri, Sep 26, 2025 at 8:49=E2=80=AFPM Maurizio Lombardi
<mlombard@bsdbackstore.eu> wrote:
>
> On Mon Aug 18, 2025 at 11:32 AM CEST, hare wrote:
> > From: Hannes Reinecke <hare@kernel.org>
> >
> > When the socket is closed while in TCP_LISTEN a callback is run to
> > flush all outstanding packets, which in turns calls
> > nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
> > So we need to check if we are in TCP_LISTEN before attempting
> > to get the sk_callback_lock() to avoid a deadlock.
>
>
> Ping, I guess this patch has been forgotten
>

Here is the patch fixed bug report:
https://lore.kernel.org/linux-nvme/CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3q=
j+uiGCXBAoA@mail.gmail.com/

> Maurizio
>
> >
> > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> > Tested-by:  Yi Zhang <yi.zhang@redhat.com>
> > ---
> >  drivers/nvme/target/tcp.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 470bf37e5a63..2e9a3e698b70 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1992,14 +1992,13 @@ static void nvmet_tcp_listen_data_ready(struct =
sock *sk)
> >
> >       trace_sk_data_ready(sk);
> >
> > +     if (sk->sk_state !=3D TCP_LISTEN)
> > +             return;
> > +
> >       read_lock_bh(&sk->sk_callback_lock);
> >       port =3D sk->sk_user_data;
> > -     if (!port)
> > -             goto out;
> > -
> > -     if (sk->sk_state =3D=3D TCP_LISTEN)
> > +     if (port)
> >               queue_work(nvmet_wq, &port->accept_work);
> > -out:
> >       read_unlock_bh(&sk->sk_callback_lock);
> >  }
> >
>
>


--=20
Best Regards,
  Yi Zhang


