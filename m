Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EA2C3ABB6
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vD6ieySZaSMEmO/1InvJncJpiiRLBXkT9kG0v3hVgcQ=; b=W7XM6mrRUU9K6p2rbRnI/oXvPh
	SRtssnPmp65CV/DLRxPQo4hIjKBt4aVfZMscN9MMPHMvYAXyVkisX/31v9bG5JoNcA6o7Wl01JIuw
	anme2Q0WrXOTaszjbXgpxfDbVyTT7QwgygxHrtmyEI2ylnJuVje5WXoA2J4/9Mve76IlDwCBNShx/
	RH6hIdXOSe56MWjX3ofzsKCBaglV7iT5vovQk0vOApLwRZ6cdrAIbRprh5knQ+WtnbOJw5sAqFG2h
	sfTWTuzE8r7kHkss74WGGSg7sPJW0b1Z0pJGMyNG/YqwTWJV5W7tuv5UtWmR6nHJ17oDZ5GWilIn3
	oVaGA6HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBv37-00000007Kn5-1ZNx;
	Mon, 05 May 2025 12:35:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBuwr-00000007Jk7-3aXm
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 12:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746448167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD6ieySZaSMEmO/1InvJncJpiiRLBXkT9kG0v3hVgcQ=;
	b=Cqw4BOs/SWlHorIPNZrYj0KdwdwaVXqne9YbMGv3az8Ms5JJBEQm0vRLEVqoWaonY+nOR1
	uPhplFlpJlebcWKeo117fSxHaOtyP6tzXGH92QWW+RbzKO+P8CfekRlvgblumcuauc3KRF
	bZDh8w3vKpy1hK9b6IfOSFHTnjC63+s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-DHxqZXrkP3icYKsXbpiSHA-1; Mon, 05 May 2025 08:29:26 -0400
X-MC-Unique: DHxqZXrkP3icYKsXbpiSHA-1
X-Mimecast-MFC-AGG-ID: DHxqZXrkP3icYKsXbpiSHA_1746448166
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3fa1ddd6bdfso1186240b6e.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 05:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448165; x=1747052965;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vD6ieySZaSMEmO/1InvJncJpiiRLBXkT9kG0v3hVgcQ=;
        b=XLrTDrDd9fYtEpUwlRxTUgDydQPcokK1lUv+vY8G5MOqptOXfXqahM/9Likzv7vicF
         V8WNbHD+s3slUKseItZRbzCzc1ZZ75AJhx46SiT8UOp3weVjCNeY4YeG0WxdbLGNTTm5
         iQ2OPWZLVzGykFkF03xnqG2m69kwfcS0LDTyWZ4PUAPJFSFR4attSCVl45X9xnYlbQXJ
         gmhtGVxQRsf1KpzC5QJCQU3i+IsGbRbXjiD3CkKHgevhYqgkWKBvQKNTgluQH0broEhR
         bRc78qYvzm8fDyNt/896uIgut17E4JEZFYDRt8TceE3dXi744H8ypdJtLJtR31rKWptU
         adOg==
X-Gm-Message-State: AOJu0YyyrjwlB/eSkbcnj53mG1C/VdgWk1iaMtROxv6aFP6aCDlvIQlh
	olgzT1Tz4l0XIoqYBqd1cmHnjn4LbJUwQHzZkTmIXvbVSo6jHkbr2wtOKZ3HWKVkwxqt+PCi2Jq
	UShATtsyQIMqE/+85Fnhsbq1JYUw5f8NAU8QYxHhvtR40u+pIjACdn76jhkrxSxGe
X-Gm-Gg: ASbGncvSOZb9gPLfw+gDsNiDyXwfAngeTBD3E0kMs/yKnfoLeEZ2Q7bd3jb2d46Rz8Z
	AJnCqBI77crJs5D3A4vX3pfAzXPLzKIWQi8xL0mKqlA/m+PR4VarY8l59wHOsmgaHJP2gXY0yaJ
	hg1s/nPOO7B++89jIAH5J6A1SRe/BwG3J0N7Yk8QVCTZkof5CGebfQVcRyRlZxeuH1UbziAr8B2
	qEx2Q1jNM0omUYVZwxdwO7JkuCZ7u/vhrVVXQ2sEvNjqefGwKfu+HeCD5wKYUeq8AXrDwPZYDsr
	JN7V5szohrZxfyGqv1UmQEStHU2q3Kfvv4INVFJd5Z5NXxNdoBQqM+dOOSfU8g==
