Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37FBCA0EF5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3MyIR3ttdSD8B9YrCDFAOYd2iehyZNQt+gj4P635QH0=; b=huqV+7dzTGiFxyc51yEtNIBnY1
	1pH/zYnOnsXHSnbMEkaq78MHK6SV1ThsayUv8kvETOjhjSbbxIM2oonh3Nrx4QdssgvZ9YK1aNiDG
	sTDFVJ8l4REXWDvdN/3dMt9FuAxVqItj+2/j9qXV7ARwxSC58IQY3r3CkDRkbHy5aHZfMOzUbcT7p
	jp/gTbOQvD4w3+Qtp4echvzxIPnT318vatS7JTPFhamplRElr/ze2Oxlvs+fxn8jHZIiAalEVvdz1
	SPWh/x4EXVAtkyRvuCaFrw2p1NF+TQ6/kn1Evu2A+YEz0zVFgUGrINS18fWf3FZHNJm/eOmKrWs2b
	YDxoobJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQry-0000000BFOR-35Qm;
	Tue, 19 Aug 2025 18:15:38 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoNKx-0000000AkyO-4Be3
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 14:29:21 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-71d71bcab69so39062897b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755613759; x=1756218559; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MyIR3ttdSD8B9YrCDFAOYd2iehyZNQt+gj4P635QH0=;
        b=CUxJpZj0Q6eRfYJhYpQyTu/fNnqXm2VkmDjk/ec4R6gY6n/k6s9LzRBMC7OF42Rfvp
         Ppi17CrTw31L5Lx6J28BqcPcVpOVVazQtEY4VxHzhMx+gMHeT7jiBKqjpUdH+fMGmbJO
         TtZshgrHcv1+PyV2hQPS5fBnP2Yzp8yRbyw8hizeV6josA8qNF0FO0cyoIvmtV/MPCME
         /V+1vfs8VDiL32Bp3CRqPX2dkgRBh19LYYCRi41YHni5KjweCP37upjFFlUPaRoJy2uP
         2kKEE2gsZ6u8VLBJnowGM2Tmyo9kDFS+wCUbwBxIH09CqDyfaquipEINlP6dV4Qf5VYc
         F9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613759; x=1756218559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MyIR3ttdSD8B9YrCDFAOYd2iehyZNQt+gj4P635QH0=;
        b=YmRNmoBcT2e+xlbW0cj8etgHfNvw6ejkhFy1EH8+vr0exiEbbt6cQ6QZp2K7VJigwc
         U73OZJNb7SzC2Use1CwyZXKmZ1hOErZ8SEEhr4DeHeT3bwnlxU4A6fMj32euI4zYFhcw
         Bv+1hbvj2wRX0BTZvMaepWyCslx0+nHf/BTXZLHlENcCDylM+g3damS/sgcuor6kgpjO
         DfUZj6KHRq5YgaPYF9+L1NeaVLe3hsLyZnxg+xXM2gF80nnj7bIr41yta1KwXtUmTGsB
         y6hVfO3ToqXwsGoMs6tDLbXCluoj4c9x0C1jRsrwqEEM7Bv/dxTxzrzmqg0bSecxxyDy
         lebg==
X-Forwarded-Encrypted: i=1; AJvYcCW2zzTf2jXKirou+OjsJGHiYfuqlr2lnwUzhE6q3VqLnfmbmPztvXLxYN/duqPxAErUBx23raulIvC1@lists.infradead.org
X-Gm-Message-State: AOJu0Yyu+HvLb4gIDRYM8durCUoeayZ8Up0Tnx9il4z2qyGT5UBbc6m1
	0ikB2igJVPbGkJNu5MAaLT0+M+Rrioa2rcVhPEj1yo/BugufIKpaQWKb7xscGm7C9mM6WnRYxt3
	dVgM5cTMPb0Iw/ieJ8//67YNN7dZT8+ImOP4m
