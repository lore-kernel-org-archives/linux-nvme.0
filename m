Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C610C369AB
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Apr 2025 05:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bAGmY7yo0g2n+TufxO6Ywq+m1ucWI9iMILpnSTrl26c=; b=NLB0hAmhqsLHkRE2b15E1k003z
	WkDQznvCtrOMZiUYhY9Llh/+/jfnHGfEy3RbCkWBNog89JHXmdquAT/MJhf5AYIkK0BxrP+WU9JBJ
	LyFjqQP5DiImGFsfw9fPYbdabYJf7bJ5PrJZ4NWBFuaePzMjPjafhtQMYB+Xq1X7BpQj47fhxrkMR
	xxHhq6XjvA2Rc4s/1joq6w/B6INRKmdGGiCUYEtlOzLpf25RH+BCzI6SE+8LwJL3VcDXWNG2ZCZM5
	XLc63JIBVvQ4HfLI9wcwlP5Gg5wevy+uJtrcfq47Z7loJMEH9ToCYyE/s408h0OfcIIM4edu8fpGy
	4APVIUKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ucl-00000002vYE-0KPP;
	Sun, 27 Apr 2025 05:32:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ucY-00000002vWW-11fT
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 05:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745731923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAGmY7yo0g2n+TufxO6Ywq+m1ucWI9iMILpnSTrl26c=;
	b=UQ4/4EPcTQtj3uO29lDrX/9mYg239BTYaOYm4azKVpmWWpm6tBvpkhE8wJ0MOpqiGs1dzA
	B7SbTlrmaHqtvcdIvFZbcsM4vJCEQkDV9lLyPjggPjOShVESWR1woGcDe1LcIW136Bgo3+
	IP5NEFPft7+5NZFZ0t7aVXI3SNg248I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-n71-BPtJNyer4VLwFUFq5Q-1; Sun, 27 Apr 2025 01:32:02 -0400
X-MC-Unique: n71-BPtJNyer4VLwFUFq5Q-1
X-Mimecast-MFC-AGG-ID: n71-BPtJNyer4VLwFUFq5Q_1745731921
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30bfd1faeeaso15747731fa.1
        for <linux-nvme@lists.infradead.org>; Sat, 26 Apr 2025 22:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745731918; x=1746336718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAGmY7yo0g2n+TufxO6Ywq+m1ucWI9iMILpnSTrl26c=;
        b=b2owY4/3bLyjNY8ndA743pk9/XafwhBbQB3XAJLdqf3qp/+1eWWkZHieDIbPHll/Fy
         yRMRLYTKLKTmUxURZSti0I5hqbXbZ7CKks3vz3aXVhPDdp0LDiLxnNv4xwMQJ5EK2T83
         d21dr20sSZ/Cu+owU15UgShq4y7fRcQQvZcmAxD+6twJLkkXrAVe1zpgMIu8GOmVySND
         +P1kAVTg46Bi4Ljs/WX7I3qGvtAt91+FTkL0pNbZJw6ONgAvkfxEVKAR29R/gC9HOSBT
         TMDQwz5cyF5fZeqHn8i+Bul364BdYVcjc1+jrLLOHn8LRjmKTrhI6lSOFrsdrnkiA0O2
         WQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo5XW2hmnGByIjJ6qQwYkeqFd7fRa7pTdGm/KyTvAJKEl/QBUCdtz1Lb9EZDf2HzFLNJ8kv5p4MOk2@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7gcwLKDaYSyrWhvRinAHQXj+N3+ykAIInubYr+QcqmIhzCdeW
	qSyUZjHQOkN3nAJ2p8RjkzYs5BNENJhwOx6wvlolTPAg5kQ7/RVNzW9tGnt73g2FifWg0HBOehF
	azQ7fyFfylunmKwY2wA5Vqcdjoj3h4ZOxA+d/ciJORNgm5EA2FavBSj5B+MuYvr8VkkA13VTzuK
	Drubsuqgjl6PztomHH2aWDyqpuu6LQbZ1Dcw8HdXLem3gLPPtvOw==
X-Gm-Gg: ASbGnctKdeTSyvqrNshKrL5Pw7wZPvKpH2JEyaW5DiWnJzAPDSxg+LBek4m59D80vID
	K2j0YBqqE2KfZZIRty2AXo/edUF/KrimpzXeFxY3cPBQfb9SWGHmXXIiLWJlLcZblEen/Ww==
X-Received: by 2002:a2e:b88a:0:b0:30c:dbf:519f with SMTP id 38308e7fff4ca-319ddd66a48mr12473051fa.35.1745731918014;
        Sat, 26 Apr 2025 22:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI+sEGbgken7Nhb0j2iRao5LcvY0tdD2oWHoLGsBFk98kQ+OqZO3f94Hu6L71NRdcScMGUxRpbOmIHYLHGruw=
X-Received: by 2002:a2e:b88a:0:b0:30c:dbf:519f with SMTP id
 38308e7fff4ca-319ddd66a48mr12472981fa.35.1745731917663; Sat, 26 Apr 2025
 22:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250425093434.36383-1-hare@kernel.org>
In-Reply-To: <20250425093434.36383-1-hare@kernel.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 27 Apr 2025 13:31:45 +0800
X-Gm-Features: ATxdqUFRFEiKudxGoc7Uo606uvrh8XgN1A4Ls9JjO1RioG1pM_WNQLnFNFKoUO0
Message-ID: <CAHj4cs-g8ZeQwzkjjfsDubPxeQ5xGC3feyFdVG5DABSYQtQ7tw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: always free derived key data
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Maurizio Lombardi <mlombard@bsdbackstore.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dv60Xm7mEvvlszBmsEZiJ54HkiywjZ73-INSr-jUYUc_1745731921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250426_223206_357211_A738F1C0 
X-CRM114-Status: GOOD (  16.91  )
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

On Fri, Apr 25, 2025 at 5:40=E2=80=AFPM Hannes Reinecke <hare@kernel.org> w=
rote:
>
> After calling nvme_auth_derive_tls_psk() we need to free the resulting
> psk data, as either TLS is disable (and we don't need the data anyway)
> or the psk data is copied into the resulting key (and can be free, too).
>
> Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Maurizio Lombardi <mlombard@bsdbackstore.eu>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Thanks for the fix:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> ---
>  drivers/nvme/target/auth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 3f9fad732350..8f67fc21149c 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -656,13 +656,12 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
>                 pr_warn("%s: ctrl %d qid %d failed to refresh key, error =
%ld\n",
>                         __func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_=
key));
>                 tls_key =3D NULL;
> -               kfree_sensitive(tls_psk);
>         }
>         if (sq->ctrl->tls_key)
>                 key_put(sq->ctrl->tls_key);
>         sq->ctrl->tls_key =3D tls_key;
>  #endif
> -
> +       kfree_sensitive(tls_psk);
>  out_free_digest:
>         kfree_sensitive(digest);
>  out_free_psk:
> --
> 2.35.3
>


--=20
Best Regards,
  Yi Zhang


