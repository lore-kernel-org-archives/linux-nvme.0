Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F95C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emv/OBOnxABiRHYiPj1bb4H2ZjmFfXAWFghCoXkCiPw=; b=R5p0U8hrf9khEFVEFF43ZfWE9O
	T7FEH6g/2xc3MZjF+WSJ0L16brgbJin1MjDm8Iz5YIwAC4FJqw+o/STafyTUj1Pf3YiXsLC4HmqEY
	wjaf6bXPiSmi6OeYjMlxXe5bCAK+EftZs/JvidAdd7xAeejeniKK2hRR2Ck5mCiqJZkZlf1xl6Sra
	k93z3UUgsPUY9qYyWVF9EJPaVJb5oJLCKyNmS+18aQT+uKAdukQ0steWa/DWLA3/VHFX7Eo+BWwsH
	O8ga3fzyE77XkSdD/IIVe374oMKvJA58LimEfV2aRisf59Un/DRQSsGSXKark5IweiGI8HR6DXw6a
	WRMhzKnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIOtW-00000003SgN-1ZRD;
	Fri, 23 May 2025 09:40:50 +0000
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIOsi-00000003SW6-1dXa
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 09:40:01 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-e7d78c3f554so1217512276.3
        for <linux-nvme@lists.infradead.org>; Fri, 23 May 2025 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747993199; x=1748597999; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emv/OBOnxABiRHYiPj1bb4H2ZjmFfXAWFghCoXkCiPw=;
        b=DtevaGk6ngeaSymfQObwmHrhv0bjt17DSjt9pyuraDPbdLVgVBaR/s+4Wuog3n5duF
         6h7ehdRyeY8XY0lsHPJp79zn0kFslnjLqgPIkgZRiyqPpPkOx6FTvw0bZ4PopkKu1E9Z
         Xh9m9heljqz6uN4dgsAp9xfclRU0t6UE+lYyTv9Q0Vo9ZJ0joht7aqeXPNb/Cr6Oi8qH
         9CCYlw7UWpg3rvhkNKsE38vXkR5qUguW4KsJG+Y/7F9Lu++5JYtFtJAyo065W0fLeMbs
         pR+yI0PPF0vH5mw2qk+BoTRWFG4/lrsCbIbFWjCMkEY2AIX2qOo1j3aUVMRTilnR4Kmk
         llzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747993199; x=1748597999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emv/OBOnxABiRHYiPj1bb4H2ZjmFfXAWFghCoXkCiPw=;
        b=cXtrNXqQDVjCUkevRCvu9CW/xajvIZ+FuXWMxodOtTQNDNSffh/fSrC76lb+9FfSoW
         JGJsuFFrGLkaSsyeBpzgF1KDqBYUQP7W7iNUaEzBBcvBIY34SrDqC1UGz+BHQI3m2kNw
         Pm9a8aee2JG57DWj15d+wzLHlvMUEl+oA4qH6FtX4Rk+93CoFWeWue2q4g0/csdgGpjb
         xIA5UeJlDD0v6HMBJWvXyov7hVRO11Soy7jprpWulxXt94ZXHoONsBYPr2xiqLoI+bqN
         hoyHlcfQJIfQMRnMLrNm1KhimVYZbpG5EqDXsqyaldZ/I3MTR9F32LQTw1k6RBgzlp2a
         xHmw==
X-Forwarded-Encrypted: i=1; AJvYcCV/1xE8z39V2spdbO2eFK1IGT6ol9VzyHVP//OBd2/rJmPznF/TCmAI6YoWn46D23i8hM83bMKB40rB@lists.infradead.org
X-Gm-Message-State: AOJu0YzaqjCHQ2OHNNkAU5y/K7is39LzwQkZRs9sZKwx1v2vQx5Wligu
	gctcbDwMGVlEDyCuCqbn0323aINhsWDNtMQ/UijDFudP24drW9JmJ/qHgPN0CK62ylBoxFcWQB+
	S75Q6B9DFSBifg05gmNYbs+7W1LT28vFnFavf
