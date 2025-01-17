Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F701C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ud5I1k1mT2TYj5aNdd11m5o9FdbSdYLBuawoHgrvp7I=; b=TpB/AQnwoMCRHy8ybi62TnYiEk
	gSWpnLanXnHuRw+BnkdMGrHCZw6S+ka4Zmb+uOBgcVmEJGFRHmUKrSs507HbILv1fPZVcTXZfC8bg
	NVPCjdnP3w/plnC2pd4iHg8ua0FTU8X2OA3UzfNmJi0kE85nVBFUBdQZp3EOg6RxaMaf18CxWS5NL
	rxmh9vaZvd7T8NTxMsttjR//ca0fodczNfnpS/yZOITIp2Xx9hLVIsoG5q5V0WgG24vehkCOTNAaV
	1HhjfawMViIQm/mWsysVLeZWvDBGh9u2Kevf4L3igF6sw52xPWntLrGS3z1WvzWsMp7aAu9v902fT
	OwSK6CIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuRY-00000001Ras-0OOu;
	Fri, 17 Jan 2025 22:03:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuRU-00000001RZq-2vNf
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 22:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737151430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud5I1k1mT2TYj5aNdd11m5o9FdbSdYLBuawoHgrvp7I=;
	b=KexV9G9YmmL3fikKxYrHJXSI5Qs/KMkUve/ErXptvPbo1jKJC2gNf7HXh+YgztXJacyiGb
	oZpe1/PSfeRkbXTxq6zbpFn3uAm348gFaPTtjo/QT5iqXLAdPC+I56Cm+O5EexNI/GLS0S
	Kt0Jhvc5NWYzqXPQLAjoA/6f/rnLmng=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-CRnj22BeNBS3iKXea7Ly_A-1; Fri, 17 Jan 2025 17:03:46 -0500
X-MC-Unique: CRnj22BeNBS3iKXea7Ly_A-1
X-Mimecast-MFC-AGG-ID: CRnj22BeNBS3iKXea7Ly_A
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e3988f71863so4360158276.0
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 14:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151426; x=1737756226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud5I1k1mT2TYj5aNdd11m5o9FdbSdYLBuawoHgrvp7I=;
        b=qHVOxnD1xM5Isrl0iYFyE8a8vqJQqhPrYIL2x+yX4CqXwXJ7fe9+OQa43/i3jOHAoz
         oJ+wacRB1k4SMY2wYnszgez2Tfi2THPDioYSTTDVt/2/iiKRQQbOCiWHD8aH3hSehqcl
         fTDsc2DsVwIp/4CdmKIbBitUJi3qTejhyhq+yJ8v1qiY4TVny/5uKERnDVmwqDNJjK6L
         XfA+mavd9HhDC3pFkAir2bdmktSPvDCUddtdDJnq2jjuWR9fOR4Kj6ZfiE4uX6EQUen1
         xp9PsVMjQYl/IC6hQ+T4FhaKCGg7AvnxX6K3gAb87E6e0Pac79Q0Aj5G2B9c9NzBJVot
         u4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGV31eZM3Q+AJ8Ev2O43UWNxErIDXJHdpJ0WXR9ERp7mISEC2rElQOkTkycMtbk8rNWY4VoCZNsqXA@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6ZyqLM9RbmBC1sU7F7E97k8dpywTZ2DI+Gq6OvybmB1I1M10K
	pvVIJJ5zgNR1hkI3Q5iVnSzMt+pn30FEtrMusvM9H53iaxdyDoOrBVNbF9uMaEFbrjmqlioVdJp
	TywnWQYlLkZ6+nu9qKNaHpkcBIEqXqJivIlkSs6jT1ySf/JNxjG0p01CroOp83zQUI1JIDjM8Ub
	zj8jaIEn9CIa5eCmfWOqoVhOkP7FPKTXt3+eCTtQ4=
