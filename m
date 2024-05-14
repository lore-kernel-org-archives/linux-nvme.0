Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378AEC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PrziG9n2X44unPcKHLDimt60QjyvFXSxnAYMGkXTekg=; b=CpP82f8LQR/Zxu0Y+qeJEUQyHK
	5DY1kbFjx3G3WtiDAAIIBMKpS5JMuUq1vnKWN8h1rxUmlhCNWq570O0tppeKLr/kyQ/WJl+OFVt9N
	Fm7Y5izzWUhg9OjOPxoV+kA9ohPP6MYuuaSsrYGP1Vs4uF0nIt3wwdXZfOQxeYfOHfQPcytzFaO6S
	GukfxPqFb0YYImIbN92mvEZtPKsxhcePwgosgLtDrKnEfhrbFH5/QOBpUjuDgzuIQv9033Uy1OtWx
	t8vPmsBtPRXajK4KtHuiYTSiRydwTiD7Em2KTI/+/gwYPgBzaj5TSOM0ZXEGdkw4+5+OHWEMy1vCP
	JJj7lhkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6zse-0000000HFI3-35Uz;
	Tue, 14 May 2024 21:40:16 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6zsb-0000000HFFq-1iQd
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 21:40:14 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-51f57713684so7730797e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 14 May 2024 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715722807; x=1716327607; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrziG9n2X44unPcKHLDimt60QjyvFXSxnAYMGkXTekg=;
        b=fHcydDx9udIWBGs4s/jtiCjIL3ODZnQhraI6mNb6ezMaN99NeHpUAuZwdnKH01wOD3
         tjk+hPgT98cZ3B9H2JyKhNvh1k0+0a9lt2O487RVpA5d0z2gH28o1Drik0yMyXAqgsf+
         5EEjJ8Ysly7YYbJSJcH5VRpx07Vk8XyujBK36UrEeFd7994ohcT+aiNRYwXOgji7Fkwj
         KykAyvQizBe8CkdWclAZv4PhSATMcDX/n7G3d8zNMQvoBvT8WIspctsYXnvPBV2OSCo9
         ql5IqZeSf5Ha3PJayjxjN0piucWOSws6AseuTP0WCrQ7RDcHQO5iEb+hlAwS1XRmKfIU
         mAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722807; x=1716327607;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrziG9n2X44unPcKHLDimt60QjyvFXSxnAYMGkXTekg=;
        b=tSmv5eAph9prpq9+RLEf0adJwnwwaNV/EVyZ8qUJ32tMrsAzpgZv5xr51L4IhLb8l8
         Bk+uAceKzpIrq/h9C0NC0Hb/zKhE698gGTv7iT3waNFAC0Sc8BEy8+vSjxEGC446At9n
         l+SNXr8sjL+zODL4XCSJsZbVGMaPpshzAgEOevjjS8tspam3eFH3DQ507zKfYOMpDsNI
         NgUzNPHXiLWp21GwLnXxu+4w1m1WDQARzHbO7eAUKBpmxfrjvAEyiQmKFZNioCojFoiG
         K7qAkIoAuRU92XZ1m5NGY0CfWFgYkt08FXk75ZXgJpxdbb87L+w7GYtyxVGbDlv/rHdD
         00aw==
X-Forwarded-Encrypted: i=1; AJvYcCWakkzcZahLJHMFJ8dwLiOXghbhQrmqe9lVowP2dnzZDhl6V2XCtqGBaROnyBdguobK7H/twkvxlRvvgJVU6D7vlLAMfadqoPORduXzrZo=
X-Gm-Message-State: AOJu0YzP/U5Z/aRADSF7X/WHdYaUIigpDaV/ybSrLcKEKtc31fSdBp+v
	kLZ4+UMNzUPWzXzEPqnwtDNyImc01cZbQs44zGhYkky2Yj7sQqaIzsQZ7rxe2lK0Wv63BxG0fVs
	R/1e+Aw==
X-Google-Smtp-Source: AGHT+IFGSTaDocCTelgf45mS4akR4/F1HUdr9D0HIeSNCHWfG9nxMysqTGBM6ywDHE34trO1bftJhQ==
X-Received: by 2002:ac2:4c4e:0:b0:523:6a08:1c91 with SMTP id 2adb3069b0e04-5236a081d53mr2435710e87.26.1715722806864;
        Tue, 14 May 2024 14:40:06 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:7881:38ef:d13d:5d35])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238a36c718sm100571e87.245.2024.05.14.14.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 14:40:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
Date: Wed, 15 May 2024 00:40:01 +0300
Cc: Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>,
 david@fromorbit.com,
 gost.dev@samsung.com,
 Hui Qi <hui81.qi@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
 <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_144013_583380_653D8CAE 
X-CRM114-Status: GOOD (  24.40  )
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



> On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>=20
>>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>>>=20
>>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
>>>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
>>>>>=20
>>>>> Userspace can send the data lifetime information using the write =
hints.
>>>>> The SCSI driver (sd) can already pass this information to the SCSI
>>>>> devices. This patch does the same for NVMe.
>>>>>=20
>>>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>>>> And map the incoming write-hints to plids.
>>>>>=20
>>>>=20
>>>>=20
>>>> Great! Thanks for sharing  the patch.
>>>>=20
>>>> Do  we have documentation that explains how, for example, =
kernel-space
>>>> file system can work with block layer to employ FDP?
>>>=20
>>> This is primarily for user driven/exposed hints. For file system
>>> driven hints, the scheme is really file system specific and =
therefore,
>>> will vary from one to another.
>>> F2FS is one (and only at the moment) example. Its 'fs-based' policy
>>> can act as a reference for one way to go about it.
>>=20
>> Yes, I completely see the point. I would like to employ the FDP in my
>> kernel-space file system (SSDFS). And I have a vision how I can do =
it.
>> But I simply would like to see some documentation with the =
explanation of
>> API and limitations of FDP for the case of kernel-space file systems.
>=20
> Nothing complicated for early experimentation.
> Once FS has determined the hint value, it can put that into
> bio->bi_write_hint and send bio down.
>=20
> If SSDFS cares about user-exposed hints too, it can choose different
> hint values than what is exposed to user-space.
> Or it can do what F2FS does - use the mount option as a toggle to
> reuse the same values either for user-hints or fs-defined hints.

How many hint values file system can use? Any limitations here?

And how file system can detect that it=E2=80=99s FDP-based device?

Thanks,
Slava.


