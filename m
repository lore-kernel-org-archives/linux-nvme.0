Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DCC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5cIxifLxpzCeD2CSk8rVMToQM4uWduk0d+Z1uu1DHY=; b=zy7jILyrI8WbX9tOivGsYjeIM8
	uL+xnT5etahN4/MyQXPbU2cnqiWxTOHVLsYyxKgoFpbRqW9RPEFV/nCUujQqe5hqDid04m6peir7x
	qj9/9R410bFJ/eFg0nh48U4VDcSylxtvVbOG/NPMWroPL+zpfeEt0mvlv6T/1HTf1xyrZDQqBZFAG
	lspb+K4cR+K1rD+DsZWQ0Cd+ry0ugVsYoAdp7xrvveO1T471qULbRBGAMVdQTCg4QFE36Z++0WhOX
	QeSG7+Nf80OP/lPCsnQGSLGp8bqiPpbNpi/7NhCtj4r5WUsXdBsWrtjFK1ccA9xLphth88vJtXTuq
	N3mGHMDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIKo-0000000C6uu-1gIG;
	Tue, 06 May 2025 13:27:46 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCG5X-0000000Bep4-123t
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 11:03:55 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-e63a159525bso4456235276.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746529430; x=1747134230; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5cIxifLxpzCeD2CSk8rVMToQM4uWduk0d+Z1uu1DHY=;
        b=ksN5BGKRs7E/5N7lPePsqk8hxrObkFz4lfsbb41Y7/HZ8okc37qajM/COjkEk4Gw+n
         MfmCfsJc7UO1njrQzxVfdfm6TeDJWlqQvl9xmGWQNwgjF97esECsMeCuCFj7yHxX1AdE
         zzCH8ciw8yv6kfR+iyfe+QXGheaZFY4MlSN+v7tvOwjK/ZEgxX5kn3sE25BH1/JEKlmW
         KuIz6yHetGNJjQLcUlf4LG4Lffr//QRBoWbJwxoKA6/N52ymCIQZYcAD4QgJbnVyeHpM
         N9op4hX1fMnlE5sPxz7Y5xRnKUKG7FRWRe14SDiZRP25GsCTI/keI3X5/Oq3VS72khrY
         v+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529430; x=1747134230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5cIxifLxpzCeD2CSk8rVMToQM4uWduk0d+Z1uu1DHY=;
        b=f5rio3A3KEBc8x+SD2rn+8OmbkKnSvmNTLOq2awVD3H8b0EUiulKxTLAmUTUnaSg1N
         cfE+A7+5zr3+vuVL4WzYZ5OWYtzUZR5V35J6Ubaj8iJYFxBwyCgXdtGrQNcvRTNutwa+
         RCH7UD0W4q0Xk8mMkmn4tQFZaaRaJIpotTa0tPrksSDJrMOynHMKJzhZPXzlZIUELcJ5
         O6IngKRl/JWHHMhWX4i9lBFLCyKxYrhQMJmmJ5KOaOooKfSffypHGtg8POEk5a/pxIb5
         W/4hWk7rjf9/0tRNwBa9dYcPx3XA5nj2aMR/Sus7MO9GaAOxwIrKXntr5PKwxM3ZDibu
         jICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/ZmRRyIsdFG5ZicnrcKbuhj2e+K44rcNiFWYZLy/zwt0eywAiSNFAL18CAjH6mTTkanQQH+/MTdb@lists.infradead.org
X-Gm-Message-State: AOJu0YzEHS1SQMGsfV90OoO/X69vRvO0KAT7tbKtIkHOI/jtP8GGBfBN
	hmBdkRO+KPWZHHzAbVuBBQCLYR+4sUvA+f/ZSrZcTngY1UmD055AAC2cKZNBsAMbgbejCBX+MlA
	+kBOGmlDaVQWu/rE/3o1OudAQsGnBKLDP
X-Gm-Gg: ASbGncv9i4LZ0cRBD5AZ2ax1/3ef9EEE7m/LyAlVUEgElSr70Q9xvIa4Wqkk9NHNFKt
	LDjS75k5d8ws+UFWd3WNCknXkcRoJb0QbmOFCLGnUOO7mCCdI90io6/zQuq6P7Cm0uqIKFgk5Tv
	hcJkEmX1VcKw3fhrsvVqYmVac=
X-Google-Smtp-Source: AGHT+IFhiv0YQSilHmty/QdAAAo648u/1DptovoPkVdAkzNPeDxQrGICMPfCoCCTzU5HCJjUYoNmiKgRrfx3Dshb/2A=
X-Received: by 2002:a05:6902:1691:b0:e6d:f160:bbdf with SMTP id
 3f1490d57ef6-e75c09a0b84mr3520072276.36.1746529429729; Tue, 06 May 2025
 04:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area> <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area> <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com> <aBlCDTm-grqM4WtY@dread.disaster.area>
