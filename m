Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FB8C87FDA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s2nIm9pR2VFff1R0Gt37lG+o36/Td6KpLeuI6lVGeTs=; b=go1p76Km6CD3UpAbsI1pQ10JsR
	bP0ivNXOutC9M2k9hpZGmd5xR3cwKlHrPSiBElic0RNOb8h3DL5UolKdQH+SuWiRAyzv2dUNE8QIf
	bntah/kzNH8TUk93+mdXFlzrxlBPfC0DjatCp50mlM+jH3c5Rw9HBZ5FsT3PlknTYxi+rxo1SkQ2z
	R49dF7WaqvzfLPV338KR3LNNBg/cd0YhQImznf9aGH2oSfRRYB70q/7vgymT6+1bGWImjxRK/Va4b
	p215RXYzRztSBNHcvUzjgrWWzdBdmCUdPRPcDUaUKsD82v6W/GOmOZpUToJd1B+1e1SarJbSZ2OHY
	1MnX/Zcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk26A-00000000uV2-0y9u;
	Thu, 07 Aug 2025 15:00:06 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujo6S-0000000GsN9-2dKO
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 00:03:29 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso585874a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525008; x=1755129808; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2nIm9pR2VFff1R0Gt37lG+o36/Td6KpLeuI6lVGeTs=;
        b=hbwe9Y2XzFSGTcLvuOHDngLN3t9RKCx3oq7puq8jK84FEg6kfez+860a9ybAaeld09
         y0tsVQcppakx3AdpuI8QilnX8ps6XcFh2fHYHfdISdFznxcdeMDUCgWt08S62P+JZ9qN
         fnsZb8/KOznM0tL4a0BrN4GgaQxK4Ab4bsT4GHHm/NeCXbKSAtIVkqSVsJnYHp10XhMH
         g672lkZQ9Ra8GX/hk8nBNB0jWAPAfK6MbOl37JXY3hSlwZ4ITkJxPHaMiWXpmPU1kub7
         hKpxxi5jPplRyga0guHaVhX1NcFX0xpxum4Evajgr2V4PoGMtD71ebeqZ9532e4tD0+i
         tnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525008; x=1755129808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2nIm9pR2VFff1R0Gt37lG+o36/Td6KpLeuI6lVGeTs=;
        b=egK44sPe0+Ehc+EMM4TGHeEjADhR/G5Z7HcUZ5fHplk622rRgJs9kHR1C976EgHiaX
         Fz1cQuKT70Q6kQfXe8/75hqz8CDGpsoEJvTHFlJHlnPoway6qYVNSfinUKnxGs9gyg8r
         tGCiigv3xzXDmUwmXj/UOMOGjet/MJM3ZDskoqCT7SRUlvHIzAHQDIrGPCD3AcV5rs5j
         RKRwrwmISG98XrWkxBwSkezvDjDcCZA3Ngy8rjdRNbxzz6hL0KahJTWtvR03sgTsHy/8
         f5wncFTiviZHat/CxREN+O3AWfDCZVRxD/rsQkN8pd1ePn5LMvZ/fENbpjUyhA8covAS
         uOkA==
X-Forwarded-Encrypted: i=1; AJvYcCWz2ayfcN5CfYF9XBye7SKqArEOT1f+R/DcrboZ2LSK8FUsJGGi1mfP9hjAr4zwRd+L3WvCNYRf2DOw@lists.infradead.org
X-Gm-Message-State: AOJu0YwrF7W9HsoV8daNpy65XJXc8oEq0FyXsLkOO1n28fK4O+M9pKJG
	ds8xIu8vPFiQE/DSnSFcKHEb0fGTPUHvrG46VqTr2VBBDHoJcCm15QFg
X-Gm-Gg: ASbGncvSzKLPM34szgoq4EgryGLYaGuKWQ8BUzNb1b0TQlMPWtfOZ59kZdwxWyuEQ4f
	7qux6nok0gF6731OkkYUXPKzauk8CzcVRcrVB95gz/yzKl4NYlzr3rO12crrCBLWurKcR+pLYMw
	dhLjvaiqJgEPKFChZjnMHK2a8UISGii84d2tgeqcRnK9znPOC4OuRWTAYS0HqEwXwMAGEsusaya
	N9GhvY6XU2QkR+RX70z4xmVWW1N2/j5v37BdDfzmAStGgo5QiqxPUBN2Nsu1fQ9hEsAeCH650iR
	zH59J3M8glHba0cHvQnI7jZzbGuXS5/5bpB3q/Tr9mZKw6L1zz+o5kVgcT28rnNCZa1PT5idohw
	1pcpK/fQ7F0+l/hfR+AAZsj1rlD41zXu8M+qp
X-Google-Smtp-Source: AGHT+IHndIqzglD98iobqIfSre5A1Dz03NPUiXq1oQdA0qqIpiN9bEtefJ4HDNfGWlO3SOLnCSjtyw==
X-Received: by 2002:a17:90b:1c85:b0:31f:6f8c:6c92 with SMTP id 98e67ed59e1d1-32166c2b18emr6044750a91.11.1754525007434;
        Wed, 06 Aug 2025 17:03:27 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a559bdsm9223807a91.1.2025.08.06.17.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:03:26 -0700 (PDT)
Message-ID: <ad14410ef291af926e7185d5d95cb0c932135ee3.camel@gmail.com>
Subject: Re: [RFC 1/4] net/handshake: get negotiated tls record size limit
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, alistair.francis@wdc.com, 
	dlemoal@kernel.org, chuck.lever@oracle.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org,
 axboe@kernel.dk, 	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 borisp@nvidia.com, 	john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, okorniev@redhat.com, 	Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, 	kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:03:14 +1000
In-Reply-To: <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <20250729024150.222513-4-wilfred.opensource@gmail.com>
	 <2a9c71e0-f29d-46b6-823d-a957b10b4858@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_170328_714278_D4E1D923 
X-CRM114-Status: GOOD (  16.75  )
X-Mailman-Approved-At: Thu, 07 Aug 2025 07:59:41 -0700
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

On Tue, 2025-07-29 at 10:12 +0200, Hannes Reinecke wrote:
>=20
[snip]...
> > diff --git a/Documentation/networking/tls-handshake.rst
> > b/Documentation/networking/tls-handshake.rst
> > index 6f5ea1646a47..cd984a137779 100644
> > --- a/Documentation/networking/tls-handshake.rst
> > +++ b/Documentation/networking/tls-handshake.rst
> > @@ -169,7 +169,8 @@ The synopsis of this function is:
> > =C2=A0 .. code-block:: c
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0 typedef void	(*tls_done_func_t)(void *data, int stat=
us,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_serial_t p=
eerid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key_serial_t p=
eerid,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t tls_rec=
ord_size_limit);
> > =C2=A0=20
> > =C2=A0 The consumer provides a cookie in the @ta_data field of the
> > =C2=A0 tls_handshake_args structure that is returned in the @data
> > parameter of
>=20
> Why is this exposed to the TLS handshake consumer?
> The TLS record size is surely required for handling and processing
> TLS
> streams in net/tls, but the consumer of that (eg NVMe-TCP, NFS)
> are blissfully unaware that there _are_ such things like TLS records.
> And they really should keep it that way.
>=20
> So I'd really _not_ expose that to any ULP and keep it internal to
> the TLS layer.
>=20
Hey Hannes,

Sorry for the delay in response, and thanks for the feedback! Yeah I
agree it was a bad approach from me. It definitely makes more sense to
keep things in the TLS layer. I will try to address this in V2.

Regards,
Wilfred

