Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4890C54E58
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wyLxpmRa9vDZTdfVvWg2aO7vI6t1684BUA4BOk13UCE=; b=tFXJg9WEDaVBtEVVbPfDlk/acJ
	M9DG4/7c6MW9rQrL7xQEdGCGyVpZEqD2zrRq/uBmNb8Pl3SFljrLCCUaVuCNwiiFOowjik7LO9UdD
	oKBUSBsR4s5DaSjYc5hnNyagzaeDaFAo7gknIZf+QM/GV6/bY/B5qG4wiFwOGwZyhBDjWy4KvvzAz
	uURGBQZmslPdfSsOVwreHPaKL/PfwU2+w8VQvybdtGn0kLh6u4/tixqo5+0E+ktPQ9B6O7JR8Huj5
	dV/XJ1zzsmAkLZmRkAjdURuO18MBtwyQRUxxBzneKLB1X/tEBdW9MfKbbqsA6fvK4ZXEgjkVnPGuL
	wziKyU4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridJf-0000000AG2s-1ENc;
	Fri, 08 Mar 2024 16:43:27 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridJb-0000000AG16-1t2J
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:43:25 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso610582166b.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 08:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916201; x=1710521001; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyLxpmRa9vDZTdfVvWg2aO7vI6t1684BUA4BOk13UCE=;
        b=GpyLP9ZX7ZJhReSV+ZwwoCQYxtHRMNPrXf2h9ralOJy8rS49vjF+LzoLg87oVlpCoZ
         B/3AkjEQizhYY9iNnk+JqpT2cbTGjWPnu8jRwd5wWuLE2YuwpcYPpSWg+7OlVOhAie6N
         RpBP9NIIiAEzV402seUwnClkOm75VEG0B3evem37yNUt8lE+TThELJHH5GnLs/+ZEmOv
         os75rOJ2LKulWEh39nvR0PbcOoC2G4Kvi7nuyAbsywc0KeGXxCuz6WUDHUS/DpZ2uIOF
         yvHmepf0sDJtxqAI4FtZGL8UpRNVFv3oabDtp7/NOn+USwpSTIDtdzaKFHvE1apUtfJq
         ln9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916201; x=1710521001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyLxpmRa9vDZTdfVvWg2aO7vI6t1684BUA4BOk13UCE=;
        b=DeL9rVVpMyrZ4bdT7hbeeH0zAXNsqVJaTicuaqQtmzeZHq4p0E9LU+/sGPMPfg02M2
         oUZfd++f6vhFjXBJPuqf8R6qOWzbpCLwHqw9vLDnKeKJyfEXqkVA32uE9kyHcB5woQKr
         ARVVDqANtIAxP0J1Y0YwUjGE4c1z2J9rLRTGFFiI0AOtwbvasyxwPhr1Jd38dXQ43UF+
         Pj4szUUmj+DicLK0pJcWt0G8i2qOasNvlklPGIr88JycmdoZk0r0yaTU2SnfYefVPoF4
         SgUaY1J21D32qqHn2uAULcbQT8QIKwjZl49Rxox39Gqt4oxRjQJZp6wHhxebHGn3jPUW
         ZncQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRjWNp4pvx6ABG4Ab5qLQ70fZ/AY4SZq10eFFs6yBJol72Py2TebUwNwq/pbv2dG8ZKncHigvVMYkuN0MUwsBHlxkgyFIuBBKQ4DnjXM=
X-Gm-Message-State: AOJu0YxypMeT15RFcJw9v7Omwypl2Yk0eNnw/SbTFJc4HqzqJniNk2q7
	mvr3R0cJ9RLWeIC2r1EU5hDf9N86jwdTl8rNr7KPI8KVRWCLTevsSDKPo0NoJnp2sQYyHDlF51s
	80FDYqnHwOqWK5tWzN+mXnD2dtTE=
X-Google-Smtp-Source: AGHT+IEfeIZXRSqypmb9U/23WbS9AVqjeSavKZ/LF+/nDtBRuH3PxWvbMYSILot6HKmpEAjJZMAW26NHGxMVPhHoPl4=
X-Received: by 2002:a17:907:2495:b0:a45:d7fb:8423 with SMTP id
 zg21-20020a170907249500b00a45d7fb8423mr707357ejb.9.1709916201065; Fri, 08 Mar
 2024 08:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com> <20240308163100.GA17078@lst.de>
In-Reply-To: <20240308163100.GA17078@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:43:12 +0800
Message-ID: <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_084323_625631_ED288E25 
X-CRM114-Status: GOOD (  16.32  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:29:27AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > This works now, but I donot know whether
> > nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> > will be suitable for all driver in future, such as driver for apple
> > device not use these two funcs
> > to init tagset (anyway it not use these two macros too), so maybe new
> > driver would use these
> > value in other position.
>
> nvme-apply should realy be converted to use the generic helpers,
> I just need some help from the maintainers.  I'll ping them.
noted, that sounds great.

>
> But I'm fine with just taking this bug fix as-is and clean this up
> later.

Sorry for delay to reply, I found the patch have applied just about 10
minutes ago.
According what you plan to do, I think as-is maybe fine, But anyway if
need, I will
send another patch to cleanup, thanks.

