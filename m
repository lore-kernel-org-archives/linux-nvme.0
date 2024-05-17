Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83AEC04FFE
	for <linux-nvme@archiver.kernel.org>; Fri, 17 May 2024 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a9v5UHstQmCiEMrDNZmaD/04p0iBzlvQ5DIypYPTouQ=; b=ZE6rPB1BYbkf3xf7bEyYMTUC2V
	wEzoXxlhXaQA8x2q2Cf+9kInRGo13WtS4FSOw1SH0iU/GM+jyQxfp1ZT+v5R3TVJ4xByGcDiANB8G
	dlhdvmAvrqT3X+IsO0sm04dIGiDFckJX+Y/PhZoyh/0aM/eBVtCUTVN4kXtuqq5I1NyA829ZeHXBP
	1BlL7cLBXmHxTXQMuaJHaGWJp1EhDBJgyQh7J/7YOR94w95J6qSoBr7dUGU1IvUFsJpYBGEcXtE+S
	clHhVJQjA1R6gY3fx0LsLCjKOaWdDbTuxyQfuJkGtshKbaHFIhX4IYMGLJEeYvkNB0n1EHsYZOKrb
	4F2lsofw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s81Hj-00000008Vwm-0xrR;
	Fri, 17 May 2024 17:22:23 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s81Hf-00000008Vvd-2Diu
	for linux-nvme@lists.infradead.org;
	Fri, 17 May 2024 17:22:20 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so2090115e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 May 2024 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715966535; x=1716571335; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9v5UHstQmCiEMrDNZmaD/04p0iBzlvQ5DIypYPTouQ=;
        b=JWW7g+IQpgBI3aiKbklGautfWa8KXQu80Kqy35h8k9hH4RgT7mnSClWanTwSO2R6Nl
         0y92+Vd08GA4YYfFdP5j+AYDJ1g4PLprcqHL32ixEaVZtQp8cEZ2s2cCIn9VkDxd29v4
         cC6BxfUH/8icUpkCirYj4yo9/8RiiSwjC41imjfqQ4ss8Lrg1ckMyg/4w16lC7kp0AA0
         MZnFc+7WmoX5dG0/ZhCoeVc/BYiI1QS6p4+QwI789CmTz0WA8uzHg9BZBPT9OM+HEJW2
         +CQXvy8V2uzqZ+GCBie+vjY20CxCxyBCQZD4pYeHvaGGXVxXkYzcUHGNvwASm3sASWdF
         lo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966535; x=1716571335;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9v5UHstQmCiEMrDNZmaD/04p0iBzlvQ5DIypYPTouQ=;
        b=c//E6xo3aLC7yPnvB9+0bjqjnFSgfMEo4Hx1hLHXgIf8325/CnnHi6ldP9iW4Y7VzV
         mS17YKQYrRwXYsLT7Kfdf1MSCXgi+o7mdTRvWOXVbYaMxIWpY+78n6OPj464+C87KLbp
         lIT+dPzQloGMy3/4F6RAD/cfnlW1RPQrCYXuggG52RgPwRWd+2Yhw9/4NfenptapZJgs
         vJZqCO5Xwj/fEzPoQXIj4roLA249ql/BKzcZZO9omrubboZL4bUQRDKB5UqyyuHISdgK
         6RAvO8Z3BiRUB5+DMhpsBdEOTiBYt4fPygZ/SBlLzLdKN5CBtVeFK6EKDuWUN4H8Ky+V
         RrrA==
X-Forwarded-Encrypted: i=1; AJvYcCVuWatvnGqlEhm5V5VxuF2vFVLBv9BDe38JFbPSUNTBIucVxGK07VJOV6eC+AopwT4DhrQss+10y54Eekt4mlPMNTqAUjT5t2GVq6jD6vc=
X-Gm-Message-State: AOJu0YyL+VDI2aEftmrlxQuAhGaOiFdXmPSNyScj0L3TcHYknLakRy4b
	HoF7YwWGzFPCQEdlrfWa13TsPatzpnRhTlmdkj6q28BLwOX7Ee4L+mC/iVzeEbk=
