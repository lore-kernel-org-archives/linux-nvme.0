Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E2C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 08:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rroRLlBJT6GfRNu70mzcTibxuMmHZLKJG0t1hBrphsg=; b=gc4rGouek13vs+dUjL78jg4igS
	LE961FP9cuiGJ3xHEZKjbXSFB2hZ8NCpB+QyjkIiLYt83OxiwXq5Ajy5s1uPfOhR5d91w/MEfhHL7
	vQx7RIW+PdhdA6Sdoq01yZ3ZvdJLm0rqOzvJ2rWZ1Lkv80hH7aiKi5MJoFK+fSJLT+g5L91gBnjv4
	F6QXahRoO3vyE/vmrvCvfVS2I6k6R2M5K5YkTgJ3G9QFhtkM2BWgPwW5vozOW8dwiQCQ/Qix0Tboc
	RNcRIyWDcEeB5EYv62GYv+ZYnQPwIzDuEdJeFZnP2Q05Eps+J2Y3uLBC5L1SuRG1/pyBgUGcUVm9r
	Vr7DZ0Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgkK-00AQUb-06;
	Mon, 25 Dec 2023 08:55:36 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgkF-00AQTh-1s
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 08:55:33 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50e741123acso1112318e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 00:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1703494527; x=1704099327; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rroRLlBJT6GfRNu70mzcTibxuMmHZLKJG0t1hBrphsg=;
        b=mg0/oncTg81W9FWBm9GGzOlD0TuuP3lARR008Uz+7GRKMfZrjumXtyJDzxgI7kJ5F+
         iwZL/SjxA/fwq8fBMZrMKHj3PQcIcFvBHryZqNQvVmRT1754oCCG1eJlpg74s/zaWO2g
         DLXcwqorixuPnqSwpmKhLlAr+RScpMit+sgmwWonyZAU/06qYEPjrXMFZaOvYHx7eRpQ
         s/ENhBwTWThJRTOQBdbbH9qLY8gl+nXLoU7UHFVY/zzXDz8LnfCE5jwpt+7i/QiaxZS5
         4gamynPsYetdLczDRWuJaErngVuxe/2TQwNlJad6yGYmp8BMRuwumSmH8YGTBJo7rcIo
         x98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703494527; x=1704099327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rroRLlBJT6GfRNu70mzcTibxuMmHZLKJG0t1hBrphsg=;
        b=aDMy7V4M1szAoWpEZVJ5jehQZzWVCnfp13EqgLDSsB0RKQAmCnky6nqAylGLDamKLr
         gQ5dXXdk8wOAvGQTselP4ZTBtKJoKa2KPGzxzSX82bX1KeNZAeds+2DkyUSsGPqi0L/r
         ZglkQSfnejSZFJY+Fo+wF6lfj2BhFakaQ07YZgzaQknn8zPoVDIajA97Ch8+gPkfx8or
         vuQ4+TQQDrhPEUIpjf3Dn4N9LTBcuhkXReyJBZYL4TBqp+hoZIPwoubF9kvtOBx1yawY
         wXtCrYzhbVrukPLo6cwFpjB1lD8gdApFrd9GdYnXjnZ6BY7mUbLMAG231mlpdEZuTmQM
         r6Hg==
X-Gm-Message-State: AOJu0Yypjzfa9aZpQEaKpAoygFBqeAY/HeF+dm3lJSjl3i7d5avuQdGB
	OaiHMm/wcJ7rfQ5g5nwCHAXnP1/8mCQfWg==
X-Google-Smtp-Source: AGHT+IFSJKqM83HqTWjurjjSswy3qfTP3qwNqDRKOQb7Q6Q9cIw6mHWOV8UA03+wzEzCtDXgsyhqAA==
X-Received: by 2002:a05:6512:2f7:b0:50e:76bd:fa23 with SMTP id m23-20020a05651202f700b0050e76bdfa23mr646575lfq.87.1703494527641;
        Mon, 25 Dec 2023 00:55:27 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:d097:b658:f57b:dbcf])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25611000000b0050e75afd92csm628185lfd.212.2023.12.25.00.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2023 00:55:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <ZYWz8K98YUGf/VZp@casper.infradead.org>
Date: Mon, 25 Dec 2023 11:55:23 +0300
Cc: Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>,
 lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE53ACBB-1787-4EA0-93D9-1147E43A5F57@dubeyko.com>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
 <ZYWm_tMtfrKaNf3t@kbusch-mbp> <ZYWz8K98YUGf/VZp@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_005531_642379_70CE1218 
X-CRM114-Status: GOOD (  18.33  )
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



> On Dec 22, 2023, at 7:06 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Fri, Dec 22, 2023 at 08:10:54AM -0700, Keith Busch wrote:
>> If the host really wants to write in small granularities, then larger
>> block sizes just shifts the write amplification from the device to =
the
>> host, which seems worse than letting the device deal with it.
>=20
> Maybe?  I'm never sure about that.  See, if the drive is actually
> managing the flash in 16kB chunks internally, then the drive has to do =
a
> RMW which is increased latency over the host just doing a 16kB write,
> which can go straight to flash.  Assuming the host has the whole 16kB =
in
> memory (likely?)  Of course, if you're PCIe bandwidth limited, then a
> 4kB write looks more attractive, but generally I think drives tend to
> be IOPS limited not bandwidth limited today?
>=20

Fundamentally, if storage device supports 16K physical sector size, then
I am not sure that we can write by 4K I/O requests. It means that we =
should
read 16K LBA into page cache or application=E2=80=99s buffer before any =
write
operation. So, I see potential RMW inside of storage device only if =
device
is capable to manage 4K I/O requests even if physical sector is 16K.
But is it real life use-case?

I am not sure about attractiveness of 4K write operations. Usually, file =
system
provides the way to configure an internal logical block size and =
metadata
granularities. Finally, it is possible to align the internal metadata =
and user data
granularities on 16K size, for example. An if we are talking about =
metadata
structures (for example, inodes table, block mapping, etc), then it=E2=80=99=
s frequently
updated data. So, 16K will most probably contains several updated 4K =
pieces.
And, as a result, we have to flush all these updated metadata, anyway, =
despite
PCIe bandwidth limitation (even if we have some). Also, I assume that to =
send
16K I/O request could be more beneficial that several 4K I/O requests. =
Of course,
real life is more complicated.=20

Thanks,
Slava.


