Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0CAC4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPX4rwxFgmeVuAz7Ic9INWbZth7Fiz1jYDDGljTwFrU=; b=epJtnTqfGYyznJi/6Z3S9X5nNb
	xETaUyn0y8qG/RKJN1b3aMdFWzgWkRnvwTojaC9xGNoMnuXG/fXOzNftirzNv39e7g0ZQUx3siuO3
	OBg8DZT1qRui06feTpgy76fw6KyUnngAo+BF6J6G1ThXS4NX+l6Zw0cAs9phQzOJaHiazW7IRL3pY
	fWXEwBDTGwWWIrCKvOtPxRAVZqbmGtDIPEKpzvQfHk2uKWwytkcAL5dAEz9WG7iv3YxTvAQQVL7IG
	irAPT2gipCTzi8WQszJ/fBRjtcc+OHr1SvmTlAW9+pxrGUJ1gtWXI0Cw2mS7HzXc+LxjkMvxcgkVy
	xdT2NDZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQnfp-005Rhc-0t;
	Fri, 19 Jan 2024 12:08:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQnfm-005Rgw-2p
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 12:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705666112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPX4rwxFgmeVuAz7Ic9INWbZth7Fiz1jYDDGljTwFrU=;
	b=TKkH2Q5zBByntzMkvgxeF2uPeXR2vRE+c28iRI4ct9OK1Ys0nYze+uR7WLgvnVvzrLIWKQ
	IY95y45AVNtLBYRLLdEBdQjNPle355jfOOmc48p8rEH6Ux3mP96Bn0OKenmdKArsZ0vwO1
	EvOWt9sZGltxCuwhdgIwtvHZQzfSRg0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-l62oCPayOaOh7LxJcS5-IA-1; Fri, 19 Jan 2024 07:08:31 -0500
X-MC-Unique: l62oCPayOaOh7LxJcS5-IA-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4b745b768abso1696260e0c.1
        for <linux-nvme@lists.infradead.org>; Fri, 19 Jan 2024 04:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705666110; x=1706270910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPX4rwxFgmeVuAz7Ic9INWbZth7Fiz1jYDDGljTwFrU=;
        b=hIAu2aPPG3ONqKe0YnbISz5BJjMQuctdKDgRD8rI8pbZXsixbxqiG25IGLs0Jklh9E
         XQyXHOtiTBapRgxhNAIbsfqnJbxtpkQ5TtkXSsyYL8vSKIFXz7oCJJ+1+XRnCZsiqhjC
         epVHbi82zs4O0isWxCN9whlcLzHSIfte2F47We8qBKnwpz/3mriT3B/D3KDj7uVauDM7
         1zWr+hcizjWkUoh7M/f/Evvq2/yo+dhiSOGrTOjoyuWQzEl1QvUSgbBdkqmJkzmZlg5T
         l2/luKQYUAyCuvGTllLACjuwX0zqam1QJ4yCuRtXitKLatQfMgDIrZAZBgxtsRfffHvx
         f/uQ==
X-Gm-Message-State: AOJu0YweB7NUS8IpoYIRr62fRs1L6fD72u98OZFtM+1sXa/TwFEtVjA1
	V/3LjEKmjsZJDuusmeoeti3JqGNZO44vFT6/XNrJREwUEWUyXhpAtKcBfBME9cephDko1mWAmCH
	NiuhyW0+fveTM7fftJESCBX7CqtChokqTBTkz3SOozKokyzeMOaqFTaFgnbcjNleQG0vVTMFL1V
	OU4GArGgEzbxCGhK7LkvXU4+okeTzzf8s/nGtscF8=
X-Received: by 2002:a1f:fc4d:0:b0:4b6:cee1:753d with SMTP id a74-20020a1ffc4d000000b004b6cee1753dmr466829vki.13.1705666110660;
        Fri, 19 Jan 2024 04:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvUu2nQqJmIY6zyHVhjy07QQTlxs6LxYPf2CxRtjQpyZfqro71C0CeX0wT84Q4E8lULqCu8Ilo6CScitilfoM=
X-Received: by 2002:a1f:fc4d:0:b0:4b6:cee1:753d with SMTP id
 a74-20020a1ffc4d000000b004b6cee1753dmr466818vki.13.1705666110410; Fri, 19 Jan
 2024 04:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20240118114854.672748-1-mlombard@redhat.com> <3urnhr2hdyn67zbw5a43cscnumbd3h3a2cd63n3ofaslwec2yv@yg3dpb22s2pb>
 <CAFL455kjiM9=ifcJOLAoKWzTHhuJkWrhPH8n+Me4fFxUAEmF-A@mail.gmail.com> <oxg3l33bnkpvtjyhrk5czbpvuk4t6w6urfywdrrboypblll3kc@hjx6z4rlfjot>
In-Reply-To: <oxg3l33bnkpvtjyhrk5czbpvuk4t6w6urfywdrrboypblll3kc@hjx6z4rlfjot>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 19 Jan 2024 13:08:18 +0100
Message-ID: <CAFL455kjxQw+9KppJTvBxT5B6t8Cmf+_n1UBk_y2zJS=rzSuew@mail.gmail.com>
Subject: Re: Re: [PATCH] nvme-host: fix the updating of the firmware version
To: Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, Niklas.Cassel@wdc.com, 
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_040835_002883_BB009036 
X-CRM114-Status: GOOD (  14.95  )
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

p=C3=A1 19. 1. 2024 v 9:42 odes=C3=ADlatel Daniel Wagner <dwagner@suse.de> =
napsal:
>
> On Thu, Jan 18, 2024 at 02:21:03PM +0100, Maurizio Lombardi wrote:
> > =C4=8Dt 18. 1. 2024 v 13:31 odes=C3=ADlatel Daniel Wagner <dwagner@suse=
.de> napsal:
> > >
>
> > What the spec leaves undefined is what does it mean a "current fw slot"
> > with value zero, which is invalid.
>
> The valid range is 1-7 for the slot ids, that rules out the value
> zero IMO. Yeah, I agree not a thing at all.

Yeah I was just pointing to the difference here with the "next slot", the v=
alue
zero in that case is valid and defined as "The controller doesn't
provide this info".

> I suspected this but it was not mentioned in the commit message. Good to
> know that it fixes something. In this case,
>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks.

Maurizio


