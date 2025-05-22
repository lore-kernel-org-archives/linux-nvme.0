Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704DDC54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=; b=QJLJNy/+80MzeLh4+rF8HgfZY8
	FLhWhR7RUK9qFitXBkYC5822tFXukQwn6fp2HRTnVIIlsZaKJ5ktbR5/q05dDP7YvoSEwWKiYzg71
	83KBJgwMnMGG1pLn+aVma5mhfk0OWGRdWzDTWs/pulD4PkMtVPwfCl4Ek0kIDASv34hqNFfBEYfzF
	ePtf/Xn2dNXVQQUC9vdKdI0wkKZKjyREoY9nnmH765lwvJVO1iosPqx9FZY9tc/HRsVTRy98TD7Ns
	9lora5XqdI8dDs96xYMJQ/6XpDNe/ir41StOOxptT7kgvdrmsjuR2B6cbcszUCA7+yX15GlgF7Gjl
	gfCE7wXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI80t-00000001SiF-3DAb;
	Thu, 22 May 2025 15:39:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI7Wb-00000001NlZ-2CqC
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 15:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747926478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=;
	b=GAtNb+kjXpoKlM3U8trmVEvhwOcYnk+wURRW8prw4RFRSIUzvootdlkijFO8sXrszEj1HG
	Gow0LmG588SbWpYLECR2/tQ92OLZY2C1Htm8R7gDCgRT3tU01Y8y7hdyczDfvtGH6WEBVz
	tJ5NKE61B3ZWmhTrtspz3f19HtfK9MQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Ti68V-uGM9eT7KzSuOr3eg-1; Thu, 22 May 2025 11:07:57 -0400
X-MC-Unique: Ti68V-uGM9eT7KzSuOr3eg-1
X-Mimecast-MFC-AGG-ID: Ti68V-uGM9eT7KzSuOr3eg_1747926476
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-707d49f9c3bso108196317b3.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 08:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926476; x=1748531276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeuSDgqVKj63XH/BsGOarDmziKxpR2gx3k140iln9W4=;
        b=tdQn6nr09TGRER5hlHHxWyorzRLf50ZmFYO9jZ/qjwNi0iQC+6CdSVtBIB1qzJ21KG
         GJQkiZYchXdRnhYHfdL+6IVEPrfQZ5PO6FwJeTRBAbWzznLzW0CgsHd0+/tQbDQK60cL
         Myn9r/i/bamYnm+MEjQ+tUuml1roshaJEoGVvRCKv920CDQkenTKKExiOes9CJtwu7Nl
         EwIobij/NaeDnKBN0Ghh4DtoUNh13fu8jBAPaYyC/kbZkgSuR8xeY/nxCDsPCZQNcBxj
         /dN9xb40T3ongxJQVPrwflS0NuC02tKVSseTobT2qZRGbqec0Onat3+ILiOd2sTUG0tO
         Otlw==
X-Gm-Message-State: AOJu0Yy9AeegClqdZgansUVV0sOaFVBt1NqSTbFtzyMaksdDsXX2tQte
	ZEtVyNQNFutUxRkghNQbKhRhwRCsMa2LeXp63vT1PfJ4Ga2j7ZsJK0kQSWwdwJI5ASm/exmZruA
	UQvMjf5VCohZYKLVRpMj374rh/S9E9WiaEijXre9KAOfHW8IJYaZhYnvBtKRNf2WnwZ+I
X-Gm-Gg: ASbGncuJZ9wCyZLVv0+9hJ1jdWefyUUcXxjWdKe7dq0jkVwnNKF35M1s5K0nrEJWuS7
	CS+Ox0srdjEnqW36FCLw4R9QSKPAcSDDkd9jm1pdbu83TM0zLL66BY+w3Z9fD2+s4JBrcIsvDR5
	0dqndG8cPjcBmyrpJ1Ov5JwTnwaGt/nSsjA+JNuJael5w3MuCrtfEQ+HGQ+CbhfMj4jnlhpwdMB
	J88RSRqeiHij3iF9w/PTpLyeV7A58PBIk47L5+2Y4ip3pNNfzRmmQAJ61lVL42C9UrrvPHxhAtR
	QqCJUNDYBgaGVPpyW7KynG0vardn7zcHVhgbYF83AjT8v1fF3xyu0Ot/1hxuGg==