X-Google-Smtp-Source: AGHT+IFzagdP4PeigI0hrZjJ8bPqkcttP59bYrzytO6RudEioXqfJ1z28D27QFTyu+49dRg0+vhc3w==
X-Received: by 2002:a05:6512:1289:b0:519:65fe:ac10 with SMTP id 2adb3069b0e04-5220e68b5a3mr8362770e87.32.1715966534663;
        Fri, 17 May 2024 10:22:14 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:197b:a3fe:ebe2:821e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8bafsm3319862e87.235.2024.05.17.10.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2024 10:22:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
Date: Fri, 17 May 2024 20:22:11 +0300
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
Message-Id: <E069A44C-9B95-4B7D-97C2-0087A8E68B48@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
 <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
 <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
 <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240517_102219_694182_B7D8D36F 
X-CRM114-Status: GOOD (  27.08  )
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



> On May 17, 2024, at 7:27 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Tue, May 14, 2024 at 2:40=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>=20
>>=20
>>=20
>>> On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>=20
>>> On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>>>=20
>>>>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>>>>>=20
>>>>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows =
the host
>>>>>>> to control the placement of logical blocks so as to reduce the =
SSD WAF.
>>>>>>>=20
>>>>>>> Userspace can send the data lifetime information using the write =
hints.
>>>>>>> The SCSI driver (sd) can already pass this information to the =
SCSI
>>>>>>> devices. This patch does the same for NVMe.
>>>>>>>=20
>>>>>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>>>>>> And map the incoming write-hints to plids.
>>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Great! Thanks for sharing  the patch.
>>>>>>=20
>>>>>> Do  we have documentation that explains how, for example, =
kernel-space
>>>>>> file system can work with block layer to employ FDP?
>>>>>=20
>>>>> This is primarily for user driven/exposed hints. For file system
>>>>> driven hints, the scheme is really file system specific and =
therefore,
>>>>> will vary from one to another.
>>>>> F2FS is one (and only at the moment) example. Its 'fs-based' =
policy
>>>>> can act as a reference for one way to go about it.
>>>>=20
>>>> Yes, I completely see the point. I would like to employ the FDP in =
my
>>>> kernel-space file system (SSDFS). And I have a vision how I can do =
it.
>>>> But I simply would like to see some documentation with the =
explanation of
>>>> API and limitations of FDP for the case of kernel-space file =
systems.
>>>=20
>>> Nothing complicated for early experimentation.
>>> Once FS has determined the hint value, it can put that into
>>> bio->bi_write_hint and send bio down.
>>>=20
>>> If SSDFS cares about user-exposed hints too, it can choose different
>>> hint values than what is exposed to user-space.
>>> Or it can do what F2FS does - use the mount option as a toggle to
>>> reuse the same values either for user-hints or fs-defined hints.
>>=20
>> How many hint values file system can use? Any limitations here?
>=20
> As many as already defined (in rw_hint.h). Possible to go higher too.
> No hard limitation per se. Write is not going to fail even if it sends
> a hint that does not exist.
>=20

OK. I see. Thanks.

>> And how file system can detect that it=E2=80=99s FDP-based device?
>=20
> It does not need to detect. File system sees write-hints; FDP is a
> lower-level detail.

I see your point. But SSDFS doesn=E2=80=99t need in hints from =
user-space side.
SSDFS has various types of segments (several types of metadata segments =
and
user data segment) and I would like to use hints for these different =
types of segments.
I mean that SSDFS needs to make decisions when and for what type of data =
or
metadata to send such hints without any instructions from user-space =
side.

Technically speaking, user-space side doesn=E2=80=99t need to care to =
provide any hints
to SSDFS because SSDFS can manage everything without such hints.
So, I would like to have opportunity to change SSDFS behavior for =
different
type of devices:

if (zns_device)
   execute_zns_related_logic
else if (fdp_device)
   execute_fdp_related_logic
else // conventional SSD
   execute_conventional_ssd_logic

Does it mean that there is no such way of FDP based device detection?

Thanks,
Slava.


