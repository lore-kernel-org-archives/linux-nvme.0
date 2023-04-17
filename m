Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BAC77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkodB1zytRbF9QO4BRTAJCPNWh+4ypd4er+H1ch/Q3M=; b=vAqnF3+f7TpFVR+eumukAKyNrF
	qa2tGKw2lU+5eeOf89tY/6MVBdWWr9O7hjTXqedCJQHHnxHVd3CgMBlBa4+1Gx/Hc+i8iP0ChG9nH
	nr584gl9rSzqtWLl8ybEXCCENA+Ndq64iIzaj/Cn5syLyLVoxaylS1iDY+y6BbaWqUjM0P7MXbEqG
	F31igreptRhxYnpv3BLNCO4F0ucdhl43AniGq1axb0gpcuGeLx8frq6WKxzgqhbcxI8dmYLf++rEu
	qFJ143OiL5dAbogoFF08W7fGCn6vZuchUpL9LPHGwN2jY7nrwyHps7wnEgki04dUu5VccW8979ACV
	3e6p6gUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poKGN-00FNv2-2J;
	Mon, 17 Apr 2023 08:31:03 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poKGJ-00FNuP-3B
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 08:31:02 +0000
Received: by mail-ej1-x629.google.com with SMTP id q23so52510809ejz.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681720257; x=1684312257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkodB1zytRbF9QO4BRTAJCPNWh+4ypd4er+H1ch/Q3M=;
        b=WyCh4fYtMhPaR/jEQQ6tftR0L3u7oCUoCLqfg9k2zw7MPjwkIPOSNIirzxwgz8UtEP
         lC7QrG9rd1R00+KNtCPrJTN/7rIK63Pp3kS5MjWD263DXc8pLaUkpVyDXmuGXSvOqrbi
         zm1B/QtdUoMh11C0u0YxKKmhESDCEVVQQQ+E46m1VSCTrxVXtSxThIakAj6iA4krkpLK
         Okb8b/VZeEeNqj43S5Sx8Pqxrop/ESf4gKUd0857yLKl9D7cAbxNB3V3q9E2+odj6Wow
         nKJ6A1s9TbqOuRsn6c8koqP/BuWNwHXeTKDw8Aj8ykX9EaFCtWHpbpUCMLiX8Lotk7gO
         X/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720257; x=1684312257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkodB1zytRbF9QO4BRTAJCPNWh+4ypd4er+H1ch/Q3M=;
        b=DO9FM5XlPVALV9skEjfWkoDW+ZvKYQ3IGyXgVMXeBa0P8/EyOhRgHil5wY7N32XFt1
         HpHv1AVcba2d3YVQcX5mL8cvkoOHyKLGtFaQYD+TQjzi+7aZcLFcnk1qqCoWl9NKtNDb
         u4+ZsYJV4LBS91grYtw6hsEEaJNt6UNvW9P6iI1Tc8epR42WLFfRrSWLuRtpuXLSrTJj
         rqUVttmOLchfUj2RwyVJOv13P/yGLux/5WMuzd5nhqJF7BCWKp/+500GIi9yKzByJfbW
         zvZb6W6vdmRtP+NZnQi4JJMTfu4cWpGMlpPjUcBB84hiCaYwGebdUK7JWPbb6GbBruFT
         0gJw==
X-Gm-Message-State: AAQBX9dweym5O2YyrPfgVxWcEhWTR7eKuxfXjcdAwnB4+CdAOCyQJe3Q
	nSXSieh8NtXHJwqF1A/ODrNf0cWn3Zk+i//2Qh4gPg==
X-Google-Smtp-Source: AKy350bCf6ZF8olTVDhfwgFxjs9OPM8GrtQrZFdUBDhMBuWGai9bQ7jB7gRoqGxdxZucjbhDvyWUqmLaQUOXg4HoQic=
X-Received: by 2002:a17:906:470d:b0:94e:ec32:ba28 with SMTP id
 y13-20020a170906470d00b0094eec32ba28mr6834528ejq.29.1681720256664; Mon, 17
 Apr 2023 01:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de> <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
 <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com> <c9b07e76-9953-b34f-dac0-4a9762b4ac34@suse.de>
