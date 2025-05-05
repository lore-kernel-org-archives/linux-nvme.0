Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E65C3ABAA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIG82GRDutsfX6ZuO5wxnZIciX/BmGs6c3KresObAZ8=; b=Zb7Vfmuvn3hNsQQ++t04Fs4yGM
	qH6pyJTJu21n5anUDZ47wl9zf4pQeJDA+PwS/LWGTsKv7/jRgAzoenzClxOxVwMlxuE9FRS/osknk
	ULzYu4EnCLZf7IQCZzphZ97Sqwd4VgMN5tYPoU1goVWsljArjlR6eOTKWeVB8ASqKGgy57sA0eMgx
	LnuJrNoMH7pyP83opqrjHEmLf0s/hWCWo/CnNFY1q8mYzLnLDc9ngbtcJqYoiPeNkVzP5l4KLORZi
	EEILwZIkzatOp1cda9JbhKZW8gQU42fPEYGvbI0NghcruRELwlTAxf7TksaI/4S6ooMQlgvqWQDZS
	4GhX5hpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvl9-00000007Ski-2kcb;
	Mon, 05 May 2025 13:21:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBvl6-00000007Sfv-36F3
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 13:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746451283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIG82GRDutsfX6ZuO5wxnZIciX/BmGs6c3KresObAZ8=;
	b=TuUX5/EkkRWQyPMeFKv1f1jLvHR00cURdmOiuWqgywzhsWxGiL2pI3b2Vc0iuu8ws1aA3f
	KaLgKCblr/JPdmP9998O48zfxI9A3ARb2GNyirj37G9yu/yYARcLTI0LMnl607zYJv6z9l
	5bLN9linRMKD3o/z4ZkK7UrHs1pNCfU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-B1GdfjuUM0OsKyIq5VshKQ-1; Mon, 05 May 2025 09:21:22 -0400
X-MC-Unique: B1GdfjuUM0OsKyIq5VshKQ-1
X-Mimecast-MFC-AGG-ID: B1GdfjuUM0OsKyIq5VshKQ_1746451281
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-60212c73868so3863070eaf.3
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 06:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451281; x=1747056081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIG82GRDutsfX6ZuO5wxnZIciX/BmGs6c3KresObAZ8=;
        b=TM5m433B+od8Nj0tEJH63AC9QuisMACaqh9iUzwUlIa3WDMKY/98FE44Vh0VuBaEti
         z63p+ea94ZshBpOaZjSAl9ngcuSEUv4O+3nCqHRMuDpEmabVGjvNwF2Dke08WAXwpmwS
         At07Ae5ny1FWjaHMdxWAh+N9Df22q/RqTXlGisadUExQZdpJs2iJmLnQ/49ozmm9nrRr
         cCLSvCT6k1oz+GCWqCl/mk/icK6jK7m1kpLajYhovEf7xR/VArupVrVm0HBRItEOVDO7
         DoeK0QqsZ85wGVfetJKDxK0x5ECCO+REej83onXSRE3IVrC2YNIXQ9SoIHlMvDoBWmOj
         LuSw==
X-Gm-Message-State: AOJu0YzIw/xUaER0h5maBI6keLeYu8xgycziV9Dh5GPtmmkMZO92JfQQ
	YwupvhIGyUDoWTi5BDvOEvvc2X+ajVtfAkFkqSf1L0Zbhf3shBfhe2VY+KfmBAXM9OK7ipCf6Gd
	68utrW67ugBIQpT0dcTNN/bq5F55DsXRXVe96Aw7bE5mUGUQk1Q8RL77RZvukcyxh
X-Gm-Gg: ASbGncv89XGSF4CnNlJcp8F+Hf3uYsSLOEK43AEALFnmYIU3rose6wnoSNTBEKLwErK
	sEjHbolRNznf2J8mf5zeSzQqDla3BdWddyhE9CQgazXj9SB1gXjPQ39Y6syEt0RVMYvlmRCG3mD
	0E4wo8/o1xynWsixd4glGw32qL96hUEJ33QAWf0AkdMRF+fk4QNC/a92CxRCW/oScVUKKvL4+vd
	ld3wfjhLIVEDnPbRLkCcGFBkYMwbPre9BdXrnGG8a8fj+LbALnZv/3Bo63TyURLxX7praZDVZDx
	2NKaMwgPiRWS/ANUuw/7Mv8QCxQ2C2LtwttuC7xMfJq4oW2NmeLXQ7Q07y5ehw==
