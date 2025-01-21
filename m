Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8DAC02182
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2025 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geD6J1ko/sZ1/6fQw+2qHOhCGfhEt9lnXK+Eig+HLX0=; b=trswG04ibo3Ca/IHrvmLW6A7vG
	fJJjax5RhP5G3Ah8P15OI0AyIbBoJSZu1yvbX5GfequjKhN4sBfNO5ESPd5mtfKnReYrinyU7eEZW
	MLp5LKveNRa9V4PJL7hNJOhWeHX2EnNuNG0tUSHwGIhCUwTj+T/FNj4ioSz+pvLxOL2LOCy0tzWe4
	p3JbJqtT2yT1E3/WieYHappi9GaGUhEkZkn+leMMVigmzgxfpUP2T2RkUAhVB0s6THIg9K6oxYgjc
	jk/wvu+eVslUObwBTdv5HXmoxKezwfihVelSxztm1tKIhTOqNrRwYr8O1xOZmSuWl16vfk/UH1aam
	YrslPf7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taF6p-000000083Ao-0iLg;
	Tue, 21 Jan 2025 14:20:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taF6M-0000000832b-3j1u
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jan 2025 14:19:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737469173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geD6J1ko/sZ1/6fQw+2qHOhCGfhEt9lnXK+Eig+HLX0=;
	b=RqqD1v3iKtkHMg8tlmtJ0lZX4LixYejFNSCoxU5LU7adCv8vqNlORIIrj02Bgrg4rTCTIg
	3nZukWiklH3Zj1C7lHE+/3Prc7btFsYWju0SsfQxuS3aGXIr3v4tNanGBCsyS6lD3ZXvXP
	z3GkcmPqzL268fYAMG1EJm/Z79dLZGQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-uCHEPu5mPOWub7JYjCqYFQ-1; Tue, 21 Jan 2025 09:19:31 -0500
X-MC-Unique: uCHEPu5mPOWub7JYjCqYFQ-1
X-Mimecast-MFC-AGG-ID: uCHEPu5mPOWub7JYjCqYFQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso100339686d6.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jan 2025 06:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469171; x=1738073971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geD6J1ko/sZ1/6fQw+2qHOhCGfhEt9lnXK+Eig+HLX0=;
        b=Ip+Zc+yEg0FSQ3cP0UtrUXpp9crkY0zQ5aOFxNzjVGvEhvb4BKEMl3GA2HCsiMSHvN
         0rAYVaMnGcIxxn4YgcebjsQYHWqQiLUCcUAhZXuygyuArcvC70SIm8d89G6gmYWZCRIR
         Px5y94vC7i2VdZOas43yxUftIUg28Wni17HqZX1AjV9A5Foz4EhSZJkKa2QXETOFU4FA
         1H+3/2U8Q9omOSEDLRmURn4HatMZ30QdqmMu8pcLseg92u8gTocA1AOD8TjT0Uzoq/GM
         ypo2gHZYHEtjr3xuq/lu3ijOmHsIcd/YvQezH2jF03+093d4wJcPrHXNPZQ8Vu6wmPBz
         +WMA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZOU1/rTo7H8J8KkLGYt6g4ZI6bvxP1dECStGNoBIGMg0r2mtYxhkAtC3/gdcHF6k/RqVwPhlN9xe@lists.infradead.org
X-Gm-Message-State: AOJu0YwrcgQPOG7mWMchIghjeFXEvnPMebnCaF3GbmAD+/FsTLWyBEiw
	u9iCwksFmzLdBSbodTIdd7htQEGmHgisBFOZWlrs2SgoN3ITSHYxNeYwfFuVCvQK7HS+/Z6xtmH
	8sQttL4cjTviH3llUIzrp9FAufwj3RUOoXgH/nv0cAViX7VbLEXzAoeboxH4WdPLa5xSvPU7IJZ
	2Pb9iMO1P78QUsEx5y2dC3icCEb6gbvAn3u4XN2B+VZxM1SV8kCQ==
X-Gm-Gg: ASbGncue8iu+uRqdSI2qHetxdkz1u3GJiMOm4a0O8Cg5cNvzf4euy0Togdoe9I7kaAA
	bpZZAt0CDWaX2pPY78q4rawTEh2EJVP2EoPh51MiRZ6D/hDQ+FG3TCA==
X-Received: by 2002:a05:6214:240d:b0:6d8:a5f7:f108 with SMTP id 6a1803df08f44-6e1b216f029mr238721036d6.26.1737469171239;
        Tue, 21 Jan 2025 06:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLmNQfV2BNbzQP7GHhRlyT8d8su4emywuO3KdYyqWL6AzlsJns7R7Jk6EcdNa6p0D4KueITnuZHAkfryA+6BA=
X-Received: by 2002:a05:6214:240d:b0:6d8:a5f7:f108 with SMTP id
 6a1803df08f44-6e1b216f029mr238720896d6.26.1737469170999; Tue, 21 Jan 2025
 06:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20250121134540.1280828-1-mlombard@redhat.com> <8238ff93-573a-41df-a6a8-3daaf46c56d8@suse.de>
In-Reply-To: <8238ff93-573a-41df-a6a8-3daaf46c56d8@suse.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 21 Jan 2025 15:19:20 +0100
X-Gm-Features: AbW1kvZNgFCxmydn2IQ2VNKkXmYt6EzxPKgYPkCr4O6Pp7Pyrhoui9gIcAkOHGs
Message-ID: <CAFL455m8OrEUed4Y6t3AdZ3997Vtr0ii5nCzE_mHVgiCYMKgxw@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Prevent infinite loop if socket closes during
 CONNECTING state
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XtTQwWvufXePMfij2XK-G2qPchCooExgEIUDF2I8jRA_1737469171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_061934_990409_CD947CEC 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

=C3=BAt 21. 1. 2025 v 15:11 odes=C3=ADlatel Hannes Reinecke <hare@suse.de> =
napsal:
>
> This feels a bit weird; wouldn't it be better to allow transitions
> from 'CONNECTING' to 'RESETTING'? Wouldn't the fix the issue, too?
> But yeah, this is a real issue; I've seen it in my tests occasionally,
> too.

Yes, it would fix the bug.
I didn't do that because it could potentially have an impact on all the dri=
vers
and I wanted to avoid regressions.

Maurizio