In-Reply-To: <aBlCDTm-grqM4WtY@dread.disaster.area>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 6 May 2025 14:03:37 +0300
X-Gm-Features: ATxdqUGRPpTDRcpadhlooEN_bho35-eXg5BG8APuEFdkYs60OQyxKdR4W39zMvw
Message-ID: <CAAiJnjo87CEeFrkHbXtQM-=+K9M8uEpythLthWTwM_-i4HMA_Q@mail.gmail.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
To: Dave Chinner <david@fromorbit.com>
Cc: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_040351_336079_EE44D868 
X-CRM114-Status: GOOD (  21.82  )
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

> So is this MD chunk size related? i.e. what is the chunk size
> the MD device? Is it smaller than the IO size (256kB) or larger?
> Does the regression go away if the chunk size matches the IO size,
> or if the IO size vs chunk size relationship is reversed?

According to the output below, the chunk size is 512K,

[root@localhost anton]# mdadm -D /dev/md127
/dev/md127:
           Version : 1.2
     Creation Time : Thu Apr 17 14:58:23 2025
        Raid Level : raid0
        Array Size : 37505814528 (34.93 TiB 38.41 TB)
      Raid Devices : 12
     Total Devices : 12
       Persistence : Superblock is persistent

       Update Time : Thu Apr 17 14:58:23 2025
             State : clean
    Active Devices : 12
   Working Devices : 12
    Failed Devices : 0
     Spare Devices : 0

            Layout : original
        Chunk Size : 512K

Consistency Policy : none

              Name : localhost.localdomain:127  (local to host
localhost.localdomain)
              UUID : 2fadc96b:f37753af:f3b528a0:067c320d
            Events : 0

    Number   Major   Minor   RaidDevice State
       0     259       15        0      active sync   /dev/nvme7n1
       1     259       27        1      active sync   /dev/nvme0n1
       2     259       10        2      active sync   /dev/nvme1n1
       3     259       28        3      active sync   /dev/nvme2n1
       4     259       13        4      active sync   /dev/nvme8n1
       5     259       22        5      active sync   /dev/nvme5n1
       6     259       26        6      active sync   /dev/nvme3n1
       7     259       16        7      active sync   /dev/nvme4n1
       8     259       24        8      active sync   /dev/nvme9n1
       9     259       14        9      active sync   /dev/nvme10n1
      10     259       25       10      active sync   /dev/nvme11n1
      11     259       12       11      active sync   /dev/nvme12n1
[root@localhost anton]# uname -r
6.14.5-300.fc42.x86_64
[root@localhost anton]# cat /proc/mdstat
Personalities : [raid0]
md127 : active raid0 nvme4n1[7] nvme1n1[2] nvme12n1[11] nvme7n1[0]
nvme9n1[8] nvme11n1[10] nvme2n1[3] nvme8n1[4] nvme0n1[1] nvme5n1[5]
nvme3n1[6] nvme10n1[9]
      37505814528 blocks super 1.2 512k chunks

unused devices: <none>
[root@localhost anton]#

When I/O size is less 512K

[root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D48.1GiB/s][r=3D197k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D14340: Tue May  6 13:59:23 2=
025
  read: IOPS=3D197k, BW=3D48.0GiB/s (51.6GB/s)(1441GiB/30001msec)
    slat (usec): min=3D3, max=3D1041, avg=3D 4.74, stdev=3D 1.48
    clat (usec): min=3D76, max=3D2042, avg=3D320.30, stdev=3D26.82
     lat (usec): min=3D79, max=3D2160, avg=3D325.04, stdev=3D27.08

When I/O size is greater 512K

[root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D1024k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T=
)
1024KiB-1024KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D63.7GiB/s][r=3D65.2k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D14395: Tue May  6 14:00:28 2=
025
  read: IOPS=3D64.6k, BW=3D63.0GiB/s (67.7GB/s)(1891GiB/30001msec)
    slat (usec): min=3D9, max=3D1045, avg=3D15.12, stdev=3D 3.84
    clat (usec): min=3D81, max=3D18494, avg=3D975.87, stdev=3D112.11
     lat (usec): min=3D96, max=3D18758, avg=3D990.99, stdev=3D113.49

But still much worse than with 256k on Rocky 9.5

Anton

=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 01:56, Dave =
Chinner <david@fromorbit.com>:
>
> On Mon, May 05, 2025 at 09:21:19AM -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > > So the MD block device shows the same read performance as the
> > > > filesystem on top of it. That means this is a regression at the MD
> > > > device layer or in the block/driver layers below it. i.e. it is not
> > > > an XFS of filesystem issue at all.
> > > >
> > > > -Dave.
> > >
> > > I have a lab setup, let me see if I can also reproduce and then trace
> > > this to see where it is spending the time
> > >
> >
> >
> > Not seeing 1/2 the bandwidth but also significantly slower on Fedora42
> > kernel.
> > I will trace it
> >
> > 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> >
> > Run status group 0 (all jobs):
> >    READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
> > 15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec
> >
> > Fedora42 kernel - 6.14.5-300.fc42.x86_64
> >
> > Run status group 0 (all jobs):
> >    READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
> > 11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec
>
> So is this MD chunk size related? i.e. what is the chunk size
> the MD device? Is it smaller than the IO size (256kB) or larger?
> Does the regression go away if the chunk size matches the IO size,
> or if the IO size vs chunk size relationship is reversed?
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

