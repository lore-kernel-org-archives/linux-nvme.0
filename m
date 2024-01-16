Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FDAC47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1CvrrNcIkgS+m/4ZjQFdMQQSZGMBxfOVQFgXMc67Lo=; b=XLEQiEm/JW2R6z4OXI3/LQKOqz
	VpOU38Fx0jqm/1K7ae3mySSEtUeOYrUUNyzzTdY2Fe3xAhXWfSWFHjOZaqYD7NKYUX8/KkfXzo2lI
	Dj91o3W9wdPUMywy1QocWVYfBkfO3gV7/aNJ3k5/AcOIF/EiO99lKb3BlCmDInWkL+skiSNzYhCP5
	6TH1KT1myqtOdvNYwmiKda508BBjTr7WzZVzW8WrKTo70uVtmdbZe1S/Kf8h1QZ+YB+Jh95XQSIjP
	e2+QXX9GVr/hHRfvDIt+/SzePW8gB3NOHERa6Xba7HrbouIF761PgxBxcoM4cz/RxKPTsUEBJbroI
	gkQSjw8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeyl-00BRdD-2X;
	Tue, 16 Jan 2024 08:39:27 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeyh-00BRbx-2j
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 08:39:26 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so5799241fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705394359; x=1705999159; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1CvrrNcIkgS+m/4ZjQFdMQQSZGMBxfOVQFgXMc67Lo=;
        b=lP3izGBVuum500nAUqCuWsSOvfqOWy6QcVVLxwmZs0R7tsaR6RSJbUF3MA3RMbBXQc
         blBShHoTCyhb8kC525GkosoTqFqghctGeg9ze0bfFNW8/px40YbQJ/dOdkRc8EUxt8/d
         I+KK4GGefPJjIR72fvV+w4/2TiaILgKeiSTDXibt8MsPnq2Cvk79xtPhWuYDPNUZG/jR
         HGdIXGKMGDVsJ6T3HDi5RxDcAtd3Fs/oaGlZQ+Fmx/WKUB3hN+E2G1gBhovUrWKibyJI
         jVJUzliVdmKGE5PcN2P2BweIHIaeqzn76WgWG2pgmbOq+n9t4dlvDqAy6yb3FAujjOaJ
         et3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705394359; x=1705999159;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1CvrrNcIkgS+m/4ZjQFdMQQSZGMBxfOVQFgXMc67Lo=;
        b=eycUnCVezXCPTPPd2hykj6UFosz6W2eIbUCrfsd/SfgM77ugPkPs8vK59Jzs6oTXUq
         zo63QCqd5ESRstcIwDWvxCkf5GcqKhwuYg5yBB/BGr9PYjXoeYdDsGNicZbNHOLcySIQ
         iMpSpiUE8OyKevE6HzxsemjLRfOqebjhJmIJTNoKK79mLOR7jeTzJQ7yNxUpPUs64zZr
         HXSebjqFsO0OplWFEb0gA2D2R0Sqm1Jyfhl52wfc0eceOrhDMNoh6oUffoChBRPUxvvZ
         UyxoOmOE2Wk+qdF4DG2XE9orpCnBi1wJiqXamMV1wfhvDEFcXhBC+RGpNIwszkE/o4lb
         pY/A==
X-Gm-Message-State: AOJu0YyNOsIbgRgeU8L30Dgf1wjmjvCFLAvGQm+XdS1Qb54ulWnmvpGq
	nosyKrjBlfLPZwIY+UWevGSYKd72Zs62lA==
X-Google-Smtp-Source: AGHT+IHzpBPMFejAuhe5xiepHjjQFUz2ftX3lyYNgoaOeP7qb8f9VKs4w9CNnTQlg+H0ndEF+6okqQ==
X-Received: by 2002:a2e:b1c7:0:b0:2cc:5546:1ee0 with SMTP id e7-20020a2eb1c7000000b002cc55461ee0mr1298482lja.133.1705394358825;
        Tue, 16 Jan 2024 00:39:18 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:5d31:9b9f:2cc5:3e9c])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9912000000b002cd46eb25f1sm1576357lji.59.2024.01.16.00.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:39:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