X-Gm-Gg: ASbGncseYtf6lLOD4jnqS60W6QbW7kK8ppx+ssG2qNPtuIOyQHGrTShFf8zhrhxNsDH
	L7fKRgjQgMPXdJ9Dl735EBJms2QA6Opq1MyL92s9QoiDsc3wM7YBUUSsh1bWfDRplGqM6O6HvkO
	h3IaYJX4fThNYCt1F413d1a/jI3BObjRziLg==
X-Google-Smtp-Source: AGHT+IHA+SW7aA1Uz+H2reZbfT7BiR5qnto0IAwVmU4f/745lOLX/xhlKG0zU8C73Ft3cTGRXn7DFZ4+W8jWhOhhv1w=
X-Received: by 2002:a05:6902:2581:b0:e7d:70b9:4b7e with SMTP id
 3f1490d57ef6-e7d70b94c8dmr6766337276.10.1747993198576; Fri, 23 May 2025
 02:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area> <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area> <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
 <f01719b1901f9d796837669086d7c1cd14c9922c.camel@redhat.com> <f08554fccd3d5e2c2ec4849b0a8158d63414e356.camel@redhat.com>
In-Reply-To: <f08554fccd3d5e2c2ec4849b0a8158d63414e356.camel@redhat.com>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 23 May 2025 12:39:47 +0300
X-Gm-Features: AX0GCFunFtVoEjxneJ-r5oEiQ-L0yNEYb07vOeg9luGAy_Q0MrrrZPORLg9XtpU
Message-ID: <CAAiJnjoW-gpU6Va-nHTU_E7+b2ajhawx5JY3eJYT62p7icTebg@mail.gmail.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
To: Laurence Oberman <loberman@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-nvme@lists.infradead.org, 
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_024000_438928_421DC216 
X-CRM114-Status: GOOD (  29.78  )
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

> This fell of my radar, I aologize and I was on PTO last week.
> Here is the Fedora kernel to install as mentioned
> https://people.redhat.com/loberman/customer/.fedora/

> tar hxvf fedora_kernel.tar.xz
> rpm -ivh --force --nodeps *.rpm

Rocky 9.5 kernel is still faster Fedora 42 kernel.

[root@memverge4 ~]# uname -r
6.14.5-300.fc42.x86_64
[root@memverge4 ~]#
[root@memverge4 ~]# cat /etc/*release
NAME=3D"Rocky Linux"
VERSION=3D"9.5 (Blue Onyx)"
ID=3D"rocky"
ID_LIKE=3D"rhel centos fedora"
VERSION_ID=3D"9.5"
PLATFORM_ID=3D"platform:el9"
PRETTY_NAME=3D"Rocky Linux 9.5 (Blue Onyx)"
ANSI_COLOR=3D"0;32"
LOGO=3D"fedora-logo-icon"
CPE_NAME=3D"cpe:/o:rocky:rocky:9::baseos"
HOME_URL=3D"https://rockylinux.org/"
VENDOR_NAME=3D"RESF"
VENDOR_URL=3D"https://resf.org/"
BUG_REPORT_URL=3D"https://bugs.rockylinux.org/"
SUPPORT_END=3D"2032-05-31"
ROCKY_SUPPORT_PRODUCT=3D"Rocky-Linux-9"
ROCKY_SUPPORT_PRODUCT_VERSION=3D"9.5"
REDHAT_SUPPORT_PRODUCT=3D"Rocky Linux"
REDHAT_SUPPORT_PRODUCT_VERSION=3D"9.5"
Rocky Linux release 9.5 (Blue Onyx)
Rocky Linux release 9.5 (Blue Onyx)
Rocky Linux release 9.5 (Blue Onyx)


Block access -

