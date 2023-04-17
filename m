Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FDEC77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i439ByrCwwyeW71ZoBXBy3yEzqs8Vnj9PSWAYBsoXlE=; b=ubJ0j0wOPTYRbN4+N74QYvEuP8
	w2WU1j7+TqQfTdGfW+g0pzOhLSWoF3TLb70T9g8SJlVGdKfXTpiYxNZSWgOnvqgcczaOpkTCjR+aM
	WRiqRJr/xnQUi7B+49oLUB9naGkEZR5zVIqh/YbpPNYRzzE18wSCpqRC6g0O14DxBG3ZW4OKcr1gM
	zq+m4HAWMBXQtNkr5vszkMPlSmgJ/Pr61KFAqmQGATuVaTliCBAnYxVgYqpMSs870DAogubfKg9e8
	jVF6X4E1P6bzlHQdcbFpF5dvERxOyECz68OObLc3xuX9LR9QDvkIKdzCMr5oFMXW9iIeBJ2+gwG1A
	rM1y2e1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poFYQ-00Emc0-2X;
	Mon, 17 Apr 2023 03:29:22 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poFYK-00Emb2-09
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 03:29:18 +0000
Received: by mail-pj1-x1036.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso10831851pjr.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Apr 2023 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681702152; x=1684294152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i439ByrCwwyeW71ZoBXBy3yEzqs8Vnj9PSWAYBsoXlE=;
        b=CZIhzjCN+vEVTWpW65Yup+aopwZLg+7s8FT92h4UGxiUCXwnDrLdzodkMn46t1WRCm
         EHa/z84VHl6kq5BEgCJLxRGlBfwJHvYCpu/CBrFbDGLig4OyIE7DnNKIhFWklYg9172M
         CatswHGFSeNeVaSfXEnW7sKMUDbv+A0MeLWoxrvQvkLOYBLWea1N2qlCLY6avBPl9kMK
         OkDwwnFgqmIZaWymXf7qbmnB+aGhWu+V+R3PMlmfONx5I46r0j9g+xJcwHxMdTvqdm0k
         f7aJSZbC+2zgtMIm/30mDPfKm737OeHamS1xzjDztETJei2pDxbLPbBHSN9WlrjBQ6IL
         9muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681702152; x=1684294152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i439ByrCwwyeW71ZoBXBy3yEzqs8Vnj9PSWAYBsoXlE=;
        b=YKmSBobmJqiRtHoIQ8pFE2g4VQdfvMTZFCh9aOlQ2EZ7SdmrBjJoL9Iywx/YVr8b7w
         Ju1GB3D1WzZoxQJWTgaQvQ6FsvS4lbrhc/5T+M+mHzTghi0+eNWPvBoGHyw4r1Q3Pw8M
         BoiFj7nOlf4A20Yp+PjcbSYFOLWXkOux1CoLlVLWmek5STkDzMfle6yCjno4VGfbltTb
         4cVeblfCTYFm6thMo3eYAeXrEdrOik4E8YLyso6Vx1UAfeYCO52EFCekIFKA9AuHt+QH
         2/nF+HbEApn/ppzVIMbGYBEweQ9ToHIpGN/8tyN2FBGTBJyJKfCn21WWcHg0+uqAWuuN
         FdtA==
X-Gm-Message-State: AAQBX9dDf4kN7Cx5aqjwagyU9RwJWGS/ftW6GrcqrubUT+FiHdN1o9zX
	K7IBksHPqKgMkfWRoq27xB1img9tF8R8uiWaIyyRUga1nhc=
X-Google-Smtp-Source: AKy350YJJdcM66yr8j9/kPzcnVKnGuU1IZcC++IHyi8cKOk9L52nS3dy7qY5Jtqe1FbMnc6AHgOYtw==
X-Received: by 2002:a17:902:c947:b0:1a6:7ea8:9f47 with SMTP id i7-20020a170902c94700b001a67ea89f47mr12982890pla.66.1681702152044;
        Sun, 16 Apr 2023 20:29:12 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm6525445plo.42.2023.04.16.20.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2023 20:29:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
From: Li Feng <fengli@smartx.com>
In-Reply-To: <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
Date: Mon, 17 Apr 2023 11:31:08 +0800
Cc: Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5745886-81C6-4BB3-848C-D4A7E47E720A@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
 <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
 <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230416_202916_305989_60DACDD2 
X-CRM114-Status: GOOD (  25.16  )
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



> 2023=E5=B9=B44=E6=9C=8816=E6=97=A5 =E4=B8=8A=E5=8D=885:06=EF=BC=8CDavid =
Laight <David.Laight@ACULAB.COM> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Li Feng
>> Sent: 14 April 2023 10:35
>>>=20
>>> On 4/13/23 15:29, Li Feng wrote:
>>>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>>>> to N-1. However, some cpus are busy for other jobs, then the =
nvme-tcp will
>>>> have a bad performance.
>>>>=20
>>>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
>>>> socket worker threads.  The parameter is a comma separated list of =
CPU
>>>> numbers.  The list is parsed and the resulting cpumask is used to =
set the
>>>> affinity of the socket worker threads.  If the list is empty or the
>>>> parsing fails, the default affinity is used.
>>>>=20
> ...
>>> I am not in favour of this.
>>> NVMe-over-Fabrics has _virtual_ queues, which really have no
>>> relationship to the underlying hardware.
>>> So trying to be clever here by tacking queues to CPUs sort of works =
if
>>> you have one subsystem to talk to, but if you have several where =
each
>>> exposes a _different_ number of queues you end up with a quite
>>> suboptimal setting (ie you rely on the resulting cpu sets to =
overlap,
>>> but there is no guarantee that they do).
>>=20
>> Thanks for your comment.
>> The current io-queues/cpu map method is not optimal.
>> It is stupid, and just starts from 0 to the last CPU, which is not =
configurable.
>=20
> Module parameters suck, and passing the buck to the user
> when you can't decide how to do something isn't a good idea either.
>=20
> If the system is busy pinning threads to cpus is very hard to
> get right.
>=20
> It can be better to set the threads to run at the lowest RT
> priority - so they have priority over all 'normal' threads
> and also have a very sticky (but not fixed) cpu affinity so
> that all such threads tends to get spread out by the scheduler.
> This all works best if the number of RT threads isn't greater
> than the number of physical cpu.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, =
MK1 1PT, UK
> Registration No: 1397386 (Wales)

Hi David,

RT priority can=E2=80=99t solve the cross numa access issue.
If the user doesn=E2=80=99t know how to configure this affinity, just =
keep it default.

Cross numa is not a obvious issue on X86{_64}, but it=E2=80=99s a =
significant issue
on aarch64 with multiple numa nodes.

Thanks.