Date: Tue, 16 Jan 2024 11:39:16 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 slava@dubeiko.com,
 Kanchan Joshi <joshi.k@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_003924_091647_C81C86AF 
X-CRM114-Status: GOOD (  31.00  )
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



> On Jan 15, 2024, at 8:54 PM, Javier Gonz=C3=A1lez =
<javier.gonz@samsung.com> wrote:
>=20
> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>> Hi Javier,
>>=20
>> Samsung introduced Flexible Data Placement (FDP) technology
>> pretty recently. As far as I know, currently, this technology
>> is available for user-space solutions only. I assume it will be
>> good to have discussion how kernel-space file systems could
>> work with SSDs that support FDP technology by employing
>> FDP benefits.
>=20
> Slava,
>=20
> Thanks for bringing this up.
>=20
> First, this is not a Samsung technology. Several vendors are building
> FDP and several customers are already deploying first product.
>=20
> We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
> block layer until we had a clear idea on use-cases. We have been
> following and reviewing Bart's write hint series and it covers all the
> block layer and interface needed to support FDP. Currently, we have
> patches with small changes to wire the NVMe driver. We plan to submit
> them after Bart's patches are applied. Now it is a good time since we
> have LSF and there are also 2 customers using FDP on block and file.
>=20
>>=20
>> How soon FDP API will be available for kernel-space file systems?
>=20
> The work is done. We will submit as Bart's patches are applied.
>=20
> Kanchan is doing this work.
>=20
>> How kernel-space file systems can adopt FDP technology?
>=20
> It is based on write hints. There is no FS-specific placement =
decisions.
> All the responsibility is in the application.
>=20
> Kanchan: Can you comment a bit more on this?
>=20
>> How FDP technology can improve efficiency and reliability of
>> kernel-space file system?
>=20
> This is an open problem. Our experience is that making data placement
> decisions on the FS is tricky (beyond the obvious data / medatadata). =
If
> someone has a good use-case for this, I think it is worth exploring.
> F2FS is a good candidate, but I am not sure FDP is of interest for
> mobile - here ZUFS seems to be the current dominant technology.
>=20

If I understand the FDP technology correctly, I can see the benefits for
file systems. :)

For example, SSDFS is based on segment concept and it has multiple
types of segments (superblock, mapping table, segment bitmap, b-tree
nodes, user data). So, at first, I can use hints to place different =
segment
types into different reclaim units. The first point is clear, I can =
place different
type of data/metadata (with different =E2=80=9Chotness=E2=80=9D) into =
different reclaim units.
Second point could be not so clear. SSDFS provides the way to define
the size of erase block. If it=E2=80=99s ZNS SSD, then mkfs tool uses =
the size of zone
that storage device exposes to mkfs tool. However, for the case of =
conventional
SSD, the size of erase block is defined by user. Technically speaking, =
this size
could be smaller or bigger that the real erase block inside of SSD. =
Also, FTL could
use a tricky mapping scheme that could combine LBAs in the way making
FS activity inefficient even by using erase block or segment concept. I =
can see
how FDP can help here. First of all, reclaim unit makes guarantee that =
erase
blocks or segments on file system side will match to erase blocks =
(reclaim units)
on SSD side. Also, I can use various sizes of logical erase blocks but =
the logical
erase blocks of the same segment type will be placed into the same =
reclaim unit.
It could guarantee the decreasing the write amplification and =
predictable reclaiming on
SSD side. The flexibility to use various logical erase block sizes =
provides
the better efficiency of file system because various workloads could =
require
different logical erase block sizes.

Technically speaking, any file system can place different types of =
metadata in
different reclaim units. However, user data is slightly more tricky =
case. Potentially,
file system logic can track =E2=80=9Chotness=E2=80=9D or frequency of =
updates of some user data
and try to direct the different types of user data in different reclaim =
units.
But, from another point of view, we have folders in file system =
namespace.
If application can place different types of data in different folders, =
then, technically
speaking, file system logic can place the content of different folders =
into different
reclaim units. But application needs to follow some =E2=80=9Cdiscipline=E2=
=80=9D to store different
types of user data (different =E2=80=9Chotness=E2=80=9D, for example) in =
different folders.

Thanks,
Slava.


