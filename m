Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE35EFD23E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=; b=TqicvDOLFNwEsRLB5StjxFnx1+
	uuH8oJyjWkLyXqJjLEQCRAT0qUTEbRF+REbebKS1MxxeRLZ/6AbxRojCImXyXTlXhniTIYAMcMhGH
	YgF9S7VAUbUiS3jn2eXiQ33UFpuviMwC5TIdkaHB7x04PeGKdDlkAx8n+2Sfx8/okp5brNWDi4yBZ
	zlmJGdYvtXWf2RNS4A82vRxYLJLQEuaVDEAXb9P+3vceFaQFg8lfrh2iV71Maa3zWWJhM40n4mQU7
	wDOBENLJtXJPuR+nRQPy4KXzT2bIfRa2AHYOehgz6986ffb3hQOVsJ8enKIP1BKAKsw0dZ39/atHY
	RabCvwpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBvV-00000003kwo-0ysA;
	Wed, 25 Feb 2026 10:15:29 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBvP-00000003kwA-3Mv6
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 10:15:26 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-389e4330e32so4509331fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 02:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014522; cv=none;
        d=google.com; s=arc-20240605;
        b=UN+rhzAB1syyV+XH2murjH2vNSkHWNCegLpBHlH39vHy2fL371L3dj0gnSnHLYUZ5P
         DIucFW92SdxvicT8M8ITfVmdDav7P8pT1GUsobCNXJ6eE+kAx95/kr/F0aqHCx8KgTal
         6er9Y6Lvc3i3XScC79w9hPSw66SUc3I9/0lYRMDHl1JhzGTaZzq4Dacul75gUHrd74hs
         +282Ij082pdCwvTy71prsn6csVlQK9WRuN30HB932ILLIqN6X74ryKk41MSJwYRCaNc7
         WmNeaAGBqErXwsh64CNkRJ043WqlKtprl515PkKa+jYt/Veoftf41+6UKqRkBtu1ii/n
         et6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        fh=m0Mj6r/QS8+9ygy0l7f3vf8IdKM77um663kmvuDSZqY=;
        b=YYnzhYNjPzgdU3IIBXZb8ovv9q7hPsuhQp3adQp2iH/ehi+IQAz19ITzg6A/e0lvf/
         hdukXJCe6US7FH4qTITEShhiKm+gogja0tvFFXoDfYVd8nCPFWZzaH3WkigMZLtmf1bM
         B6+I+f2OnIE+vnDve0iALKJFdhcaWKY2rHNkC1TJlrwenNcZpBA5LRSsKGozGCPyg4Pl
         ultEp88rIAwllQ1xV+/4pPp5MMg/07r34FusaVGV2KRH3jPMGfbl1Ke7dBH3vj7b0TLk
         lLLpOLqMWdFFY8sBijBjGGkdHoQKeV1mcUUs2aj5HmuUMShVc9aWvOmw9yL6GVwiR7Je
         BFjQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014522; x=1772619322; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=EQrj1tclszRSUaz1FWRbiQTwlrGAg8xoMgqMKiOSYKvY0BOUej0cRV/drJ2OwkL9FF
         CqYIT9dhKKBxsIntNt9lXtv7K7lyq5NGB/AWz6OxGZyJUSBcRg8i1NioP1BsfYcOO++h
         W1FKtPLtKW0zRZvrNpchlPbxLcZyyS6tRlbfUQN4km3YlcZBMNrHCVnUij8EbSotSMUq
         t5quXO2id3lW/+upG0MUrl/KytZm7sLw9zLPUlhMXrMCfwCncbkaDWlYBE4j43VZwGlH
         WRmpaRD6xJftC9hViHZn4/ZsVJYHpHsCctC1Pxb/YsQBpUcU6/nU5Iw8XH9LFt/RUpU3
         Zf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014522; x=1772619322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=lLw7CF4ealDEOz7ixnLUVIML7Ne+ya1YqGLz2zZSTg1EolCeWD7g90npVpad+UylTA
         C34sOoQkz98iNzxLbNLoDsqTVdfrXKtXp2vgjeqlwmT3ry//uNwAqSuDX47KXQWaJ0lA
         q/ak4w8UuP8LbJkaF/BBBsXgkdAeRStfT89Ie6HXiMFf+xxYOnn4GlhT0drK7laeTkMt
         xtuzyKyE2G6vHOyV//5N0qc219RaoibOy7a8SZyieIvOD14Qy/TVyr36ofyo8kK5Uins
         stsKBxwHNVHGpgO334GqmmPK5kvcRodfO6njjHk48e1jg+asnha2R+6I9FjVp93R8fn9
         hzQw==