X-Received: by 2002:a05:6808:bc9:b0:403:290c:74a with SMTP id 5614622812f47-4035a58485bmr4120863b6e.20.1746448165722;
        Mon, 05 May 2025 05:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsD2ST4a3Uo0A6T5OxLxFk2/TlW1gU7xcpu3xPcTgRCcsS4BARvQL/mpn+SktWUmE5GCUgnQ==
X-Received: by 2002:a05:6808:bc9:b0:403:290c:74a with SMTP id 5614622812f47-4035a58485bmr4120847b6e.20.1746448165319;
        Mon, 05 May 2025 05:29:25 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033d9c21e4sm1808879b6e.17.2025.05.05.05.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:29:23 -0700 (PDT)
Message-ID: <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
From: Laurence Oberman <loberman@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Anton Gavriliuk
 <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Mon, 05 May 2025 08:29:21 -0400
In-Reply-To: <aBfhDQ6lAPmn81j0@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
	 <aBaVsli2AKbIa4We@dread.disaster.area>
	 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
	 <aBfhDQ6lAPmn81j0@dread.disaster.area>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C7Sfn719moaaU2sHQtTkVZJlqu5HXjutZ3dEOn-wlX8_1746448166
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_052929_972996_DBA17550 
X-CRM114-Status: GOOD (  13.35  )
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

On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> [cc linux-block]
>=20
> [original bug report:
> https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMm=
tr1oC=3DfOOgAQ@mail.gmail.com/
> =C2=A0]
>=20
> On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk wrote:
> > > What's the comparitive performance of an identical read profile
> > > directly on the raw MD raid0 device?
> >=20
> > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> >=20
> > [root@localhost ~]# df -mh /mnt
> > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Mou=
nted on
> > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=C2=
=A0 34T=C2=A0=C2=A0 4% /mnt
> >=20
> > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exi=
tall
> > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T=
)
> > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > fio-3.39-44-g19d9
> > Starting 1 process
> > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta
> > 00m:00s]
> > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May=C2=A0 4 0=
8:22:12
> > 2025
> > =C2=A0 read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001msec)
> > =C2=A0=C2=A0=C2=A0 slat (nsec): min=3D971, max=3D312380, avg=3D1817.92,=
 stdev=3D1367.75
> > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D78, max=3D1351, avg=3D174.46, std=
ev=3D28.86
> > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D80, max=3D1352, avg=3D176.27=
, stdev=3D28.81
> >=20
> > Fedora 42 (6.14.5-300.fc42.x86_64)
> >=20
> > [root@localhost anton]# df -mh /mnt
> > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% Mou=
nted on
> > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=C2=
=A0 34T=C2=A0=C2=A0 4% /mnt
> >=20
> > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exi=
tall
> > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T=
)
> > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > fio-3.39-44-g19d9
> > Starting 1 process
> > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta
> > 00m:00s]
> > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May=C2=A0 4 10=
:14:00
> > 2025
> > =C2=A0 read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001msec)
> > =C2=A0=C2=A0=C2=A0 slat (usec): min=3D3, max=3D273, avg=3D 5.63, stdev=
=3D 1.48
> > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D67, max=3D2800, avg=3D374.99, std=
ev=3D29.90
> > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D72, max=3D2914, avg=3D380.62=
, stdev=3D30.22
>=20
> So the MD block device shows the same read performance as the
> filesystem on top of it. That means this is a regression at the MD
> device layer or in the block/driver layers below it. i.e. it is not
> an XFS of filesystem issue at all.
>=20
> -Dave.

I have a lab setup, let me see if I can also reproduce and then trace
this to see where it is spending the time