In-Reply-To: <c9b07e76-9953-b34f-dac0-4a9762b4ac34@suse.de>
From: Li Feng <fengli@smartx.com>
Date: Mon, 17 Apr 2023 16:32:56 +0800
Message-ID: <CAHckoCz2ZTiSB6WQ8t5m6A9z6zC3BHid12_QFoPe5VGeq5Wwgw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu affinity
To: Hannes Reinecke <hare@suse.de>
Cc: David Laight <David.Laight@aculab.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"lifeng1519@gmail.com" <lifeng1519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_013100_023091_DD072175 
X-CRM114-Status: GOOD (  38.56  )
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

On Mon, Apr 17, 2023 at 2:27=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/15/23 23:06, David Laight wrote:
> > From: Li Feng
> >> Sent: 14 April 2023 10:35
> >>>
> >>> On 4/13/23 15:29, Li Feng wrote:
> >>>> The default worker affinity policy is using all online cpus, e.g. fr=
om 0
> >>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tc=
p will
> >>>> have a bad performance.
> >>>>
> >>>> This patch adds a module parameter to set the cpu affinity for the n=
vme-tcp
> >>>> socket worker threads.  The parameter is a comma separated list of C=
PU
> >>>> numbers.  The list is parsed and the resulting cpumask is used to se=
t the
> >>>> affinity of the socket worker threads.  If the list is empty or the
> >>>> parsing fails, the default affinity is used.
> >>>>
> > ...
> >>> I am not in favour of this.
> >>> NVMe-over-Fabrics has _virtual_ queues, which really have no
> >>> relationship to the underlying hardware.
> >>> So trying to be clever here by tacking queues to CPUs sort of works i=
f
> >>> you have one subsystem to talk to, but if you have several where each
> >>> exposes a _different_ number of queues you end up with a quite
> >>> suboptimal setting (ie you rely on the resulting cpu sets to overlap,
> >>> but there is no guarantee that they do).
> >>
> >> Thanks for your comment.
> >> The current io-queues/cpu map method is not optimal.
> >> It is stupid, and just starts from 0 to the last CPU, which is not con=
figurable.
> >
> > Module parameters suck, and passing the buck to the user
> > when you can't decide how to do something isn't a good idea either.
> >
> > If the system is busy pinning threads to cpus is very hard to
> > get right.
> >
> > It can be better to set the threads to run at the lowest RT
> > priority - so they have priority over all 'normal' threads
> > and also have a very sticky (but not fixed) cpu affinity so
> > that all such threads tends to get spread out by the scheduler.
> > This all works best if the number of RT threads isn't greater
> > than the number of physical cpu.
> >
> And the problem is that you cannot give an 'optimal' performance metric
> here. With NVMe-over-Fabrics the number of queues is negotiated during
> the initial 'connect' call, and the resulting number of queues strongly
> depends on target preferences (eg a NetApp array will expose only 4
> queues, with Dell/EMC you end up with up max 128 queues).
> And these queues need to be mapped on the underlying hardware, which has
> its own issues wrt to NUMA affinity.
>
> To give you an example:
> Given a setup with a 4 node NUMA machine, one NIC connected to
> one NUMA core, each socket having 24 threads, the NIC exposing up to 32
> interrupts, and connections to a NetApp _and_ a EMC, how exactly should
> the 'best' layout look like?
> And, what _is_ the 'best' layout?
> You cannot satisfy the queue requirements from NetApp _and_ EMC, as you
> only have one NIC, and you cannot change the interrupt affinity for each
> I/O.
>
Not all users have so many NIC cards that they can have one NIC per NUMA no=
de.
This scenario is quite common that only has one NIC.

There doesn=E2=80=99t exist a =E2=80=98best' layout for all cases,
So add this parameter to let users select what they want.

> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>