X-Forwarded-Encrypted: i=1; AJvYcCW+0Ey91nNqlI8Dh2VpREzlhKebDrCGi+SdxqxQcX8JGTpT4E627KXkMDX8ELwxBZw3SIueWffmiBf9@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2trJzJN6GLFvtO42xap19MEs37gEfDFu0eyYDGghqVKtMUj8l
	5fYW3Qfu5Ve8+taXScRr4QowBMxnEPb3fYfuryvuTkz1akAvhCFrJcRgWL6FR2QCb8KMUDgeGJE
	eQXS4qstz1F80j2P7NnniYltkzXSOpDC4xqYKSXOthg==
X-Gm-Gg: ATEYQzwqzClYUmS0oyqks9OpvI4vQR6WiqZtApUhXpopsuDKtxyP36aodnIq9ECr8VT
	hOPN4PJNoPJTjahEJY583k7rr0riqmBok+rKmNtsb4OoFU1KFjKVAbmuMhtRylT93VLRW1WYi30
	HAbcS/mezj8hWkkkx2Nd9UmsFSRef2sbIJIZxgNSDo773JB0kVkXmdHx282QvRO/Xd5pvEv+6+D
	mFo1MGRnKv4Wg34U56UMEMavENDZrYqmCepUT0OeRkOExkqm+/ksCn8yzL/KaTwvohHHmrAWVaZ
	EV8dG2wHKZpNbZeyIeJH1lD7k/4Rn23RIIHDLLKn0yB8Xw1zc/OYz1V99OYlq8fiBB5t
X-Received: by 2002:a05:651c:981:b0:385:9b50:91a8 with SMTP id
 38308e7fff4ca-389a5d4e691mr49137391fa.15.1772014521621; Wed, 25 Feb 2026
 02:15:21 -0800 (PST)
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
In-Reply-To: <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:15:10 +0100
X-Gm-Features: AaiRm526FWUEGWm_hy7H18Kx_R9h0RTFeFOS6FCw0pCWHIRaUmeSA-DegrV6Fgs
Message-ID: <CAJpMwyiys85=WG-EQtsioo3OOiRDToUh1jE18Uj2Be2JdzNXDA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_021525_686262_B227A30D 
X-CRM114-Status: GOOD (  18.86  )
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

On Mon, Feb 23, 2026 at 8:44=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/15/26 10:18 PM, Haris Iqbal wrote:
> >>  From my view, blktests keep on finding kernel bugs. I think it demons=
trates the
> >> value of this community effort, and I'm happy about it. Said that, I f=
ind what
> >> blktests can improve more, of course. Here I share the list of improve=
ment
> >> opportunities from my view point (I already mentioned the first three =
items).
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
>
> This is actually rather trivial to solve I have some pre-made things for
> fstests and that can be adopted for blktests as well:
>
> vng \
>      --user=3Droot -v --name vng-tcmu-runner \
>      -a loglevel=3D3 \
>      --run $KDIR \
>      --cpus=3D8 --memory=3D8G \
>      --exec "~johannes/src/ci/run-fstests.sh" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi0 -drive
> file=3D/dev/sda,format=3Draw,if=3Dnone,id=3Dzbc0 -device
> scsi-block,bus=3Dscsi0.0,drive=3Dzbc0" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi1 -drive
> file=3D/dev/sdb,format=3Draw,if=3Dnone,id=3Dzbc1 -device
> scsi-block,bus=3Dscsi1.0,drive=3Dzbc1"
>
> and run-fstests.sh is:
>
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
>
> DIR=3D"/tmp/"
> MKFS=3D"mkfs.btrfs -f"
> FSTESTS_DIR=3D"/home/johannes/src/fstests"
> HOSTCONF=3D"$FSTESTS_DIR/configs/$(hostname -s)"
> TESTDEV=3D"$(grep TEST_DEV $HOSTCONF | cut -d '=3D' -f 2)"
>
> mkdir -p $DIR/{test,scratch,results}
> $MKFS $TESTDEV
>
> cd $FSTESTS_DIR
> ./check -x raid
>
> I'm not sure it'll make sense to include this into blktests other than
> maybe providing an example in the README.

You're right. It is pretty trivial to run on VMs, but only after
everything is set up.
Adding it to blktests would allow this setup to be done (and run tests
after that) on any system by running just a couple of commands.

>
>
> Byte,
>
>      Johannes
>