X-Gm-Gg: ASbGncuUuS48sdxe59GEJWdMKtKp6g1Uq+u8zGkDO59liYuW054acCKwUZBHOs45oSe
	OoptJqeUlsOzRO889tiuo590h6dtcCm/cRm8Ivj0YiZEDkvt+nKDHWPENEbRsA3hPZ8frs0CfaP
	8RXYf2Fu/qhmnLp5k1a/r7EVjaYmi33q1FmSTqxj4zWW6LMEpoGt0Mqly3sJss+9Qbyc9tvl5JL
	SYULV8p
X-Google-Smtp-Source: AGHT+IHotNm61S/ASktf5QJ+HwvAItVm2kqgGm3JkDb7lHg+zy0JBSP6FbxtPJGZg8BNBYbA/xWI79JHUyC3s45QbZY=
X-Received: by 2002:a05:690c:6707:b0:71c:1673:7bc7 with SMTP id
 00721157ae682-71f9d667805mr33509917b3.29.1755613758778; Tue, 19 Aug 2025
 07:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
 <7a48ed7a-bbc6-4847-94bb-8fb08def0ca4@suse.de> <CAHj4cs91w8-PRJUsMJVBqp=WLSgo-OnT7PuovpALQmqX=f4abA@mail.gmail.com>
 <CAHj4cs8oUX6-0nZYpNKNkuR=r9huRERB20GigOOKZzVnc09pGA@mail.gmail.com>
In-Reply-To: <CAHj4cs8oUX6-0nZYpNKNkuR=r9huRERB20GigOOKZzVnc09pGA@mail.gmail.com>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 19 Aug 2025 17:29:07 +0300
X-Gm-Features: Ac12FXw-kXc_lUMKsnNd3jfoCaU3A_UpsBIWFLdMGpWHUYAeWy62jFXxxRd_s3g
Message-ID: <CAAiJnjq4WS=8zzsxTu8XSN7A5MRN-XHGPDnaAoyQUXFAmJRmrA@mail.gmail.com>
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Chris Leech <cleech@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_072920_044067_B58B3567 
X-CRM114-Status: GOOD (  23.50  )
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

Hi Yi Zhang

> Please try to add the uuid in the device field, which should fix your iss=
ue.

On the NVMe/TCP target for the given device (/dev/nvme0n1) nguid and
uuid are exactly the same

[root@memverge4 ~]# cat /sys/class/block/nvme0n1/uuid
01000000-0000-0000-8ce3-8ee3064aa4f2
[root@memverge4 ~]# cat /sys/class/block/nvme0n1/nguid
01000000-0000-0000-8ce3-8ee3064aa4f2