X-Received: by 2002:a05:690c:4c13:b0:70c:a57c:94a3 with SMTP id 00721157ae682-70ca7a070b3mr360606427b3.19.1747926476146;
        Thu, 22 May 2025 08:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEwejxGi9nhRL8K2qREaXlEOIvA5oHyKuV51mEoHSEqpfOw/2WGHKr40KQ8uc0OMSjq9xOjA==
X-Received: by 2002:a05:690c:4c13:b0:70c:a57c:94a3 with SMTP id 00721157ae682-70ca7a070b3mr360605927b3.19.1747926475650;
        Thu, 22 May 2025 08:07:55 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca82f8d40sm30812717b3.18.2025.05.22.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:07:54 -0700 (PDT)
Message-ID: <f08554fccd3d5e2c2ec4849b0a8158d63414e356.camel@redhat.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
From: Laurence Oberman <loberman@redhat.com>
To: Dave Chinner <david@fromorbit.com>, Anton Gavriliuk
 <antosha20xx@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Thu, 22 May 2025 11:07:53 -0400
In-Reply-To: <f01719b1901f9d796837669086d7c1cd14c9922c.camel@redhat.com>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
	 <aBaVsli2AKbIa4We@dread.disaster.area>
	 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
	 <aBfhDQ6lAPmn81j0@dread.disaster.area>
	 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
	 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
	 <f01719b1901f9d796837669086d7c1cd14c9922c.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: 9B735XS4X_gTxFRXHeY6w_l2M5kmo5cEpFo1yHPl_RA_1747926476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_080801_715959_2AA57F20 
X-CRM114-Status: GOOD (  29.11  )
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

On Mon, 2025-05-05 at 13:39 -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 09:21 -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > > [cc linux-block]
> > > >=20
> > > > [original bug report:
> > > > https://lore.kernel.org/linux-xfs/CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-Q=
zmZBMmtr1oC=3DfOOgAQ@mail.gmail.com/
> > > > =C2=A0]
> > > >=20
> > > > On Sun, May 04, 2025 at 10:22:58AM +0300, Anton Gavriliuk
> > > > wrote:
> > > > > > What's the comparitive performance of an identical read
> > > > > > profile
> > > > > > directly on the raw MD raid0 device?
> > > > >=20
> > > > > Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)
> > > > >=20
> > > > > [root@localhost ~]# df -mh /mnt
> > > > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Us=
e% Mounted on
> > > > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=
=A0=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > > > >=20
> > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64=
 --
> > > > > exitall
> > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > 256KiB,
> > > > > (T)
> > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > fio-3.39-44-g19d9
> > > > > Starting 1 process
> > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta
> > > > > 00m:00s]
> > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May=C2=
=A0 4
> > > > > 08:22:12
> > > > > 2025
> > > > > =C2=A0 read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001=
msec)
> > > > > =C2=A0=C2=A0=C2=A0 slat (nsec): min=3D971, max=3D312380, avg=3D18=
17.92,
> > > > > stdev=3D1367.75
> > > > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D78, max=3D1351, avg=3D174.4=
6, stdev=3D28.86
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D80, max=3D1352, avg=3D=
176.27, stdev=3D28.81
> > > > >=20
> > > > > Fedora 42 (6.14.5-300.fc42.x86_64)
> > > > >=20
> > > > > [root@localhost anton]# df -mh /mnt
> > > > > Filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Size=C2=A0 Used Avail Us=
e% Mounted on
> > > > > /dev/md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35T=C2=A0 1.3T=C2=
=A0=C2=A0 34T=C2=A0=C2=A0 4% /mnt
> > > > >=20
> > > > > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > > > > --filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64=
 --
