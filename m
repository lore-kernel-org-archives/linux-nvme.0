Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10E5CAC5B8
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 01:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=; b=GiMM/dPH1Y3q/pp/CsiaVsHtMW
	kavHx7HdvgII4NxRKkpCgkKCNsgXwO3773r4SNTFyf0GECOefpx8BGy2JVuH4pG7PYQKU9fMHPTaP
	wW8aWq8cyr4zVe+5M5EnvlrapWy/A1bjZ2jPXTaP/YLLZs12Z4j/8YbTX3WNAW+0xLHzZiPrX4pD7
	UiNYCt7ADh3Mchjc6ENiRTFZcbk0VxOVdFC+2QHkyFlYNbX7pqNYwMx7pmqe33K2+w00Lx/THlh3o
	oKaVb9ABU3A5dSaqE6Fuwh8Avym0NGgPrvYsHtZKShxgHOEY6K3zdymqivmJuvjceX6zGlhO0GRwp
	w15w4arQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5wPs-000000017QB-3bak;
	Tue, 07 Oct 2025 01:23:00 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5wPp-000000017NX-2TLM
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 01:22:58 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso11634924a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 06 Oct 2025 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800175; x=1760404975; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=JtTNK4PRLgIcYlYebblPckWArgDEB4kaO8Xn7gdoajUfulODSGafy39dR7uH5OrA3f
         xDrXZEGHxJxAm7wlro8jpNUjapbuwsKJsh9rLjIgmG/yd7LKFJSGaNPHV2T1wUGBAYfi
         bfuyJUTxO8HvIRcdyFymvOEeRHp5anTW9xR4hIzl+gNQp/l9qgIyfElmIxKj7YyDZ3QX
         Lffovu4AuU2fukwqCT8pfxy10PPh+76B77cc2Fjj4pqDQX17taJn7P+jopOBG8OalMK7
         5XMSTX9B3JeAVpLx8pe468ASna6ijbntqI37VWvG6VjmEkabkK1at1NiTphwFCov+JyG
         TQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800175; x=1760404975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=P12OObdeanjoOyYgs1dEbnGMM1zGy8WcVAzPcHSA3/+UDI2cIQNe/+nfvWvRYSk1Mf
         07hNpPJjOzKi329pKr8noe44jHW5HOuaQb5CBux9n7NuywmLZ/i6uiUawLKWL9b11aNt
         29xs9HWNF/t7SZdM/RefZMLtU10Dy0JdNjJgrLBF61t2Zze7gGXX0H3HlfYnKjgZ6929
         Reh8/vU7rkDjLMW8d7YY5oIqT9cPhZj0Zk11pGnxnVWEpsbv0CWSpJENVlFmszj1P4P9
         wC3e/gyPUM/Sgh749skEIiZ3pznLC8D61D9hZbhsY3Y64oHFlJLTnofHBOfhdtxqGXDf
         OCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXx8olwjYSmwd2nzyo4TgfZKzhY+EPunLoP/QbZszcuOWLX0FiTFkL0uzEksCwmmyhDVFUzjJaWWNmI@lists.infradead.org
X-Gm-Message-State: AOJu0YzoPGtgLmptDu/q0vU/SIYdyt0J2+8Stz2SS0R5K7r6yW8+CZuc
	1ls/H11ORwWiSmJt1HfdxGugOTa0kSAowv64K5qr3tF+ZXWY2/zZNJNBefFcg2I+v38FLVv/Ymc
	hD+nL/+3vTfjKFshEFa7qdy7cON/jR3c=
X-Gm-Gg: ASbGncsacqO0co4GByp5lJcWHiK863u4UxSjriAtqiui0RzK6s3tkaBYTFyGk3Wwnrq
	ahmB9XxTAba9EHmYLadku83AGuDKt1r5lGll5j0xdt0tq1tBA0NG4Y4KCjXWbJhlvrKDXuCd3fe
	SCkQo1sDFS+SR36rUVziVMOZbCEJ4yKAgL+IdHJ3nnq8ka6DJ1r+i20TQmvcj3t9CCzJ5Dwpt8h
	Rod1Yl0o14O/qYkK2a8jjggCVzHqI77jcrXfI2U9373PQcULrEvGwN6ZC4PCA==
X-Google-Smtp-Source: AGHT+IEqVioe1S+GxtMPUCva4kG5CmfdDTTGDPNdiniLUblABnKsGagheixLUyeC/Xqdz84Zg3zCalpzx4OwzsmlUYQ=
X-Received: by 2002:a05:6402:b0a:b0:638:d495:50a7 with SMTP id
 4fb4d7f45d1cf-639348fa973mr13226165a12.16.1759800175262; Mon, 06 Oct 2025
 18:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com> <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
In-Reply-To: <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Oct 2025 11:22:29 +1000
X-Gm-Features: AS18NWA3ErD_gS2cWuFH4B1EU9R8Gp49Hxw1eP3L2D2MX2i73c7hEabcslLmzvQ
Message-ID: <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_182257_645747_225DC483 
X-CRM114-Status: GOOD (  22.71  )
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

On Mon, Oct 6, 2025 at 4:16=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > To avoid future handshake_req_hash_add() calls failing with EEXIST when
> > performing a KeyUpdate let's make sure the old request is destructed
> > as part of the completion.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - New patch
> >
> >   net/handshake/request.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 0d1c91c80478..194725a8aaca 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, =
unsigned int status,
> >               /* Handshake request is no longer pending */
> >               sock_put(sk);
> >       }
> > +
> > +     handshake_sk_destruct_req(sk);
> >   }
> >   EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
> >
> Curious.
> Why do we need it now? We had been happily using the handshake mechanism
> for quite some time now, so who had been destroying the request without
> this patch?

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Note that destroying is mostly just removing the entry from the hash
table with rhashtable_remove_fast(). Which is what we need to be able
to submit it again.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