So I added uuid

      "namespaces": [
        {
          "device": {
            "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
            "uuid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
           "nsid": 1
        }
      ],

Yes, this fixed my issue - automatically reconnect namespace after
NVMe/TCP target reboot.

Anton

=D0=B2=D1=82, 19 =D0=B0=D0=B2=D0=B3. 2025=E2=80=AF=D0=B3. =D0=B2 16:43, Yi =
Zhang <yi.zhang@redhat.com>:
>
> Hi Anton
>
> Please try to add the uuid in the device field, which should fix your iss=
ue.
>
> On Tue, Aug 19, 2025 at 6:55=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wr=
ote:
> >
> > Hi Hannes
> >
> > I tried with the upstream kernel v6.17-rc2, and it can still be reprodu=
ced.
> >
> > # dmesg | tail -30
> > [  219.560691] nvme nvme0: Failed reconnect attempt 3/-1
> > [  219.565784] nvme nvme0: Reconnecting in 10 seconds...
> > [  229.795215] nvme nvme0: failed to connect socket: -111
> > [  229.800369] nvme nvme0: Failed reconnect attempt 4/-1
> > [  229.805450] nvme nvme0: Reconnecting in 10 seconds...
> > [  240.034918] nvme nvme0: failed to connect socket: -111
> > [  240.040093] nvme nvme0: Failed reconnect attempt 5/-1
> > [  240.045165] nvme nvme0: Reconnecting in 10 seconds...
> > [  250.274619] nvme nvme0: failed to connect socket: -111
> > [  250.279776] nvme nvme0: Failed reconnect attempt 6/-1
> > [  250.284855] nvme nvme0: Reconnecting in 10 seconds...
> > [  260.514102] nvme nvme0: failed to connect socket: -111
> > [  260.519261] nvme nvme0: Failed reconnect attempt 7/-1
> > [  260.524340] nvme nvme0: Reconnecting in 10 seconds...
> > [  270.754031] nvme nvme0: failed to connect socket: -111
> > [  270.759184] nvme nvme0: Failed reconnect attempt 8/-1
> > [  270.764263] nvme nvme0: Reconnecting in 10 seconds...
> > [  280.993410] nvme nvme0: failed to connect socket: -111
> > [  280.998591] nvme nvme0: Failed reconnect attempt 9/-1
> > [  281.003653] nvme nvme0: Reconnecting in 10 seconds...
> > [  291.249090] nvme nvme0: creating 4 I/O queues.
> > [  291.264959] nvme nvme0: mapped 4/0/0 default/read/poll queues.
> > [  291.271975] nvme nvme0: Successfully reconnected (attempt 10/-1)
> > [  291.273897] nvme nvme0: identifiers changed for nsid 2
> > [  291.283631] block nvme0n1: no available path - failing I/O
> > [  291.289139] block nvme0n1: no available path - failing I/O
> > [  291.294649] block nvme0n1: no available path - failing I/O
> > [  291.300159] block nvme0n1: no available path - failing I/O
> > [  291.305665] block nvme0n1: no available path - failing I/O
> > [  291.311197] block nvme0n1: no available path - failing I/O
> >
> > On Tue, Aug 19, 2025 at 2:11=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> > >
> > > On 8/12/25 17:48, Anton Gavriliuk wrote:
> > > > Hi
> > > >
> > > > There are NVMe/TCP target and initiator servers, both running on
> > > > RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> > > >
> > > > NVMe/TCP target exports single NVMe SSD
> > > >
> > > >        "namespaces": [
> > > >          {
> > > >            "device": {
> > > >              "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
> > > >              "path": "/dev/nvme0n1"
> > > >            },
> > > >            "enable": 1,
> > > >            "nsid": 1
> > > >          }
> > > >        ],
> > > >
> > > > If NVMe/TCP target is not available, initiator tries to reconnect
> > > > every 10 seconds
> > > >
> > > > [ 2586.071048] nvme nvme9: failed to connect socket: -111
> > > > [ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
> > > > [ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
> > > > [ 2596.310921] nvme nvme9: failed to connect socket: -111
> > > > [ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
> > > > [ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
> > > > [ 2606.550772] nvme nvme9: failed to connect socket: -111
> > > > [ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
> > > > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> > > >
> > > > when NVMe/TCP target become available, initiator failed reconnect t=
he namespace
> > > >
> > > > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> > > > [ 2616.793080] nvme nvme9: creating 16 I/O queues.
> > > > [ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
> > > > [ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
> > > > [ 2616.834446] nvme nvme9: identifiers changed for nsid 1
> > > > [ 2616.835618] block nvme9n1: no usable path - requeuing I/O
> > > > [ 2616.856602] block nvme9n1: no available path - failing I/O
> > > > [ 2616.856811] block nvme9n1: no available path - failing I/O
> > > >
> > > > and there is no nvme9n1 namespace in the "nvme list" output.
> > > >
> > > This looks like the missed re-scan issue I found recently.
> > > Should be fixed with
> > > 9546ad1a9bda ("nvme: requeue namespace scan on missed AENs")
> > >
> > > (And you are running RHEL. Please open a bugzilla with RH.)
> > > (And why am I even answering that?)
> > >
> > > Cheers,
> > >
> > > Hannes
> > > --
> > > Dr. Hannes Reinecke                  Kernel Storage Architect
> > > hare@suse.de                                +49 911 74053 688
> > > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> > > HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
> > >
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
>
>
>
> --
> Best Regards,
>   Yi Zhang
>