X-Gm-Gg: ASbGnctC2ksbEVy8nnOha4m+tG7r1KXQB1x08ULXjJyFIBxihRUgrYoeWJEPOvPtUW+
	zPnzzUGiQ7u2sBptTGbI3h5vOimhint3DJaYfEDVWEKF0IfjGSlo=
X-Received: by 2002:a05:6902:1886:b0:e53:64a6:2dda with SMTP id 3f1490d57ef6-e57b132bbcbmr3576569276.37.1737151426252;
        Fri, 17 Jan 2025 14:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQwvrSdsuqlBWpT0himi7jmlaYLUhffo5y8yQ3fW0Xeiz+oEH1S8Kb7TROawUAlUnc1hNHXFBI8DZg2pJsecE=
X-Received: by 2002:a05:6902:1886:b0:e53:64a6:2dda with SMTP id
 3f1490d57ef6-e57b132bbcbmr3576538276.37.1737151425895; Fri, 17 Jan 2025
 14:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20250113124446.830697-1-ming.lei@redhat.com> <CAGtn9r=bqfqm6d0ipf6pc5Rure=NdkxdX+K=gTp4iAQ6qUYVtQ@mail.gmail.com>
 <CAGtn9r=pJjpZVoGt9deesQxv=G9tC4r8ZNAWVX2nTErQWAo3Rw@mail.gmail.com>
 <CAGtn9rn=rUsaOACWyOLAx2=E++WvStwtQwyXZR=kxYmuCQQ0_A@mail.gmail.com> <Z4hnfSFc1hobsN7g@fedora>
In-Reply-To: <Z4hnfSFc1hobsN7g@fedora>
From: Ewan Milne <emilne@redhat.com>
Date: Fri, 17 Jan 2025 17:03:34 -0500
X-Gm-Features: AbW1kvZW4yj3u8b3ARg5Uoa-kojpD82rO190zgRgRbpArJE7HwxyxrUUPovWXIc
Message-ID: <CAGtn9rkVq1VpMnF2SbdVmsN8Fv1rHKdG6kcfaWxAKoyyeML=gw@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Marco Patalano <mpatalan@redhat.com>, James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7TL7ImXqK3uY4gh8R2Xjkv--xF2wxumHgSFlGiIfoek_1737151426
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_140352_816569_31077C0D 
X-CRM114-Status: GOOD (  20.82  )
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

So testing looks like it is showing that the WARN_ON() I referenced
earlier goes away
after reverting all the recent keepalive changes, all the way back to
and including:

a54a93d0e359 nvme: move stopping keep-alive into nvme_uninit_ctrl()

But I think this is just because this makes the keeaplive stop early enough=
.

I think the problem is that the call do nvme_stop_keep_alive() does
not wait unitil
the keepalive command, if in progress, completes.  It just makes sure that
nvme_keep_alive_work() is not queued or running.  But the keepalive command
is asynchronous, invoked via blk_execute_rq_nowait().  (I had thought that =
the
ref taken on the nvme_fc_ctrl while the command was in progress would have
covered this though.)

-Ewan

On Wed, Jan 15, 2025 at 8:57=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hi Ewan,
>
> On Wed, Jan 15, 2025 at 12:33:50PM -0500, Ewan Milne wrote:
> > Moving the tagset removal to the end of nvme_fc_delete_ctrl() ran OK an=
d we
> > no longer see the WARN_ON() seen earlier, however I think that there is=
 a
> > potential problem with doing this because the keepalive is not stopped =
until
> > nvme_uninit_ctrl() is called.  On our systems w/FC kato is normally dis=
abled
> > so we wouldn't see any problem but this isn't true in the general case.
>
> Please see e9869c85c811 ("nvme-fabrics: fix kernel crash while shutting d=
own controller")
> which stops the keepalive request at the entry of
> nvme_remove_admin_tag_set().
>
> So your above concern shouldn't exist.
>
> Thanks,
> Ming
>