[root@memverge4 ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.40
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D34.7GiB/s][r=3D142k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D3566: Fri May 23 12:20:18 20=
25
  read: IOPS=3D142k, BW=3D34.7GiB/s (37.2GB/s)(1040GiB/30001msec)
    slat (usec): min=3D3, max=3D1065, avg=3D 6.68, stdev=3D 2.19
    clat (usec): min=3D75, max=3D2712, avg=3D443.75, stdev=3D36.12
     lat (usec): min=3D83, max=3D2835, avg=3D450.43, stdev=3D36.49

File access -

[root@memverge4 ~]# mount /dev/md127 /mnt
[root@memverge4 ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/mnt/testfile --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exit=
all
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.40
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.4GiB/s][r=3D169k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D3666: Fri May 23 12:21:33 20=
25
  read: IOPS=3D172k, BW=3D42.1GiB/s (45.2GB/s)(1263GiB/30001msec)
    slat (usec): min=3D3, max=3D1054, avg=3D 5.46, stdev=3D 1.81
    clat (usec): min=3D118, max=3D2500, avg=3D365.50, stdev=3D28.08
     lat (usec): min=3D121, max=3D2794, avg=3D370.96, stdev=3D28.35

Back to latest 9.5 kernel (5.14.0-503.40.1.el9_5.x86_64)

Block access -

[root@memverge4 ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.40
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D70.8GiB/s][r=3D290k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D6121: Fri May 23 12:35:22 20=
25
  read: IOPS=3D287k, BW=3D70.1GiB/s (75.3GB/s)(2104GiB/30001msec)
    slat (nsec): min=3D1492, max=3D165338, avg=3D3029.64, stdev=3D1544.70
    clat (usec): min=3D71, max=3D1069, avg=3D219.56, stdev=3D21.22
     lat (usec): min=3D74, max=3D1233, avg=3D222.59, stdev=3D21.34

File access -

[root@memverge4 ~]# mount /dev/md127 /mnt
[root@memverge4 ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/mnt/testfile --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exit=
all
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.40
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D73.5GiB/s][r=3D301k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D6200: Fri May 23 12:36:47 20=
25
  read: IOPS=3D301k, BW=3D73.4GiB/s (78.8GB/s)(2201GiB/30001msec)
    slat (nsec): min=3D1443, max=3D291427, avg=3D2951.98, stdev=3D1952.66
    clat (usec): min=3D118, max=3D1449, avg=3D209.84, stdev=3D23.13
     lat (usec): min=3D121, max=3D1562, avg=3D212.79, stdev=3D23.23

Anton

=D1=87=D1=82, 22 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 18:08, Laur=
ence Oberman <loberman@redhat.com>:
>
> On Mon, 2025-05-05 at 13:39 -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 09:21 -0400, Laurence Oberman wrote:
> > > On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > > > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > > > [cc linux-block]
> > > > >
> > > > > [original bug report:
> > > > > https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ=
-QzmZBMmtr1oC=3DfOOgAQ@mail.gmail.com/
> > > > >  ]
> > > > >
> > > > > On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk
> > > > > wrote:
> > > > > > > What's the comparitive performance of an identical read
> > > > > > > profile
> > > > > > > directly on the raw MD raid0 device?
> > > > > >
> > > > > > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> > > > > >
> > > > > > [root@localhost ~]# df -mh /mnt
> > > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > > /dev/md127       35T  1.3T   34T   4% /mnt
> > > > > >
> > > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D=
64 --
> > > > > > exitall
> > > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_bas=
ed
> > > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > > 256KiB,
> > > > > > (T)
> > > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > > fio-3.39-44-g19d9
> > > > > > Starting 1 process
> > > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][e=
ta
> > > > > > 00m:00s]
> > > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May  =
4
> > > > > > 08:22:12
> > > > > > 2025
> > > > > >   read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001mse=
c)
> > > > > >     slat (nsec): min=3D971, max=3D312380, avg=3D1817.92,
> > > > > > stdev=3D1367.75
> > > > > >     clat (usec): min=3D78, max=3D1351, avg=3D174.46, stdev=3D28=
.86
> > > > > >      lat (usec): min=3D80, max=3D1352, avg=3D176.27, stdev=3D28=
.81
> > > > > >
> > > > > > Fedora 42 (6.14.5-300.fc42.x86_64)
> > > > > >
> > > > > > [root@localhost anton]# df -mh /mnt
> > > > > > Filesystem      Size  Used Avail Use% Mounted on
> > > > > > /dev/md127       35T  1.3T   34T   4% /mnt
> > > > > >
> > > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D=
64 --
> > > > > > exitall
> > > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_bas=
ed
> > > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > > 256KiB,
> > > > > > (T)
> > > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > > fio-3.39-44-g19d9
> > > > > > Starting 1 process
> > > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][e=
ta
> > > > > > 00m:00s]
> > > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May  4
> > > > > > 10:14:00
> > > > > > 2025
> > > > > >   read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001mse=
c)
> > > > > >     slat (usec): min=3D3, max=3D273, avg=3D 5.63, stdev=3D 1.48
> > > > > >     clat (usec): min=3D67, max=3D2800, avg=3D374.99, stdev=3D29=
.90
> > > > > >      lat (usec): min=3D72, max=3D2914, avg=3D380.62, stdev=3D30=
.22
> > > > >
> > > > > So the MD block device shows the same read performance as the
> > > > > filesystem on top of it. That means this is a regression at the
> > > > > MD
> > > > > device layer or in the block/driver layers below it. i.e. it is
> > > > > not
> > > > > an XFS of filesystem issue at all.
> > > > >
> > > > > -Dave.
> > > >
> > > > I have a lab setup, let me see if I can also reproduce and then
> > > > trace
> > > > this to see where it is spending the time
> > > >
> > >
> > >
> > > Not seeing 1/2 the bandwidth but also significantly slower on
> > > Fedora42
> > > kernel.
> > > I will trace it
> > >
> > > 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> > >
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
> > > 15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec
> > >
> > > Fedora42 kernel - 6.14.5-300.fc42.x86_64
> > >
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
> > > 11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec
> > >
> > >
> > >
> > >
> >
> > Fedora42 kernel issue
> >
> > While my difference is not as severe we do see a consistently lower
> > performance on the Fedora
> > kernel. (6.14.5-300.fc42.x86_64)
> >
> > When I remove the software raid and run against a single NVME we
> > converge to be much closer.
> > Also latest upstream does not show this regression either.
> >
> > Not sure yet what is in our Fedora kernel causing this.
> > We will work it via the Bugzilla
> >
> > Regards
> > Laurence
> >
> > TLDR
> >
> >
> > Fedora Kernel
> > -------------
> > root@penguin9 blktracefedora]# uname -a
> > Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> > May
> > 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > 5 runs of the fio against /dev/md1
> >
> > [root@penguin9 ~]# for i in 1 2 3 4 5
> > > do
> > > ./run_fio.sh | grep -A1 "Run status group"
> > > done
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.3GiB/s (12.2GB/s), 11.3GiB/s-11.3GiB/s (12.2GB/s-
> > 12.2GB/s), io=3D679GiB (729GB), run=3D60001-60001msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.2GiB/s (12.0GB/s), 11.2GiB/s-11.2GiB/s (12.0GB/s-
> > 12.0GB/s), io=3D669GiB (718GB), run=3D60001-60001msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.4GiB/s (12.2GB/s), 11.4GiB/s-11.4GiB/s (12.2GB/s-
> > 12.2GB/s), io=3D682GiB (733GB), run=3D60001-60001msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.1GiB/s (11.9GB/s), 11.1GiB/s-11.1GiB/s (11.9GB/s-
> > 11.9GB/s), io=3D664GiB (713GB), run=3D60001-60001msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.3GiB/s (12.1GB/s), 11.3GiB/s-11.3GiB/s (12.1GB/s-
> > 12.1GB/s), io=3D678GiB (728GB), run=3D60001-60001msec
> >
> > RHEL9.5
> > ------------
> > Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> > Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> > "Run
> > status group"; done
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB/s-
> > 16.0GB/s), io=3D894GiB (960GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.6GiB/s (15.6GB/s), 14.6GiB/s-14.6GiB/s (15.6GB/s-
> > 15.6GB/s), io=3D873GiB (938GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB/s-
> > 16.0GB/s), io=3D892GiB (958GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB/s-
> > 15.6GB/s), io=3D872GiB (936GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
> > 15.8GB/s), io=3D884GiB (950GB), run=3D60003-60003msec
> >
> >
> > Remove software raid from the layers and test just on a single nvme
> > ---------------------------------------------------------------------
> > -
> >
> > fio --name=3Dtest --rw=3Dread --bs=3D256k --filename=3D/dev/nvme23n1 --
> > direct=3D1
> > --numjobs=3D1 --iodepth=3D64 --exitall --group_reporting --
> > ioengine=3Dlibaio
> > --runtime=3D60 --time_based
> >
> > Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> > Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > [root@penguin9 ~]# ./run_nvme_fio.sh
> >
> > Run status group 0 (all jobs):
> >    READ: bw=3D3207MiB/s (3363MB/s), 3207MiB/s-3207MiB/s (3363MB/s-
> > 3363MB/s), io=3D188GiB (202GB), run=3D60005-60005msec
> >
> >
> > Back to fedora kernel
> >
> > [root@penguin9 ~]# uname -a
> > Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> > May
> > 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > Within the margin of error
> >
> > Run status group 0 (all jobs):
> >    READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB/s-
> > 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
> >
> >
> > Try recent upstream kernel
> > ---------------------------
> > [root@penguin9 ~]# uname -a
> > Linux penguin9.2 6.13.0-rc7+ #2 SMP PREEMPT_DYNAMIC Mon May  5
> > 10:59:12
> > EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> > "Run
> > status group"; done
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.6GiB/s (15.7GB/s), 14.6GiB/s-14.6GiB/s (15.7GB/s-
> > 15.7GB/s), io=3D876GiB (941GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB/s-
> > 15.9GB/s), io=3D891GiB (957GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB/s-
> > 15.9GB/s), io=3D890GiB (956GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB/s-
> > 15.6GB/s), io=3D871GiB (935GB), run=3D60003-60003msec
> >
> >
> > Update to latest upstream
> > -------------------------
> >
> > [root@penguin9 ~]# uname -a
> > Linux penguin9.2 6.15.0-rc5 #1 SMP PREEMPT_DYNAMIC Mon May  5
> > 12:18:22
> > EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > Single nvme device is once again fine
> >
> > Run status group 0 (all jobs):
> >    READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB/s-
> > 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
> >
> >
> > [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> > "Run
> > status group"; done
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.7GiB/s (15.7GB/s), 14.7GiB/s-14.7GiB/s (15.7GB/s-
> > 15.7GB/s), io=3D880GiB (945GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D18.1GiB/s (19.4GB/s), 18.1GiB/s-18.1GiB/s (19.4GB/s-
> > 19.4GB/s), io=3D1087GiB (1167GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D18.0GiB/s (19.4GB/s), 18.0GiB/s-18.0GiB/s (19.4GB/s-
> > 19.4GB/s), io=3D1082GiB (1162GB), run=3D60003-60003msec
> > Run status group 0 (all jobs):
> >    READ: bw=3D18.2GiB/s (19.5GB/s), 18.2GiB/s-18.2GiB/s (19.5GB/s-
> > 19.5GB/s), io=3D1090GiB (1170GB), run=3D60005-60005msec
> >
> >
>
> This fell of my radar, I aologize and I was on PTO last week.
> Here is the Fedora kernel to install as mentioned
> https://people.redhat.com/loberman/customer/.fedora/
>
> tar hxvf fedora_kernel.tar.xz
> rpm -ivh --force --nodeps *.rpm
>