> > > > > exitall
> > > > > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > > > > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-
> > > > > 256KiB,
> > > > > (T)
> > > > > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > > > > fio-3.39-44-g19d9
> > > > > Starting 1 process
> > > > > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta
> > > > > 00m:00s]
> > > > > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May=C2=
=A0 4
> > > > > 10:14:00
> > > > > 2025
> > > > > =C2=A0 read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001=
msec)
> > > > > =C2=A0=C2=A0=C2=A0 slat (usec): min=3D3, max=3D273, avg=3D 5.63, =
stdev=3D 1.48
> > > > > =C2=A0=C2=A0=C2=A0 clat (usec): min=3D67, max=3D2800, avg=3D374.9=
9, stdev=3D29.90
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 lat (usec): min=3D72, max=3D2914, avg=3D=
380.62, stdev=3D30.22
> > > >=20
> > > > So the MD block device shows the same read performance as the
> > > > filesystem on top of it. That means this is a regression at the
> > > > MD
> > > > device layer or in the block/driver layers below it. i.e. it is
> > > > not
> > > > an XFS of filesystem issue at all.
> > > >=20
> > > > -Dave.
> > >=20
> > > I have a lab setup, let me see if I can also reproduce and then
> > > trace
> > > this to see where it is spending the time
> > >=20
> >=20
> >=20
> > Not seeing 1/2 the bandwidth but also significantly slower on
> > Fedora42
> > kernel.
> > I will trace it
> >=20
> > 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> >=20
> > Run status group 0 (all jobs):
> > =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8=
GB/s-
> > 15.8GB/s), io=3D441GiB (473GB), run=3D30003-30003msec
> >=20
> > Fedora42 kernel - 6.14.5-300.fc42.x86_64
> >=20
> > Run status group 0 (all jobs):
> > =C2=A0=C2=A0 READ: bw=3D10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2=
GB/s-
> > 11.2GB/s), io=3D313GiB (336GB), run=3D30001-30001msec
> >=20
> >=20
> >=20
> >=20
>=20
> Fedora42 kernel issue
>=20
> While my difference is not as severe we do see a consistently lower
> performance on the Fedora
> kernel. (6.14.5-300.fc42.x86_64)
>=20
> When I remove the software raid and run against a single NVME we
> converge to be much closer.
> Also latest upstream does not show this regression either.
>=20
> Not sure yet what is in our Fedora kernel causing this.=20
> We will work it via the Bugzilla
>=20
> Regards
> Laurence
>=20
> TLDR
>=20
>=20
> Fedora Kernel
> -------------
> root@penguin9 blktracefedora]# uname -a
> Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> May
> 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> 5 runs of the fio against /dev/md1
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5
> > do
> > ./run_fio.sh | grep -A1 "Run status group"
> > done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.3GiB/s (12.2GB/s), 11.3GiB/s-11.3GiB/s (12.2GB=
/s-
> 12.2GB/s), io=3D679GiB (729GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.2GiB/s (12.0GB/s), 11.2GiB/s-11.2GiB/s (12.0GB=
/s-
> 12.0GB/s), io=3D669GiB (718GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.4GiB/s (12.2GB/s), 11.4GiB/s-11.4GiB/s (12.2GB=
/s-
> 12.2GB/s), io=3D682GiB (733GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.1GiB/s (11.9GB/s), 11.1GiB/s-11.1GiB/s (11.9GB=
/s-
> 11.9GB/s), io=3D664GiB (713GB), run=3D60001-60001msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D11.3GiB/s (12.1GB/s), 11.3GiB/s-11.3GiB/s (12.1GB=
/s-
> 12.1GB/s), io=3D678GiB (728GB), run=3D60001-60001msec
>=20
> RHEL9.5
> ------------
> Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB=
/s-
> 16.0GB/s), io=3D894GiB (960GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.6GiB/s (15.6GB/s), 14.6GiB/s-14.6GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D873GiB (938GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.9GiB/s (16.0GB/s), 14.9GiB/s-14.9GiB/s (16.0GB=
/s-
> 16.0GB/s), io=3D892GiB (958GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D872GiB (936GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB=
/s-
> 15.8GB/s), io=3D884GiB (950GB), run=3D60003-60003msec
>=20
>=20
> Remove software raid from the layers and test just on a single nvme
> ---------------------------------------------------------------------
> -
>=20
> fio --name=3Dtest --rw=3Dread --bs=3D256k --filename=3D/dev/nvme23n1 --
> direct=3D1
> --numjobs=3D1 --iodepth=3D64 --exitall --group_reporting --
> ioengine=3Dlibaio
> --runtime=3D60 --time_based
>=20
> Linux penguin9.2 5.14.0-503.40.1.el9_5.x86_64 #1 SMP PREEMPT_DYNAMIC
> Thu Apr 24 08:27:29 EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# ./run_nvme_fio.sh
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3207MiB/s (3363MB/s), 3207MiB/s-3207MiB/s (3363MB=
/s-
> 3363MB/s), io=3D188GiB (202GB), run=3D60005-60005msec
>=20
>=20
> Back to fedora kernel
>=20
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.14.5-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri
> May
> 2 14:16:46 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Within the margin of error
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB=
/s-
> 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
>=20
>=20
> Try recent upstream kernel
> ---------------------------
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.13.0-rc7+ #2 SMP PREEMPT_DYNAMIC Mon May=C2=A0 5
> 10:59:12
> EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.6GiB/s (15.7GB/s), 14.6GiB/s-14.6GiB/s (15.7GB=
/s-
> 15.7GB/s), io=3D876GiB (941GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB=
/s-
> 15.9GB/s), io=3D891GiB (957GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB=
/s-
> 15.9GB/s), io=3D890GiB (956GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.5GiB/s (15.6GB/s), 14.5GiB/s-14.5GiB/s (15.6GB=
/s-
> 15.6GB/s), io=3D871GiB (935GB), run=3D60003-60003msec
>=20
>=20
> Update to latest upstream
> -------------------------
>=20
> [root@penguin9 ~]# uname -a
> Linux penguin9.2 6.15.0-rc5 #1 SMP PREEMPT_DYNAMIC Mon May=C2=A0 5
> 12:18:22
> EDT 2025 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Single nvme device is once again fine
>=20
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D3061MiB/s (3210MB/s), 3061MiB/s-3061MiB/s (3210MB=
/s-
> 3210MB/s), io=3D179GiB (193GB), run=3D60006-60006msec
>=20
>=20
> [root@penguin9 ~]# for i in 1 2 3 4 5; do ./run_fio.sh | grep -A1
> "Run
> status group"; done
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D14.7GiB/s (15.7GB/s), 14.7GiB/s-14.7GiB/s (15.7GB=
/s-
> 15.7GB/s), io=3D880GiB (945GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.1GiB/s (19.4GB/s), 18.1GiB/s-18.1GiB/s (19.4GB=
/s-
> 19.4GB/s), io=3D1087GiB (1167GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.0GiB/s (19.4GB/s), 18.0GiB/s-18.0GiB/s (19.4GB=
/s-
> 19.4GB/s), io=3D1082GiB (1162GB), run=3D60003-60003msec
> Run status group 0 (all jobs):
> =C2=A0=C2=A0 READ: bw=3D18.2GiB/s (19.5GB/s), 18.2GiB/s-18.2GiB/s (19.5GB=
/s-
> 19.5GB/s), io=3D1090GiB (1170GB), run=3D60005-60005msec
>=20
>=20

This fell of my radar, I aologize and I was on PTO last week.
Here is the Fedora kernel to install as mentioned
https://people.redhat.com/loberman/customer/.fedora/

tar hxvf fedora_kernel.tar.xz
rpm -ivh --force --nodeps *.rpm


