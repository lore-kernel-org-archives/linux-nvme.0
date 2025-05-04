Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ACC3ABB0
	for <linux-nvme@archiver.kernel.org>; Sun,  4 May 2025 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N1NwuG/e4xVsHdGCaYu3EUBwEEpbWOPwWienDO7qyI8=; b=TvMwQeDrhvI/FzTTnIhuSe6ZFh
	4fbKY9dLWwiOTmv5yfg9CJoYpOagx3muSs3AUKcM335jp1XAjlzTyrox7XfWHMB7M1gZhhgnfwgU/
	HbTQutpI7jmPcg0psFk9Wceh8eXSYY2WBphjfdtCZmz/BDzwnF3lk/qmA3Lw9fZwFCCjA1TotLlTp
	KmabAwTD1D/mPjYhN81PZxemoWcIYrwKzEfrg4Rl685DhWSlfANi87nLOqwC9cXeViOg8tZP+KtmP
	UuU+z45RMRgGX5MCY1v6oz9IgnfbsNVoN0qvJvWG570GcSDRjwk1iNBv4524PeRzYjujtHyPu8Hqe
	U8UW6PKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBTgv-00000004xXq-0fWF;
	Sun, 04 May 2025 07:23:13 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBTgs-00000004xXK-1kWN
	for linux-nvme@lists.infradead.org;
	Sun, 04 May 2025 07:23:11 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-7053f85f059so28178717b3.2
        for <linux-nvme@lists.infradead.org>; Sun, 04 May 2025 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746343389; x=1746948189; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1NwuG/e4xVsHdGCaYu3EUBwEEpbWOPwWienDO7qyI8=;
        b=V0qaqnaSCtZ1fXuFwZfeoXY5oEPfjXM9LNhBAjq154vOOd5Hwyh2oXsppKNzT1XR0A
         cL3Z4ey5W1CKV+4BTawegWD1pvJpfTx7tL23+dcMOpxbf2opX6JMjGvtyx8abW9n+SYr
         /Nd5QZYhFxDO13A8u6C91i8dS6MAJcWF3CFVqgiwBAKFacVEat+DBQVrsXbY1RwF8sbf
         HDDEL+349ezBPanXWB866gpUF08lhtD3Pldr4R6FDjVlYSLouHMeseatwEmrffYxA/3a
         nkIa9IAowlSyw+YpRXcMzUMq9+kF22rgK9TrLpNlYxmjaoAosZDc5QpW6engmsumM6mW
         X35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746343389; x=1746948189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1NwuG/e4xVsHdGCaYu3EUBwEEpbWOPwWienDO7qyI8=;
        b=V1Vqr4krXD8pcDL4sCLv51Es5qgJYvw9RJPRd8beJoyvVOvBvuTVkXHeDVOjzND4C+
         RG3/g4+K8P5lkCF0HpvTjN31MQpgzGEv0iE3K69tn/M1+YOnY/7p5606Cb5gRFutIH6n
         szzH8QKhV6OEnAfvOgvR7K4W9KTlu46sKG1QU46M7fbcDF+BqXvohRG9RrzL5rtkYx2i
         ht8+p26ZmOZV6p+E39LCDtvRA2kYr3LZ2KKTp6xOsLrr1HlmTpfWUUJXIVK2JC60OfNe
         44MoytPpwiyYwTFWeKT40fxQDZLUzh7MZrgd36eGgZQvv6cbHnZH6L/6kU4o02oZ7XSn
         dL1w==
X-Gm-Message-State: AOJu0Ywk48cTa1nCP9SC0SRD6QkRT8g0qfnBgAchwmPvIwvH56Ac49T4
	QdqeejmRFWYw3yJveNYkFjDmU7sJTE8Ymt43bMnfZON+QEJnJgw28bLy3ktQlm1ahv6n988ZfuP
	frkNkyPLf2K6hYkXDgABSc5UHQGo=
X-Gm-Gg: ASbGncvZeXLJYhPYMRs0t6CHLGCodLvK65bRetxwcVycm20VlM7oCS0H0FYBzm62DLi
	DiUxc/MYY84esmezdLtSGTwJLZSO9n6Bg+MYpqeSs2AqX5W6/gpZt7x2NEzxzd4QH06+GagesRG
	zO5A3ovRZnnfbgcHoh86tISD4=
X-Google-Smtp-Source: AGHT+IEAwS2M8BjFUUCYCsFeM+hsNE3mh+qrGuGCxsuJvXJpwQsJ1i0nwL10/qyygP5cPmYT3g7jz+LvmQvXIC3EEGs=
X-Received: by 2002:a05:690c:6e0d:b0:708:3dee:d76e with SMTP id
 00721157ae682-708eaf01991mr37566527b3.22.1746343389158; Sun, 04 May 2025
 00:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
In-Reply-To: <aBaVsli2AKbIa4We@dread.disaster.area>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sun, 4 May 2025 10:22:58 +0300
X-Gm-Features: ATxdqUHb2MJMovNmfI4rEyQJRRdEB_WPt7NXFPP2gOUuPbI6O4-CFxmT27fJsGM
Message-ID: <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
To: Dave Chinner <david@fromorbit.com>
Cc: linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_002310_483574_7C74D433 
X-CRM114-Status: GOOD (  14.03  )
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