X-Received: by 2002:a05:6870:241d:b0:2b7:f58d:6dcf with SMTP id 586e51a60fabf-2dab306a348mr7088223fac.18.1746451281670;
        Mon, 05 May 2025 06:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSFoVMOrZluBnw+MORthCitmUF2zcmvueOnmkO8JsVGz6KhUlfEjQyECXfa5BsXBb6t8dxQ==
X-Received: by 2002:a05:6870:241d:b0:2b7:f58d:6dcf with SMTP id 586e51a60fabf-2dab306a348mr7088214fac.18.1746451281316;
        Mon, 05 May 2025 06:21:21 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa1207873sm1985356fac.38.2025.05.05.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:21:20 -0700 (PDT)
Message-ID: <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
From: Laurence Oberman <loberman@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Anton Gavriliuk
 <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Mon, 05 May 2025 09:21:19 -0400
In-Reply-To: <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
	 <aBaVsli2AKbIa4We@dread.disaster.area>
	 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
	 <aBfhDQ6lAPmn81j0@dread.disaster.area>
	 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lOIcsZW7vR6vFsoQPE8Z5_WqoNlYZjfIQRgxBeuH-Co_1746451281
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_062124_860779_47FA8729 
X-CRM114-Status: GOOD (  16.90  )
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

On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > [cc linux-block]
> >=20
> > [original bug report:
> > https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZB=
Mmtr1oC=3DfOOgAQ@mail.gmail.com/
> > =C2=A0]
> >=20
> > On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk wrote:
> > > > What's the comparitive performance of an identical read profile
> > > > directly on the raw MD raid0 device?
> > >=20
> > > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> > >=20
> > > [root@localhost ~]# df -mh /mnt
> > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% M=
ounted on
> > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=
=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > >=20
> > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --
> > > exitall
> > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB,
> > > (T)
> > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > fio-3.39-44-g19d9
> > > Starting 1 process
> > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta
> > > 00m:00s]
> > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May=C2=A0 4=
 08:22:12
> > > 2025
> > > =C2=A0 read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001msec=
)
> > > =C2=A0=C2=A0=C2=A0 slat (nsec): min=3D971, max=3D312380, avg=3D1817.9=
2, stdev=3D1367.75
> > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D78, max=3D1351, avg=3D174.46, s=
tdev=3D28.86
> > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D80, max=3D1352, avg=3D176.=
27, stdev=3D28.81
> > >=20
> > > Fedora 42 (6.14.5-300.fc42.x86_64)
> > >=20
> > > [root@localhost anton]# df -mh /mnt
> > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Use% M=
ounted on
> > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=A0=
=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > >=20
> > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --
> > > exitall
> > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB,
> > > (T)
> > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > fio-3.39-44-g19d9
> > > Starting 1 process
> > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta
> > > 00m:00s]
> > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May=C2=A0 4 =
10:14:00
> > > 2025
> > > =C2=A0 read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001msec=
)
> > > =C2=A0=C2=A0=C2=A0 slat (usec): min=3D3, max=3D273, avg=3D 5.63, stde=
v=3D 1.48
> > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D67, max=3D2800, avg=3D374.99, s=
tdev=3D29.90
> > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D72, max=3D2914, avg=3D380.=
62, stdev=3D30.22
> >=20
> > So the MD block device shows the same read performance as the
> > filesystem on top of it. That means this is a regression at the MD
> > device layer or in the block/driver layers below it. i.e. it is not
> > an XFS of filesystem issue at all.
> >=20
> > -Dave.
>=20
> I have a lab setup, let me see if I can also reproduce and then trace
> this to see where it is spending the time
>=20


Not seeing 1/2 the bandwidth but also significantly slower on Fedora42
kernel.
I will trace it

9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64

Run status group 0 (all jobs):
   READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec

Fedora42 kernel - 6.14.5-300.fc42.x86_64

Run status group 0 (all jobs):
   READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec





