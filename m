Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E7C04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5uaRNapfMv5f1rVugo2BX+9Ar9b3PGznLd2aVR8CIok=; b=wvuSk00Zr0GEJSL8CIUEXnxbDf
	/I+iILmbrRuK+Mfdoc/9tQpBZpZBLAdnVdn+CnOguh7RN5eXyHaaKONkAXe5+mOYY05iMkKEfcMtq
	kR1e89pmXbElTSMyCBVpPn9quJDIuBn3/W8KnOewkyH6fYUCR3vY56WlgtNOwxXU9HJjwzag9gfvZ
	oACdvTp/FUckUlCuziHmycq2cCrkW/tKkddtBTy2AqOsphtasElVIQfUcvJDFUqys8SwA764EtUiP
	bMAgwMrCgX7ljkXgeLxiWC7PSa/OuONJix5OZshJ16OCII3yh818IcykUDDHQINitVskr4sAKqH5G
	07wCAvNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6xOV-0000000Guhn-41cf;
	Tue, 14 May 2024 19:00:59 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6xOS-0000000Guh1-3IuE
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 19:00:58 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so53175651fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 14 May 2024 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715713253; x=1716318053; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uaRNapfMv5f1rVugo2BX+9Ar9b3PGznLd2aVR8CIok=;
        b=WGCXzlLAUNPyjQN/6I377vED9asq2ErmrofoMBm78dN9b2vGgkvCrOmmz1OL1r8ckQ
         +OkFJIXKICcqApLsvnWRnEa39IvWVMTqntcfZb1f3hRVhcu1xIwXNvqwgHV+XXa0JcUP
         Zj4+KuzI0BifTfXUeS/5Bf34G1WukSESArWK5uRMvnm/+DLWOHsRKcpTdPfjXgVJnsAb
         fAtH7TAVRskk6BDtTFNX+W302Lz6FY7sY2ak47UvyYGT3UQOfhO70PNkI7DFlxlskwEw
         2T2sNndrDvWkEJIMZRW+SbQjX7UY8SivKalacuLoMV/bkW0W1ipg3LiIlewylL9UPG2t
         zVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715713253; x=1716318053;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uaRNapfMv5f1rVugo2BX+9Ar9b3PGznLd2aVR8CIok=;
        b=IoCe933d3nkh/UMCv08vpoTwTqvlt/T9dAgt/GNJRsCmckvEXMDAwUZzkSMHhlmyD2
         tVDaPpY2ByUnG2Fi98Sv40dLL5CN+//vQBaOSJTKSCSJvm3srwNu1Kw7Oho1Lnj4d21I
         ctsLctUAcCbdkWdlQXD9BxCw3pV682yTPXyKbnAx0LcWv3urXRywqFG+QQoB2gdA+COZ
         hT2wu+t8mPeIHKKE/wCGu5z7+jbJiN83/zRVc1d1qWsDT+MjuVmr2cc3WhUWCjXMZWUU
         Lm70frfRFnwkVF3GcVnD6kg/LBxY/laQzuG/4GcOaHKmdiZ8JqeYuttR7kxzzrOEtj24
         S7OA==
X-Forwarded-Encrypted: i=1; AJvYcCX+OttSUPHlgzmy0l8Nspmf8IUanSQ8yQ82Wcam1FvamloUEFL4hyCM3+7qb3zNYAFNUKj5lVCNMJvXvx7IEI7PcLhBaf47WWdvcOKO7mA=
X-Gm-Message-State: AOJu0Yw3suNIY/gYyuOLa2Kr/9hs8CkUX9x/Y+owFpv1k7iaI654IweH
	YMc+LLIJX2t0iaXFkGi75+GuKfIJ4JpxPcd0dYU3a3KgFo0f1cFmmW5zeudn3z4=
X-Google-Smtp-Source: AGHT+IF8Tfh2uu+B1TsYgX0zRT6Rbfo1m6HiOQghs7bs/CgInno9rJlztpdNh3x1sVdGe6eXublZZg==
X-Received: by 2002:a05:651c:505:b0:2df:baf3:2ae3 with SMTP id 38308e7fff4ca-2e51ff4d047mr107289251fa.29.1715713252968;
        Tue, 14 May 2024 12:00:52 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:7881:38ef:d13d:5d35])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ef09ffsm18123191fa.59.2024.05.14.12.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 12:00:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
Date: Tue, 14 May 2024 22:00:48 +0300
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
Message-Id: <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_120056_981887_7A18AC03 
X-CRM114-Status: GOOD (  20.99  )
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



> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>=20
>>=20
>>=20
>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>=20
>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
>>>=20
>>> Userspace can send the data lifetime information using the write =
hints.
>>> The SCSI driver (sd) can already pass this information to the SCSI
>>> devices. This patch does the same for NVMe.
>>>=20
>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>> And map the incoming write-hints to plids.
>>>=20
>>=20
>>=20
>> Great! Thanks for sharing  the patch.
>>=20
>> Do  we have documentation that explains how, for example, =
kernel-space
>> file system can work with block layer to employ FDP?
>=20
> This is primarily for user driven/exposed hints. For file system
> driven hints, the scheme is really file system specific and therefore,
> will vary from one to another.
> F2FS is one (and only at the moment) example. Its 'fs-based' policy
> can act as a reference for one way to go about it.

Yes, I completely see the point. I would like to employ the FDP in my
kernel-space file system (SSDFS). And I have a vision how I can do it.
But I simply would like to see some documentation with the explanation =
of
API and limitations of FDP for the case of kernel-space file systems.

Thanks,
Slava.