> What's the comparitive performance of an identical read profile
> directly on the raw MD raid0 device?

Rocky 9.5 (5.14.0-503.40.1.el9_5.x86_64)

[root@localhost ~]# df -mh /mnt
Filesystem      Size  Used Avail Use% Mounted on
/dev/md127       35T  1.3T   34T   4% /mnt

[root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D81.4GiB/s][r=3D334k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D43189: Sun May  4 08:22:12 2=
025
  read: IOPS=3D363k, BW=3D88.5GiB/s (95.1GB/s)(2656GiB/30001msec)
    slat (nsec): min=3D971, max=3D312380, avg=3D1817.92, stdev=3D1367.75
    clat (usec): min=3D78, max=3D1351, avg=3D174.46, stdev=3D28.86
     lat (usec): min=3D80, max=3D1352, avg=3D176.27, stdev=3D28.81

Fedora 42 (6.14.5-300.fc42.x86_64)

[root@localhost anton]# df -mh /mnt
Filesystem      Size  Used Avail Use% Mounted on
/dev/md127       35T  1.3T   34T   4% /mnt

[root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
--filename=3D/dev/md127 --direct=3D1 --numjobs=3D1 --iodepth=3D64 --exitall
--group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T)
256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
fio-3.39-44-g19d9
Starting 1 process
Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D41.0GiB/s][r=3D168k IOPS][eta 00m:00s]
test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5685: Sun May  4 10:14:00 20=
25
  read: IOPS=3D168k, BW=3D41.0GiB/s (44.1GB/s)(1231GiB/30001msec)
    slat (usec): min=3D3, max=3D273, avg=3D 5.63, stdev=3D 1.48
    clat (usec): min=3D67, max=3D2800, avg=3D374.99, stdev=3D29.90
     lat (usec): min=3D72, max=3D2914, avg=3D380.62, stdev=3D30.22


Anton

=D0=B2=D1=81, 4 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 01:16, Dave =
Chinner <david@fromorbit.com>:
>
> On Sun, May 04, 2025 at 12:04:16AM +0300, Anton Gavriliuk wrote:
> > There are 12 Kioxia CM-7 NVMe SSDs configured in mdadm/raid0 and
> > mounted to /mnt.
> >
> > Exactly the same fio command running under Fedora 42
> > (6.14.5-300.fc42.x86_64) and then under Rocky 9.5
> > (5.14.0-503.40.1.el9_5.x86_64) shows twice the performance difference.
> >
> > /mnt/testfile size 1TB
> > server's total dram 192GB
> >
> > Fedora 42
> >
> > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > --filename=3D/mnt/testfile --direct=3D1 --numjobs=3D1 --iodepth=3D64 --=
exitall
> > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T=
)
> > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > fio-3.39-44-g19d9
> > Starting 1 process
> > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D49.6GiB/s][r=3D203k IOPS][eta 00m:0=
0s]
> > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D2465: Sat May  3 17:51:2=
4 2025
> >   read: IOPS=3D203k, BW=3D49.6GiB/s (53.2GB/s)(1487GiB/30001msec)
> >     slat (usec): min=3D3, max=3D1053, avg=3D 4.60, stdev=3D 1.76
> >     clat (usec): min=3D104, max=3D4776, avg=3D310.53, stdev=3D29.49
> >      lat (usec): min=3D110, max=3D4850, avg=3D315.13, stdev=3D29.82
>
> > Rocky 9.5
> >
> > [root@localhost ~]# fio --name=3Dtest --rw=3Dread --bs=3D256k
> > --filename=3D/mnt/testfile --direct=3D1 --numjobs=3D1 --iodepth=3D64 --=
exitall
> > --group_reporting --ioengine=3Dlibaio --runtime=3D30 --time_based
> > test: (g=3D0): rw=3Dread, bs=3D(R) 256KiB-256KiB, (W) 256KiB-256KiB, (T=
)
> > 256KiB-256KiB, ioengine=3Dlibaio, iodepth=3D64
> > fio-3.39-44-g19d9
> > Starting 1 process
> > Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D96.0GiB/s][r=3D393k IOPS][eta 00m:0=
0s]
> > test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15467: Sun May  4 00:00:=
39 2025
> >   read: IOPS=3D390k, BW=3D95.3GiB/s (102GB/s)(2860GiB/30001msec)
> >     slat (nsec): min=3D1111, max=3D183816, avg=3D2117.94, stdev=3D1412.=
34
> >     clat (usec): min=3D81, max=3D1086, avg=3D161.60, stdev=3D19.67
> >      lat (usec): min=3D82, max=3D1240, avg=3D163.72, stdev=3D19.73
> >
>
> Completely latency has doubled on the fc42 kernel. For a read, there
> isn't much in terms of filesystem work to be done on direct IO
> completion, so I'm not sure this is a filesystem issue...
>
> What's the comparitive performance of an identical read profile
> directly on the raw MD raid0 device?
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

